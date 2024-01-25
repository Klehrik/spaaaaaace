/// Step

switch (Type)
{	
	case 0: // Main proj
		motion_set(Dir, Spd);
		image_angle = Dir;
		break;
		
	case 1: // Missiles
		if (TargetDelay > 0) TargetDelay -= 1;
		else
		{
			TargetDelay = 10;
			
			for (var n = 1; n <= instance_number(obj_Ship); n++)
			{
				Target = instance_nth_nearest(x, y, obj_Ship, n);
				if (Target.Team != Team and point_distance(x, y, Target.x, Target.y) <= 990) break;
			}
		}
		if (instance_exists(Target))
		{
			var dir = point_direction(x, y, Target.x, Target.y);
			var ang = sign(angle_difference(image_angle, dir));
			if (angle_difference(image_angle, dir) < 0) image_angle += 2;
			else if (angle_difference(image_angle, dir) > 0) image_angle -= 2;
			if (ang != sign(angle_difference(image_angle, dir))) image_angle = dir;
			motion_set(image_angle, Spd);
		}
		break;
}

if (Spd > 0) image_alpha = 1;

if (Img > 0 and global.DT mod Img == 0 and point_in_rectangle(x, y, global.CamX - 16, global.CamY - 16, global.CamX + global.CamW + 16, global.CamY + global.CamH + 16))
{
	part_type_colour1(global.PartProj, image_blend);
	part_type_orientation(global.PartProj, image_angle, image_angle, 0, 0, 0);
	part_particles_create(global.PartSys2, x, y, global.PartProj, 1);
}

Life -= 1;
if (Life <= 0) { part_particles_create(global.PartSys, x, y, global.Part1, 1); instance_destroy(); }