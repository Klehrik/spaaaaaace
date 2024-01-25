/// Asteroid Management

global.DT += 1;

if (!instance_exists(global.Follow))
{
	with (obj_Enemy) PointerWait = 6;
	Map = 0;
	MapOpen = -1;
	SInfo = 0;
	SInfoOpen = -1;
}

if (instance_exists(obj_Player)) global.Follow = obj_Player;
else global.Follow = instance_find(obj_Enemy, 0);



// What this does: Allows a group of ships to send a *single* message to the player when greeting

if (global.DT < 90) { with (obj_Enemy) { other.GroupSeePlayer[Group] = 0; other.GroupSeePlayerCount[Group] = -1; } } // Set main array
// Get view player state of each ship this frame and use it to update the main array (after 6 frames)
else
{
	with (obj_Enemy) { other.GroupSeePlayerTemp[Group] = 0; } // Set temp array
	with (obj_Enemy) // Update temp array
	{
		if (point_distance(x, y, global.Follow.x, global.Follow.y) <= Scan) other.GroupSeePlayerTemp[Group] = 1;
	}
	with (obj_Enemy) // Update main array
	{
		if (other.GroupSeePlayerTemp[Group] == 0) other.GroupSeePlayer[Group] = 0;
		else if (other.GroupSeePlayerTemp[Group] == 1)
		{
			other.GroupSeePlayerTemp[Group] = 2; // Make sure no other ship of the group tampers with the updated value
		
			if (other.GroupSeePlayer[Group] == 0) { other.GroupSeePlayer[Group] = 1; other.GroupSeePlayerCount[Group] += 1; } // Greet for 1 frame
			else other.GroupSeePlayer[Group] = 2; // Lock player viewing until the player leaves
		}
	}
}

InCombat = 0;

with (obj_Enemy)
{
	if (point_distance(x, y, global.Follow.x, global.Follow.y) <= Scan)
	{
		if (Team != global.Follow.Team) other.InCombat = 1;
		
		if (other.GroupSeePlayer[Group] == 1 and global.Follow.object_index == obj_Player and global.DT >= 90)
		{
			if (Team == 1) ds_list_add(global.Text, [Name, ally_blue_text(other.GroupSeePlayerCount[Group]), 102, 0, 7.7, c_blue]);
			else ds_list_add(global.Text, [Name, enemy_red_text(other.GroupSeePlayerCount[Group]), 102, 0, 7.7, c_red]);
			//with (obj_Enemy) { if (Group == other.Group) SeePlayerCount += 1; }
		}
		//if (global.DT >= 6) SeePlayer = 1;
	}
	//else SeePlayer = -1;
}



instance_activate_object(obj_Asteroid);
with (obj_Asteroid) { if (point_distance(x, y, global.Follow.x, global.Follow.y) > global.Follow.Scan) instance_deactivate_object(self); }



// LMBDown - prevent player from moving when pressing menu buttons
global.LMBDown = 0;

var buttons = ds_list_create();

// Map + Ship Info
var tx = global.CamX + global.CamW / 2 - 300; // Top left corner of screen
var ty = global.CamY + global.CamH / 2 - 300;

// Map - Switch button
if (Map >= 50) ds_list_add(buttons, [global.CamX + global.CamW / 2 + 205, global.CamY + global.CamH / 2 - 320, global.CamX + global.CamW / 2 + 290, global.CamY + global.CamH / 2 - 280]);

// Ship Info - Equipment slots
if (SInfo >= 100)
{
	for (var _x = 79; _x <= 79 + 112; _x += 56) ds_list_add(buttons, [tx + _x, ty + 232, tx + _x + 48, ty + 280]);
	for (var _x = 276; _x <= 276 + 56; _x += 56) ds_list_add(buttons, [tx + _x, ty + 232, tx + _x + 48, ty + 280]);
	for (var _x = 417; _x <= 417 + 56; _x += 56) ds_list_add(buttons, [tx + _x, ty + 232, tx + _x + 48, ty + 280]);
}

// Check if LMB is being pressed within one of the buttons
if (mouse_check_button(mb_left))
{
	for (var n = 0; n < ds_list_size(buttons); n++)
	{
		var b = buttons[| n];
		if (point_in_rectangle(mouse_x, mouse_y, b[0], b[1], b[2], b[3])) { global.LMBDown = 1; break }
	}
}

ds_list_destroy(buttons);