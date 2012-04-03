package  MusicEditPackage.ProjectIO
{
	import com.adobe.serialization.json.JSON;
	import flash.media.Sound;
	import flash.events.*;
	import flash.utils.ByteArray;
	import flash.net.*;
	import MusicEditPackage.Field.MainField;
	import MusicEditPackage.MusicEdit;
	import MusicEditPackage.Field.Cell;
	import MusicEditPackage.Creation.SamplePrototype.Sample;
	import MusicEditPackage.Mode;
	
	public class Decoder 
	{
		private static var mainField:MainField = null;
        private static var counter:uint = 0;
		private static var sound:Sound = null;
		private static var sample:Sample = null;
		private static var startNum:uint = 0;
		private static var data:Array = null;
		private static var movieStart:Cell = null;
		private static var mainMusic:MusicEdit = null;
		private static var main:Main = null;

		public function Decoder() 
		{
			
		}
		
		//data: counter, url, title, length, instrument
		public static function Decode(mainField2:MainField, data2:Array, main2:MusicEdit)
		{
			try
			{
			   mainField = mainField2;
			   mainMusic = main2;
			   main = mainMusic.parent as Main;
			   data = data2;
			   counter = 0;
			   var ar:Array  = data[counter].toString().split(",");
			   movieStart = mainField.getChildByName("cell"+ar[0]) as Cell;
			   movieStart.url = ar[1];
			   movieStart.title = ar[2];
			   movieStart.length = ar[3];
			   movieStart.instrument = ar[4];
			   movieStart.using = ar[5];
			
			   sample = new Sample(ar[2],ar[1],ar[3],ar[4], ar[5]);
		       startNum = ar[0];
			
			   sound = new Sound();
			   sound.addEventListener(Event.COMPLETE, ExtractMP3);
		       sound.addEventListener(IOErrorEvent.IO_ERROR, IOerror);
			   var ref:String = ar[1].toString();
	           sound.load(new URLRequest(ref));
			   Key.ShowKey(main, false);
			}
             catch(ex:Error)
			 {
			     Key.HideKey(main);
				 var attention:Attention = new Attention("Испорченный проект", mainMusic.parent as Main);
			     attention.Show();
				 return;
			 }
			
		}
		
		
	   	private static function ExtractMP3(e:Event)
		{
			try
			{
			   sample.information = new Vector.<Vector.<ByteArray>>();
			   var positionCur:uint = 0;
			   var index:uint = 0;
			   var temp:Vector.<ByteArray> = new Vector.<ByteArray>();
			   var frames:uint=0;
			   while(positionCur < int(sound.length * 44.1))
			   {
				   if(index==Mode.FREQUENCY)
				   {
					   sample.information.push(temp);
					   temp = new Vector.<ByteArray>();
					   index = 0;
				   }
				   var bytes:ByteArray = new ByteArray();
			       sound.extract(bytes, Mode.extractLength);
				   bytes.position = 0;
                   if(bytes.bytesAvailable<Mode.currentMeasure)
				      bytes.length = Mode.currentMeasure;
				   temp.push(bytes);
				   positionCur += Mode.extractLength;
				   index++;
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
				
			        sample.information.push(temp);
			   }
			   
			    sample.x = movieStart.x;
	            sample.y = movieStart.y+5;
		        mainField.addChild(sample);
			    var currentNum:uint = startNum;
		        for (var i:uint=0; i<sample.length; i++)
		        {
			       (mainField.getChildByName("cell" + currentNum.toString()) as Cell).info = sample.information[i];
			       currentNum = currentNum + (mainField.rowNum-1);
		        }
			    sample.startMovie = startNum;
		   	   
		       counter++;
			   if(counter < data.length)
			   {
			      var ar:Array  = data[counter].toString().split(",");
			      movieStart = mainField.getChildByName("cell"+ar[0]) as Cell;
			      movieStart.url = ar[1];
			      movieStart.title = ar[2];
			      movieStart.length = ar[3];
			      movieStart.instrument = ar[4];
			      movieStart.using = ar[5];
		         	

		          sample = new Sample(ar[2],ar[1],ar[3],ar[4], ar[5]);
		          startNum = ar[0];
		          sound = new Sound();
		          sound.addEventListener(Event.COMPLETE, ExtractMP3);
		          sound.addEventListener(IOErrorEvent.IO_ERROR, IOerror);
				  var ref:String = ar[1].toString();
	              sound.load(new URLRequest(ref));
	              
			   }
			   else
			   {
			    	mainMusic.scrollPanel.source = mainField;
					mainMusic.mainField = mainField;
					mainField.gotoBegin();
					main = mainMusic.parent as Main;
			        Key.HideKey(main);
			   }
			}
			catch(ex:Error)
			{
			    Key.HideKey(main);
				var attention:Attention = new Attention("Ошибка при распаковке", mainMusic.parent as Main);
			    attention.Show();
				return;
			}
			
		}
		
		
		
		private static function IOerror(e:IOErrorEvent)
		{
			 Key.HideKey(main);
			 var attention:Attention = new Attention("Сервер недоступен", mainMusic.parent as Main);
			 attention.Show();
		}
		

	}
	
}
