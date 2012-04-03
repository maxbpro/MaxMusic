package com.adobe.soundsEncoders
{
	import flash.events.ProgressEvent;
	import cmodule.shine.CLibInit;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.display.Shape;
	import MusicEditPackage.Sending;

	/**
	 * @author kikko.fr - 2010
	 */
	public class ShineMP3Encoder extends EventDispatcher 
	{
		
		public var wavData:ByteArray;
		public var mp3Data:ByteArray;
		
		private var cshine:Object;
		private var timer:Timer;
		private var initTime:uint;
		private var canvas:Shape = null;
		private var sending:Sending = null;
		
		public function ShineMP3Encoder(wavData:ByteArray, canvas:Shape) 
		{
			this.wavData = wavData;
			sending = canvas.parent as Sending;
			this.canvas = canvas;
		}

		public function start() : void 
		{
			
			initTime = getTimer();
			
			mp3Data = new ByteArray();
			
			
			timer = new Timer(1000/30);
			timer.addEventListener(TimerEvent.TIMER, update);
			
			var temp:CLibInit = new CLibInit();
			cshine = temp.init();
			cshine.init(this, wavData, mp3Data);
			
			if(timer) timer.start();
		}
		
		public function shineError(message:String):void 
		{
			
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, update);
			timer = null;
			
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, message));
		}
		
		public function saveAs(filename:String=".mp3"):void 
		{
			
			var ref:FileReference = new FileReference();
			ref.save(mp3Data, filename);
		}
		
		private function update(event : TimerEvent) : void 
		{
			
			var percent:int = cshine.update();
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, percent, 100));
			
			canvas.graphics.beginFill(0xFF0000);
			canvas.graphics.lineTo(2 * percent, 0);
			canvas.graphics.endFill();
			sending.txt.text = "Конвертирование в mp3... ";
			
			trace("encoding mp3...", percent+"%");
			
			if(percent==100) {
				
				trace("Done in", (getTimer()-initTime) * 0.001 + "s");
				
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, update);
				timer = null;
				canvas.parent.removeChild(canvas);
				sending.foreground.visible = true;
				sending.Added(null);
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		
	}
}
