package  
{
	import flash.utils.Dictionary;

	public class PropertyVO
	{	
		private var dictionary : Dictionary = new Dictionary(true);

		public function PropertyVO(propertiesToWatch : Array)
		{
			for each (var item : String in propertiesToWatch) 
			{
				dictionary[item] = "";
			}	
		}

		public function extractCurrentProperties(objectToRecord : *) : void
		{
			for (var property : String in dictionary) 
			{				
				dictionary[property] = objectToRecord[property];
			}
		}

		public function restoreProperties(objectToRestore : *) : void
		{
			for (var property : String in dictionary) 
			{
				objectToRestore[property] = dictionary[property];
			}
		}

		public function dispose() : void
		{
			for (var item : String in dictionary) 
			{
				item = null;	
			}
			
			dictionary = null;
		}
	}
}
