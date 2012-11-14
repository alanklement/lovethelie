package models 
{

	/**
	 * @author Alan
	 */
	public class Flash_Var_Model 
	{
		public var skins_url : String;
		public var fashion_xml_url : String;
		public var objects_xml_url : String;
		public var large_img_dir : String;
		public var thumb_img_dir : String;
		public var img_dir : String;
		public var contact_url : String;
		public var fashion_dir : String;
		public var objects_dir : String;

		public function Flash_Var_Model(flash_vars : Object) 
		{
			this.skins_url = String(flash_vars["skins"]);
			this.fashion_xml_url = String(flash_vars["fashion_xml_url"]);
			this.objects_xml_url = String(flash_vars["objects_xml_url"]);
			this.large_img_dir = String(flash_vars["large_img_dir"]);
			this.thumb_img_dir = String(flash_vars["thumb_img_dir"]);
			this.contact_url = String(flash_vars["info_img"]);
			this.img_dir = String(flash_vars["img_dir"]);

			this.fashion_dir = String(flash_vars["fashion_dir"]);
			this.objects_dir = String(flash_vars["objects_dir"]);
		}
	}
}
