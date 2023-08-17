/// @description Insert description here
// You can write your code in this editor
switch(card)
	{
		///CARD IS IN COMPUTER HAND
		case card_in_computer_hand:
			//if computer has all cards, go to player hand
			if(ds_list_size(obj_tab_game_manager.computer_hand) == 3) card = card_in_player_hand;
		break;
		
		///CARD IS IN PLAYER HAND
		case card_in_player_hand:
			//once player has all cards
			if(ds_list_size(obj_tab_game_manager.player_hand) == 3)
			{
				//flip over the player's cards
				if(in_player_hand) face_up = true;
				
				//computer now selects a card
				card = card_computer_select;
			}	
		break;
		
		///CARD IS SELECTED BY COMPUTER
		case card_computer_select:
			//if in select state if computer hasn't selected any cards yet
			if(obj_tab_game_manager.state == 1 && ds_list_size(obj_tab_game_manager.computer_selected) < 1)
			{
				//out of the cards in the computer hand
				if(in_computer_hand)
				{
						//choose random card from computer hand
						var _random_computer_card = ds_list_find_value(obj_tab_game_manager.computer_hand, irandom(ds_list_size(obj_tab_game_manager.computer_hand) - 1));
						//find its index in the hand
						global.selected_computer_card_index = ds_list_find_index(obj_tab_game_manager.computer_hand, _random_computer_card);
					
						//move to middle
						scr_set_pos(_random_computer_card, selected_x, comp_selected_y);
						//play card sound
						audio_play_sound(snd_card, 10, false);
						
						//set it to be selected by computer
						_random_computer_card.computer_select = true;
						ds_list_add(obj_tab_game_manager.computer_selected, _random_computer_card);
				}
			}
			//after computer selects card, player selects card
			if(ds_list_size(obj_tab_game_manager.computer_selected) > 0) card = card_player_select;
		break;
	
		///CARD IS SELECTED BY PLAYER
		case card_player_select:
			//if no card selected
			if(ds_list_size(obj_tab_game_manager.player_selected) < 1)
			{
				//out of the cards in the player hand
				if(in_player_hand)
				{
					//if mouse hovers on card
					if(position_meeting(mouse_x, mouse_y, id))
					{
						//moves up 
						target_y = obj_tab_game_manager.player_hand_y - 30;
						
						//if clicked
						if(mouse_check_button_pressed(mb_left))
						{
							//find the card in the player hand
							global.selected_player_card_index = ds_list_find_index(obj_tab_game_manager.player_hand, id);
							
							//move to middle
							target_y = player_selected_y;
							target_x = selected_x;
							
							//play card sound
							audio_play_sound(snd_card, 10, false);
							
							//set the clicked card as player select
							player_select = true;
							ds_list_add(obj_tab_game_manager.player_selected, id);
						}
					}
					//when not hovering, goes back down
					else target_y = obj_tab_game_manager.player_hand_y;
				}
			}
			//after card is selected, go to compare cards
			else card = card_wait;
		break;
		
		///CARDS ARE BEING COMPARED
		case card_wait:
			//if state is back to state_deal, restart
			if(obj_tab_game_manager.state == 0) card = card_in_computer_hand;
		break;
		
		default:
			show_debug_message(card);
			show_debug_message("oh no! something is wrong with the card");
			break;
	}








