if (mouse_check_button_pressed(mb_left)) {
    var boom_power = 2000
	var _offset = 1;
	for (var _i = 0; _i < boom_power; _i++) {
	    var _x = random_range(mouse_x - _offset, mouse_x + _offset);
	    var _y = random_range(mouse_y - _offset, mouse_y + _offset);
	    instance_create_layer(_x, _y, "Particles", obj_explosion);
	}
}
