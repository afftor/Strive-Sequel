extends Node

#The upgrade tree is gone. Everything it sold is stood up on the mansion plan instead: the
#workshops and their tools, a bathhouse, a practice room with somewhere for a tutor, and the
#buildings out on the estate grounds. What it sold and could not become a room - builder
#crews and their tools, farm slots, the exotic trader's stock - is simply gone; nothing reads
#those codes any more.
#
#The dictionary stays, empty, because a save made before this still names the old codes and
#every reader asks it with .has() first. game_res.convert_room_tree_upgrades() hands those
#old purchases to the rooms that replaced them, and fix_serialization() sweeps the rest away.
var upgradelist = {}
