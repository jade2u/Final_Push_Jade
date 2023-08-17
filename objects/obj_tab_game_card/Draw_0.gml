///CARD MOVING
//if card hasn't reached target position
if(abs(x - target_x) > 1)
{
	//move x pos towards target position
	x = lerp(x, target_x, 0.2);
	//card is visually on top of past cards
	depth = -1000;
}

//close to target pos
else	
{
	//set our pos to the target pos
	x = target_x;
	//set depth to target depth
	depth = target_depth;
}

//y same as the x
if(abs(y - target_y) > 1)
{
	y = lerp(y, target_y, 0.2);
	depth = -1000;
}
else
{
	y = target_y;
	depth = target_depth;
}

///FACE INDEX
//set the card's face based on the face_index we assigned in the manager
if(face_index == 0) sprite_index = spr_tab_game_paper;
if(face_index == 1) sprite_index = spr_tab_game_scissors;
if(face_index == 2) sprite_index = spr_tab_game_rock;

//show back if not face up
if(face_up == false) sprite_index = spr_tab_game_card;

//draw sprite
draw_sprite(sprite_index, image_index, x, y);







