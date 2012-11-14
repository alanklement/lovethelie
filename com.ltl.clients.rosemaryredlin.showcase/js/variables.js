var vars = function() {
	function refresh (width) {
		vars.slide_holder_width += width;

		var value = view.slider_div.slider('option', 'value');
				
		if(value > 90)
		{
			view.slider_div.slider('option', 'value', 90);
		}
	};

	return{
		refresh:refresh
	};
	
}();

vars.intialize = function () {
	this.slide_holder_width = 0;
	this.transition_speed = 250;
	this.img_base_path = "";

	this.beauty_xml ="./php/beauty.php";
	this.beauty_dir =  "./img/beauty/";
	
	this.editorial_xml = "./php/editorial.php";
	this.editorial_dir =  "./img/editorial/";
	
	this.advertising_xml = "./php/advertising.php";
	this.advertising_dir = "./img/advertising/";

	this.celeb_xml = "./php/celeb.php";
	this.celeb_dir = "./img/celeb/";
	
	this.hair_makeup_xml = "./php/hair_makeup.php";
	this.hair_makeup_dir = "./img/hair_makeup/";	
	
	this.xml_to_load = "";
	this.bio_is_visible = false;
	this.contact_is_visible = false;	
	this.intro_is_visible  = true;
	this.clients_is_visible  = false;	
};


