# Vats of Eden
version 0

## Introduction

Vats of Eden is a single player game that combines elements of idle games, card collecting games, and colony-management. It takes place seventy-five years from now in upstate New York, and like the utopian eras of the 1890s groups are splintering off from the main stream society to experiment with new forms of economies, government, family structure, and other exsistential questions. As a player you'll start with a founder and two members and build your colony to flourish in a strange and sometimes hostile new world.

## Description

Configure everything - every element of the game can be governed by simple sliders that allow you to react to changing situations. Buildings, machines, furniture, characters, gear, concepts and all nest inside one and another to create different effects and rates. The game is propelled along but a constant rate of cards being dealt to the player offering them choices, situations, and rewards.

## Features
* Evolve your colony from a makeshift shack to a powerful city-state.
* Manage colony members gear skill and social life
* Experiment with new forms of economies, law, and invention.

---

## Stats

Stats are scoped to three levels: the colony as a whole, individual characters, and resources that flow through edges. These are distinct — colony stats are aggregate health indicators, character stats are personal attributes, and resources are the material the graph actually moves around.

### Colony Stats

| Stat | What it measures | Damaged by | Built by |
|------|-----------------|------------|----------|
| `Cohesion` | How unified the colony is | Value mismatches, consensus failures, unmet needs | Shared meals, successful votes, aligned Concept nodes |
| `Resilience` | Ability to absorb shocks | Thin surplus, single-point dependencies in the graph | Redundant node paths, stockpiles, healthy characters |
| `Reputation` | External perception | Broken barter agreements, visible internal conflict | Successful trades, skilled visitors, colony milestones |

Reputation gates the quality of incoming cards — a high-reputation colony draws from a better deck.

### Character Stats

| Stat | What it measures |
|------|-----------------|
| `Health` | Physical condition; sick state breaks labor edges |
| `Morale` | Day-to-day wellbeing; affects labor efficiency and social edge quality |
| `Dedication` | Commitment to the colony; low dedication → character considers leaving |
| `Skills` | Domain-specific labor multipliers (farming, crafting, medicine, etc.) |
| `Values` | Core beliefs (Autonomy, Community, Fairness, etc.); determines alignment friction with Concept nodes |

### Resources (Edge-Flowing)

| Resource | Role |
|----------|------|
| `Food` | Survival baseline; unmet food need → Health decline |
| `Materials` | Construction, tools, repairs |
| `Energy` | Powers machines; without it, Transformer nodes go idle |
| `Knowledge` | Unlocks new node types and Concept nodes |

### Money is a Concept, Not a Stat

Money does not exist as a universal resource. It only appears if the colony activates a `Market Economy` Concept node. Colonies running communal, gift, or barter systems have no currency — and don't need one internally.

**External trade always uses barter.** Exchange nodes at the colony boundary handle outside transactions regardless of internal economic config. As the colony grows and manages dozens of external relationships, the complexity of barter at scale creates organic pressure to invent money — players adopt it when they need it, not because the game starts them with it.

---

## Node Architecture

Every element in the game is a node. Nodes connect to other nodes via typed edges. The colony's behavior emerges from the graph — changing the topology changes how the colony functions.

### Node Types

| Node | Role | Example |
|------|------|---------|
| `Producer` | Generates resources over time | Garden, Solar array, Workshop |
| `Consumer` | Uses resources, outputs effects | Kitchen, Clinic, School |
| `Transformer` | Converts resource A → B | Still, Forge, Compost pile |
| `Container` | Holds other nodes + characters | Building, Room, Campsite |
| `Character` | Has needs, skills, relationships | Founder, Member |
| `Concept` | Broad modifier to colony behavior | Communal ownership, Barter economy |
| `Gear` | Modifier attached to a character | Tool, Clothing, Medicine |
| `Event` | Transient, card-driven | Storm, Visitor, Outbreak |

### Edge Types

