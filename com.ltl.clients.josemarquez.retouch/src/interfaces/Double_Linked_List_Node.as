package interfaces
{

	public interface Double_Linked_List_Node
	{
		function set next_link(node : Double_Linked_List_Node) : void;

		function get next_link() : Double_Linked_List_Node;

		function set previous_link(node : Double_Linked_List_Node) : void;

		function get previous_link() : Double_Linked_List_Node;

		function get payload() : *;
	}
}
