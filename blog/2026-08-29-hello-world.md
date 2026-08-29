# Hello World

Like in every new programming language, it's time to write the classic `init` post.

I decided to start this blog to share parts of my coding journey, projects, and what I'm learning along the way. But most importantly, I want to write this introduction to show that you don't need to fit the stereotypical "cracked dev" mold to build cool things, work on what you love, or make it to places you only ever dreamed of.

## The "Not-So-Cracked" Origin

Let's get one thing straight: I am not, and will probably never be, the most cracked developer out there.

Whenever you scroll through tech Twitter or YouTube, you inevitably stumble upon some 18-year-old MIT student portfolio showcasing how they built an autonomous electric car from scratch at age 10 and designed the factory assembly line to mass-produce it at 13.

That definitely wasn't me.

I started programming seriously when I was around 16, with Python in high school class—nothing out of the ordinary. Before that, I always had a soft spot for computers. When I was 10, my grandfather set up a laptop with Linux Mint for me. I spent hours playing around with [Scratch](https://scratch.mit.edu/) to make simple games, and my proudest technical flex back then was figuring out how to launch Minecraft directly from the bash terminal:

```bash
java -Xmx1024M -jar ~/Downloads/minecraft.jar
```

Growing up as a random kid in a small town in France, the idea of ever going to work in Silicon Valley (honestly, I didn't even know what the "Bay Area" was back then) felt like a very funny, impossible joke.

## Finding My Way: UTC & The Love for Simple Software

I stayed curious about science and eventually joined [UTC](https://www.utc.fr/) (Université de Technologie de Compiègne, part of Sorbonne University).

In France, engineering education follows a 5-year model (integrated preparatory classes + engineering cycle) resulting in the French _Diplôme d'Ingénieur_, which is recognized as the equivalent of a Master's degree in the US. A 3-year Bachelor's isn't the standard engineering route here.

I genuinely loved my time at UTC for three main reasons:

1. **Autonomy:** Because it's structured like a university, nobody holds your hand. If you want to succeed, you have to figure things out on your own and take ownership of your learning.
2. **Student-driven culture:** The university is packed with student clubs. From robotics and sports to tech, business, and cultural events, everything is entirely managed by students—from administrative paperwork and budgeting to hands-on engineering.
3. **Real-world focus:** The curriculum requires two 6-month full-time internships and an academic experience abroad.

Throughout my academic projects, I made it a habit to push every assignment a little further than what was asked—not just for the grade, but for the fun of building something cool and polished.

Around that time, I fell deeper down the programming rabbit hole. I started exploring languages like **Rust**, **Zig**, and **Lua**, appreciating how each language approaches systems, memory, and abstractions. I developed a deep love for simple, idiomatic software—code that solves a problem cleanly with minimal overhead and zero unnecessary complexity. A lot of that mindset was inspired by watching recreational programming streams by [Tsoding](https://github.com/tsoding) (a bit nerdy, I know, but I loved it).

## The Waterloo Shock: Dreaming Bigger

Things really accelerated when I went on an academic exchange to Canada at the [University of Waterloo](https://uwaterloo.ca/).

I took master's level courses in Deep Learning, Image Processing, and Robotics. Beyond the coursework, being at Waterloo was a complete culture shock.

From day one, almost everyone was laser-focused on the Bay Area. People were polishing their LinkedIn profiles, networking, launching side projects, and grinding LeetCode in their free time. Landing an internship in California or getting into Big Tech / FAANG was _the_ target.

Seeing that energy was contagious. I decided to take inspiration from them, give it an honest shot, and see if I could find something in California.

I started sending out dozens of job applications. Unsurprisingly, it was mostly radio silence. The moment you check the _"Will you now or in the future require visa sponsorship?"_ box on standard job portals, your resume usually goes straight into the void.

## Just Try (Seriously, Just Try)

Applying through standard front-door job portals wasn't working. So I switched strategies: what if I just reached out directly to founders and engineering leaders to ask for advice?

While researching tech leads and founders in the US robotics and AI space, I came across [Claire Delaunay](https://www.linkedin.com/in/clairedelaunay/). Her track record was unbelievable: multiple successful exits in the Bay Area, Robotics Program Lead at Google, VP of Engineering at NVIDIA, and Director of Engineering at Uber.

I reached out to her asking for advice, half-expecting to never hear back.

To my surprise, she answered! We had a quick chat, she loved my vision, and she told me she was in the process of starting a new robotics startup in the Bay.

Fast-forward four months: visa approved, flight tickets booked, and I landed in California as a Machine Learning intern. I spent those months trying to make a space for myself in this crazy tech environment, grinding weekend hackathons across San Francisco, and connecting with so many incredibly talented people.

## What Now?

Looking back: I started out making simple games on Scratch, launched Minecraft through a bash command, and took up serious programming relatively late compared to typical prodigies.

Now? I'm working as a **Founding Engineer in Embodied AI**, split between Paris and the Bay Area (Redwood City), building and deploying robots in real-world environments.

If there's one thing I've learned from this entire journey, it's this:

**Everything is possible if you actually try.**

It sounds simple, but so many people eliminate themselves before they even begin because they assume they don't have the right pedigree, the right background, or the "cracked" genius status.

The difference isn't having built a car at age 10. The difference is shifting your mindset from _"Why this won't work"_ to _"How could I make this possible?"_

Once you make that shift, you just take the shot, adapt, and repeat.

```zig
while (!success) {
    const goal = dream_big();

    if (try reach_out(goal)) |opportunity| {
        build_cool_stuff(opportunity);
    } else |_| {
        // "how could I make it possible?"
        adapt_and_retry();
    }
}
```
