#import "@preview/simple-technical-resume:0.1.0": *

#let name = "Theo Guegan"
#let email = "theo.guegan.perso@gmail.com"
#let github = "theguega"
#let linkedin = "guegan-theo"
#let personal-site = "theog.fyi"

#show: resume.with(
  top-margin: 0.3in,
  bottom-margin: 0.2in,
  left-margin: 0.45in,
  right-margin: 0.45in,
  personal-info-font-size: 9pt,
  font-size: 9.5pt,
  author-position: center,
  personal-info-position: center,
  author-name: name,
  email: email,
  website: personal-site,
  linkedin-user-id: linkedin,
  github-username: github,
)

#custom-title("Experience")[
  #work-heading(
    "Founding Engineer, Embodied AI",
    "Opalin (Claire Delaunay, ex-VP NVIDIA Robotics)",
    "Redwood City, CA",
    datetime(year: 2026, month: 2, day: 1),
    "Present",
  )[
    - VLAs and world action models: architectures, training, fine-tuning and evaluation of visuomotor policies over multi-view video and proprioception, run in real time on the robots.
    - End-to-end training loop from data to fleet: new experiments every day, each with evaluation and actionable metrics.
    - Data curation: 3D dataset viewer; per-task statistics (3D workspace and grasp-point coverage, phase durations, smoothness) and robust outlier detection (MAD, MCD, DTW novelty, near-duplicates); half the data, success 50% to 98%.
    - Real-time arm control with Pinocchio IK/FK and impedance control to 0.1 mm over CAN.
  ]

  #work-heading(
    "Embedded AI Software Engineer",
    "Thales Land & Air Systems",
    "Vélizy-Villacoublay, France",
    datetime(year: 2024, month: 9, day: 1),
    datetime(year: 2025, month: 2, day: 1),
  )[
    - Fully decentralized embedded AI for drone swarm coordination and control, removing the need for a permanent datalink to the ground station.
    - Embedded Lua script engine and on-device LLM voice-to-script generation (98% correctness) for rapid mission prototyping (Rust harness, end-to-end deployment).
    - Cut new-mission deployment time by 10x and improved reliability and predictability by 4x.
    - Part of Thales' COHESION demonstrator (JDEC 2024), featured in French media.
  ]

  #work-heading(
    "Research Assistant, Autonomous Vehicle Control Lead",
    "CNRS Hauts-de-France, Heudiasyc Lab",
    "Compiègne, France",
    datetime(year: 2024, month: 2, day: 1),
    datetime(year: 2025, month: 6, day: 1),
  )[
    - Control architecture for a fleet of shared autonomous vehicles in dense urban environments; replaced rigid trajectory planning with waypoint-based navigation.
    - Led sim-to-real deployment of the control stack onto a Renault Zoe (ROS/Python): waypoint control law, adaptive cruise control, obstacle avoidance; 99% safety in simulation.
    - 1st School Award (2024), 1st place Open Category (2025), UTAC Challenge.
  ]

  #work-heading(
    "Business Manager",
    "Junior UTC",
    "Compiègne, France",
    datetime(year: 2023, month: 9, day: 1),
    datetime(year: 2024, month: 9, day: 1),
  )[
    - Led technical projects for clients such as Airbus (over €30,000), coordinating student engineers.
  ]
]

#custom-title("Research")[
  #project-heading(
    "Behavior Cloning of MPC for 3-DOF Robotic Manipulators",
    stack: "arXiv:2606.00383",
    project-url: "https://arxiv.org/abs/2606.00383",
  )[
    - Poster at the Workshop on RL in the Era of Imitation Learning, IEEE ICRA 2026.
    - Distilled an MPC policy into neural surrogates: 3x lower inference latency at 85% success; static architectures outperform temporal ones.
    - Ablation and statistical studies over traditional ML algorithms
  ]
]

#custom-title("Skills")[
  #skills()[
    - *Learning:* JEPA and latent-predictive objectives, multimodal video architectures, VLAs, flow matching, imitation learning, LoRA/PEFT
    - *Scale:* multi-GPU training, efficient inference, data curation pipelines, PyTorch, JAX, Docker, CI/CD
    - *Planning & control:* MPC, Pinocchio IK/FK, RNEA, impedance control, ROS2, dora-rs, RTOS, CAN
    - *Languages & sim:* Python 3.12+, Rust, C++17, C, MATLAB, Bash; MuJoCo, Isaac Sim, Genesis, Gazebo
  ]
]

#custom-title("Education")[
  #education-heading(
    "University of Waterloo",
    "Waterloo, Canada",
    "M.Sc. Artificial Intelligence",
    "AI/ML",
    datetime(year: 2025, month: 9, day: 1),
    datetime(year: 2025, month: 12, day: 1),
  )[
    - GPA 4.0/4.0: Deep Learning (Bryan Tripp), Machine Learning (Terrence C. Stewart), Image Processing.
  ]

  #education-heading(
    "Université de Technologie de Compiègne",
    "Compiègne, France",
    "M.Sc. Computer Engineering",
    "Embedded & Autonomous Systems",
    datetime(year: 2021, month: 9, day: 1),
    datetime(year: 2026, month: 9, day: 1),
  )[
    - GPA 5.0/5.0: Robotics Control, Embedded Systems, Kinematics.
  ]
]

#custom-title("Hackathons")[
  - 2nd prize, Seeed x NVIDIA x Hugging Face Embodied AI Hackathon (Santa Clara, 2026).
  - 2nd prize, Open World Hackathon by VLGE (San Francisco, 2026).
  - Winner, UTC x ST2I Hackathon (France). Also: Mistral AI Worldwide (San Francisco, 2026), SWARM Robotics (Canada).
]

#custom-title("Open Source")[
  - #link("https://github.com/theguega/fathom")[fathom]: zero-overhead Rust visualization of multimodal spatiotemporal data (video, depth, point clouds, trajectories).
  - #link("https://github.com/theguega/drover")[drover]: Rust agent runtime running coding agents in git worktrees, driven from the terminal or Discord.
  - Reachy Mini and SO-ARM-101 manipulation stacks; #link("https://github.com/theguega/peillute")[peillute], distributed P2P payments in Rust; Kaggle Brain-to-Text '25.
]
