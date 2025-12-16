if (fixed) exit;

var dt = global.BH_DT;

var ax = fx / mass;
var ay = fy / mass;

// semi-implicit Euler
vx += ax * dt;
vy += ay * dt;

x += vx * dt;
y += vy * dt;
