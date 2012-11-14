package
v_300{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;

	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	/**
	 * @author Freelancer
	 */
	public class Accordian extends EventDispatcher
	{
		public var mc : MovieClip;
		public var grey_line : MovieClip;
		public var copy : MovieClip;
		public var content : MovieClip;
		private var timeline : TimelineLite;
		private var content_start : Number;
		private var tick : MovieClip;
		private var glow : MovieClip;
		private var hit : MovieClip;

		public function Accordian(mc : MovieClip)
		{
			TweenPlugin.activate([TintPlugin]);

			this.mc = mc;
			create_references();
			add_event_listeners();
			init_objects();
			create_timeline();
		}

		private function add_event_listeners() : void
		{
			hit.addEventListener(MouseEvent.ROLL_OVER, open);
			hit.addEventListener(MouseEvent.ROLL_OUT, close);
		}

		private function create_timeline() : void
		{
			timeline = new TimelineLite();
			timeline.stop();

			timeline.appendMultiple([new TweenLite(grey_line, .25, {alpha:1, scaleX:1})]);
			timeline.append(new TweenLite(tick, .25, {alpha:1}), -.2);
			timeline.appendMultiple([new TweenLite(content, .25, {y:content_start + 40})], -.1);
			timeline.append(new TweenLite(glow, .25, {alpha:1}), -.2);
		}

		private function init_objects() : void
		{
			grey_line.alpha = 0;
			grey_line.scaleX = .2;
			content_start = content.y;
			tick.alpha = 0;
			glow.alpha = 0;
			hit.buttonMode = true;
		}

		private function create_references() : void
		{
			copy = MovieClip(mc.getChildByName("mc_copy"));
			grey_line = MovieClip(mc.getChildByName("mc_grey_line"));
			content = MovieClip(mc.getChildByName("mc_content"));
			tick = MovieClip(mc.getChildByName("mc_tick"));
			glow = MovieClip(mc.getChildByName("mc_glow"));
			hit = MovieClip(mc.getChildByName("hit"));
		}

		public function open(event : MouseEvent = null) : void
		{
			if(event)
			{
				dispatchEvent(event.clone());
				
			}
			hit.height = 75;
			new TweenLite(copy, .25, {tint:0xffffff});
			copy.removeEventListener(MouseEvent.CLICK, open);
			copy.addEventListener(MouseEvent.CLICK, close);
			timeline.play();
		}

		public function close(event : MouseEvent = null) : void
		{
			if(event)
			{
				dispatchEvent(event.clone());
			}
			hit.height = 27;
			new TweenLite(copy, .25, {tint:0x34A98D});
			copy.removeEventListener(MouseEvent.CLICK, close);
			copy.addEventListener(MouseEvent.CLICK, open);
			timeline.reverse();
		}
	}
}
