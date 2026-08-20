# What the old paperdoll does

Read off `Character_generator/generator_data.gd` and `ragdoll_builder.gd` before the
new doll replaced them, because none of it is written down anywhere else and the
files themselves are meant to go. This is a record of behaviour, not of art: which
character stat drives which part of the doll, what the fallbacks are, and which
parts are tied to each other.

## How a character reaches the doll

`rebuild(character)` walks `GeneratorData.stats_to_look` in order and, for each
stat, looks the character's value up in `GeneratorData.transforms[stat]`. A value
with no entry is skipped silently. It runs twice: textures first, everything else
second, so a part is never positioned before it exists.

Operations a transform can carry:

| type | what it does |
| --- | --- |
| `texture` | puts an image on one node |
| `texture_set` | applies a whole named set of images at once (the race bodies) |
| `node_attr` | writes one property on one node - visibility, `z_index`, position |
| `node_group_attr` | writes one property on every node of a group |
| `node_group_select` | shows one node of a group and hides its siblings (the poses) |
| `offset` | moves the whole doll |

## Clothing

Clothing is not a stat the character stores. `CharacterClass.get_stat` derives it
from what is equipped, and the derivation carries rules that have to survive the
port:

```
armor_base   <- the itembase equipped in `chest`
               hector_armor   -> chest_base_metal
               garb_of_forest -> chest_base_leather
               nothing, and the character is not on nudity duty -> underwear
               anything the doll has no entry for -> servant
armor_lower  <- the itembase equipped in `legs`, same rules
armor_*_underwear <- the itembase equipped in `underwear`
               nothing, and not on nudity duty -> underwear
               on nudity duty -> nothing at all
armor_collar <- `neck`,  armor_weapon <- `rhand`,  armor_head <- `head`
               anything unknown -> nothing (these do not degrade to a default)
```

`rebuild_cloth(false)` strips the character but **keeps the collar**: the loop
skips every armour stat except `armor_collar` when the doll is undressed. A
collar is worn on a naked slave on purpose.

## Parts that are tied to each other

- **Sex picks the skeleton.** `sex` selects one of two whole node trees
  (`male_pose` / `Female_pose`) and moves the doll 30 px down for the male one.
  `futa` is the female tree with the penis shown.
- **The penis carries its testicles.** They are one bundle; the type also decides
  which testicle art is used.
- **Race is a texture set, not a part.** Each of the 33 races applies a whole set
  of body images and toggles the `human` / `nonhuman` node groups. Ears, horns,
  tail and wings are separate stats on top of it.
- **Pregnancy re-orders the belly.** Dressing the doll pushes `Pregnancy` and
  `Pregnancy2` to `z_index` 6 so the belly draws over the clothes; undressing puts
  them back to 0.
- **Extra nipples are a setting, not only a stat.** `multiple_tits_developed` is
  forced to false when `input_handler.globalsettings.furry_multiple_nipples` is off.
- **Hair is four independent layers**, each with its own style, two colours and a
  length: base, fringe, back, assist.
- **Stat links.** `GeneratorData.stats_links` says which stats have to be re-applied
  together: changing skin colour also re-applies ear, tail and lip colour; changing
  the first hair colour re-applies the fringe colour and the ear and tail colour;
  changing height re-applies everything (`full`); personality re-applies the pose.

## Every stat the doll reads, and what it accepts

