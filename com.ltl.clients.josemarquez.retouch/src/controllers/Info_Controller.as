package controllers 
{
	import com.greensock.TweenMax;

	import top_level.__center_img;
	import top_level.__resize;

	import flash.display.Bitmap;
	import flash.display.MovieClip;

	/**
	 * @author Alan
	 */
	public class Info_Controller 
	{
		private var holder : MovieClip;
		private var new_bm : Bitmap;

		public function Info_Controller(holder : MovieClip) 
		{
			this.holder = holder;
			holder.alpha = 0;
		}

		public function show_info(bm : Bitmap) : void 
		{	
			__resize(bm, holder);
			__center_img(bm, holder);
			
			if(holder.numChildren > 1)
			{
				new TweenMax(holder, .5, {alpha:0, onComplete:clean, onCompleteParams:[bm]});
			}
			else
			{
				fade_in(bm);
			}
		}

		private function fade_in(bm : Bitmap) : void 
		{
			holder.addChild(bm);
			new TweenMax(holder, .5, {alpha:1});
		}

		private function clean(bm : Bitmap = null) : void 
		{	
			clean_display();
			fade_in(bm);
		}

		public function hide() : void 
		{
			new TweenMax(holder, .5, {alpha:0, onComplete:clean_display});
		}

		private function clean_display() : void 
		{
			while(holder.numChildren > 1)
			{
				holder.removeChildAt(holder.numChildren - 1);
			}
		}
	}
}
