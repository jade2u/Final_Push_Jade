///GAME STATES
state_deck = 0;	//getting deck
state_choosing = 1;	//player choosing card pile
state_match = 2;	//deciding if card in right place
state_win = 3;	//player wins
//initial state
state= state_deck;

///LISTS
deck = ds_list_create();	//cards in deck
organized = ds_list_create();	//organized cards
name = ds_list_create();	//name cards
email = ds_list_create();	//email cards
phone = ds_list_create();	//phone cards

name_organized = ds_list_create();
email_organized = ds_list_create();
phone_organized = ds_list_create();

///WAIT TIME VARS
wait_timer = 0;

//total num of cards
num_cards = 6;

///INITIAL DECK
for(var _i = 0; _i < num_cards; _i++)
{
	//make a new card
	var _new_card = instance_create_layer(room_width/2 - 100, room_height/2, "Instances", obj_tab_work_card);
	
	//first 2 cards are name
	if(_i < 2)
	{
		_new_card.face_index = 0;
		ds_list_add(name, _new_card);
	}
	//then email
	else if(_i < 4)
	{
		_new_card.face_index = 1;
		ds_list_add(email, _new_card);
	}
	//then phone
	else if(_i < 6)
	{
		_new_card.face_index = 2;
		ds_list_add(phone, _new_card);
	}
	
	//var if card is a match
	_new_card.match = false;
	_new_card.wrong = false;
	
	//add card to deck
	ds_list_add(deck, _new_card);
}

//randomize seed
randomize();
//shuffle deck
ds_list_shuffle(deck);

//loop through deck
for(var _i = 0; _i < num_cards; _i++)
{
	//set depth
	deck[| _i].depth = -850 - _i;
	//set y
	deck[| _i].y = room_height /2;
}

//loop through name
for(var _i = 0; _i < ds_list_size(name); _i++)
{
	name[| _i].face_number = _i;
}
//loop through email
for(var _i = 0; _i < ds_list_size(email); _i++)
{
	email[| _i].face_number = _i;
}
//loop through phone
for(var _i = 0; _i < ds_list_size(phone); _i++)
{
	phone[| _i].face_number = _i;
}


