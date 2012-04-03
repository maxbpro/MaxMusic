package 
{
	import vk.APIConnection;
	
	public class PersonInfo 
	{
		public static var uid:String = null;
		public static var achive:String = null;
		public static var tack:int = 0;
		public static var opened:Array = null;
		public static var fanat:uint = 0;
		public static var creater:uint = 0;
		public static var painter:uint = 0;
		public static var columb:uint = 0;
		public static var songs:String = null;
		public static var VK:APIConnection = null;
		public static var photoUrl:String = null;
		public static var first_name:String = null;
		public static var last_name:String = null;
		public static var flashVars:Object = null;
		public static var atacCount:uint = 0;
		public static var invite:uint = 0;
 
		public function PersonInfo() 
		{

		}
		
		public static function getStatus():String
		{
			var max:uint = uint(Math.max(fanat, creater,painter,columb));
			if(max==0)
			   return "Новичок";
			if(fanat == max)
			{
				return "Воздыхатель";
			}
			else
			{
				if(creater==max)
				{
					return "Творец";
				}
				else
				{
					if(painter==max)
					{
						return "Маляр";
					}
					else
					{
						if(columb==max)
						{
							return "Колумб";
						}
					}
				}
			}
			return "Новичок";
		}
		
		

	}
	
}
