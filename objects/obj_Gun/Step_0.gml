/// obj_Gun : Step

if (_cd > 0) _cd--;

var player = instance_find(obj_Player_planet, 0);
var star = instance_find(obj_Star, 0);
if (player != noone) {
	drag_start_x = player.x;
	drag_start_y = player.y;
	
	var _x = player.x
	var _y = player.y
	var dir = point_direction(player.x, player.y, mouse_x, mouse_y)
	lx = lengthdir_x(player.diameter/2 + 2, dir) + player.x
	ly = lengthdir_y(player.diameter/2 + 2, dir) + player.y
	
	// старт "drag" только если кликнули рядом с пушкой
	if (!dragging && mouse_check_button_pressed(mb_left) && _cd <= 0) {
	
	    var dx = mouse_x - x;
	    var dy = mouse_y - y;
	    dragging = true;

	}

	// отпустили — стреляем
	if (dragging && mouse_check_button_released(mb_left)) {
	    dragging = false;

	    var vx = mouse_x - player.x;
	    var vy = mouse_y - player.y;

	    var d = point_distance(0, 0, vx, vy);
	    if (d > 2) {
	        d = min(d, max_drag);

	        var dir = point_direction(player.x, player.y, mouse_x, mouse_y);
	        var spd = d * speed_mult;

			
			
	        var b = instance_create_layer(lx, ly, bullet_layer, bullet_obj);
	        b.phy_speed_x = lengthdir_x(spd/10, dir);
	        b.phy_speed_y = lengthdir_y(spd/10, dir);

	        _cd = cooldown;
	    }
	}
}



