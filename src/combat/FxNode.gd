extends Node2D
#What the drawn combat effects share: the kit of atlas, shaders and baked textures, textures baked off screen one a
#frame, batched meshes, and the small shapes, sparks and flares they are made of.
#No _process or _exit_tree here: Godot 3 runs those in every class of the chain.

#the atlas the meshes are drawn with: a soft disc, a dense disc and a white patch
const UV_SOFT = Rect2(0.5 / 80.0, 0.5 / 32.0, 31.0 / 80.0, 31.0 / 32.0)
const UV_PUFF = Rect2(36.5 / 80.0, 0.5 / 32.0, 31.0 / 80.0, 31.0 / 32.0)
const UV_WHITE = Vector2(76.0 / 80.0, 0.5)
const SOFT_PX = Rect2(0.5, 0.5, 31.0, 31.0)
const PUFF_PX = Rect2(36.5, 0.5, 31.0, 31.0)
const WHITE = Color(1, 1, 1)
const ICE = [Color(0.941, 0.988, 1.0), Color(0.588, 0.843, 1.0)]
const GOLD = [Color(1.0, 0.98, 0.886), Color(1.0, 0.8, 0.361)]
const SLIVER = Color(0.824, 0.933, 1.0)
const ABYSS = [Color(0.933, 0.886, 1.0), Color(0.588, 0.361, 1.0)]
const TENTACLE_BODY = Color(0.055, 0.02, 0.094)
const TENTACLE_MID = Color(0.149, 0.063, 0.243)
const TENTACLE_RIM = Color(0.588, 0.376, 0.941)
const TENTACLE_GLOW = Color(0.431, 0.204, 0.863)
const TENTACLE_SUCKER = Color(0.706, 0.588, 0.894)

#baked textures hold coverage in red; plain shapes pass through unchanged
const COVER_SHADER = """shader_type canvas_item;
void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	COLOR = vec4(COLOR.rgb, COLOR.a * tex.a * tex.r);
}
"""

const DESAT_SHADER = """shader_type canvas_item;
void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	float l = dot(tex.rgb, vec3(0.3, 0.59, 0.11));
	COLOR = vec4(vec3(l) * COLOR.rgb, tex.a * COLOR.a);
}
"""

var t = 0.0
var tau = 0.0
var shared = {}

var mesh_points = PoolVector2Array()
var mesh_colors = PoolColorArray()
var mesh_indices = PoolIntArray()
var b_layer = null
var bp = PoolVector2Array()
var bc = PoolColorArray()
var bu = PoolVector2Array()
var bi = PoolIntArray()
var circles = {}


#one kit per combat screen: the effects add their own shaders to it, and the baked textures stay in `baked`
static func make_kit():
	var white = Image.new()
	white.create(4, 4, false, Image.FORMAT_RGBA8)
	white.fill(Color(1, 1, 1, 1))
	var white_tex = ImageTexture.new()
	white_tex.create_from_image(white, 0)
	var cover = Shader.new()
	cover.code = COVER_SHADER
	var desat = Shader.new()
	desat.code = DESAT_SHADER
	return {atlas = make_atlas(), white = white_tex, cover = cover, desat = desat, baked = {}, jobs = []}


static func make_atlas():
	var data = PoolByteArray()
	for y in range(32):
		for x in range(80):
			var a = 0.0
			if x < 32: a = disc_alpha(Vector2(x - 15.5, y - 15.5).length() / 16.0, false)
			elif x >= 36 and x < 68: a = disc_alpha(Vector2(x - 51.5, y - 15.5).length() / 16.0, true)
			elif x >= 72: a = 1.0
			data.append(255)
			data.append(int(round(255.0 * a)))
	var image = Image.new()
	image.create_from_data(80, 32, false, Image.FORMAT_LA8, data)
	var tex = ImageTexture.new()
	tex.create_from_image(image, Texture.FLAG_FILTER)
	return tex


static func disc_alpha(d, dense):
	if !dense: return clamp(1.0 - d, 0.0, 1.0)
	if d < 0.55: return 1.0 - 0.25 * d / 0.55
	return 0.75 * clamp(1.0 - (d - 0.55) / 0.45, 0.0, 1.0)


func use_kit(kit):
	shared = kit
	if !shared.has('baked'): shared.baked = {}
	if !shared.has('jobs'): shared.jobs = []


#the part of the portrait a KEEP_ASPECT_COVERED icon shows
static func cover_region(ts, rs):
	if ts.x <= 0.0 or ts.y <= 0.0 or rs.x <= 0.0 or rs.y <= 0.0: return Rect2(Vector2(), ts)
	var k = max(rs.x / ts.x, rs.y / ts.y)
	var size = rs / k
	return Rect2((ts - size) / 2.0, size)


