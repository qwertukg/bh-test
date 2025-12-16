/// obj_System: Create

// гарантируем мир гравитации
if (!instance_exists(obj_GravityWorld)) {
    instance_create_layer(0, 0, "Instances", obj_GravityWorld);
}

// центр
var cx = x;
var cy = y;

// звезда
var star = instance_create_layer(cx, cy, "Instances", obj_Star);

// планета на орбите
var r = 300;
var px = cx + r;
var py = cy;

var player = instance_create_layer(px, py, "Instances", obj_Player_planet);
var enemy = instance_create_layer(cx - r, py, "Instances", obj_Enemy_planet);

// круговая скорость (как раньше, px/step)
var v = sqrt(global.BH_G * star.mass / r);
with (player) {
    phy_speed_x = 0;
    phy_speed_y = -v * global.PTM;
}

with (enemy) {
    phy_speed_x = 0;
    phy_speed_y = v * global.PTM;
}

// пояс астероидов
var count = 100;
for (var i = 0; i < count; i++) {
    var ang = random(2*pi);
    var rr  = random_range(190, 210);

    var ax = cx + cos(ang) * rr;
    var ay = cy + sin(ang) * rr;

    var a = instance_create_layer(ax, ay, "Instances", obj_Asteroid);

	var vv = sqrt(global.BH_G * star.mass / rr);
	with (a) {
	    phy_speed_x = (-sin(ang) * vv + random_range(-0.2, 0.2)) * global.PTM
	    phy_speed_y =  (cos(ang) * vv + random_range(-0.2, 0.2)) * global.PTM
	}
}
