/// Reset Game

ds_map_destroy(global.StarMap);
ds_map_destroy(global.Party);
ds_list_destroy(global.PartyList);
part_system_destroy(global.PartSys);
part_system_destroy(global.PartSys2);
part_type_destroy(global.Part1);
part_type_destroy(global.Part2);
part_type_destroy(global.Part3);
part_type_destroy(global.PartShip);
part_type_destroy(global.PartProj);
part_type_destroy(global.PartWarp);
ds_list_destroy(global.Text);
audio_stop_all();

room_goto(rm_Init);