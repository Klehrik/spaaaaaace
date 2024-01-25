/// Weapons

function fire_weapon(ID, Slot)
{
	switch (ID)
	{
		case 0: // Light Shot - damage: 1
			var p = instance_create_depth(x, y, 0, obj_Proj);
			p.Dir = image_angle;
			p.Spd = 16;
			p.Damage = 1;
			p.image_blend = image_blend;
			p.Team = Team;
			break;
		
		case 1: // Dual Shot - total damage: 2
			for (var a = -2; a <= 2; a += 4)
			{
				var p = instance_create_depth(x, y, 0, obj_Proj);
				p.Dir = image_angle + a;
				p.Spd = 16;
				p.Damage = 1;
				p.image_blend = image_blend;
				p.Team = Team;
			}
			break;
			
		case 2: // Spitfire - damage: 1
			var p = instance_create_depth(x, y, 0, obj_Proj);
			p.Dir = image_angle + random_range(-8, 8);
			p.Spd = 16;
			p.Damage = 1;
			p.image_blend = image_blend;
			p.Team = Team;
			break;
			
		case 3: // Burst - total damage: 12
			for (var n = 0; n < 12; n++)
			{
				var p = instance_create_depth(x, y, 0, obj_Proj);
				p.Dir = image_angle + random_range(-8, 8);
				p.Spd = random_range(6, 12);
				p.Damage = 1;
				p.image_blend = image_blend;
				p.Team = Team;
			}
			HSP -= dcos(image_angle) * MoveSpeed * 0.8;
			VSP += dsin(image_angle) * MoveSpeed * 0.8;
			break;
			
		case 4: // Railgun - damage: 8
			var p = instance_create_depth(x, y, 0, obj_Proj);
			p.Dir = image_angle;
			p.Spd = 24;
			p.Damage = 8;
			p.Img = 1;
			p.image_blend = image_blend;
			p.image_xscale = 3;
			p.Team = Team;
			break;
			
		case 5: // Backburst - total damage: 4
			for (var n = 0; n < 4; n++)
			{
				var p = instance_create_depth(x, y, 0, obj_Proj);
				p.Dir = image_angle + 180 + random_range(-40, 40);
				p.Spd = random_range(4, 8);
				p.Damage = 1;
				p.image_blend = image_blend;
				p.Team = Team;
			}
			HSP += dcos(image_angle) * MoveSpeed * 0.8;
			VSP -= dsin(image_angle) * MoveSpeed * 0.8;
			break;
			
		case 6: // Sidefire - total damage: 16
			for (var a = 90; a <= 270; a += 180)
			{
				for (var n = 0; n < 8; n++)
				{
					var p = instance_create_depth(x, y, 0, obj_Proj);
					p.Dir = image_angle + a + random_range(-20, 20);
					p.Spd = random_range(6, 12);
					p.Damage = 1;
					p.image_blend = image_blend;
					p.Team = Team;
				}
			}
			break;
			
		case 7: // Hull Laser - damage per 7 frames: 1 - duration: 120 frames - cannot damage shields
			Laser[Slot - 1] = 120;
			LaserType[Slot - 1] = 0;
			break;
			
		case 8: // Shieldbreaker - damage: MaxShield * 0.4 - 1 damage to hull
			var p = instance_create_depth(x, y, 0, obj_Proj);
			p.Dir = image_angle;
			p.Spd = 12;
			p.Damage = 1;
			p.Img = 1;
			p.SB = 1;
			p.image_blend = image_blend;
			p.image_xscale = 2;
			p.image_yscale = 2;
			p.Team = Team;
			break;
			
		case 9: // Tachyon Beam
			Laser[Slot - 1] = 90;
			LaserType[Slot - 1] = 1;
			break;
			
		case 10: // Light Missiles - total damage: 6
			for (n = image_angle - 45; n <= image_angle + 45; n += 90)
			{
				var p = instance_create_depth(x, y, 0, obj_Proj);
				p.Type = 1;
				p.Spd = 10;
				p.Damage = 3;
				p.Img = 2;
				p.image_blend = image_blend;
				p.Team = Team;
				p.Life *= 2;
				with (p) { image_angle = n; motion_set(image_angle, Spd); }
			}
			break;
			
		case 11: // Multi-Missiles - total damage: 14
			for (n = 0; n < 7; n++)
			{
				var p = instance_create_depth(x, y, 0, obj_Proj);
				p.Type = 1;
				p.Spd = 10 - (n / 2);
				p.Damage = 2;
				p.Img = 2;
				p.image_blend = image_blend;
				p.Team = Team;
				p.Life *= 2;
				with (p) { image_angle = other.image_angle + irandom_range(-60, 60); motion_set(image_angle, Spd); }
			}
			break;
	}
	
	return weapon_cooldown(ID);
}

function weapon_cooldown(ID)
{
	// lS, dS, spitF, Burst, Rail, BBurst, sideF, hullL, SBrk, tacL, lM, mM
	var cooldowns = [40, 60, 20, 160, 180, 90, 120, 240, 200, 840, 140, 300];
	return cooldowns[ID];
}

function weapon_direction_min(ID)
{
	// lS, dS, spitF, Burst, Rail, BBurst, sideF, hullL, SBrk, tacL, lM, mM
	var directions = [0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0];
	return directions[ID];
}

function weapon_direction_max(ID)
{
	// lS, dS, spitF, Burst, Rail, BBurst, sideF, hullL, SBrk, tacL, lM, mM
	var directions = [5, 5, 5, 5, 5, 5, 110, 7, 5, 0, 360, 360];
	return directions[ID];
}

function weapon_range(ID)
{
	// lS, dS, spitF, Burst, Rail, BBurst, sideF, hullL, SBrk, tacL, lM, mM
	var range = [1280, 1280, 1280, 960, 1920, 9999, 960, 960, 960, 960, 960, 960];
	return range[ID];
}

function weapon_is_laser(ID)
{
	// lS, dS, spitF, Burst, Rail, BBurst, sideF, hullL, SBrk, tacL, lM, mM
	var range = [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0];
	return range[ID];
}

//function weapon_speed(ID)
//{
//	var speeds = [16, 16, 16, 9, 24, 6, 9, 16, 12];
//	return speeds[ID];
//}