package 
{

	import flash.events.Event ;
	import flash.events.MouseEvent ;
	import flash.events.EventDispatcher ;

	import flash.display.MovieClip ;
	import flash.display.DisplayObjectContainer ;

	import com.bigspaceship.utils.Out ;
	import com.bigspaceship.events.SliderEvent ;

	import gs.TweenLite ;
	import gs.easing.*
/**
 *	Application entry point for Scrub_Slider.
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 9.0
 *
 *	@author Alan Klement
 *	@since 11.03.2008
 *	
 *	
 *	
 *	
 *	
 *	// AK :
 *	@TODO Optimize for Garbage Collection 
 *	
 */
	public class ScrubScroller extends MovieClip 
	{
		/** 
		 * @private	
		 */
	
		private var _scroller	: MovieClip ;
		private var _scrollBar	: MovieClip ;
		private var _parent		: DisplayObjectContainer ;
		private var _speed		: uint ;
	
		/**
		 *	@get
		 *	@set
		 */
			
		public function set speed ( $speed:uint ):void
		{
			_speed = $speed ;
		}
		
		/**
		 *	@constructor
		 */
		
			
		public function ScrubScroller( $dragger:MovieClip, $bar:MovieClip, $parent:DisplayObjectContainer )
		{	
		
			_scroller 	= $dragger ;
			_scrollBar 	= $bar ;
			_parent		= $parent ;
		
			__init() ;
		}

		protected function __init ():void
		{		
			_scroller.addEventListener 	( MouseEvent.MOUSE_DOWN, 	__start ) ;
			_parent.addEventListener 	( MouseEvent.MOUSE_UP,  	__stop ) ;
		}
	
		protected function __start ( $evt:MouseEvent ):void
		{
			addEventListener ( Event.ENTER_FRAME, __calculateDrag ) ;
		}

		protected function __calculateDrag ( $evt:Event ):void
		{	
			var min = 0 ;
			var max = _scrollBar.width ;
			var xMouse = _scrollBar.mouseX
		
			if 	( xMouse <= min ) 
			{
				_scroller.x = min ;
			}
			else if ( xMouse >= max ) 
			{ 
				_scroller.x = max ;
			}
			else 
			{ 
				_scroller.x = xMouse ; 
			}

			var distance:Number = int( Math.cos ( ( ( _scroller.x ) / max ) * Math.PI ) * _speed ) ;
			dispatchEvent ( new SliderEvent ( SliderEvent.UPDATE, distance )) ;
			
			if ( distance <= 0 )
			{
				removeEventListener ( Event.ENTER_FRAME, __calculateSlowDown ) ;
			}		
		}

		protected function __calculateSlowDown ( $evt:Event ):void
		{
			var distance:Number = int( Math.cos ( ( ( _scroller.x ) / _scrollBar.width ) * Math.PI ) * _speed ) ;
			dispatchEvent ( new SliderEvent ( SliderEvent.UPDATE, distance )) ;		
		}
	
		protected function __stop ( $evt:MouseEvent ):void
		{				
			removeEventListener ( Event.ENTER_FRAME, __calculateDrag ) ;
			addEventListener 	( Event.ENTER_FRAME, __calculateSlowDown ) ;
								
			TweenLite.to ( _scroller, 1, { x:_scrollBar.width * .5, ease:Back.easeOut } )
		}
	}
}