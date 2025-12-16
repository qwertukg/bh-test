// obj_GravityWorld: Create

// параметры
global.PTM		= 0.1
global.BH_G     = 0.4;
global.BH_THETA = 0.4;
global.BH_DT    = 0.01;
global.BH_SOFT  = 4.0;

// границы дерева (под комнату)
tree_cx = room_width * 0.5;
tree_cy = room_height * 0.5;
tree_hw = max(room_width, room_height) * 0.6;

min_hw = 2.0;
root = undefined;

// ---- глобальный конструктор узла квадродерева ----
global.BH_Node = function(_cx, _cy, _hw) constructor {
    cx = _cx; cy = _cy; hw = _hw;

    mass = 0.0;
    cmx = 0.0;
    cmy = 0.0;

    body = noone; // instance id тела в листе (если лист с 1 телом)
    child = array_create(4, undefined);

    is_leaf = function() { return (child[0] == undefined); };

    contains = function(px, py) {
        return (px >= cx - hw && px < cx + hw && py >= cy - hw && py < cy + hw);
    };

    quad_index = function(px, py) {
        var east  = (px >= cx);
        var south = (py >= cy);
        if (!east && !south) return 0; // NW
        if ( east && !south) return 1; // NE
        if (!east &&  south) return 2; // SW
        return 3;                      // SE
    };

    subdivide = function() {
        var q = hw * 0.5;
        child[0] = new global.BH_Node(cx - q, cy - q, q);
        child[1] = new global.BH_Node(cx + q, cy - q, q);
        child[2] = new global.BH_Node(cx - q, cy + q, q);
        child[3] = new global.BH_Node(cx + q, cy + q, q);
    };

    add_mass = function(bid) {
        var m2 = bid.mass;
        var newm = mass + m2;
        if (newm > 0) {
            cmx = (cmx * mass + bid.x * m2) / newm;
            cmy = (cmy * mass + bid.y * m2) / newm;
        }
        mass = newm;
    };

    insert = function(bid, _min_hw) {
        if (!contains(bid.x, bid.y)) return false;

        add_mass(bid);

        // минимальный размер — дальше не делим
        if (hw <= _min_hw) {
            if (body == noone) body = bid; // если уже занято — оставим как есть (масса/CM уже учтены)
            return true;
        }

        if (is_leaf()) {
            if (body == noone) {
                body = bid;
                return true;
            } else {
                var old = body;
                body = noone;
                subdivide();

                var qi_old = quad_index(old.x, old.y);
                child[qi_old].insert(old, _min_hw);

                var qi_new = quad_index(bid.x, bid.y);
                child[qi_new].insert(bid, _min_hw);
                return true;
            }
        } else {
            var qi = quad_index(bid.x, bid.y);
            return child[qi].insert(bid, _min_hw);
        }
    };
};

// построение дерева
bh_build = function(bodies_arr) {
    var r = new global.BH_Node(tree_cx, tree_cy, tree_hw);
    var n = array_length(bodies_arr);
    for (var i = 0; i < n; i++) r.insert(bodies_arr[i], min_hw);
    return r;
};

// сила от узла к телу
bh_apply = function(node, bid) {
    if (node == undefined) return;
    if (node.mass <= 0) return;

    // лист
    if (node.is_leaf()) {
        var oid = node.body;
        if (oid == noone) return;
        if (oid == bid) return;

        var dx = oid.x - bid.x;
        var dy = oid.y - bid.y;

        var soft = max(global.BH_SOFT, (bid.diameter + oid.diameter) * 0.5);
        var r2 = dx*dx + dy*dy + soft*soft;

        var inv_r = 1.0 / sqrt(r2);
        var inv_r3 = inv_r * inv_r * inv_r;

        var f = global.BH_G * bid.mass * oid.mass * inv_r3;
        bid.fx += dx * f;
        bid.fy += dy * f;
        return;
    }

    // внутренний узел (theta)
    var dxm = node.cmx - bid.x;
    var dym = node.cmy - bid.y;

    var softm = max(global.BH_SOFT, bid.diameter * 0.5);
    var r2m = dxm*dxm + dym*dym + softm*softm;
    var d = sqrt(r2m);

    var s = node.hw * 2.0;

    if ((s / d) < global.BH_THETA) {
        var inv_r = 1.0 / d;
        var inv_r3 = inv_r * inv_r * inv_r;
        var f = global.BH_G * bid.mass * node.mass * inv_r3;
        bid.fx += dxm * f;
        bid.fy += dym * f;
    } else {
        bh_apply(node.child[0], bid);
        bh_apply(node.child[1], bid);
        bh_apply(node.child[2], bid);
        bh_apply(node.child[3], bid);
    }
};





// 1/32 = 32 пикселя считаются за 1 метр (рекомендованный пример из мануала).
physics_world_create(global.PTM); // (pixeltometrescale) :contentReference[oaicite:0]{index=0}

// Гравитация (в метрах/сек^2). Можно поставить (0,0) если “космос”.
physics_world_gravity(0, 0); // (xg, yg) :contentReference[oaicite:1]{index=1}
