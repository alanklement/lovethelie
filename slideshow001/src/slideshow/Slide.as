package slideshow 
{
	import flash.display.Bitmap ;
	
	import flash.events.Event ;
	import flash.events.EventDispatcher ;
	
	
	public class Slide extends EventDispatcher 
	{
		protected var _bm 				: Bitmap ;;

		public function get image ():Bitmap {  return _bm ; }
		public function set image ( $img:Bitmap ):void {  _bm = $img ; }

		public function Slide ( $bm:Bitmap )
		{
			trace ( this + '   :::: Instansiated') ;
			_bm = $bm ;
			_bm.addEventListener ( Event.ADDED_TO_STAGE, __onAddedToStage ) ;			
			_setUpTransistions();
		}
			
		public function enter ():void {}
			
		public function exit ():void {}
		
		protected function _addedToStage():void {}
		
		protected function _setUpTransistions():void {}
		
		private function __onAddedToStage( $evt:Event ):void 
		{
			$evt.target.removeEventListener ( $evt.type, __onAddedToStage ) ;
			_addedToStage ();
		}
	}
}

