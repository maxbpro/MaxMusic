package MusicEditPackage.Field
{
	
	import flash.display.*;
	import flash.filters.*;
	import flash.events.*;
	
	
	public class Line extends MovieClip 
	{
		private var pos:uint = 1;
		private var canvas:Shape = null;
		private static var line:Line = null;
		
		private function Line() 
		{
			line = new Line();
			addEventListener(MouseEvent.MOUSE_OVER, over);
			addEventListener(MouseEvent.MOUSE_OUT, out);
		}
		
		public static function getInstance()
		{
			if(line==null)
			  return new Line();
			else
			  return line;  
		}
		
		
		public function set position(value)
		{
			if(value>0)
			  pos = value;
		}
		
		public function get position()
		{
			return pos;
		}
		
		
		
		public function Active()
		{
			 canvas = new Shape();
			 addChild(canvas);
             canvas.graphics.beginFill(0xFFFFFF, 1);
			 canvas.graphics.drawRect(0,0,2, height);
			 var myFilters:Array = new Array();
	         var effect:BitmapFilter = new GlowFilter(0xFFCC66, 0.75, 25,13,2,1,false,false);
             myFilters.push(effect);
             this.filters = myFilters;
		}
		
		public function Deactive()
		{
			canvas.graphics.clear();
			this.filters = null;
		}
		
		private function over(e:MouseEvent)
		{
			ShineWhiteActive();
		}
		
		private function out(e:MouseEvent)
		{
			ShineWhiteDeactive();
		}
		
		public function ShineWhiteActive()
		{
			 canvas = new Shape();
			 addChild(canvas);
             canvas.graphics.beginFill(0xFFFFFF, 1);
			 canvas.graphics.drawRect(0,0,2, height);
			 var myFilters:Array = new Array();
	         var effect:BitmapFilter = new GlowFilter(0xFFFFFF, 0.75, 25,13,2,1,false,false);
             myFilters.push(effect);
             this.filters = myFilters;
		}
		
		public function ShineWhiteDeactive()
		{
			canvas.graphics.clear();
			this.filters = null;
		}
		
		

	}
	
}
