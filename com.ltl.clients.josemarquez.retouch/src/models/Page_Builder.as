package models 
{
	import interactive.Interactive_Thumb;

	/**
	 * @author Alan
	 */
	public class Page_Builder 
	{
		private static const NUMBER_OF_ITEMS_PER_PAGE : int = 17;
		
		public static function create_pages(thumbs : Array) : Array 
		{
			var thumb_pages : Array = [];
			var num_of_pages : int = Math.ceil(thumbs.length / NUMBER_OF_ITEMS_PER_PAGE);
			var offset : int = 0;
			
			for (var i : int = 0;i < num_of_pages;i++) 
			{
				var page : Array = [];
				for (var j : int = 0;j < NUMBER_OF_ITEMS_PER_PAGE;j++) 
				{
					var thumb : Interactive_Thumb = Interactive_Thumb(thumbs[j + offset]);
					if(thumb)
					{
						page.push(thumb);
					}
				}
				offset += NUMBER_OF_ITEMS_PER_PAGE;
				thumb_pages.push(page);
			}
			
			return thumb_pages;
		}
	}
}