#where a TextureRect of `size` puts a texture of `ts`, worked out the way TextureRect does it: {rect} in its own space
#and the {region} of the texture shown there. The card portraits are KEEP_ASPECT_CENTERED: the whole picture, fitted.
static func placement(ts, size, mode, expand = true):
	var rect = Rect2(Vector2(), size)
	var region = Rect2(Vector2(), ts)
	if ts.x <= 0.0 or ts.y <= 0.0: return {rect = rect, region = region}
	match mode:
		TextureRect.STRETCH_SCALE_ON_EXPAND:
			if !expand: rect.size = ts
		TextureRect.STRETCH_KEEP:
			rect.size = ts
		TextureRect.STRETCH_KEEP_CENTERED:
			rect = Rect2((size - ts) / 2.0, ts)
		TextureRect.STRETCH_KEEP_ASPECT, TextureRect.STRETCH_KEEP_ASPECT_CENTERED:
			var w = int(ts.x * size.y / ts.y)
			var h = int(size.y)
			if w > size.x:
				w = int(size.x)
				h = int(ts.y * w / ts.x)
			rect.size = Vector2(w, h)
			if mode == TextureRect.STRETCH_KEEP_ASPECT_CENTERED: rect.position = (size - rect.size) / 2.0
		TextureRect.STRETCH_KEEP_ASPECT_COVERED:
			region = cover_region(ts, size)
	return {rect = rect, region = region}


static func texture_placement(node):
	return placement(node.texture.get_size(), node.rect_size, node.stretch_mode, node.expand)


func new_flare(pos, ang, t0, size, dur, key, n, pal, even, sym):
	return {pos = pos, ang = ang, t0 = t0, size = size, dur = dur, key = key, n = n, pal = pal, even = even, sym = sym}


func add_layer(z, mode, method, shader = null, parent = null):
	var layer = Node2D.new()
	layer.z_index = z
	if shader != null:
		var material_ = ShaderMaterial.new()
		material_.shader = shader
		layer.material = material_
	elif mode >= 0:
		layer.material = blend(mode)
	(parent if parent != null else self).add_child(layer)
	layer.connect('draw', self, method, [layer])
	return layer


#drawn once by `method`; takes the layer's blending unless it has a shader of its own
func static_node(layer, method, arg, shader = null):
	var node = Node2D.new()
	if shader != null:
		var material_ = ShaderMaterial.new()
		material_.shader = shader
		node.material = material_
	else:
		node.use_parent_material = true
	node.visible = false
	layer.add_child(node)
	node.connect('draw', self, method, [node, arg])
	return node


func blend(mode):
	var material_ = CanvasItemMaterial.new()
	material_.blend_mode = mode
	return material_


func card_ok(node):
	return node != null and is_instance_valid(node) and node.is_inside_tree() and node.visible


func card_space(layer, node):
	layer.draw_set_transform_matrix(layer.get_global_transform().affine_inverse() * node.get_global_transform())


func screen_space(layer):
	layer.draw_set_transform_matrix(Transform2D())


func card_xform(node):
	return get_global_transform().affine_inverse() * node.get_global_transform()


func local_rect(control):
	var rect = control.get_global_rect()
	return Rect2(get_global_transform().affine_inverse().xform(rect.position), rect.size)


func screen_rect():
	var rect = get_viewport().get_visible_rect()
	return Rect2(get_global_transform().affine_inverse().xform(rect.position), rect.size)


#A holder drawn right after `after`, a sibling of this node, in the same coordinates. Given the battlefield's last node
#(CombatAnimations.field_end) what it holds lies over the field and under the interface. Without one it is this node.
#The owner frees a holder of its own.
func ground_after(after):
	if after == null or !is_instance_valid(after) or after.get_parent() != get_parent(): return self
	var node = Node2D.new()
	node.transform = transform
	after.get_parent().add_child_below_node(after, node)
	return node


func _draw_nothing(_layer):
	pass


#an invisible dot, so the shader is compiled at the start of the cast rather than when the first card freezes
func _draw_warm_up(layer):
	layer.draw_rect(Rect2(0, 0, 1, 1), Color(1, 1, 1, 0))


#--- textures drawn once off screen: a viewport draws it, the next frames read it back ------------------------------

