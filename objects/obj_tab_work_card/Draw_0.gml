///FACE INDEX
if(face_index == 0) sprite_index = spr_tab_work_name;
if(face_index == 1) sprite_index = spr_tab_work_email;
if(face_index == 2) sprite_index = spr_tab_work_phone;

//MATCH INDEX
if(match)
{
	if(face_number == 0 || face_number == 2) face_number = 4;
	if(face_number == 1 || face_number = 3) face_number = 5;
}
if(wrong)
{
	if(face_number = 0) face_number = 2;
	if(face_number = 1) face_number = 3;
}

if(!match && !wrong) image_index = 0;	//if in deck

//draw sprite after siri intro text
if(global.text > 6 || global.text == 0) draw_sprite(sprite_index, face_number, x, y);





