/// Init

depth = -5000;

global.DT = 0;

global.CamX = 0;
global.CamY = 0;
global.CamW = camera_get_view_width(view_camera);
global.CamH = camera_get_view_height(view_camera);

global.Follow = obj_Player;

global.LMBDown = 0;

global.Text = ds_list_create();
//ds_list_add(global.Text, ["Name", "Text test\nLine 2", 102, 0, 12.5]); // name, text, y, open, alpha

LockView = -1;
Map = 0;
MapOpen = -1;
MapType = -1;
SInfo = 0;
SInfoOpen = -1;
SInfoShip = 0;

SInfoSelectShip = -1; // Move around items in storage
SInfoSelectSlot = -1;

WarpDrive = 20 * 60;
WarpDriveMax = WarpDrive;

GroupSeePlayer = []; // Check if a group of ships as a whole has the player within view
GroupSeePlayerCount = [];

//Asteroids = [];
//for (var n = 0; n < 200; n++)
//{
//	Asteroids[n] = [irandom_range(0, global.MapSizeX), irandom_range(0, global.MapSizeY), random_range(1, 4)];
//}

//for (var n = 0; n < array_length(Asteroids); n++)
//{
//	var a = instance_create_depth(Asteroids[n][0], Asteroids[n][1], 0, obj_Asteroid);
//	a.Size = Asteroids[n][2];
//}

var system = global.StarMap[? global.Location];
for (var n = 0; n < array_length(system); n++)
{
	var a = instance_create_depth(system[n][0], system[n][1], 0, obj_Asteroid);
	a.Size = system[n][2];
}