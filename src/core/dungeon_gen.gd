extends Node

var debug = false

func _ready():
	if debug:
#		lines = 8
#		cols = 10
		prim()
		first_pass()
		second_pass()
		third_pass()
		fourth_pass()
#		color_subtrees()
		init_tuning()
		fill_diameter()
		if trim_diameter(10, 8):
			print_debug_data(tuning)
			trim_outer(8)
		else:
			print_debug_data(tuning)
			print('fail')

#graph
# edges are connections, not walls
# edge is arr[2] - type/vertex
# vertex is poolintarray[2] - row/column
# packed_vertex - int, packed_edge - int
var lines = 5
var cols = 5

func pack_vertex(vertex):
	return vertex[0] * cols + vertex[1]


func unpack_vertex(packed_vertex):
	var res = PoolIntArray([packed_vertex / cols, packed_vertex % cols])
	return res


func pack_edge(edge):
	match edge[0]:
		'h':
			return pack_vertex(edge[1]) * 10
		'v':
			return pack_vertex(edge[1]) * 10 + 5


func unpack_edge(packed_edge):
	var t1 = packed_edge % 10
	var t2 = packed_edge / 10
	if t1 == 0:
		return ['h', unpack_vertex(t2)]
	if t1 == 5:
		return ['v', unpack_vertex(t2)]
	print('error in packed edge')
	return null


func get_vertex(edge):
	var res0 = edge[1]
	var res1 = edge[1]
	match edge[0]:
		'h':
			res1[1] += 1
		'v':
			res1[0] += 1
	return [res0, res1]


func get_edges(vertex):
	var res = []
	if vertex[0] > 0:
		var newvertex = vertex
		newvertex[0] -= 1
		res.push_back(['v', newvertex])
	if vertex[1] > 0:
		var newvertex = vertex
		newvertex[1] -= 1
		res.push_back(['h', newvertex])
	if vertex[0] < lines - 1:
		res.push_back(['v', vertex])
	if vertex[1] < cols - 1:
		res.push_back(['h', vertex])
	return res


func get_another_vertex(edge, vertex):
	var tmp = get_vertex(edge)
	if !tmp.has(vertex):
		print('error - vertex not incindent to edge')
		return null
	tmp.erase(vertex)
	return tmp[0]


#prim
var vertex_arr = []
var edges_arr = []
var edges_arr_final = []
#debug
var vertex_arr_unpacked = []
var edges_arr_unpacked = []
var edges_arr_final_unpacked = []


func print_debug_data(vertex_data = null):
	#print top border
	var text = "+"
	for j in range(cols):
		text += "--+"
	print(text)
	
	for i in range(lines):
		#print cell line
		text = "|"
		for j in range(cols):
			if vertex_data == null:
				text += "  "
			else:
				text += "%2d" % vertex_data[pack_vertex(PoolIntArray([i, j]))]
			if j != (cols - 1) and edges_arr_final.has(pack_edge(['h', PoolIntArray([i, j])])):
				text += " "
			else:
				text += "|"
		print(text)
		#print bottom line
		text = "+"
		for j in range(cols):
			if (i != lines - 1) and edges_arr_final.has(pack_edge(['v', PoolIntArray([i, j])])):
				text += "  "
			else:
				text += "--"
			text += "+"
		print(text)


func fill_debug():
	vertex_arr_unpacked.clear()
	edges_arr_unpacked.clear()
	edges_arr_final_unpacked.clear()
	for v in vertex_arr:
		vertex_arr_unpacked.push_back(unpack_vertex(v))
	for e in edges_arr:
		edges_arr_unpacked.push_back(unpack_edge(e))
	for e in edges_arr_final:
		edges_arr_final_unpacked.push_back(unpack_edge(e))


func get_random_vertex(): #packed
	var size_a = lines * cols
	return globals.rng.randi_range(0, size_a - 1)


