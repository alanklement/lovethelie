package controllers 
{
	import interactive.Glowing_Btn;

	import org.osflash.signals.Signal;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author Alan
	 */
	public class Top_Nav 
	{
		public var fashion_nav_clicked : Signal = new Signal();
		public var objects_nav_clicked : Signal = new Signal();
		public var contacts_nav_selected : Signal = new Signal();
		private var fashion_btn : Glowing_Btn;
		private var objects_btn : Glowing_Btn;
		private var contacts_btn : Glowing_Btn;
		private var btns : Array;

		public function Top_Nav(fashion_nav : MovieClip, objects_nav : MovieClip, contacts_nav : MovieClip) 
		{
			fashion_btn = new Glowing_Btn(fashion_nav);
			objects_btn = new Glowing_Btn(objects_nav);
			contacts_btn = new Glowing_Btn(contacts_nav);
			
			btns = [fashion_btn,objects_btn,contacts_btn];
			
			add_listeners();
		}

		private function add_listeners() : void 
		{
			fashion_btn.notify_clicked.add(fashion_clicked);
			objects_btn.notify_clicked.add(objects_clicked);
			contacts_btn.notify_clicked.add(contacts_clicked);
		}

		private function fashion_clicked(event : MouseEvent) : void 
		{
			turn_of_other_buttons(fashion_btn);
			fashion_nav_clicked.dispatch();
		}

		private function turn_of_other_buttons(selected_btn : Glowing_Btn) : void 
		{
			for each (var item : Glowing_Btn in btns) 
			{
				if(item != selected_btn)
				{
					item.set_to_unselected();
				}
				else
				{
					item.set_to_selected();
				}
			}
		}

		private function objects_clicked(event : MouseEvent) : void 
		{
			turn_of_other_buttons(objects_btn);

			objects_nav_clicked.dispatch();		
		}

		private function contacts_clicked(event : MouseEvent) : void 
		{
			turn_of_other_buttons(contacts_btn);
			
			contacts_nav_selected.dispatch();
		}

		public function start() : void 
		{
			turn_of_other_buttons(fashion_btn);
		}
	}
}
