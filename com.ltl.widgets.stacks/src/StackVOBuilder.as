package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class StackVOBuilder 
	{
		private var stackXML : XML;
		private var stackDataReadyCallback : Function;
		private var stackImgPath : String;
		private var simpleBulkLoader : SimpleBulkLoader;
		private var largeImgURLKeys : Array = [];
		private var stackVO : StackVO;

		public function StackVOBuilder(stackData : XML, stackImgPath : String, stackDataReadyCallback : Function)
		{
			this.stackXML = stackData;
			this.stackDataReadyCallback = stackDataReadyCallback;
			this.stackImgPath = stackImgPath;
			
			addPreviewURLToLoader();	
		}

		private function addPreviewURLToLoader() : void
		{
			simpleBulkLoader = new SimpleBulkLoader();
		
			var previewImageURL : String = stackImgPath + stackXML.preview;
			simpleBulkLoader.addItem(previewImageURL, 'preview');
			
			addActiveImageURLToLoader();
		}

		// active image is what is the preview image turns into when stack is activated
		private function addActiveImageURLToLoader() : void
		{			
			var activeImageURL : String = stackImgPath + stackXML.stackActive;
			simpleBulkLoader.addItem(activeImageURL, 'stackActive');
			
			addStackItemsURLsToLoader();
		}

		private function addStackItemsURLsToLoader() : void
		{
			var loaderID : int = 0;
			for (var i : int = 0;i < stackXML.stack.length();i++) 
			{	
				var thumbURL : String = stackImgPath + stackXML.stack[i].thumb;		
				simpleBulkLoader.addItem(thumbURL, loaderID);
			
				var largeImgURL : String = String(stackXML.stack[i].source);
				largeImgURLKeys.push(largeImgURL);
				loaderID++;	
			}
			
			startThumbImagesLoad();			
		}

		private function startThumbImagesLoad() : void
		{
			simpleBulkLoader.loadAllItems(buildStackVO);
		}

		private function buildStackVO() : void
		{
			var previewImg : Sprite = new Sprite();
			var stackActiveImg : Sprite = new Sprite();
		
			previewImg.addChild(simpleBulkLoader.getBitmap('preview'));
			stackActiveImg.addChild(simpleBulkLoader.getBitmap("stackActive"));
			
			stackVO = new StackVO(previewImg, stackActiveImg);
			
			buildStackItemVOs();
		}

		private function buildStackItemVOs() : void
		{
			for (var i : int = 0;i < largeImgURLKeys.length;i++) 
			{
				var stackItemThumbBitmap : Bitmap = simpleBulkLoader.getBitmap(i);
				var stackItemVO : StackItemVO = new StackItemVO(stackItemThumbBitmap, String(largeImgURLKeys[i]));
				stackVO.stackItemVOs.push(stackItemVO);
			}
			
			passStackVOToClient();			
		}

		private function passStackVOToClient() : void
		{
			stackDataReadyCallback(stackVO);
		}

		public function dispose() : void
		{
			simpleBulkLoader.dispose();
			
			stackXML = null;
			stackDataReadyCallback = null;
			stackImgPath = null;
			simpleBulkLoader = null;
			largeImgURLKeys = null;
			stackVO = null;
		}
	}
}
