/*
Copyright (C) 2008 Big Spaceship, LLC

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
package com.bigspaceship.utils{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	public class SimpleSequencer extends EventDispatcher{
		
		public var debug:Boolean = true; 
		
		private var _animationSteps_array:Array = new Array();
		private var _countStep:int;
		
		private var _id:String;
				
		private var _parallelActions_array:Array;
		private var _timer_dic:Dictionary = new Dictionary();
		
		public function SimpleSequencer($id:String){
			//creating an "unique" id for debugging reasons
			_id = $id +'_'+ int(Math.random()*100);
			
			if(debug){
				trace('SimpleSequencer CONSTRUCTOR', _id);
				addEventListener(Event.ENTER_FRAME, _onEnterFrame_handler);
			}
		}
		
		public function traceSteps():void{
			for(var i:int=0; i<_animationSteps_array.length; i++){
				trace('AnimStep', _animationSteps_array[i].stepId, _animationSteps_array[i].array);
			}
		}
		
		public function addStep($stepId:Number, $target:EventDispatcher, $functionToCall:Function, $eventToListen:String, $args:Object=null):void{
			var anim:Object = {type:'normal', target:$target, functionToCall:$functionToCall, eventToListen:$eventToListen, args:$args};
			
			var stepExists:Boolean = false;
			for(var i:int=0; i<_animationSteps_array.length; i++){
				if(_animationSteps_array[i].stepId == $stepId){
					_animationSteps_array[i].array.push(anim);
					stepExists = true;
				}
			}
			if(!stepExists){
				_animationSteps_array.push({stepId:$stepId, array:new Array(anim)});
			}
		}
		
		public function start():void{
			
			if(_animationSteps_array.length > 0){
				//sort array by stepId:
				_animationSteps_array.sortOn('stepId', Array.NUMERIC);
				if(debug){
					trace('SimpleSequencer START:', _id, 'steps:', _animationSteps_array.length, '_countStep:', _countStep, 'stepId:', _animationSteps_array[_countStep].stepId );
				}
				_parallelActions_array = new Array();
				var i:int;
				var animObj:Object;
				//addEventlisteners
				for (i=0; i<_animationSteps_array[_countStep].array.length; i++){
					animObj = _animationSteps_array[_countStep].array[i];
					switch (animObj.type){
						case 'normal':
							animObj.target.addEventListener(animObj.eventToListen, _onAnimationComplete);
							break;
						/* case 'bigTweenLite':
							break; */
					}
					//_semaphoreParallels.addLock(newSemLockId());
					newSemLockId();
				}
				for (i=0; i<_animationSteps_array[_countStep].array.length; i++){
					animObj = _animationSteps_array[_countStep].array[i];
					switch (animObj.type){
						case 'normal':
							if(animObj.args && animObj.args.hasOwnProperty('delay')){
								if(debug){
									trace('delay:: ', animObj.args.delay);
								}
								var timer:Timer = new Timer(animObj.args.delay, 1);
								timer.addEventListener(TimerEvent.TIMER, _onTimerEvent_handler);
								_timer_dic[timer] = animObj;
								timer.start()
							}else{
								 if(animObj.args && animObj.args.hasOwnProperty('functionToCallParams')){
									animObj.functionToCall.apply(null, animObj.args.functionToCallParams);
								}else{
									animObj.functionToCall();
								} 
							}
							break;
					}
				}
			}else{
				_onComplete();
				if(debug){
					trace('no steps added!');
				}
			}
		}
		
		private function _onTimerEvent_handler($evt:Event):void{
			if(debug){
				trace('SimpleSequencer _onTimerEvent_handler, target:',_timer_dic[$evt.target].target);
			}
			if(_timer_dic[$evt.target].args && _timer_dic[$evt.target].args.hasOwnProperty('functionToCallParams')){
				_timer_dic[$evt.target].functionToCall.apply(null, _timer_dic[$evt.target].args.functionToCallParams);
			}else{
				_timer_dic[$evt.target].functionToCall();
			}
			$evt.target.removeEventListener($evt.type, _onTimerEvent_handler);
			delete _timer_dic[$evt.target];
		}
		
		private function newSemLockId():String{
			var lock:String;
			//do.. while loop to prevent double lockIds.
			do{ 
				lock = String(Math.random());
			}
			while(_parallelActions_array.indexOf(lock)>-1);
			_parallelActions_array.push(lock);
			if(debug){
				trace('newLockId: ', lock, ', countLocks:',  _parallelActions_array.length);
			}
			return lock;
		}
		
		private function _onEnterFrame_handler($evt:Event):void{
			trace('sequence running:', _id, 'steps:', _animationSteps_array.length,'_countStep:', _countStep, 'stepId:', _animationSteps_array[_countStep].stepId);
		}
		
		private function _onAnimationComplete($evt:Event):void{
			//trace('AnimationSequencer, _onAnimationComplete', $evt.currentTarget, $evt.target, $evt.type);
			$evt.target.removeEventListener($evt.type, _onAnimationComplete);
			_parallelActions_array.pop();
			_checkSemaphores();
		}
		
		private function _checkSemaphores():void{
			if(_parallelActions_array.length < 1){
				if(_countStep+1<_animationSteps_array.length){
					_countStep+=1;
					//start next step
					start();
				}else{
					//all animations complete
					_onComplete();
				}
			}
		}
		
		private function _onComplete():void{
			if(debug){
				trace('SimpleSequencer COMPLETE', _id);
			}
			removeEventListener(Event.ENTER_FRAME, _onEnterFrame_handler);
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}