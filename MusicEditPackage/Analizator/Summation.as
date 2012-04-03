package MusicEditPackage.Analizator 
{
	import flash.utils.ByteArray;
	import MusicEditPackage.Field.*;
	import MusicEditPackage.*;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.media.*;
	import flash.display.Shape;
	import flash.utils.Timer;
	
	public class Summation  
	{
		public static var outputSignal:Vector.<Vector.<ByteArray>> = null;
		private static var counter:uint=0;
		private static var i:uint = 0;
		private static var mainField:MainField = null;
		private static var mainMusic:MusicEdit = null;
		public static var soundChannel:SoundChannel = null;
		
		public function Summation() 
		{
		
		}
		
		
		public static function Mix(field:MainField)
		{
			mainField = field;
			outputSignal = new Vector.<Vector.<ByteArray>>();
			counter = (field.getLinePosition()-1)*(field.rowNum-1);
			i = field.getLinePosition();
			mainField.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private static function onEnterFrame(e:Event)
		{
			try
			{
				if(i==mainField.columnNum)
				{
					mainField.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					(mainField.root as Main).MusicEditMovie.Play();
				}
				else
				{
					var currentMeasure:Vector.<ByteArray> = new Vector.<ByteArray>(Mode.FREQUENCY);
				    for(var v:uint=0; v<Mode.FREQUENCY; v++)
				    {
				       currentMeasure[v] = new ByteArray();
				       currentMeasure[v].length = Mode.currentMeasure;
			        }

				    for (var j:uint=0; j<mainField.rowNum-1; j++)
				    {   
				         if( (mainField.getChildByName("cell"+counter) as Cell).info!= null)
					     {		
					         var addingCell:Cell = mainField.getChildByName("cell"+counter) as Cell;
						     for (var z:uint = 0; z < addingCell.info.length; z++)
						     {
							  
							     currentMeasure[z] = summatorByteArrays( currentMeasure[z] , addingCell.info[z]);
						     }
					     }
					     counter++;
				    }
                    outputSignal.push(currentMeasure);
				}
				i++; 
			}
			catch(ex:Error)
			{
				var attention:Attention = new Attention("Ошибка при суммировании сигнала",mainField.root as Main);
				attention.Show();
				return;
			}
		}
		
		
		
		private static function summatorByteArrays(a:ByteArray, b:ByteArray):ByteArray
		{
			var ar:ByteArray = new ByteArray();
			ar.position=0; a.position=0; b.position=0;

			while(ar.position<b.length  )
			{
				ar.writeFloat(a.readFloat()+b.readFloat());
			}
			ar.position=0;
			return ar;
		}
		
		private static var currentMeasure:Vector.<ByteArray> = new Vector.<ByteArray>();
		private static var counterCurrentMeasure:uint = 0;
		private static var counterPartOfCurrentMeasure:uint = 0;
		
		
		
		public static function PlayDinamic(output: Vector.<Vector.<ByteArray>>, mainMusicPar:MusicEdit)
		{
			try
			{
			   mainMusic = mainMusicPar;
			   soundChannel = new SoundChannel();
			   outputSignal = output;
			   counterCurrentMeasure = 0;
			   counterPartOfCurrentMeasure = 0;
			   var sound:Sound = new Sound();
			   currentMeasure = outputSignal[counterCurrentMeasure];
			   mainField.setChildIndex(mainField.line, mainField.numChildren-1);
			   //mainField.line.x-=25;
			   mainField.line.Active();
			   sound.addEventListener(SampleDataEvent.SAMPLE_DATA, SampleDataHandler);
               soundChannel = sound.play();
			   mainMusic.PauseShow();
			   mainField.counterForLinePosition = 0;
			   soundChannel.addEventListener(Event.SOUND_COMPLETE, SoundCompleteHandler);
			}
			catch(ex:Error)
			{
				var attention:Attention = new Attention("Ошибка при воспроизведении",mainField.root as Main);
				attention.Show();
				return;
			}
		}
		
		

		private static function SampleDataHandler (e:SampleDataEvent)
		{
			try
			{
			   if (counterCurrentMeasure < outputSignal.length)
			   {
				   var bytes:ByteArray = new ByteArray();
				   bytes = currentMeasure[counterPartOfCurrentMeasure];
				   counterPartOfCurrentMeasure++;
                   mainField.playLeft();
				   e.data.writeBytes(bytes);
				   if( counterPartOfCurrentMeasure == Mode.FREQUENCY)
			       {
					   counterCurrentMeasure++;
					   counterPartOfCurrentMeasure = 0;
					   if(counterCurrentMeasure != outputSignal.length)
				       {
					      currentMeasure = outputSignal[counterCurrentMeasure];
					   }
				   }
				
			   }
			}
			catch(ex:Error)
			{
				var attention:Attention = new Attention("Ошибка при воспроизведении",mainField.root as Main);
				attention.Show();
				return;
			}
		}
		
		private static function SoundCompleteHandler(e:Event)
		{
			mainMusic.PauseHide();
			mainField.line.Deactive();
			 //mainField.playLeft();
			 //mainField.playLeft();
		}
		
		public static function Stop()
		{
			soundChannel.stop();
			mainMusic.PauseHide();
			mainField.line.Deactive();
		}
		
		public static var bytes:ByteArray = null
		
		
		public static function GetBytesFinal(field:MainField)
		{
			 bytes = new ByteArray();
			 counter = 0;
             i = 0;
             mainField = field;
			 mainField.addEventListener(Event.ENTER_FRAME, onEnterFrame2);
		}
		
		private static function onEnterFrame2(e:Event)
		{
			
			if(i == mainField.columnNum-1)
			{
				mainField.removeEventListener(Event.ENTER_FRAME, onEnterFrame2);
				(mainField.root as Main).MusicEditMovie.winSending.Mp3Convert();
			}
			else
			{
				try
				{
			       var currentMeasure:Vector.<ByteArray> = new Vector.<ByteArray>(Mode.FREQUENCY);
				   for(var v:uint=0; v<Mode.FREQUENCY; v++)
				   {
				      currentMeasure[v] = new ByteArray();
				      currentMeasure[v].length = Mode.currentMeasure;
			       }

				   for (var j:uint=0; j<mainField.rowNum-1; j++)
				   {   
				         if( (mainField.getChildByName("cell"+counter) as Cell).info!= null)
					     {		
					         var addingCell:Cell = mainField.getChildByName("cell"+counter) as Cell;
						     for (var z:uint = 0; z < addingCell.info.length; z++)
						     {
							  
							     currentMeasure[z] = summatorByteArrays( currentMeasure[z] , addingCell.info[z]);
						     }
					     }
					     counter++;
				   }
				   for(v = 0; v<Mode.FREQUENCY; v++)
				   {
					   var temp:ByteArray = new ByteArray();
					   currentMeasure[v].readBytes(temp);
				       bytes.writeBytes(temp);
				   }
				}
				catch(ex:Error)
			    {
				   var attention:Attention = new Attention("Ошибка при воспроизведении",mainField.root as Main);
				   attention.Show();
				   return;
			    }
			}
			i++;

		}
		
		
		
		
		
		
	}
	
}
