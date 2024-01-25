/// Init

randomize();

//global.WepSel = [0, 0, 0];
//sel = 0;

global.MapSizeX = 9999;
global.MapSizeY = 9999;

global.StarMap = ds_map_create();

var pointsListX = [];
var pointsListY = [];
global.StarMapList = [];
for (var a = 0; a < 20; a++)
{
	// Select points that are not close to other points
	do
	{
		var _x = irandom_range(600, 9399);
		var _y = irandom_range(600, 9399);
	
		var near = 0;
		for (var n = 0; n < array_length(pointsListX); n++)
		{
			if (point_distance(_x, _y, pointsListX[n], pointsListY[n]) < 400) near = 1;
		}
	}
	until near == 0;
	
	pointsListX[a] = real(_x);
	pointsListY[a] = real(_y);
	
	_x = string(_x);
	_y = string(_y);
	while (string_length(_x) < 4) _x = "0" + _x;
	while (string_length(_y) < 4) _y = "0" + _y;
	var str = _x + " " + _y;
	
	global.StarMap[? str] = [];
	for (var n = 0; n < 200; n++) // Create asteroids
	{
		global.StarMap[? str][n] = [irandom_range(0, global.MapSizeX), irandom_range(0, global.MapSizeY), random_range(1, 4)];
	}
	
	global.StarMapList[a] = str;
}
global.Location = global.StarMapList[0];

global.IDCount = 1;

global.Party = ds_map_create();
//                    name   team   HL, mHL, mSL, SLreg   turn, move, dash   weps (3)   systems (2)   storage (2)   scan (id 16)
global.Party[? 0] = ["Kris",  1,      20, 20, 10, 1,        3, 4, 180,       2, 4, 5,     -1, -1,       9, 100,      2000];
global.PartyList = ds_list_create();
global.PartyList[| 0] = 0;

//var system = global.StarMap[? "0000 0000"];
//for (var n = 0; n < array_length(system[n]); n++)
//{
//	var a = instance_create_depth(system[n][0], system[n][1], 0, obj_Asteroid);
//	a.Size = system[n][2];
//}

global.PartSys = part_system_create();
part_system_depth(global.PartSys, -1000);

global.PartSys2 = part_system_create();
part_system_depth(global.PartSys2, 900);

// Small white circle (standard)
global.Part1 = part_type_create();
part_type_shape(global.Part1, pt_shape_disk);
part_type_size(global.Part1, 0, 0, 0.018, 0);
part_type_alpha2(global.Part1, 1, 0);
part_type_life(global.Part1, 25, 25);

// Medium white circle (asteroids, etc.)
global.Part2 = part_type_create();
part_type_shape(global.Part2, pt_shape_disk);
part_type_size(global.Part2, 0, 0, 0.04, 0);
part_type_alpha2(global.Part2, 1, 0);
part_type_life(global.Part2, 30, 30);

// Small-medium orange circle (ship destruction, etc.)
global.Part3 = part_type_create();
part_type_shape(global.Part3, pt_shape_disk);
part_type_size(global.Part3, 0, 0, 0.03, 0);
part_type_alpha2(global.Part3, 1, 0);
part_type_colour1(global.Part3, c_orange);
part_type_life(global.Part3, 40, 40);

// Ship after-image
global.PartShip = part_type_create();
part_type_sprite(global.PartShip, spr_Ship, 0, 0, 0);
part_type_alpha2(global.PartShip, 1, 0);
part_type_life(global.PartShip, 25, 25);

// Proj after-image
global.PartProj = part_type_create();
part_type_sprite(global.PartProj, spr_Proj, 0, 0, 0);
part_type_alpha2(global.PartProj, 1, 0);
part_type_life(global.PartProj, 14, 14);

// Warp
global.PartWarp = part_type_create();
part_type_shape(global.PartWarp, pt_shape_disk);
part_type_size(global.PartWarp, 0, 0, 0.06, 0);
part_type_alpha3(global.PartWarp, 1, 1, 0);
part_type_colour2(global.PartWarp, c_white, c_orange);
part_type_life(global.PartWarp, 60, 60);



global.Music = irandom_range(0, 2);
global.MusicTravelList = [mus_Travel1, mus_Travel2, mus_Travel3];
global.MusicBattleList = [mus_Battle1, mus_Battle2, mus_Battle3];
global.Music1 = audio_play_sound(global.MusicTravelList[global.Music], 0, 0);
global.Music2 = audio_play_sound(global.MusicBattleList[global.Music], 0, 0);
global.MusVol = 0.1;
global.Music1Vol = global.MusVol;
global.Music2Vol = 0;
audio_sound_gain(global.Music2, 0, 0);



room_goto(rm_World2);