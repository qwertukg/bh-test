/// obj_Body: Create

// дефолты только если ребёнок не задал до event_inherited()
if (!variable_instance_exists(id, "mass"))     mass     = 1.0
if (!variable_instance_exists(id, "diameter")) diameter = 1.0

if (!variable_instance_exists(id, "vx")) vx = 0.0;
if (!variable_instance_exists(id, "vy")) vy = 0.0;

fx = 0.0;
fy = 0.0;

// ---- physics fixture ----
var fix = physics_fixture_create();

var r = diameter * 0.5;
physics_fixture_set_circle_shape(fix, r);

// ВАЖНО: подгоняем физ. массу под твою mass
var r = diameter * 0.5;
var area = pi * r * r;
physics_fixture_set_density(fix, 0);


physics_fixture_set_restitution(fix, 0);
physics_fixture_set_friction(fix, 0);

physics_fixture_bind(fix, id);
physics_fixture_delete(fix);



