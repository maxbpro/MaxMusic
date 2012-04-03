package MusicEditPackage 
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.filters.*;
	import flash.utils.ByteArray;
	
	public class Friend extends MovieClip 
	{
		public var first_name:String = null;
		public var last_name:String = null;
		private var url:String = null;
		private var uid:String = null;
		public var index:uint = 0;
		private var file:ByteArray = null;
		
		public function Friend(last_name:String,first_name:String, url:String, uid:String, index:uint, file:ByteArray) 
		{
			this.first_name = first_name;
			this.last_name = last_name;
			this.url = url;
			this.uid = uid;
			this.index = index;
			this.file = file;
			addEventListener(Event.ADDED_TO_STAGE, Added);
			addEventListener(MouseEvent.ROLL_OVER, Over);
			addEventListener(MouseEvent.ROLL_OUT, Out);
			addEventListener(MouseEvent.MOUSE_DOWN, Down);
			addEventListener(MouseEvent.CLICK, onSend);
		}
		
		private function Added(e:Event)
		{
			txt.text = first_name+ " " + last_name;
			photo.source = url;
			photo.load();
		}
		
		private function Over(e:MouseEvent)
		{
			var myFilters:Array = new Array();
	        var effect:BitmapFilter = new GlowFilter(0xFFFF33, 0.75, 13,13,2,1,false,false);
            myFilters.push(effect);
            filters = myFilters;
			
		}
		
		private function Down(e:MouseEvent)
		{
			var myFilters:Array = new Array();
	        var effect:BitmapFilter = new GlowFilter(0xFF88FF, 0.75, 13,13,2,1,false,false);
            myFilters.push(effect);
            filters = myFilters;
		}
		
		private function Out(e:MouseEvent)
		{
			filters = null;
		}
		
		private function onSend(e:MouseEvent)
		{
			SendToWall.Send(file,uid, root as Main);
		}
	}
	
}
