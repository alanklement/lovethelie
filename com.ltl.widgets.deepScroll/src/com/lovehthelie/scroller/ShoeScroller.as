package com.lovehthelie.scroller 
{
	import gs.TweenGroup;
	import gs.TweenLite;
	import gs.easing.Expo;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class ShoeScroller extends Sprite 
	{
		public static const UPDATE_SHOE_DESCIPTION : String = "UPDATE_SHOE_DESCIPTION";
		public static const SHOE_CLICKED : String = "SHOE_CLICKED";

		public var clickedShoeURL : String;
		public var shoeDescripton : String;

		private var shoes : Array;
		private var focalLength : Number = 50;
		private var zTotalDepth : int = 500;
		private var fadeInGroup : TweenGroup;
		private var shoeShiftTimer : Timer;
		private var shoePositions : Array = [];
		private var shiftTweenGroup : TweenGroup;
		private var shoeTrainStartY : int = 25;
		private var shoeTrainStartX : int = 350;
		private var multiplier : Number = .25;

		public function ShoeScroller(shoeVOs : Array)
		{
			this.shoes = shoeVOs;
			addShoesToDiplayList();
			this.shoeDescripton = InteractiveShoe(shoeVOs[shoeVOs.length - 1]).shoeDescription;
		}

		private function addShoesToDiplayList() : void
		{
			var amountToOffSetZ : Number = zTotalDepth / shoes.length;			
			
			var shoeOffsetX : int = shoeTrainStartX;
			var shoeOffsetY : int = shoeTrainStartY;
									
			for (var i : int = 0;i < shoes.length;i++) 
			{
				zTotalDepth -= amountToOffSetZ;
				var scale : Number = Math.min((focalLength / (focalLength + zTotalDepth)),1);
				
				var shoe : InteractiveShoe = shoes[i];				
				shoe.scaleX = shoe.scaleY = scale;
				shoe.y = shoeOffsetY; 
				shoe.x = shoeOffsetX;
				shoe.alpha = 0;
				
				addChild(shoe);
				
				shoePositions[i] = {x:shoe.x, y:shoe.y, scaleX:scale, scaleY:scale, alpha:1};				
				
				shoeOffsetX -= shoe.width * multiplier;
				shoeOffsetY += shoe.height * .08;
			}
			
			prepareAnimateInTweens();
		}

		private function prepareAnimateInTweens() : void
		{
			fadeInGroup = new TweenGroup();
			fadeInGroup.align = TweenGroup.ALIGN_START;
			fadeInGroup.stagger = .05;
			
			for (var i : int = 0;i < shoes.length;i++) 
			{
				fadeInGroup.push(TweenLite.to(shoes[i], .75, {alpha:1, ease:Expo.easeOut}));
			}
			
			fadeInGroup.pause();
		}

		public function fadeInShoesAndStartScrolller() : void
		{
			fadeInGroup.resume();
			fadeInGroup.onComplete = createShoeShiftTimer;
			
			dispatchEvent(new Event(ShoeScroller.UPDATE_SHOE_DESCIPTION));
			this.shoeDescripton = InteractiveShoe(shoes[shoes.length - 1]).shoeDescription;
		}

		private function createShoeShiftTimer() : void
		{
			shoeShiftTimer = new Timer(1000);
			shoeShiftTimer.addEventListener(TimerEvent.TIMER, shiftShoes);
			shoeShiftTimer.start();
		}		

		private function shiftShoes(event : TimerEvent) : void
		{
			shiftTweenGroup = new TweenGroup();
			shiftTweenGroup.pause();
			// add foremost shoe tween
			shiftTweenGroup.push(TweenLite.to(shoes[shoes.length - 1], .15, {alpha:0}));

			for (var i : int = 0;i < shoes.length - 1;i++) 
			{
				shiftTweenGroup.push(TweenLite.to(shoes[i], .25, Object(shoePositions[i + 1])));
			}
	
			shiftTweenGroup.onComplete = reShuffeArray;				
			shiftTweenGroup.resume();
		}

		private function reShuffeArray() : void
		{
			var foremostShoe : InteractiveShoe = shoes.pop();
			shoes.unshift(foremostShoe);
			
			tellViewToUpdateShoeDescription();
		}

		private function tellViewToUpdateShoeDescription() : void
		{
			dispatchEvent(new Event(ShoeScroller.UPDATE_SHOE_DESCIPTION));
			this.shoeDescripton = InteractiveShoe(shoes[shoes.length - 1]).shoeDescription;
			
			putBackShoeAtBottomOfDisplayList();
		}

		private function putBackShoeAtBottomOfDisplayList() : void
		{
			removeChild(shoes[0]);
			addChildAt(shoes[0], 0);
			InteractiveShoe(shoes[0]).x = shoePositions[0].x;
			InteractiveShoe(shoes[0]).y = shoePositions[0].y;
			InteractiveShoe(shoes[0]).scaleX = shoePositions[0].scaleX;
			InteractiveShoe(shoes[0]).scaleY = shoePositions[0].scaleY;
			InteractiveShoe(shoes[0]).alpha = 0;
//			tweenBackShoeFromOffScreen();
		}
	}
}
