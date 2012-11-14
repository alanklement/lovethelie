package
{
	import flash.display.MovieClip ;
	
	public class Main extends MovieClip
	{
	
		private var _stack	: HStack = new HStack() ;

		public function Main()
		{            
			_stack.xml = "book1.xml" ;
			_stack.story = 1 ;
			_stack.x = 50 ;
			_stack.y = 50 ;
			_stack.load()  ;
			addChild ( _stack ) ;
		}
	
	}

}

