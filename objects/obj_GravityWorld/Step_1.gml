// obj_GravityWorld: Begin Step

// собрать все тела (все наследники obj_Body)
var n = instance_number(obj_Body);
if (n <= 0) exit;

bodies = array_create(n);
_collect_i = 0;
with (obj_Body) {
    other.bodies[other._collect_i] = id;
    other._collect_i++;
}

// сброс сил
for (var i = 0; i < n; i++) {
    var bid = bodies[i];
    bid.fx = 0.0;
    bid.fy = 0.0;
}

// дерево
root = bh_build(bodies);

// силы (Barnes–Hut)
for (var i = 0; i < n; i++) {
    bh_apply(root, bodies[i]);
}
