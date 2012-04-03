package com 
{
	import flash.display.Bitmap;
	import flash.display.*;
	import flash.events.*;
    import flash.net.*;
    import com.preloader.Preloader;
    import flash.geom.ColorTransform;
	
	public class MainClass extends MovieClip
	{
		private var main:Preloader = null;
		private var localY:uint = 60;
        private var localX:uint = 50;
		
		private var isDrawing1:Boolean = false;
		private var isDrawing2:Boolean = false;
		private var isDrawing3:Boolean = false;
		private var isDrawing4:Boolean = false;
		private var isDrawing5:Boolean = false;
		private var isDrawing6:Boolean = false;
		private var isDrawing7:Boolean = false;
		private var isDrawing8:Boolean = false;

		public function MainClass() 
		{
			
			addEventListener(Event.ADDED_TO_STAGE, Added);
		}

		private function Added(e:Event) 
		{
            this.main = root as Preloader;
			var loader:Loader = new Loader();
      	    loader.contentLoaderInfo.addEventListener(Event.COMPLETE, Init);
	        loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressOfLoading);
	        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            loader.load(new URLRequest("http://cs5940.vk.com/u19543977/3821f903d09e08.zip"));
		}
		
		private function progressOfLoading(e:ProgressEvent)
		{
			var percent = Math.round(100*(e.bytesLoaded/e.bytesTotal));
			var sample:Sample = null;
			var myColor1;
			var myColor2;
			if(isDrawing8 == false && percent>87.5)
			{
				 myColor1 = Math.random() * 0xFFFFFF;
                 myColor2 = Math.random() * 0xFFFFFF;
											
				sample = new Sample(5, myColor1,myColor2);
				sample.x = localX+400;
				sample.y = localY;
				main.mainField.addChild(sample);
			    localY+=50;
				localX = 50;
				isDrawing8 = true;
			}
			else
			{
				if(isDrawing7 == false && percent>(100 - 12.5*2))
				{
					                        myColor1 = Math.random() * 0xFFFFFF;
                                            myColor2 = Math.random() * 0xFFFFFF;
											
										    sample = new Sample(5, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += (sample.width+50);
											sample = new Sample(7, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											
								
											
											
											localY+=50;
											localX = 50;
											isDrawing7 = true;
				}
				else
				{
					if(isDrawing6 == false && percent>(100 - 12.5*3))
					{
						 myColor1 = Math.random() * 0xFFFFFF;
                                            myColor2 = Math.random() * 0xFFFFFF;
											
										    sample = new Sample(1, myColor1,myColor2);
											sample.x = localX+300;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += (sample.width+300);
											sample = new Sample(3, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += sample.width+50;
											
								
											
											
											localY+=50;
											localX = 50;
											isDrawing6 = true;
					}
					else
					{
						if(isDrawing5 == false && percent>(100 - 12.5*4))
						{
							                myColor1 = Math.random() * 0xFFFFFF;
                                            myColor2 = Math.random() * 0xFFFFFF;
											
										    sample = new Sample(1, myColor1,myColor2);
											sample.x = localX+250;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += (sample.width+250);
											sample = new Sample(2, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += sample.width+50;
											sample = new Sample(4, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
								
											
											
											localY+=50;
											localX = 50;
											isDrawing5 = true;
						}
						else
						{
							if(isDrawing4 == false && percent>(100 - 12.5*5))
							{
								            myColor1 = Math.random() * 0xFFFFFF;
                                            myColor2 = Math.random() * 0xFFFFFF;
											
										    sample = new Sample(7, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += (sample.width+50);
											sample = new Sample(3, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += sample.width+50;
											sample = new Sample(2, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
								
											
											
											localY+=50;
											localX = 50;
											isDrawing4 = true;
							}
							else
							{
								if(isDrawing3 == false && percent>(100 - 12.5*6))
								{
									        myColor1 = Math.random() * 0xFFFFFF;
                                            myColor2 = Math.random() * 0xFFFFFF;
											
										    sample = new Sample(1, myColor1,myColor2);
											sample.x = localX+100;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += (sample.width+150);
											sample = new Sample(3, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += sample.width+100;
											sample = new Sample(2, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
								
											
											
											localY+=50;
											localX = 50;
											isDrawing3 = true;
								}
								else
								{
									if(isDrawing2 == false && percent>(100 - 12.5*7))
									{

                                            myColor1 = Math.random() * 0xFFFFFF;
                                            myColor2 = Math.random() * 0xFFFFFF;
											
										    sample = new Sample(1, myColor1,myColor2);
											sample.x = localX+50;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += (sample.width+50);
											sample = new Sample(6, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += sample.width+50;
											sample = new Sample(4, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
								
											
											
											localY+=50;
											localX = 50;
											isDrawing2 = true;
									}
									else
									{
										if(isDrawing1 == false && percent>(100 - 12.5*8))
										{
											
                                            myColor1 = Math.random() * 0xFFFFFF;
                                            myColor2 = Math.random() * 0xFFFFFF;
											sample = new Sample(4, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += sample.width;
											sample = new Sample(1, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += sample.width;
											sample = new Sample(4, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += sample.width;
											sample = new Sample(3, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											localX += sample.width;
											sample = new Sample(2, myColor1,myColor2);
											sample.x = localX;
											sample.y = localY;
											main.mainField.addChild(sample);
											
											
											localY+=50;
											localX = 50;
											isDrawing1 = true;
										}
									}
								}
							}
					
						}
					}
				}
			}
		}
		
		private function ioErrorHandler(e:IOErrorEvent)
		{
			trace(e.text);
		}
		
		private function Init(e:Event)
		{
		   try
		   {
			   var game:MovieClip = e.target.content;
			   game.x = -0.5; game.y = -1;
			   addChild(game);
		   }
		   catch(ex:Error)
		   {
			   trace(ex.message);
		   }
		}

	}
}
