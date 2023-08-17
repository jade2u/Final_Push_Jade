///draws text scrolling from the first to last character in a string.
//draw_text_scrolling(0, 0, "Hello World", 0.5, 20, undefined)
//draw_text_scrolling (x, y, string, speed, sleep time, sound)
 
function draw_text_scrolling(text_x, text_y, text_str, text_spd, text_slp, text_snd)
{
    //check the index counter has been defined
    if !variable_instance_exists(self.id, "_text_char")
	{
        //defines the counter variables
        _text_char      = 0;
        _text_prev      = 0;
        _text_sleep     = 0;
    }
 
    //gets the current character index
    var text_ind = floor(_text_char);
    var text_chr = string_char_at(text_str, text_ind);
	
    //checks if the text index isn't the final char
    if (text_ind != string_length(text_str)){
 
        //if text isn't sleeping
        if (_text_sleep == 0)
		{
            //if character is NOT a sleep identifier
            if !((text_chr == "?") || (text_chr == "!"))
			{
                //increment character counter
                _text_char += text_spd;
        
                //max out the character counter at the string length
                _text_char = min(_text_char, string_length(text_str));
        
                //checks if the character has been fully incremented
                if (text_ind > _text_prev) && (text_snd != undefined) && audio_exists(text_snd)
				{
                    //play text sound
                   audio_stop_sound(text_snd);
                   audio_play_sound(text_snd, 0, false);
                }
        
                //sets the previous value to the char index
                _text_prev = text_ind;
            }
			//if character IS a sleep identifier
			else
			{
                //start sleep
                _text_sleep = text_slp;
            }
    
        }
		
		//if text is sleeping
		else
		{
            //check if final frame of sleep
            if (_text_sleep == 1)
			{
                //increment character past sleep identifier
                _text_char = text_ind + 1;
            }
    
            //decrements sleep counter
            _text_sleep--;
        }
    }
 
    //draw scrolling text
    draw_text(text_x, text_y, string_copy(text_str, 1, text_ind)); 
}
