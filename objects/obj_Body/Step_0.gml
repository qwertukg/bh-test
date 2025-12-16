/// obj_Body: Step (physics)

var dt = global.BH_DT;

var ax = fx / mass;
var ay = fy / mass;

// то же самое, что было с vx/vy, но в physics-скорость (px/step)
phy_speed_x += ax * dt;
phy_speed_y += ay * dt;

fx = 0;
fy = 0;
