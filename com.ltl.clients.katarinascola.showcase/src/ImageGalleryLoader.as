package {
	import flash.display.Bitmap;

	public class ImageGalleryLoader {
		private var xmlLoader : XMLLoader;
		private var notifyControllerThumbsReady : Function;
		private var simpleBulkLoader : SimpleBulkLoader;
		private var image_url_prefix : String;
		private var galleryVOs : Array;
		private var thumb_Img_Dir : String;

		public function loadGallery(image_url_prefix : String, thumbImgDir : String, fashionXml : String, notifyControllerImagesReady : Function) : void {
			var date : Date = new Date();
			this.image_url_prefix = image_url_prefix;
			this.thumb_Img_Dir = thumbImgDir;
			this.notifyControllerThumbsReady = notifyControllerImagesReady;
			xmlLoader = new XMLLoader(fashionXml + "?cachebust=" + date.getTime(), createGalleryVOs);
		}

		private function createGalleryVOs(xml : XML) : void {
			galleryVOs = [];

			for each (var image : XML in xml.child("image")) {
				var id : String = String(image.attribute("id"));
				var source : String = String(image_url_prefix + image.attribute("source"));
				var thumbId : String = String(image.attribute("thumbId"));
				var thumbSource : String = String(thumb_Img_Dir + image.attribute("thumbSource"));

				var galleryVO : GalleryVO = new GalleryVO(id, source, thumbId, thumbSource);
				galleryVOs.push(galleryVO);
			}

			bulkloadThumbs(addLinkedListBehaviourToArray(galleryVOs));
		}

		private function addLinkedListBehaviourToArray(linkedListNodes : Array) : Array {
			for (var i : int = 1;i < linkedListNodes.length - 1;i++) {
				var innerColumn : LinkedListNode = LinkedListNode(linkedListNodes[i]);
				innerColumn.previousLink = LinkedListNode(linkedListNodes[i - 1]);
				innerColumn.nextLink = LinkedListNode(linkedListNodes[i + 1]);
			}

			var firstColumn : LinkedListNode = LinkedListNode(linkedListNodes[0]);
			var lastColumn : LinkedListNode = LinkedListNode(linkedListNodes[linkedListNodes.length - 1]);

			firstColumn.previousLink = lastColumn;
			firstColumn.nextLink = linkedListNodes[1];

			lastColumn.previousLink = linkedListNodes[linkedListNodes.length - 2];
			lastColumn.nextLink = firstColumn;

			return linkedListNodes;
		}

		private function bulkloadThumbs(galleryVOs : Array) : void {
			simpleBulkLoader = new SimpleBulkLoader();

			for (var i : int = 0;i < galleryVOs.length;i++) {
				var galleryVO : GalleryVO = GalleryVO(galleryVOs[i]);
				simpleBulkLoader.addItem(galleryVO.thumbSource, galleryVO.thumbSource);
			}

			simpleBulkLoader.loadAllItems(allThumbsLoadedCallback);
		}

		private function allThumbsLoadedCallback() : void {
			for (var i : int = 0;i < galleryVOs.length;i++) {
				var galleryVO : GalleryVO = GalleryVO(galleryVOs[i]);
				galleryVO.thumbImage = Bitmap(simpleBulkLoader.getBitmap(galleryVO.thumbSource));
			}

			notifyControllerThumbsReady(galleryVOs);

			disposeObjects();
		}

		private function disposeObjects() : void {
			xmlLoader.dispose();
			simpleBulkLoader.dispose();
		}
	}
}
