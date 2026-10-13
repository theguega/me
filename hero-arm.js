const canvas = document.getElementById("robotCanvas");
const ctx = canvas.getContext("2d");
ctx.imageSmoothingEnabled = false;

// screen position of the base, and world-to-screen projection below
const OX = 56,
    OY = 108;
const H0 = 10;
const L1 = 34,
    L2 = 30;
const HOVER_Z = 26,
    GRASP_Z = 4; // block center on the table
const WRIST_GRASP_Z = GRASP_Z + 5; // wrist height that puts the block between the fingers
const BLOCK_PX = 8;

// frames the predicted arm leads the target by
const LOOKAHEAD = 14;
// share of the remaining distance the real arm covers per frame
const FOLLOW_RATE = 0.12;
const TRAIL_LEN = 24;
const PLOT = { x: 88, y: 18, size: 34 };

const SRC = { red: { x: 46, y: 8 }, blue: { x: 40, y: 32 } };
const BIN = { red: { x: -22, y: 20 }, blue: { x: -6, y: 40 } };
const HOME = { x: -6, y: 0, z: HOVER_Z };

const C_BG = "#eff1f5",
    C_GRID = "#e6e9ef";
const C_ARM = "#7c7f93",
    C_ARM_HL = "#9ca0b0",
    C_ARM_SH = "#5c5f77";
const C_JOINT = "#acb0be",
    C_JOINT_DOT = "#8c8fa1";
const C_BASE_1 = "#6c6f85",
    C_BASE_2 = "#4c4f69";
const C_FLOOR = "#dce0e8",
    C_FLOOR_EDGE = "#acb0be";
const C_BLOCK = {
    red: ["#d20f39", "#e64553", "#a50d2e"],
    blue: ["#1e66f5", "#7287fd", "#209fb5"],
};
const C_GHOST = "#8839ef",
    C_LATENT = "#1e66f5",
    C_GOAL = "#40a02b",
    C_ERR = "#fe640b",
    C_PLOT_BG = "#e6e9ef",
    C_PLOT_EDGE = "#ccd0da";

let time = 0;
const actual = { x: HOME.x, y: HOME.y, z: HOME.z };
const trail = [];

function easeInOutCubic(t) {
    return t < 0.5 ? 4 * t * t * t : 1 - Math.pow(-2 * t + 2, 3) / 2;
}

const mix = (a, b, p) => a + (b - a) * p;
const clamp01 = (v) => Math.min(1, Math.max(0, v));

// the task as a timeline: each segment eases from the previous waypoint to its own
const SEQ = [];
const where = { red: "src", blue: "src" };

function add(p, dur, grip = 1, held = null) {
    SEQ.push({ p, dur, grip, held, where: { ...where } });
}

function pick(name) {
    const { x, y } = SRC[name];
    add({ x, y, z: HOVER_Z }, 50);
    add({ x, y, z: WRIST_GRASP_Z }, 30);
    add({ x, y, z: WRIST_GRASP_Z }, 25, 0, name);
    add({ x, y, z: HOVER_Z }, 25, 0, name);
}

function place(name) {
    const { x, y } = BIN[name];
    add({ x, y, z: HOVER_Z }, 50, 0, name);
    add({ x, y, z: WRIST_GRASP_Z }, 30, 0, name);
    where[name] = "bin";
    add({ x, y, z: WRIST_GRASP_Z }, 25, 1);
    add({ x, y, z: HOVER_Z }, 25, 1);
}

add(HOME, 40);
pick("red");
place("red");
pick("blue");
place("blue");
add(HOME, 50);

const TOTAL = SEQ.reduce((n, s) => n + s.dur, 0);

function sample(frame) {
    let f = frame % TOTAL;
    let i = 0;
    while (f >= SEQ[i].dur) {
        f -= SEQ[i].dur;
        i++;
    }
    const cur = SEQ[i];
    const prev = SEQ[(i + SEQ.length - 1) % SEQ.length];
    const e = easeInOutCubic(f / cur.dur);
    return {
        p: {
            x: mix(prev.p.x, cur.p.x, e),
            y: mix(prev.p.y, cur.p.y, e),
            z: mix(prev.p.z, cur.p.z, e),
        },
        grip: mix(prev.grip, cur.grip, e),
        held: cur.held,
        where: cur.where,
    };
}

