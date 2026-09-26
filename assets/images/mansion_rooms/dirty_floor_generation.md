# Dirty floor

Generated with the built-in image_gen tool, then resized in Godot to the original 80 × 80 atlas region. The builder displays it at the same 64 × 64 repeat size as the clean floor.

Source crop: `floor_tiles_clean_reference.png`, copied from `house_layout_atlas.png`, rectangle (400, 320, 80, 80).
Generated original: `floor_dirty_generated.png`.
Runtime atlas: `room_dirty_floor_atlas.png`.
Builder item: `floor_tiles_dirty`.

## Generation prompt

Use case: precise-object-edit. Edit target: attached square top-down game floor tile. Create a dirty abandoned version of this EXACT floor, preserving the same stone tile grid positions, scale, straight overhead view and muted gray pixel-art style. Add irregular accumulated brown earth, dusty grime, dark stains and tiny grit ON TOP of the existing stone, concentrated unevenly in grout and several soft patches, while keeping most stone slabs recognizable. This is a seamless repeatable floor texture for ruined mansion rooms: match opposing edges, uniform ambient lighting, no vignette, no perspective, no walls, no furniture, no large debris, no text. Fill the entire square canvas with the floor. Opaque texture. Preserve the original geometry and approximately 3x3 slab layout, do not increase the number of slabs.