#queues a texture unless it is baked or queued already. `draw` paints it; `prepare`, if given, lays out its geometry
#over a few frames first and returns true when done. Returns the job, or null.
func bake(key, size, light, draw, prepare = '', shader = null):
	if shared.baked.has(key): return null
	for job in shared.jobs:
		if job.key == key: return null
	var job = {key = key, size = size, light = light, draw = draw, prepare = prepare, shader = shader, owner = self, vp = null, frame = 0}
	shared.jobs.append(job)
	return job


#one new viewport a frame across every effect keeps the geometry work of the textures from landing in a single frame
func bake_step():
	var jobs = shared.jobs
	var now = Engine.get_frames_drawn()
	for i in range(jobs.size() - 1, -1, -1):
		var job = jobs[i]
		if !is_instance_valid(job.owner): jobs.remove(i)
		elif job.owner == self and job.vp != null and now >= job.frame + 2:
			finish_bake(job)
			jobs.remove(i)
	if shared.get('started', -1) == now: return
	for job in jobs:
		if job.owner != self or job.vp != null: continue
		shared.started = now
		if job.prepare == '' or call(job.prepare, job): start_bake(job)
		return


func start_bake(job):
	#every flag set after the size would allocate the render target again
	var vp = Viewport.new()
	vp.usage = Viewport.USAGE_2D
	vp.transparent_bg = true
	vp.disable_3d = true
	vp.render_target_v_flip = true
	vp.render_target_update_mode = Viewport.UPDATE_ONCE
	vp.gui_disable_input = true
	vp.size = job.size
	var painter = Node2D.new()
	if job.shader != null:
		var material_ = ShaderMaterial.new()
		material_.shader = job.shader
		var params = job.get('params', {})
		for key in params:
			material_.set_shader_param(key, params[key])
		painter.material = material_
	else:
		painter.material = blend(CanvasItemMaterial.BLEND_MODE_ADD)
	vp.add_child(painter)
	painter.connect('draw', self, job.draw, [painter, job])
	add_child(vp)
	job.vp = vp
	job.frame = Engine.get_frames_drawn()


#light keeps its colour and tiles; coverage keeps one channel
func finish_bake(job):
	var img = job.vp.get_texture().get_data()
	job.vp.queue_free()
	job.vp = null
	if img == null or img.is_empty(): return
	img.convert(Image.FORMAT_RGB8 if job.light else Image.FORMAT_L8)
	var tex = ImageTexture.new()
	tex.create_from_image(img, Texture.FLAG_FILTER | (Texture.FLAG_REPEAT if job.light else 0))
	shared.baked[job.key] = tex


#--- sparks, flares and slivers ----------------------------------------------------------------------------------

func burst_sparks(layer, b, index):
	var a = tau - b.at
	if a < 0.0 or a > 0.6: return
	for i in range(b.n):
		var h1 = hash01(index * 31 + i)
		var h2 = hash01(index * 31 + i + 7)
		var life = 0.25 + 0.3 * h2
		if a > life: continue
		var an = b.ang + (h1 - 0.5) * b.spread
		var sp = (400.0 + 700.0 * h2) * b.power
		var q = a / life
		var d = Vector2(cos(an), sin(an))
		var p = b.pos + d * sp * (1.0 - exp(-4.0 * a)) / 4.0 + Vector2(0.0, 300.0 * a * a)
		layer.draw_line(p, p - d * sp * exp(-4.0 * a) * 0.025, fade(b.pal[0].linear_interpolate(b.pal[1], q), 0.9 * (1.0 - q)), 2.4 * (1.0 - q) + 0.6)


func flare(layer, f):
	var a = tau - f.t0
	if a < 0.0 or a > f.dur: return
	var grow = out_cubic(clamp(a / 0.02, 0.0, 1.0))
	var q = seg(a, 0.015, f.dur)
	var life = 1.0 - q
	var s = f.size
	var n = f.n
	var xf = Transform2D(f.ang, f.pos)
	d_blob(layer, f.pos, s * 3.0 * grow, f.pal[1], 0.5 * life)
	for pass_i in range(2):
		var col = PoolColorArray([fade(f.pal[0], life) if pass_i == 1 else fade(f.pal[1], 0.5 * life)])
		for i in range(n):
			var h = hash01(f.key + i * 3.7)
			var an = 0.0
			var L = 0.0
			if f.even:
				an = TAU * i / n + (h - 0.5) * 0.2
				L = s * (2.4 + 0.5 * h)
			elif i == 0:
				L = s * 3.2
			elif i == 1:
				an = PI
				L = s * (3.2 if f.sym else 1.6)
			else:
				an = TAU * (i - 1.5) / (n - 2) + (h - 0.5) * 0.4
				L = s * (0.75 + 0.7 * h)
			L *= grow * (1.0 - 0.3 * q)
			var bw = s * (0.16 if i < 2 else 0.1) * (1.0 if pass_i == 1 else 2.3) * life
			var ca = cos(an)
			var sa = sin(an)
			layer.draw_primitive(PoolVector2Array([xf.xform(Vector2(-sa * bw, ca * bw)), xf.xform(Vector2(ca * L, sa * L)), xf.xform(Vector2(sa * bw, -ca * bw))]),
				col, PoolVector2Array())
	d_blob(layer, f.pos, s * 0.8 * grow, WHITE, 0.95 * life)


