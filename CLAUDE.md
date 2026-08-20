# CLAUDE.md

Guidance for Claude when working in this repository.

`AGENTS.md` carries the same guidance for Codex. The two files overlap on purpose — when a rule here
changes, change it there too. Every path, helper and command below was verified against the working
tree on 2026-08-19; anything that could not be verified was left out rather than guessed.

## Project Basics

- Godot 3.5.1 project for Strive for Power 2.
- For command-line validation use the compatible Godot 3.5.3 executable at
  `C:\Users\1\Desktop\godot\Godot_v3.5.3-stable_win64.exe`.
- Main scene: `res://gui_modules/Universal/Modules/Menu.tscn` (`project.godot`, `run/main_scene`).
- Run from the editor by opening `project.godot` and pressing F5.
- There is no build, lint or test pipeline. Most verification is targeted inspection plus the bounded
  checks under [Verification](#verification).

## Workflow

- Use PowerShell on Windows; the Bash tool is available for POSIX scripts and takes its own syntax.
- Prefer `rg` for searching files and text.
- Inspect nearby code, scenes and data definitions before editing.
- Before adding new behaviour, check whether an existing helper already does it.
- Keep changes scoped to the request. Do not rewrite unrelated systems for cleanup.
- Preserve user edits and uncommitted work — the working tree often differs substantially from `HEAD`.
- When writing or extending narrative drafts in `helper stuff/*.txt`, first read
  `.agents/helper-event-writing-style.md` for the local drafting style.

## Load the matching skill before editing

These two project skills hold the engine knowledge that is not obvious from the code. Load the skill
*before* opening the target file, not after starting the edit:

| Touching | Load |
| --- | --- |
| `assets/data/Skills.gd`, `assets/data/Effects.gd`, `assets/data/skilldata/*.gd` — any skill, passive, status, buff, stack, trait effect, damage/defense modifier, enemy or boss ability | `strive-combat-skills` |
| `src/combat/CombatAnimations.gd`, `src/core/core_animations.gd`, `src/combat/animation_handler.gd`, or any `sfx` entry in skill data — timing, queue blocking, damage numbers, HP bars, sprite flipping, card movement | `strive-combat-animations` |

This applies however the request is phrased. "Why doesn't this ability's bonus fire?" is a skill-engine
question even though it names no file.

## Godot Files

- Treat `.tscn`, `.tres`, `.import`, `project.godot` and `export_presets.cfg` as Godot-managed formats.
- Make narrow edits to them and preserve existing formatting.
- Avoid changing resource paths unless the task needs it. Do not change export presets unless asked.
- All new or replaced game sound assets must use WAV (`.wav`); keep generator-source files outside game assets.
- Before editing a `.tscn` by hand, or doing a visual check, offer to hand the job to Codex CLI and wait
  for an explicit yes.

## UI Helpers

- Prefer the tooltip helpers in `src/core/globals.gd` over ad hoc `hint_tooltip` wiring:
  `globals.connecttexttooltip`, `connectitemtooltip_v2`, `connectskilltooltip`, `connectmaterialtooltip`,
  `connectslavetooltip`, `disconnect_text_tooltip`.
- For dynamic UI lists, prefer `input_handler.ClearContainer` and `input_handler.DuplicateContainerTemplate`
  (`src/core/input_handler.gd`) over manually duplicating template nodes and clearing children. Use
  `ClearContainerForced` only when the template-preserving clear is wrong, and `append_not_duplicate` for
  arrays that must not receive duplicates.
- Any animation that moves a combat card or portrait must return it to its original position before the
  animation ends. Use the original transform as the baseline and verify repeated playback does not drift.
- Never place a combat effect *behind* a fighter portrait — the icons are opaque, so nothing shows. Put the
  effect on top, or between the icon and its frame. If it must read as "under" the card, move it outside the
  portrait rectangle (below the bottom edge, wider than the sides).

## Localization

- All display text goes through localization keys and `tr()`, never hardcoded strings.
- Localization files live in `localization/<lang>/main.gd`; the language folders are `en`, `es`, `fr`, `it`,
  `ru`, `zh`.
- Only edit `localization/en/main.gd` unless explicitly asked for another language. Do not add text to
  non-English files as a fallback, placeholder, mirror or convenience copy. Locale stubs the game itself
  writes on launch are fine — leave them alone.
- `localization/en/main.gd` is very large; never read it in full. Use `rg` to locate keys, then read context.
- Before adding or renaming data with generated display text, inspect the code that derives its keys and
  verify every required key exists. Preserve the source code verbatim in generated keys (including
  underscores) and confirm with targeted `rg` searches.

## Event Rules

When writing or modifying `assets/data/events/*.gd` or `assets/data/scenedata.gd`:

- Put player-facing text behind localization keys in `localization/en/main.gd`.
- Assign character sprites whenever a character is present.
- `"Close"` ends the interaction. `"Continue"` advances within a flow. `"(return to root)"` must name an
  explicit destination. `"(on either)"` marks an instant transition, not sequential branching.
- Character speech uses yellow colour tags for the primary speaker, aqua for secondary speakers.
- Quest step descriptions say what the player must do to advance, not merely what happened.
- Put player-visible mechanical effects (stat, trait, money, material, reputation, relationship changes) on
  the option that transitions into the result scene, or in that guaranteed result scene's `common_effects`,
  so automated feedback appears in the result text.
- Never leave a feedback-relevant effect on a `"Close"` option. For conditional outcomes keep each effect on
  its matching transition or variation-level `common_effects`; use shared `common_effects` only when every
  route through the scene receives the same effect.

When adapting existing events:

- Flag likely issues first: missing transitions, dead-end loops, missing text, ambiguous instructions.
- Combat without an explicit defeat outcome assumes defeat means game over.
- Preserve em dashes in dialogue text.
- Verify every branch has an explicit exit or return.

Scoring relationship changes in a questline: only score decisive treatment choices — options that lead to
structurally different outcomes (different consequences, or gating whether a character stays, leaves or is
harmed). Leave purely cosmetic option pairs unscored, and do not gate minor same-scene reply variants behind
a new persistent decision flag.

## Conditions and Effects

The schema has several naming traps:

- Character conditions checked by `CharacterClass.checkreqs()` (`src/character/CharacterClass.gd:1837`) use
  discriminator `code`.
- Global conditions checked by `globals.checkreqs()` (`src/core/globals.gd:2973`) use discriminator `type`.
- Effects in `common_effects` and `bonus_effects` use discriminator `code`.
- The operator field is always `operant`, never `operand`.
- Interaction scenes have their own `checkreqs` at `src/interaction_member.gd:559` — check which one a call
  site actually reaches before assuming the schema.

Common field-name exceptions:

```gdscript
{code = 'stat', stat = 'charm_factor', operant = 'gte', value = 4}
{code = 'has_profession', profession = 'rogue', check = true}
{code = 'race', race = 'elf', check = true}
{code = 'trait', trait = 'brave', check = true}
{code = 'has_status', status = 'poisoned', check = true}
{type = 'faction_reputation', code = 'mages', operant = 'gte', value = 2000}
{type = 'has_upgrade', name = 'upgrade_code', value = 1}
{type = 'decision', value = 'PrincessDead', check = true}
{type = 'quest_stage', name = 'quest_id', value = 3, operant = 'gte'}
{type = 'has_items', name = 'itembase', operant = 'gte', value = 1}
{code = 'reputation', name = 'mages', operant = '+', value = 100}
{code = 'progress_quest', value = 'quest_id', stage = 'stage_name'}
{code = 'start_combat', value = 'enemy_group_id'}
```

Quick field map:

| What | Field |
| --- | --- |
| Stat name, character condition | `stat` |
| Profession name | `profession` |
| Race id | `race` |
| Trait id | `trait` |
| Status id | `status` |
| Faction id, global condition | `code` |
| Faction id, reputation effect | `name` |
| Upgrade code | `name` |
| Quest id | `name` |
| Item base | `name` |
| Hero code | `name` |
| Decision id | `value` |
| Character code, `unique_character_changes` | `value` |

## Verification

- Run the smallest relevant check after code edits.
- If a check cannot be run locally, say why.
- For gameplay, UI or data changes, describe the specific behaviour that was inspected or verified.

### Every check must end on its own

Never run — and never write — a check that can sit waiting forever. A command that needs a human to close a
window, press a key or answer a prompt is not a check; it is a hang, and whoever started it is stuck until
somebody notices. Kill any process a check leaves behind.

- Launching a Godot scene plainly (`Godot.exe --path <project> res://.../foo.tscn`) **never exits**. The game
  opens and waits for a player. Do not use that as verification.
- **The mansion scenes currently have no self-test flag.** `mansion_view.gd` had a `--mansion-selftest` hook
  at `HEAD`, but the working-copy rewrite of that file removed it along with `in_test_mode`. Check that the
  hook exists before citing it; do not assume it does.
- A new self-test must always reach its own end: no waiting on input, no unbounded retry loop. If it needs
  something that may never arrive, bound the attempts and report what it saw.
- Where no flag exists, put a hard time limit on the command and read the cutoff as the end of the check,
  not as a failure.

### Keep time limits short

Give every command the shortest limit that plausibly fits it. A long limit is only for a check you
actually expect to run that long, and the expectation has to be one you can state.

- `timeout` is wall-clock only. It never detects a hang: it fires on a busy process exactly as it fires
  on a stuck one, and exit `124` looks the same in both cases. The limit is the only thing standing
  between a hung command and minutes of the user's time.
- Default for anything that could block: 30 s. The bounded Godot boot (~20 s to the menu): 60 s. Past
  ~120 s only when you can name the reason, such as a full catalogue rebuild or a driven run across
  several in-game days. Plain `rg`, `git` and file reads need no wrapper at all.
- Wrap as `timeout -k 5s <sec> <cmd>` so a process that ignores SIGTERM still dies.
- When a limit trips, read the output before raising it. Output flowing right up to the cutoff means the
  limit was too low; output that stopped early means a real hang, and a bigger number will not help.
- Never raise the limit twice for the same command. If the second attempt trips as well, the check is
  wrong, not slow.
- In PowerShell, `timeout` is **not** the coreutils tool: it resolves to `C:\WINDOWS\system32\timeout.exe`,
  which waits for a keypress and hangs the session. Bash tool only. In PowerShell use
  `$p.WaitForExit(<ms>)` with `$p.Kill()`.

### Checks that do terminate

```powershell
& "C:\Users\1\Desktop\godot\Godot_v3.5.3-stable_win64.exe" --no-window --quit --path "C:\Users\1\Desktop\godot\Strive-Sequel"
```

Boots to the menu in ~20 s, runs one frame and exits. It surfaces parse errors in every autoload and anything
they `preload`, so clean output means those scripts really parse. This is the cheap "does it compile" test.

`--check-only` parse checks are near-useless here: autoload singletons are unregistered in that mode, so every
script reports cascading "identifier isn't declared" errors.

Other entry points that exist and quit by themselves:

- `--anim-plan <file>` — combat animation autopilot (`src/combat/anim_autopilot.gd`).
- `--update-contract`, `--dry-run` — doll2 catalogue builder CLI
  (`Character_generator/Doll2Spine/doll2_catalogue_build_cli.gd`).
- `--lab-selftest`, `--lab-shot` — the combat lab, which is a *separate* project at
  `C:\Users\1\Desktop\godot\ConquestCombatTesting` mounted onto this repo by directory junctions. Never open
  both projects in the Godot editor at once; they share the import cache.

### Headless harnesses

For unit-style checks — parse a scene script, assert a node path exists, sample per-frame state — write an
`extends SceneTree` harness and run `<godot.exe> --no-window --path <repo> -s user://foo.gd`.

- **Never create scratch, probe or verification files inside the project tree**, even temporarily and even if
  cleaned up afterwards. The user dir is `C:\Users\1\AppData\Roaming\Strive for Power 2` (the project sets
  `use_custom_user_dir=true`), which is the right place. Delete the harness when done — leftovers accumulate
  there.
- The harness script itself is parsed before globals are bound, so bare `input_handler` / `ResourceScripts`
  is a parse error inside it; use `get_root().get_node("input_handler")`. Scripts loaded *from* the harness
  use the bare names fine.
- Define `func _idle(_delta)`, count frames, and `quit()` when done.
- Synthetic keyboard input is reliable: build an `InputEventKey` and `Input.parse_input_event(ev)`. Synthetic
  mouse input under `--no-window` lands maybe half the time — send it on several consecutive frames and treat
  a miss as plumbing, not logic.

### Hazards when driving the real game

- `MansionMainModule.tscn` ships with `test_mode = true` and `_ready` acts on it whenever
  `OS.has_feature('editor')`. `globals.LoadGame` instantiates the mansion *after* deserializing, so loading a
  save from the editor build re-runs `test_mode()` → `make_world()` and clobbers the save you just loaded. Set
  `test_mode = false` in the scene first and `git checkout` it afterwards.
- `C:\Users\1\AppData\Roaming\Strive for Power 2\saves` holds real saves and `autosave_frequency = 1` rotates
  them every in-game day. Back the folder up before any driven run and restore it after.
- `input_handler.globalsettings` is the real persisted config (`%APPDATA%\Strive for Power 2\Settings.ini`,
  written on exit). A probe that changes a setting keeps that value in the user's install. Back it up too.
- A run of character creation or the mansion generates portrait PNGs in `user://userportraits` for its
  throwaway characters. Delete the ones the run created.

## Git

- Do not create commits unless asked.
- Do not reset, checkout or discard changes unless explicitly asked.
- Before reporting completion, mention any files changed by the task.
