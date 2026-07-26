export interface BlogPost {
    slug: string;
    title: string;
    excerpt: string;
    publishDate: string;
    readingTime: number;
    category: string;
    content: string[];
}

export const posts: BlogPost[] = [
    {
        slug: "building-an-agentic-dev-loop",
        title: "Building an agentic development loop I actually trust",
        excerpt:
            "The workflow I use to let AI agents draft, inspect, and refine code without giving up observability or judgment.",
        publishDate: "July 24, 2026",
        readingTime: 5,
        category: "Agentic Development",
        content: [
            "The most useful agentic workflows are not the ones that feel fully autonomous. They are the ones that make the machine legible. I want the model to propose edits, explain its path, and leave clear checkpoints that I can inspect before anything important lands.",
            "My default loop is simple: give the agent a narrow objective, let it inspect the surrounding code, require a concrete execution plan, and then verify its changes with fast local checks. That structure keeps momentum high without turning the editor into a black box.",
            "Trust comes from instrumentation, not from vibes. If the agent can show me the diff, the diagnostics, and the build result, I can move quickly while still feeling grounded in what changed and why."
        ]
    },
    {
        slug: "weekly-agent-news-roundup",
        title: "This week in agent news: tool use, evals, and tighter feedback loops",
        excerpt:
            "A personal roundup of the updates that mattered most to people building with AI agents this week.",
        publishDate: "July 19, 2026",
        readingTime: 4,
        category: "News",
        content: [
            "The signal this week was not just bigger models. It was better scaffolding around them: clearer tool calling, more deliberate evaluation pipelines, and product teams openly discussing how to keep agents from drifting off task.",
            "That matters because the frontier is shifting from pure model capability toward workflow design. The teams winning right now are packaging models inside reviewable systems with constraints, retries, and human checkpoints.",
            "When I scan the news, I look less for benchmark spikes and more for evidence that the surrounding loop is maturing. Reliable agents are as much about product discipline as raw intelligence."
        ]
    },
    {
        slug: "three-ui-patterns-for-ai-assisted-coding",
        title: "Three UI patterns that make AI-assisted coding feel less chaotic",
        excerpt:
            "The interface details I keep noticing in the best agentic developer tools: scoped context, visible progress, and reversible actions.",
        publishDate: "July 8, 2026",
        readingTime: 6,
        category: "Product Design",
        content: [
            "A good agent interface should answer three questions at a glance: what context does the model have, what is it trying to do right now, and how easy is it to undo the result? When those answers are fuzzy, users slow down or disengage.",
            "Scoped context matters because it keeps prompts grounded. Progress indicators matter because they reduce the anxiety of waiting. Reversible actions matter because they turn experimentation into something safe and routine.",
            "These patterns sound small, but they are the difference between a gimmick and a tool that becomes part of a daily engineering workflow."
        ]
    },
    {
        slug: "what-i-want-from-coding-agents-next",
        title: "What I want from coding agents next",
        excerpt:
            "Less magic, better memory, and stronger collaboration primitives would do more for my workflow than another dramatic demo.",
        publishDate: "June 28, 2026",
        readingTime: 3,
        category: "Opinion",
        content: [
            "I do not need coding agents to pretend they are senior engineers. I need them to become better collaborators: more explicit about assumptions, better at retaining local project context, and more willing to surface uncertainty before they act.",
            "The next wave of improvement should focus on memory, traceability, and handoff quality. If an agent can summarize what it learned, what it changed, and what still needs attention, it becomes much easier to weave into real team workflows.",
            "That is the version of progress I care about most: systems that make humans sharper, not systems that merely look impressive in short clips."
        ]
    }
];