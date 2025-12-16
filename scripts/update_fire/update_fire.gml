// Скрипт для обновления состояния частиц огня
function update_fire(_obj) {
    with (_obj) {
        // Проверяем, нужно ли уничтожить частицу
        if (s <= 0 || image_alpha <= 0) {
            instance_destroy();
            exit;
        }

        // Обновляем параметры движения
        // speed = speed + acceleration - friction
        f += deceleration;
        s += acceleration;
        s -= f;
        if (s < 0) s = 0;

        // Двигаем частицу (полярка) + "гравитация" вниз
        x += lengthdir_x(s, d);
        y += lengthdir_y(s, d) + g;

        // Обновляем вращение и масштаб
        angle_speed += angle_acceleration;
        scale_speed += scale_acceleration;

        image_angle  += angle_speed;
        image_xscale += scale_speed;
        image_yscale += scale_speed;

        // Вычисляем динамику для изменения цвета и прозрачности
        dynamics = acceleration - f;
        var _progress = clamp(abs(dynamics) / acceleration, 0, 1);
        var _color = 255 - lerp(255, 0, _progress);

        // Меняем цвет и альфа-канал в зависимости от динамики
        if (dynamics >= 0) { 
            image_blend = make_color_rgb(255, _color, 0);
            image_alpha = _progress;
        } else {
			//instance_destroy();
            image_blend = make_color_rgb(_color, _color, _color);
        }
    }
}
