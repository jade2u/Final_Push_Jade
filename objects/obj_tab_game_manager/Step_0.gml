//var for discard pile y staggering
var discard_y = y - ((ds_list_size(discard)) * 5);

//whether deck is full or not
if(ds_list_size(deck) == num_cards) deck_full = true;
else deck_full = false;

//whether player hand is full or not
if(ds_list_size(player_hand) == 3) player_hand_full = true;
else player_hand_full = false;

//if computer hand is full or not
if(ds_list_size(computer_hand) == 3) computer_hand_full = true;
else computer_hand_full = false;

//whether discard is full or not
if(ds_list_size(discard) == num_cards) discard_full = true;
else discard_full = false;


///GAME STATES
switch(state)
{
	///DEALING CARDS
	case state_deal:
		if(move_timer == 0 && global.text == 0)
		{
			//get the last card in the deck
			var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
			
			//if computer hand isn't full yet
			if(!computer_hand_full)
			{
				//add the last card to computer hand
				ds_list_add(computer_hand, _dealt_card);
				//delete it from the deck
				ds_list_delete(deck, ds_list_size(deck) - 1);
				
				//let card know it's in computer hand
				_dealt_card.in_computer_hand = true;
				//let the card know it's not selected
				_dealt_card.computer_select = false;
				
				//set the card's target positon in the computer's hand area
				_dealt_card.target_y = computer_hand_y;
				_dealt_card.target_x = hand_x + (ds_list_size(computer_hand) - 1) * hand_x_offset;
				//play card sound
				audio_play_sound(snd_card, 10, false);
			}
				
			//if the computer has all 3 cards, but player doesn't
			if (computer_hand_full && !player_hand_full)
			{
				//add the last deck card to the player hand
				ds_list_add(player_hand, _dealt_card);
				//remove the last card from the deck
				ds_list_delete(deck, ds_list_size(deck) - 1);
				
				//let the card know it's now in the player's hand
				_dealt_card.in_player_hand = true;
				//let the card know it's not selected
				_dealt_card.player_select = false;
				
				//set the card's target positon in the player's hand area
				_dealt_card.target_y = player_hand_y;
				_dealt_card.target_x = hand_x + (ds_list_size(player_hand) - 1) * hand_x_offset;
				//play card sound
				audio_play_sound(snd_card, 10, false);
			}
			
		}
		//when all hands are filled, go to next state
		if(computer_hand_full && player_hand_full)
		{
			wait_timer++;
			if(wait_timer == 50)
			{
				wait_timer = 0;
				state = state_select;
			}
		}
	break;

	///CHOOSING CARDS
	case state_select:	//in card step event
		//after player has chosen a card, go to compare state
		if(ds_list_size(player_selected) == 1) state = state_compare;	
	break;

	///DECIDING WHO WON
	case state_compare:
		//find which type of card is being played
		var _return_computer_select = computer_selected[| 0].face_index;
		var _return_player_select = player_selected[| 0].face_index;

		wait_timer++;	
		//wait before flipping comp card
		if(wait_timer >= comp_flip_wait)
		{
			//get computer selected card
			var _return_computer_select_face  = computer_selected[| 0];
			//flip it over
			_return_computer_select_face.face_up = true;

			//wait before moving to select state
			if(wait_timer >= clear_state_wait)
			{
				//if computer & player play same card, go to clean cards
				if(_return_player_select == _return_computer_select) state = state_selected_clean;
			
				//if they're not the same
				if(_return_player_select != _return_computer_select)
				{	
					//if player plays paper
					if(_return_player_select == 0)
					{
						//if computer plays rock, player wins
						if(_return_computer_select == 2)
						{
							player_win = true;
							computer_win = false;
						}
						//if computer plays scissors, computer wins
						if(_return_computer_select == 1)
						{
							player_win = false;
							computer_win = true;
						}
					}
					//if player plays scissors
					if(_return_player_select == 1)
					{
						//if computer plays paper, player wins
						if(_return_computer_select == 0)
						{
							player_win = true;
							computer_win = false;
						}
						//if computer plays rock, computer wins
						if(_return_computer_select == 2)
						{
							player_win = false;
							computer_win = true;
						}
					}
					//if player plays rock
					if(_return_player_select == 2)
					{
						//if computer plays scissors, player wins
						if(_return_computer_select == 1)
						{
							player_win = true;
							computer_win = false;
						}
						//if computer plays paper, computer wins
						if(_return_computer_select == 0)
						{
							player_win = false;
							computer_win = true;
						}
					}
				}
				//if player win, go to win state
				if(player_win)
				{
					audio_play_sound(snd_win, 10, false);
					state = state_win;
				}
				//if computer wins, go to clean state
				if(computer_win)
				{
					audio_play_sound(snd_lose, 10, false);
					state = state_selected_clean;
				}
			}
		}				
	break;
		
	///MOVING SELECTED TO DISCARD
	case state_selected_clean:
		//wait to move cards
		if(move_timer = 0)
		{
			//if there is still a computer selected card
			if(ds_list_size(computer_selected) > 0)
			{
				//get the select card
				var _remaining_computer_select = computer_selected[| 0];
				
				//set target depth
				_remaining_computer_select.target_depth = -810 - ds_list_size(discard);
				//move it to discard pile
				scr_set_pos(_remaining_computer_select, discard_x, discard_y);
				//play card sound
				audio_play_sound(snd_card, 10, false);
				
				//set it to not be selected
				_remaining_computer_select.computer_select = false;
				ds_list_clear(computer_selected);
				
				//set it to not be in computer hand
				_remaining_computer_select.in_computer_hand = false;
				ds_list_delete(computer_hand, global.selected_computer_card_index);
				
				//add to discard
				ds_list_add(discard, _remaining_computer_select);
			}
			
			//and if there is still a player selected card
			else if(ds_list_size(player_selected) > 0)
			{
				//get the select card
				var _remaining_player_select = player_selected[| 0];
				
				//set target depth
				_remaining_player_select.target_depth = -810 - ds_list_size(discard);
				//move it to discard pile
				scr_set_pos(_remaining_player_select, discard_x, discard_y);
				//play card sound
				audio_play_sound(snd_card, 10, false);
				
				//set it to no longer be selected
				_remaining_player_select.player_select = false;
				ds_list_clear(player_selected);
				
				//set it to no longer be in player hand
				_remaining_player_select.in_player_hand = false;
				ds_list_delete(player_hand, global.selected_player_card_index);
				
				//add to discard
				ds_list_add(discard, _remaining_player_select);
			}
			
			//when no player selected card, go to clean hands
			else if(ds_list_size(player_selected) == 0)
			{
				//reset wait timer
				wait_timer = 0;
				state = state_hand_clean;
			}
		}
	break;
	
	///MOVING HANDS TO DISCARD
	case state_hand_clean:
		if(move_timer = 0)
			{
				//var for hand sizes
				var _num_computer_hand = ds_list_size(computer_hand);
				var _num_player_hand= ds_list_size(player_hand);

				//if computer hand still has cards
				if(_num_computer_hand > 0)
				{
					//get the last card in the hand
					var _remaining_computer_hand = computer_hand[| _num_computer_hand - 1];
					
					//set target depth
					_remaining_computer_hand.target_depth = -810 - ds_list_size(discard);
					//move it to the discard pile
					scr_set_pos(_remaining_computer_hand, discard_x, discard_y);
					//play card sound
					audio_play_sound(snd_card, 10, false);
					
					//flip it face up
					if(!_remaining_computer_hand.face_up) _remaining_computer_hand.face_up = true;
				
					//set it to not be in computer hand
					_remaining_computer_hand.in_computer_hand = false;
					ds_list_delete(computer_hand, _num_computer_hand - 1);
					
					
					//add to discard list
					ds_list_add(discard,  _remaining_computer_hand);
				}
				
				//and if player hand still has cards
				else if (_num_player_hand > 0)
				{
					//get the last card in the hand
					var _remaining_player_hand = player_hand[| _num_player_hand - 1];
					
					//set target depth
					_remaining_player_hand.target_depth = -810 - ds_list_size(discard);
					//move it to the discard pile
					scr_set_pos(_remaining_player_hand, discard_x, discard_y);
					//play card sound
					audio_play_sound(snd_card, 10, false);
				
					//set it to not be in player hand
					_remaining_player_hand.in_player_hand = false;
					ds_list_delete(player_hand, _num_player_hand - 1);
					
					//add to discard list
					ds_list_add(discard,  _remaining_player_hand);
				}
				
				//when both hands have no cards
				else
				{
					//clear all lists
					ds_list_clear(player_hand);
					ds_list_clear(player_selected);
					ds_list_clear(computer_hand);
					ds_list_clear(computer_selected);
					
					//if deck is empty, go to shuffle
					if (ds_list_size(deck) == 0) state = state_shuffle;
				}
			}
	break;
	
	///SHUFFLING DISCARD AND MOVING TO DECK
	case state_shuffle:
		//vars for num of cards in discard & deck
		var _num_discard = ds_list_size(discard);
		var _num_deck = ds_list_size(deck);
		
		//every 6 frames
		if(move_timer % 6 == 0)
		{
			//if there are still cards in discard
			if(_num_discard > 0)
			{
				//get the last card in discard
				var _return_discard = discard[| _num_discard - 1];
				
				//move to the deck area
				scr_set_pos(_return_discard, x - 400, y - (_num_deck * 5));
				//set target depth
				_return_discard.target_depth = -810 -_num_deck;
				//play card sound
				audio_play_sound(snd_card, 10, false);
				
				//turn all cards back to face down
				_return_discard.face_up = false;
				
				//remove the card from the discard list and add it to the deck list
				ds_list_delete(discard, _num_discard - 1);
				ds_list_add(deck, _return_discard);
			}
		
		//when discard has no more cards
		if (_num_discard == 0)
			{
				//randomize seed
				randomize();
				//shuffle the deck
				ds_list_shuffle(deck);
				
				//loop through deck
				for(var _i = 0; _i < num_cards; _i++)
				{
					//reset position
					deck[| _i].target_y = y;
					deck[| _i].target_depth = -810;
					//move them to the shuffled deck
					ds_list_add(shuffled_deck, deck[| _i]);
				}
				//when all cards have been moved to shuffled deck
				if(ds_list_size(shuffled_deck) == num_cards)
				{
					//clear deck
					ds_list_clear(deck);
					//move to organize deck
					state = state_organize_deck;
				}
			}
		}
	break;
		
		
	case state_organize_deck:
		//vars for num of cards in deck and shuffled deck
		var _num_deck = ds_list_size(deck);
		var _num_shuffled_deck = ds_list_size(shuffled_deck);
		
		//every 6 frames
		if(move_timer % 6 == 0)
		{
			//if shuffled deck still has cards
			if(_num_shuffled_deck > 0)
			{
				//get the last card in the shuffled deck
				var _return_deck_card = shuffled_deck[| _num_shuffled_deck - 1];
				
				//stagger card
				scr_set_pos(_return_deck_card, x - 400, y - ( _num_deck * 5));
				//set target depth
				_return_deck_card.target_depth = -810 - _num_deck;
				//play card sound
				audio_play_sound(snd_card, 10, false);
				
				//remove the card from the shuffled deck list and add it back to the deck list
				ds_list_delete(shuffled_deck, _num_shuffled_deck - 1);
				ds_list_add(deck, _return_deck_card);
			}
			//when all cards have been moved back to deck
			if(_num_shuffled_deck == 0) state = state_deal;
		}
	break;
	
	case state_win:
		//let obj_manager know to draw heart
	break;
			
	default:
		show_debug_message(state);
		show_debug_message("oh no! something is wrong with the state");
		break;
}

//count and reset the move timer
move_timer++;
if(move_timer >= move_timer_max)
{
	move_timer = 0;
}







