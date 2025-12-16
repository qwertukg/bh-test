if !instance_exists(id) exit
if !instance_exists(other) exit

var big = noone
var small = noone
if (id.mass > other.mass) {
	big = id
	small = other
} else {
	big = other
	small = id
}





var boom_power = 500
var _offset = 1;
for (var _i = 0; _i < boom_power; _i++) {
	var _x = random_range(small.x - _offset, small.x + _offset);
	var _y = random_range(small.y - _offset, small.y + _offset);
	var e = instance_create_layer(_x, _y, "Particles", obj_explosion);
	
	var minM = clamp01_1(small.mass*0.5)
	var maxM = clamp01_1(small.mass*1)
	
	e.s = random_range(minM, maxM);
}


instance_destroy(small)