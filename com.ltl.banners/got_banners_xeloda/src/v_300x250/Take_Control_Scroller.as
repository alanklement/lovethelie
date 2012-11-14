package v_300x250
{
	import com.greensock.TweenLite;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author Freelancer
	 */
	public class Take_Control_Scroller extends EventDispatcher
	{
		public static const UPDATE : String = "UPDATE";
		public var mc : Take_Control_MC;
		public var progress : Number;

		public function Take_Control_Scroller(mc : Take_Control_MC)
		{
			this.mc = mc;
			add_event_listeners();
		}

		private function add_event_listeners() : void
		{
			mc.handle.addEventListener(MouseEvent.MOUSE_DOWN, start_drag);
			mc.handle.buttonMode = true;
		}

		private function start_drag(event : MouseEvent) : void
		{
			mc.handle.removeEventListener(MouseEvent.MOUSE_DOWN, start_drag);
			mc.handle.stage.addEventListener(MouseEvent.MOUSE_UP, stop_drag);
			mc.handle.stage.addEventListener(MouseEvent.MOUSE_MOVE, report_handle_pos);
			mc.handle.startDrag(false, new Rectangle(0, 0, 100, 0));
		}

		private function report_handle_pos(event : MouseEvent) : void
		{
			this.progress = mc.handle.x * .01;
			dispatchEvent(new Event(UPDATE));
		}

		private function stop_drag(event : MouseEvent) : void
		{
			mc.handle.stage.removeEventListener(MouseEvent.MOUSE_MOVE, report_handle_pos);
			mc.handle.stage.removeEventListener(MouseEvent.MOUSE_UP, stop_drag);
			mc.handle.addEventListener(MouseEvent.MOUSE_DOWN, start_drag);
			mc.handle.stopDrag();
		}

		public function set_handle_pos(number : Number) : void
		{
			TweenLite.to(mc.handle, .2, {x:Math.round(number)});
		}
	}
}
