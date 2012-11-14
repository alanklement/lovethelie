package models 
{
	import builders.Interactive_Thumb_Builder;
	import builders.VO_Builder;

	import controllers.Network_Controller;

	import org.osflash.signals.Signal;

	/**
	 * @author Alan
	 */
	public class Data_Model 
	{
		public var notify_vos_ready : Signal = new Signal();
		public var network : Network_Controller;
		public var current_thumb_pages : Array;
		public var fashion_thumb_pages : Array;
		public var object_thumb_pages : Array;
		public var fashion_vos : Array;
		public var objects_vos : Array;
		public var flash_vars : Flash_Var_Model;

		public function load_vos() : void 
		{
			network.all_xml_loaded.addOnce(create_vos);
			network.load_xml_files();
		}

		private function create_vos(fashion_xml : XML,objects_xml : XML) : void 
		{
			fashion_vos = VO_Builder.build_vos(fashion_xml,flash_vars.fashion_dir);
			objects_vos = VO_Builder.build_vos(objects_xml,flash_vars.objects_dir);
			
			load_fashion_thumbs();
		}

		private function load_fashion_thumbs() : void 
		{
			network.notify_thumbs_loaded.addOnce(on_fashion_thumbs_loaded);
			network.load_thumbs(fashion_vos);
		}

		private function on_fashion_thumbs_loaded(thumbs : Array) : void 
		{
			fashion_thumb_pages = Page_Builder.create_pages(Interactive_Thumb_Builder.build(thumbs));
			network.notify_thumbs_loaded.addOnce(on_object_thumbs_loaded);
			network.load_thumbs(objects_vos);	
		}

		private function on_object_thumbs_loaded(thumbs : Array) : void 
		{
			object_thumb_pages = Page_Builder.create_pages(Interactive_Thumb_Builder.build(thumbs));
			notify_vos_ready.dispatch();
		}

		public function change_to_fashion_thumbs() : void 
		{
			current_thumb_pages = fashion_thumb_pages;
		}

		public function change_to_object_thumbs() : void 
		{
			current_thumb_pages = object_thumb_pages;
		}
		
//			Cleaner.clean(interactive_thumbs);
//			interactive_thumbs = [];
//			thumb_pages = [];
//			this.interactive_thumbs = interactive_thumb_builder.build(vos);			
//			add_thumb_listeners();
//			
//			current_thumb = Interactive_Thumb(interactive_thumbs[0]);
//			vo_clicked.dispatch(current_thumb.vo);
//			create_thumb_pages(interactive_thumbs);
	}
}
