package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Freelancer
	 */
	public class Heart extends EventDispatcher
	{
		public var mc : Sprite;
		private var pulse : Pulse;
		private var dot : Green_Dot_MC;
		private var is_playing : Boolean;
		private var timer : Timer;

		public function Heart(mc : Sprite, pulse : Pulse, dot : Green_Dot_MC)
		{
			this.mc = mc;
			this.pulse = pulse;
			this.dot = dot;
			mc.addEventListener(Event.ADDED_TO_STAGE, set_up);
			
		}

		private function set_up(event : Event) : void {
			mc.addChild(dot);
			mc.addChild(pulse);

			init_properties();

			timer = new Timer(250);
			timer.addEventListener(TimerEvent.TIMER, check_pos);
			timer.start();
		}

		private function check_pos(event : TimerEvent) : void
		{
			if(mc.x > 119 && mc.x < 165 && !is_playing)
			{
				is_playing = true;
				pulse.begin_pulsing();
				dispatchEvent(new Event(Main.HOT_SPOT_HIT));
			}

			if(mc.x < 119 || mc.x > 165)
			{
				if(is_playing)
				{
					is_playing = false;
					pulse.discontinue_pulses();
				}
			}
		}

		private function init_properties() : void
		{
			dot.y = 105;
		}
	}
}
