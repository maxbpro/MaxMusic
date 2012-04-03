package MusicEditPackage.LoadingPackage
{
	import flash.net.*;
	import flash.events.*;
	import flash.display.*;
	import com.adobe.serialization.json.JSON;
	import MusicEditPackage.Creation.*;
	import MusicEditPackage.MusicEdit;
	
	public class Loading 
	{
		public static var genres:Vector.<Object> = null;
		
		private var mainMusic:MusicEdit = null;
		private var main:Main = null;

		public function Loading(mainMusic:MusicEdit) 
		{
             this.mainMusic = mainMusic;
			 main = mainMusic.parent as Main;
			 WriteClient();
		}
		
		private function WriteClient()
		{
			var vars:URLVariables = new URLVariables();
			vars['hash'] = Main.getHash(PersonInfo.uid);
			vars['uid'] = PersonInfo.uid;
			vars['key'] = Main.getHash((Math.random()*1000).toString());
			var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/ReadClient.php");
			myrequest.method = URLRequestMethod.POST;
			myrequest.data = vars;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, ReadClientSuccess);
			loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			loader.load(myrequest);
		}
		
		private function ReadClientSuccess(e:Event)
		{
			var response:String = e.target.data.response;
			if(response=="success")
			{
			   var result:Object = e.target.data;
			   PersonInfo.tack = uint(result.tack);
			   PersonInfo.achive = result.achive;
			   PersonInfo.fanat = result.fanat;
			   PersonInfo.creater = result.creater;
			   PersonInfo.painter = result.painter;
			   PersonInfo.columb = result.columb;
			   PersonInfo.songs = result.songs;
			   PersonInfo.invite = result.invite;
			   var opened:String = result.opened;
			   if (opened != "empty")
			      PersonInfo.opened = opened.split(",");
			   
			   genres = FillSamplesInfo.Init();
			   mainMusic.ShowDemo();
			}
			else
			{
				if(response=="close")
				{
					var attention:Attention = new Attention("Доступ временно закрыт", main);
			        attention.Show();
					Key.ShowKey(main, false);
				}
				else
				{
				   if(response=="hack")
				   {  
				      PersonInfo.atacCount = uint(e.target.data.atacCount);
				      var result:Object = e.target.data;
			          PersonInfo.tack = uint(result.tack);
			          PersonInfo.achive = result.achive;
			          PersonInfo.fanat = result.fanat;
			          PersonInfo.creater = result.creater;
			          PersonInfo.painter = result.painter;
			          PersonInfo.columb = result.columb;
			          PersonInfo.songs = result.songs;
			          var opened:String = result.opened;
			          if (opened != "empty")
			             PersonInfo.opened = opened.split(",");
			   
			          genres = FillSamplesInfo.Init();
			          mainMusic.ShowDemo();
				   }
				   else
				   {
				      var attention:Attention = new Attention("Сервер недоступен", main);
			          attention.Show();
				   }
				}
				
			}
		}
		

		private function IOFail(e:IOErrorEvent)
		{
			Key.HideKey(main);
			var attention:Attention = new Attention("Сервер недоступен", main);
			attention.Show();
		}

	}
	
}
