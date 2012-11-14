package com.bigspaceship.core.display{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	public class StandardBtn extends EventDispatcher{
		protected var _mc:MovieClip;
		
		public function get mc():MovieClip{
			return _mc;
		}
		
		public function StandardBtn($mc:MovieClip){
			_mc = $mc;
			
			//_mc.btn.addEventListener(MouseEvent.ROLL_OVER, _onRollOver);
			//_mc.btn.addEventListener(MouseEvent.ROLL_OUT, _onRollOut);
			//_mc.btn.addEventListener(MouseEvent.ROLL_OVER, _onRollOver, false, 0, true);
			
			var labels:Array = _mc.currentLabels;

			for (var i:uint = 0; i < labels.length; i++) {
			    var label:FrameLabel = labels[i];
			    //trace("frame " + label.frame + ": " + label.name);
			    switch(label.name){
			    	case 'ROLLOVER':
			    		_mc.btn.addEventListener(MouseEvent.ROLL_OVER, _onRollOver);
			    		break;
			    	case 'ROLLOUT':
			    		_mc.btn.addEventListener(MouseEvent.ROLL_OUT, _onRollOut);
			    		break;
			    	case 'CLICK':
			    		_mc.btn.addEventListener(MouseEvent.MOUSE_DOWN, _onClick);
			    		break;
			    }
			}
			_mc.addEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);
		}
		
		private function _onRollOver($evt:MouseEvent):void{
			//trace('ROLLOVER');
			_mc.gotoAndPlay('ROLLOVER');
			
		}
		
		private function _onRollOut($evt:MouseEvent):void{
			//trace('ROLLOUT');
			_mc.gotoAndPlay('ROLLOUT');
		}
		
		private function _onClick($evt:MouseEvent):void{
			//trace('StandardBtn: CLICK');
			_mc.gotoAndPlay('CLICK');
		}
		
		private function _onRemovedFromStage($evt:Event):void{
			_mc.btn.removeEventListener(MouseEvent.ROLL_OVER, _onRollOver);
			_mc.btn.removeEventListener(MouseEvent.ROLL_OUT, _onRollOut);
			_mc.btn.removeEventListener(MouseEvent.MOUSE_DOWN, _onClick);
		}

	}
}