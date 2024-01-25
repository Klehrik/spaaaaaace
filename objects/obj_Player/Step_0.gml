/// Step

// Destroy
if (Hull <= 0)
{
	for (var n = 0; n < 4; n++) part_particles_create(global.PartSys, x + irandom_range(-16, 16), y + irandom_range(-16, 16), global.Part3, 1);
	instance_destroy();
}

// Turning and other movement variables
var dir = point_direction(x, y, mouse_x, mouse_y);

var ang = sign(angle_difference(image_angle, dir));
if (angle_difference(image_angle, dir) < 0) image_angle += TurnSpeed * ((abs(HSP) + abs(VSP)) / (MoveSpeed * 2));
else if (angle_difference(image_angle, dir) > 0) image_angle -= TurnSpeed * ((abs(HSP) + abs(VSP)) / (MoveSpeed * 2));
if (ang != sign(angle_difference(image_angle, dir))) image_angle = dir;

var acc = MoveSpeed / 40;

// Accelerate
if (mouse_check_button(mb_left) and global.LMBDown == 0 and Appear <= -9)
{
	HSP += dcos(image_angle) * acc;
	VSP -= dsin(image_angle) * acc;
}
else
{
	if (HSP != 0) HSP -= sign(HSP) * 0.02;
	if (VSP != 0) VSP -= sign(VSP) * 0.02;
	if (abs(HSP) <= 0.02) HSP = 0;
	if (abs(VSP) <= 0.02) VSP = 0;
}

// High-speed after images
if (global.DT mod 4 == 0 and (HSP < -MoveSpeed - 1 or HSP > MoveSpeed + 1 or VSP < -MoveSpeed - 1 or VSP > MoveSpeed + 1))
{
	part_type_colour1(global.PartShip, image_blend);
	part_type_orientation(global.PartShip, image_angle, image_angle, 0, 0, 0);
	part_particles_create(global.PartSys2, x, y, global.PartShip, 1);
}
if (HSP < -MoveSpeed) HSP += acc * 2;
if (HSP > MoveSpeed) HSP -= acc * 2;
if (VSP < -MoveSpeed) VSP += acc * 2;
if (VSP > MoveSpeed) VSP -= acc * 2;

x += HSP;
y += VSP;

// (abs(HSP) + abs(VSP)) / MoveSpeed

// Stay in-bounds
if (x < 0) { x = 0; HSP /= 1.2; }
else if (x > global.MapSizeX) { x = global.MapSizeX; HSP /= 1.2; }
if (y < 0) { y = 0; VSP /= 1.2; }
else if (y > global.MapSizeY) { y = global.MapSizeY; VSP /= 1.2; }



// Dash
if (DashT > 0) DashT -= 1;
if (keyboard_check(vk_space) and DashT <= 0 and Appear <= -9)
{
	mouse_clear(mb_right);
	DashT = DashCooldown;
	HSP = max(HSP + dcos(image_angle) * MoveSpeed * 1.6, dcos(image_angle) * MoveSpeed * 2.5);
	VSP = max(VSP - dsin(image_angle) * MoveSpeed * 1.6, -dsin(image_angle) * MoveSpeed * 2.5);
}



// Shoot
if (Appear <= -9)
{
	if (Weps[0] > 0 and (weapon_is_laser(Equip[0]) == 0 or Laser[0] <= 0)) Weps[0] -= 1;
	if (Weps[1] > 0 and (weapon_is_laser(Equip[1]) == 0 or Laser[1] <= 0)) Weps[1] -= 1;
	if (Weps[2] > 0 and (weapon_is_laser(Equip[2]) == 0 or Laser[2] <= 0)) Weps[2] -= 1;

	if (keyboard_check(ord("1")) and Equip[0] >= 0 and Weps[0] <= 0) Weps[0] = fire_weapon(Equip[0], 1);
	if (keyboard_check(ord("2")) and Equip[1] >= 0 and Weps[1] <= 0) Weps[1] = fire_weapon(Equip[1], 2);
	if (keyboard_check(ord("3")) and Equip[2] >= 0 and Weps[2] <= 0) Weps[2] = fire_weapon(Equip[2], 3);
}