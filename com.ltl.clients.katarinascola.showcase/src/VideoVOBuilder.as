package {
	public class VideoVOBuilder {
		private var createVideoMenu : Function;
		private var xmlLoader : DisposableBootstrap;
		private var videoDir : String;

		public function VideoVOBuilder(videoDir : String, xmlURL : String, createVideoMenu : Function) {
			this.videoDir = videoDir;
			this.createVideoMenu = createVideoMenu;
			xmlLoader = new XMLLoader(xmlURL, buildVideoVOs);
		}

		private function buildVideoVOs(xml : XML) : void {
			var videoVOs : Array = [];
			for each (var video : XML in xml.video) {
				var videoVO : VideoVO = new VideoVO(video.title, videoDir + video.fileName);
				videoVOs.push(videoVO);
			}

			createVideoMenu(videoVOs);
		}
	}
}
