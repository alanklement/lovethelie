package  
controllers
{
	import models.Data_Model;
	import models.Flash_Var_Model;

	import utils.ExternalSwfSkinLoader;
	import utils.SimpleBulkLoader;
	import utils.XML_Loader;

	import vos.Image_VO;

	import org.osflash.signals.Signal;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;

	public class Network_Controller
	{
		public var notify_thumbs_loaded : Signal = new Signal(Array);
		public var notify_info_loaded : Signal = new Signal(Bitmap);
		public var notify_contact_loaded : Signal = new Signal(Loader);
		public var skins_loaded : Signal;
		public var all_xml_loaded : Signal;
		public var thumbs_loaded : Signal;
		public var before_after_loaded : Signal;
		private var skin_loader : ExternalSwfSkinLoader;
		private var flash_var_facade : Flash_Var_Model;
		private var xml_loader : XML_Loader;
		//		private var thumb_loader : SimpleBulkLoader = new SimpleBulkLoader();
		private var data_model : Data_Model;
		private var before_after_loader : Before_After_Loader = new Before_After_Loader();
		private var before_url : String;
		private var after_url : String;
		private var loader : Loader = new Loader();
		private var bulk_loader : SimpleBulkLoader;
		private var image_vos : Array;
		private var contact_loader : Loader;

		public function Network_Controller(flash_vars : Flash_Var_Model, data_model : Data_Model)
		{
			this.data_model = data_model;
			flash_var_facade = flash_vars;//new Flash_Var_Model(flash_vars);
			create_signals();
			add_listeners();
		}

		private function create_signals() : void 
		{		
			skins_loaded = new Signal(ApplicationDomain);
			all_xml_loaded = new Signal(XML, XML);
			before_after_loaded = new Signal(Bitmap, Bitmap);
		}

		private function add_listeners() : void 
		{
			before_after_loader.images_loaded.add(notify_images_loaded);
		}

		public function load_skins() : void 
		{
			skin_loader = new ExternalSwfSkinLoader(flash_var_facade.skins_url, notify_skins_loaded);
		}

		public function notify_skins_loaded(skins : ApplicationDomain) : void
		{
			skins_loaded.dispatch(skins);
			skin_loader.dispose();
		}

		public function load_xml_files() : void 
		{
			xml_loader = new XML_Loader();
			xml_loader.load_complete.addOnce(notify_xml_files_loaded);
			xml_loader.load_XML(flash_var_facade.fashion_xml_url, flash_var_facade.objects_xml_url);
		}

		private function notify_xml_files_loaded(fashion_xml : XML,objects_xml : XML) : void 
		{
			all_xml_loaded.dispatch(fashion_xml, objects_xml);
			xml_loader.dispose();
		}
		
		public function load_before_after_imgs(before : String, after : String) : void 
		{
//			this.before_url = flash_var_facade.large_img_dir + before;
//			this.after_url = flash_var_facade.large_img_dir + after;

			this.before_url = before;
			this.after_url =  after;
			
			before_after_loader.load_images(before_url, after_url);	
		}

		private function notify_images_loaded(before : Bitmap,after : Bitmap) : void 
		{
			before_after_loaded.dispatch(before, after);
		}

		public function load_info(url : String) : void 
		{
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, handle_error);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, notify_info_img_ready);
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handle_error);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, notify_info_img_ready);
			loader.load(new URLRequest(url));
		}

		private function notify_info_img_ready(event : Event) : void 
		{
			var bm : Bitmap = Bitmap(loader.content);
			notify_info_loaded.dispatch(bm);
		}

		private function handle_error(event : Class) : void 
		{
			trace('event: ' + (event));
		}

		public function load_thumbs(image_vos : Array) : void 
		{
			bulk_loader = new SimpleBulkLoader();
			bulk_loader.notify_images_loaded.addOnce(get_thumbs);
			
			this.image_vos = image_vos;
			
			for (var i : int = 0;i < image_vos.length;i++) 
			{
				var vo : Image_VO = Image_VO(image_vos[i]);
				var url : String = vo.thumb_img_url;
				bulk_loader.addItem(url, vo);
			}
			
			bulk_loader.loadAllItems();	
		}

		private function get_thumbs() : void 
		{	
			for (var i : int = 0;i < image_vos.length;i++) 
			{
				var vo : Image_VO = Image_VO(image_vos[i]);
				vo.thumb_img = bulk_loader.getBitmap(vo);
			}
			
			bulk_loader.dispose();
			bulk_loader = null;
			notify_thumbs_loaded.dispatch(image_vos);	
		}

		public function load_contact() : void 
		{
			contact_loader = new Loader();
			contact_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, pass_loader);
			contact_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, fail_silently);
			contact_loader.load(new URLRequest(flash_var_facade.img_dir + flash_var_facade.contact_url));
		}

		private function pass_loader(event : Event) : void 
		{
			contact_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, pass_loader);
			contact_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, fail_silently);
			notify_contact_loaded.dispatch(contact_loader);
		}

		private function fail_silently(event : IOErrorEvent) : void 
		{
			trace(this, 'fail_silently', 'event: ', (event));
		}
	}
}
