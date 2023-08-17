/*///INTRO
if(global.text == 1)
{
	//create text
	instance_create_layer(652,950, "Instances", obj_text);
	//if no longer drawing text, delete text
	if(section_done && !text_drawn) instance_destroy(obj_text);
}

///GUI
if(global.text == 2)
{
	//create text
	instance_create_layer(652,950, "Instances", obj_text);
	//if no longer drawing text, delete text
	if(!text_drawn) instance_destroy(obj_text);
}

///PIX
if(global.text == 3)
{
	//create text
	instance_create_layer(652,950, "Instances", obj_text);
	//if no longer drawing text, delete text
	if(!text_drawn) instance_destroy(obj_text);
}


