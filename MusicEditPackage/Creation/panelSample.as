package MusicEditPackage.Creation
{
	
	import flash.display.*;
	import flash.media.Sound;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.geom.Rectangle;
	import flash.media.SoundChannel;
	import flash.text.*;
	
	
	public class panelSample extends MovieClip 
	{
		private var sound:Sound=null;
		private var soundChannel:SoundChannel = null;
		// для передачи Sound в "родитель" PreviewSample
		private var preview:PreviewSample = null;
		public var length:uint=0;
		private var title:String = "";
		public var url:String = null;
		public var instrument:uint = 0;
		private var playMe:btnplay = null;
		
		public function panelSample(title:String, url:String, length:int, preview:PreviewSample, instrument:uint) 
		{
            this.title = title;
			this.length = length;
			this.preview = preview;
			this.url = url;
			this.instrument = instrument;
			var increment:uint = 0;
			if(preview.using != "free")
			   increment = 30;
			if (length>6)
				this.background.width = 340;
			else
			{
				if(length<3)
				   this.background.width = 200;
				else
				   this.background.width = length * 50+40;
			}
			this.background.height +=increment;
			

			addEventListener(Event.ADDED_TO_STAGE, Added);
		}
		
		private function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			var canvas:Shape = new Shape();
			addChildAt(canvas, getChildIndex(titleOfSample));
			var colors:Array = MainSamplesPanel.GetColor(instrument);
			var fillType:String = GradientType.LINEAR;
			var alphas:Array = [1, 1];
            var ratios:Array = [0, 255];
			canvas.graphics.beginGradientFill(fillType, colors, alphas, ratios);  
			if(length>6)
			  canvas.graphics.drawRect(20,20,300,30);
			else
			  canvas.graphics.drawRect(20,20,50*length, 30);
            for(var i:uint=0; i<numChildren; i++)
            {
	            var obj:InteractiveObject = getChildAt(i) as InteractiveObject; 
	            if(obj!= null)
	              (getChildAt(i) as InteractiveObject).mouseEnabled = false;
            }
          
			txt.text = "Число тактов: "+length;
			playMe = new btnplay();
			playMe.width=30; playMe.height=30;
			playMe.x = txt.width +30; playMe.y = 60;
			playMe.addEventListener(MouseEvent.MOUSE_DOWN, DownloadBegin);
			addChild(playMe);
			var stopMe:btnstop = new btnstop();
			stopMe.width=30; stopMe.height=30;
			stopMe.x = txt.width + playMe.width + 40; stopMe.y = 60;
			stopMe.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent)
									{
										if(soundChannel!= null)
										   soundChannel.stop();
									});
			addChild(stopMe);
			if(preview.using == "close")
			{
				var btnCloseSample:closeSample = new closeSample();
				btnCloseSample.x = this.width/2 - 76;
				btnCloseSample.y = height - 50;
				addChild(btnCloseSample);
				var lockopen:LockClose = new LockClose();
				lockopen.x = 20+length*50 - 37;
				lockopen.y = 22;
				lockopen.mouseEnabled = false;
				addChildAt(lockopen, getChildIndex(titleOfSample));
			}
			else
			{
				if(preview.using == "open")
				{
					var btnOpenSample:openSample = new openSample();
					btnOpenSample.x = this.width/2 - 76;
					btnOpenSample.y = height - 50;
					btnOpenSample.mouseEnabled = false;
					addChild(btnOpenSample);
					var lockclose:LockOpen = new LockOpen();
					lockclose.x = 20+length*50 - 37;
					lockclose.y = 22;
					lockclose.mouseEnabled = false;
					addChildAt(lockclose, getChildIndex(titleOfSample));
				}
			}
			titleOfSample.text = title;
			if(length == 1)
			{
			   if(titleOfSample.text.length >= 8)
			   {
				   var format:TextFormat = titleOfSample.getTextFormat();
				   switch(titleOfSample.text.length)
				   {
					   case 8:
					   {
			               format.size = 12;
						   break;
					   }
					   case 9:
					   {
				           format.size = 10;
						   break;
					   }
				   }
				   titleOfSample.setTextFormat(format);
			   }
			}
			txtPercent.text = "";
		}
		
		private function DownloadBegin(e:MouseEvent)
		{
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE, DownloadMP3Success);
			sound.addEventListener(ProgressEvent.PROGRESS, ProgressLoading);
			sound.addEventListener(IOErrorEvent.IO_ERROR, IOerror);
		    sound.load(new URLRequest(url));
			txtPercent.text = "0%";
			playMe.mouseEnabled = false;
		}
		
		private function ProgressLoading(e:ProgressEvent)
		{
			txtPercent.text = uint(e.bytesLoaded/e.bytesTotal*100) + "%";
		}
		
		private function DownloadMP3Success(e:Event)
		{
            soundChannel = sound.play();
			preview.sample.InitSound(sound);
			txtPercent.text = "";
			playMe.mouseEnabled = true;
		}
		
		private function IOerror(e:IOErrorEvent)
		{
			var attention:Attention = new Attention("Сервер недоступен", preview.root as Main);
			attention.Show();
		}
	}
	
}
