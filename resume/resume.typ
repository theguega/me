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
    - Trained efficient visuomotor policies: latent encoders over multi-view video and proprioception, deployed as real-time robot policies.
    - Variance-targeted data curation: 2.8x less curated demonstrations beat unfiltered ones, lifting folding success from 20% to 98%.
    - Frozen-DINOv3 phase, progress and contact estimator annotates every episode (97% top-1), cutting human labeling 70%.
    - End-to-end data engine: multi-stream sync, 3D dataset viewer (multi-view, URDF) used daily for QA.
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
    - Embedded Lua script engine and local script generation for rapid mission prototyping (Rust harness, local inference, end-to-end deployment).
    - Cut new-mission deployment time by 10x and improved reliability and predictability by 4x.
    - Part of Thales' COHESION demonstrator (JDEC 2024), featured in French media.
  ]

  #work-heading(
    "Research Assistant",
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

#custom-title("Projects & Awards")[
  #skills()[
    - *Open source:* SO-ARM-101 and Reachy Mini manipulation stacks; autonomous drones; #link("https://github.com/theguega/peillute")[peillute], a distributed P2P payment system in Rust; Kaggle Brain-to-Text '25.
    - *Hackathons:* 2nd prize, Seeed x NVIDIA x Hugging Face Embodied AI (Santa Clara, 2026); 2nd prize, Open World by VLGE (San Francisco, 2026); winner, UTC x ST2I (France); Mistral AI Worldwide (San Francisco, 2026); SWARM Robotics (Canada).
  ]
]