| Edge | Meaning |
|------|---------|
| `resource` | Material/energy flowing between nodes |
| `labor` | Character's time + skill applied to a node |
| `modifier` | Multiplier on a rate (buff/debuff) |
| `social` | Relationship between characters |
| `trigger` | Event causes an effect somewhere |
| `occupancy` | Character inhabits/works a space |

Edges are typed — a `labor` port only accepts `Character` nodes, a `modifier` port only accepts `Concept` or `Gear` nodes. Invalid connections are blocked at the UI level.

---

## Scenario: Three-Character Colony Under Two Economic Systems

Starting cast:

- **Maya** (Founder) — values: Autonomy, Pragmatism
- **Theo** — values: Community, Fairness
- **Roz** — values: Efficiency, Independence

Starting nodes: Garden (Producer → food), Kitchen (Transformer → meals), Workshop (Producer → tools).

---

### Config A: Communal Pool

A `Common Pool` Concept node sits in every resource flow path. All output is surrendered to it; the pool distributes based on need.

```
Maya ──labor──> Garden ──resource──> [ Common Pool ] ──resource──> Kitchen ──meals──> Maya
Theo ──labor──> Kitchen                                         └──resource──> Clinic
Roz  ──labor──> Workshop ─resource─> [ Common Pool ]            └──resource──> Workshop
```

**Effects:**
- Theo gets a `+social` modifier — his Community value aligns with the system
- Maya takes a `−labor efficiency` penalty — Autonomy value creates friction with surrendering her output
- Roz is neutral; the pool routes tools to whoever needs them, which satisfies her Efficiency value as long as the pool doesn't bottleneck
- A `Fairness Rule` constraint node on the pool's output edges ensures no character is prioritized, blocking any attempt to wire a direct Garden → Maya path

**Failure mode:** If the colony grows, the Common Pool becomes a single point of congestion. Players can see this in the graph — one node with too many edges. The fix requires splitting it (a `Regional Pool` concept) or switching systems.

---

### Config B: Barter

No central pool. Each character owns their labor output. `Exchange` nodes sit between every resource transfer and require a reciprocal flow to resolve.

```
Maya ──labor──> Garden ──resource──> [ Exchange ] ──meals──> Maya
                                         ↑
                               Theo ──labor──> Kitchen ──resource──> [ Exchange ] ──tools──> Theo
                                                                          ↑
                                                             Roz ──labor──> Workshop
```

**Effects:**
- Roz gets a `+labor efficiency` modifier — Independence aligns with owning her output
- Theo takes a `−social` penalty — his Fairness value creates friction when he notices Maya accumulates more food than she needs but won't share it without exchange
- Maya thrives — Autonomy value is satisfied, Pragmatism means she'll negotiate efficiently
- Exchange nodes expose price: if Roz produces few tools, their exchange rate rises. Players can see scarcity in the graph by how many pending `resource` edges are blocked at Exchange nodes

**Failure mode:** A sick character can't labor, breaking their exchange chains. Unlike the communal config, there's no automatic rerouting — other characters must explicitly rewire their edges to cover the gap, which may cost social capital.

---

### What the player learns from comparing the two

The graphs look structurally different:
- **Communal** has one fat central node — resilient to individual failure, vulnerable to scale
- **Barter** has many small exchange nodes — efficient when healthy, fragile under stress

Neither is optimal. The right config depends on the colony's character composition, current threats, and the player's goals. Swapping systems mid-game is possible but costly — characters with mismatched values will resist the transition, surfacing as `−modifier` edges until they adjust or leave.

---

## Layering Legal Systems

Economic systems govern *how resources flow*. Legal systems govern *who can change the graph and what happens when rules are broken*. They layer on top of any economic config as two node types:

- **`Rule` nodes** — sit on edges as gatekeepers; block or tax flows that violate the law
- **`Tribunal` nodes** — fire when a Rule is broken, producing an `Event` that ripples through social edges

### Config C: Consensus Governance (layered on Config A — Communal)

Consensus is a natural fit for the communal colony since Theo's Fairness value already leans that way. A `Consensus` Rule node gates any *structural* change — adding a node, rewiring an edge, or changing a Concept.

