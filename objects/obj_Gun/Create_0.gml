/// obj_Gun : Create

// что спавним
bullet_obj   = obj_Rocket;
bullet_layer = "Instances";

// настройки выстрела
max_drag    = 220;   // максимум "силы" (в пикселях)
speed_mult  = 0.08;  // множитель скорости пули (подбери)
cooldown    = 6;     // в шагах
_cd         = 0;

// drag state
dragging    = false;
drag_start_x = 0;
drag_start_y = 0;

lx = 0
ly = 0

