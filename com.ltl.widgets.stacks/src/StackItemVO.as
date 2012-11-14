package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class StackItemVO 
	{
		public var thumbImage : Sprite;
		public var largeImgURL : String;

		public function StackItemVO(thumbImage:Bitmap,largeImgURL:String)
		{
			this.thumbImage = new Sprite();
			this.thumbImage.addChild(thumbImage);
			this.largeImgURL = largeImgURL;
		}
	}
}