```
                    ┌─────────────────────────────────┐
                    │       CONSENSUS GATE             │
                    │  Maya ──approval──┐              │
New Node/Edge ─────>│  Theo ──approval──┼──> activate  │
(pending)           │  Roz  ──approval──┘              │
                    └─────────────────────────────────┘
```

**Effects:**
- Theo's Community value grants him a `+speed` modifier on approval — he votes quickly and enthusiastically
- Maya's Autonomy value makes her a slow approver — she deliberates, creating latency on every structural change
- Roz's Efficiency value means she'll approve fast if the change improves throughput, veto fast if it doesn't — she's the swing vote

**Emergent tension:** The player wants to wire in a new `Clinic` node. Theo approves immediately. Roz approves — it reduces sick-day labor losses. Maya is deliberating. The player can see the pending edge sitting at the Consensus Gate with two of three approvals lit. They can try to move Maya via a `social` edge (spend relationship capital) or wait.

**Violation:** If the player bypasses the gate and wires directly, a `Tribunal` Event node fires:

```
Illegal Edge ──trigger──> [ Tribunal ] ──social penalty──> Maya (initiator)
                                      ──trust penalty──> all Character nodes
                                      ──trigger──> [ Precedent Node ]
```

The `Precedent` node remembers the violation and increases the scrutiny modifier on Maya's future proposals.

---

### How Legal Systems Interact Differently with Each Economic Config

| | Communal Pool | Barter |
|---|---|---|
| **Consensus** | Slow but stable — most changes are collective anyway, friction is low | Grinds to a halt — every private exchange technically requires approval, players usually abandon it |
| **Meritocracy** | Creates internal contradiction — high-skill characters accumulate influence over a system designed to ignore contribution | Natural fit — skill determines exchange rates, labor edges carry weight, high performers pull ahead visibly |
| **Rotating Leadership** | Works smoothly — leader rotates authority over pool distribution, prevents entrenchment | Awkward — a barter economy has no central authority to rotate, the leader node has nothing to govern |
| **Common Law** | Precedents accumulate around the pool — eventually a thick web of constraints on what the pool can do | Precedents accumulate around Exchange nodes — trade law emerges organically from past disputes |

The table illustrates a design principle: **legal and economic systems have compatibility**. Pairing mismatched systems (Consensus + Barter) creates interesting friction that players have to actively manage or resolve by changing one of the two. This is a feature — it surfaces real historical tensions without the player needing to know the history.

### Legal System Node Types

| Node | Role |
|------|------|
| `Rule` | Sits on an edge; blocks or taxes non-compliant flows |
| `Tribunal` | Fires on Rule violation; produces social/trust Events |
| `Precedent` | Remembers past Events; modifies scrutiny on future similar actions |
| `Authority` | Grants a Character node the right to bypass or override specific Rules |
| `Veto` | Allows a Character to block a structural change unilaterally |

---

## Cards

Cards propel the game forward. The deck is shuffled randomly but colony conditions unlock new cards that are reshuffled in — building a Clinic adds medical cards, surviving a crisis adds veteran cards, high Reputation adds quality visitor cards. The player holds a maximum of three cards at a time.

### Lifecycle Properties

Every card has up to three properties that fire at different moments:

| Property | When it fires | Purpose |
|----------|--------------|---------|
| `on_reveal` | The moment the card enters the hand | Immediate effect — good or bad, the card announces itself |
| `on_purchase` | When the player plays the card | The main effect: places a node, wires an edge, applies a boon |
| `on_discard` | When the player removes the card without playing it | The cost of clearing a slot — resources, stat hits, or consequences |

The discard cost is the core tension: every card in hand is either an opportunity or a liability. A card you don't want still occupies a slot, and freeing that slot has a price.

**Example — Storm Warning:**
- `on_reveal` → `−Resilience` (the weather is already turning)
- `on_purchase` → player chooses a node to reinforce, negating damage
- `on_discard` → `−Food` (the storm hits uncontested, spoiling stores)

### Card Categories