func slivers(layer, d, di):
	var a = tau - d.t0
	if a < 0.0 or a > 1.4: return
	var col = PoolColorArray([fade(d.get('col', SLIVER), 1.0 - seg(a, 0.9, 1.4))])
	var none = PoolVector2Array()
	for i in range(d.n):
		var b = di * 57 + i * 7
		var h1 = hash01(b)
		var h2 = hash01(b + 1)
		var h3 = hash01(b + 2)
		var an = d.ang + (h1 - 0.5) * d.spread
		var sp = (260.0 + 620.0 * h2) * d.power
		var p = d.pos + Vector2(cos(an), sin(an)) * sp * a + Vector2((h3 - 0.5) * 30.0, 1100.0 * a * a)
		if p.y > d.pos.y + 50.0: continue
		var size = d.size * (0.5 + h3)
		var xf = Transform2D(a * (6.0 + 10.0 * h1) * (-1.0 if h2 < 0.5 else 1.0), p)
		layer.draw_primitive(PoolVector2Array([xf.xform(Vector2(-size, -size * 0.16)), xf.xform(Vector2(size, -size * 0.16)),
			xf.xform(Vector2(size, size * 0.16)), xf.xform(Vector2(-size, size * 0.16))]), col, none)


#--- frost: feathered lines, soft edges, grains --------------------------------------------------------------------

func grow_frost(seeds, r, depth):
	var lines = []
	for i in range(depth + 1):
		lines.append([])
	for sd in seeds:
		grow_branch(lines, sd[0], sd[1], sd[2], 0, r, depth)
	return lines


func grow_branch(lines, p, ang, length, dep, r, depth):
	var n = 3 if dep > 0 else 6
	var dl = length / n
	var a = ang
	for s in range(n):
		a += (r.randf() - 0.5) * 0.2
		var q = p + Vector2(cos(a), sin(a)) * dl
		lines[dep].append(p)
		lines[dep].append(q)
		if dep < depth and s >= 1 and s < n - 1:
			var bl = length * 0.45 * (1.0 - float(s) / n)
			if r.randf() > 0.15: grow_branch(lines, q, a + 0.85 + 0.4 * r.randf(), bl * (0.7 + 0.6 * r.randf()), dep + 1, r, depth)
			if r.randf() > 0.15: grow_branch(lines, q, a - 0.85 - 0.4 * r.randf(), bl * (0.7 + 0.6 * r.randf()), dep + 1, r, depth)
		p = q


#the mockup's blurred copy as two wide faint passes under the crisp line
func frost_lines(painter, lines, spec, blur, blur_alpha, crisp_alpha):
	for d in range(lines.size()):
		if lines[d].size() < 2: continue
		var pts = PoolVector2Array(lines[d])
		var w = spec[d][0]
		var a = spec[d][1]
		var peak = a * w / (blur * 2.5)
		painter.draw_multiline(pts, Color(1, 1, 1, blur_alpha * 0.45 * peak), blur * 3.5)
		painter.draw_multiline(pts, Color(1, 1, 1, blur_alpha * 0.55 * peak), blur * 1.5)
		painter.draw_multiline(pts, Color(1, 1, 1, crisp_alpha * a * min(1.0, w)), max(1.0, w), true)


#`dir` points from the edge into the band
func edge_fade(painter, r, dir, a):
	var c0 = Color(1, 1, 1, a)
	var c1 = Color(1, 1, 1, 0.0)
	var p = [r.position, Vector2(r.end.x, r.position.y), r.end, Vector2(r.position.x, r.end.y)]
	var cols = []
	if dir == Vector2(0, 1): cols = [c0, c0, c1, c1]
	elif dir == Vector2(0, -1): cols = [c1, c1, c0, c0]
	elif dir == Vector2(1, 0): cols = [c0, c1, c1, c0]
	else: cols = [c1, c0, c0, c1]
	painter.draw_primitive(PoolVector2Array(p), PoolColorArray(cols), PoolVector2Array())


