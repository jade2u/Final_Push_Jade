///TEXT
if(!instance_exists(obj_text) && global.text > 0)
{
	instance_create_layer(652,950, "Instances", obj_text);
	//show_debug_message(instance_exists(obj_text));
}
if(instance_exists(obj_text) && global.text == 0) instance_destroy(obj_text);

/// GAME STATES
switch(state)
{
	///INTRO
	case state_intro:
		global.text = 1;
		//once text has been drawn
		if(instance_exists(obj_text))
		{
			if(obj_text.text_index == 7)
			{
				global.text = 0;
				//and is finished, go to gui
				state = state_gui;
			}
		}
	break;
	
	///GUI
	case state_gui:
		
		if(instance_position(mouse_x, mouse_y, obj_tab_gui))
		{
			//play hover frame
			obj_tab_gui.icon_frame = 1;
		
			//if icon clicked, show gui tab
			if(mouse_check_button_pressed(mb_left))
			{
				audio_play_sound(snd_mouse, 10, false);
				global.tab = 1;
			}
		}
		//if not hovering, no hover anim
		else obj_tab_gui.icon_frame = 0;
		
		//once gui tab is shown
		if(global.tab == 1)
		{
			///PLUS
			//if hovering on the plus
			if(position_meeting(mouse_x, mouse_y, obj_tab_gui_plus)) 
			{
				//play hover frame
				obj_tab_gui_plus.image_index = 1;
				//if size isn't at 100% yet
				if(obj_tab_gui.tab_frame < 4)
				{
					//when plus is clicked
					if(mouse_check_button_pressed(mb_left))
					{
						audio_play_sound(snd_grow, 10, false);
						//inc bar frame
						obj_tab_gui.tab_frame++;
						//inc player size
						global.player++;
					}
				}
				//if size is at 100%, player is at full size
				if (obj_tab_gui.tab_frame == 4) global.player = 5;
			}
			//if not hovering on plus, no hover anim
			else obj_tab_gui_plus.image_index = 0;
			
			///MINUS
			//if hovering
			if(position_meeting(mouse_x, mouse_y, obj_tab_gui_minus)) 
			{
				//play hover frame
				obj_tab_gui_minus.image_index = 1;
				//if size isn't at 100% yet and greater than 0%
				if(obj_tab_gui.tab_frame < 4 && obj_tab_gui.tab_frame > 0)
				{
					//when plus is clicked
					if(mouse_check_button_pressed(mb_left))
					{
						audio_play_sound(snd_shrink, 10, false);
						//dec bar frame
						obj_tab_gui.tab_frame--;
						//dec player size
						global.player--;
					}
				}
				//if size is at 100%, player is at full size
				if (obj_tab_gui.tab_frame == 4) global.player = 5;
			}
			//if not hovering, no hover anim
			else obj_tab_gui_minus.image_index = 0;
		}
		
		
		//if player is at full size
		if(global.player == 5)
		{
			//audio_play_sound(snd_win, 10, false);
			//draw gui text
			global.text = 2;
			//draw heart
			instance_create_layer(1120, 570, "Instances", obj_heart);
		}	
		//heart collected, set score to 1
		if(instance_exists(obj_heart) && (obj_heart.heart_pressed)) score = 1;
		
		//if player has collected heart & tab has been deleted
		if(score == 1 && global.tab == 0)
		{
			//destroy heart
			instance_destroy(obj_heart);
			
			//after siri outro text is done
			if(instance_exists(obj_text))
			{
				if(obj_text.text_index == 9)
				{
					//delete text
					global.text = 0;
					//and is finished, go to pix
					state= state_pix;
				}
			}
		}
	break;
	
	///PIX
	case state_pix:
		//if hovering on icon
		if(instance_position(mouse_x, mouse_y, obj_tab_pix))
		{
			//play hover anim
			obj_tab_pix.icon_frame = 1;
			//if mouse clicked
			if(mouse_check_button_pressed(mb_left))
			{
				//play sound
				audio_play_sound(snd_mouse, 10, false);
				//draw tab
				global.tab = 2;
				
				//draw explanation text
				global.text = 3;
			}
		}
		//if not hovering on icon, no hover anim
		else obj_tab_pix.icon_frame = 0;
		
		//if tab manager exists
		if(instance_exists(obj_tab_pix_manager))
		{
			
			//delete intro text
			if(instance_exists(obj_text) && global.text == 3)
			{
				if(obj_text.text_index == 5) global.text = 0;
			}
	
			//if player lost, draw shuffling text
			if(obj_tab_pix_manager.state == 3) global.text = 4;
			//delete text before new round
			if(obj_tab_pix_manager.state == 1)
			{
				if(instance_exists(obj_text) && global.text == 4)
				{
					if(obj_text.text_index == 4) global.text = 0;
				}
			}
			
			//if player has won
			if(obj_tab_pix_manager.state == 6)
			{
				//draw heart
				instance_create_layer(room_width/2, room_height/2 + 100, "Instances", obj_heart);
			}
			
			//inc score once heart is pressed
			if(instance_exists(obj_heart) && obj_heart.heart_pressed)
			{
				
				score = 2;
			}
		}
		//if heart is pressed & tab deleted
		if(score == 2 && global.tab == 0)
		{
			//destroy heart
			instance_destroy(obj_heart);
			//destroy associated objects
			instance_destroy(obj_tab_pix_manager);
			instance_destroy(obj_tab_pix_card);
				
			//draw outro text
			global.text = 5;
				
			//after siri outro text is done
			if(instance_exists(obj_text))
			{
				if(obj_text.text_index == 6)
				{
					//delete text
					global.text = 0;
					//and is finished, go to work
					state= state_work;
				}
			}
		}
	break;
	
	///WORK
	case state_work:
		//if hovering on icon
		if(instance_position(mouse_x, mouse_y, obj_tab_work))
		{
			//play hover anim
			obj_tab_work.icon_frame = 1;
			//if mouse clicked, draw tab
			if(mouse_check_button_pressed(mb_left))
			{
				audio_play_sound(snd_mouse, 10, false);
				global.tab = 3;
				
				//draw explanation text
				global.text = 6;
			}
		}
		//if not hovering, no hover icon anim
		else obj_tab_work.icon_frame = 0;
		
		//if obj manager exists
		if(instance_exists(obj_tab_work_manager))
		{
			//delete intro text
			if(instance_exists(obj_text) && global.text == 6)
			{
				if(obj_text.text_index == 5) global.text = 0;
			}
			
			//and siri win text played, draw heart
			if(obj_tab_work_manager.state == 3) instance_create_layer(room_width/2, room_height/2, "Instances", obj_heart);
			
			//inc score once heart is pressed
			if(instance_exists(obj_heart) && obj_heart.heart_pressed) score = 3;
			
			
		}
		//if heart is pressed & tab deleted
		if(score == 3 && global.tab == 0)
		{
			//destroy associated objects
			instance_destroy(obj_tab_work_manager);
			instance_destroy(obj_tab_work_card);
			//destroy heart
			instance_destroy(obj_heart);
				
			//draw outro text
			global.text = 7;
			
			//after siri outro text is done
			if(instance_exists(obj_text))
			{
				if(obj_text.text_index == 5)
				{
					//delete text
					global.text = 0;
					//and is finished, go to work
					state= state_game;
				}
			}
		}
	break;
	
	///GAME
	case state_game:
		//if hovering on icon
		if(instance_position(mouse_x, mouse_y, obj_tab_game))
		{
			//play hover anim
			obj_tab_game.icon_frame = 1;
			//if mouse clicked, draw tab
			if(mouse_check_button_pressed(mb_left))
			{
				audio_play_sound(snd_card, 10, false);
				global.tab = 4;
				
				//draw explanation text
				global.text = 8;
			}
		}
		//if not hovering, no hover icon anim
		else obj_tab_game.icon_frame = 0;
		
		if(instance_exists(obj_tab_game_manager))
		{
			//delete intro text
			if(instance_exists(obj_text) && global.text == 8)
			{
				if(obj_text.text_index == 9) global.text = 0;
			}	
			
			//if player lost, draw shuffling text
			if(obj_tab_game_manager.state == 3) global.text = 9;
			//delete text before new round
			if(obj_tab_game_manager.state == 0)
			{
				if(instance_exists(obj_text) && global.text == 9)
				{
					if(obj_text.text_index == 4) global.text = 0;
				}
			}
			
			//and siri win text played, draw heart
			if(obj_tab_game_manager.state == 7) instance_create_layer(room_width/2  - 400, room_height/2, "Instances", obj_heart);
			
			//inc score once heart is pressed
			if(instance_exists(obj_heart) && obj_heart.heart_pressed) score = 4;
		}
		//if heart is pressed & tab deleted
		if(score == 4 && global.tab == 0)
		{
			//destroy associated objects
			instance_destroy(obj_tab_game_manager);
			instance_destroy(obj_tab_game_card);
			//destroy heart
			instance_destroy(obj_heart);
			
			//draw outro text
			global.text = 10;
			
			//after siri outro text is done
			if(instance_exists(obj_text))
			{
				if(obj_text.text_index == 6)
				{
					//delete text
					global.text = 0;
					//and is finished, go to work
					state= state_web;
				}
			}
		}
	break;
	
	///WEB
	case state_web:
		//if hovering on icon
		if(instance_position(mouse_x, mouse_y, obj_tab_web))
		{
			//play hover anim
			obj_tab_web.icon_frame = 1;
			//if mouse clicked
			if(mouse_check_button_pressed(mb_left))
			{
				audio_play_sound(snd_card, 10, false);
				global.tab = 5;
				
				//draw explanation text
				global.text = 11;
			}
		}
		//if not hovering, no hover icon anim
		else obj_tab_web.icon_frame = 0;
		
		if(global.tab == 5)
		{
			//if button hasn't been clicked yet
			if(obj_tab_web.tab_frame == 0)
			{
				//delete intro text
				if(instance_exists(obj_text) && global.text == 11)
				{
					if(obj_text.text_index == 3) global.text = 0;
				}	
				
				//draw buttons
				instance_create_layer(room_width / 2, room_height/2,"Instances", obj_tab_web_search);
				instance_create_layer(room_width / 2, room_height/2,"Instances", obj_tab_web_lucky);
				
				///SEARCH BUTTON
				//if hover
				if(instance_position(mouse_x, mouse_y, obj_tab_web_search))
				{
					//play hover anim
					obj_tab_web_search.search_frame = 1;
					//if clicked
					if(mouse_check_button_pressed(mb_left))
					{	
						audio_play_sound(snd_mouse, 10, false);
						//destroy buttons
						instance_destroy(obj_tab_web_search);
						instance_destroy(obj_tab_web_lucky);
						//go to search tabe
						obj_tab_web.tab_frame = 1;
					}
				}
				else if (obj_tab_web.tab_frame == 0)obj_tab_web_search.search_frame = 0;
					
				///LUCKY BUTTON
				//if hover
				if(instance_position(mouse_x, mouse_y, obj_tab_web_lucky))
				{
					//play hover anim
					obj_tab_web_lucky.lucky_frame = 1;
					//if clicked
					if(mouse_check_button_pressed(mb_left)) 
					{
						audio_play_sound(snd_mouse, 10, false);
						//destroy buttons
						instance_destroy(obj_tab_web_search);
						instance_destroy(obj_tab_web_lucky);
						//go to lucky tab
						obj_tab_web.tab_frame = 2;
					}
				}
				else if (obj_tab_web.tab_frame == 0) obj_tab_web_lucky.lucky_frame = 0;
			}
			
			///BUTTON CLICKED
			//search
			if(obj_tab_web.tab_frame == 1)
			{
				//draw link
				instance_create_depth(room_width/2, room_height/2 - 10, -810, obj_tab_web_link);
				//if link clicked
				if(instance_position(mouse_x, mouse_y, obj_tab_web_link))
				{
					//draw heart
					if(mouse_check_button_pressed(mb_left))
					{
						instance_create_layer(room_width * 0.75, room_height/3, "Instances", obj_heart);
					}
				}
			}
			//lucky
			//once tab drawn, draw heart
			if(obj_tab_web.tab_frame == 2) instance_create_layer(room_width * 0.75, room_height/3, "Instances", obj_heart);
		}
		//inc score once heart is pressed
		if(instance_exists(obj_heart) && obj_heart.heart_pressed) score = 5;
		
		//if heart is pressed & tab deleted
		if(score == 5 && global.tab == 0)
		{
			//destroy heart
			instance_destroy(obj_heart);
			if(instance_exists(obj_tab_web_link))instance_destroy(obj_tab_web_link);
			
			//draw outro text
				global.text = 12;
				
				//after siri outro text is done
				if(instance_exists(obj_text))
				{
					if(obj_text.text_index == 3)
					{
						//delete text
						global.text = 0;
						//and is finished, go to work
						state= state_trash;
					}
				}
		}
		
		//show_debug_message(global.tab);
		
		
	break;
	
	case state_trash:
		//if hovering on icon
		if(instance_position(mouse_x, mouse_y, obj_trash))
		{
			//play hover anim
			obj_trash.trash_frame = 1;
			//if mouse clicked, draw tab
			if(mouse_check_button_pressed(mb_left))
			{
				audio_play_sound(snd_trash, 10, false);
				room = rm_end;
			}
		}
		//if not hovering, no hover icon anim
		else obj_tab_game.trash_frame = 0;
	break;
	
}






