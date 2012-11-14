package com.bigspaceship.events
{
	import flash.events.Event;

	public class SliderEvent extends Event
	{
		public static const START	:String			= "onSliderStart";
		public static const COMPLETE:String			= "onSliderComplete";

		public static const UPDATE	:String			= "onSliderUpdate";
		
		public var p				:Number;

		public function SliderEvent(type:String,$p:Number,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			p = $p;
		}
		//
		override public function clone():Event { return new SliderEvent(type,p,bubbles,cancelable); };		
	}
}