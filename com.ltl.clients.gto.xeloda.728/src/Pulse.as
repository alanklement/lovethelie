package 
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;

	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author Freelancer
	 */
	public class Pulse extends Sprite
	{
		public var timeline : TimelineLite;
		private var Pulse_Art : Class;
		private var pulse : MovieClip;
		private var continue_pulses : Boolean;
		private var inner_mc : MovieClip;

		public function Pulse(Art : Class)
		{
			this.Pulse_Art = Art;

			pulse = new Pulse_Art();
			this.inner_mc = MovieClip(pulse.getChildByName("inner_mc"));

			addChild(pulse);
			create_pulse_timeline();
		}

		private function create_pulse_timeline() : void
		{
			pulse.scaleX = pulse.scaleY = .01;
			timeline = new TimelineLite({onComplete:check_to_continue});
			timeline.append(new TweenLite(pulse, .1, {alpha:1}));
			timeline.appendMultiple([new TweenLite(pulse, 2.5, {alpha:0}), new TweenLite(pulse, 2.75, {scaleX:1.5, scaleY:1.5}), new TweenLite(inner_mc, 1, {alpha:0})]);
		}

		private function check_to_continue() : void
		{
			if(continue_pulses)
			{
				timeline.gotoAndPlay(0);
			}
		}

		public function begin_pulsing() : void
		{
			timeline.gotoAndPlay(0);
			continue_pulses = true;
		}

		public function discontinue_pulses() : void
		{
			continue_pulses = false;
		}
	}
}
