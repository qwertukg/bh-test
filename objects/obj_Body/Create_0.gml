// значения по умолчанию, если не переопределены до event_inherited()
if (!variable_instance_exists(id, "mass"))     mass = 1.0;
if (!variable_instance_exists(id, "diameter")) diameter = 4.0;

if (!variable_instance_exists(id, "vx")) vx = 0.0;
if (!variable_instance_exists(id, "vy")) vy = 0.0;

if (!variable_instance_exists(id, "fx")) fx = 0.0;
if (!variable_instance_exists(id, "fy")) fy = 0.0;

// ---- физическая фикстура ----
var radius = diameter * 0.5;
var area = pi * sqr(radius);
var density = (area > 0) ? (mass / area) : 0;

var fix = physics_fixture_create();
physics_fixture_set_circle_shape(fix, radius);
physics_fixture_set_density(fix, density);
physics_fixture_set_restitution(fix, 0); // не упругие тела
physics_fixture_set_linear_damping(fix, 0);
physics_fixture_set_angular_damping(fix, 0);
physics_fixture_set_friction(fix, 0);
physics_fixture_set_sensor(fix, false);
physics_fixture_bind(fix, id);
physics_fixture_delete(fix);

physics_set_linear_velocity(vx, vy);
