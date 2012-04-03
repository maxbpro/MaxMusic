package MusicEditPackage.Field
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.text.engine.TextLine;
	import flash.ui.Keyboard;
	import flash.display.DisplayObject;
	
	
	public class MainField extends MovieClip 
	{
		private static const WEITHOfCell:uint = 50;
		private static const HIGHTOfCell:uint = 40;
		
		public var columnNum:uint = 0;
		public var rowNum:uint = 0;
		public var line:Line;
		
		private var localX:uint = 0;
		private var localY:uint = 0;
		private var counterForCell:uint = 0;
		private var temp:CellTitle = null;
		private var stageX:Number = 0;
		private var stageY:Number = 0;
		
		// Initialization
		public function MainField(column:uint, row:uint) 
		{
			this.columnNum = column;
			this.rowNum = row;
			localX = 0 ; 
			localY = 0;
			counterForCell = 0;
			line = Line.getInstance();
			line.x = 47;
			line.y = 0;
			for (var i:uint=0; i<column; i++)
			{
				for (var j:uint=0; j<row; j++)
				{
					if(j==0 && i!=0)
					{
						temp = new CellTitle(i, line);
						temp.addEventListener(MouseEvent.CLICK, PositionChanged);
						temp.txt.text = (i).toString();
					    temp.x = localX;
				        temp.y = localY;
					    addChild(temp);
					}
					else
					{
					   if(i==0 && j!=0)
					   {
						   temp = new CellTitle(0);
						   temp.txt.x -= 10;
						   temp.txt.text = String.fromCharCode(j+64);
						   temp.x = localX;
				           temp.y = localY;
						   temp.removeEventListener(MouseEvent.ROLL_OVER, temp.RollOverHandler);
						   temp.removeEventListener(MouseEvent.ROLL_OUT, temp.RollOutHandler);
					       addChild(temp);
				   	   }
					   else
					   {
						   if( i == 0 && j== 0)
						   {
						      temp = new CellTitle(0);
						      temp.x = localX;
				              temp.y = localY;
					          addChild(temp);
						   }
						   else
						   {
							  var temp1:Cell = new Cell();
						      temp1.name = "cell" + counterForCell.toString();
						      counterForCell++;
						      temp1.x = localX;
				              temp1.y = localY;
							  temp1.rowNum = j;
					          addChild(temp1);
						   }
					   }
					}  
					localY += HIGHTOfCell;
				}
				localX += WEITHOfCell;
				localY = 0;
			}
			addEventListener(Event.ADDED, AddedSample);
			addChild(line);
		}
		
		// adding column into mainField
		public function ColumnAdd()
		{
            if(counterForCell<800)
			{
			   for (var j:uint=0; j<rowNum; j++)
			   {
				   if(j==0)
				   {
					   var temp:CellTitle = new CellTitle(columnNum, line);
					   temp.addEventListener(MouseEvent.CLICK, PositionChanged);
					   temp.txt.text = (columnNum).toString();
				       temp.x = localX;
			           temp.y = localY;
				       addChild(temp);
				   }
				   else
				   {
					   var temp1:Cell = new Cell();
					   temp1.name = "cell" + counterForCell.toString();
				       counterForCell++;
				       temp1.x = localX;
				       temp1.y = localY;
					   addChild(temp1);
				   }
				   localY += HIGHTOfCell;
			   }
			   localX += WEITHOfCell;
			   localY = 0;
			   columnNum++;
			   background.width += 50;
			}
		}
		
		private function AddedSample(e:Event)
		{
			main = root as Main;
			var sample:Sample  = e.target as Sample;
			if(sample != null)
			{
				sample.name = e.target.title;
				sample.addEventListener(MouseEvent.MOUSE_DOWN, StartDrag);
				sample.addEventListener(MouseEvent.MOUSE_UP, StopDrag);
				sample.addEventListener(KeyboardEvent.KEY_UP, SampleKeyUpHandler);
				sample.removeEventListener(KeyboardEvent.KEY_UP, sample.RemoveFromMain);
				for(var i:uint=0; i<sample.numChildren; i++)
				{
					var obj:DisplayObjectContainer = sample.getChildAt(i) as DisplayObjectContainer;
					if(obj != null)
						obj.mouseChildren = false;
				}
				sample.CreateInsideCells();
				sample.addEventListener(MouseEvent.ROLL_OVER, sampleCoordSearch);
			}
		}
		
		private var contentOfCell:Boolean = false;
		
		private function StartDrag(e:MouseEvent)
		{
			var sample:Sample = e.currentTarget as Sample;
			setChildIndex(sample,numChildren-1);
			sample.startDrag();
		}
		
		private function StopDrag(e:MouseEvent)
		{
			var sample:Sample = e.currentTarget as Sample;
			sample.stopDrag();
			
			var movieOld:Cell = getChildByName("cell" + sample.startMovie.toString()) as Cell;
			var movieCurrent:Cell = e.currentTarget.dropTarget.parent.parent as Cell;
			if(movieCurrent != null)
			{   
			   //  проверка на перенесенный
			    var ar:Array = movieCurrent.name.split("cell");
			    var currentNum1:uint = ar[1];
			    ar = e.target.name.split("insideCell");
			    var position:uint = ar[1];
			    var startNum:uint = currentNum1 - position *(rowNum-1);
				var currentNum:uint = startNum;
				
				var sameRow:Boolean = false;
				if(movieCurrent.rowNum == movieOld.rowNum)
				{
				   sameRow = true;
				   var ignorNumRight:uint = startNum;
				   var ignorNumLeft:uint = startNum;
				   var s:uint = (currentNum1-sample.startMovie)/(rowNum-1);
				   var y:uint = sample.length - s;
				   var ignorLimitRight:uint = currentNum1 + (y-1) * (rowNum-1);
				   var ignorLimitLeft:uint = currentNum1 - (y-1) * (rowNum-1);
				}
				
	            // проверка на первый 
	            var movieStart:Cell = getChildByName("cell" + startNum.toString()) as Cell;
				if(movieStart != null)
				{
			         // проверка на content
				   if( sameRow == true)
				   {
					  for(var i:uint=0; i<sample.length; i++)
		              {
						  if ( currentNum != ignorNumRight && currentNum != ignorNumLeft)
						  {
					         movieCurrent = getChildByName("cell" + currentNum.toString()) as Cell;
		                     if(movieCurrent.info != null)
			                 {
				                var b:Cell = getChildByName("cell" + currentNum.toString()) as Cell;
				                contentOfCell = true;
			                    break;
		                     }
						  }
					
			              currentNum = currentNum + (rowNum-1);
					      if( ignorNumRight<ignorLimitRight)
					         ignorNumRight = ignorNumRight + (rowNum-1);
						  if( ignorNumLeft>ignorLimitLeft)
					         ignorNumLeft = ignorNumLeft - (rowNum-1);
		              } 
				   }
				   else
				   {
					  for(var i:uint=0; i<sample.length; i++)
		              {
					      movieCurrent = getChildByName("cell" + currentNum.toString()) as Cell;
		                  if(movieCurrent.info != null)
			              {
				             contentOfCell = true;
			                 break;
		                  }
					
			             currentNum = currentNum + (rowNum-1);
		              }
				   }
			        
 
				   
			       if(contentOfCell == false)
			       {
					   // clear prev
					   var currentNumForRemoving = sample.startMovie;
					   var movieForClear:Cell = getChildByName("cell" + currentNumForRemoving.toString()) as Cell;
					   movieForClear.url = null;
					   movieForClear.length = 0;
					   movieForClear.title = null;
					   movieForClear.instrument = 0;
			           for (var i:uint=0; i<sample.length; i++)
			           {
			               var mv:Cell = getChildByName("cell" + currentNumForRemoving.toString()) as Cell;
			               mv.info = null;
			               currentNumForRemoving = currentNumForRemoving + (rowNum-1);
			           }
					   
				       //adding new
			           sample.x = movieStart.x;
			           sample.y = movieStart.y+5;
					   movieStart.url = sample.url;
					   movieStart.title = sample.title;
				       movieStart.length = sample.length;
				       movieStart.instrument = sample.instrument;
					   movieStart.using = sample.using;
			           addChild(sample);
			  
			           for (i = 0; i<sample.length; i++)
			           {
	                       (getChildByName("cell" + startNum.toString()) as Cell).info = sample.information[i];
		                    startNum = startNum + (rowNum-1);
	                   }
			          
				  
				  
					  
					   var movie:Cell = e.currentTarget.dropTarget.parent.parent as Cell;
		               var ar:Array = movie.name.split("cell");
			           sample.startMovie = ar[1] - position*(rowNum-1);
			          
			       }
			       else
			       {
				      sample.x = movieOld.x;
				      sample.y = movieOld.y+5;
			       }
				}
				else
				{
				    sample.x = movieOld.x;
				    sample.y = movieOld.y+5;
					
				}
			}
			else
			{
				if((e.currentTarget.dropTarget as TextLine)!= null)
				{
					   removeChild(sample);
						// clear 
					   var currentNumForRemoving:uint = sample.startMovie;
					   var movieForClear:Cell = getChildByName("cell" + currentNumForRemoving.toString()) as Cell;
					   movieForClear.url = null;
					   movieForClear.length = 0;
					   movieForClear.title = null;
					   movieForClear.instrument = 0;
			           for (var i:uint=0; i<sample.length; i++)
			           {
			               var mv:Cell = getChildByName("cell" + currentNumForRemoving.toString()) as Cell;
			               mv.info = null;
			               currentNumForRemoving = currentNumForRemoving + (rowNum-1);
			           }
				}
				else
				{
				   sample.x = movieOld.x;
				   sample.y = movieOld.y+5;
				}
			}
		}
		
		private function SampleKeyUpHandler(e:KeyboardEvent)
		{
			if(e.keyCode == Keyboard.DELETE || e.keyCode == Keyboard.BACKSPACE)
			{
				 var sample:Sample = e.currentTarget as Sample;
				 if(sample != null)
				 {
				    removeChild(sample);
				    // clear 
			        var currentNumForRemoving:uint = sample.startMovie;
				    (getChildByName("cell" + currentNumForRemoving.toString()) as Cell).url = null;
		            for (var i:uint=0; i<sample.length; i++)
	                {
		                  var mv:Cell = getChildByName("cell" + currentNumForRemoving.toString()) as Cell;
		                  mv.info = null;
		                  currentNumForRemoving = currentNumForRemoving + (rowNum-1);
	                }
				    sample = null;
				 }
					   
			}
			else
			{
				if(e.ctrlKey==true && e.keyCode == Keyboard.C)
				{
					 var oldsample:Sample = e.currentTarget as Sample;
					 var sample:Sample = new Sample(oldsample.title, oldsample.url,oldsample.length,oldsample.instrument,oldsample.using);
					 sample.x = stageX-10;
			         sample.y = stageY-15;
			         main.addChild(sample);
					 sample.addEventListener(KeyboardEvent.KEY_UP, sample.RemoveFromMain);
			         sample.addEventListener(MouseEvent.CLICK, CopyEnd);
				     sample.startDrag();
				}
			}
		}
		
		private function CopyEnd(e:MouseEvent)
		{
			var sample:Sample = e.currentTarget as Sample;
			var contentOfCell:Boolean = false;
			sample.stopDrag();
			var movieStart:Cell = e.currentTarget.dropTarget.parent.parent as Cell;
			if(movieStart != null)
			{ 
			   var ar:Array = movieStart.name.split("cell");
			   var startNum:uint = ar[1];
			   var currentNum:uint = startNum;
			   for(var i:uint=0; i<sample.length; i++)
			   {
				   var mv:Cell = getChildByName("cell" + currentNum.toString()) as Cell;  
				   // Проверка на добавление ячеек
				   if(mv == null )
		           {
			           ColumnAdd();
				       mv = getChildByName("cell" + currentNum.toString()) as Cell;
			       }
				   if(mv.info != null)
				   {
				       contentOfCell = true;
				       break;
				   }
				   
				   currentNum = currentNum + rowNum-1;
			   }
			   
			   if(contentOfCell == false)
			   {
				   sample.StartDownload(startNum, this);
				   sample.removeEventListener(MouseEvent.CLICK, CopyEnd);
			   }
			   else
			   {
			      main.removeChild(sample);
				  sample.addEventListener(MouseEvent.CLICK, CopyEnd);   
			   }
			}
			else
			{
			    main.removeChild(sample);
				sample.addEventListener(MouseEvent.CLICK, CopyEnd);
			}
			
			
			
		}
		
		public function TransferTwoStop(sample:Sample, startNum:uint)
		{
			var movieStart:Cell =  getChildByName("cell" + startNum.toString()) as Cell;  
			sample.x = movieStart.x;
			sample.y = movieStart.y+5;
			addChild(sample);
			if(contains_my(main,sample))
			  main.removeChild(sample);
			var currentNum:uint = startNum;
			for (var i:uint=0; i<sample.length; i++)
			{
				(getChildByName("cell" + currentNum.toString()) as Cell).info = sample.information[i];
			    currentNum = currentNum + rowNum-1;
			}
	
			movieStart.url = sample.url;
			movieStart.title = sample.title;
			movieStart.length = sample.length;
			movieStart.instrument = sample.instrument;
			movieStart.using = sample.using;
			
			sample.removeEventListener(KeyboardEvent.KEY_UP, sample.RemoveFromMain);
		}
		
		
		
		private function contains_my(container : DisplayObjectContainer, child :DisplayObject) : Boolean 
		{
            return child.parent == container;
        }
		
		
		
		public function gotoRight()
		{
			if(line.x < (columnNum-1)*WEITHOfCell)
			{ 
			   setChildIndex(line,numChildren-1);
			   line.position++;
			   line.x = line.position*WEITHOfCell;
			   (scrollPanel.parent as MusicEdit).infoPanel.position.text = line.position;
			}
		}
		
		public function gotoLeft()
		{
			if(line.x>50)
			{
			    setChildIndex(line,numChildren-1);
				line.position--;
				line.x = line.position*WEITHOfCell;
				(scrollPanel.parent as MusicEdit).infoPanel.position.text = line.position;
			}
			
		}
		
		public function gotoBegin()
		{
			  setChildIndex(line,numChildren-1);
			  line.x = 47;
			  line.position=1;
			  scrollPanel.horizontalScrollPosition = 0;
			  (scrollPanel.parent as MusicEdit).infoPanel.position.text = line.position;
		}
		
		public function gotoEnd()
		{
			setChildIndex(line,numChildren-1);
			line.x = columnNum*WEITHOfCell;
			line.position=columnNum;
			scrollPanel.horizontalScrollPosition  = scrollPanel.maxHorizontalScrollPosition ;
			(scrollPanel.parent as MusicEdit).infoPanel.position.text = line.position;
		}
		
		public function getLinePosition()
		{
			return line.position;
		}
		
		public var counterForLinePosition = 0;
		
		public function playLeft()
		{
			var step:Number = Mode.step;
			if(line.x<columnNum*WEITHOfCell)
			{
			   if(line.x>650/2)
			   {
				    if(scrollPanel.horizontalScrollPosition < scrollPanel.maxHorizontalScrollPosition)
				    {
				       scrollPanel.horizontalScrollPosition += step;
					   setChildIndex(line,numChildren-1);
			           line.x += step;
					   if(counterForLinePosition==Mode.FREQUENCY)
					   {
						   line.position++;
					      
						   counterForLinePosition = 0;
					   }
					   counterForLinePosition++;
				    }
				    else
				    {
					    setChildIndex(line,numChildren-1);
			            line.x += step;
					    if(counterForLinePosition==Mode.FREQUENCY)
					    {
						   line.position++;
						   counterForLinePosition = 0;
					    }
					    counterForLinePosition++;
				    }
			   }
			   else
			   {
				   setChildIndex(line,numChildren-1);
			       line.x += step;
				   if(counterForLinePosition==Mode.FREQUENCY)
				   {
					   line.position++;
					   counterForLinePosition = 0;
				   }
				   counterForLinePosition++;
			   }
			   (scrollPanel.parent as MusicEdit).infoPanel.position.text = line.position;
			   
			}
		}
		
		private function PositionChanged(e:MouseEvent)
		{
			line.position = (e.currentTarget as CellTitle).column;
			line.x = line.position*WEITHOfCell;
			(scrollPanel.parent as MusicEdit).infoPanel.position.text = line.position;
		}
		
		private function sampleCoordSearch(e:MouseEvent)
		{
			stageX = e.stageX;
			stageY = e.stageY;
		}
		
	}
	
}
