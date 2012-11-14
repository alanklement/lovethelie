package  {
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
		public var mc : Pills_Intro_MC;
		private var pulse : Pulse;
		private var timer : Timer;
		private var is_playing : Boolean;

		public function Intro_Pills(mc : Pills_Intro_MC, pulse : Pulse)
		{
			this.mc = mc;
			this.pulse = pulse;
			mc.addEventListener(Event.ADDED_TO_STAGE, set_up);
		}

		private function set_up(event : Event) : void {

			mc.removeEventListener(Event.ADDED_TO_STAGE, set_up);
			pulse.y = 10;
			mc.addChild(pulse);

			mc.chemo_txt_mc.alpha = 0;
			mc.pills_mc.alpha = 0;

			timer = new Timer(250);
			timer.addEventListener(TimerEvent.TIMER, check_pos);
			pulse.alpha = 0;
			setTimeout(start_timer, 500);
			pulse.timeline.gotoAndStop(0);
		}

		private function start_timer() : void
		{
			timer.start();
		}

		private function check_pos(event : TimerEvent) : void
		{
			if(mc.x == 150 && !is_playing)
			{
				pulse.alpha = 1;
				is_playing = true;
				pulse.begin_pulsing();
//				dispatchEvent(new Event(Main.HOT_SPOT_HIT));
			}

			if(mc.x < 145 )
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
	