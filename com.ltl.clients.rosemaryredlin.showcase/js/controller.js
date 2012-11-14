var controller = function() {
	
	var count = 0;
	var images = []; 
	var urls = []; 	

	function intialize () {
		view.slider_div.slider('disable');
		this.xml_to_load = "";
		view.gallery_container.hide();
		view.slider_div.hide();
		view.bio_container.hide();
		view.contact_container.hide();
		view.clients_container.hide();
	};
	

	function load_xml () {

		$.ajax({
	    	type: "GET",
	    	url: vars.xml_to_load,
	    	dataType: "xml",
	    	success: add_images_to_holder
	  	});
	}
	
	function add_images_to_holder (xml) {

		reset_for_gallery_load();

	  	$(xml).find("image").each(function()
	  	{
			var li = '<li></li>';
			var img = new Image();
			var url = vars.img_base_path + $(this).text();
			view.slide_holder.append(li);

			var last = $('li:last');
			last.append(img);
			last.addClass("list");

			images.push(img);
			urls.push(url);

	  	});
		
		do_staggared_load();
		view.slider_div.slider('enable');
	}

	function do_staggared_load () {
		
		count = 0;
		for (var i=0; i < 3; i++) {
			load_img(images.shift(),urls.shift());
		};
	}

	function load_beauty(){
		vars.xml_to_load = vars.beauty_xml;
		vars.img_base_path = vars.beauty_dir;
		
		show_gallery();
	};
	
	function load_editorial () {
		vars.xml_to_load = vars.editorial_xml;
		vars.img_base_path = vars.editorial_dir;
		
		show_gallery();
	};
	
	function load_advertising () {
		vars.xml_to_load = vars.advertising_xml;
		vars.img_base_path = vars.advertising_dir;
		
		show_gallery();	
	}
	
	function load_celeb () {
		vars.xml_to_load = vars.celeb_xml;
		vars.img_base_path = vars.celeb_dir;
		
		show_gallery();	
	}
	
	function load_clients () {
		
			if(vars.intro_is_visible){
				view.intro_container.fadeOut('slow', function() {
					view.clients_container.fadeIn(vars.transition_speed);
					vars.clients_is_visible = true;
					vars.intro_is_visible = false;
				});	
			}else if(vars.contact_is_visible){
				view.contact_container.fadeOut('slow', function() {
					view.clients_container.fadeIn(vars.transition_speed);
					vars.clients_is_visible = true;
					vars.contact_is_visible = false;
				});
			}
			else if(vars.bio_is_visible){
				view.bio_container.fadeOut('slow', function() {
					view.clients_container.fadeIn(vars.transition_speed);
					vars.clients_is_visible = true;
					vars.bio_is_visible = false;
				});
			}
			else
			{
				$('#slider').hide('fast');
				view.gallery_container.fadeOut(vars.transition_speed, function() {
					view.clients_container.fadeIn(vars.transition_speed);
					vars.clients_is_visible = true;
				});		
			}
	}

	function load_hair_makeup () {
		vars.xml_to_load = vars.hair_makeup_xml;
		vars.img_base_path = vars.hair_makeup_dir;
		
		show_gallery();	
	}
	
	function show_gallery () {
		
		if(vars.bio_is_visible)
		{					
			view.bio_container.fadeOut(vars.transition_speed, function() {	
				reset_for_gallery_load();
				view.gallery_container.fadeIn(0, load_xml);
				vars.bio_is_visible = false;				
			});
			
			view.slider_div.show('fast');
		}
		else if(vars.intro_is_visible)
		{
			view.intro_container.fadeOut(vars.transition_speed, function() {	
				reset_for_gallery_load();
				view.gallery_container.fadeIn(0, load_xml);
				vars.intro_is_visible = false;				
			});
			
			view.slider_div.show('fast');
		}
		else if(vars.contact_is_visible)
		{
			view.contact_container.fadeOut(vars.transition_speed, function() {	
				reset_for_gallery_load();
				view.gallery_container.fadeIn(0, load_xml);
				vars.contact_is_visible = false;				
			});
			
			view.slider_div.show('fast');
		}
		else if(vars.clients_is_visible)
		{
			view.clients_container.fadeOut(vars.transition_speed, function() {	
				reset_for_gallery_load();
				view.gallery_container.fadeIn(0, load_xml);
				vars.clients_is_visible = false;				
			});
			
			view.slider_div.show('fast');
		}		
		else
		{
			view.slide_holder.fadeOut(vars.transition_speed, load_xml);
		}
		
		view.slider_div.slider('option', 'value', 0);
	}
	
	function load_contact () {
		if(vars.intro_is_visible){
			view.intro_container.fadeOut('slow', function() {
				view.contact_container.fadeIn(vars.transition_speed);
				vars.contact_is_visible = true;
				vars.intro_is_visible = false;
			});	
		}
		else if(vars.bio_is_visible){
				view.bio_container.fadeOut('slow', function() {
					view.contact_container.fadeIn(vars.transition_speed);
					vars.contact_is_visible = true;
					vars.bio_is_visible = false;
				});
		}
		else if(vars.clients_is_visible){
				view.clients_container.fadeOut('slow', function() {
					view.contact_container.fadeIn(vars.transition_speed);
					vars.contact_is_visible = true;
					vars.clients_is_visible = false;
				});
		}
		else
		{
			$('#slider').hide('fast');
			view.gallery_container.fadeOut(vars.transition_speed, function() {
				view.contact_container.fadeIn(vars.transition_speed);
				vars.contact_is_visible = true;
			});		
		}
	}
	
	function show_bio () {
		
		reset_bio();
						
		if(vars.intro_is_visible){
			view.intro_container.fadeOut('slow', function() {
				view.bio_container.fadeIn(vars.transition_speed);
				vars.bio_is_visible = true;
				vars.intro_is_visible = false;
			});	
		}else if(vars.contact_is_visible){
			view.contact_container.fadeOut('slow', function() {
				view.bio_container.fadeIn(vars.transition_speed);
				vars.bio_is_visible = true;
				vars.contact_is_visible = false;
			});
		}else if(vars.clients_is_visible){
				view.clients_container.fadeOut('slow', function() {
					view.bio_container.fadeIn(vars.transition_speed);
					vars.bio_is_visible = true;
					vars.clients_is_visible = false;
				});
			}
		else
		{
			$('#slider').hide('fast');
			view.gallery_container.fadeOut(vars.transition_speed, function() {
				view.bio_container.fadeIn(vars.transition_speed);
				vars.bio_is_visible = true;
			});		
		}
	}
	
	function reset_bio () {
		view.bio_text.css('top',0);
		view.bio_slider.slider('option', 'value', 100);		
	}
	
	function reset_for_gallery_load () {
		view.slide_holder.empty();
		images = [];
		urls = [];
		vars.slide_holder_width = 0;
		view.slide_holder.css('left', 0);
		view.slide_holder.show();
		count = 0;
	}

	function load_img (img,url) {
		$(img).hide();
		$(img).load(image_loaded);
		$(img).attr('src',url);
	}

	function image_loaded () {
		$(this).fadeIn();
		vars.refresh($(this).width());
		
		count++;
		if(count >= 3)
		{
			do_staggared_load();
		}
	}
	
	function update_slide_value (event,ui) {
		var amount_to_slide = vars.slide_holder_width * (ui.value)/100 * -1;
		view.slide_holder.css('left',amount_to_slide);
	};
	
	function slide_bio (event,ui) {
		var amount_to_slide = 100 * (ui.value)/100 - 100;
		view.bio_text.css('top',amount_to_slide);
	}
	
	return {
		load_beauty:load_beauty,
		load_clients:load_clients,
		load_editorial:load_editorial,
		show_bio:show_bio,
		load_advertising:load_advertising,
		load_celeb:load_celeb,
		load_hair_makeup:load_hair_makeup,
		intialize:intialize,
		slide_bio:slide_bio,
		load_contact:load_contact,
		update_slide_value:update_slide_value		
	}
}();


