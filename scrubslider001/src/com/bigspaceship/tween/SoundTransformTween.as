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
	
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.Sprite;
	
	public class SoundTransformTween extends EventDispatcher{
		
		protected static var __sp 	: Sprite = new Sprite();
		
		private var _channel		: SoundChannel;
		private var _tweens			: Array;
		private var _func			: Function;
		private var _stBegin		: SoundTransform;
		private var _stFinish		: SoundTransform;
		private var _time			: Number;
		private var _duration		: Number;
		
		public function SoundTransformTween($channel:SoundChannel, $st1:SoundTransform, $st2:SoundTransform, $dur:Number, $func:Function = null):void{
			_channel = $channel;
			_tweens = new Array();
			_func = $func || function (t:Number, b:Number, c:Number, d:Number):Number { return c*t/d + b; };

			_stBegin = $st1;
			_stFinish = $st2;
			
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
				(_channel) ? _channel.soundTransform = _getNextTransform() : SoundMixer.soundTransform = _getNextTransform();
			}
		};
		
		private function _getNextTransform():SoundTransform{
			var st:SoundTransform = new SoundTransform(
				_func(_time, _stBegin.volume, _stFinish.volume - _stBegin.volume, _duration), 
				_func(_time, _stBegin.pan, _stFinish.pan - _stBegin.pan, _duration)
			);
			
			return st;
		};
		
		
	}
}
