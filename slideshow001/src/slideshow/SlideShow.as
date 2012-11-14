package  slideshow
{
	import flash.display.Bitmap ;
	import flash.display.DisplayObjectContainer ;
	
	import flash.events.Event ;
	import flash.events.EventDispatcher ;

	import data.SlideShowData ;

	public class SlideShow extends EventDispatcher 
	{
		private var _data 			: SlideShowData ;
		private var _xmlURL			: String ; 	
		private var _images			: Array ;
		private var _currentImg		: int = 0 ;
		private var _holder 		: DisplayObjectContainer ;
				
		public function set xml ( $xmlURL:String ):void {  _xmlURL = $xmlURL; }
		
		public function set holder ( $obj:DisplayObjectContainer ):void {  _holder = $obj; }
		
		public function SlideShow() {}
		
		public function init ():void
		{
			if ( _xmlURL == null ) { throw new Error ( "Error: use 'mySlideShow.xml' to set an XML file to load ") ; }
			if ( _holder == null ) { throw new Error ( "Error: use 'mySlideShow.holder' to set a container to hold the slideshow ") ; }
			
			_images = [] ;
		
			_data = new SlideShowData();
			_data.addEventListener ( Event.COMPLETE, _onDataLoaded )
			_data.xml = _xmlURL ;
			_data.loadXML() ;
		}
		
		public function loadFirstSlide ():void
		{
			_images [ _currentImg ].enter();
			dispatchEvent( new SlideEvent( SlideEvent.FIRST_SLIDE ) )
		}

		public function nextSlide ():void
		{	
			if ( _currentImg + 1 == _images.length ) { return ;}
			
			_images [ _currentImg ].exit();
			_currentImg ++ ;			
			_images [ _currentImg ].enter();
			
			if ( _currentImg + 1 == _images.length ) { dispatchEvent( new SlideEvent( SlideEvent.LAST_SLIDE ) ) ;}			
		}
		
		public function previousSlide ():void
		{
			if ( _currentImg  == 0 ) { return ;}
			
			_images [ _currentImg ].exit();
			_currentImg -- ;			
			_images [ _currentImg ].enter();
			
			if ( _currentImg  == 0 ) { dispatchEvent( new SlideEvent( SlideEvent.FIRST_SLIDE ) ) ;}			
		}
		public function clean ( ):void
		{
			_images [ _currentImg ].addEventListener ( SlideEvent.EXIT_COMPLETE, _finishClean ) ;
			_images [ _currentImg ].exit() ;	
		}

		private function _onDataLoaded ( $evt:Event ):void
		{
			$evt.target.removeEventListener ( $evt.type, _onDataLoaded ) ;

			for each ( var image:Bitmap in _data.images )
			{
				var slide:FadingSlide = new FadingSlide ( image ) ;
				_holder.addChild ( slide.image ) ;
				_images.push( slide ) ;
			}		
			
			dispatchEvent ( new SlideEvent ( SlideEvent.SLIDE_DATA_LOADED ) ) ;
		}
		
		private function _finishClean ( $evt:SlideEvent ):void
		{
			$evt.target.removeEventListener ( $evt.type, _finishClean ) ;
			if ( _data.hasEventListener ( Event.COMPLETE ) ) _data.removeEventListener ( Event.COMPLETE, _onDataLoaded ) ;

			var i : uint = 0  ;
			var l : uint = _images.length
			
			for ( i ; i < l ; i++)
			{
				_holder.removeChild ( _images [ i ].image ) ;
			}
			
			_currentImg = 0 ;
			_images = null ;	
			_data = null ;	
		}
	}
}

