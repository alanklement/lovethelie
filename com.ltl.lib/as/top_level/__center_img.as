package top_level
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * @author Alan
	 */
	public function __center_img(img : Bitmap, img_holder : Sprite) : void 
	{
		img.x = -img.width * .5;
		img.y = -img.height * .5;
	}
}
