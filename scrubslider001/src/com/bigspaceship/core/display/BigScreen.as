package com.bigspaceship.core.display
{
	import flash.display.Sprite;
	import flash.display.MovieClip;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.bigspaceship.core.display.ScreenState;
	import com.bigspaceship.events.AnimationEvent;

	public class BigScreen extends Sprite
	{
		protected var _mc 			:MovieClip;
		protected var _curState		:String;
		protected var _nextState	:String;
		
		public function BigScreen($mc:MovieClip)
		{
			super();

			_mc = $mc;
			_mc.addEventListener(AnimationEvent.ANIMATE_IN_START,_animateInStart_handler,false,0,true);
			_mc.addEventListener(AnimationEvent.ANIMATE_IN,_animateInComplete_handler,false,0,true);
			_mc.addEventListener(AnimationEvent.ANIMATE_OUT_START,_animateOutStart_handler,false,0,true);
			_mc.addEventListener(AnimationEvent.ANIMATE_OUT,_animateOutComplete_handler,false,0,true);
			addChild(_mc);

			_nextState = _curState = ScreenState.OUT;
		};

		public function get mc():MovieClip { return _mc; };
		public function get state():String { return _curState; };

		// in, leave these alone.	
		public function animateIn():void
		{
			_mc.gotoAndPlay("IN");
			_nextState = _curState = ScreenState.ANIMATE_IN;
		};
	
		private function _animateInStart_handler($evt:AnimationEvent):void{ _onAnimateInStart(); };
	
		private function _animateInComplete_handler($evt:AnimationEvent):void
		{
			_curState = ScreenState.IN;

			// jk: if the lastState is ANIMATE_OUT, at some point before we got to this handler animateOut was called. immediately call animateOut so we can effectively "catch up" with the user's request.
			if(_nextState == ScreenState.ANIMATE_OUT) animateOut();
			else
			{
				_nextState = _curState;
				_onAnimateIn();
			}
		};

		// in, extend these
		protected function _onAnimateIn():void { dispatchEvent(new AnimationEvent(AnimationEvent.ANIMATE_IN)); };
		protected function _onAnimateInStart():void { dispatchEvent(new AnimationEvent(AnimationEvent.ANIMATE_IN_START)); };

		// out, leave these alone.
		public function animateOut():void
		{
			// jk: first check to see if we're in. we don't want the OUT animation to play unless we've finished animating in.
			if(_curState == ScreenState.IN)
			{
				_curState = ScreenState.ANIMATE_OUT;
				_mc.gotoAndPlay("OUT");
			}
			
			// jk: set the state to animate out regardless. _animateInComplete_handler() will call animateOut() immediately.
			_nextState = ScreenState.ANIMATE_OUT;
		};
	
		private function _animateOutStart_handler($evt:AnimationEvent):void { _onAnimateOutStart(); };	
		private function _animateOutComplete_handler($evt:AnimationEvent):void { _onAnimateOut(); };
	
		// out, extend these
		protected function _onAnimateOutStart():void { dispatchEvent(new AnimationEvent(AnimationEvent.ANIMATE_OUT_START)); };
	
		// jk: _onAnimateOut should double as a cleanUp function.
		protected function _onAnimateOut():void
		{
			_nextState = _curState = ScreenState.OUT;
			dispatchEvent(new AnimationEvent(AnimationEvent.ANIMATE_OUT));
		};	
	};
};