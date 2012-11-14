package  
{
	import flash.display.MovieClip;

	public class DesignerVO implements LinkedListNode
	{
		public var profileImage : MovieClip;
		public var shoeImage : MovieClip;
		public var occupation : String;
		public var name : String;
		public var profileLinkOnZazzle : String;
		private var _nextLink : LinkedListNode;
		private var _previousLink : LinkedListNode;

		public function DesignerVO(profileImage : MovieClip, shoeImage : MovieClip,name : String, occupation : String, profileLinkOnZazzle : String)
		{
			this.profileImage = profileImage;
			this.shoeImage = shoeImage;
			this.name = name;
			this.occupation = occupation;
			this.profileLinkOnZazzle = profileLinkOnZazzle + "?&rf=238622604218983425";
		}

		public function get nextLink() : LinkedListNode
		{
			return _nextLink;
		}

		public function get previousLink() : LinkedListNode
		{
			return _previousLink;
		}

		public function get payload() : *
		{
			return this;
		}

		public function set nextLink(node : LinkedListNode) : void
		{
			_nextLink = node;			
		}

		public function set previousLink(node : LinkedListNode) : void
		{
			_previousLink = node;
		}
	}
}
