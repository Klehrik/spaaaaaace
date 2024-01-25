/// Draw

draw_set_font(fnt_Calibri);
draw_set_circle_precision(64);

var s = global.Follow;

// Map Borders
if (instance_exists(s))
{
	var dist = s.x; // left border
	if (s.y < dist) dist = s.y; // top border
	if (global.MapSizeX - s.x < dist) dist = global.MapSizeX - s.x; // right border
	if (global.MapSizeY - s.y < dist) dist = global.MapSizeY - s.y; // bottom border

	draw_set_alpha(0.7 - min(dist / 600 * 0.7, 0.7));
	draw_rectangle(0, 0, global.MapSizeX, global.MapSizeY, 1);
	draw_set_alpha(1);
}



// FPS
var blue = 0;
var red = 0;
with (obj_Enemy) { if (Team == 1) blue += 1; else red += 1; }

var mus_name = ["Civil", "Milkyway", "Cosmos"];
mus_name = mus_name[global.Music];

draw_text(global.CamX + 10, global.CamY + 10, string(round(fps_real)) + " / Instances: " + string(instance_count) + " / Blue Ships: " + string(blue) + " / Red Ships: " + string(red));
draw_text(global.CamX + 10, global.CamY + 34, "Current Music: " + mus_name + " / Volume: " + string(floor(global.MusVol * 10)) + " (-/+ to adjust)");
draw_text(global.CamX + 10, global.CamY + 58, "T - Lock View");
draw_text(global.CamX + 10, global.CamY + 82, "C - Map");
draw_text(global.CamX + 10, global.CamY + 106, "S - Ship Info");
draw_text(global.CamX + 10, global.CamY + 130, "R - Reset Game");

//show_debug_overlay(1);

// Text
var bx = global.CamX + global.CamW;
var by = global.CamY + global.CamH;

for (var n = 0; n < ds_list_size(global.Text); n++)
{	
	var _y = 102 * (ds_list_size(global.Text) - n);
	if (global.Text[| n][2] < _y) global.Text[| n][2] += (_y - global.Text[| n][2]) / 12;
	if (global.Text[| n][2] > _y - 1) global.Text[| n][2] = _y;
	
	if (global.Text[| n][3] < 100) global.Text[| n][3] += 4; // Open box
	
	var t = global.Text[| n];
	
	draw_set_alpha(min(0.5 * t[4], 0.5));
	//draw_rectangle_colour(bx - 356, by - t[2], bx - 16, by - t[2] + 86, c_black, c_black, c_black, c_black, 0);
	if (t[3] < 50) draw_rectangle_colour(bx - 186 - (t[3] / 50 * 170), by - t[2] + 51, bx - 186 + (t[3] / 50 * 170), by - t[2] + 51, c_black, c_black, c_black, c_black, 0);
	else draw_rectangle_colour(bx - 356, by - t[2] + 43 - ((t[3] - 50) / 50 * 43), bx - 16, by - t[2] + 43 + ((t[3] - 50) / 50 * 43), c_black, c_black, c_black, c_black, 0);
	
	draw_set_alpha(t[4]);
	//draw_rectangle(bx - 356, by - t[2], bx - 16, by - t[2] + 86, 1);
	if (t[3] < 50) draw_rectangle(bx - 186 - (t[3] / 50 * 170), by - t[2] + 51, bx - 186 + (t[3] / 50 * 170), by - t[2] + 51, 1);
	else draw_rectangle(bx - 356, by - t[2] + 43 - ((t[3] - 50) / 50 * 43), bx - 16, by - t[2] + 43 + ((t[3] - 50) / 50 * 43), 1);
	
	if (t[3] >= 100)
	{
		draw_text_colour(bx - 346, by - t[2] + 8, t[0], t[5], t[5], t[5], t[5], min(t[4], 1));
		draw_text(bx - 346, by - t[2] + 34, t[1]);
	}
	
	// Text boxes exceeding 3 will disappear within 1.6 seconds
	if (n < ds_list_size(global.Text) - 3 and global.Text[| n][4] > 2) global.Text[| n][4] = 2;
	
	global.Text[| n][4] -= 0.02;
	if (global.Text[| n][4] <= 0) 
	{
		t = global.Text[| n];
		ds_list_delete(global.Text, ds_list_find_index(global.Text, t));
	}
}
draw_set_alpha(1);

