///GAME STATES
switch(state)
{
	///DEALING PIX
	case state_deal:
		//if there are 9 pix, go to next state
		if (ds_list_size(pix) == 9) state = state_select
	break;
	
	///SELECT PIX
	case state_select:
		//once player select 3 pix, go to next state
		if(ds_list_size(selected) == 3) state = state_compare;
	break;
	
	///COMPARE PIX
	case state_compare:
		//start wait timer
		wait_timer++
		//after 50 frames
		if(wait_timer == 50)
		{
			//if not all selected cards are cat cards, go to shuffle
			if(ds_list_size(selected_cat) < ds_list_size(selected))
			{
				audio_play_sound(snd_lose, 10, false);
				state = state_shuffle;
			}
			//if all selected cards are cat cards, go to clear
			else if (ds_list_size(selected_cat) == ds_list_size(selected))
			{
				audio_play_sound(snd_win, 10, false);
				state = state_clear;
			}
			
			//reset wait timer
			wait_timer = 0;
		}
	break;
	
	///SHUFFLE PIX
	case state_shuffle:
		//var for num of pix
		var _num_pix = ds_list_size(pix);
		
		//if there are still pix on screen
		if(_num_pix > 0)
		{
			//get the last pic
			var _return_pic = pix[| _num_pix - 1];
			
			//make it face down
			_return_pic.face_up = false;
			//make it dissappear
			_return_pic.depth = 0;
			
			//remove from pix and add to reset
			ds_list_delete(pix, _num_pix - 1);
			ds_list_add(pix_reset, _return_pic);
		}
		
		//once no more pix on screen
		if(_num_pix == 0)
		{
			//shuffle pix
			randomize();
			ds_list_shuffle(pix_reset);
			
			//clear pix & selected lists
			ds_list_clear(pix);
			ds_list_clear(selected);
			ds_list_clear(selected_cat);
			
			//wait before going to next frame
			wait_timer++
			if(wait_timer == 80)
			{
				///DRAW SIRI SHUFFLING TEXT HERE
				state = state_reset;
				wait_timer = 0;
			}			
		}
	break;
	
	//RESET PIX AFTER SHUFFLE
	case state_reset:
		//var for num of pix
		var _num_pix = ds_list_size(pix);
		
		//if pix aren't all back to original pix list
		if(_num_pix < num_pix)
		{
			//loop through pix reset
			for(var _i = 0; _i < num_pix; _i++)
			{
				//reset column every row
				if(column == 3) column = 0;
	
				//new row every 3 cards
				if(_i < 3) row = 0;
				else if(_i < 6) row = 1;
				else if (_i < 9) row = 2;;
	
				//set position of card
				pix_reset[| _i].y = y + (pix_y_offset * row);
				pix_reset[| _i].x = x + (pix_x_offset * column);
				pix_reset[| _i].depth = -900;
				column++;
				
				//add back to pix list
				ds_list_add(pix, pix_reset[| _i]);
			}
		}
		
		//when all cards are back in pix list
		if(_num_pix == num_pix)
		{
			//clear reset list
			ds_list_clear(pix_reset);
			//go to initial state
			state = state_deal;
		}
	break;
	
	//CLEARING AFTER WIN
	case state_clear:
		//reset column var
		column = 0;
		//loop through pix
		for(var _i = 0; _i < num_pix; _i++)
		{
			//get last pic
			var _return_pic = pix[| _i];
			
			//if cat card
			if(_return_pic.face_index == 0)
			{
				//face up
				_return_pic.face_up = true;
				//move up
				_return_pic.y = y;
				//move to column
				_return_pic.x = x + (pix_x_offset * column);
				column++;
			}
			//if not selected, hide under tab
			else _return_pic.depth = 0;
		}
		//once looped through, go to win state
		state = state_win;
	break;
	
	case state_win:
		//draw heart in obj_manager
	break;
}








