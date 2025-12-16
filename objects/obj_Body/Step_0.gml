/// obj_Body: Step (physics)

var dt = global.BH_DT;

// Импульс J = F * dt  (эквивалент твоему dv = (F/m)*dt)
physics_apply_impulse(x, y, fx * dt, fy * dt);

// обнуляем аккумуляторы сил на следующий шаг
fx = 0.0;
fy = 0.0;
