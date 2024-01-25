/// Step

// Team Management
if (Team == 1) { image_blend = c_blue; Name = "Fleet Ship"; }
else if (Team == 2) image_blend = c_red;

// Destroy
if (Hull <= 0)
{
	for (var n = 0; n < 4; n++) part_particles_create(global.PartSys, x + irandom_range(-16, 16), y + irandom_range(-16, 16), global.Part3, 1);
	instance_destroy();
}



var s = noone;
	
// Get nearest enemy
for (var n = 2; n <= instance_number(obj_Ship); n++) // start at 2 to avoid self
{
	var sh = instance_nth_nearest(x, y, obj_Ship, n);
		
	if (point_distance(x, y, sh.x, sh.y) <= Scan)
	{
		if (Team > 0 and sh.Team != Team)
		{
			s = sh;
			break;
		}
	}
	else break;
}
	
var acc = MoveSpeed / 40;
	
// Intercept
if (s != noone)
{
	if (Laser[0] + Laser[1] + Laser[2] <= 0)
	{
		var pv = point_direction(s.x, s.y, s.x + s.HSP, s.y + s.VSP);
		var dist = point_distance(x, y, s.x, s.y);
		var spd = abs(s.HSP) + abs(s.VSP);
		
		if (spd > 1)
		{
			var _x = s.x + dcos(pv) * dist / sqrt(spd);
			var _y = s.y - dsin(pv) * dist / sqrt(spd);
		}
		else
		{
			var _x = s.x + dcos(pv) * dist * sqrt(spd);
			var _y = s.y - dsin(pv) * dist * sqrt(spd);
		}
		var dir = point_direction(x, y, _x, _y);
	}
	else var dir = point_direction(x, y, s.x, s.y);
}
else // Follow the leader
{
	if (!instance_exists(Leader))
	{
		Leader = id;
		with (obj_Enemy) { if (Group == other.Group) Leader = other.id; }
	}
		
	if (Leader == id)
	{
		var dir = point_direction(x, y, Destination[0], Destination[1]);
		if (point_distance(x, y, Destination[0], Destination[1]) < 400) Destination = [irandom_range(0, global.MapSizeX), irandom_range(0, global.MapSizeY)];
	}
	else
	{
		if (instance_exists(Leader)) var dir = point_direction(x, y, Leader.x, Leader.y);
		else var dir = point_direction(x, y, x + HSP, y + VSP);
	}
}



// AI
var cone = 0;
// (abs(HSP) + abs(VSP)) / MoveSpeed due to the fact that diagonal movement is double speed (at max caps)
var len = max((abs(HSP) + abs(VSP)) / MoveSpeed * 700, 700) / TurnSpeed * (MoveSpeed / 4);
var movedir = point_direction(x, y, x + HSP, y + VSP);
for (var n = -10; n <= 10; n += 5)
{
	if (collision_line(x, y, x + dcos(movedir + n) * len, y - dsin(movedir + n) * len, obj_Ship, 0, 1))
	{
		cone = 1;
		var colobj = collision_line(x, y, x + dcos(movedir + n) * len, y - dsin(movedir + n) * len, obj_Ship, 0, 1);
	}
	if (collision_line(x, y, x + dcos(movedir + n) * len, y - dsin(movedir + n) * len, obj_Asteroid, 0, 1))
	{
		cone = 1;
		var colobj = collision_line(x, y, x + dcos(movedir + n) * len, y - dsin(movedir + n) * len, obj_Asteroid, 0, 1);
	}
}
	
if (s != noone)
{
	if (cone) State = 3; // Avoid ships
	else if (abs(angle_difference(image_angle, dir) > 90)) State = 2; // Turn around (target behind)
	else if (point_distance(x, y, s.x, s.y) < 240 and abs(HSP) + abs(VSP) > 3) State = 0; // Idle slow
	else State = 2; // Chase target
}
else
{
	if (cone) State = 3; // Avoid ships
	else State = 2; // Idle slow
}
	
// Lean Pref Switch
if (global.DT mod 240 == 0) LeanPref *= -1;

// Behaviors
switch (State)
{
	case 0: // Slow down
		if (HSP != 0) HSP -= sign(HSP) * 0.02;
		if (VSP != 0) VSP -= sign(VSP) * 0.02;
		if (abs(HSP) <= 0.02) HSP = 0;
		if (abs(VSP) <= 0.02) VSP = 0;
		
		Move = 0;
		break;
		
	case 1: // Idle move
		Move = 1;
		break;
		
	case 2: // Chase target
		var ang = sign(angle_difference(image_angle, dir));
		if (angle_difference(image_angle, dir) < 0) image_angle += TurnSpeed * ((abs(HSP) + abs(VSP)) / (MoveSpeed * 2));
		else if (angle_difference(image_angle, dir) > 0) image_angle -= TurnSpeed * ((abs(HSP) + abs(VSP)) / (MoveSpeed * 2));
		if (ang != sign(angle_difference(image_angle, dir))) image_angle = dir;
		
		Move = 1;
		break;
		
	case 3: // Avoid collision
		//image_angle += (TurnSpeed * ((abs(HSP) + abs(VSP)) / (MoveSpeed * 2)) / 1.2) * LeanPref
		image_angle += (TurnSpeed * ((abs(HSP) + abs(VSP)) / (MoveSpeed * 2)) / 1.2) * sign(angle_difference(image_angle, point_direction(x, y, colobj.x, colobj.y)));
		
		Move = 1;
		break;
}



