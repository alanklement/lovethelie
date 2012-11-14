package  
{
	import flash.display.Sprite;

	public class StackVO 
	{
		public var previewImg : Sprite;
		public var stackActiveImg : Sprite;
		public var stackItemVOs : Array = [];
		
		public function StackVO(previewImg:Sprite,stackActiveImg:Sprite)
		{
			this.previewImg = previewImg;
			this.stackActiveImg = stackActiveImg;
		}
	}
}
