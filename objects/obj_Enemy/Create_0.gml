/// Init

image_blend = c_white;
Group = 0;
Leader = 0;
Destination = [irandom_range(0, global.MapSizeX), irandom_range(0, global.MapSizeY)];

Scan = 1600;
PointerWait = 6;

HSP = 0;
VSP = 0;

Name = "Rebel";
Team = 2;

x = 4900 + random_range(-50, 50);
y = 5000 + random_range(-50, 50);

Hull = 10;
Shield = 5;
MaxHull = Hull;
MaxShield = Shield;
ShieldRegenRate = 1;
ShieldRegen = 0;

TurnSpeed = 6//3;
MoveSpeed = 6//4;
DashCooldown = 240;
DashT = 0;

//Wep1 = [0, 0]; // ID, Cooldown
//Wep2 = [-1, 0]; // ID, Cooldown
//Wep3 = [-1, 0]; // ID, Cooldown

Equip = [0, -1, -1, // Weapons
-1, -1, // Systems
-1, -1]; // Storage
Weps = [0, 0, 0]; // Weapon cooldowns
Laser = [0, 0, 0];
LaserType = [0, 0, 0];

//Storage = [-1, -1, -1];

Hull = 20;
Shield = 10;
MaxHull = Hull;
MaxShield = Shield;
do Equip[0] = irandom_range(0, 11); until Equip[0] != 9;
do Equip[1] = irandom_range(0, 11); until Equip[1] != 9;
do Equip[2] = irandom_range(0, 11); until Equip[2] != 9;

//Equip[0] = 2;
//Equip[1] = 3;
//Equip[2] = 9;

// testing
//Hull = 20;
//MaxHull = 20;
//Shield = 80;
//MaxShield = 80;
//ShieldRegenRate = 12;
//ShieldRegen = 0;

//TurnSpeed = 6;
//MoveSpeed = 6;
//DashCooldown = 180;
//DashT = 0;

//Wep1 = [1, 0]; // ID, Cooldown
//Wep2 = [4, 0]; // ID, Cooldown
//Wep3 = [4, 0]; // ID, Cooldown

State = 0;

LeanPref = choose(-1, 1);

Appear = -10;