# A Primer on Vision-Language-Action Models

VLAs are the next frontier in robotic control. Instead of hand-crafting reward functions or writing rule-based controllers, we let a single model see, understand, and act.

## Why VLAs?

- **End-to-end**: no separate perception, planning, and control stacks
- **Language-conditioned**: tell the robot what to do in natural language
- **Generalizable**: pre-trained on internet-scale data, fine-tuned on robot demonstrations

## The Architecture

A typical VLA pipeline looks like:

1. A vision encoder (ViT) processes the camera feed
2. A language model fuses the visual tokens with a text instruction
3. An action head decodes continuous motor commands

```
camera_feed -> ViT -> [visual_tokens]
instruction -> tokenizer -> [text_tokens]
[visual_tokens + text_tokens] -> LLM -> action_head -> joint_positions
```

## What I'm Working On

Currently exploring ways to make VLAs more sample-efficient and robust to distribution shift. More on this soon.
