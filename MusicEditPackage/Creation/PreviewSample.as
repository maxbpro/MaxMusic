package MusicEditPackage.Creation
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.*;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	public class PreviewSample extends MovieClip 
	{
		private var length:int = -1;
		private var title:String = "";
		private var url:String = "";
		private var instrument:uint = 0;
		
		private var panel:panelSample = null;
		public var sample:Sample = null;
		private var flagShowPanel:Boolean = false;
		private var contentOfCell:Boolean = false;
		public var using:String = null;
		private var  sound:Sound = null;
		
		public function PreviewSample(title:String, url:String, length:int, mainMusic:MusicEdit, instrument:uint, using:String) 
		{
			this.title = title;
			this.url = url;
			this.length = length;
			this.mainMusic = mainMusic;
			this.instrument = instrument;
			this.using = using;
			var colors:Array = MainSamplesPanel.GetColor(instrument);
			this.graphics.beginGradientFill(GradientType.LINEAR, colors, [1,1], [0,255]);   
			this.graphics.drawRect(0,0, length*50, 30);
			this.alpha = 0.8;
			addEventListener(MouseEvent.ROLL_OVER, over);
			addEventListener(MouseEvent.ROLL_OUT, out);
			addEventListener(MouseEvent.MOUSE_DOWN, TransferStart);
			addEventListener(Event.ADDED_TO_STAGE, Added);
		}
		
		private function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			main = root as Main;
			if(using == "close")
			{
				var lockclose:LockClose = new LockClose();
				lockclose.x = length * 50 - 37;
				lockclose.y = 2;
				lockclose.mouseEnabled = false;
				lockclose.alpha = 0.75;
				addChildAt(lockclose, getChildIndex(txt));
			}
			else
			{
				if(using == "open")
				{
					var lockopen:LockOpen = new LockOpen();
					lockopen.x = length*50 - 37;
					lockopen.y = 2;
					lockopen.mouseEnabled = false;
					lockopen.alpha = 0.75;
					addChildAt(lockopen, getChildIndex(txt));
				}
			}
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
			
			
			 
		}
		
		private function over(e:MouseEvent)
		{
			if(flagShowPanel==false)
			{
			   panel = new panelSample(title, url, length, this, instrument);
			   panel.y = (e.stageY - e.localY) + 25;
			   panel.x = (e.stageX - e.localX);
			  
               panel.addEventListener(MouseEvent.ROLL_OUT, PanelRollOut);
			   main.addChild(panel);
			   sample = new Sample(title, url, length, instrument, using);
			   flagShowPanel = true;
			  
			}
			
			// Свечение 
			var myFilters:Array = new Array();
			var effect:BitmapFilter = new GlowFilter(0xFFFF33, 0.75, 13,13,2,1,false,false);
            myFilters.push(effect);
            this.filters = myFilters;
			buttonMode = true;
		}
		
		private function out(e:MouseEvent)
		{
			if (e.relatedObject != null  &&  !(e.relatedObject is panelSample))
			{
				if(main.contains(panel))
		     	   main.removeChild(panel);
				panel = null;
				flagShowPanel = false;
				this.filters = null;
				buttonMode = false;
			}
		}
		
		private function PanelRollOut (e:MouseEvent)
		{
			if(main.contains(panel))
			   main.removeChild(panel);
			panel = null;
			flagShowPanel = false;
		    this.filters = null;
		}
		
		private function TransferStart(e:MouseEvent)
		{
			if(MainSamplesPanel.currentStyleIsReal)
			{
				if(using != "close")
				{
			       sample.x = e.stageX-10;
			       sample.y = e.stageY-15;
			       main.addChild(sample);
			       sample.addEventListener(MouseEvent.MOUSE_UP, TransferOneStop);
				   sample.startDrag();
				}
				else
				{
					var attention:Attention = new Attention("Сэмпл закрыт!",main);
				    attention.Show();
				}
			}
			else
			{
				var attention:Attention = new Attention("Для использования этих сэмплов нужно создать проект другого стиля (жанра)",main);
				attention.Show();
			}
		}
		
		
		
		private function TransferOneStop(e:MouseEvent)
		{
			contentOfCell = false;
			sample.stopDrag();
			var movieStart:Cell = e.currentTarget.dropTarget.parent.parent as Cell;
			if(movieStart != null)
			{ 
			   var ar:Array = movieStart.name.split("cell");
			   var startNum:uint = ar[1];
			   var currentNum:uint = startNum;
			   for(var i:uint=0; i<sample.length; i++)
			   {
				   var mv:Cell = mainMusic.mainField.getChildByName("cell" + currentNum.toString()) as Cell;  
				   // Проверка на добавление ячеек
				   if(mv == null )
		           {
			           mainMusic.mainField.ColumnAdd();
				       mv = mainMusic.mainField.getChildByName("cell" + currentNum.toString()) as Cell;
			       }
				   if(mv.info != null)
				   {
				       contentOfCell = true;
				       break;
				   }
				   
				   currentNum = currentNum + (mainMusic.mainField.rowNum-1);
			   }
			   
			   if(contentOfCell == false)
			   {
				   sample.StartDownload(startNum, this);
			       sample.removeEventListener(MouseEvent.MOUSE_UP, TransferOneStop);
			       sample.removeEventListener(MouseEvent.MOUSE_DOWN, TransferStart);
			   }
			   else
			   {
				   if (contains_my(main, sample))
				   {
				      main.removeChild(sample);
				   }
			   }
			}
			else
			{
				if (contains_my(main, sample))
				{
				   main.removeChild(sample);
				}
			}
		}
		
		
		public function TransferTwoStop(sample:Sample, startNum:uint)
		{
			var movieStart:Cell =  mainMusic.mainField.getChildByName("cell" + startNum.toString()) as Cell;  
			sample.x = movieStart.x;
			sample.y = movieStart.y+5;
			mainMusic.mainField.addChild(sample);
			if(contains_my(main,sample))
			  main.removeChild(sample);
			var currentNum:uint = startNum;
			for (var i:uint=0; i<sample.length; i++)
			{
				(mainMusic.mainField.getChildByName("cell" + currentNum.toString()) as Cell).info = sample.information[i];
			    currentNum = currentNum + (mainMusic.mainField.rowNum-1);
			}
	
			movieStart.url = sample.url;
			movieStart.title = sample.title;
			movieStart.length = sample.length;
			movieStart.instrument = sample.instrument;
			movieStart.using = sample.using;
		}
		
		
		
		private function contains_my(container : DisplayObjectContainer, child : DisplayObject) : Boolean 
		{
            return child.parent == container;
        }
								
		
		
	}
	
}
