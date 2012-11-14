package slideshow 
{

	import flash.events.Event;

	public class SlideEvent extends Event 
	{
	
		public static const ENTER_COMPLETE			: String = "ENTER_COMPLETE" ;
		public static const EXIT_COMPLETE			: String = "EXIT_COMPLETE" ;
		public static const SLIDE_DATA_LOADED		: String = "SLIDE_DATA_LOADED" ;
		public static const FIRST_SLIDE				: String = "FIRST_SLIDE" ;
		public static const LAST_SLIDE				: String = "LAST_SLIDE" ;
	
		public function SlideEvent( type:String, bubbles:Boolean=true, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable);
		}
	
		override public function clone():Event
		{
			return new SlideEvent(type, bubbles, cancelable);
		}
	
	}

}

