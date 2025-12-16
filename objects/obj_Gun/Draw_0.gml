/// obj_Gun : Draw
draw_self();

if (dragging) {
    // линия от пушки к мыши
	draw_set_color(c_red)
    draw_line_width(lx, ly, mouse_x, mouse_y, 1);
	draw_set_color(c_white)


    // "сила" (сколько натянули)
    var d = point_distance(lx, ly, mouse_x, mouse_y);
    d = min(d, max_drag);
}
