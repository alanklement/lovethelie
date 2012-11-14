package vos 
{
	import flash.display.Bitmap;

	/**
	 * @author Alan
	 */
	public class Image_VO 
	{
		public var before_img_url : String;
		public var after_img_url : String;
		public var thumb_img_url : String;
		public var thumb_img : Bitmap;
		public var info_img : String;
		public var no_info : Boolean;

		public function dispose() : void 
		{
			before_img_url = null;
			after_img_url = null;
			thumb_img_url = null;
			thumb_img = null;
			info_img = null;
		}
	}
}
