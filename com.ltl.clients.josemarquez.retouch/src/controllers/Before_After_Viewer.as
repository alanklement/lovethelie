package controllers 
{
	import effects.Reflective_Image;

	import com.greensock.TweenMax;

	import org.osflash.signals.Signal;

	import flash.display.Bitmap;
	import flash.display.Sprite;

	/**
	 * @author Alan
	 */
	public class Before_After_Viewer 
	{
		public var notfy_clear_complete : Signal = new Signal();
		private var before : Bitmap;
		private var after : Bitmap;
		private var holder : Sprite;
		private var after_reflection : Reflective_Image;
		private var before_reflection : Reflective_Image;

		public function Before_After_Viewer(holder : Sprite) 
		{
			this.holder = holder;
		}

		public function update(before : Bitmap, after : Bitmap) : void 
		{
			this.before = before;
			this.after = after;
			
			fade_out_holder();
		}

		private function fade_out_holder() : void 
		{
			new TweenMax(holder, .5, {alpha:0, onComplete:clean_images});
		}

		public function reset() : void 
		{
			new TweenMax(holder, .5, {alpha:0, onComplete:remove});
		}

		private function clean_images() : void 
		{
			remove();
			
			add_images_to_container();
		}

		private function remove() : void 
		{
			while(holder.numChildren > 1)
			{
				holder.removeChildAt(holder.numChildren - 1);	
			}			
			notfy_clear_complete.dispatch();
		}

		private function add_images_to_container() : void 
		{
			after_reflection= new Reflective_Image(after, holder);
			before_reflection = new Reflective_Image(before, holder);

			holder.addChild(after_reflection);
			holder.addChild(before_reflection);

			before_reflection.alpha = 0;

			fade_in_holder();
		}

		public function fade_in_holder() : void 
		{
			new TweenMax(holder, .5, {alpha:1});
		}

		public function cross_fade(state : String) : void 
		{
			if(state == Cross_Fader.SHOW_AFTER)
			{
				new TweenMax(before_reflection, .5, {alpha:0});	
			}
			else
			{				
				new TweenMax(before_reflection, .5, {alpha:1});	
			}
		}

		public function dim() : void 
		{
			new TweenMax(holder, .5, {alpha:0});	
		}
	}
}
