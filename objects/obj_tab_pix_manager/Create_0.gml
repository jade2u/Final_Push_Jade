 ///GAME STATES
state_deal = 0;	//placing cards
state_select = 1;	//player slects cards
state_compare = 2;	//whether player won or not
state_shuffle = 3;	//shuffling cards
state_reset = 4;	//reset non-cat cards
state_clear = 5;	//clearing non-cat cards
state_win = 6;	//let obj_manager know player won
//initial state
state = state_deal;

///LISTS
pix_reset = ds_list_create();	//resetting pix
pix = ds_list_create();	//pics on tab
selected = ds_list_create();	//selected cards
selected_cat = ds_list_create();	//correct cards
cat = ds_list_create();	//cat cards
not_cat = ds_list_create();

num_pix = 9;	//total num of pix

///POSITION VARS
pix_x_offset = 200;	//space b/t columns
pix_y_offset = 175;	//space b/t rows
row = 0;	//every 3 cards, new row
column = 0;	//restart at every row

///WAIT TIME VARS
wait_timer = 0;


///INITIAL PIX
for(var _i = 0; _i < num_pix; _i++)
{
	//make a new pic
	var _new_pic = instance_create_layer(x, y, "Instances", obj_tab_pix_card);
	
	//if there aren't already 3 cat cards
	if(ds_list_size(cat) < 3)
	{
		//give pic random face
		_new_pic.face_index = _i % 2;
		//if it's a cat, add to cat list
		if(_new_pic.face_index == 0) ds_list_add(cat, _new_pic);
		if(_new_pic.face_index == 1) ds_list_add(not_cat, _new_pic);
	}
	
	//once there are 3 cat cards, only not cat cards
	else _new_pic.face_index = 1;
	
	if(_new_pic.face_index == 1) ds_list_add(not_cat, _new_pic);
	
	//var for if card is face up
	_new_pic.face_up = false;
	//var for if card is selected
	_new_pic.select = false;
	
	//set target depth to be b/t player and tab
	_new_pic.depth = -900;
	
	//add to pix
	ds_list_add(pix, _new_pic);
}

//randomize seed
randomize();
//shuffle pix list
ds_list_shuffle(pix);

//loop through pix
for(var _i = 0; _i < num_pix; _i++)
{
	//reset column every row
	if(column == 3) column = 0;
	
	//reset row every 3 cards
	if(_i < 3) row = 0;
	else if(_i < 6) row = 1;
	else if (_i < 9) row = 2;;
	
	//set position of card
	pix[| _i].y = y + (pix_y_offset * row);
	pix[| _i].x = x + (pix_x_offset * column);
	//inc column
	column++;
}

//loop through cat pix
for(var _i = 0; _i < ds_list_size(cat); _i++)
{
	var _last_cat = cat[| _i];
	_last_cat.face_number = _i;
}

//loop through not cat pix
for(var _i = 0; _i < ds_list_size(not_cat); _i++)
{
	var _last_card = not_cat[| _i];
	_last_card.face_number = _i;

}
