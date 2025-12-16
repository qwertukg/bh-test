/// obj_Body: Step (physics)

var dt = global.BH_DT;

var ax = fx / mass;
var ay = fy / mass;

sx = ax * dt
sy = ay * dt

// то же самое, что было с vx/vy, но в physics-скорость (px/step)
phy_speed_x += sx
phy_speed_y += sy

fx = 0;
fy = 0;
