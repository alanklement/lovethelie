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
	public class Advice extends EventDispatcher
	{
		public var mc : Sprite;
		private var pulse : Pulse;
		// private var advice_mc : MovieClip;
		private var dot : Green_Dot_MC;
		private var timer : Timer;
		private var is_playing : Boolean;

		public function Advice(mc : Sprite, pulse : Pulse, dot : Green_Dot_MC)
		{
			this.mc = mc;
			this.pulse = pulse;
			this.dot = dot;
			mc.addChild(dot);
			mc.addChild(pulse);

			init_properties();

			timer = new Timer(250);
			timer.addEventListener(TimerEvent.TIMER, check_pos);
			timer.start();
		}

		private function check_pos(event : TimerEvent) : void
		{
			if(mc.x > -20 && mc.x < 20 && !is_playing)
			{
				is_playing = true;
				pulse.begin_pulsing();
				dispatchEvent(new Event(Main.HOT_SPOT_HIT));
			}

			if(mc.x < -20 || mc.x > 20)
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
			dot.x = 115;
			dot.y = 74;

			pulse.x = 280;
			pulse.y = 48;
		}
	}
}
