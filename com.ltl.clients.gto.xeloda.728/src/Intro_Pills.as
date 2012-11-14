package 
{

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	/**
	 * @author Freelancer
	 */
	public class Intro_Pills extends EventDispatcher
	{
		public var mc : Pills_Intro_728_MC;
		private var pulse : Pulse;
		private var timer : Timer;
		private var is_playing : Boolean;

		public function Intro_Pills(mc : Pills_Intro_728_MC, pulse : Pulse)
		{
			this.mc = mc;
			this.pulse = pulse;
			pulse.y = 39;
			pulse.x = 360;
			mc.addChild(pulse);

			timer = new Timer(250);
			timer.addEventListener(TimerEvent.TIMER, check_pos);
			pulse.alpha = 0;
			setTimeout(timer.start, 500);

			pulse.timeline.gotoAndStop(0);
		}

		private function check_pos(event : TimerEvent) : void
		{
			if(mc.x == 0 && !is_playing)
			{
				pulse.alpha = 1;
				is_playing = true;
				pulse.begin_pulsing();
				dispatchEvent(new Event(Main.HOT_SPOT_HIT));
			}

			if(mc.x < 0 )
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
