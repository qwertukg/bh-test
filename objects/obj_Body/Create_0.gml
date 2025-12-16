/// obj_Body: Create

// дефолты только если ребёнок не задал до event_inherited()
if (!variable_instance_exists(id, "mass"))     mass     = 1.0;
if (!variable_instance_exists(id, "diameter")) diameter = 1.0;

if (!variable_instance_exists(id, "vx")) vx = 0.0;
if (!variable_instance_exists(id, "vy")) vy = 0.0;

fx = 0.0;
fy = 0.0;
sx = 0 
sy = 0 

// ---- physics fixture ----
var fix = physics_fixture_create();

var r = diameter * 0.5;
physics_fixture_set_circle_shape(fix, r);

var r = diameter * 0.5;
var area = pi * r * r;
physics_fixture_set_density(fix, mass / max(area, 0.00001));


physics_fixture_set_restitution(fix, 0);
physics_fixture_set_friction(fix, 0);

physics_fixture_bind(fix, id);
physics_fixture_delete(fix);

/// @func clamp01_1(x)
/// @desc Пропорционально сжимает x из диапазона [xmin..xmax] в [0.1..1] (логарифмически).
/// @param x
function clamp01_1(x) {
    var xmin = 0.05;
    var xmax = 20000;

    // защита: лог требует > 0
    var xx = clamp(x, xmin, xmax);

    var t = (ln(xx) - ln(xmin)) / (ln(xmax) - ln(xmin));
    t = clamp(t, 0, 1);

    return lerp(0.1, 1.0, t);
}
