#import "@preview/simple-technical-resume:0.1.0": *

#let name = "Theo Guegan"
#let email = "theo.guegan.perso@gmail.com"
#let github = "theguega"
#let linkedin = "guegan-theo"
#let personal-site = "theguega.github.io/me/"

#show: resume.with(
  top-margin: 0.4in,
  personal-info-font-size: 9pt,
  font-size: 10.6pt,
  author-position: center,
  personal-info-position: center,
  author-name: name,
  email: email,
  website: personal-site,
  linkedin-user-id: linkedin,
  github-username: github
)

#custom-title("Skills")[
  #skills()[
    - *Robotics & Control:* ROS2, RTOS, Behavior Trees, IK Control, MPC
    - *AI & ML:* VLAs, Vision models, Reinforcement Learning, Imitation Learning, PyTorch, JAX.
    - *Languages:* Python 3.10-3.13, Rust, C, C++17, MATLAB, Lua, Bash
    - *Simulation & Tools:* MuJoCo, Isaac Sim, Genesis, Gazebo, Docker, CMake, Git, CI/CD
  ]
]

#custom-title("Experience")[
  #work-heading(
    "Machine Learning Intern",
    "Stealth Startup",
    "Palo Alto, CA",
    datetime(year:2026, month:2, day:1),
    "Present"
  )[
    - CEO: Claire Delaunay
    - Training and evaluating VLAs and vision models for robotics control.
    - Developing agentic frameworks for robotics
    - Deploying end-to-end infrastructure : data-collection, simulation, networking, videos
    - More public information soon..
  ]

  #work-heading(
    "Embedded Drone Software Engineer Intern",
    "Thales Land & Air Systems",
    "Vélizy-Villacoublay, France",
    datetime(year:2024, month:9, day:1),
    datetime(year:2025, month:2, day:1)
  )[
    - Architected a real-time embedded Lua scripting engine in C++ (TDD), enabling rapid mission prototyping.
    - Streamlined build processes for embedded Linux targets, ensuring reliable deployment in messy real-world conditions.
    - Integrated local LLMs via Rust/Docker, handling hardware constraints and demonstrating ownership of the full software stack.
    - Developed a cross-platform drone manager application with multi-drone support and control.
  ]

  #work-heading(
    "Autonomous Vehicle Control Lead",
    "UTonome – UTAC Challenge",
    "Compiègne, France",
    datetime(year:2024, month:2, day:1),
    datetime(year:2025, month:6, day:1)
  )[
    - Led the deployment of control software from simulation to Renault Zoe (ROS/Python), validating algorithms in real-world track scenarios.
    - Designed a homogeneous waypoint-based control law with (99% sim safety).
    - Deployed Adaptive Cruise Control, Static obstacle avoidance and navigation algorithms based on the same control law with dynamic dispatch.
    - Won 2025 and 2024 UTAC edition.
  ]
]

#custom-title("Hackathons - Projects")[
  #project-heading("Portfolio")[
    - Built my own SO-ARM, some OSS tools for LLMs, a neural MPC approximation, Reachy Mini projects and many more on my portfolio, see:
    - https://www.theguega.github.io/me
  ]

  #project-heading("Hackathons - Competitions")[
    - #link("https://www.utac.com/challenge-utac")[UTAC Autonomous vehicle challenge (France) : best school award 2024 | won 2025 edition]
    - FIT Coding Challenge 2025 (Bosnia)
    - UTC x st2i hackathon (France) : winners
    - #link("https://luma.com/7xkp31u4")[SWARM, The World’s Largest Swarm Robotics Hackathon (Canada)]
    - #link("https://luma.com/mistralhack-sanfrancisco?tk=5OVyT1")[Mistral AI Worldwide Hackathon 2026: build the next era of AI (San Francisco)]
    - #link("https://luma.com/zsaa3r3d?tk=BmAVah")[Seeed 2026 Embodied AI Hackathon in Santa Clara : won 2nd prize]
    - #link("https://luma.com/robohacks-at-YC?tk=2BHGQB")[RoboHacks : NASA, Deepmind, YC (San Francisco)]
  ]
]

#custom-title("Education")[
  #education-heading(
    "Université de Technologie de Compiègne (UTC)",
    "Compiègne, France",
    "M.Sc. Computer Science",
    "Embedded & Autonomous Systems",
    datetime(year: 2021, month: 9, day: 1),
    datetime(year: 2026, month: 6, day: 1)
  )[
    - GPA: 5.0/5.0 | Robotics Control, Embedded Systems, Kinematics
  ]

  #education-heading(
    "University of Waterloo",
    "Waterloo, Canada",
    "Computer Engineering",
    "AI/ML",
    datetime(year: 2025, month: 9, day: 1),
    datetime(year: 2025, month: 12, day: 1)
  )[
    - GPA : 4.0/4.04 | Deep Learning (Bryan Tripp), ML (Terrence C. Stewart), Image Processing, Computer Networks
  ]
]
