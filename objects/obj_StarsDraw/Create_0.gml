/// Create

depth = 1000;

Stars = ds_list_create();
for (var n = 0; n < 40; n++) ds_list_add(Stars, [irandom_range(global.CamX, global.CamX + global.CamW), irandom_range(global.CamY, global.CamY + global.CamH)]);