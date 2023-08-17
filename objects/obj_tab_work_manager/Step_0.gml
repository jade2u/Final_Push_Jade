/// @description Insert description here
// You can write your code in this editor
switch(state)
{
	//DECK ARRANGING
	case state_deck:
		//if deck is full, go to choose cards
		if(ds_list_size(deck) == num_cards) state = state_choosing;
	break;
	
	//CHOOSING CARD PILE
	case state_choosing:
		//get the last card in deck
		var _return_deck = ds_list_find_value(deck, ds_list_size(deck) - 1);
		var _return_deck_face = _return_deck.face_index; 
		
		//if player presses 1
		if(keyboard_check_pressed(ord("1")))
		{
			//change frame of tab to show selection
			obj_tab_work.tab_frame = 1;
			//if it is a NAME
			if(_return_deck_face == 0)
			{
				//set match to be true
				_return_deck.match = true;
				_return_deck.wrong = false;
				//move to name pile
				_return_deck.x = x - name_x;
				_return_deck.y = y - y_var + (ds_list_size(name_organized) * y_offset);
				
				//delete from deck and add to organized list
				ds_list_delete(deck, ds_list_size(deck) - 1);
				ds_list_add(organized, _return_deck);
				ds_list_add(name_organized, _return_deck);
				
				//go to match state
				state = state_match;
			}
			//if it's not a NAME
			else
			{
				//set match to be false
				_return_deck.match = false;
				_return_deck.wrong = true;
			}
		}
		
		//if player presses 2
		if(keyboard_check_pressed(ord("2")))
		{
			//change frame of tab to show selection
			obj_tab_work.tab_frame = 2;
			//if it is an EMAIL
			if(_return_deck.face_index == 1)
			{
				//set match to be true
				_return_deck.match = true;
				_return_deck.wrong = false;
				
				//move to email pile
				_return_deck.x = x - email_x;
				_return_deck.y = y - y_var + (ds_list_size(email_organized) * y_offset);
				
				////delete from deck and add to organized list
				ds_list_delete(deck, ds_list_size(deck) - 1);
				ds_list_add(organized, _return_deck);
				ds_list_add(email_organized, _return_deck);
				
				//go to match state
				state = state_match;
			}
			//if it's not an EMAIL
			else
			{
				//set match to be false
				_return_deck.match = false;
				_return_deck.wrong = true;
			}
		}
		
		//if player presses 3
		if(keyboard_check_pressed(ord("3")))
		{
			//change frame of tab to show selection
			obj_tab_work.tab_frame = 3;
			//if it is an PHONE
			if(_return_deck.face_index == 2)
			{
				//set match to be true
				_return_deck.match = true;
				_return_deck.wrong = false;
				
				//move to phone pile
				_return_deck.x = x + phone_x;
				_return_deck.y = y - y_var + (ds_list_size(phone_organized) * y_offset) ;
				
				//delete from deck and add to organized list
				ds_list_delete(deck, ds_list_size(deck) - 1);
				ds_list_add(organized, _return_deck);
				ds_list_add(phone_organized, _return_deck);
				
				//go to match state
				state = state_match;
			}
			//if it's not a PHONE
			else
			{
				//set match to be false
				_return_deck.match = false;
				_return_deck.wrong = true;
			}
		}
	break;
	
	///CHECKING IF DONE ORGANIZING
	case state_match:
		//if all cards haven't been organized, go back to choosing state
		if(ds_list_size(organized) < num_cards) state = state_choosing;
		//if all cards have been organized, go to win state
		else if (ds_list_size(organized) == num_cards) state = state_win;
	break;
	
	//PLAYER WIN
	case state_win:
		//let obj_manager know to draw heart
	break;
}







