package v_728x90
{
	import com.greensock.TweenLite;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author Freelancer
	 */
	public class Pulling_Arrow extends EventDispatcher
	{
		public static const ARROW_TRIGGERED : String = "ARROW_TRIGGERED";
		public var mc : Yellow_Arrow_728;
		private var arrow_head : MovieClip;
		private var hit : MovieClip;

		public function Pulling_Arrow(art : Yellow_Arrow_728)
		{
			this.mc = art;
			mc.addEventListener(Event.ADDED_TO_STAGE, set_up);
			this.arrow_head = MovieClip(mc.arrow.getChildByName("head"));
			this.hit = MovieClip(mc.arrow.getChildByName("hit"));
		}

		private function set_up(event : Event) : void
		{
			add_event_listeners();
			hit.buttonMode = true;
		}

		private function add_event_listeners() : void
		{
			hit.addEventListener(MouseEvent.ROLL_OVER, get_bigger);
			hit.addEventListener(MouseEvent.ROLL_OUT, get_smaller);
			hit.addEventListener(MouseEvent.MOUSE_DOWN, start_drag);
		}

		private function start_drag(event : MouseEvent) : void
		{
			mc.arrow.startDrag(false, new Rectangle(-198, -18, 70, 0));
			mc.arrow.addEventListener(MouseEvent.MOUSE_MOVE, check_x_pos_other_pull);
		}

		private function check_x_pos_other_pull(event : MouseEvent) : void
		{
			if(mc.arrow.x >= -135)
			{
				mc.arrow.removeEventListener(MouseEvent.MOUSE_MOVE, check_x_pos_other_pull);

				mc.arrow.stopDrag();
				dispatchEvent(new Event(Pulling_Arrow.ARROW_TRIGGERED));
				TweenLite.to(mc.arrow, .5, {x:-198});
			}
		}

		private function get_smaller(event : MouseEvent) : void
		{
			new TweenLite(arrow_head, .5, {scaleX:1, scaleY:1});
		}

		private function get_bigger(event : MouseEvent) : void
		{
			new TweenLite(arrow_head, .5, {scaleX:1.3, scaleY:1.3});
		}

		public function disable() : void
		{
			this.mc.mouseChildren = false;
			this.mc.mouseEnabled = false;
		}

		public function enable() : void
		{
			this.mc.mouseChildren = true;
			this.mc.mouseEnabled = true;
		}
	}
}
