tool
extends Polygon2D
class_name AutoPoly
 
export var auto_poly = false setget _auto_poly_set, _auto_poly_get
export var copy_uvs = false setget _copy_uv_set, _copy_uv_get
var current_poly_count
 
func _auto_poly_set(v):
	auto_poly = v
	current_poly_count = polygon.size()
	if auto_poly == false:
		print("auto poly disabled")
	else:
		print("auto poly ready")
 
func _auto_poly_get():
	return auto_poly
 
func _process(delta):
	if auto_poly == true and current_poly_count != polygon.size():
		print("update polygon")
		create_poly()
		current_poly_count = polygon.size()
 
func create_poly():
	if polygon.size() < 3:
		return
	
	var delaunay_points = Geometry.triangulate_delaunay_2d(polygon)
	polygons.resize(0)
	var i = 0
	print("dela size : ",delaunay_points.size())
	while i <= (delaunay_points.size() / 3) -1:
		var poly = Array()
		poly.resize(3)
		var k = 0
		var j = i * 3
		while k <= 2:
			poly[k] = delaunay_points[j]
			j += 1
			k += 1
		polygons.append(poly)
		i += 1
	if copy_uvs: uv = polygons
 
func _copy_uv_set(v):
	copy_uvs = v
 
func _copy_uv_get():
	uv = polygons
