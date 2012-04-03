package com.preloader 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	
	
	public class Preloader extends MovieClip 
	{

		private static const ENTRY_FRAME : int = 3;

		public function Preloader() : void 
		{
			super();
			stop();

			progressBar.progressMask.scaleX = 0;
			
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
		}

		private function completeHandler(e:Event)
		{
			play();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		private function enterFrameHandler(e : Event) 
		{
			if (currentFrame >= ENTRY_FRAME) 
			{
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				stop();
				var main : Class = loaderInfo.applicationDomain.getDefinition("MainClass") as Class;
				addChild(new main());
			}
		}

		private function progressHandler(e : ProgressEvent) 
		{
			progressBar.progressMask.scaleX = 1 / e.bytesTotal * e.bytesLoaded;
		}
	}
}
