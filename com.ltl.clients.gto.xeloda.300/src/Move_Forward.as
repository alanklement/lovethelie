package 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Freelancer
	 */
	public class Move_Forward extends EventDispatcher
	{
		public var mc : Move_Forward_Blue_MC;
		private var pulse : Pulse;
		public var yellow_dot : Yellow_Dot_MC;
		private var timer : Timer;
		private var is_playing : Boolean;

		public function Move_Forward(mc : Move_Forward_Blue_MC, pulse : Pulse, yellow_dot : Yellow_Dot_MC)
		{
			this.mc = mc;
			this.pulse = pulse;
			this.yellow_dot = yellow_dot;
			
			mc.addEventListener(Event.ADDED_TO_STAGE, set_up);
		}

		private function set_up(event : Event) : void {
			yellow_dot.x = -10;
			pulse.x = -10;
			mc.addChild(pulse);
			mc.addChild(yellow_dot);

			timer = new Timer(250);
			timer.addEventListener(TimerEvent.TIMER, check_pos);
			timer.start();
		}

		private function check_pos(event : TimerEvent) : void
		{
			if(mc.x <= 50 && !is_playing)
			{
				is_playing = true;
				pulse.begin_pulsing();
				
//				dispatchEvent(new Event(Main.HOT_SPOT_HIT));
			}

			if(mc.x > 50)
			{
				if(is_playing)
				{
					is_playing = false;
					pulse.discontinue_pulses();
				}
			}
		}
	}
}
