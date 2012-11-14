package top_level
{
	import interfaces.Double_Linked_List_Node;
	public function __add_linked_list_behaviour_array(target_array : Array) : Array 
	{
		for (var i : int = 1;i < target_array.length - 1;i++) 
		{
			var inner_node : Double_Linked_List_Node = Double_Linked_List_Node(target_array[i]);
			inner_node.previous_link = Double_Linked_List_Node(target_array[i - 1]);
			inner_node.next_link = Double_Linked_List_Node(target_array[i + 1]); 	
		}
			
		var first_node : Double_Linked_List_Node = Double_Linked_List_Node(target_array[0]);
		var last_node : Double_Linked_List_Node = Double_Linked_List_Node(target_array[target_array.length - 1]);

		first_node.previous_link = last_node;
		first_node.next_link = target_array[1];

		last_node.previous_link = target_array[target_array.length - 2];
		last_node.next_link = first_node;

		return target_array;
	}
}
