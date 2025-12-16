/// obj_Body: Create

mass = 1.0;
diameter = 4.0;

vx = 0.0;
vy = 0.0;

fx = 0.0;
fy = 0.0;

// ----------------------
// physics fixture
// ----------------------
var fix = physics_fixture_create();

// круг (удобно для планет/астероидов)
var r = diameter * 0.5;
physics_fixture_set_circle_shape(fix, r);

// физ. параметры
physics_fixture_set_density(fix, 1);     // плотность (масса будет из area*density)
physics_fixture_set_restitution(fix, 0); // без упругости
physics_fixture_set_friction(fix, 0);    // без трения

// прикрепить к инстансу
physics_fixture_bind(fix, id);

// чтобы не “засыпали”
physics_fixture_set_awake(fix, false);

// fixture больше не нужен
physics_fixture_delete(fix);



