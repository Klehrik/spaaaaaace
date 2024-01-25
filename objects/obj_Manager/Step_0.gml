/// Step

// Camera
if (instance_exists(global.Follow))
{
	if (LockView < 0)
	{
		var dir = point_direction(global.Follow.x, global.Follow.y, mouse_x, mouse_y);
		var dist = point_distance(global.Follow.x, global.Follow.y, mouse_x, mouse_y) / 2.5;
		global.CamX = global.Follow.x - global.CamW / 2 + dcos(dir) * dist;
		global.CamY = global.Follow.y - global.CamH / 2 - dsin(dir) * dist;
	}
	else
	{
		global.CamX = global.Follow.x - global.CamW / 2;
		global.CamY = global.Follow.y - global.CamH / 2;
	}
}
camera_set_view_pos(view_camera, global.CamX, global.CamY);



// Music
if (!audio_is_playing(global.Music1)) // Pick new tracks once the current ones have ended
{
	//do var m = irandom_range(0, array_length(global.MusicTravelList) - 1);
	//until global.Music != m;
	
	global.Music += 1;
	if (global.Music >= array_length(global.MusicTravelList)) global.Music = 0;
	
	//global.Music = m;
	
	global.Music1 = audio_play_sound(global.MusicTravelList[global.Music], 0, 0);
	global.Music2 = audio_play_sound(global.MusicBattleList[global.Music], 0, 0);
}

if (keyboard_check_pressed(189)) global.MusVol -= 0.1;
if (keyboard_check_pressed(187)) global.MusVol += 0.1;
global.MusVol = clamp(global.MusVol, 0, 1);

if (InCombat >= 1)
{
    if (global.Music1Vol > 0) global.Music1Vol -= 0.007 * global.MusVol;
    if (global.Music2Vol < global.MusVol) global.Music2Vol += 0.007 * global.MusVol;
}
else
{
    if (global.Music1Vol < global.MusVol) global.Music1Vol += 0.007 * global.MusVol;
    if (global.Music2Vol > 0) global.Music2Vol -= 0.007 * global.MusVol;
}

global.Music1Vol = clamp(global.Music1Vol, 0, global.MusVol);
global.Music2Vol = clamp(global.Music2Vol, 0, global.MusVol);
audio_sound_gain(global.Music1, global.Music1Vol, 0);
audio_sound_gain(global.Music2, global.Music2Vol, 0);