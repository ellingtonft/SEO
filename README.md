# SEO kit for Claude Code — runbook

From Jonah. This is the SEO/AEO process I use on my own sites, packaged so your
Claude Code can run it. It gives you one skill (`/seo-pass`), one agent
(`seo-lane-auditor`), and the research and lessons behind them.

**AEO** = answer-engine optimization: being cited by ChatGPT, Perplexity,
Claude, and Google AI Overviews, not only ranked in blue links.

## What is in the box

```
ellington-seo-kit/
├── README.md                          ← this runbook (for you)
├── install.sh                         ← copies the skill + agent into ~/.claude
├── templates/first-prompt.md          ← paste this into Claude Code to start
└── .claude/
    ├── agents/seo-lane-auditor.md     ← read-only auditor, one per lane, run in parallel
    └── skills/seo-pass/
        ├── SKILL.md                   ← the /seo-pass process (audit → fix → draft PR)
        └── references/
            ├── site-playbook.md       ← linear 10-step first pass for a small site
            ├── audit-lanes.md         ← the check catalog, 7 lanes
            ├── blind-spots.md         ← what most checklists miss in 2026 (entity, local, AI)
            ├── lessons.md             ← gotchas that cost real time on real sites
            ├── code-patterns.md       ← copy-paste Next.js code + curl/Lighthouse checks
            ├── strategy.md            ← ranking, links, knowledge panel, AI search
            └── pr-template.md         ← the PR body format
```

## 1. Install (2 minutes)

You need Claude Code, `git`, `gh` (logged in: `gh auth login`), and Node.

```bash
cd ellington-seo-kit
bash install.sh          # copies into ~/.claude/skills and ~/.claude/agents
```

Or keep it per-project: copy the `.claude/` folder into your site's repo root.
Restart Claude Code (or run `/agents` and `/skills` to check it sees them).

**Optional, recommended add-ons:**

| Add-on | Why | Install |
|---|---|---|
| `claude-seo` (MIT, open source) | 25 extra SEO sub-skills (local SEO, e-commerce, international, backlinks, reports). My audit catalog is distilled from it. | In Claude Code: `/plugin marketplace add AgriciDaniel/claude-seo` then `/plugin install claude-seo@agricidaniel-claude-seo` |
| Chrome DevTools MCP | Lets Claude render pages in a real browser and run Lighthouse itself | `claude mcp add chrome-devtools -- npx chrome-devtools-mcp@latest` |

Neither is required. Without them the skill uses `curl`, WebFetch, and `npx lighthouse`.

## 2. Pick your path

| Your situation | Do this |
|---|---|
| Small site, first SEO pass ever (personal, portfolio, local business, <20 pages) | **Path A** — the linear playbook |
| Bigger site, or you have done the basics and want a full audit | **Path B** — `/seo-pass` fan-out |
| No code access (Wix, Squarespace, Shopify theme, someone else's site) | **Path C** — audit-only report |
| "Can I rank #1 for X?" / "what next?" | Ask Claude to read `references/strategy.md` and answer for your query |

### Path A — linear playbook (start here if unsure)
Open Claude Code in your site's repo and paste `templates/first-prompt.md`,
filled in. Claude works through `site-playbook.md` Steps 0–10 and stops for you
at: copy changes, the deploy, and Search Console clicks.

### Path B — full audit + PR
```
/seo-pass https://yoursite.com .
```
Claude records the live site, runs 7 auditors in parallel, commits the safe
fixes on a branch, runs the build and Lighthouse, and opens a **draft PR**.
Copy changes come back as a checklist in the PR, not as edits. You review, merge,
deploy. Then tell Claude "it's deployed" and it re-checks the live site and walks
you through Search Console.

### Path C — no repo
```
/seo-pass https://yoursite.com
```
You get a ranked report with evidence. For Wix/Squarespace/Shopify/WordPress,
most fixes are settings; ask Claude to turn the report into click-by-click
steps for your platform.

## 3. The parts only you can do

Claude can't do these for you. They matter as much as the code:

1. **Google Search Console** — verify the site (Domain property via DNS is
   best), submit the sitemap, Request Indexing. Claude gives you each click.
2. **Bing Webmaster Tools** — "Import from Google Search Console". It takes one
   minute, and ChatGPT search uses Bing.
3. **Google Business Profile** (if you are a local business) — claim, verify,
   fill every field, add photos, reply to reviews. For local search, this beats
   most on-site work.
4. **Profile consistency** — same name, same one-line description, same photo or
   logo, same link on LinkedIn, Instagram, GitHub, Yelp, and directories.
5. **Approve copy and deploys.** The skill never merges or deploys by itself.

## 4. How to judge Claude's work

- Every claim needs **evidence**: pasted `<head>`, a status code, a Lighthouse
  score, a Search Console screenshot. If Claude says "should work", ask for the output.
- **Search Console is the only source of truth for indexing.** A `site:yoursite.com`
  Google search that shows nothing does not prove you are not indexed.
- **Timelines:** first crawl in 1–3 days; snippet updates in days to 2 weeks;
  ranking movement on real queries in weeks to months; knowledge panel in 3–6
  months. Changing code again doesn't speed any of this up.

## 5. Keep it going (monthly, ~20 minutes)

- Search Console → Performance: which queries get impressions but few clicks?
  Ask Claude to improve the title and description for those pages.
- Refresh your top pages every 6–12 months, with a visible "Updated" date.
- Write one page per real question your customers ask, with an answer block at the top.
- Get 1–2 real mentions or links per month (local press, partners, podcasts,
  Reddit answers). Real ones only, never bought.
- Re-run `/seo-pass` after big site changes.
