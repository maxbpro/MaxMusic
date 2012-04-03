package  MusicEditPackage
{
	
	public class Mode 
	{
		
		public static var FREQUENCY = 10;
		public static var currentMeasure = 0;
		public static var extractLength = 0;
		public static var mode:String = null;
		public static var step:Number = -1;

		public function Mode() 
		{
			
		}
		
		public static function ModeChange(mode2:String, mainMusic:MusicEdit)
		{
			switch(mode2)
			{
				case "Dance":
				{
					FREQUENCY = 10;
					extractLength = 7558;
					currentMeasure = 60464;
					step = 5;
					mode = "Dance";
					mainMusic.infoPanel.genre.text = "Dance";
					mainMusic.stylePictures.gotoAndStop(1);
					break;
				}
				case "DrumNBass":
				{
					FREQUENCY = 10;
					extractLength = 6615;
					currentMeasure = 52920;
					step = 5;
					mode = "DrumNBass";
					mainMusic.infoPanel.genre.text = "Drum'N'Bass";
					mainMusic.stylePictures.gotoAndStop(2);
					break;
				}
				case "Pop":
				{
					FREQUENCY = 15;
					extractLength = 7838;
					currentMeasure = 62704;
					step = 50.0/15.0;
					mode = "Pop";
					mainMusic.infoPanel.genre.text = "Pop";
					mainMusic.stylePictures.gotoAndStop(3);
					break;
				}
			}
		}

	}
	
}