#### Node Cards
Offer a new node to place in the colony graph. The card defines the node type, its input/output ports, and any starting modifiers.

- **Unlocked by:** building milestones, Knowledge accumulation, Reputation thresholds
- **on_reveal examples:** the node appears as a pending placement, may attract a character's interest (`+Morale` for aligned values)
- **on_purchase:** the node enters the graph; player wires its edges
- **on_discard examples:** the opportunity passes, or a rival colony gets it instead (`−Reputation`)

*Examples: Greenhouse, Printing Press, Communal Bath, Radio Tower*

#### Edge Cards
Offer a new connection between existing nodes — a relationship, a trade route, a supply line — that the player couldn't wire manually.

- **Unlocked by:** social milestones, external contact, legal system changes
- **on_reveal examples:** the potential connection becomes visible; characters involved may react immediately via social edges
- **on_purchase:** the edge is wired; ongoing flow begins
- **on_discard examples:** the window closes, relationship sours (`−social` between involved characters)

*Examples: Trade Route, Mentorship, Shared Infrastructure, Alliance*

#### Event Cards
Situations that demand a response. Unlike other categories, Events are not improvements — they are pressures. The player must engage with them via `on_purchase` or accept the `on_discard` consequence.

- **Unlocked by:** colony fragility, external Reputation, random chance weighted by season/era
- **on_reveal examples:** the situation begins immediately — a sick character, an arriving stranger, a broken machine
- **on_purchase:** the player's chosen response resolves the event (pay resources, assign a character, invoke a Rule node)
- **on_discard:** the event resolves badly — stat damage, character loss, Tribunal firing

*Examples: Storm Warning, Unexpected Visitor, Equipment Failure, Fever Outbreak*

#### Concept Cards
Offer a new economic, legal, or social Concept node. These are the highest-impact cards — they change how the entire graph resolves.

- **Unlocked by:** Knowledge accumulation, specific node combinations, era progression
- **on_reveal examples:** colony members react based on value alignment (`+Morale` for Theo on a communal Concept, `−Morale` for Maya)
- **on_purchase:** Concept node enters the graph; player wires it into the economic or legal layer
- **on_discard examples:** the idea is lost for this era; Knowledge cost to rediscover

*Examples: Communal Ownership, Common Law, Rotating Leadership, Market Economy, Gift Economy*

#### Character Cards
A person who wants to join the colony. Each arrives with skills, values, health, and morale — and sometimes baggage.

- **Unlocked by:** Reputation thresholds, specific node types (a Clinic attracts healers), Event outcomes
- **on_reveal examples:** the character appears at the boundary; existing members may react via social edges (alignment or friction)
- **on_purchase:** character joins, becomes a node in the graph; player assigns occupancy and labor edges
- **on_discard examples:** the person moves on; if they were highly skilled, `−Reputation` (word gets around)

*Examples: Disaffected Engineer, Traveling Medic, Young Idealist, Former Lawyer, Experienced Farmer*

#### Boon Cards
Direct windfalls — resources, stat boosts, or temporary modifiers. The simplest category but valuable as pressure relief.

- **Unlocked by:** Reputation, lucky draws, Event resolutions
- **on_reveal examples:** minor immediate benefit in some cases
- **on_purchase:** resource injection, stat boost, or temporary `+modifier` on a node
- **on_discard examples:** usually no cost — boons are the one forgiving card type, but holding them wastes a slot

*Examples: Surplus Harvest, Word Spreads (Reputation boost), Found Materials, Good Season*

### Hand Management

With only three slots, the player is always making triage decisions:

- A Node card for a building you're not ready to place yet — hold it or discard?
- An Event card with a steep `on_discard` cost — it can't be ignored, it must be played
- A Character card for someone whose values will create friction — do you want the skills badly enough?

The hand is a resource unto itself. Experienced players manage it as deliberately as they manage the graph.

---

## The Main Arc

### The Central Question

Can you maintain your founding ideals as the colony grows — or does scale, crisis, and the grain of human nature force you to compromise them one small cut at a time?

