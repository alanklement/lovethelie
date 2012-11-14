/*
Copyright (C) 2006 Big Spaceship, LLC

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

To contact Big Spaceship, email info@bigspaceship.com or write to us at 45 Main Street #716, Brooklyn, NY, 11201.
*/
package com.bigspaceship.tween{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Transform;
	import flash.geom.ColorTransform;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class ColorTransformTween extends EventDispatcher{
		
		protected static var __sp 	: Sprite = new Sprite();

		private var _dispObj	: DisplayObject;
		private var _transform	: Transform;
		private var _tweens		: Array;
		private var _func		: Function;
		private var _ctBegin	: ColorTransform;
		private var _ctFinish	: ColorTransform;
		private var _time		: Number;
		private var _duration	: Number;
		
		public function ColorTransformTween($obj:DisplayObject, $ct1:ColorTransform, $ct2:ColorTransform, $dur:Number, $func:Function = null):void{
			_dispObj = $obj;
			_transform = $obj.transform;
			_tweens = new Array();
			_func = $func || function (t:Number, b:Number, c:Number, d:Number):Number { return c*t/d + b; };

			_ctBegin = $ct1;
			_ctFinish = $ct2;
			
			_time = 0;
			_duration = $dur;
			
			start();
		};
		
		public function start():void{
			__sp.addEventListener(Event.ENTER_FRAME, _nextStep);
		};
		
		public function stop():void{
			__sp.removeEventListener(Event.ENTER_FRAME, _nextStep);
		};

		private function _nextStep($evt:Event = null):void{
			_time ++;
			if(_time > _duration){
				stop();
				// dispatch finished event
			}else{
				_transform.colorTransform = _getNextTransform();
			}
		};
		
		private function _getNextTransform():ColorTransform{
			var ctNew:ColorTransform = new ColorTransform(
				_func(_time, _ctBegin.redMultiplier, _ctFinish.redMultiplier - _ctBegin.redMultiplier, _duration), 
				_func(_time, _ctBegin.greenMultiplier, _ctFinish.greenMultiplier - _ctBegin.greenMultiplier, _duration), 
				_func(_time, _ctBegin.blueMultiplier, _ctFinish.blueMultiplier - _ctBegin.blueMultiplier, _duration), 
				_func(_time, _ctBegin.alphaMultiplier, _ctFinish.alphaMultiplier - _ctBegin.alphaMultiplier, _duration), 
				_func(_time, _ctBegin.redOffset, _ctFinish.redOffset - _ctBegin.redOffset, _duration), 
				_func(_time, _ctBegin.greenOffset, _ctFinish.greenOffset - _ctBegin.greenOffset, _duration), 
				_func(_time, _ctBegin.blueOffset, _ctFinish.blueOffset - _ctBegin.blueOffset, _duration), 
				_func(_time, _ctBegin.alphaOffset, _ctFinish.alphaOffset - _ctBegin.alphaOffset, _duration)
			);
			
			return ctNew;
		};
		
		
	}
}
