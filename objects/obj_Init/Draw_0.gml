/// Draw

//draw_set_font(fnt_Calibri);

//if (sel < 3)
//{
//	draw_text(24, 24, "Select Weapon " + string(sel + 1));

//	draw_text(24, 56, "D. Original Default (2, 5, 6)");
//	draw_text(24, 80, "1. Light Shot");
//	draw_text(24, 104, "2. Dual Shot");
//	draw_text(24, 128, "3. Spitfire");
//	draw_text(24, 152, "4. Burst");
//	draw_text(24, 176, "5. Railgun");
//	draw_text(24, 200, "6. Backburst");
//	draw_text(24, 224, "7. Sidefire");
//	draw_text(24, 248, "8. Laser");
//	draw_text(24, 272, "9. Shieldbreaker");
//	draw_text(24, 296, "0. sus");

//	if (keyboard_check_pressed(ord("D"))) { global.WepSel = [1, 4, 5]; sel = 3; }
//	else if (keyboard_check_pressed(ord("1"))) { global.WepSel[sel] = 0; sel += 1; }
//	else if (keyboard_check_pressed(ord("2"))) { global.WepSel[sel] = 1; sel += 1; }
//	else if (keyboard_check_pressed(ord("3"))) { global.WepSel[sel] = 2; sel += 1; }
//	else if (keyboard_check_pressed(ord("4"))) { global.WepSel[sel] = 3; sel += 1; }
//	else if (keyboard_check_pressed(ord("5"))) { global.WepSel[sel] = 4; sel += 1; }
//	else if (keyboard_check_pressed(ord("6"))) { global.WepSel[sel] = 5; sel += 1; }
//	else if (keyboard_check_pressed(ord("7"))) { global.WepSel[sel] = 6; sel += 1; }
//	else if (keyboard_check_pressed(ord("8"))) { global.WepSel[sel] = 7; sel += 1; }
//	else if (keyboard_check_pressed(ord("9"))) { global.WepSel[sel] = 8; sel += 1; }
//	else if (keyboard_check_pressed(ord("0"))) { global.WepSel[sel] = 9; sel += 1; }
//}

//else
//{
//	draw_text(24, 24, "Press SPACE to begin");
	
//	if (keyboard_check_pressed(vk_space)) room_goto(rm_World);
//}