package
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;

	import flash.display.MovieClip;
	import flash.events.Event;

	public class Collapsed extends MovieClip
	{
		private var intro_timeline : TimelineLite;
		public var mc_log : MovieClip;
		public var mc_photo1 : MovieClip;
		public var mc_photo2 : MovieClip;
		public var mtd_copy_mc : MovieClip;
		public var click_to_see_vis_mc : MovieClip;
		public var field1 : MovieClip;
		public var logo_mc : MovieClip;

		public function Collapsed()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, animate_in);
			create_timelines();
		}

		private function create_timelines():void
		{
			intro_timeline = new TimelineLite();
			intro_timeline.stop();
			intro_timeline.append(TweenLite.to(logo_mc, .25, {x:18.95}));
			intro_timeline.append(TweenLite.from(mc_log, 1, {y:750, ease:Back.easeOut}));
			intro_timeline.append(TweenLite.from(click_to_see_vis_mc, .75, {y:516.8, ease:Back.easeOut}), -.75);
			intro_timeline.append(TweenLite.from(mtd_copy_mc, .75, {alpha:0}), -.5);
			intro_timeline.append(TweenLite.from(mc_photo1, .75, {x:-250, ease:Back.easeOut}), -1);
			intro_timeline.append(TweenLite.from(mc_photo2, .75, {x:174, ease:Back.easeOut}), -1);
			intro_timeline.append(TweenLite.from(field1.grass1, .75, {y:"200", ease:Back.easeOut}), -.5);
			intro_timeline.append(TweenLite.from(field1.grass2, .75, {y:"200", ease:Back.easeOut}), -.6);
			intro_timeline.append(TweenLite.from(field1.grass3, .75, {y:"200", ease:Back.easeOut}), -.6);
			intro_timeline.append(TweenLite.from(field1.bush1, .75, {y:"200", ease:Back.easeOut}), -.6);
			intro_timeline.append(TweenLite.from(field1.flowers, .75, {alpha:0}), -.6);
		}

		public function animate_in(event : Event = null) : void
		{
			intro_timeline.play();
		}
	}
}