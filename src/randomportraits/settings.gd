extends Node

# Settings used by the mod. Can change these and the new values will be used the next time the game runs.

# Whether to print some debug statements. Can help diagnose portrait selection. Set to true/false
var debug = false

# Number of seconds before cache expires. Will only scan portrait folder if this much time
# has elapsed since last scan, and a new request for a random portrait occurs.
var cacheExpiration = 300

# Minimum number of portraits that need to match. Set to -1 to disable.
var minMatch = 2
# For Race, will abort setting portrait.
# For Race+Gender, will abort setting portrait.
# For Race+Gender+Age,  will first try and relax the matching:
# Adult: Will accept teen, if not enough, wll abort.
# Teen: Will accept Child.  If still not enough, will accept Adult. Still not enough, abort.
# Child: Will accept Teen. If still not enough, will abort.

# Base weight all portraits get. Change to 0 to require matching at least 1 attribute.
var base_weight = 1
# Weight assigned to the given attribute. 
var haircolor_weight = 70
var skincolor_weight = 20
var titsize_weight = 100
var asssize_weight = 20

# The higher the weight for a portrait, the higher the chance it will be chosen.
# Combined weight is the multication of each matching weight. Thus if an attribute
# has a weight of 20, then it is 20x more likely to be chosen if it matches compared
# to a portrait that does not match that attribute.
# However, if you have only a handful that match an attribute and a lot that don't, 
# then you may see a non-matching get selected fairly often. For example, if 1 black
# hair portrait, and 20 non-black hair, with a weight of 20 and all other attributes
# identical, you'd expect to get that 1 black hair portrait half the time, and one of 
# the other 20 the other half of the time.