// 3 DoF: base yaw, shoulder and elbow pitch, solved in the arm's vertical plane
function armPose(p) {
    const yaw = Math.atan2(p.y, p.x);
    const reach = L1 + L2 - 0.1;
    let r = Math.hypot(p.x, p.y);
    let zz = p.z - H0;
    const d = Math.hypot(r, zz);
    if (d > reach) {
        r *= reach / d;
        zz *= reach / d;
    }
    const dd = Math.min(d, reach);
    const cosT2 = (dd * dd - L1 * L1 - L2 * L2) / (2 * L1 * L2);
    const theta2 = -Math.acos(Math.max(-1, Math.min(1, cosT2)));
    const theta1 =
        Math.atan2(zz, r) -
        Math.atan2(L2 * Math.sin(theta2), L1 + L2 * Math.cos(theta2));

    const world = (rr, zr) => ({
        x: rr * Math.cos(yaw),
        y: rr * Math.sin(yaw),
        z: H0 + zr,
    });
    const elbowR = L1 * Math.cos(theta1);
    const elbowZ = L1 * Math.sin(theta1);
    return {
        s: { x: 0, y: 0, z: H0 },
        e: world(elbowR, elbowZ),
        w: world(
            elbowR + L2 * Math.cos(theta1 + theta2),
            elbowZ + L2 * Math.sin(theta1 + theta2),
        ),
    };
}

function proj(p) {
    return { x: OX + 0.9 * p.x - 0.45 * p.y, y: OY - p.z - 0.3 * p.y };
}

// position in the latent plot: yaw and height of the end effector
function embed(p) {
    const yaw = Math.atan2(p.y, p.x);
    const u = clamp01((yaw - 0.2) / 2.2);
    const v = clamp01(p.z / 36);
    return {
        px: PLOT.x + u * PLOT.size,
        py: PLOT.y + (1 - v) * PLOT.size,
    };
}

function drawSegment(a, b) {
    ctx.lineCap = "round";
    ctx.strokeStyle = C_ARM_SH;
    ctx.lineWidth = 6;
    ctx.beginPath();
    ctx.moveTo(a.x, a.y + 1);
    ctx.lineTo(b.x, b.y + 1);
    ctx.stroke();
    ctx.strokeStyle = C_ARM;
    ctx.lineWidth = 5;
    ctx.beginPath();
    ctx.moveTo(a.x, a.y);
    ctx.lineTo(b.x, b.y);
    ctx.stroke();
    ctx.strokeStyle = C_ARM_HL;
    ctx.lineWidth = 2;
    ctx.beginPath();
    ctx.moveTo(a.x, a.y - 1);
    ctx.lineTo(b.x, b.y - 1);
    ctx.stroke();
}

function drawJoint(s, size) {
    const x = Math.floor(s.x - size / 2),
        y = Math.floor(s.y - size / 2);
    ctx.fillStyle = C_ARM_SH;
    ctx.fillRect(x - 1, y - 1, size + 2, size + 2);
    ctx.fillStyle = C_JOINT;
    ctx.fillRect(x, y, size, size);
    ctx.fillStyle = C_JOINT_DOT;
    ctx.fillRect(Math.floor(s.x) - 1, Math.floor(s.y) - 1, 2, 2);
}

// the predicted arm, drawn under the real one
function drawGhost(pose) {
    const s = proj(pose.s),
        e = proj(pose.e),
        w = proj(pose.w);
    ctx.globalAlpha = 0.4;
    ctx.strokeStyle = C_GHOST;
    ctx.lineWidth = 1;
    ctx.setLineDash([2, 2]);
    ctx.beginPath();
    ctx.moveTo(s.x, s.y);
    ctx.lineTo(e.x, e.y);
    ctx.lineTo(w.x, w.y);
    ctx.stroke();
    ctx.setLineDash([]);
    ctx.fillStyle = C_GHOST;
    ctx.fillRect(Math.floor(w.x) - 1, Math.floor(w.y) - 1, 3, 3);
    ctx.globalAlpha = 1;
}

