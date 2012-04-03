package MusicEditPackage 
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.ByteArray;
	import com.adobe.soundsEncoders.*;
	import MusicEditPackage.Analizator.Summation;
	import flash.media.*;
	import fl.events.SliderEvent;
	import fl.controls.Slider;
	import flash.utils.Timer;
	
	
	
	
	public class Sending extends MovieClip 
	{
		private const PLOT_HEIGHT:int = 100; 
        private const CHANNEL_LENGTH:int = 185; 
		private var shine:ShineMP3Encoder = null;
		private var canvas:Shape = null;
		private var isConvert:Boolean = false;
		private var sound:Sound = null;
		private var channel:SoundChannel = null;
		private var bytesPosition:Number = 0;
		private var bytes:ByteArray = null;
		private var mixBytes:ByteArray = null;
		private var slider:Slider = null;
		private var key:LoadingKeySmall = null;
		private var main:Main = null;
		
		public function Sending() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Added);
			btnSendToHits.addEventListener(MouseEvent.CLICK, onSendToHits);
			btnSendYourself.addEventListener(MouseEvent.CLICK, onSendToYourself);
			btnSendFriend.addEventListener(MouseEvent.CLICK, onSendToFriend);
		}
		
		public function Added(e:Event)
		{
			main = root as Main;
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			if(isConvert == false)
			{
			   btnPlay.addEventListener(MouseEvent.CLICK, ConvertToMp3);
			   foreground.btnPlay.addEventListener(MouseEvent.CLICK, ConvertToMp3);
			   btnPause.mouseEnabled = false;
			   btnStop.mouseEnabled = false;
			   canvas = new Shape();
			   canvas.graphics.lineStyle(3,0xFF0000);
			   canvas.x = 386; canvas.y = 467;
			   canvas.graphics.moveTo(0,0);
			   addChild(canvas);
			   foreground.visible = true;
			   buttonDeactive();
			}
			else
			{
				btnPlay.addEventListener(MouseEvent.CLICK, ConvertToMp3);
				foreground.btnPlay.addEventListener(MouseEvent.CLICK, ConvertToMp3);
				btnPause.addEventListener(MouseEvent.CLICK, Pause);
				btnStop.addEventListener(MouseEvent.CLICK, Stop);
				btnPause.mouseEnabled = true;
			    btnStop.mouseEnabled = true;
				txt.text = "Конвертирование завершено";
				foreground.visible = true;
				slider = new Slider();
				slider.x = 386;
				slider.y = 467;
				slider.width = 200;
				slider.maximum = 100;
				addChild(slider);
				buttonActive();
				
			}
		}
		
		private function ConvertToMp3(e:MouseEvent)
		{
			if(isConvert == false)
			{
				bytes = new ByteArray();
				foreground.visible = false;
				key = new LoadingKeySmall();
				main.addChild(key);
			    Summation.GetBytesFinal(main.MusicEditMovie.mainField);
			   
			}
			else
			{
				sound = new Sound();
				sound.addEventListener(SampleDataEvent.SAMPLE_DATA, sampleDataHandler);
				bytes.position = bytesPosition;
				channel = sound.play();
				channel.addEventListener(Event.SOUND_COMPLETE, SoundComplete);
				addEventListener(Event.ENTER_FRAME, VisualAnimation);
				mixBytes = new ByteArray();
				foreground.visible = false;
				btnPlay.mouseEnabled = false;
			}
		}
		
		public function Mp3Convert()
		{
			if(key!= null)
			   main.removeChild(key);
			bytes = Summation.bytes;
			bytes.position = 0;
			var WavBytes:ByteArray = WaveEncoder.encode(bytes);
	        WavBytes.position = 0;
		    shine = new ShineMP3Encoder(WavBytes, canvas);
		    shine.start();
		    isConvert = true;
            bytesPosition = 0;
		}
		
		
		
		
		
		private function sampleDataHandler(e:SampleDataEvent)
		{
			try
			{
			   var temp:ByteArray = new ByteArray();
			   bytes.readBytes(temp,0,Mode.currentMeasure);
			   bytesPosition = bytes.position;
			   slider.value = 100 * bytesPosition/bytes.length;
			   e.data.writeBytes(temp);
			}
			catch(ex:Error)
			{
				bytesPosition = 0;
				slider.value = 0;
				btnPlay.mouseEnabled = true;
			}
		}
		
		private function Stop(e:MouseEvent)
		{
			removeEventListener(Event.ENTER_FRAME, VisualAnimation);
			channel.stop();
			bytesPosition = 0;
			foreground.visible = true;
			slider.value = 0;
			btnPlay.mouseEnabled = true;
		}
		
		private function Pause(e:MouseEvent)
		{
			removeEventListener(Event.ENTER_FRAME, VisualAnimation);
			channel.stop();
			foreground.visible = true;
			btnPlay.mouseEnabled = true;
		}
		
		private function VisualAnimation(e:Event)
		{
			txtTime.text = getMinutes(Math.round(channel.position/1000)) + " / " 
			    + getMinutes(Mode.extractLength*Mode.FREQUENCY/44100 * main.MusicEditMovie.mainField.columnNum);
			SoundMixer.computeSpectrum(mixBytes, false, 0); 
            var g:Graphics = mainCanvas.graphics; 
            g.clear(); 
            g.lineStyle(0, 0x6600CC); 
            g.beginFill(0x6600CC); 
            g.moveTo(0, 100); 
     
            var n:Number = 0; 
         
            // left channel 
            for (var i:int = 0; i < CHANNEL_LENGTH; i++)  
            { 
               n = (mixBytes.readFloat() * 200); 
               g.lineTo(i * 2, PLOT_HEIGHT - n); 
            } 
            g.lineTo(CHANNEL_LENGTH * 2, 100); 
            g.endFill(); 
     
            // right channel 
           g.lineStyle(0, 0xCC0066); 
           g.beginFill(0xCC0066, 0.5); 
           g.moveTo(CHANNEL_LENGTH * 2, 100); 
     
           for (i = CHANNEL_LENGTH; i > 0; i--)  
           { 
              n = (mixBytes.readFloat() * 200); 
              g.lineTo(i * 2, PLOT_HEIGHT - n); 
           } 
           g.lineTo(0, 100); 
           g.endFill(); 
		}
		
		private function getMinutes(secondsAll:uint):String
		{
			var minutes:uint = Math.floor(secondsAll/60);
			var st:String = minutes.toString();
			st += ":";
			var seconds:uint = secondsAll - 60*minutes;
			if(seconds<10)
			  st = st + "0" + seconds.toString();
			else
			  st = st + seconds.toString();
			return st;
		}
		
		private function SoundComplete(e:Event)
		{
			removeEventListener(Event.ENTER_FRAME, VisualAnimation);
			foreground.visible = true;
			slider.value = 0;
			btnPlay.mouseEnabled = true;
		}
		
		
		
		private function buttonDeactive()
		{
			DeactiveButton(btnSendYourself);
			DeactiveButton(btnSendFriend);
			DeactiveButton(btnSendToHits);
		}
		
		private function buttonActive()
		{
			ActiveButton(btnSendYourself);
			ActiveButton(btnSendFriend);
			ActiveButton(btnSendToHits);
		}
		
		private function DeactiveButton(mv:MovieClip)
		{
			mv.txt.textColor = 0x000000;
			mv.mouseChildren = false;
			mv.mouseEnabled = false;
		}
		
		private function ActiveButton(mv:MovieClip)
		{
			mv.txt.textColor = 0xFFFFFF;
			mv.mouseChildren = true;
			mv.mouseEnabled = true;;
		}
		
		private function onSendToHits(e:MouseEvent)
		{
			 var winSendHits:winSendToHits = new winSendToHits(shine.mp3Data, main.MusicEditMovie.currentProject.title);
			 main.addChild(winSendHits);
			
		}
		
		private function onSendToYourself(e:MouseEvent)
		{
			SendToWall.Send(shine.mp3Data,PersonInfo.uid, main);
		}
		
		private function onSendToFriend(e:MouseEvent)
		{
			var win:winFriends = new winFriends(shine.mp3Data);
			main.addChild(win);
		}
		
		
		
		
		
	}
	
}
