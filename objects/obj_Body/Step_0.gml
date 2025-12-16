if (fixed) {
    physics_set_linear_velocity(0, 0);
    exit;
}

physics_apply_force(fx, fy);
