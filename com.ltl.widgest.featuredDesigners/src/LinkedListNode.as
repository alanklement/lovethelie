package  
{

	public interface LinkedListNode
	{
		function set nextLink(node:LinkedListNode) : void;

		function get nextLink() : LinkedListNode;

		function set previousLink(node:LinkedListNode) : void;

		function get previousLink() : LinkedListNode;

		function get payload() : *;
	}
}