The node graph is a moral ledger. Every shortcut taken under pressure, every expedient rewiring, every tenet quietly bent is recorded in the topology. By Era 5 the graph shows you exactly when and why you drifted. The game does not punish compromise because compromise is evil — it makes the cost *visible*.

---

### The Founding Covenant

Before the first card is drawn, the player selects **2 to 4 Tenets** from a pool. These are the colony's founding principles. More tenets means a harder game — more constraints on the graph, more things the cohesion check scrutinizes.

Each Tenet is:
- A principle (the stated belief)
- A cascading rule (the graph constraint it enforces)
- A check condition (how compliance is measured at each era transition)

Tenet selection is the real character creation moment. The colony's identity — and its eventual tragedy or triumph — begins here.

#### Example Tenets

| Tenet | Cascading Rule | Check Condition |
|-------|---------------|-----------------|
| **Common Abundance** | All resource flows must pass through a Common Pool node; no private accumulation nodes | Are there any resource edges that bypass the pool? |
| **Labor is Voluntary** | No labor edge can be active without explicit Character approval | Are any labor edges assigned rather than consented? |
| **Open Doors** | Character cards can never be discarded; all who arrive must be offered a place | How many Character cards were discarded this era? |
| **Truth in Governance** | All structural graph changes must pass through a Consensus Gate | Are there any Rule bypasses recorded in Precedent nodes? |
| **No Masters** | No Character node may hold an Authority or Veto node for more than one era | Does any character currently hold persistent authority? |
| **Living Lightly** | Total node count is capped relative to population; growth must be deliberate | Does the graph exceed the population-scaled node limit? |
| **The Commons First** | External barter may only exchange surplus — nothing that would reduce any member below need | Did any barter exchange deplete a member's needs this era? |
| **Knowledge Belongs to All** | Knowledge resource may not be hoarded; it must flow to at least one other node per era | Is Knowledge accumulating in any single node without outflow? |

Some combinations are naturally compatible — *Common Abundance* and *Truth in Governance* reinforce each other. Some create internal tension — *Open Doors* and *Living Lightly* will eventually pull against each other as population grows. Players discover these tensions in play.

---

### The Five Eras

At each era transition, a **Cohesion Check** measures the colony's graph against every active Tenet. Partial compliance degrades Cohesion. Full failure of any Tenet at any check is a loss — not because the colony collapses immediately, but because it has ceased to be what it set out to be.

Passing the Era 5 check is the win condition.

---

#### Era 1 — Founding
*3 people. A clearing. A decision about what kind of place this will be.*

The graph is tiny. Basic survival nodes only: shelter, food production, a fire. The Tenets are easy to uphold because there's barely anything to violate them with. This era is about establishing the founding wiring — the Concept nodes laid here cast long shadows.

- **Card pool:** Basic Boons, simple Events, foundational Node cards
- **Primary pressure:** Physical survival — cold, hunger, injury
- **Cohesion check:** Mostly a formality. But the graph is already a record.
- **What drift looks like here:** Assigning labor without consent because someone needs to eat. A small thing. The first cut.

---

#### Era 2 — Roots
*5–10 people. The colony survived. Word is getting out.*

New characters arrive via card, each with their own values. The first external barter relationships form. The founding Concept nodes face their first real test as people who didn't choose them arrive and live under them.

- **Card pool:** Character cards, Edge cards (trade routes, mentorships), first Concept cards
- **Primary pressure:** Value friction — newcomers who didn't sign the covenant
- **Cohesion check:** Are the Tenets holding under the first wave of growth?
- **What drift looks like here:** A skilled newcomer whose values clash. You wire their labor anyway. *Just for now.*

---

#### Era 3 — Settlement
*10–25 people. A real place now, with factions.*

The graph is complex enough that single points of failure appear. Specialization creates dependency. Characters with similar values cluster, creating informal factions that may pull against the founding Concept nodes. External reputation means outsiders have opinions about you.

