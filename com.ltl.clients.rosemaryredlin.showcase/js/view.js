view = function()
{
	function intialize () {

		this.btns = [];

		this.beauty_btn = $('#beauty_btn');	
		this.editorial_btn = $('#editorial_btn');
		this.advertising_btn = $('#advertising_btn');
		this.celebrity_btn = $('#celebrity_btn');
		this.hair_makeup_btn = $('#hair_makeup_btn');
		this.contact_btn = $('#contact_btn');
		this.video_btn = $('#video_btn');
		this.bio_btn = $('#bio_btn');
		this.clients_btn = $('#clients_btn');
		
		this.intro_container = $('#intro_container')

		this.contact_container = $('#contact_container');	
		
		this.clients_container = $('#clients_container');	
	
		this.bio_container = $('#bio_container');
		this.bio_text = $('#bio_text');		
		this.bio_slider = $('#bio_slider');

		this.gallery_container = $('#gallery_container');
		this.slide_holder = $('#slide_holder');
		this.slider_div = $('#slider');

		add_btns_to_array();
		build_ui();
		build_events();
	};
	
	function add_btns_to_array () {
		view.btns.push(view.beauty_btn);
		view.btns.push(view.editorial_btn);
		view.btns.push(view.advertising_btn);
		view.btns.push(view.celebrity_btn);
		view.btns.push(view.hair_makeup_btn);
		view.btns.push(view.clients_btn);
		view.btns.push(view.contact_btn);
		view.btns.push(view.bio_btn);				
		view.btns.push(view.video_btn);
	}

	function build_ui () {
		view.slider_div.slider({animate: true});	
		view.bio_slider.slider({ orientation: 'vertical' });	
	};

	function build_events () {
		view.beauty_btn.bind('click',controller.load_beauty);
		view.editorial_btn.bind('click',controller.load_editorial);
		view.contact_btn.bind('click',controller.load_contact);
		view.bio_btn.bind('click',controller.show_bio);
		view.advertising_btn.bind('click',controller.load_advertising);
		view.celebrity_btn.bind('click',controller.load_celeb);
		view.hair_makeup_btn.bind('click',controller.load_hair_makeup);
		view.clients_btn.bind('click',controller.load_clients);

		create_roll_overs();

		view.slider_div.bind('slide',controller.update_slide_value);
		view.bio_slider.bind('slide',controller.slide_bio);
	};
	
	function create_roll_overs () {
				
		for (var i=0; i < view.btns.length; i++) {
			view.btns[i].hover(function() {
				this.src = this.src.replace("_off","_on");
			}, function() {
				this.src = this.src.replace("_on","_off");
			});
		};
	}

	function refresh () {
		view.slider_div.slider('option', 'max', vars.slide_holder_width);
	};
	
	return{
		intialize:intialize,
		refresh:refresh
	}
	
}();