function drawFootprint(c, color) {
    const corners = [
        [-7, -7],
        [7, -7],
        [7, 7],
        [-7, 7],
    ].map(([dx, dy]) => proj({ x: c.x + dx, y: c.y + dy, z: 0 }));
    ctx.strokeStyle = color;
    ctx.setLineDash([2, 2]);
    ctx.beginPath();
    ctx.moveTo(corners[0].x, corners[0].y);
    corners.slice(1).forEach((k) => ctx.lineTo(k.x, k.y));
    ctx.closePath();
    ctx.stroke();
    ctx.setLineDash([]);
}

function drawBlock(p, name) {
    const s = proj(p);
    const x = Math.round(s.x) - BLOCK_PX / 2,
        y = Math.round(s.y) - BLOCK_PX / 2;
    const [c, hl, sh] = C_BLOCK[name];
    ctx.fillStyle = c;
    ctx.fillRect(x, y, BLOCK_PX, BLOCK_PX);
    ctx.fillStyle = hl;
    ctx.fillRect(x, y, BLOCK_PX, 2);
    ctx.fillRect(x, y, 2, BLOCK_PX);
    ctx.fillStyle = sh;
    ctx.fillRect(x + BLOCK_PX - 2, y, 2, BLOCK_PX);
}

// end-effector and commanded target in a 2D embedding, gap to the prediction as a bar
function drawLatent(actualPt, predPt, goalPt) {
    const { x, y, size } = PLOT;
    ctx.fillStyle = C_PLOT_BG;
    ctx.fillRect(x, y, size, size);
    ctx.strokeStyle = C_PLOT_EDGE;
    ctx.lineWidth = 1;
    ctx.strokeRect(x + 0.5, y + 0.5, size - 1, size - 1);

    trail.push(actualPt);
    if (trail.length > TRAIL_LEN) trail.shift();
    ctx.fillStyle = C_LATENT;
    trail.forEach((p, i) => {
        ctx.globalAlpha = ((i + 1) / trail.length) * 0.6;
        ctx.fillRect(Math.floor(p.px), Math.floor(p.py), 1, 1);
    });
    ctx.globalAlpha = 1;

    ctx.strokeStyle = C_GOAL;
    ctx.strokeRect(Math.floor(goalPt.px) - 2, Math.floor(goalPt.py) - 2, 4, 4);

    ctx.strokeStyle = C_GHOST;
    ctx.strokeRect(Math.floor(predPt.px) - 1, Math.floor(predPt.py) - 1, 3, 3);

    ctx.fillStyle = C_LATENT;
    ctx.fillRect(Math.floor(actualPt.px) - 1, Math.floor(actualPt.py) - 1, 3, 3);

    const gap = Math.hypot(predPt.px - actualPt.px, predPt.py - actualPt.py);
    ctx.fillStyle = C_ERR;
    ctx.fillRect(x, y + size - 2, Math.min(size, gap * 2), 2);
}

function drawBase(grip) {
    const base = proj({ x: 0, y: 0, z: 0 });
    ctx.fillStyle = "rgba(76, 79, 105, 0.1)";
    ctx.fillRect(base.x - 16, base.y + 2, 32, 4);
    ctx.fillStyle = C_BASE_1;
    ctx.beginPath();
    ctx.moveTo(base.x - 14, base.y + 4);
    ctx.lineTo(base.x + 14, base.y + 4);
    ctx.lineTo(base.x + 10, base.y - 4);
    ctx.lineTo(base.x - 10, base.y - 4);
    ctx.fill();
    ctx.fillStyle = C_BASE_2;
    ctx.fillRect(base.x - 8, base.y - 10, 16, 8);
    ctx.fillStyle =
        Math.floor(time / 15) % 2 === 0 || grip === 0 ? "#40a02b" : "#ccd0da";
    ctx.fillRect(base.x - 5, base.y - 8, 2, 2);
}

