package com.bigspaceship.core.display
{
	import com.bigspaceship.events.SliderEvent;
	import com.bigspaceship.core.display.Slider;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class SliderWithButtons extends Slider
	{	
		private var _up_mc 			: MovieClip;
		private var _down_mc		: MovieClip;
		private var _lastTarget		: MovieClip;
		private var _buttonsOnly	: Boolean;
		private var _dist			: int = 3;
		
		public function SliderWithButtons($mc:MovieClip, $isHorizontal:Boolean = false, $buttonsOnly:Boolean = false)
		{
			super($mc, $isHorizontal);
			
			_buttonsOnly = $buttonsOnly;
			_dragger.visible = _trough.visible = !_buttonsOnly;
			_up_mc = _mc.up_mc;
			_down_mc = _mc.down_mc;
			_lastTarget = _up_mc;
			
			_up_mc.buttonMode = true;
			_up_mc.useHandCursor = true;
			_up_mc.mouseChildren = false;
			_up_mc.addEventListener(MouseEvent.MOUSE_DOWN, _scroll, false, 0, true);
			
			_down_mc.buttonMode = true;
			_down_mc.useHandCursor = true;
			_down_mc.mouseChildren = false;
			_down_mc.addEventListener(MouseEvent.MOUSE_DOWN, _scroll, false, 0, true);
		};
		
		
		override protected function reset():void
		{
			_lastTarget = _up_mc;
			super.reset();
		};
		
		
		private function _scroll($evt:MouseEvent):void
		{
			if($evt.target != _lastTarget)
			{
				_dist *= -1;
				_lastTarget = $evt.target as MovieClip;
			}
			_mc.addEventListener(Event.ENTER_FRAME, _updateScroll, false, 0, true);
			_mc.stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp, false, 0, true);
		};
		
		
		private function _onMouseUp($evt:MouseEvent = null):void
		{
			_mc.removeEventListener(Event.ENTER_FRAME, _updateScroll);
			_mc.stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
		};
		
		
		private function _updateScroll($evt:Event = null):void
		{
			if(_isHorizontal)
			{
				_dragger.x -= _dist;
				if(_dragger.x >= _trough.width - _dragger.width) _dragger.x = _trough.width - _dragger.width;
				if(_dragger.x <= 0) _dragger.x = 0;
			}else
			{
				_dragger.y -= _dist;
				if(_dragger.y >= _trough.height - _dragger.height) _dragger.y = _trough.height - _dragger.height;
				if(_dragger.y <= 0) _dragger.y = 0;
			}
			super._update($evt);
		};
		
		public function set scrollAmount($v:int):void { _dist = $v; };
	};
};