package  
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Help extends MovieClip 
	{
		private var st:String = null;
		private var main:Main = null;
		
		public function Help(st:String, main:Main, width:uint, height:uint, stageX:Number, stageY:Number) 
		{
			this.st = st;
			this.main = main;
			this.background.width = width;
			this.background.height = height;
			this.x = stageX+2;
			this.y = stageY+20;
			addEventListener(Event.ADDED_TO_STAGE, Added);
		}
		
		private function Added(e:Event)
		{
			txt.text = st;
			txt.width = background.width - 5;
			txt.height = background.height - 5;
			removeEventListener(Event.ADDED_TO_STAGE, Added);
		}
		
		public function Show()
		{
			this.alpha = 0.1;
			if(main != null)
			  main.addChild(this);
			addEventListener(Event.ENTER_FRAME, EnterFrameShowHandler);
		}
		
		private function EnterFrameShowHandler(e:Event)
		{
			if(alpha<1)
			   this.alpha += 0.5;
			else
			   removeEventListener(Event.ENTER_FRAME, EnterFrameShowHandler);
		}
		
		public function Hide()
		{
			removeEventListener(Event.ENTER_FRAME, EnterFrameShowHandler);
			addEventListener(Event.ENTER_FRAME, EnterFrameHideHandler);
		}
		
		private function EnterFrameHideHandler(e:Event)
		{
			 if(alpha>0)
			   this.alpha -= 0.5;
			 else
			 {
				 removeEventListener(Event.ENTER_FRAME, EnterFrameHideHandler);  
                 if(main != null)				 
				   main.removeChild(this);
			 }
	    }
		
		
	}
	
}
