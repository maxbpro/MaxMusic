package MusicHitsPackage 
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class status extends MovieClip 
	{
		private var  winInfo:PersonHitsForEdit = null;
		
		public function status() 
		{
			addEventListener(MouseEvent.ROLL_OVER, RollOver);
            addEventListener(MouseEvent.ROLL_OUT, RollOut);
		}
		
		

        function RollOver(e:MouseEvent)
        {
	        txt.textColor = 0xFD87FE;
			buttonMode = true;
			winInfo = new PersonHitsForEdit();
			winInfo.x =  -winInfo.width/2;
			winInfo.y = 42;
			addChild(winInfo);
        }

        function RollOut(e:MouseEvent)
        {
            txt.textColor = 0xFFFFFF;
			buttonMode = false;
			if(winInfo != null && contains(winInfo))
			   removeChild(winInfo);
        }
	}
	
}
