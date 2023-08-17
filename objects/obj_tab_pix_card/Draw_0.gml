///FACE INDEX
if(face_index == 0) sprite_index = spr_tab_pix_cat;
if(face_index == 1) sprite_index = spr_tab_pix_not_cat;
//face up
if(face_up == false) sprite_index = spr_tab_pix_back;

//draw sprite
draw_sprite(sprite_index, face_number, x, y);





