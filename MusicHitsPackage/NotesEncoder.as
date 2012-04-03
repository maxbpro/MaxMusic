
package  MusicHitsPackage
{
    import flash.display.*;
	
	public class NotesEncoder 
	{
		private static var ar:Array = new Array(1,2,4,8,16,32,48,64,80,96,112,128,144,160);
        private static var result:Vector.<uint> = null;
		
		public function NotesEncoder() 
		{
			// constructor code
		}
		
		public static function Encode(number:uint)
		{
			result = new Vector.<uint>();
			var del:uint=0;
			for (var i:int=ar.length-1; i>=0; i--)
			{
				if(Math.floor(number/ar[i])==1)
				{
					del = number-ar[i];
					result.push(ar[i]);
					break;
				}
			}
			
			while(del!=0 && del!=1)
			{
				for (i=3; i>=0; i--)
				{
					if(Math.floor(del/ar[i])==1)
					{
						del = del - ar[i];
						result.push(ar[i]);
						break;
					}
				}
			}
			if(del==1)
			  result.push(1);
		}


		
		public static function GetLineNotes():Sprite
		{
		   var localX:uint = 0;
		   var lineNotes:Sprite = new Sprite();
		   for (var i:uint=0; i<result.length; i++)
		   {
			   var note:Sprite = new Sprite();
			   note = GetFigure(result[i]);
			   note.x = localX;

			   lineNotes.addChild(note);
               trace(note.width);
			   localX += (note.width + 5);
			   if(i>=6)
			   {
				   note = getPoints();
				   localX += note.width;
			       note.x = localX;
			       lineNotes.addChild(note);
			   }
			     
		   }
		   return lineNotes;
			
		}
		
		private static function GetFigure(number:uint):Sprite
		{
			  switch(number)
			  {
			 	   case 1:
				   {
					   return new Hex();
					   break;
				   }
				   case 2:
				   {
					   return new Oct();
					   break;
				   }
				   case 4:
				   {
					   return new Quarter();
					   break;
				   }
				   case 8:
				   {
					   return new Half();
					   break;
				   }
				   case 16:
				   {
					   return new Entire();
					   break;
				   }
				   case 32:
				   {
					   return new Two();
					   break;
				   }
				   case 48:
				   {
					   return new Three();
					   break;
				   }
				   case 64:
				   {
					   return new Four();
					   break;
				   }
				   case 80:
				   {
					   return new Five();
					   break;
				   }
				   case 96:
				   {
					   return new Six();
					   break;
				   }
				   case 112:
				   {
					   return new Seven();
					   break;
				   }
				   case 128:
				   {
					   return new Eight();
					   break;
				   }
				   case 144:
				   {
					   return new Nine();
					   break;
				   }
				   case 160:
				   {
					   return new KeyScrip();
					   break;
				   }
			  }
			  return null;
		}
		
		private static function getPoints():Sprite
		{
			return new Points();
		}

	}
	
}
