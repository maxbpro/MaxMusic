package  
{
	
	import flash.display.MovieClip;
    import flash.events.*;
	
	
	public class Attention extends MovieClip 
	{
		private var info:String = null;
		private var main:Main = null;
		
		public function Attention(info:String, main:Main) 
		{
			this.info = info;
			this.main = main;
			addEventListener(Event.ADDED_TO_STAGE, Added);
			btnOK.addEventListener(MouseEvent.CLICK, closeAttention);
		}
		
		private function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			txt.text = info;
		}
		
		private function closeAttention(e:MouseEvent)
		{
			main.removeChild(this);
			
		}
		
		public function Show()
		{
			main.addChild(this);
		}
	}
	
}
