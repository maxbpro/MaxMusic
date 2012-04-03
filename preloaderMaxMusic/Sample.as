package  
{
	
	import flash.display.MovieClip;
	import flash.display.Graphics;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilter;
	
	public class Sample extends MovieClip 
	{
		private const startColor = 0x888888;
		
		public function Sample(length:uint, myColor1, myColor2) 
		{
			var g:Graphics = this.graphics;

			var colors:Array = [myColor1, myColor1 + 117500];
			trace(colors[0]);
			g.beginGradientFill(GradientType.LINEAR, colors, [1, 0.75], [0, 255]);   
			g.drawRect(0,0,50*length, 40);
			alpha = 0;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event)
		{
			alpha+=0.05;
			if(alpha>1)
			  removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
	
}
