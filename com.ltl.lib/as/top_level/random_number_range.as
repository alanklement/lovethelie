package top_level 
{

	public function random_number_range(low : Number = 0, high : Number = 100) : Number
	{
		return Math.round(Math.random() * (high - low)) + low;
	}
}
