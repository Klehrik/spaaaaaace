/// Misc

function item_name(ID)
{
	if (ID < 100) // Weapon
	{
		var names = ["Light Shot", "Dual Shot", "Spitfire", "Burst", "Railgun",
		"Backburst", "Sidefire", "Hull Laser", "Shieldbreaker", "Tachyon Beam",
		"Light Missiles", "Multi-Missiles"];
		return names[ID];
	}
	else if (ID < 200) // System
	{
		var names = ["Sight"];
		return names[ID - 100];
	}
}

function item_desc(ID)
{
	if (ID < 100) // Weapon
	{
		var desc = ["A basic blaster found on\nmost ships.", // Light Shot
		"Fires two projectiles.", // Dual Shot
		"Fires a frenzy of\ninaccurate projectiles.", // Spitfire
		"Fires a large burst of\nprojectiles.", // Burst
		"Highly-accurate and\ndamaging but takes time to\nfire.", // Railgun
		"Allows for greater mobility,\nespecially when turning.", // Backburst
		"Fires a burst of projectiles\nfrom both sides.", // Sidefire
		"Can rip through a ship's\nhull, but cannot bypass\nshields.", // Hull Laser
		"Breaks a portion of a ship's\nshield. More effective\nagainst ships with high\nshields.", // Shieldbreaker
		"A prototype weapon that\ncan deal devastating\namounts of damage.", // sus Laser
		"Fires two homing missiles.", // Light Missiles
		"Fires a barrage of homing\nmissiles.", // Multi-Missiles
		];
		return desc[ID];
	}
	else if (ID < 200) // System
	{
		var desc = ["Assists with aiming."];
		return desc[ID - 100];
	}
}

function item_type(ID)
{
	if (ID < 100) return "Weapon";
	else if (ID < 200) return "System";
	else return "Other";
}

function item_sprite(ID)
{
	if (ID < 100) // Weapon
	{
		return [spr_WepIcons, ID];
	}
	else if (ID < 200) // System
	{
		return [spr_SysIcons, ID - 100];
	}
}

function team_name(ID)
{
	teams = ["None", "Galactic Fleet", "Rebel Army"];
	return teams[ID];
}