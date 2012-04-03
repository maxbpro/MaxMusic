package  
{
	
	
	public class Key 
	{
		private static var key:LoadingKey = null;


		public function Key() 
		{
			
		}
		
		public static function ShowKey(main:Main, visib:Boolean = true)
		{
			if(main != null)
			{
			   key = new LoadingKey();
			   key.txt.visible = false;
			   if(visib==false)
			   {
				   key.key.x = 688;
				   key.key.y = 417;
				   key.txt.visible = true;
			   }
			
			   main.addChild(key);
			}
		}
		
		public static function HideKey(main:Main)
		{
			if(key != null && main != null)
			{
			   main.removeChild(key);
			   key = null;
			}
		}

	}
	
}
