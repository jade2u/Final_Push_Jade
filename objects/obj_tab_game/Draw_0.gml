/// @description Insert description here
// You can write your code in this editor

///ICON
draw_sprite(spr_icon_game, icon_frame, x, y);

///TAB
if(global.tab == 4)
{
	//draw tab
	draw_sprite(spr_tab_game, 0, room_width / 2, (room_height / 2) - 50);
	//draw obj manager 1 time
	if(!instance_exists(obj_tab_game_manager)) instance_create_layer(room_width / 2, (room_height / 2) - 50, "Instances", obj_tab_game_manager);
}






