/// Draw

// Pointer
if (PointerWait > 0) PointerWait -= 1;

var on = 1;
if (on == 1 and instance_exists(global.Follow) and PointerWait <= 0 and point_distance(x, y, global.Follow.x, global.Follow.y) <= Scan)
{
	if (global.DT > 6 and (x < global.CamX - 16 or x > global.CamX + global.CamW + 16 or y < global.CamY - 16 or y > global.CamY + global.CamH + 16))
	{
		var dir = point_direction(x, y, global.Follow.x, global.Follow.y);
		var _x = x;
		var _y = y;
		if (point_distance(x, y, global.Follow.x, global.Follow.y) > 800)
		{
			_x += dcos(dir) * (point_distance(x, y, global.Follow.x, global.Follow.y) - 800);
			_y -= dsin(dir) * (point_distance(x, y, global.Follow.x, global.Follow.y) - 800);
		}
		var loop = 0;
		var loop2 = point_distance(_x, _y, global.Follow.x, global.Follow.y) / 1.8;
		while (loop < loop2 and (_x < global.CamX + 24 or _x > global.CamX + global.CamW - 24 or _y < global.CamY + 24 or _y > global.CamY + global.CamH - 24))
		{
			loop += 1;
			_x += dcos(dir) * 2;
			_y -= dsin(dir) * 2;
		}
		
		draw_sprite_ext(spr_Pointer, 0, _x, _y, 1, 1, dir - 180, image_blend, 1);
	}
}

// Shield Bubble
if (Shield > 0)
{
	draw_set_alpha(abs(sin(global.DT / 60) / 6) + 0.3);
	draw_circle_colour(x, y, 28, image_blend, image_blend, 0);
	draw_set_alpha(1);
}

// Lasers
for (var n = 0; n <= 2; n++)
{
	if (Laser[n] > 0)
	{
		Laser[n] -= 1;
	
		if (LaserType[n] == 0) // Hull Laser
		{
			var _x = x;
			var _y = y;
	
			do
			{
				_x += dcos(image_angle) * 4;
				_y -= dsin(image_angle) * 4;
			}
			until collision_point(_x, _y, obj_Ship, 1, 1) or collision_point(_x, _y, obj_Asteroid, 1, 1) or point_distance(x, y, _x, _y) > 960;
	
			if (Laser[n] >= 104) draw_set_alpha((120 - Laser[n]) / 16);
			else if (Laser[n] <= 16) draw_set_alpha(Laser[n] / 16);
			draw_line_width_color(x, y, _x, _y, 6, image_blend, image_blend);
			draw_set_alpha(1);
	
	
	
			// Deal damage
			var hit = 0;
			if (collision_point(_x, _y, obj_Ship, 1, 1)) hit = collision_point(_x, _y, obj_Ship, 1, 1);
	
			if (hit > 0 and Laser[n] mod 7 == 0 and hit.Team != Team)
			{
				with (hit)
				{
					if (Shield <= 0) { Hull -= 1; ShieldRegen = regen; }
	
					part_particles_create(global.PartSys, _x, _y, global.Part1, 1);
				}
			}
		}
		
		else // Tachyon Beam
		{
			var _x = x;
			var _y = y;
	
			do
			{
				_x += dcos(image_angle) * 4;
				_y -= dsin(image_angle) * 4;
			}
			until collision_point(_x, _y, obj_Ship, 1, 1) or collision_point(_x, _y, obj_Asteroid, 1, 1) or point_distance(x, y, _x, _y) > 960;
	
			if (Laser[n] >= 74) draw_set_alpha((90 - Laser[n]) / 16);
			else if (Laser[n] <= 16) draw_set_alpha(Laser[n] / 16);
			var c = make_color_hsv((global.DT mod 171) * 1.5, 255, 255);
			draw_line_width_color(x, y, _x, _y, 6, c, c);
			draw_set_alpha(1);
	
	
	
			// Deal damage
			var hit = 0;
			if (collision_point(_x, _y, obj_Ship, 1, 1)) hit = collision_point(_x, _y, obj_Ship, 1, 1);
	
			if (hit > 0 and hit.Team != Team)
			{
				with (hit)
				{
					if (Shield > 0) { if (Laser[n] mod 15 == 0) Shield = clamp(Shield - 1, 0, MaxShield); }
					else Hull -= 1;
					
					ShieldRegen = regen;
	
					part_particles_create(global.PartSys, _x, _y, global.Part1, 1);
				}
			}
			
			var ahit = 0;
			if (collision_point(_x, _y, obj_Asteroid, 1, 1)) ahit = collision_point(_x, _y, obj_Asteroid, 1, 1);
	
			if (ahit > 0 and Laser[n] mod 15 == 0)
			{
				with (ahit)
				{
					Size -= 0.1;
					part_particles_create(global.PartSys, _x, _y, global.Part1, 1);
				}
			}
		}
	}
}

// Stats
if (Hull > 0) draw_rectangle_colour(x - 18, y + 24, x - 18 + (Hull / MaxHull) * 36, y + 32, c_green, c_green, c_green, c_green, 0);
if (Shield > 0)
{
	var sw = (Shield / MaxShield) * 40;
	draw_rectangle_colour(x - 20, y + 24, x - 20 + sw, y + 32, c_blue, c_blue, c_blue, c_blue, 0);
	draw_line(x - 20 + sw, y + 24, x - 20 + sw, y + 32);
}
draw_rectangle(x - 20, y + 24, x + 20, y + 32, 1);

// debug
//var len = 700 / TurnSpeed * (MoveSpeed / 4);
//var movedir = point_direction(x, y, x + HSP, y + VSP);
//for (var n = -8; n < 8; n += 4)
//{
//	draw_line(x, y, x + dcos(movedir + n) * len, y - dsin(movedir + n) * len);
//}

//var dir = point_direction(x, y, obj_Player.x, obj_Player.y);
//draw_text(x, y - 32, abs(HSP) + abs(VSP));
//draw_text(x, y - 48, abs(angle_difference(image_angle, dir)));

//draw_line(x, y, x + dcos(DEBUG) * 100, y - dsin(DEBUG) * 100);

draw_self();

// leader sign (test)
//if (Leader == id) draw_circle(x, y, 4, 0);