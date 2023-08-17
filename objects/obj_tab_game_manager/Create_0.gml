///GAME STATES
state_deal = 0;	//dealing cards
state_select = 1;	//selecting cards
state_compare = 2;	//choosing winner
state_selected_clean = 3;	//clearing selected cards
state_hand_clean = 4;	//clearing hands
state_shuffle = 5;	//moving discard to deck, shuffling, & resetting card position
state_organize_deck = 6;	//putting deck back in order
state_win = 7;	//player win

///LISTS FOR GAME STATES
deck = ds_list_create();	//cards in deck
shuffled_deck = ds_list_create();	//cards after being shuffled

discard = ds_list_create();	//cards in discard pile

player_hand = ds_list_create();	//cards in player hand
player_selected = ds_list_create();	//card player chooses

computer_hand = ds_list_create();	//cards in computer hand
computer_selected = ds_list_create();	//card computer chooses

//list states
deck_full = false;	//6
discard_full = false;	//6
shuffled_deck_full = false;	//6
player_hand_full = false;	//3
computer_hand_full = false;	//3

//set the initial state of the game
state = state_deal;

///where selected cards are in hand lists
global.selected_player_card_index = 0;
global.selected_computer_card_index = 0;

//total number of cards
num_cards = 6;

//who won
player_win = false;
computer_win = false;

///WAIT TIME VARS
move_timer = 0;	//time b/t cards moving
wait_timer = 0;	//time player can see selection


///INITIAL DECK
for(var _i = 0; _i < num_cards; _i++)
{
	//make a new card
	var _new_card = instance_create_layer(x, y, "Instances", obj_tab_game_card);
	
	//give card a face
	_new_card.face_index = _i % 3;
	
	//var for if card is face up
	_new_card.face_up = false;
	
	//var for if card is in player hand
	_new_card.in_player_hand = false;
	//var for if card is selected by player
	_new_card.player_select = false;
	
	//var for if card is in computer hand
	_new_card.in_computer_hand = false;
	//var for if card is selected by computer
	_new_card.computer_select = false;
	
	//declare the var target_depth and set it to above game tab
	_new_card.target_depth = -810;
	
	//set the initial target position of the card
	_new_card.target_x = x - 400;
	_new_card.target_y = y - 150;
	
	//add the new card to the deck
	ds_list_add(deck, _new_card);
}


//randomize the seed GM uses to create randomness
randomize();
//shuffle the deck list
ds_list_shuffle(deck);

//loop through the deck
for(var _i = 0; _i < num_cards; _i++)
{
	//visually stagger the cards
	deck[| _i].target_depth = -810 - (num_cards -_i);
	deck[| _i].y = y - (5 * _i);
	//have the card go directly to it's position
	deck[| _i].target_y = deck[| _i].y;
}







