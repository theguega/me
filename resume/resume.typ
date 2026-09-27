#import "@preview/simple-technical-resume:0.1.0": *

#let name = "Theo Guegan"
#let email = "theo.guegan.perso@gmail.com"
#let github = "theguega"
#let linkedin = "guegan-theo"
#let personal-site = "theguega.github.io/me/"

#show: resume.with(
  top-margin: 0.4in,
  bottom-margin: 0.25in,
  left-margin: 0.45in,
  right-margin: 0.45in,
  personal-info-font-size: 9pt,
  font-size: 10pt,
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
    "Opalin (Claire Delaunay, ex-NVIDIA Robotics)",
    "Bay Area, CA",
    datetime(year: 2026, month: 2, day: 1),
    "Present",
  )[
    - Trained visuomotor policies with JEPA architectures: latent-predictive encoders over multi-view video and proprioception, distilled into real-time policies running on physical robots.
    - Built variance-targeted data collection and curation, the largest source of model gains: 90 curated demonstrations beat 250 unfiltered ones, folding success 20% to 98%.
    - Frozen-DINOv3 phase, progress and contact models pre-annotate every episode at 97% top-1, cutting human labeling 70% and automating curation.
    - End-to-end data engine: multi-stream sync, multi-sensor system, 3D dataset viewer (multi-view + URDF) used daily for inspection and QA.
    - VLA fine-tuning with flow matching and LoRA/PEFT on multi-GPU; real-time runtime with Pinocchio IK/FK, RNEA, impedance and position control to 0.1 mm over CAN.
  ]

  #work-heading(
    "Embedded Drone Software Engineer, Intern",
    "Thales Land & Air Systems",
    "Vélizy-Villacoublay, France",
    datetime(year: 2024, month: 9, day: 1),
    datetime(year: 2025, month: 2, day: 1),
  )[
    - Architected a real-time embedded Lua scripting engine in C++ (TDD), enabling rapid mission prototyping on flight hardware.
    - Integrated local LLMs via Rust and Docker under tight compute constraints (85% accuracy); owned the stack from cross-compilation to live demo.
  ]

  #work-heading(
    "Autonomous Vehicle Control Lead",
    "UTonome — UTAC Challenge",
    "Compiègne, France",
    datetime(year: 2024, month: 2, day: 1),
    datetime(year: 2025, month: 6, day: 1),
  )[
    - Led sim-to-real deployment of the control stack onto a Renault Zoe (ROS/Python): waypoint control law, adaptive cruise control, obstacle avoidance; 99% safety in simulation.
    - Won the 2025 open category and the 2024 best-school award.
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
  ]
]

#custom-title("Skills")[
  #skills()[
    - *Learning:* self-supervised and latent-predictive (JEPA) objectives, video and multimodal architectures, VLAs, flow matching, imitation learning, LoRA/PEFT, evaluation design
    - *Scale:* multi-GPU distributed training, efficient inference, data curation pipelines, dataloaders, PyTorch, JAX, Docker, CI/CD
    - *Planning & control:* MPC, model-based planning, Pinocchio IK/FK and RNEA, impedance control, ROS2, dora-rs, RTOS, CAN
    - *Languages:* Python, Rust, C++17, C, MATLAB, Bash
    - *Simulation:* MuJoCo, Isaac Sim, Genesis, Gazebo
  ]
]

#custom-title("Education")[
  #education-heading(
    "University of Waterloo",
    "Waterloo, Canada",
    "M.Sc. Computer Engineering",
    "AI/ML",
    datetime(year: 2025, month: 9, day: 1),
    datetime(year: 2025, month: 12, day: 1),
  )[
    - GPA 4.0/4.0 — Deep Learning (Bryan Tripp), Machine Learning (Terrence C. Stewart), Image Processing.
  ]

  #education-heading(
    "Université de Technologie de Compiègne",
    "Compiègne, France",
    "M.Sc. Computer Science",
    "Embedded & Autonomous Systems",
    datetime(year: 2021, month: 9, day: 1),
    datetime(year: 2026, month: 6, day: 1),
  )[
    - GPA 5.0/5.0 — Robotics Control, Embedded Systems, Kinematics.
  ]
]

#custom-title("Projects & Awards")[
  #skills()[
    - *Open source:* SO-ARM-101 and Reachy Mini manipulation stacks; autonomous drones; #link("https://github.com/theguega/peillute")[peillute], a distributed P2P payment system in Rust; Kaggle Brain-to-Text '25.
    - *Hackathons:* 2nd prize, Seeed x NVIDIA x Hugging Face Embodied AI (Santa Clara, 2026); 2nd prize, Open World by VLGE (San Francisco, 2026); winner, UTC x ST2I (France); Mistral AI Worldwide (San Francisco, 2026); SWARM Robotics (Canada).
  ]
]
