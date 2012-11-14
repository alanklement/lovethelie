package  
{

	public class DesignerManager 
	{
		public var 	currentDesigner : LinkedListNode;
		public var nextDesigner : LinkedListNode;
		public var designers : Array;
		private var designerFifteen : DesignerVO;
		private var designerSixteen : DesignerVO;
		private var designerSeventeen : DesignerVO;
		private var designerEighteen : DesignerVO;
		private var designerNineteen : DesignerVO;
		private var designerTwenty : DesignerVO;

		public function DesignerManager()
		{
			createDesigners();
			setFirstDesigner();
			add_designers_to_array();
			createDesignerLinkedList();
		}

		private function createDesigners() : void
		{
//			designerOne = new DesignerVO(new DesignerOne(), new ShoeOne(), "Jeriana San Juan", "Stylist", "http://www.zazzle.com/thenewblack");
//			designerTwo = new DesignerVO(new DesignerTwo(), new ShoeTwo(), "Carly Margolis", "Jewelry Designer", "http://www.zazzle.com/carlymargolis");
//			designerThree = new DesignerVO(new DesignerThree(), new ShoeThree(), "Lana Del Rey", "Singer", "http://www.zazzle.com/lanadelrey");
//			designerFour = new DesignerVO(new DesignerFour(), new ShoeFour(), "Matt Locher", "Musician", "http://www.zazzle.com/solidgold");
//			designerFive = new DesignerVO(new DesignerFive(), new ShoeFive(), "Ben Warwas", "Designer", "http://www.zazzle.com/bwarwas");
//			designerSix = new DesignerVO(new DesignerSix(), new ShoeSix(), "Yuko Inagaki", "Graphic Designer", "http://www.zazzle.com/yukissimo");
//			designerSeven = new DesignerVO(new DesignerSeven(), new ShoeSeven(), "Chris Bonenfant", "Designer", "http://www.zazzle.com/c_bonenfant");
//			designerEight = new DesignerVO(new DesignerEight(), new ShoeEight(), "Ann Armstrong", "Steel Fabricator", "http://www.zazzle.com/annabun");
			
//			designerNine = new DesignerVO(new DesignerNine(), new ShoeNine(), "Mark McDevitt \n& Robert Lee", "Graphic Designers", "http://www.zazzle.com/methane");
//			designerTen = new DesignerVO(new DesignerTen(), new ShoeTen(), "Tate Steinsiek", "Special Effects Artist", "http://www.zazzle.com/illwilled");
//			designerEleven = new DesignerVO(new DesignerEleven(), new ShoeEleven(), "Yellena James", "Illustrator", "http://www.zazzle.com/yellena");
//			designerTwelve = new DesignerVO(new DesignerTwelve(), new ShoeTwelve(), "Christopher Bettig", "Designer", "http://www.zazzle.com/christopherbettig");
//			designerThirteen = new DesignerVO(new DesignerThirteen(), new ShoeThirteen(), "Jake Holloman", "Graphic Designer/Illustrator", "http://www.zazzle.com/micronhero");
//			designerFourteen = new DesignerVO(new DesignerFourteen(), new ShoeFourteen(), "Lamonte", "Breakdancer", "http://www.zazzle.com/tales112");

			designerFifteen = new DesignerVO(new DesignerFifteen(), new ShoeFifteen(), "Ann Armstrong", "Steel Fabricator/Welder", "http://www.zazzle.com/annabun");
			designerSixteen = new DesignerVO(new DesignerSixteen(), new ShoeSixteen(), "Butcher Bear & Charlie", "Singer/DJ", "http://www.zazzle.com/charliebearcharlie");
			designerSeventeen = new DesignerVO(new DesignerSeventeen(), new ShoeSeventeen(), "Carly Margolis", "Jewelry Designer", "http://www.zazzle.com/carlymargolis");
			designerEighteen = new DesignerVO(new DesignerEighteen(), new ShoeEighteen(), "Emili Adame", "Jewelry Designer", "http://www.zazzle.com/mariposalola");
			designerNineteen = new DesignerVO(new DesignerNineteen(), new ShoeNineteen(), "Jesse Hoy", "Musician", "http://www.zazzle.com/thedeadlysyndrome");
			designerTwenty = new DesignerVO(new DesignerTwenty(), new ShoeTwenty(), "Allison Cole", "Illustrator", "http://www.zazzle.com/allisonillustration");
		}

		private function add_designers_to_array() : void
		{
			designers = [designerFifteen,designerSixteen,designerSeventeen,designerEighteen,designerNineteen,designerTwenty];
		}

		private function setFirstDesigner() : void
		{
			currentDesigner = designerFifteen;
		}

		private function createDesignerLinkedList() : void
		{
			LinkedListNode(designers[0]).previousLink = LinkedListNode(designers[designers.length - 1]);
			LinkedListNode(designers[0]).nextLink = LinkedListNode(designers[1]);
			
			for (var i : int = 1;i < designers.length - 1;i++) 
			{				
				LinkedListNode(designers[i]).previousLink = LinkedListNode(designers[i - 1]);
				LinkedListNode(designers[i]).nextLink = LinkedListNode(designers[i + 1]);
			} 

			LinkedListNode(designers[designers.length - 1]).previousLink = LinkedListNode(designers[designers.length - 2]);
			LinkedListNode(designers[designers.length - 1]).nextLink = LinkedListNode(designers[0]);
		}

		public function makeNextDesignerIntoCurrentDesigner() : void
		{
			currentDesigner = nextDesigner;	
		}

		public function shiftDesignerToPreviousLink() : void
		{
			nextDesigner = currentDesigner.previousLink;
		}

		public function shiftDesignerToNextLink() : void
		{
			nextDesigner = currentDesigner.nextLink;
		}
	}
}