- **Card pool:** Specialization Node cards, legal Concept cards, diplomatic Edge cards, harder Events
- **Primary pressure:** Internal politics and graph complexity
- **Cohesion check:** The first hard check. Growth has created pressure. Where did you bend?
- **What drift looks like here:** Consensus is slow with 20 people. You grant one trusted character temporary Authority. It never quite goes away.

---

#### Era 4 — Influence
*25–60 people. Other factions want something from you.*

The colony is a known quantity. Allies and adversaries make moves. Diplomatic cards carry high stakes — good deals that require compromising a Tenet, threats that can only be answered by expedience. Internal factions may now have enough members to formally challenge the founding Concept nodes.

- **Card pool:** High-stakes diplomatic Edge cards, faction Event cards, powerful Concept cards that tempt deviation
- **Primary pressure:** External pressure meeting internal fracture
- **Cohesion check:** The reckoning. Every compromise since Era 1 is visible in the graph.
- **What drift looks like here:** A neighboring faction offers protection in exchange for adopting a Market Economy node. You need it. You wire it in. The Common Pool still exists — technically.

---

#### Era 5 — City-State
*60+ people. You built something that matters.*

Scale exposes every accumulated compromise. The founding Tenets either still govern the graph or they are vestigial — present as nodes but no longer load-bearing. The final Cohesion Check does not ask whether you survived. It asks whether what you built is still what you meant to build.

- **Card pool:** Full deck; legacy cards that reflect the colony's history
- **Primary pressure:** The weight of everything that came before
- **Cohesion check:** The win condition. Pass it and you have done something rare.
- **What winning looks like:** The graph reflects the founding covenant. The Tenets are still load-bearing. The colony reached scale without losing its soul.
- **What losing looks like:** The Tenets are there in the graph — you never formally removed them — but they govern nothing. The colony succeeded. It just isn't what you meant anymore.

---

### Loss Conditions

| Condition | What happened |
|-----------|--------------|
| **Tenet failure at any Cohesion Check** | The colony has drifted past the point of return — it is no longer what it set out to be |
| **Cohesion collapse** | Internal fracture; the colony splits or dissolves |
| **Resilience collapse** | A crisis the colony could not absorb; physical dissolution |
| **Reputation collapse** | Isolation; no cards worth drawing, no trade, no future |

---

### The Death of a Thousand Cuts

No single decision loses the game. The game is lost through accumulation — each small compromise reasonable in isolation, devastating in aggregate. The graph makes this legible: a tenet violation doesn't announce itself as a moral failure, it registers as a misrouted edge, a bypassed gate, a node that shouldn't be there. Only at the Cohesion Check does the full picture resolve.

This is the game's subject: ideals, and what the human condition does to them over time.

---

## The World

### Procedural Generation from Tenets

The world is not hand-authored. It generates from the player's founding Tenet choices, which means every playthrough produces a unique but personally legible political landscape. The player always understands the world because they created the conditions for it.

Two things are generated at game start:

1. **The Mainstream** — diametrically opposed to the player's Tenets; the world being fled
2. **The Faction Landscape** — 3 to 10 other colonies, each a different combination of the player's Tenets and mainstream values

---

### The Mainstream

Each Tenet inverts to produce a feature of the mainstream:

| Tenet | Mainstream Inverse |
|-------|--------------------|
| Common Abundance | Enforced private property; accumulation as virtue |
| Labor is Voluntary | Wage labor; debt as mechanism of control |
| Truth in Governance | Representative authority; decisions made above |
| No Masters | Entrenched hierarchy; title and rank |
| Open Doors | Border enforcement; belonging as earned status |
| Living Lightly | Expansion as progress; growth as obligation |
| The Commons First | Export economy; surplus extracted, not shared |
| Knowledge Belongs to All | Intellectual property; knowledge as competitive advantage |

The mainstream is never an ally. It does not attack directly — it exerts pressure through the card system:

- **Temptation cards** — on_reveal: a resource windfall or skilled worker; on_purchase: wire in a mainstream Concept node; on_discard: −Reputation with the mainstream but +Cohesion
- **Mainstream Character cards** — arrive highly skilled and healthy but carrying mainstream values (Hierarchy, Accumulation, Deference); their labor edges are productive but their social edges create value friction
- **Cultural drift** — in eras of low Cohesion, mainstream-valued characters can shift other characters' values over time, quietly rewriting social edges

