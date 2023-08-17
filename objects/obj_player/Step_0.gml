///MOVE
//directions variables
var _x_dir = mouse_x - mx;
var _y_dir = mouse_y - my;
var _abs_x = abs(_x_dir);
var _abs_y = abs(_y_dir);

//x axis
if(_abs_x > _abs_y)	//if change in x > change in y
{
	if(_x_dir < 0) image_index = 1;	//moving left if neg
	if(_x_dir > 0) image_index = 2;	//moving right if pos
}
//y axis
else if(_abs_y > _abs_x)	//if change in y > change in x
{
	if(_y_dir < 0) image_index = 3;	//moving up if neg
	if(_y_dir > 0) image_index = 4;	//moving down if pos
}
//not moving
else if (_abs_x == _abs_y) image_index = 0;

//update positions
mx = mouse_x;
my = mouse_y;

//size inc
if(global.player== 2) sprite = spr_player_2;
if(global.player == 3) sprite = spr_player_3;
if(global.player == 4) sprite = spr_player_4;
if(global.player == 5) sprite = spr_player_5;