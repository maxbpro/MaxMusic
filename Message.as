package  
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class Message extends MovieClip 
	{
		private var st:String = null;
		
		public function Message(frame:uint, st:String = "Введите имя для проекта") 
		{
			gotoAndStop(frame);
			this.st = st;
			addEventListener(Event.ADDED_TO_STAGE, Added);
		}
		
		private function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			txt.text = st;
		}
	}
	
}
