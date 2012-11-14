package core
{

	public interface IDouble_Linked_List_Node 
	{
		function set next_link(node : IDouble_Linked_List_Node) : void;

		function get next_link() : IDouble_Linked_List_Node;

		function set previous_link(node : IDouble_Linked_List_Node) : void;

		function get previous_link() : IDouble_Linked_List_Node;

		function get payload() : *;
	}
}
