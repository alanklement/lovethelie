package builders 
{
	import models.Flash_Var_Model;

	import vos.Image_VO;

	/**
	 * @author Alan
	 */
	public class VO_Builder  
	{
		public static function build_vos(xml : XML, img_dir : String) : Array 
		{
			var image_vos : Array = [];
			var images : int = xml..image.length(); 
			for (var i : int = 0;i < images;i++) 
			{
				var vo : Image_VO = VO_Builder.build_vo((xml..image[i]), img_dir);
				//				var thumb : Interactive_Thumb = new Interactive_Thumb(vo);
				image_vos.push(vo);
			}
			
			return image_vos;
		}

		private static function build_vo(xml : XML,img_dir : String) : Image_VO 
		{
			var vo : Image_VO = new Image_VO();
			vo.before_img_url = img_dir + String(xml.before.text());
			vo.after_img_url = img_dir + String(xml.after.text());
			vo.thumb_img_url = img_dir + String(xml.thumb.text());
			vo.info_img = img_dir + String(xml.info.text());
			
			if(String(xml.info.text()) == '')
			{
				vo.no_info = true;	
			}
			else
			{
				vo.no_info = false;
			}
									
			return vo;
		}
	}
}
