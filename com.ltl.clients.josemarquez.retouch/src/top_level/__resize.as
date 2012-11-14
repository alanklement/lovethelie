package top_level
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * @author Alan
	 */
	public function __resize(img : Bitmap,target_holder : Sprite) : void 
	{
		trace(this, ' :: ', ' @ __resize ', ' target_holder.height: ' + (target_holder.height));
		if(img.height > target_holder.height)
		{
			var ratio : Number = Math.min(target_holder.width / img.width, target_holder.height / img.height);

			img.smoothing = true;
			img.width = ratio * img.width;
			img.height = ratio * img.height;
		}
	}
}
