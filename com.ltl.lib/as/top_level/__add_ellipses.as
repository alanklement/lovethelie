package top_level
{
	public function __add_ellipses(orignal_string : String,max_length : int) : String 
	{
		if(orignal_string.length > max_length)
		{
			orignal_string = orignal_string.slice(0, max_length);
				
			if(orignal_string.charAt(orignal_string.length - 1) == " ")
			{				
				orignal_string = orignal_string.slice(0, max_length - 1);
			}
	
			orignal_string = orignal_string + "...";
		}
		
		return orignal_string;
	}
}