| stat | values |
| --- | --- |
| `cloth` | `true`, `false` |
| `sex` | `male`, `female`, `futa` |
| `race` | `Human`, `Elf`, `TribalElf`, `DarkElf`, `Orc`, `Goblin`, `Kobold`, `Gnome`, `Dwarf`, `Fairy`, `Dryad`, `Demon`, `Seraph`, `Dragonkin`, `Centaur`, `Harpy`, `Taurus`, `Ratkin`, `Slime`, `Lamia`, `Arachna`, `Scylla`, `Nereid`, `BeastkinCat`, `BeastkinWolf`, `BeastkinFox`, `BeastkinBunny`, `BeastkinTanuki`, `HalfkinCat`, `HalfkinWolf`, `HalfkinFox`, `HalfkinBunny`, `HalfkinTanuki` |
| `ears` | `cat`, `fox`, `wolf`, `tanuki`, `rat`, `bunny`, `bunny_standing`, `bunny_drooping`, `elven`, `demon`, `feathered`, `cow`, `goblin`, `orcish`, `normal`, `fish` |
| `eye_tex` | `eyes1`, `eyes2`, `eyes3`, `eyes4`, `eyes5`, `eyes1m`, `eyes2m`, `eyes3m`, `eyes4m`, `eyes5m` |
| `eye_color` | `blue`, `cyan`, `brown`, `green`, `pink`, `purple`, `red`, `yellow`, `grey`, `black` |
| `body_color_lips` | `blue`, `cyan`, `brown`, `green`, `pink`, `purple`, `red`, `yellow`, `grey`, `black` |
| `horns` | `short`, `curved`, `straight`, `dragon`, `curved_top`, `curved_down`, `spiral`, `spiral_2` |
| `wings` | `demon`, `dragon`, `fairy`, `seraph` |
| `tail` | `cat`, `demon`, `dragon`, `dragon2`, `cow`, `fox`, `rat`, `tanuki`, `wolf`, `kobold`, `fish` |
| `penis_type` | `human`, `furry`, `feline`, `canine`, `equine` |
| `pregnancy_status` | `no`, `early`, `heavy` |
| `multiple_tits_developed` | `true`, `false` |
| `tits_size` | `flat`, `small`, `average`, `average_high`, `average_narrow`, `average_wide`, `big`, `big_high`, `big_narrow`, `huge`, `huge_high`, `huge_narrow`, `huge_wide`, `masculine` |
| `skin_coverage` | `feathers`, `plant`, `fur_orange`, `fur_orange_white`, `fur_striped`, `fur_white`, `fur_grey`, `fur_brown`, `fur_black`, `scale`, `scale2`, `scale3`, `kobold`, `fur_tricolor` |
| `body_color_skin` | `blue1`, `blue2`, `blue3`, `blue4`, `blue5`, `grey1`, `grey2`, `grey3`, `grey4`, `grey5`, `green1`, `green2`, `green3`, `green4`, `green5`, `human1`, `human2`, `human3`, `human4`, `human5`, `human6`, `human7`, `pink1`, `pink2`, `pink3`, `pink4`, `pink5`, `purple1`, `purple2`, `purple3`, `purple4`, `purple5`, `red1`, `red2`, `red3`, `red4`, `red5`, `yellow1`, `yellow2`, `yellow3`, `yellow4`, `yellow5` |
| `body_color_wings` | `blue1`, `blue2`, `blue3`, `brown1`, `brown2`, `brown3`, `orange1`, `orange2`, `orange3`, `dark1`, `dark2`, `dark3`, `green1`, `green2`, `green3`, `cyan1`, `cyan2`, `cyan3`, `pink1`, `pink2`, `pink3`, `purple1`, `purple2`, `purple3`, `red1`, `red2`, `red3`, `white1`, `white2`, `white3`, `yellow1`, `yellow2`, `yellow3` |
| `body_color_ears` | `blue1`, `blue2`, `blue3`, `brown1`, `brown2`, `brown3`, `orange1`, `orange2`, `orange3`, `dark1`, `dark2`, `dark3`, `green1`, `green2`, `green3`, `cyan1`, `cyan2`, `cyan3`, `pink1`, `pink2`, `pink3`, `purple1`, `purple2`, `purple3`, `red1`, `red2`, `red3`, `white1`, `white2`, `white3`, `yellow1`, `yellow2`, `yellow3` |
| `body_color_tail` | `blue1`, `blue2`, `blue3`, `orange1`, `orange2`, `orange3`, `brown1`, `brown2`, `brown3`, `dark1`, `dark2`, `dark3`, `green1`, `green2`, `green3`, `cyan1`, `cyan2`, `cyan3`, `pink1`, `pink2`, `pink3`, `purple1`, `purple2`, `purple3`, `red1`, `red2`, `red3`, `white1`, `white2`, `white3`, `yellow1`, `yellow2`, `yellow3` |
| `body_color_animal` | `blue1`, `blue2`, `blue3`, `orange1`, `orange2`, `orange3`, `brown1`, `brown2`, `brown3`, `dark1`, `dark2`, `dark3`, `green1`, `green2`, `green3`, `cyan1`, `cyan2`, `cyan3`, `pink1`, `pink2`, `pink3`, `purple1`, `purple2`, `purple3`, `red1`, `red2`, `red3`, `white1`, `white2`, `white3`, `yellow1`, `yellow2`, `yellow3` |
| `body_color_horns` | `blue1`, `blue2`, `blue3`, `brown1`, `brown2`, `brown3`, `orange1`, `orange2`, `orange3`, `dark1`, `dark2`, `dark3`, `green1`, `green2`, `green3`, `cyan1`, `cyan2`, `cyan3`, `pink1`, `pink2`, `pink3`, `purple1`, `purple2`, `purple3`, `red1`, `red2`, `red3`, `white1`, `white2`, `white3`, `yellow1`, `yellow2`, `yellow3` |
| `beard` | `no`, `style1`, `style2`, `style3`, `style4`, `style5`, `style6`, `style7`, `style8`, `style9`, `style10`, `style11`, `style12` |
| `hair_facial_color` | `blue_1`, `blue_2`, `blue_3`, `brown_1`, `brown_2`, `brown_3`, `orange_1`, `orange_2`, `orange_3`, `dark_1`, `dark_2`, `dark_3`, `green_1`, `green_2`, `green_3`, `cyan_1`, `cyan_2`, `cyan_3`, `pink_1`, `pink_2`, `pink_3`, `purple_1`, `purple_2`, `purple_3`, `red_1`, `red_2`, `red_3`, `white_1`, `white_2`, `white_3`, `yellow_1`, `yellow_2`, `yellow_3` |
| `hair_base` | `lion`, `back`, `braids`, `default`, `dopple`, `fringe`, `fringe2`, `irokez`, `kare`, `lamb`, `parting`, `straight`, `undercut` |
| `hair_fringe` | `dopple`, `irokez`, `lion`, `parting`, `undercut`, `back`, `braids`, `default`, `fringe`, `kare`, `lamb`, `straight` |
| `hair_assist` | `braid`, `bun`, `pigtails`, `ponytail`, `ponytail_2`, `ponytail_3`, `twin_tails`, `twin_tails_2`, `twin_tails_3`, `twin_tails_4`, `twin_tails_5` |
| `hair_back` | `care`, `dishevel`, `double_tail`, `ponytail_long`, `spiral`, `straight`, `twin_braids`, `wave`, `very_long` |
| `hair_base_color_1` | `blue_1`, `blue_2`, `blue_3`, `brown_1`, `brown_2`, `brown_3`, `orange_1`, `orange_2`, `orange_3`, `dark_1`, `dark_2`, `dark_3`, `green_1`, `green_2`, `green_3`, `cyan_1`, `cyan_2`, `cyan_3`, `pink_1`, `pink_2`, `pink_3`, `purple_1`, `purple_2`, `purple_3`, `red_1`, `red_2`, `red_3`, `white_1`, `white_2`, `white_3`, `yellow_1`, `yellow_2`, `yellow_3` |
| `hair_fringe_color_1` | `blue_1`, `blue_2`, `blue_3`, `brown_1`, `brown_2`, `brown_3`, `orange_1`, `orange_2`, `orange_3`, `dark_1`, `dark_2`, `dark_3`, `green_1`, `green_2`, `green_3`, `cyan_1`, `cyan_2`, `cyan_3`, `pink_1`, `pink_2`, `pink_3`, `purple_1`, `purple_2`, `purple_3`, `red_1`, `red_2`, `red_3`, `white_1`, `white_2`, `white_3`, `yellow_1`, `yellow_2`, `yellow_3` |
| `hair_back_color_1` | `blue_1`, `blue_2`, `blue_3`, `brown_1`, `brown_2`, `brown_3`, `orange_1`, `orange_2`, `orange_3`, `dark_1`, `dark_2`, `dark_3`, `green_1`, `green_2`, `green_3`, `cyan_1`, `cyan_2`, `cyan_3`, `pink_1`, `pink_2`, `pink_3`, `purple_1`, `purple_2`, `purple_3`, `red_1`, `red_2`, `red_3`, `white_1`, `white_2`, `white_3`, `yellow_1`, `yellow_2`, `yellow_3` |
| `hair_assist_color_1` | `blue_1`, `blue_2`, `blue_3`, `brown_1`, `brown_2`, `brown_3`, `orange_1`, `orange_2`, `orange_3`, `dark_1`, `dark_2`, `dark_3`, `green_1`, `green_2`, `green_3`, `cyan_1`, `cyan_2`, `cyan_3`, `pink_1`, `pink_2`, `pink_3`, `purple_1`, `purple_2`, `purple_3`, `red_1`, `red_2`, `red_3`, `white_1`, `white_2`, `white_3`, `yellow_1`, `yellow_2`, `yellow_3` |
| `hair_base_color_2` | `blue_1`, `blue_2`, `blue_3`, `brown_1`, `brown_2`, `brown_3`, `orange_1`, `orange_2`, `orange_3`, `dark_1`, `dark_2`, `dark_3`, `green_1`, `green_2`, `green_3`, `cyan_1`, `cyan_2`, `cyan_3`, `pink_1`, `pink_2`, `pink_3`, `purple_1`, `purple_2`, `purple_3`, `red_1`, `red_2`, `red_3`, `white_1`, `white_2`, `white_3`, `yellow_1`, `yellow_2`, `yellow_3` |
| `hair_fringe_color_2` | `blue_1`, `blue_2`, `blue_3`, `brown_1`, `brown_2`, `brown_3`, `orange_1`, `orange_2`, `orange_3`, `dark_1`, `dark_2`, `dark_3`, `green_1`, `green_2`, `green_3`, `cyan_1`, `cyan_2`, `cyan_3`, `pink_1`, `pink_2`, `pink_3`, `purple_1`, `purple_2`, `purple_3`, `red_1`, `red_2`, `red_3`, `white_1`, `white_2`, `white_3`, `yellow_1`, `yellow_2`, `yellow_3` |
| `hair_back_color_2` | `blue_1`, `blue_2`, `blue_3`, `brown_1`, `brown_2`, `brown_3`, `orange_1`, `orange_2`, `orange_3`, `dark_1`, `dark_2`, `dark_3`, `green_1`, `green_2`, `green_3`, `cyan_1`, `cyan_2`, `cyan_3`, `pink_1`, `pink_2`, `pink_3`, `purple_1`, `purple_2`, `purple_3`, `red_1`, `red_2`, `red_3`, `white_1`, `white_2`, `white_3`, `yellow_1`, `yellow_2`, `yellow_3` |
| `hair_assist_color_2` | `blue_1`, `blue_2`, `blue_3`, `brown_1`, `brown_2`, `brown_3`, `orange_1`, `orange_2`, `orange_3`, `dark_1`, `dark_2`, `dark_3`, `green_1`, `green_2`, `green_3`, `cyan_1`, `cyan_2`, `cyan_3`, `pink_1`, `pink_2`, `pink_3`, `purple_1`, `purple_2`, `purple_3`, `red_1`, `red_2`, `red_3`, `white_1`, `white_2`, `white_3`, `yellow_1`, `yellow_2`, `yellow_3` |
| `hair_base_length` | `bald`, `default`, `long`, `middle`, `short` |
| `hair_fringe_length` | `bald`, `default`, `middle`, `long`, `short` |
| `hair_back_length` | `default`, `middle`, `long`, `short` |
| `hair_assist_length` | `default`, `middle`, `long`, `short` |
| `height` | `tiny`, `petite`, `short`, `average`, `tall`, `towering` |
| `ass_size` | `flat`, `small`, `average`, `big`, `huge`, `masculine` |
| `chin` | `default`, `curve`, `kobold`, `kobold_2`, `small`, `skinny`, `male`, `muscle`, `short`, `beastkin` |
| `eyeshape` | `face1`, `face2`, `face3`, `face4`, `face5` |
| `nose` | `beastkin`, `default`, `dwarf`, `kobold`, `small`, `straight` |
| `eyebrows` | `style1`, `style2`, `style3`, `style4`, `style5`, `style6`, `style7` |
| `lips` | `none`, `style1`, `style2`, `style3`, `style4`, `style5`, `orcish`, `beastkin_cry`, `beastkin_open`, `beastkin_smile` |
| `armor_base` | `underwear`, `lacy_underwear`, `seethrough_underwear`, `servant`, `jacket`, `latex_suit`, `service_suit`, `worker_outfit`, `craftsman_suit`, `tentacle_suit`, `chest_base_cloth`, `chest_adv_cloth`, `chest_base_leather`, `chest_adv_leather`, `chest_base_metal`, `chest_adv_metal` |
| `armor_lower` | `underwear`, `lacy_underwear`, `seethrough_underwear`, `servant`, `jacket`, `latex_suit`, `worker_outfit`, `craftsman_suit`, `tentacle_suit`, `legs_base_cloth`, `legs_adv_cloth`, `legs_base_leather`, `legs_adv_leather`, `legs_base_metal`, `legs_adv_metal` |
| `armor_collar` | `amulet_of_recognition`, `leather_collar`, `service_suit` |
| `armor_weapon` | `cali_heirloom`, `cali_heirloom_active`, `holy_sword`, `sword`, `swordadv`, `dagger`, `club`, `mace`, `holy_spear`, `spearadv`, `spear`, `aire_bow`, `bowadv`, `bow`, `staff`, `staffadv`, `battleaxe`, `maceadv`, `crossbow`, `crossbowadv` |
| `armor_head` | `mask`, `foxmask`, `pet_suit` |
| `armor_color` | `default`, `default_leather`, `default_metal`, `default_underwear` |
| `armor_color_base` | `default`, `default_leather`, `default_metal`, `default_underwear` |
| `armor_color_lower` | `default`, `default_leather`, `default_metal`, `default_underwear` |
| `armor_color_collar` | `default`, `default_leather`, `default_metal`, `default_underwear` |
| `armor_color_weapon` | `default`, `default_leather`, `default_metal`, `default_underwear` |
| `pose` | `kind`, `shy`, `bold`, `pose4`, `pose5`, `pose6` |

