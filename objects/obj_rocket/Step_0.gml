var _x = sx
var _y = sy

event_inherited();

dir = point_direction(0, 0, phy_linear_velocity_x, phy_linear_velocity_y);

var count = 5
var _offset = 1;
for (var _i = 0; _i < count; _i++) {
	var _x = random_range(x - _offset, x + _offset);
	var _y = random_range(y - _offset, y + _offset);
	var particle = instance_create_layer(_x, _y, "Particles", obj_explosion);
	particle.d = (dir + 180) mod 360;
	particle.s = random_range(0.1, 0.2);
	particle.acceleration = random_range(0.1, 0.2);         
	particle.deceleration = random_range(0.01, 0.02); 
}