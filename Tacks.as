package  
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Tacks extends MovieClip 
	{
		private var win:winBalance = null;
		private var main:Main = null;
		
		public function Tacks() 
		{
			addEventListener(MouseEvent.ROLL_OVER, RollOver);
            addEventListener(MouseEvent.ROLL_OUT, RollOut);
			addEventListener(Event.ADDED_TO_STAGE, Added);
		}
		
		private function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			main = root as Main;
		}
		

        private function RollOver(e:MouseEvent)
        {
	        txt.textColor = 0xFD87FE;
			buttonMode = true;
			win = new winBalance();
			win.x = 400 - win.width/2;
			win.y = e.stageY - e.localY;
			main.addChild(win);
			win.addEventListener(MouseEvent.ROLL_OUT, winOut);
        }

        private function RollOut(e:MouseEvent)
        {
			if (e.relatedObject != null  &&  !(e.relatedObject is winBalance))
			{
			   if(main.contains(win))
		     	   main.removeChild(win);
               txt.textColor = 0xFFFFFF;
			   buttonMode = false;
			   win = null;
			}
			txt.textColor = 0xFFFFFF;
        }
		
		private function winOut(e:MouseEvent)
		{
			 if(main.contains(win))
		     	   main.removeChild(win);
			 txt.textColor = 0xFFFFFF;
			 win = null;
		}
		
	}
	
}
