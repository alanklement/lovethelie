package data
{

	import flash.events.Event ;
	import flash.events.EventDispatcher ;
	import flash.display.Loader ;
	import flash.display.Bitmap ;
	
	import flash.net.URLLoader ;
	import flash.net.URLRequest ;

	/**
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author Alan Klement
	 *
	 *	@since 14.11.2008
	 */
	
	public class SlideShowData extends EventDispatcher 
	{
		private var _xmlURL 	: String ;
		private var _content	: Array ;
		private var _count      : uint  ;
		private var _countTo    : uint ;
		private var _urls 		: Array = [] ;
		
		public function set xml ( $xmlURL:String ):void { _xmlURL = $xmlURL ; }
		public function get images ():Array { return _content ; }
		
		/**
		 *	@constructor
		 */		

		public function SlideShow() { trace ( this + '   :::: SlideShow') ; }
		
		public function loadXML ():void
		{
			_content = [] ;
			_count = 0 ;
			
			var xmlLoader:URLLoader = new URLLoader ( new URLRequest ( _xmlURL ) ) ;
			xmlLoader.addEventListener ( Event.COMPLETE, _onXMLLoaded )  
		}
		
		private function _onXMLLoaded ( $evt:Event ):void
		{
			$evt.target.removeEventListener ( $evt.type, _onXMLLoaded ) ;
			
			var xml:XML = XML ( $evt.target.data ) 
			var list:XMLList = xml.*
			
			for each ( var url:XML in list )
			{
				_urls.push(  url.@source ) ;
			}
			_countTo =  _urls.length ;
			_loadNext() ;	
		}
		
		private function _loadNext ():void
		{	
			var loader:Loader =  new Loader() ;
			loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, _onLoadComplete ) ;
			loader.load ( new URLRequest ( _urls[ _count ] ) ) ;
			_count ++ ;
		}
		
		private function _onLoadComplete ( $evt:Event ):void
		{			
			var img:Bitmap = $evt.target.content ;
			_content.push ( img ) ;

			if ( _count == _countTo )
			{
				// clean
 				$evt.target.removeEventListener ( $evt.type, _onLoadComplete ) ;
				_urls = null ;
				_count = 0 ;
				
				dispatchEvent ( new Event ( Event.COMPLETE ) ) ;	
			}
			else
			{
				_loadNext() ;	
			}
		}	
	}
}
