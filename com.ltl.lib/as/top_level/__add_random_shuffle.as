package top_level
{
	public function __add_random_shuffle(target_array : Array) : Array 
	{
		for(var i : int = 0;i < target_array.length;i++)
		{
			var a : Object = target_array[i];
			var b : Number = Math.floor(Math.random() * target_array.length);
			target_array[i] = target_array[b];
			target_array[b] = a;
		}
			
		return null;
	}
}