// Change Velocities
if (Move == 1)
{
	HSP += dcos(image_angle) * acc;
	VSP -= dsin(image_angle) * acc;
}



// Movement
if ((HSP < -MoveSpeed - 1 or HSP > MoveSpeed + 1 or VSP < -MoveSpeed - 1 or VSP > MoveSpeed + 1) and
point_in_rectangle(x, y, global.CamX - 16, global.CamY - 16, global.CamX + global.CamW + 16, global.CamY + global.CamH + 16))
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
	
// Stay in-bounds
if (x < 0) { x = 0; HSP /= 1.2; }
else if (x > global.MapSizeX) { x = global.MapSizeX; HSP /= 1.2; }
if (y < 0) { y = 0; VSP /= 1.2; }
else if (y > global.MapSizeY) { y = global.MapSizeY; VSP /= 1.2; }



// Shoot
if (Weps[0] > 0 and (weapon_is_laser(Equip[0]) == 0 or Laser[0] <= 0)) Weps[0] -= 1;
if (Weps[1] > 0 and (weapon_is_laser(Equip[1]) == 0 or Laser[1] <= 0)) Weps[1] -= 1;
if (Weps[2] > 0 and (weapon_is_laser(Equip[2]) == 0 or Laser[2] <= 0)) Weps[2] -= 1;
	
if (s != noone)
{
	var alt = 1; // alternate firing the same weapon (eg. don't fire two railguns at once)
	var shoot = 0;
	if (abs(angle_difference(image_angle, dir)) >= weapon_direction_min(Equip[0]) and abs(angle_difference(image_angle, dir)) <= weapon_direction_max(Equip[0])) shoot = 1;
	var in_range = 0;
	if (point_distance(x, y, s.x, s.y) <= weapon_range(Equip[0])) in_range = 1;
	if (Equip[0] >= 0)
	{
		if (Equip[0] == Equip[1]) { if (Weps[1] >= weapon_cooldown(Equip[1]) * 0.6) alt = 0; }
		if (Equip[0] == Equip[2]) { if (Weps[2] >= weapon_cooldown(Equip[2]) * 0.6) alt = 0; }
	}
	if (Equip[0] >= 0 and Weps[0] <= 0 and alt == 1 and shoot == 1 and in_range == 1) Weps[0] = fire_weapon(Equip[0], 1);
		
	var alt = 1; // alternate firing the same weapon (eg. don't fire two railguns at once)
	var shoot = 0;
	if (abs(angle_difference(image_angle, dir)) >= weapon_direction_min(Equip[1]) and abs(angle_difference(image_angle, dir)) <= weapon_direction_max(Equip[1])) shoot = 1;
	var in_range = 0;
	if (point_distance(x, y, s.x, s.y) <= weapon_range(Equip[1])) in_range = 1;
	if (Equip[1] >= 0)
	{
		if (Equip[1] == Equip[0]) { if (Weps[0] >= weapon_cooldown(Equip[0]) * 0.6) alt = 0; }
		if (Equip[1] == Equip[2]) { if (Weps[2] >= weapon_cooldown(Equip[2]) * 0.6) alt = 0; }
	}
	if (Equip[1] >= 0 and Weps[1] <= 0 and alt == 1 and shoot == 1 and in_range == 1) Weps[1] = fire_weapon(Equip[1], 2);
		
	var alt = 1; // alternate firing the same weapon (eg. don't fire two railguns at once)
	var shoot = 0;
	if (abs(angle_difference(image_angle, dir)) >= weapon_direction_min(Equip[2]) and abs(angle_difference(image_angle, dir)) <= weapon_direction_max(Equip[2])) shoot = 1;
	var in_range = 0;
	if (point_distance(x, y, s.x, s.y) <= weapon_range(Equip[2])) in_range = 1;
	if (Equip[2] >= 0)
	{
		if (Equip[2] == Equip[0]) { if (Weps[0] >= weapon_cooldown(Equip[0]) * 0.6) alt = 0; }
		if (Equip[2] == Equip[1]) { if (Weps[1] >= weapon_cooldown(Equip[1]) * 0.6) alt = 0; }
	}
	if (Equip[2] >= 0 and Weps[2] <= 0 and alt == 1 and shoot == 1 and in_range == 1) Weps[2] = fire_weapon(Equip[2], 3);
}