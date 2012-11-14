package {
	import com.greensock.TweenLite;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class GalleryVO extends Sprite implements LinkedListNode {
		public var thumbSource : String;
		public var thumbId : String;
		public var source : String;
		public var id : String;
		public var btn : Sprite;
		private var _thumbImage : Bitmap;
		private var _nextLink : LinkedListNode;
		private var _previousLink : LinkedListNode;
		private var isSelected : Boolean;

		public function GalleryVO(id : String, source : String, thumbId : String, thumbSource : String) {
			this.id = id;
			this.source = source;
			this.thumbId = thumbId;
			this.thumbSource = thumbSource;
			this.buttonMode = true;
		}

		public function set thumbImage(thumbImage : Bitmap) : void {
			_thumbImage = thumbImage;
			_thumbImage.alpha = .5;
			addChild(_thumbImage);
			addEventListeners();
		}

		private function addEventListeners() : void {
			this.addEventListener(MouseEvent.ROLL_OVER, fadeIn);
			this.addEventListener(MouseEvent.ROLL_OUT, fadeOut);
		}

		private function fadeIn(event : MouseEvent) : void {
			TweenLite.to(_thumbImage, .15, {alpha:1});
		}

		private function fadeOut(event : MouseEvent) : void {
			if (isSelected) {
				return;
			} else {
				TweenLite.to(_thumbImage, .15, {alpha:.5});
			}
		}

		public function makeSelected(event : MouseEvent = null) : void {
			isSelected = true;
			TweenLite.to(_thumbImage, .15, {alpha:1});
		}

		public function makeUnselected(event : MouseEvent = null) : void {
			isSelected = false;
			TweenLite.to(_thumbImage, .15, {alpha:.5});
		}

		public function get thumbImage() : Bitmap {
			return _thumbImage;
		}

		public function get nextLink() : LinkedListNode {
			return _nextLink;
		}

		public function get previousLink() : LinkedListNode {
			return _previousLink;
		}

		public function get content() : * {
			return this;
		}

		public function set nextLink(node : LinkedListNode) : void {
			this._nextLink = node;
		}

		public function set previousLink(node : LinkedListNode) : void {
			this._previousLink = node;
		}
	}
}