//draw_set_alpha(0.6);
//draw_rectangle_colour(bx - 356, by - 102, bx - 16, by - 16, c_black, c_black, c_black, c_black, 0);
//draw_set_alpha(1);
//draw_rectangle(bx - 356, by - 102, bx - 16, by - 16, 1);
//draw_text_colour(bx - 346, by - 94, "Naughtius Maximus", c_red, c_red, c_red, c_red, 1);
//draw_text(bx - 346, by - 68, "Hey! This is private property!\nGet out of here before I make you!");

//draw_rectangle(bx - 356, by - 204, bx - 16, by - 118, 1);

//draw_rectangle(bx - 356, by - 306, bx - 16, by - 220, 1);



if (instance_exists(s))
{
	// HUD: Hull
	for (var n = 0; n < s.MaxHull; n++)
	{
		var _y = global.CamH - 112;
		if (n >= (s.MaxHull / 4) * 3) _y -= 12;
		else if (n >= s.MaxHull / 2) _y -= 8;
		else if (n >= s.MaxHull / 4) _y -= 4;
	
		if (n < s.Hull) draw_rectangle_colour(global.CamX + 16 + (n / s.MaxHull) * 240, global.CamY + _y, global.CamX + 15 + ((n + 1) / s.MaxHull) * 240, global.CamY + 668, c_green, c_green, c_green, c_green, 0);
		draw_rectangle(global.CamX + 16 + (n / s.MaxHull) * 240, global.CamY + _y, global.CamX + 15 + ((n + 1) / s.MaxHull) * 240, global.CamY + 668, 1);
	}

	// HUD: Shield
	var _y = global.CamH - 88;
	draw_rectangle_colour(global.CamX + 16, global.CamY + _y, global.CamX + 15 + (s.Shield / s.MaxShield) * 176, global.CamY + _y + 12, c_blue, c_blue, c_blue, c_blue, 0);
	for (var n = 0; n < s.MaxShield; n++)
	{
		//var _y = global.CamH - 88;
		//if (n < s.Shield) draw_rectangle_colour(global.CamX + 16 + (n / s.MaxShield) * 176, global.CamY + _y, global.CamX + 15 + ((n + 1) / s.MaxShield) * 176, global.CamY + _y + 12, c_blue, c_blue, c_blue, c_blue, 0);
		draw_rectangle(global.CamX + 16 + (n / s.MaxShield) * 176, global.CamY + _y, global.CamX + 15 + ((n + 1) / s.MaxShield) * 176, global.CamY + _y + 12, 1);
	}

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	// HUD: Weapons
	var _y = global.CamH - 16;
	if (s.Equip[0] >= 0) draw_rectangle_colour(global.CamX + 16, global.CamY + _y - (s.Weps[0] / weapon_cooldown(s.Equip[0])) * 48, global.CamX + 64, global.CamY + _y, c_gray, c_gray, c_gray, c_gray, 0);
	if (s.Equip[1] >= 0) draw_rectangle_colour(global.CamX + 80, global.CamY + _y - (s.Weps[1] / weapon_cooldown(s.Equip[1])) * 48, global.CamX + 128, global.CamY + _y, c_gray, c_gray, c_gray, c_gray, 0);
	if (s.Equip[2] >= 0) draw_rectangle_colour(global.CamX + 144, global.CamY + _y - (s.Weps[2] / weapon_cooldown(s.Equip[2])) * 48, global.CamX + 192, global.CamY + _y, c_gray, c_gray, c_gray, c_gray, 0);
	for (var _x = 16; _x <= 144; _x += 64)
	{
		var c = c_white;
		if (_x == 16 and s.Weps[0] > 0
		or _x == 80 and s.Weps[1] > 0
		or _x == 144 and s.Weps[2] > 0) c = c_gray;
		draw_rectangle_colour(global.CamX + _x, global.CamY + _y - 48, global.CamX + _x + 48, global.CamY + _y, c, c, c, c, 1); // Borders
	}
	if (s.Equip[0] >= 0) draw_sprite(spr_WepIcons, s.Equip[0], global.CamX + 28, global.CamY + global.CamH - 52); // Icons
	if (s.Equip[1] >= 0) draw_sprite(spr_WepIcons, s.Equip[1], global.CamX + 92, global.CamY + global.CamH - 52);
	if (s.Equip[2] >= 0) draw_sprite(spr_WepIcons, s.Equip[2], global.CamX + 156, global.CamY + global.CamH - 52);
	draw_text(global.CamX + 40, global.CamY + _y, "1"); // Text
	draw_text(global.CamX + 104, global.CamY + _y, "2");
	draw_text(global.CamX + 168, global.CamY + _y, "3");

	// HUD: Dash
	draw_rectangle_colour(global.CamX + 208, global.CamY + _y - (s.DashT / s.DashCooldown) * 72, global.CamX + 256, global.CamY + _y, c_gray, c_gray, c_gray, c_gray, 0);
	draw_rectangle(global.CamX + 208, global.CamY + _y - 72, global.CamX + 256, global.CamY + _y, 1);
	draw_sprite(spr_DashIcon, 0, global.CamX + 220, global.CamY + _y - 48);
	draw_text(global.CamX + 232, global.CamY + _y, "Space");

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);



	_y = 30;
	
	var tx = global.CamX + global.CamW / 2 - 300; // Top left corner of screen
	var ty = global.CamY + global.CamH / 2 - 300;

	// Map
	if (global.DT >= 99 and WarpDrive > 0) WarpDrive -= 1; // global.DT >= 99 -> wait for player to appear
	
	if (keyboard_check_pressed(ord("C")) and SInfo <= 0) { MapOpen *= -1; MapType = -1; }
	Map = clamp(Map + MapOpen * 4, 0, 100);

	draw_set_alpha(Map / 100 * 0.6);
	var c = c_black;
	draw_rectangle_colour(global.CamX, global.CamY, global.CamX + global.CamW, global.CamY + global.CamH, c, c, c, c, 0);
	draw_set_alpha(1);

	if (Map < 50) draw_line(global.CamX + global.CamW / 2 - Map * 6, global.CamY + global.CamH / 2 + _y, global.CamX + global.CamW / 2 + Map * 6, global.CamY + global.CamH / 2 + _y);
	else draw_rectangle(global.CamX + global.CamW / 2 - 300, global.CamY + global.CamH / 2 - (Map - 50) * 6 + _y, global.CamX + global.CamW / 2 + 300, global.CamY + global.CamH / 2 + (Map - 50) * 6 + _y, 1);
	
	if (Map >= 100)
	{	
		if (MapType == -1) // System Map
		{
			draw_text_transformed(global.CamX + global.CamW / 2 - 290, global.CamY + global.CamH / 2 - 300 + _y - 50, "System Map", 2, 2, 0);
	
			draw_circle_colour(tx + s.x / global.MapSizeX * 600, ty + s.y / global.MapSizeY * 600 + _y, 4, c_aqua, c_aqua, 0); // Player
	
			var sc = global.Follow.Scan;
	
			with (obj_Asteroid)
			{
				if (point_distance(x, y, s.x, s.y) <= sc)
				{
					with (obj_Manager) draw_circle_colour(tx + other.x / global.MapSizeX * 600, ty + other.y / global.MapSizeY * 600 + _y, other.Size / 1.2, $4f575f, $4f575f, 0);
				}
			}
	
			with (obj_Enemy)
			{
				if (point_distance(x, y, s.x, s.y) <= sc)
				{
					with (obj_Manager) draw_circle_colour(tx + other.x / global.MapSizeX * 600, ty + other.y / global.MapSizeY * 600 + _y, 4, other.image_blend, other.image_blend, 0);
				}
			}
	
			// Scan range
			draw_set_alpha(0.2 + abs(sin(global.DT / 90)) * 0.4);
			draw_circle(tx + s.x / global.MapSizeX * 600, ty + s.y / global.MapSizeY * 600 + _y, sc / 16.6, 1);
			draw_set_alpha(1);
		}
		
		else if (MapType == 1) // Star Map
		{
			draw_text_transformed(global.CamX + global.CamW / 2 - 290, global.CamY + global.CamH / 2 - 350 + _y, "Star Map", 2, 2, 0);
			
			// Warp Drive bar
			c = c_gray;
			if (WarpDrive <= 0) c = c_white;
			draw_rectangle_colour(global.CamX + global.CamW / 2 - 100, global.CamY + global.CamH / 2 - 340 + _y, global.CamX + global.CamW / 2 - 100 + (1 - (WarpDrive / WarpDriveMax)) * 280, global.CamY + global.CamH / 2 - 315 + _y, c, c, c, c, 0);
			draw_rectangle(global.CamX + global.CamW / 2 - 100, global.CamY + global.CamH / 2 - 340 + _y, global.CamX + global.CamW / 2 + 180, global.CamY + global.CamH / 2 - 315 + _y, 1);
			draw_set_halign(fa_center);
			draw_text_colour(global.CamX + global.CamW / 2 + 42, global.CamY + global.CamH / 2 - 337 + _y, "Warp Drive", c_black, c_black, c_black, c_black, 1);
			draw_text(global.CamX + global.CamW / 2 + 40, global.CamY + global.CamH / 2 - 339 + _y, "Warp Drive");
			draw_set_halign(fa_left);
			
			var tooltip = "";
			
			// System points
			for (var n = 0; n < array_length(global.StarMapList); n++)
			{
				var xx = real(string_copy(global.StarMapList[n], 1, 4));
				var yy = real(string_copy(global.StarMapList[n], 6, 4));
				
				if (global.Location == global.StarMapList[n]) draw_circle_colour(tx + xx / 9999 * 600, ty + yy / 9999 * 600 + _y, 6, c_white, c_white, 0);
				else draw_circle_colour(tx + xx / 9999 * 600, ty + yy / 9999 * 600 + _y, 4, $4f575f, $4f575f, 0);
				
				// Mouse
				if (point_distance(mouse_x, mouse_y, tx + xx / 9999 * 600, ty + yy / 9999 * 600 + _y) <= 10)
				{
					// Outline and tooltip set
					draw_circle_colour(tx + xx / 9999 * 600, ty + yy / 9999 * 600 + _y, 9 + abs(sin(global.DT / 80)) * 2, c_white, c_white, 1);
					tooltip = global.StarMapList[n];
					
					if (mouse_check_button_pressed(mb_left) and global.Location != global.StarMapList[n] and WarpDrive <= 0)// and InCombat <= 0) // Jump to system
					{
						// Save data
						save_party();
						save_system();
						global.Location = global.StarMapList[n];
						room_goto(rm_World);
					}
				}
			}
			
			// Tooltip (system info)
			if (tooltip != "")
			{
				var l = mouse_x + 10; // left
				var t = mouse_y + 10; // top
				var w = 200; // width
				var h = 200; // height
				
				if (floor(l + w) > global.CamX + global.CamW) l = mouse_x - 10 - w;
				if (floor(t + h) > global.CamY + global.CamH) t = mouse_y - 10 - h;
				
				draw_rectangle_colour(l, t, l + w, t + h, c_black, c_black, c_black, c_black, 0);
				draw_rectangle(l, t, l + w, t + h, 1);
				
				var xx = string(real(string_copy(tooltip, 1, 4)));
				var yy = string(real(string_copy(tooltip, 6, 4)));
				
				draw_text(l + 10, t + 10, "Location: " + xx + ", " + yy);
				
				// Warp text
				if (tooltip == global.Location) draw_text(l + 10, t + 40, "ALREADY HERE");
				//else if (InCombat >= 1) draw_text(l + 10, t + 40, "SHIP IN COMBAT");
				else if (WarpDrive > 0) draw_text(l + 10, t + 40, "CHARGING...");
				else draw_text(l + 10, t + 40, "CLICK TO WARP");
			}
		}
		
		
		
		// Switch maps
		draw_rectangle(global.CamX + global.CamW / 2 + 205, global.CamY + global.CamH / 2 - 350 + _y, global.CamX + global.CamW / 2 + 290, global.CamY + global.CamH / 2 - 310 + _y, 1);
		draw_text(global.CamX + global.CamW / 2 + 215, global.CamY + global.CamH / 2 - 341 + _y, "(S)witch");
		
		var rect = point_in_rectangle(mouse_x, mouse_y, global.CamX + global.CamW / 2 + 205, global.CamY + global.CamH / 2 - 350 + _y, global.CamX + global.CamW / 2 + 290, global.CamY + global.CamH / 2 - 310 + _y);
		if ((mouse_check_button_pressed(mb_left) and rect)
		or keyboard_check_pressed(ord("S"))) // Button
		{
			Map = 50;
			MapType *= -1;
		}
	}
	
	
	
	// Ship Info
	if (keyboard_check_pressed(ord("S")) and Map <= 0 and instance_exists(obj_Player)) { SInfoOpen *= -1; SInfoShip = 0; SInfoSelectShip = -1; SInfoSelectSlot = -1; }
	if (InCombat == 1) SInfoOpen = -1; // Prevent opening during combat
	SInfo = clamp(SInfo + SInfoOpen * 4, 0, 100);

	draw_set_alpha(SInfo / 100 * 0.6);
	var c = c_black;
	draw_rectangle_colour(global.CamX, global.CamY, global.CamX + global.CamW, global.CamY + global.CamH, c, c, c, c, 0);
	draw_set_alpha(1);

	if (SInfo < 50) draw_line(global.CamX + global.CamW / 2 - SInfo * 6, global.CamY + global.CamH / 2 + _y, global.CamX + global.CamW / 2 + SInfo * 6, global.CamY + global.CamH / 2 + _y);
	else draw_rectangle(global.CamX + global.CamW / 2 - 300, global.CamY + global.CamH / 2 - (SInfo - 50) * 6 + _y, global.CamX + global.CamW / 2 + 300, global.CamY + global.CamH / 2 + (SInfo - 50) * 6 + _y, 1);
	
	if (SInfo >= 100)
	{
		draw_text_transformed(global.CamX + global.CamW / 2 - 290, global.CamY + global.CamH / 2 - 350 + _y, "Ship Info", 2, 2, 0);
		
		for (var n = 0; n < instance_number(obj_Ship); n++) // Find ship to view
		{
			var s = instance_find(obj_Ship, n);
			if (s.ID == SInfoShip) break;
		}
		
		// Text
		var size = 1.3;
		
		draw_text_transformed(tx + 24, ty + 20 + _y, "Name:", size, size, 0);
		draw_text_transformed(tx + 24, ty + 60 + _y, "Allegiance:", size, size, 0);
		draw_text_transformed(tx + 164, ty + 20 + _y, s.Name, size, size, 0);
		draw_text_transformed(tx + 164, ty + 60 + _y, team_name(s.Team), size, size, 0);
		//draw_text_transformed(tx + 320, ty + 20 + _y, "Reputation:", size, size, 0);
		//draw_text_transformed(tx + 490, ty + 20 + _y, "50", size, size, 0);
		
		draw_text_transformed(tx + 24, ty + 100 + _y, "Scan Range:", size, size, 0);
		draw_text_transformed(tx + 24, ty + 140 + _y, "Dash Boost:", size, size, 0);
		draw_text_transformed(tx + 164, ty + 100 + _y, string(s.Scan) + " m", size, size, 0);
		draw_text_transformed(tx + 164, ty + 140 + _y, string(s.DashCooldown / 60) + " sec", size, size, 0);
		
		draw_text_transformed(tx + 356, ty + 20 + _y, "Hull:", size, size, 0);
		draw_text_transformed(tx + 356, ty + 60 + _y, "Shield:", size, size, 0);
		draw_text_transformed(tx + 356, ty + 100 + _y, "Reputation:", size, size, 0);
		draw_text_transformed(tx + 356, ty + 140 + _y, "Warp Drive:", size, size, 0);
		draw_set_halign(fa_right);
		draw_text_transformed(tx + 572, ty + 20 + _y, string(floor(s.Hull)) + " / " + string(s.MaxHull), size, size, 0);
		draw_text_transformed(tx + 572, ty + 60 + _y, string(floor(s.Shield)) + " / " + string(s.MaxShield), size, size, 0);
		draw_set_halign(fa_left);
		draw_text_transformed(tx + 500, ty + 100 + _y, "50", size, size, 0);
		draw_text_transformed(tx + 500, ty + 140 + _y, "20 sec", size, size, 0);
		
		draw_set_halign(fa_center);
		draw_text(tx + 159, ty + 292, "Weapons");
		draw_text(tx + 328, ty + 292, "Systems");
		draw_text(tx + 469, ty + 292, "Storage");
		draw_set_halign(fa_left);
		
		
		
		// * Why did I write Wep and Storage seperately?
		// edit: fixed :)
		
		var swap_slot = -1;
		var tooltip = "";
		
		for (var _x = 79; _x <= 79 + 112; _x += 56) // Weapons
		{
			var slot = (_x - 79) / 56;
			
			var c = c_white;
			if (SInfoSelectSlot == slot) c = c_yellow;
			draw_rectangle_colour(tx + _x, ty + 232, tx + _x + 48, ty + 280, c, c, c, c, 1); // 224 / 236
			if (s.Equip[slot] >= 0) draw_sprite(item_sprite(s.Equip[slot])[0], item_sprite(s.Equip[slot])[1], tx + _x + 12, ty + 244);
			
			if (point_in_rectangle(mouse_x, mouse_y, tx + _x, ty + 232, tx + _x + 48, ty + 280))
			{
				if (s.Equip[slot] >= 0) tooltip = slot;
				
				if (mouse_check_button_pressed(mb_left))
				{	
					if (SInfoSelectSlot >= 0) swap_slot = slot;
					else
					{
						if (s.Equip[slot] >= 0)
						{
							SInfoSelectShip = s;
							SInfoSelectSlot = slot; // 0, 1, 2
						}
					}
				}
			}
		}
		
		for (var _x = 276; _x <= 276 + 56; _x += 56) // Systems
		{
			var slot = (_x - 276) / 56 + 3;
			
			var c = c_white;
			if (SInfoSelectSlot == slot) c = c_yellow;
			draw_rectangle_colour(tx + _x, ty + 232, tx + _x + 48, ty + 280, c, c, c, c, 1); // 332 middle - 56
			if (s.Equip[slot] >= 0) draw_sprite(item_sprite(s.Equip[slot])[0], item_sprite(s.Equip[slot])[1], tx + _x + 12, ty + 244);
			
			if (point_in_rectangle(mouse_x, mouse_y, tx + _x, ty + 232, tx + _x + 48, ty + 280))
			{
				if (s.Equip[slot] >= 0) tooltip = slot;
				
				if (mouse_check_button_pressed(mb_left))
				{
					if (SInfoSelectSlot >= 0) swap_slot = slot;
					else
					{
						if (s.Equip[slot] >= 0)
						{
							SInfoSelectShip = s;
							SInfoSelectSlot = slot; // 3, 4
						}
					}
				}
			}
		}
		
		for (var _x = 417; _x <= 417 + 56; _x += 56) // Storage
		{
			var slot = (_x - 417) / 56 + 5;
			
			var c = c_white;
			if (SInfoSelectSlot == slot) c = c_yellow;
			draw_rectangle_colour(tx + _x, ty + 232, tx + _x + 48, ty + 280, c, c, c, c, 1); // 440 / 428
			if (s.Equip[slot] >= 0) draw_sprite(item_sprite(s.Equip[slot])[0], item_sprite(s.Equip[slot])[1], tx + _x + 12, ty + 244);
			
			if (point_in_rectangle(mouse_x, mouse_y, tx + _x, ty + 232, tx + _x + 48, ty + 280))
			{
				if (s.Equip[slot] >= 0) tooltip = slot;
				
				if (mouse_check_button_pressed(mb_left))
				{
					if (SInfoSelectSlot >= 0) swap_slot = slot;
					else
					{
						if (s.Equip[slot] >= 0)
						{
							SInfoSelectShip = s;
							SInfoSelectSlot = slot; // 5, 6
						}
					}
				}
			}
		}
		
		// Swap
		if (swap_slot >= 0)
		{
			// Check if both slots are the same
			if !(s == SInfoSelectShip and swap_slot == SInfoSelectSlot)
			{
				var item = s.Equip[swap_slot];
				var item2 = SInfoSelectShip.Equip[SInfoSelectSlot];
			
				if (((swap_slot <= 2 and (item2 < 99 or item2 < 0)) // Check swap_slot
				or (swap_slot >= 3 and swap_slot <= 4 and ((item2 >= 100 and item2 < 199) or item2 < 0))
				or swap_slot >= 5) and
				((SInfoSelectSlot <= 2 and (item < 99 or item < 0)) // Check SInfoSelectSlot
				or (SInfoSelectSlot >= 3 and SInfoSelectSlot <= 4 and ((item >= 100 and item < 199) or item < 0))
				or SInfoSelectSlot >= 5))
				{
					s.Equip[swap_slot] = item2;
					SInfoSelectShip.Equip[SInfoSelectSlot] = item;
			
					if (swap_slot <= 2) s.Weps[swap_slot] = weapon_cooldown(item2);
					if (SInfoSelectSlot <= 2) SInfoSelectShip.Weps[SInfoSelectSlot] = weapon_cooldown(item);
				}
			
				SInfoSelectShip = -1;
				SInfoSelectSlot = -1;
			}
			else
			{
				SInfoSelectShip = -1;
				SInfoSelectSlot = -1;
			}
		}
		
		// Tooltip (equipment info)
		if (tooltip != "")
		{
			var l = mouse_x + 10; // left
			var t = mouse_y + 10; // top
			var w = 230; // width
			var h = 200; // height
				
			if (floor(l + w) > global.CamX + global.CamW) l = mouse_x - 10 - w;
			if (floor(t + h) > global.CamY + global.CamH) t = mouse_y - 10 - h;
				
			draw_rectangle_colour(l, t, l + w, t + h, c_black, c_black, c_black, c_black, 0);
			draw_rectangle(l, t, l + w, t + h, 1);
				
			draw_text(l + 10, t + 10, item_name(s.Equip[tooltip]));
			draw_text(l + 10, t + 34, "Type: " + item_type(s.Equip[tooltip]));
			draw_text(l + 10, t + 66, item_desc(s.Equip[tooltip]));
		}
		
		// - click box to select
		//   - click another box to swap
		//     - check current box: see if other item is applicable
		//     - check other box: see if current item is applicable
	}
}