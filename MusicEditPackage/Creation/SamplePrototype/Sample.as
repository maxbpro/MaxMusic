package MusicEditPackage.Creation.SamplePrototype 
{
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.net.URLRequest;
	import flash.geom.*;
	import flash.ui.Keyboard;
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilter;
    import flash.text.*;
	
	
	public class Sample extends MovieClip 
	{
		private static const WIDTHOfInsideCell:uint = 50;
		
		private  var information:Vector.<Vector.<ByteArray>> = null;
		
		private var length:int = -1;
		private var title:String = new String();
		private var instrument:uint = 0;
		private var url:String = null;
		private var using:String = null;
		private var sound:Sound = null;	
		
		public function Sample(title:String, url:String, length:int , instrument:uint, using:String) 
		{
			 this.url = url;
			 this.title = title;
			 this.length = length;
			 this.instrument = instrument;
			 this.using = using;
			 addEventListener(Event.ADDED_TO_STAGE, Added);
			 addEventListener(MouseEvent.ROLL_OVER, RollOver);
			 addEventListener(MouseEvent.ROLL_OUT, RollOut);
			 addEventListener(KeyboardEvent.KEY_UP, RemoveFromMain);
			 mouseChildren = false;
		}
		
		
		
		private function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			DrawSample();
		}
		
		
		public function StartDownload()
		{
            if (sound == null)
			{
		     	sound = new Sound();
		     	sound.addEventListener(Event.COMPLETE, ExtractMP3);
				sound.addEventListener(ProgressEvent.PROGRESS, onProgress);
			    sound.addEventListener(IOErrorEvent.IO_ERROR, IOerror);
		     	sound.load(new URLRequest(url));
			}
			else
			{
				ExtractMP3(null);
			}

		}
		
		private function onProgress(e:ProgressEvent)
		{
			txt.text = uint(e.bytesLoaded/e.bytesTotal*100)+"%";
		}

	   	private function ExtractMP3(e:Event)
		{
			this.txt.text = title;
			try
			{
			   if(information == null)
			   {
			      information = new Vector.<Vector.<ByteArray>>();
			      var positionCur:uint = 0;
			      var counter:uint = 0;
			      var temp:Vector.<ByteArray> = new Vector.<ByteArray>();
			      var frames:uint=0;
			      while(positionCur < int(sound.length * 44.1))
			      {
				      if(counter==Mode.FREQUENCY)
				      {
					      information.push(temp);
					      temp = new Vector.<ByteArray>();
					      counter=0;
				      }
				      var bytes:ByteArray = new ByteArray();
			          sound.extract(bytes, Mode.extractLength);
				      bytes.position = 0;
                      if(bytes.bytesAvailable<Mode.currentMeasure)
				         bytes.length = Mode.currentMeasure;
				      temp.push(bytes);
				      positionCur += Mode.extractLength;
				      counter++;
				      frames++;
			      }
			      if(temp.length != 0)
			      {
					   for(var i:uint=temp.length; i<=Mode.FREQUENCY-1; i++)
					   {
						   bytes = new ByteArray();
						   bytes.length = Mode.currentMeasure;
						   temp.push(bytes);
					   }
				
			           information.push(temp);
			      }
			   
			   }
			}
			catch(e:Error)
			{
				var attention:Attention = new Attention("Сэмпл недоступен", preview.root as Main);
				attention.Show();
			}
		}
		
		
		
        public function CreateInsideCells()
		{
			var location:uint=0;
			for(var i:uint=0; i<length; i++)
			{
				var insideCell:InsideCell = new InsideCell();
				insideCell.alpha = 0;
				insideCell.x = location;
				insideCell.name = "insideCell" + i.toString(); 
				addChild(insideCell);
				location += WIDTHOfInsideCell;
			}
		}
		
		
		
		
		private function RollOver(e:MouseEvent)
		{
           // Свечение и фокус
			var myFilters:Array = new Array();
			var effect:BitmapFilter = new GlowFilter(0xFFFF33, 0.75, 13,13,2,1,false,false);
            myFilters.push(effect);
            this.filters = myFilters;
			parent.stage.focus = this;
			buttonMode = true;
		}
		
		
		
		private function RollOut(e:MouseEvent)
		{
			 this.filters = null;
			 buttonMode = false;
		}
		
		
		private function IOerror(e:IOErrorEvent)
		{
			var attention:Attention = new Attention("Сервер недоступен", preview.root as Main);
			attention.Show();
		}
		
		public function RemoveFromMain(e:KeyboardEvent)
		{
			if(e.keyCode == Keyboard.DELETE || e.keyCode == Keyboard.BACKSPACE)
			{
				 try
				 {
				   (root as Main).removeChild(this);
				 }
				 catch(ex:Error)
				 {
					 
				 }
				
					   
			}
		}
		
		private function DrawSample()
		{
		   txt.text = title;
			if(length == 1)
			{
			   if(txt.text.length >= 8)
			   {
				   var format:TextFormat = txt.getTextFormat();
				   switch(txt.text.length)
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
				   txt.setTextFormat(format);
			   }
			}
			var canvas:Shape = new Shape();
			addChild(canvas);
			var colors:Array = MainSamplesPanel.GetColor(instrument);
			canvas.graphics.beginGradientFill(GradientType.LINEAR, colors, [1, 0.75], [0, 255]);   
			canvas.graphics.drawRect(0,0,50*length, 30);
			setChildIndex(txt,numChildren-1);
			if(using != "free")
			{
				var lockopen:LockOpen = new LockOpen();
				lockopen.x = length*50 - 37;
				lockopen.y = 2;
				lockopen.mouseEnabled = false;
				lockopen.alpha = 0.75;
				addChildAt(lockopen, getChildIndex(txt));
			}
		}
		
	}
	
}