func grains(painter, W, H, count, r, falloff, floor_chance, windward):
	begin_mesh()
	for i in range(count):
		var p = Vector2(W * r.randf(), H * r.randf())
		var dx = abs(p.x - windward)
		var edge = min(min(dx * 0.6, W - dx), min(p.y, H - p.y))
		if r.randf() > exp(-edge / falloff) + floor_chance: continue
		grain(p, 0.12 + 0.3 * r.randf(), 0.4 + 0.8 * r.randf())
	flush_mesh(painter)


func grain(p, al, rad):
	var side = max(1.0, 1.77 * rad)
	var col = Color(1, 1, 1, al * min(1.0, PI * rad * rad / (side * side)))
	var base = mesh_points.size()
	for q in [Vector2(-0.5, -0.5), Vector2(0.5, -0.5), Vector2(0.5, 0.5), Vector2(-0.5, 0.5)]:
		mesh_points.append(p + q * side)
		mesh_colors.append(col)
	for index in [base, base + 1, base + 2, base, base + 2, base + 3]:
		mesh_indices.append(index)


#--- drawing helpers -----------------------------------------------------------------------------------------

#drawn every frame: straight to the layer
func d_blob(layer, pos, r, col, a):
	if a <= 0.004 or r <= 0.5: return
	layer.draw_texture_rect_region(shared.atlas, Rect2(pos - Vector2(r, r), Vector2(r, r) * 2.0), SOFT_PX, fade(col, a))


func d_puff(layer, pos, r, col, a):
	if a <= 0.004 or r <= 0.5: return
	layer.draw_texture_rect_region(shared.atlas, Rect2(pos - Vector2(r, r), Vector2(r, r) * 2.0), PUFF_PX, fade(col, a))


func d_star4(layer, pos, s, rot, col, a):
	if a <= 0.01 or s <= 0.5: return
	layer.draw_colored_polygon(star_points(pos, s, rot), fade(col, a))


func d_stripe(layer, clip, o, u, s, cols):
	for poly in stripe_parts(clip, o, u, s, cols):
		layer.draw_polygon(poly[0], poly[1])


func star_points(pos, s, rot):
	var pts = PoolVector2Array()
	for i in range(8):
		var an = rot + i * PI / 4.0
		pts.append(pos + Vector2(cos(an), sin(an)) * (s * 0.14 if i % 2 == 1 else s))
	return pts


#a band cut to a rect: along `u` from `o` it runs cols[k] at s[k]; returns [points, colours] pairs
func stripe_parts(clip, o, u, s, cols):
	var res = []
	if cols[1].a <= 0.004: return res
	var n = Vector2(-u.y, u.x) * 4000.0
	var box = rect_points(clip)
	for half in range(2):
		var a = s[half]
		var b = s[half + 1]
		if b - a <= 0.01: continue
		var slab = PoolVector2Array([o + u * a - n, o + u * b - n, o + u * b + n, o + u * a + n])
		for poly in Geometry.intersect_polygons_2d(box, slab):
			if poly.size() < 3: continue
			var colors = PoolColorArray()
			for p in poly:
				colors.append(cols[half].linear_interpolate(cols[half + 1], clamp(((p - o).dot(u) - a) / (b - a), 0.0, 1.0)))
			res.append([poly, colors])
	return res


#drawn once: one triangle mesh textured with the atlas
func b_begin(layer):
	b_layer = layer


func b_flush():
	if bi.size() > 0 and b_layer != null:
		VisualServer.canvas_item_add_triangle_array(b_layer.get_canvas_item(), bi, bp, bc, bu, PoolIntArray(), PoolRealArray(), shared.atlas.get_rid())
	bp = PoolVector2Array()
	bc = PoolColorArray()
	bu = PoolVector2Array()
	bi = PoolIntArray()


#`uv` picks a region of the atlas, the white patch by default
func b_quad(a, b, c, d, ca, cb, cc, cd, uv = null):
	if bi.size() > 12000: b_flush()
	var n = bp.size()
	bp.append(a)
	bp.append(b)
	bp.append(c)
	bp.append(d)
	bc.append(ca)
	bc.append(cb)
	bc.append(cc)
	bc.append(cd)
	if uv == null:
		bu.append(UV_WHITE)
		bu.append(UV_WHITE)
		bu.append(UV_WHITE)
		bu.append(UV_WHITE)
	else:
		bu.append(uv.position)
		bu.append(Vector2(uv.end.x, uv.position.y))
		bu.append(uv.end)
		bu.append(Vector2(uv.position.x, uv.end.y))
	#unrolled: this runs thousands of times a frame
	bi.append(n)
	bi.append(n + 1)
	bi.append(n + 2)
	bi.append(n)
	bi.append(n + 2)
	bi.append(n + 3)