## Where it was shown

Eight screens instanced `ragdoll.tscn` directly: character creation, character
info, the body tab, the full slave info of exploration, dating, interaction, the
gear screen and the mansion slave list. Each one clipped it with a `Light2D` in
mask mode over items on light layer 4 - see the note on clipping in the port.

## What the new doll needs that the character does not store yet

The old stats carry over unchanged wherever the two dolls agree - race, ears,
horns, tail, wings, hair (four layers, two colours and a length each), eyes,
brows, lips, nose, chin, skin colour and coverage, breast size, pregnancy,
height, and the derived armour slots. The list below is only what is new.

| new stat | values | why |
| --- | --- | --- |
| `doll` | `female`, `male` | there are two skeletons now, and they are not interchangeable. It follows `sex`, except that a femboy body needs the male one. |
| `body_shape` | `male`, `femboy` | the male art is cut for two builds and several sets carry a chest for each. Female dolls ignore it. |
| `hand_pose` | `1`, `2`, `3` | the hand the doll holds; the old rig had one hand per side. |
| `tattoo` | a part id or none | 20 pieces of tattoo art the old doll could not show at all. |
| `face_markings` | a part id or none | cheek scales and kobold spots. The old doll had them welded into the race overlay, so they could not be worn without the whole body. |
| `build`, `waist`, `shoulders`, `arms`, `legs`, `hips` | 0.8 - 1.4, default 1.0 | how heavy or slight a character is, on top of the height tier. The old doll had `ass_size` alone. |
| `hair_length`, `fringe_length`, `hair_assist_length` | 0.6 - 1.8, default 1.0 | the old doll had four length presets per layer; these are continuous, and the base and back layers now share one. |
| gear zone colours | three colours per gear channel | the old doll picked one of four preset materials per item (`armor_color_*`). Every gear part now carries three independently coloured zones. |
| `ears_zone_colours`, `wings_zone_colours`, `animal_zone_colours` | three colours each | the same for ear linings, wing membranes and animal bodies, which the old doll coloured with one value each. |
| `coverage` and its colours | pattern id plus a colour per layer | replaces `skin_coverage`; the pattern is the same art, but each layer takes its own colour now. |

