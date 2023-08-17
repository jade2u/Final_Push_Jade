///CARD STATES

 switch(card)
 {
	 ///CARD IN TAB
	case card_tab:
		//once there are 9 pix on screen
		if(ds_list_size(obj_tab_pix_manager.pix) == 9)
		{
			//after siri text is done
			if(global.text == 0)
			{
				//start timer
				card_wait_timer++;
				//wait for 50 frames
				if(card_wait_timer >= 50)
				{
					//flip cards over
					face_up = true;
					audio_play_sound(snd_keyboard, 10, false);
					//wait 50 more frames
					if(card_wait_timer >= 100)
					{
						//flip the cards back down
						face_up = false;
						audio_play_sound(snd_card, 10, false);
						//reset timer
						card_wait_timer = 0;
						//go to next state
						card = card_select
					}
				}
			}
		}
	break;
	
	///CARD BEING SELECTED
	case card_select:
		//if not all cards are selected
		if(ds_list_size(obj_tab_pix_manager.selected) < 3)
		{
			//if mouse hovers on card
			if(position_meeting(mouse_x, mouse_y, id))
			{
				//if clicked
				if(mouse_check_button_pressed(mb_left))
				{
					//turn it over
					face_up = true;
					audio_play_sound(snd_card, 10, false);
					
					//if cat card, add to correct card list
					if(id.face_index == 0) ds_list_add(obj_tab_pix_manager.selected_cat, id);
					
					//add to selected list
					select = true;
					ds_list_add(obj_tab_pix_manager.selected, id);
				}
			}
		}
		//once 3 cards selected, go to wait state
		else card = card_wait;
	break;
	
	///SEEING IF PLAYER WINS
	case card_wait:
		//if new round starts, go back to initial state
		if(obj_tab_pix_manager.state == 0)
		{
			rounds++;
			card = card_tab;
		}
	break;
 }








