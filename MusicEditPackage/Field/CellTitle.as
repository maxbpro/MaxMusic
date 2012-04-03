package MusicEditPackage.Field
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.filters.*;
	
	
	public class CellTitle extends MovieClip 
	{
		public var column:uint = 0;
		private var line:Line = null;
		
		public function CellTitle(column:uint, line:Line = null) 
		{
			this.column = column;
			this.line = line;
			addEventListener(MouseEvent.ROLL_OVER, RollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, RollOutHandler);
		}
		
		public function RollOverHandler(e:MouseEvent)
		{
			var myFilters:Array = new Array();
	        var effect:BitmapFilter = new GlowFilter(0xFFFFFF, 0.75, 13,13,2,1,true,false);
            myFilters.push(effect);
            filters = myFilters;
			if(line!=null)
			   line.ShineWhiteActive();
		}
		
		public function RollOutHandler(e:MouseEvent)
		{
			filters = null;
			if(line!=null)
			   line.ShineWhiteDeactive();
		}
	}
	
}