func prim():
	vertex_arr.clear()
	edges_arr.clear()
	edges_arr_final.clear()
	
	var current_vertex = get_random_vertex()
	vertex_arr.push_back(current_vertex)
	for e in get_edges(unpack_vertex(current_vertex)):
		edges_arr.push_back(pack_edge(e))
	
	if debug:
		fill_debug()
	
	while vertex_arr.size() < cols * lines:
		var current_edge = input_handler.random_from_array(edges_arr)
		edges_arr.erase(current_edge)
		edges_arr_final.push_back(current_edge)
		
		var expand_vertex
		for v in get_vertex(unpack_edge(current_edge)):
			if !vertex_arr.has(pack_vertex(v)):
				expand_vertex = v
				break
		
		if expand_vertex == null:
			print('error - no expand vertex')
			return
		
		vertex_arr.push_back(pack_vertex(expand_vertex))
		for e in get_edges(expand_vertex):
			var t_e = pack_edge(e)
			if edges_arr_final.has(t_e):
				continue
			
			var t_v = get_another_vertex(e, expand_vertex)
			if vertex_arr.has(pack_vertex(t_v)):
				edges_arr.erase(t_e)
				continue
			
			edges_arr.push_back(t_e)
		
		if debug:
			fill_debug()
	
	if debug:
		print_debug_data()


#distances and diameter
var pass1 = []
var data1 = {max_d = 0, vertex = PoolIntArray([0, 0])}
var pass2 = []
var data2 = {max_d = 0, vertex = PoolIntArray([0, 0])}
var pass4 = []
var data4 = {max_d = 0, branches = 0}


func fill_dist(dist_arr, dist_dict):
	dist_arr.clear()
	dist_arr.resize(cols * lines)
	dfs(pack_vertex(dist_dict.vertex), 0, dist_arr, dist_dict)


func dfs(vertex, dist, dist_arr, dist_dict):  #packed vertex
	if dist_arr[vertex] != null:
		return
	dist_arr[vertex] = dist
	var u_vertex = unpack_vertex(vertex)
	if dist > dist_dict.max_d:
		dist_dict.max_d = dist
		dist_dict.vertex = u_vertex
	for e in get_edges(u_vertex):
		if !edges_arr_final.has(pack_edge(e)):
			continue
		var n_v = get_another_vertex(e, u_vertex)
		dfs(pack_vertex(n_v), dist + 1, dist_arr, dist_dict)


func find_next_vertex(vertex, value, data_arr): #packed vertex
	var res = []
	var u_vertex = unpack_vertex(vertex)
	for e in get_edges(u_vertex):
		if !edges_arr_final.has(pack_edge(e)):
			continue
		var n_v = get_another_vertex(e, u_vertex)
		var pack_n_v = pack_vertex(n_v)
		if data_arr[pack_n_v] == value:
			res.push_back(pack_n_v)
	return res


func first_pass():
	pass1 = []
	data1 = {max_d = 0, vertex = PoolIntArray([0, 0])}
	fill_dist(pass1, data1)
	
	if debug:
		print_debug_data(pass1)
		print(data1)


func second_pass():
	pass2 = []
	data2 = {max_d = 0, vertex = data1.vertex}
	fill_dist(pass2, data2)
	
	if debug:
		print_debug_data(pass2)
		print(data2)


func third_pass():
	data1.vertex = data2.vertex
	data1.max_d = 0
	fill_dist(pass1, data1)
	
	if debug:
		print_debug_data(pass1)
		print(data1)


func fourth_pass():
	pass4 = []
	data4 = {max_d = 0, branches = 0}
	pass4.resize(cols * lines)
	var d = data1.max_d
	
	for i in range (cols * lines):
		pass4[i] = (pass1[i] + pass2[i] - d) / 2
		if data4.max_d < pass4[i]:
			data4.max_d = pass4[i]
		if pass4[i] == 1:
			data4.branches += 1
	
	if debug:
		print_debug_data(pass4)


#tuning
var tuning
var diameter = []

func init_tuning():
	tuning = pass4.duplicate()


