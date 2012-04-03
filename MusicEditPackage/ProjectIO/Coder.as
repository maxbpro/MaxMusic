package MusicEditPackage.ProjectIO
{
	import com.adobe.serialization.json.JSON;
	import MusicEditPackage.Field.Cell;
	import MusicEditPackage.Field.MainField;
	import MusicEditPackage.Mode;
	
	public class Coder 
	{

		public  function Coder() 
		{
			// constructor code
		}
		
		public static function Code(mainField:MainField, title:String):String
		{
			try
			{
			   var main:Main = mainField.root as Main;
			   var ar:Array = new Array();
			   var counter:uint = 0;
			   for(var i:uint = 0; i<mainField.columnNum-1; i++)
			   {
				   for(var j:uint =0 ; j<mainField.rowNum-1; j++)
				   {
				      var movieCurrent:Cell = mainField.getChildByName("cell"+counter) as Cell;
				      if(movieCurrent.url != null)
				      {
					      ar.push(counter + "," + movieCurrent.url + "," + movieCurrent.title + "," + movieCurrent.length + ","+ movieCurrent.instrument + ","+ movieCurrent.using);
				      }
				      counter++;
				   }
			   }
			   var projectAr:Array = new Array();
			   projectAr[0] = mainField.columnNum;
			   projectAr[1] = title;
			   projectAr[2] = Mode.mode;
			   if(ar.length == 0)
			     projectAr[3] = "empty";
			   else
			     projectAr[3] = ar;
			   var projectString:String = JSON.encode(projectAr);
		   }
		   catch(ex:Error)
           {
		      var attention:Attention = new Attention("Ошибка при кодировании",main);
		      attention.Show();
			  return null;
	       }
		   return projectString;
		   
		}
		

	}
	
}