Two old stats have no counterpart and should stop being read once the port is
done: `pose` (poses are not authored yet) and `beard` (the new export has no
beard art at all - it is the one content gap against the old doll).

## Where the new stats go, and what happens to saved characters

Character data lives in `src/character/statlist.gd` as templates, and
`ch_stats.gd` copies a template per character. `statdata.gd` declares each stat
separately (`code`, `tags`, `default_bonus`).

**Adding a stat is safe for existing saves.** `ch_stats.deserialize` walks the
*template's* keys and takes the saved value only when there is one:

```gdscript
for stat in statlist:
    if savedict.statlist.has(stat):
        statlist[stat] = savedict.statlist[stat]
```

A key the save has never heard of therefore keeps its template default, and a key
the template has dropped is ignored. No migration pass is needed for anything
added to `template_direct`, `sex_binded_exterior`, `metrics`, `piercing` or
`armor_color`.

**Two dictionaries do not work that way.** `pregnancy` and `tattoo` are taken
from the save whole:

```gdscript
pregnancy = savedict.pregnancy.duplicate()
tattoo = savedict.tattoo.duplicate()
```

An entry added to either of those will simply be absent on every character loaded
from an older save, and reading it returns nothing rather than the default. If
the new doll needs a field there, deserialize has to merge them against the
template first - a three-line change, but it has to be made deliberately.

**What the character already carries that the old doll never showed.** The tattoo
dictionary has eight slots (`tattoo_face`, `tattoo_neck`, `tattoo_arms`,
`tattoo_legs`, `tattoo_chest`, `tattoo_crotch`, `tattoo_waist`, `tattoo_ass`) and
the old doll rendered none of them. The new art covers one of the eight - the
womb tattoos, which answer `tattoo_crotch`; the other seven have no art yet.

**Where each new stat belongs:**

| stat | template | default |
| --- | --- | --- |
| `doll` | `template_direct` | derived from `sex`, stored so a femboy can override it |
| `body_shape` | `sex_binded_exterior` | `male` on male dolls, unused on female |
| `hand_pose` | `template_direct` | `1` |
| `face_markings` | `template_direct` | `''` |
| `build`, `waist`, `shoulders`, `arms`, `legs`, `hips` | `metrics` | `1.0` |
| gear zone colours | `armor_color` | three per slot, replacing the single preset |

`tattoo_crotch` needs no new stat, only a doll that reads it.
