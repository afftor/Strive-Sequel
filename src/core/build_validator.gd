extends Reference

#checksum of the supporter code. The code itself is not stored anywhere in the build,
#and what ends up in the player's progress data is this string, not what they typed.
const CHECKSUM = "a93217a1af2ac82aa16cf3995c3a30f7ee68d4d76f135384ca26d6158a559823"


static func validate(text):
	return text.sha256_text() == CHECKSUM
