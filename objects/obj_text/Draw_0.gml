/// @description Insert description here
draw_set_font(fnt_siri);
draw_set_color(c_black);

draw_text_scrolling(652, 950, text_array[text_index], 0.2, 30, undefined);

//if space pressed or timer over
if (keyboard_check_pressed(vk_space))
{
     draw_text_reset();	//reset text
     text_index += 1;	//start new line
	 //show_debug_message(text_index)
}