function drawClaw(w, grip) {
    ctx.save();
    ctx.translate(w.x, w.y);
    ctx.fillStyle = C_BASE_1;
    ctx.fillRect(-3, -3, 6, 6);
    ctx.fillStyle = C_JOINT;
    ctx.fillRect(-1, -1, 2, 2);
    ctx.fillStyle = C_BASE_2;
    ctx.fillRect(-6, 2, 12, 4);

    const openAmt = grip * 4;
    ctx.fillStyle = C_ARM;
    ctx.fillRect(-6 - openAmt, 6, 3, 6);
    ctx.fillStyle = C_ARM_SH;
    ctx.fillRect(-4 - openAmt, 6, 1, 6);
    ctx.fillStyle = C_ARM;
    ctx.fillRect(3 + openAmt, 6, 3, 6);
    ctx.fillStyle = C_ARM_SH;
    ctx.fillRect(3 + openAmt, 6, 1, 6);
    ctx.restore();
}

function drawFrame(t) {
    ctx.fillStyle = C_BG;
    ctx.fillRect(0, 0, 128, 128);
    ctx.strokeStyle = C_GRID;
    ctx.lineWidth = 1;
    for (let i = 0; i < 128; i += 16) {
        ctx.beginPath();
        ctx.moveTo(i, 0);
        ctx.lineTo(i, 128);
        ctx.stroke();
        ctx.beginPath();
        ctx.moveTo(0, i);
        ctx.lineTo(128, i);
        ctx.stroke();
    }
    ctx.fillStyle = C_FLOOR;
    ctx.fillRect(0, 114, 128, 14);

    drawFootprint(SRC.red, C_FLOOR_EDGE);
    drawFootprint(SRC.blue, C_FLOOR_EDGE);
    ctx.globalAlpha = 0.5;
    drawFootprint(BIN.red, C_BLOCK.red[0]);
    drawFootprint(BIN.blue, C_BLOCK.blue[0]);
    ctx.globalAlpha = 1;

    const f = sample(t);
    const ahead = sample(t + LOOKAHEAD);
    actual.x += (f.p.x - actual.x) * FOLLOW_RATE;
    actual.y += (f.p.y - actual.y) * FOLLOW_RATE;
    actual.z += (f.p.z - actual.z) * FOLLOW_RATE;

    const pose = armPose(actual);
    const ghost = armPose(ahead.p);
    drawGhost(ghost);

    // painter's order: parts with larger y are farther, drawn first
    const parts = [];
    for (const name of ["red", "blue"]) {
        if (f.held === name) continue;
        const c = f.where[name] === "src" ? SRC[name] : BIN[name];
        parts.push({
            depth: c.y,
            draw: () => drawBlock({ x: c.x, y: c.y, z: GRASP_Z }, name),
        });
    }
    parts.push({ depth: 0, draw: () => drawBase(f.grip) });
    parts.push({
        depth: (pose.s.y + pose.e.y) / 2,
        draw: () => {
            drawSegment(proj(pose.s), proj(pose.e));
            drawJoint(proj(pose.s), 8);
        },
    });
    parts.push({
        depth: (pose.e.y + pose.w.y) / 2,
        draw: () => {
            drawSegment(proj(pose.e), proj(pose.w));
            drawJoint(proj(pose.e), 6);
        },
    });
    parts.push({ depth: pose.w.y, draw: () => drawClaw(proj(pose.w), f.grip) });
    if (f.held) {
        // held block is drawn last so it reads as in front of the claw body
        parts.push({
            depth: pose.w.y,
            draw: () =>
                drawBlock({ x: pose.w.x, y: pose.w.y, z: pose.w.z - 5 }, f.held),
        });
    }

    parts.sort((a, b) => b.depth - a.depth).forEach((part) => part.draw());

    drawLatent(embed(pose.w), embed(ghost.w), embed(f.p));
}

function animate() {
    time++;
    drawFrame(time);
    requestAnimationFrame(animate);
}
animate();
