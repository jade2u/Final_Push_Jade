///resets the scrolling text

function draw_text_reset()
{
    //checks if the variable has been defined
    if variable_instance_exists(self.id, "_text_char")
	{
        //Resets the defined variables for text scrolling.
        _text_char      = 0;
        _text_prev      = 0;
        _text_sleep     = 0;
    } 
}