func b_line(a, b, width, col):
	if col.a <= 0.004: return
	var d = b - a
	var l = d.length()
	if l < 0.001: return
	var n = Vector2(-d.y, d.x) * (width * 0.5 / l)
	b_quad(a + n, b + n, b - n, a - n, col, col, col, col)


func b_polyline(pts, width, col, loop = false):
	if col.a <= 0.004: return
	var count = pts.size()
	for i in range(count - 1):
		b_line(pts[i], pts[i + 1], width, col)
	if loop and count > 2: b_line(pts[count - 1], pts[0], width, col)


func b_circle(pos, r, width, col):
	var ring = unit_circle(8)
	for s in range(8):
		b_line(pos + ring[s] * r, pos + ring[(s + 1) % 8] * r, width, col)


func b_disc(pos, r, col, segments):
	if col.a <= 0.004 or r <= 0.1: return
	var ring = unit_circle(segments)
	var n = bp.size()
	bp.append(pos)
	bc.append(col)
	bu.append(UV_WHITE)
	for s in range(segments):
		bp.append(pos + ring[s] * r)
		bc.append(col)
		bu.append(UV_WHITE)
	for s in range(segments):
		bi.append(n)
		bi.append(n + 1 + s)
		bi.append(n + 1 + (s + 1) % segments)


#radii[k] to radii[k + 1] blending colors[k] into colors[k + 1]
func b_ring(pos, radii, colors, segments):
	var n = bp.size()
	var ring = unit_circle(segments)
	for k in range(radii.size()):
		for s in range(segments):
			bp.append(pos + ring[s] * radii[k])
			bc.append(colors[k])
			bu.append(UV_WHITE)
	for k in range(radii.size() - 1):
		var r0 = n + k * segments
		var r1 = r0 + segments
		for s in range(segments):
			var m = (s + 1) % segments
			for index in [r0 + s, r1 + s, r1 + m, r0 + s, r1 + m, r0 + m]:
				bi.append(index)


func b_mesh(points, colors, indices):
	var n = bp.size()
	for k in range(points.size()):
		bp.append(points[k])
		bc.append(colors[k])
		bu.append(UV_WHITE)
	for j in indices:
		bi.append(n + j)


func b_poly(pts, cols):
	var idx = Geometry.triangulate_polygon(pts)
	if idx.empty(): return
	var n = bp.size()
	var single = typeof(cols) == TYPE_COLOR
	for k in range(pts.size()):
		bp.append(pts[k])
		bc.append(cols if single else cols[k])
		bu.append(UV_WHITE)
	for j in idx:
		bi.append(n + j)


func b_stripe(clip, o, u, s, cols):
	for poly in stripe_parts(clip, o, u, s, cols):
		b_poly(poly[0], poly[1])


#a band of `width` along a path, as one strip: joints share their edge points, so nothing is added twice there
func b_band(pts, width, col):
	var n = pts.size()
	if n < 2 or col.a <= 0.004: return
	if bi.size() > 12000: b_flush()
	var base = bp.size()
	for i in range(n):
		var d = pts[min(i + 1, n - 1)] - pts[max(i - 1, 0)]
		var l = d.length()
		var side = Vector2(-d.y, d.x) * (width * 0.5 / l) if l > 0.0001 else Vector2()
		bp.append(pts[i] + side)
		bp.append(pts[i] - side)
		bc.append(col)
		bc.append(col)
		bu.append(UV_WHITE)
		bu.append(UV_WHITE)
	for i in range(n - 1):
		var a = base + i * 2
		for k in [a, a + 1, a + 3, a, a + 3, a + 2]:
			bi.append(k)


#the band from `a` to `b` times each row's half width along its normal (tentacle_rows), as one strip
func b_strip(rows, a, b, col):
	var n = rows.size()
	if n < 2 or col.a <= 0.004: return
	if bi.size() > 12000: b_flush()
	var base = bp.size()
	for r in rows:
		bp.append(r.p + r.n * (r.w * a))
		bp.append(r.p + r.n * (r.w * b))
		bc.append(col)
		bc.append(col)
		bu.append(UV_WHITE)
		bu.append(UV_WHITE)
	for i in range(n - 1):
		var k = base + i * 2
		for m in [k, k + 1, k + 3, k, k + 3, k + 2]:
			bi.append(m)


#--- tentacles: a smooth path grown by its length, a wave down it, a tapered strip in a few flat tones -------------

