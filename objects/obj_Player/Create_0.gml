/// Init

image_blend = c_aqua;
ID = 0;

x = global.MapSizeX / 2;
y = global.MapSizeY / 2;

HSP = 0;
VSP = 0;

Appear = 90;

Name = global.Party[? 0][0];
Team = global.Party[? 0][1];

Hull = global.Party[? 0][2];
MaxHull = global.Party[? 0][3];
MaxShield = global.Party[? 0][4];
Shield = MaxShield;
ShieldRegenRate = global.Party[? 0][5];
ShieldRegen = 0;

TurnSpeed = global.Party[? 0][6];
MoveSpeed = global.Party[? 0][7];
DashCooldown = global.Party[? 0][8];
DashT = 0;

//Wep1 = [global.Party[? 0][10], 0]; // ID, Cooldown
//Wep2 = [global.Party[? 0][11], 0]; // ID, Cooldown
//Wep3 = [global.Party[? 0][12], 0]; // ID, Cooldown

//Storage = [global.Party[? 0][13], global.Party[? 0][14], global.Party[? 0][15]];

Equip = [global.Party[? 0][9], global.Party[? 0][10], global.Party[? 0][11], // Weapons
global.Party[? 0][12], global.Party[? 0][13], // Systems
global.Party[? 0][14], global.Party[? 0][15]]; // Storage
Weps = [0, 0, 0]; // Weapon cooldowns
Laser = [0, 0, 0];
LaserType = [0, 0, 0];

Scan = global.Party[? 0][16];

// name      allegiance      HL, mHL, mSL, SLreg   turn, move, dash   weps (3)   systems (2)   storage (2)   scan (id 16)

//Sights = global.Party[? 0][17];

//Wep1 = [global.WepSel[0], 0]; // ID, Cooldown
//Wep2 = [global.WepSel[1], 0]; // ID, Cooldown
//Wep3 = [global.WepSel[2], 0]; // ID, Cooldown

// sus
//if (Wep1[0] == 9 or Wep2[0] == 9 or Wep3[0] == 9)
//{
//	Hull = 4;
//	Shield = 1;
//	MaxHull = Hull;
//	MaxShield = Shield;
//}

// Starter Ship Ideas

// Dart
// Hull, Shield (Regen) - 12, 8 (1.6/sec. - 38 fr.)
// Turn, Move, Dash - 3, 4, 3 sec.
// Weapons - Light Shot, Backburst

// Heavy
// Hull, Shield (Regen) - 20, 10 (1/sec. - 60 fr.)
// Turn, Move, Dash - 2, 3, 4 sec.
// Weapons - Light Shot, Dual Shot

// Hunter
// Hull, Shield (Regen) - 4, 8 (1/sec. - 60 fr.)
// Turn, Move, Dash - 4, 4, 3 sec.
// Weapons - Railgun, Backburst
// + Laser Sight

//// default
//Hull = 20;
//MaxHull = 20;
//Shield = 10;
//MaxShield = 10;
//ShieldRegenRate = 60;
//ShieldRegen = 0;

//TurnSpeed = 3;
//MoveSpeed = 4;
//DashCooldown = 180;
//DashT = 0;

//Wep1 = [1, 0]; // ID, Cooldown
//Wep2 = [4, 0]; // ID, Cooldown
//Wep3 = [5, 0]; // ID, Cooldown
//Sights = 0;

//for (var n = 0; n < 10; n++) instance_create_depth(irandom_range(0, global.MapSizeX), irandom_range(0, global.MapSizeY), 0, obj_Enemy);
//for (var n = 0; n < 9; n++)
//{
//	var e = instance_create_depth(irandom_range(4000, 6000), irandom_range(4000, 6000), 0, obj_Enemy);
//	if (n < 4) e.Team = 1;
//}

//for (var n = 1; n <= 5; n++)
//{
//	do
//	{
//		var _x = irandom_range(0, global.MapSizeX);
//		var _y = irandom_range(0, global.MapSizeY);
//	}
//	until point_distance(global.MapSizeX / 2, global.MapSizeY / 2, _x, _y) > Scan + 400;
//	var t = (n mod 2) + 1;
	
//	var e = instance_create_depth(_x + irandom_range(-200, 200), _y + irandom_range(-200, 200), 0, obj_Enemy);
//	e.ID = global.IDCount;
//	global.IDCount += 1;
//	e.Team = t;
//	e.Group = n;
//	e.Leader = e.id;
//	var e_id = e.id;
//	for (var c = 0; c < irandom_range(3, 4); c++)
//	{
//		var e = instance_create_depth(_x + irandom_range(-200, 200), _y + irandom_range(-200, 200), 0, obj_Enemy);
//		e.ID = global.IDCount;
//		global.IDCount += 1;
//		e.Team = t;
//		e.Group = n;
//		e.Leader = e_id;
//	}
//}