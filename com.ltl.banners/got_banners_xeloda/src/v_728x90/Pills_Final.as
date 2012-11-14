package v_728x90
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;

	import flash.events.MouseEvent;

	/**
	 * @author Freelancer
	 */
	public class Pills_Final
	{
		public var mc : Pills_Final_728_MC;
		private var timeline : TimelineLite;

		public function Pills_Final(mc : Pills_Final_728_MC)
		{
			this.mc = mc;
			init();
			timeline = new TimelineLite();
			timeline.append(TweenLite.to(mc.arrrow_mc, .25, {x:625, scaleX:1.5, scaleY:1.5}));
			timeline.append(TweenLite.to(mc.emails_mc, .25, {scaleX:1.3, scaleY:1.3}),-.25);
			timeline.pause();
		}

		private function init() : void
		{
			mc.top_copy_mc.alpha = 0;
			mc.art_mc.alpha = 0;
			mc.bottom_copy_mc.alpha = 0;
			mc.arrrow_mc.alpha = 0;
			mc.emails_mc.alpha = 0;
			mc.hit_mc.buttonMode = true;
			mc.hit_mc.addEventListener(MouseEvent.ROLL_OVER, on_roll_over);
			mc.hit_mc.addEventListener(MouseEvent.ROLL_OUT, on_roll_out);
		}

		private function on_roll_over(event : MouseEvent) : void
		{
			timeline.play();
		}

		private function on_roll_out(event : MouseEvent) : void
		{
			timeline.reverse();
		}
	}
}
