package {
	import gs.TweenLite;
	import gs.easing.Quad;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class ThumbNav extends EventDispatcher {
		public static const THUMB_CLICKED : String = "THUMB_CLICKED";
		public var selectedGalleryVO : GalleryVO;
		private var thumbHolderMC : MovieClip;
		private var holderMC : MovieClip;
		private var thumbXOffset : Number = 5;
		private var galleryVOs : Array;
		private var amountOfThumbsToMove : Number;
		private var maximumNumOfThumbsToMove : int;
		private var shiftCompleteCallback : Function;
		private var holderOutlineMC : MovieClip;
		private var gradientsMC : MovieClip;
		private var previousBtnMC : ThumbNavBtn;
		private var nextBtnMC : ThumbNavBtn;
		private var stepRightBtnMC : ThumbNavBtn;
		private var stepLeftBtnMC : ThumbNavBtn;

		public function ThumbNav(view : MovieClip) {
			previousBtnMC = new ThumbNavBtn(MovieClip(view.getChildByName("previousBtnMC")));
			nextBtnMC = new ThumbNavBtn(MovieClip(view.getChildByName("nextBtnMC")));
			stepRightBtnMC = new ThumbNavBtn(MovieClip(view.getChildByName("stepRightBtnMC")));
			stepLeftBtnMC = new ThumbNavBtn(MovieClip(view.getChildByName("stepLeftBtnMC")));
			thumbHolderMC = MovieClip(view.getChildByName("thumbHolderMC"));
			holderMC = MovieClip(thumbHolderMC.getChildByName("holderMC"));
			holderOutlineMC = MovieClip(thumbHolderMC.getChildByName("holderOutlineMC"));
			gradientsMC = MovieClip(thumbHolderMC.getChildByName("gradientsMC"));

			gradientsMC.mouseChildren = false;
			gradientsMC.mouseEnabled = false;
			galleryVOs = [];
		}

		public function disable() : void {
			TweenLite.to(previousBtnMC.mc, .25, {autoAlpha:0});
			TweenLite.to(nextBtnMC.mc, .25, {autoAlpha:0});
			TweenLite.to(stepRightBtnMC.mc, .25, {autoAlpha:0});
			TweenLite.to(stepLeftBtnMC.mc, .25, {autoAlpha:0});
			TweenLite.to(thumbHolderMC, .25, {autoAlpha:0});
		}

		public function changeThumbs(galleryVOs : Array) : void {
			enable();
			TweenLite.to(holderMC, .25, {alpha:0, onComplete:removeThumbs, onCompleteParams:[galleryVOs]});
		}

		private function enable() : void {
			// TweenLite.to(previousBtnMC.mc, .25, {autoAlpha:1});
			// TweenLite.to(nextBtnMC.mc, .25, {autoAlpha:1});
			TweenLite.to(stepRightBtnMC.mc, .25, {autoAlpha:1});
			TweenLite.to(stepLeftBtnMC.mc, .25, {autoAlpha:1});
			TweenLite.to(thumbHolderMC, .25, {autoAlpha:1});
		}

		private function removeThumbs(galleryVOs : Array) : void {
			for each (var galleryVO : GalleryVO in this.galleryVOs) {
				holderMC.removeChild(galleryVO);
			}

			this.galleryVOs = galleryVOs;
			addThumbs();
		}

		private function addThumbs() : void {
			this.galleryVOs = galleryVOs;
			this.amountOfThumbsToMove = Math.floor(galleryVOs.length * .15);
			this.maximumNumOfThumbsToMove = Math.min(amountOfThumbsToMove, 7);
			this.maximumNumOfThumbsToMove = Math.max(amountOfThumbsToMove, 3);

			var thumbOffset : Number = 0;
			for each (var galleryVO : GalleryVO in galleryVOs) {
				galleryVO.x = thumbOffset;
				galleryVO.addEventListener(MouseEvent.CLICK, notifyThumbClickToView);
				holderMC.addChild(galleryVO);
				thumbOffset += galleryVO.width + thumbXOffset;
			}

			var centerThumbs : Number = (holderOutlineMC.width * .5) - (holderMC.width * .5);
			holderMC.x = centerThumbs;
			TweenLite.to(holderMC, .5, {alpha:1});

			enableNavigation();
		}

		private function enableNavigation() : void {
			if (holderOutlineMC.width > holderMC.width) {
				TweenLite.to(nextBtnMC.mc, .25, {autoAlpha:0});
				TweenLite.to(previousBtnMC.mc, .25, {autoAlpha:0});
			} else {
				TweenLite.to(nextBtnMC.mc, .5, {autoAlpha:1});
				TweenLite.to(previousBtnMC.mc, .5, {autoAlpha:1});
			}
			nextBtnMC.addEventListener(MouseEvent.CLICK, shiftRight);
			previousBtnMC.addEventListener(MouseEvent.CLICK, shiftLeft);

			stepRightBtnMC.addEventListener(MouseEvent.CLICK, stepRight);
			stepLeftBtnMC.addEventListener(MouseEvent.CLICK, stepLeft);
		}

		private function shiftRight(event : MouseEvent) : void {
			disableNavigation();
			var distanceToMove : Number = calculateWidthOfThumbsToMove(maximumNumOfThumbsToMove);

			repositionThumbsToTheRight(maximumNumOfThumbsToMove);
			TweenLite.to(holderMC, .5, {x:(distanceToMove * -1).toString(), ease:Quad.easeInOut, onComplete:enableNavigation});
		}

		private function shiftLeft(event : MouseEvent) : void {
			disableNavigation();
			var distanceToMove : Number = calculateWidthOfThumbsToMove(maximumNumOfThumbsToMove);

			repositionThumbsToTheLeft(maximumNumOfThumbsToMove);
			TweenLite.to(holderMC, .5, {x:distanceToMove.toString(), ease:Quad.easeInOut, onComplete:enableNavigation});
		}

		private function stepLeft(event : MouseEvent) : void {
			selectedGalleryVO.makeUnselected();

			var previousLink : LinkedListNode = LinkedListNode(selectedGalleryVO.previousLink);
			selectedGalleryVO = GalleryVO(previousLink.content);
			selectedGalleryVO.makeSelected();

			dispatchEvent(new Event(ThumbNav.THUMB_CLICKED));
		}

		private function stepRight(event : MouseEvent) : void {
			selectedGalleryVO.makeUnselected();
			var nextNodeLink : LinkedListNode = LinkedListNode(selectedGalleryVO.nextLink);
			selectedGalleryVO = GalleryVO(nextNodeLink.content);
			selectedGalleryVO.makeSelected();
			dispatchEvent(new Event(ThumbNav.THUMB_CLICKED));
		}

		private function disableNavigation() : void {
			nextBtnMC.removeEventListener(MouseEvent.CLICK, shiftRight);
			previousBtnMC.removeEventListener(MouseEvent.CLICK, shiftLeft);
		}

		private function repositionThumbsToTheLeft(maximumNumOfThumbsToMove : Number) : void {
			for (var i : int = 0;i < maximumNumOfThumbsToMove;i++) {
				var galleryVOAtTheEnd : GalleryVO = GalleryVO(galleryVOs.pop());
				galleryVOAtTheEnd.x = GalleryVO(galleryVOs[0]).x - (galleryVOAtTheEnd.width + thumbXOffset);
				galleryVOs.unshift(galleryVOAtTheEnd);
			}
		}

		private function repositionThumbsToTheRight(maximumNumOfThumbsToMove : Number) : void {
			for (var i : int = 0;i < maximumNumOfThumbsToMove;i++) {
				var galleryVOAtTheBegining : GalleryVO = GalleryVO(galleryVOs.shift());
				galleryVOAtTheBegining.x = GalleryVO(galleryVOs[galleryVOs.length - 1]).x + (GalleryVO(galleryVOs[galleryVOs.length - 1]).width + thumbXOffset);
				galleryVOs.push(galleryVOAtTheBegining);
			}
		}

		private function calculateWidthOfThumbsToMove(maximumNumOfThumbsToMove : Number) : Number {
			var distance : Number = 0;
			for (var i : int = 0;i < maximumNumOfThumbsToMove;i++) {
				distance += GalleryVO(galleryVOs[i]).width + thumbXOffset;
			}
			return distance;
		}

		private function notifyThumbClickToView(event : MouseEvent) : void {
			selectedGalleryVO.makeUnselected();
			this.selectedGalleryVO = GalleryVO(event.currentTarget);
			selectedGalleryVO.makeSelected();

			dispatchEvent(new Event(ThumbNav.THUMB_CLICKED));
		}
	}
}