#a smooth path through the waypoints (Catmull-Rom), n points to a span
static func spline_path(wp, n):
	var res = []
	for i in range(wp.size() - 1):
		var p0 = wp[max(0, i - 1)]
		var p1 = wp[i]
		var p2 = wp[i + 1]
		var p3 = wp[min(wp.size() - 1, i + 2)]
		for k in range(n):
			var t1 = float(k) / n
			var t2 = t1 * t1
			var t3 = t2 * t1
			res.append(0.5 * (2.0 * p1 + (p2 - p0) * t1 + (2.0 * p0 - 5.0 * p1 + 4.0 * p2 - p3) * t2 + (3.0 * p1 - p0 - 3.0 * p2 + p3) * t3))
	res.append(wp.back())
	return res


#the first k of a path, by its length
static func path_part(pts, k):
	if k >= 1.0: return pts.duplicate()
	var total = 0.0
	for i in range(1, pts.size()):
		total += pts[i].distance_to(pts[i - 1])
	var want = total * max(0.0, k)
	var res = [pts[0]]
	var acc = 0.0
	for i in range(1, pts.size()):
		var l = pts[i].distance_to(pts[i - 1])
		if acc + l <= want:
			res.append(pts[i])
			acc += l
			continue
		res.append(pts[i - 1].linear_interpolate(pts[i], (want - acc) / max(0.000001, l)))
		break
	return res


#a wave running from the root to the tip, still at the root
static func writhe(pts, amp, t, seed_):
	var n = pts.size() - 1
	if n < 1: return pts
	var res = []
	for j in range(n + 1):
		var d = pts[min(n, j + 1)] - pts[max(0, j - 1)]
		var o = amp * sin(j * 0.55 - t * 11.0 + seed_) * min(1.0, j * 2.5 / n)
		res.append(pts[j] + Vector2(-d.y, d.x) / max(0.000001, d.length()) * o)
	return res


#cross sections along a spine: where, its normal, the half width tapering to the tip; `thick` swells it
static func tentacle_rows(pts, w0, thick = 1.0):
	var n = pts.size() - 1
	var rows = []
	for j in range(n + 1):
		var d = pts[min(n, j + 1)] - pts[max(0, j - 1)]
		rows.append({p = pts[j], n = Vector2(-d.y, d.x) / max(0.000001, d.length()),
			w = w0 * thick * pow(1.0 - float(j) / max(1, n), 1.05) / 2.0 + 0.6})
	return rows


#for an additive layer
func tentacle_glow(rows, al):
	b_strip(rows, 2.6, -2.6, fade(TENTACLE_GLOW, 0.09 * al))


#a dark body, a lighter band down its back, a violet rim on the lit side and pale suckers on the other
func tentacle_body(rows, al):
	b_strip(rows, 1.0, -1.0, fade(TENTACLE_BODY, al))
	b_strip(rows, 0.5, 0.08, fade(TENTACLE_MID, 0.9 * al))
	var rim = []
	for r in rows:
		rim.append(r.p + r.n * r.w)
	b_polyline(rim, 1.2, fade(TENTACLE_RIM, 0.75 * al))
	var sucker = fade(TENTACLE_SUCKER, 0.45 * al)
	for j in range(4, rows.size() - 4, 4):
		var r = rows[j]
		b_disc(r.p - r.n * (r.w * 0.55), max(0.8, r.w * 0.26), sucker, 8)


func blob(pos, r, col, a):
	if a <= 0.004 or r <= 0.5: return
	var c = fade(col, a)
	b_quad(pos - Vector2(r, r), pos + Vector2(r, -r), pos + Vector2(r, r), pos + Vector2(-r, r), c, c, c, c, UV_SOFT)


func puff(pos, r, col, a):
	if a <= 0.004 or r <= 0.5: return
	var c = fade(col, a)
	b_quad(pos - Vector2(r, r), pos + Vector2(r, -r), pos + Vector2(r, r), pos + Vector2(-r, r), c, c, c, c, UV_PUFF)


func clipped_blob(pos, r, clip, col):
	if col.a <= 0.004: return
	var box = Rect2(pos - Vector2(r, r), Vector2(r, r) * 2.0)
	var cut = box.clip(clip)
	if cut.size.x <= 0.0 or cut.size.y <= 0.0: return
	var k0 = (cut.position - box.position) / box.size
	var k1 = (cut.end - box.position) / box.size
	var uv = Rect2(UV_SOFT.position + UV_SOFT.size * k0, UV_SOFT.size * (k1 - k0))
	b_quad(cut.position, Vector2(cut.end.x, cut.position.y), cut.end, Vector2(cut.position.x, cut.end.y), col, col, col, col, uv)


func star4(pos, s, rot, col, a):
	if a <= 0.01 or s <= 0.5: return
	b_poly(star_points(pos, s, rot), fade(col, a))


