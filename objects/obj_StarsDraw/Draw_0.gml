/// Draw

for (var n = 0; n < ds_list_size(Stars); n++)
{
	while (Stars[| n][0] < global.CamX) Stars[| n][0] += global.CamW;
	while (Stars[| n][0] > global.CamX + global.CamW) Stars[| n][0] -= global.CamW;
	while (Stars[| n][1] < global.CamY) Stars[| n][1] += global.CamH;
	while (Stars[| n][1] > global.CamY + global.CamH) Stars[| n][1] -= global.CamH;
	draw_circle_colour(Stars[| n][0], Stars[| n][1], 1, c_white, c_white, 0);
}