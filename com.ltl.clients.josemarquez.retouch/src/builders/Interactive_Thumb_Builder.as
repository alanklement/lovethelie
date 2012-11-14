package builders 
{
	import interactive.Interactive_Thumb;

	import top_level.__add_linked_list_behaviour_array;

	/**
	 * @author Alan
	 */
	public class Interactive_Thumb_Builder
	{	
		public static function build(vos : Array) : Array 
		{
			var thumbs : Array = [];
			
			for (var i : int = 0;i < vos.length;i++) 
			{
				thumbs.push(new Interactive_Thumb(vos[i]));			
			}
			
			return __add_linked_list_behaviour_array(thumbs);
		}	
	}
}
