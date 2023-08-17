///ICON
draw_sprite(spr_icon_pix, icon_frame, x, y);

///TAB
if(global.tab == 2)
{
	draw_sprite(spr_tab_pix, 0, 960, 540);
	if(!instance_exists(obj_tab_pix_manager)) instance_create_layer(670, 320, "Instances", obj_tab_pix_manager);
}