func find_subtree(vertex): #packed vertex
	var dist = tuning[vertex]
	var res = [vertex]
	for v in find_next_vertex(vertex, dist + 1, tuning):
		res.append_array(find_subtree(v))
	return res


func color_subtrees(start_len = 1, col = 50): 
#	var col = 50
	for i in range(tuning.size()):
		if tuning[i] == start_len:
			col += 1
			var v_arr = find_subtree(i)
			for v in v_arr:
				tuning[v] = col
	if debug:
		print_debug_data(tuning)


func fill_diameter():
	diameter.clear()
	var d = data1.max_d
	var vertex = pack_vertex(data1.vertex)
	while d > 0:
		diameter.push_back(unpack_vertex(vertex))
		var tmp = find_next_vertex(vertex, d - 1, pass1)
		d -= 1
		vertex = tmp[0]
	diameter.push_back(unpack_vertex(vertex))
	
	if debug:
		print(diameter)


func gather_amounts(limit = 2):
	var res = {main = 0, outer = 0, outer_arr = [], roots_arr = []}
	for i in range(tuning.size()):
		if tuning[i] == 0:
			res.main += 1
		elif tuning[i] <= limit:
			res.outer += 1
			if tuning[i] == limit:
				res.outer_arr.push_back(i)
			if tuning[i] == 1:
				res.roots_arr.push_back(i)
	
	if debug:
		print(res)
	return res


func trim_diameter(limit, outer_limit):
	if diameter.size() < limit:
		return false
	
	while diameter.size() > limit:
		var rem_vertex
		if globals.rng.randf() > 0.5:
			rem_vertex = diameter.front()
			diameter.pop_front()
		else:
			rem_vertex = diameter.back()
			diameter.pop_back()
		var t_arr = find_subtree(pack_vertex(rem_vertex))
		for v in t_arr:
			tuning[v] +=1
	
	var temp = gather_amounts()
	if temp.outer >= outer_limit:
		return true
	else:
		return false


func trim_outer(outer_limits, limit = 2): #temp solution - greedy distant based triming outer vertexes
	#more complex solution should trim full subtrees until conditions met
	#but for current small limits there is little difference 
	var temp = gather_amounts(1)
	if temp.outer >= outer_limits:
		limit = 1
	for i in range(tuning.size()):
		if tuning[i] > limit:
			tuning[i] = 99
	
	temp = gather_amounts()
	if temp.outer < outer_limits:
		print("error in calling outer trimming")
	else:
		while temp.outer > outer_limits:
			var t = input_handler.random_from_array(temp.outer_arr)
			temp.outer_arr.erase(t)
			tuning[t] = 99
			temp.outer -= 1
	
	if debug:
		print_debug_data(tuning)


#api
func generate(data):
	debug = false
	lines = 5
	cols = 5
	
	if data.has('debug'):
		debug = data.debug
	if data.has('lines'):
		lines = data.lines
	if data.has('cols'):
		cols = data.cols
	
	for arg in ['main_route_length', 'bonus_rooms']:
		if data[arg] is Array:
			data[arg] = globals.rng.randi_range(data[0], data[1])
	
	var main_route_length = data.main_route_length
	var bonus_rooms = data.bonus_rooms
	
	var retry_attempts_global = 10
	while retry_attempts_global > 0:
		var retry_attempts = 4
		var completed = false
		prim()
		first_pass()
		second_pass()
		third_pass()
		fourth_pass()
		
		while retry_attempts > 0:
			retry_attempts -= 1
			init_tuning()
			fill_diameter()
			if trim_diameter(main_route_length, bonus_rooms):
				if debug:
					print_debug_data(tuning)
				trim_outer(bonus_rooms)
				completed = true
				break
			else:
				if debug:
					print_debug_data(tuning)
					print('fail trim %d %d' % [4 - retry_attempts, 10 - retry_attempts_global])
		if completed:
			break
		else:
			print('fail seed %d' % (10 - retry_attempts_global))
		retry_attempts_global -= 1
	if retry_attempts_global < 0:
		print("bad data limits")
		print(data)
		return false
	else:
		return true
