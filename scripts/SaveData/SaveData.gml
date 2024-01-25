/// Save Data

function save_party()
{
	// Player
	
	// name      allegiance      HL, mHL, mSL, SLreg   turn, move, dash   weps (3)   systems (2)   storage (2)   scan (id 16)
	var p = obj_Player;
	if (instance_exists(p)) global.Party[? 0] = [p.Name, p.Team,
	p.Hull, p.MaxHull, p.MaxShield, p.ShieldRegenRate,
	p.TurnSpeed, p.MoveSpeed, p.DashCooldown,
	p.Equip[0], p.Equip[1], p.Equip[2],
	p.Equip[3], p.Equip[4],
	p.Equip[5], p.Equip[6],
	p.Scan];
}

function save_system()
{
	// Asteroids
	instance_activate_object(obj_Asteroid);
	global.StarMap[? global.Location] = [];
	for (var b = 0; b < instance_number(obj_Asteroid); b++)
	{
		var a = instance_find(obj_Asteroid, b);
		global.StarMap[? global.Location][b] = [a.x, a.y, a.Size];
	}
}