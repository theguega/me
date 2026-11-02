# Robots Are Not Text

A demo worked on Friday. On Monday the same robot failed the same task, and I spent the next week finding out why. Nothing in the code had changed. The table had moved a few centimetres, the lighting was different, and a gripper pad was slightly worn. That week taught me more about robot learning than any paper I'd read.

That gap is where this story starts. Most of the field is still talking about the demo.

## Where It Started: RT-2 and the Text Trick

In 2023, Google DeepMind published [RT-2](https://arxiv.org/abs/2307.15818). The idea was simple and a bit mischievous: take a vision-language model that already knows what a "cup" is and what "move it next to the apple" means, co-fine-tune it on robot trajectories, and write the actions as text. Each action dimension was discretised into 256 bins and emitted as tokens, the same way a word would be.

It worked surprisingly well. The model handled objects and instructions it never saw in robot data, because the semantic knowledge came from the web. That's the scaling story everyone repeats: more internet knowledge, more robot skills.

## Text Is the Wrong Shape for a Robot

Here's what gets lost. Robot data is continuous and high-dimensional. A single 7-DoF arm at 30 Hz is a stream of joint positions, velocities and torques. Add cameras, depth, force and tactile sensing, and you have a multi-rate time series that doesn't look like a sentence.

Discretising works up to a point. Quantisation is a lossy map from a continuous control space onto a grid, and at fine resolution the token sequences get long and slow. Recent policies move away from it. [Diffusion Policy](https://arxiv.org/abs/2303.04137) models action chunks with a denoising process, and [pi0](https://arxiv.org/abs/2410.24164) uses flow matching for its action head. Both are better at precise, multimodal continuous outputs.

The question I care about most is alignment. How do you put a semantic space and a sensorimotor space into one system so that one can recover the other? Humans do this constantly. You can describe a grasp in words, feel it without looking, and picture it from a sentence. I like to think of it as three systems: a fast reactive one, a slower one that plans and reasons, and one that orchestrates them. A single model with one output head doesn't obviously give you that.

## A Prompt Is Not a Sentence

The same bias shows up in how we prompt. In RT-2, the prompt is a sentence. For a robot, the intent can be a goal image, a demonstration, a point on the table, a force profile, or a spoken command grounded in what the robot sees. The intent has to be aligned with the real world and with the modalities the robot can actually use.

The natural place for that alignment is a latent world, where the goal, the observation and the predicted outcome live in the same space. That's the bet behind latent worlds and JEPA: a prompt is useful when the model can check it against what the robot will do.

## Kinematics Still Pays the Bills

Before anything is learned, the robot has to know where its hand is. Forward and inverse kinematics, Jacobians, collision checking, trajectory optimisation, impedance control. A policy that outputs a joint target still needs a controller that can reach it safely, and a planner that knows the arm can't pass through the table.

Learned models are good at intent and bad at guarantees. Classical robotics is the reverse. The useful architecture uses both, and whoever draws the boundary between them well is ahead.

## Predict the Result, Not the Pixels

Yann LeCun's position paper (2022) argues for world models that predict in representation space, not in pixels. [I-JEPA](https://arxiv.org/abs/2301.08243) and [V-JEPA](https://arxiv.org/abs/2404.08471) apply that idea to images and video: predict the embedding of a masked or future region from its context, without reconstructing every pixel.

For robotics, the appeal is direct. A policy should know what happens if it does something. Predicting the consequence of an action, in a space that drops irrelevant detail, is a far more data-efficient target than predicting every pixel of the next frame. That's why I think JEPA-style models are a strong candidate for the "understanding" part of a robot's brain.

## Three Systems, Three Modules

Each system is an AI module with its own job:

- **System 1, the reactive policy:** a visuomotor model that maps the latest observations to actions at control rate. It is conditioned on a prompt from System 2, a subgoal or constraint in the same latent space, so it knows what it is trying to do, not just what it sees. It has to be fast, and its internal representation has to be clean: a latent that keeps what matters for control and drops the rest. This is where a JEPA-style world model shapes that latent.
- **System 2, the planner:** a slower module that reasons over that latent. It plans sequences of subgoals, checks them against what System 1 predicts will happen, and handles tasks that need more than a reflex.
- **System 3, the orchestrator:** a voice and text LLM pipeline that manages memory and long-horizon tasks. It turns spoken or written intent into tasks, tracks what is done and what is still open, and decides which System 2 plan and System 1 policy to call.

The modules matter, but the interfaces between them matter more. If System 1 can't expose its latent and its predicted outcomes, System 2 has nothing to plan with.

## Demos Lie, Politely

Imitation learning is only as good as its data. Behaviour cloning learns the distribution it saw, and the real world drifts away from that distribution in small steps: lighting, object placement, wear on a gripper, a slightly different table. Each small error moves the robot into a state it never saw in training, and the errors compound. That's the gap between the demo video and the robot that fails on Monday.

This is where RL matters. An imitation policy inherits the quality of its demonstrations. RL, given a reward and room to explore, can go past them. The hard part is doing that without a cluster of GPUs or a broken arm. Model-based RL is one answer: [SuperMimic](https://arxiv.org/abs/2610.28480) trains a single differentiable world model across all motions and backpropagates through short imagined rollouts, instead of the cluster-scale model-free RL most tracking pipelines use.

Physical Intelligence's pi*0.6 (2025) takes a different route and stays on real hardware. A VLA is trained from its own experience on the robot, using a learned value function to weight which actions to reinforce, and human corrections are folded into the same loop. The policy improves on the tasks it already does, from the data its own deployments produce, rather than only from more demonstrations.

## Data Is an Operations Problem

Scaling data is an operations problem. Collecting demonstrations takes operator time. Annotating takes people. Reviewing takes people. High-rate, multi-camera logs take storage, and someone has to decide which episodes are worth keeping. Each of those steps becomes the bottleneck the day you go from ten robots to a hundred.

So the data pipeline is a product. Filtering, per-task statistics, outlier detection, versioning and fast replay matter as much as the model.

## Trying Is Cheap, Measuring Is Not

AI has made it cheap to try things. A new architecture, a new tool, a new training recipe, a few hours of GPU time. What hasn't become cheap is knowing whether it worked on the real robot.

I've lost more weeks to a gripper that works in the morning and not in the afternoon than to any model architecture. I'm not the person to write the definitive paper on this, but I've now seen enough Monday failures to have opinions. Deploying, running the same task a hundred times, logging every failure and turning those failures into a metric a team can act on: that's the bottleneck. Benchmarks help, but they don't replace a robot on a table.

## What I'm Building at Opalin

At Opalin I'm a founding engineer, working on the layers between a single experiment and a fleet. That means data collection from several teleoperators, filtering, training, deployment and evaluation, all inside one loop. The goal is to combine what traditional robotics got right with what the AI side has added, so a demo on one robot becomes a useful system on many robots, one that adapts quickly to new challenges.

Here's the loop I keep in my head:

```zig
while (!deployed) {
    const intent = orchestrator.next(voice_or_text);     // System 3
    const plan = planner.plan(intent, latent);            // System 2
    const action = policy.act(observation, plan.subgoal); // System 1
    world.check(action, latent) catch |_| plan.replan();  // predicted vs real
}
```

Opalin's policies are now robust to most of these things, and I'm glad I don't have to fight like that every week.

**Demos are easy to make. Robots that work on Monday, measured properly, on a fleet, are the job.**
