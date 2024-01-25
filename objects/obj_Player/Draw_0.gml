/// Draw

if (Appear > -10) Appear -= 1;

if (Appear == 20) part_particles_create(global.PartSys, x, y, global.PartWarp, 1);
if (Appear <= 0)
{
	// Shield Bubble
	if (Shield > 0)
	{
		var c = c_aqua;
		draw_set_alpha(abs(sin(global.DT / 60) / 6) + 0.3);
		draw_circle_colour(x, y, 28, c, c, 0);
		draw_set_alpha(1);
	}

	// Laser Sight
	if (Equip[3] == 100 or Equip[4] == 100)
	{
		var _x = x;
		var _y = y;
	
		do
		{
			_x += dcos(image_angle) * 4;
			_y -= dsin(image_angle) * 4;
		}
		until collision_point(_x, _y, obj_Ship, 1, 1) or collision_point(_x, _y, obj_Asteroid, 1, 1) or _x < global.CamX or _x > global.CamX + global.CamW or _y < global.CamY or _y > global.CamY + global.CamH;
	
		draw_set_alpha(0.7);
		draw_line_colour(x, y, _x, _y, c_fuchsia, c_fuchsia);
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

	draw_self();
}