func unit_circle(segments):
	if !circles.has(segments):
		var ring = []
		for s in range(segments):
			ring.append(Vector2(cos(TAU * s / segments), sin(TAU * s / segments)))
		circles[segments] = ring
	return circles[segments]


func radial(layer, pos, radii, colors, segments = 40):
	var own = mesh_points.size() == 0
	var base = mesh_points.size()
	for ring in range(radii.size()):
		for s in range(segments):
			var a = TAU * s / segments
			mesh_points.append(pos + Vector2(cos(a), sin(a)) * radii[ring])
			mesh_colors.append(colors[ring])
	for ring in range(radii.size() - 1):
		var r0 = base + ring * segments
		var r1 = r0 + segments
		for s in range(segments):
			var n = (s + 1) % segments
			for index in [r0 + s, r1 + s, r1 + n, r0 + s, r1 + n, r0 + n]:
				mesh_indices.append(index)
	if own: flush_mesh(layer)


func begin_mesh():
	mesh_points = PoolVector2Array()
	mesh_colors = PoolColorArray()
	mesh_indices = PoolIntArray()


func flush_mesh(layer):
	if mesh_indices.size() > 0:
		VisualServer.canvas_item_add_triangle_array(layer.get_canvas_item(), mesh_indices, mesh_points, mesh_colors)
	begin_mesh()


static func rect_points(r):
	return PoolVector2Array([r.position, Vector2(r.end.x, r.position.y), r.end, Vector2(r.position.x, r.end.y)])


static func closed(pts):
	var res = PoolVector2Array(pts)
	if res.size() > 0: res.append(res[0])
	return res


static func c8(r, g, b, a = 1.0):
	return Color(r / 255.0, g / 255.0, b / 255.0, clamp(a, 0.0, 1.0))


static func fade(col, a):
	return Color(col.r, col.g, col.b, clamp(a, 0.0, 1.0))


static func quad_point(a, b, c, k):
	return (1.0 - k) * (1.0 - k) * a + 2.0 * (1.0 - k) * k * b + k * k * c


static func seg(x, a, b):
	if b <= a: return 1.0 if x >= b else 0.0
	return clamp((x - a) / (b - a), 0.0, 1.0)


static func bump(x, a, b, c):
	if x <= a or x >= c: return 0.0
	if x < b: return out_quad((x - a) / (b - a))
	return 1.0 - inout_quad((x - b) / (c - b))


static func out_quad(k):
	return 1.0 - (1.0 - k) * (1.0 - k)


static func inout_quad(k):
	return 2.0 * k * k if k < 0.5 else 1.0 - pow(-2.0 * k + 2.0, 2) / 2.0


static func out_cubic(k):
	return 1.0 - pow(1.0 - k, 3)


static func out_back(k):
	return 1.0 + 2.9 * pow(k - 1.0, 3) + 1.9 * pow(k - 1.0, 2)


#hit-stops: the effect's clock stands still for d real seconds at each {at, d} of `stops`, sorted by `at`
static func stop_to_anim(stops, r):
	var acc = 0.0
	for s in stops:
		var rs = s.at + acc
		if r <= rs: break
		if r < rs + s.d: return s.at
		acc += s.d
	return r - acc


static func stop_to_real(stops, a):
	var acc = 0.0
	for s in stops:
		if a <= s.at: break
		acc += s.d
	return a + acc


#the screen shake of `kicks` ({at, mag, dur, dir}) at real time `now`, `px` at full strength; mostly along the blow
static func kick_shake(kicks, stops, now, px):
	var best = 0.0
	var dir = null
	for k in kicks:
		var a = now - stop_to_real(stops, k.at)
		if a < 0.0 or a >= k.dur: continue
		var m = px * k.mag * pow(1.0 - a / k.dur, 1.5)
		if m > best:
			best = m
			dir = k.get('dir')
	if best <= 0.01: return Vector2()
	var tick = floor(now * 60.0)
	var n1 = noise(57, tick, 1)
	var n2 = noise(57, tick, 2)
	if dir == null: return Vector2(best * n1, best * n2)
	return Vector2(best * (n1 * dir.x - 0.35 * n2 * dir.y), best * (n1 * dir.y + 0.35 * n2 * dir.x))


static func hash01(i):
	var x = sin(float(i) * 127.1 + 311.7) * 43758.5453
	return x - floor(x)


static func noise(key, i, tick):
	var v = sin(key * 0.0137 + i * 17.171 + tick * 7.913) * 43758.5453
	return (v - floor(v)) * 2.0 - 1.0
