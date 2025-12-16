mass = 1.0;
diameter = 4.0;

vx = 0.0;
vy = 0.0;

fx = 0.0;
fy = 0.0;

fixed = false; // звезда будет fixed=true

// ---- физическая фикстура ----
var radius = diameter * 0.5;
var area = pi * sqr(radius);
var density = (area > 0) ? (mass / area) : 0;

var fix = physics_fixture_create();
physics_fixture_set_circle_shape(fix, radius);
physics_fixture_set_density(fix, fixed ? 0 : density);
physics_fixture_set_restitution(fix, 0); // не упругие тела
physics_fixture_set_linear_damping(fix, 0);
physics_fixture_set_angular_damping(fix, 0);
physics_fixture_set_friction(fix, 0);
physics_fixture_set_sensor(fix, false);
if (fixed) {
    physics_fixture_set_kinematic(fix);
}
physics_fixture_bind(fix, id);
physics_fixture_delete(fix);

if (!fixed) {
    physics_set_linear_velocity(vx, vy);
}