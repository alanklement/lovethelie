package  
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;

	import com.greensock.TweenLite;

	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;

	import flash.display.Sprite;

	public class Main extends Sprite 
	{
		private var view : ViewFacade;
		private var visitProfileBtn : KedsButton;
		private var seeAllDesignersBtn : KedsButton;
		private var navShoeLeft : KedsButton;
		private var navShoeRight : KedsButton;
		private var designerImageHolder : MovieClip;
		private var designerOccupation : TextField;
		private var designerName : TextField;
		private var designerImageWidth : Number;
		private var designerShoeWidth : Number;
		private var shoeHolder : MovieClip;
		private var designerManager : DesignerManager;
		private var allDesignersURL : String = "http://www.kedscollective.com/designers/";
		private var currentDesignerProfilePageURL : String = "";

		public function Main()
		{
			activateTweenPlugins();
			addArtwork();
			createReferencesToDisplayObjects();
			createButtons();
			addButtonEventListeners();
			createDesingers();
			getImageWidths();
			addFirstDesigner();
		}

		private function activateTweenPlugins() : void
		{
			TweenPlugin.activate([TintPlugin]);
		}

		private function addArtwork() : void
		{
			view = new ViewFacade();
			addChild(view);
		}

		private function createReferencesToDisplayObjects() : void
		{
			shoeHolder = MovieClip(view.shoeContainerMC.getChildByName("shoeHolderMC"));
			designerImageHolder = MovieClip(view.designerImageHolderMC);
			designerName = TextField(view.designerNameTF);
			designerOccupation = TextField(view.designerOccupationTF);	
		}

		private function createButtons() : void
		{
			visitProfileBtn = new KedsButton(view.viewProfileBtnMC);
			seeAllDesignersBtn = new KedsButton(view.seeAllDesignersBtnMC);
			navShoeLeft = new KedsButton(view.navLetMC);
			navShoeRight = new KedsButton(view.navRightMC);
		}

		private function addButtonEventListeners() : void
		{
			navShoeLeft.mc.addEventListener(MouseEvent.CLICK, shiftDesginersToRight);
			navShoeRight.mc.addEventListener(MouseEvent.CLICK, shiftDesginersToLeft);
			visitProfileBtn.mc.addEventListener(MouseEvent.CLICK, bavigateToDesignersProfilePage);
			seeAllDesignersBtn.mc.addEventListener(MouseEvent.CLICK, navigateToAllDesignersPage);
		}

		private function shiftDesginersToLeft(event : MouseEvent) : void
		{
			disableNav();
			designerManager.shiftDesignerToNextLink();
			updateText(designerManager.nextDesigner);									
			updateButtonLinks(designerManager.nextDesigner);												

			shiftOldDesigner(-designerShoeWidth, -designerImageWidth);	
			addAndShiftNextDesigner(designerShoeWidth, designerImageWidth);			
		}		

		private function shiftDesginersToRight(event : MouseEvent) : void
		{
			disableNav();
			designerManager.shiftDesignerToPreviousLink();
			updateText(designerManager.nextDesigner);
			updateButtonLinks(designerManager.nextDesigner);												
												
			shiftOldDesigner(designerShoeWidth, designerImageWidth);
			addAndShiftNextDesigner(-designerShoeWidth, -designerImageWidth);			
		}

		private function navigateToAllDesignersPage(event : MouseEvent) : void
		{
			navigateToURL(new URLRequest(allDesignersURL), "_blank");
		}

		private function bavigateToDesignersProfilePage(event : MouseEvent) : void
		{
			trace(this, '@bavigateToDesignersProfilePage', 'currentDesignerProfilePageURL: ' + (currentDesignerProfilePageURL));
			navigateToURL(new URLRequest(currentDesignerProfilePageURL), "_blank");
		}

		private function disableNav() : void
		{
			navShoeLeft.mc.removeEventListener(MouseEvent.CLICK, shiftDesginersToRight);
			navShoeRight.mc.removeEventListener(MouseEvent.CLICK, shiftDesginersToLeft);
		}

		private function updateText(designer : LinkedListNode) : void
		{
			var designer_name : String = DesignerVO(designer.payload).name.toUpperCase();
			
			adjust_textfield_if_name_is_long(designer_name);
			
			designerName.text = designer_name;
			designerOccupation.text = DesignerVO(designer.payload).occupation;						
		}

		private function adjust_textfield_if_name_is_long(designer_name : String) : void
		{
			if(designer_name.length <= 18)
			{
				designerName.y = 255;						
			}
			else
			{				
				designerName.y = 247;						
			}
		}

		private function updateButtonLinks(nextDesigner : LinkedListNode) : void
		{
			currentDesignerProfilePageURL = DesignerVO(nextDesigner.payload).profileLinkOnZazzle;
		}

		private function shiftOldDesigner(endingShoeXPos : Number,endinImageXPos : Number) : void
		{
			var oldDesignerImage : MovieClip = DesignerVO(designerManager.currentDesigner.payload).profileImage;
			TweenLite.to(oldDesignerImage, .3, {x:endinImageXPos, onComplete:removeOldDesigner, onCompleteParams:[designerManager.currentDesigner.payload], alpha:0});

			var oldDesignerShoe : MovieClip = DesignerVO(designerManager.currentDesigner.payload).shoeImage;
			TweenLite.to(oldDesignerShoe, .3, {x:endingShoeXPos, alpha:0});
		}

		private function removeOldDesigner(oldDesigner : DesignerVO) : void
		{
			designerImageHolder.removeChild(oldDesigner.profileImage);
			shoeHolder.removeChild(oldDesigner.shoeImage);
			designerManager.makeNextDesignerIntoCurrentDesigner();
			
			addButtonEventListeners();
		}

		private function addAndShiftNextDesigner(startingShoeXPosition : Number, startingImageXPosition : Number) : void
		{
			var shoe : MovieClip = DesignerVO(designerManager.nextDesigner.payload).shoeImage;
			shoe.x = startingShoeXPosition;
			shoe.alpha = 0;
			shoeHolder.addChild(shoe);
			TweenLite.to(shoe, .3, {x:0, alpha:1});

			var image : MovieClip = DesignerVO(designerManager.nextDesigner.payload).profileImage;
			image.x = startingImageXPosition;
			image.alpha = 0;
			designerImageHolder.addChild(image);
			TweenLite.to(image, .3, {x:0, alpha:1});	
		}

		private function createDesingers() : void
		{
			designerManager = new DesignerManager();
		}

		private function getImageWidths() : void
		{
			var first_designer : DesignerVO = designerManager.designers[0];
			designerImageWidth = first_designer.profileImage.width + 15;
			designerShoeWidth = first_designer.shoeImage.width + 15;
		}

		private function addFirstDesigner() : void
		{
			designerImageHolder.addChild(DesignerVO(designerManager.currentDesigner.payload).profileImage);
			shoeHolder.addChild(DesignerVO(designerManager.currentDesigner.payload).shoeImage);
			updateText(designerManager.currentDesigner);
			updateButtonLinks(designerManager.currentDesigner);
		}
	}
}