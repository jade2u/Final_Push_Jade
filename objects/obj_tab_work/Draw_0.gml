///ICON
draw_sprite(spr_icon_work, icon_frame, x, y);

///TAB
if(global.tab == 3)
{
	//draw tab
	draw_sprite(spr_tab_work, tab_frame, room_width / 2, (room_height / 2) - 50);
	//draw obj manager 1 time
	if(!instance_exists(obj_tab_work_manager)) instance_create_layer(room_width / 2, (room_height / 2) - 50, "Instances", obj_tab_work_manager);
}



