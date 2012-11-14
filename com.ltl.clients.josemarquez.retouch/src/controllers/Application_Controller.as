package  
controllers
{
	import effects.Plugins;

	import models.Data_Model;

	import views.App_View;

	import vos.Image_VO;

	import com.greensock.TweenMax;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.MouseEvent;

	/**
	 * @author Alan
	 */
	public class Application_Controller
	{
		private var network : Network_Controller;
		private var view : App_View;
		private var data_model : Data_Model;
		private var nav_control : Nav_Controller;
		private var before_after_viewer : Before_After_Viewer;
		private var cross_fader : Cross_Fader;
		private var top_nav : Top_Nav;
		private var info_control : Info_Controller;
		private var current_section : String;

		public function Application_Controller(network : Network_Controller,data_model : Data_Model, app_view : App_View) 
		{
			this.network = network;
			this.view = app_view;
			this.data_model = data_model;
			this.nav_control = new Nav_Controller(app_view.image_nav);
			this.before_after_viewer = new Before_After_Viewer(view.img_holder);
			this.cross_fader = new Cross_Fader(view.before_after_slide);
			this.top_nav = new Top_Nav(view.fashion_nav, view.objects_nav, view.contact_nav);
			this.info_control = new Info_Controller(view.info_holder);
			
			set_properties();
			add_listeners();
			Plugins.init();
		}

		private function set_properties() : void 
		{
			view.pre_loader.alpha = 0;
		}

		private function add_listeners() : void 
		{
			network.before_after_loaded.add(pass_images_to_viewer);			
			nav_control.vo_clicked.add(load_big_images);
			nav_control.info_clicked.addOnce(show_info);
			cross_fader.switch_state.add(before_after_viewer.cross_fade);
			top_nav.fashion_nav_clicked.add(load_fashion_section);
			top_nav.objects_nav_clicked.add(load_objects_section);
			top_nav.contacts_nav_selected.add(show_contacts);
			network.notify_info_loaded.add(pass_info_to_viewer);
		}

		private function show_info(url : String) : void 
		{
			network.load_info(url);
		}

		private function load_big_images(vo : Image_VO) : void 
		{
			before_after_viewer.dim();
			remove_info();
			new TweenMax(view.pre_loader, .5, {alpha:1, onComplete:network.load_before_after_imgs, onCompleteParams:[(vo).before_img_url, (vo).after_img_url]});
			cross_fader.reset();
		}

		private function pass_images_to_viewer(bm_1 : Bitmap,bm_2 : Bitmap) : void 
		{
			new TweenMax(view.pre_loader, .5, {alpha:0, onComplete:before_after_viewer.update, onCompleteParams:[bm_1,bm_2]});
		}

		public function start() : void 
		{			
			view.notify_intro_finished.addOnce(load_contact);
			view.show_intro();
			top_nav.start();
		}

		private function load_contact() : void 
		{
			network.notify_contact_loaded.addOnce(load_thumbs);
			network.load_contact();
		}

		private function load_thumbs(info : Loader) : void 
		{
			view.info = info;
			data_model.notify_vos_ready.addOnce(show_view);
			data_model.load_vos();			
		}

		private function show_view() : void 
		{
			view.show_rest_of_view();
			load_fashion_section();
		}

		private function load_fashion_section() : void 
		{
			if(current_section == 'fashion')
			{
				return;
			}
			else
			{
				current_section = 'fashion';
				view.turn_off_contacts();
				data_model.change_to_fashion_thumbs();
	
				before_after_viewer.notfy_clear_complete.addOnce(clean_thumbs);
				before_after_viewer.reset();
			}
		}

		private function load_objects_section() : void 
		{
			if(current_section == 'object')
			{
				return;
			}
			else
			{
				current_section = 'object';
				view.turn_off_contacts();
				data_model.change_to_object_thumbs();
				before_after_viewer.notfy_clear_complete.addOnce(clean_thumbs);
				before_after_viewer.reset();
			}
		}

		private function clean_thumbs() : void 
		{
			nav_control.notfy_clear_complete.addOnce(pass_thumbs_to_nav_controller);
			nav_control.clear_thumbs_from_view();
		}

		private function pass_thumbs_to_nav_controller() : void 
		{
			nav_control.update_thumbs(data_model.current_thumb_pages);			
		}

		private function pass_info_to_viewer(bm : Bitmap) : void 
		{
			view.notify_stage_click.addOnce(remove_info);
			info_control.show_info(bm);
		}

		private function remove_info(event : MouseEvent = null) : void 
		{
			nav_control.info_clicked.addOnce(show_info);
			info_control.hide();
			nav_control.turn_btn_off();
		}

		private function show_contacts() : void 
		{
			if(current_section == 'contact')
			{
				return;
			}
			else
			{
				nav_control.clear_thumbs_from_view3();
				current_section = 'contact';
				view.hide_not_contact();
				before_after_viewer.reset();		
			}
		}
	}
}