The mainstream grows more present as the colony's Reputation rises. Success makes you visible. Visibility invites pressure.

---

### The Faction Landscape

Each faction is generated as a combination of:
- Some of the player's Tenets (the overlap — basis for alliance)
- Some mainstream values (the divergence — source of friction)
- Occasionally one unique Tenet of their own

With 3 player Tenets there are 7 possible overlap combinations (excluding the mainstream, which shares none). The game selects 3–10 of these, gives each a name, a character, and a starting Reputation score with the colony.

---

### Worked Example

**Player chooses three Tenets:**
1. *Common Abundance* — all resource flows through a Common Pool
2. *Labor is Voluntary* — no assigned labor edges
3. *Truth in Governance* — all structural changes require Consensus

**Generated Mainstream: The Outside**
Private property enforced by contract law. Wage labor normalized through debt. Elected officials govern without consensus. Skilled, comfortable, and confident it is correct. The thing you left.

**Generated Factions:**

| Faction | Shared Tenets | Divergence | Character |
|---------|--------------|------------|-----------|
| **The Stewards** | Common Abundance, Labor is Voluntary | A charismatic founder governs by instinct, no consensus | Communal and warm but quietly authoritarian; will ask you to accept their leader's judgment |
| **The Free Workers Co-op** | Labor is Voluntary, Truth in Governance | Private ownership of tools and output; market-based exchange | Democratic and voluntary but property-minded; closest natural ally, will eventually push you toward markets |
| **The Council of Neighbors** | Truth in Governance | Private property, paid labor; mainstream economics with democratic process | Reasonable, bureaucratic, baffled by your economics; useful trading partner, dangerous long-term influence |
| **The Hermitage** | None | Rejects the mainstream differently — isolationist, self-sufficient, deeply suspicious | Neither ally nor enemy; will trade sporadically; may shelter your members who leave |
| **The Adjusters** | Common Abundance | Assigned labor by committee, no individual consent, no consensus | Efficient and strange; share your economics but their governance is alarming; will offer resources with strings |
| **The Libertyfolk** | Labor is Voluntary | Full market economy, private property, no governance structure | Ideologically opposed on economics but personally compatible; respect your voluntary labor, will try to trade you into their orbit |

---

### Faction Mechanics

Each faction maintains its own Reputation score with the colony, separate from global Reputation. Faction relationships evolve through play:

- **Diplomatic Edge cards** connect the colony to factions — trade routes, mutual aid agreements, knowledge exchanges
- **Faction Character cards** — members of other factions who want to join, carrying that faction's value mix
- **Faction Event cards** — a neighboring faction in crisis, a territorial dispute, an ideological challenge
- **Pressure** — factions with low overlap will occasionally send Temptation cards that require tenet compromise to accept

High faction Reputation unlocks better barter rates, emergency support, and shared Knowledge. But close relationships with factions whose values diverge from your Tenets creates internal friction — their Character cards bring their values with them.

**Factions can drift too.** A faction that started as a partial ally may compromise its own founding values over the eras, becoming more mainstream — or more radical. The player may watch a neighbor's colony fail its own version of the Cohesion Check.

---

### The Pressure Gradient

| Source | Relationship | Mechanism |
|--------|-------------|-----------|
| **The Mainstream** | Never ally | Temptation cards, mainstream Characters, cultural drift at low Cohesion |
| **High-overlap factions** | Potential allies | Offer support; ask compromise on the one Tenet you don't share |
| **Low-overlap factions** | Trading partners / rivals | Barter relationships; may poach members via Character cards |
| **Outlier factions** | Unpredictable | Unique Tenets create unexpected alignment or conflict |

The world is not hostile. It is indifferent in a way that is harder to resist than hostility. The mainstream does not need to attack — it simply continues to exist, offering comfort, offering skill, offering the path of least resistance, one card at a time.