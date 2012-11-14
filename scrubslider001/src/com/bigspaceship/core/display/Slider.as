package com.bigspaceship.core.display
{
	import com.bigspaceship.events.SliderEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class Slider extends EventDispatcher
	{
		protected var _mc			: MovieClip;				
		protected var _dragger 		: MovieClip;
		protected var _trough		: MovieClip;
		
		protected var _isDragging	: Boolean;
		protected var _isHorizontal	: Boolean;
		protected var _offset		: int;
		
		public function Slider($mc:MovieClip, $isHorizontal:Boolean = false)
		{
			super();
			_mc = $mc;
			
			_dragger = _mc.dragger_mc;
			_trough = _mc.trough_mc;

			_isDragging = false;
			_isHorizontal = $isHorizontal;

			_dragger.buttonMode = true;
			_dragger.useHandCursor = true;
			_dragger.mouseChildren = false;
			_dragger.addEventListener(MouseEvent.MOUSE_DOWN,_draggerOnMouseDown,false,0,true);
		}
		
		/**
		*  <code>getMC()</code>
		*
		*	@return MovieClip of this object
		*/
		public function getMC():MovieClip { return _mc; };
		public function get visible():Boolean { return _dragger.visible; };
		public function set visible($isVisible:Boolean):void { _dragger.visible = $isVisible; };
		public function get isDragging():Boolean { return _isDragging; };
		/**
		*  The <code>offset()</code> method sets the offset, if any,
		*	for the gutter left/right or top/bottom
		*
		*	@param offset Specifies the offset
		*/
		public function set offset($value:int):void
		{
			_offset = $value;
		};
		
		public function reset():void
		{
			_isHorizontal ? _dragger.x = 0 : _dragger.y = 0;
			_draggerOnMouseUp();
			_update();
		};
		
		public function setPos($n:Number):void
		{
			if(_isHorizontal) _dragger.x = ((_trough.width - _offset) - _dragger.width) * $n;
			else _dragger.y = ((_trough.height - _offset) - _dragger.height) * $n;
			_update();
		};
		
		public function getPos():Number
		{
			var cur:Number = _isHorizontal ? _dragger.x : _dragger.y;
			var tot:Number = _isHorizontal ? (_trough.width - _dragger.width) : (_trough.height - _dragger.height);		
			var p:Number = cur/tot;
						
			return p;
		};
		
		private function _draggerOnMouseDown($evt:MouseEvent):void
		{
			_isDragging = true;
			dispatchEvent(new SliderEvent(SliderEvent.START,_getPercentageDragged()));

			var r:Rectangle;
			if(_isHorizontal) r = new Rectangle(0,0,(_trough.width - _offset) - _dragger.width,0);
			else r = new Rectangle(0,0,0,(_trough.height - _offset) - _dragger.height)
			_dragger.startDrag(false,r);

			_mc.addEventListener(Event.ENTER_FRAME,_update,false,0,true);
			_mc.stage.addEventListener(MouseEvent.MOUSE_UP,_draggerOnMouseUp,false,0,true);
		};
		
		private function _draggerOnMouseUp($evt:MouseEvent = null):void
		{
			_isDragging = false;
			_dragger.stopDrag();
			_mc.removeEventListener(Event.ENTER_FRAME,_update);
			_mc.stage.removeEventListener(MouseEvent.MOUSE_UP,_draggerOnMouseUp);
			dispatchEvent(new SliderEvent(SliderEvent.COMPLETE,_getPercentageDragged()));
		};
		
		protected function _update($evt:Event = null):void { dispatchEvent(new SliderEvent(SliderEvent.UPDATE,_getPercentageDragged())); };
		
		private function _getPercentageDragged():Number
		{
			var cur:Number = _isHorizontal ? _dragger.x : _dragger.y;
			var tot:Number = _isHorizontal ? ((_trough.width - _offset) - _dragger.width) : ((_trough.height - _offset) - _dragger.height);		
			return cur/tot;	
		};
	}
}