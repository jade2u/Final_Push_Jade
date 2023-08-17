//if mouse on heart
if(instance_position(mouse_x, mouse_y, obj_heart))
{
	//and heart clicked
	if(mouse_check_button_pressed(mb_left))
	{
		audio_play_sound(snd_heart, 10, false, 0.1);
		//set heart as pressed
		heart_pressed = true;
		obj_top.image_index = score;	//set top index
		global.tab = 0;	//delete tab
	}
	//if not clicked, set heart as not pressed
	else heart_pressed = false;
}









