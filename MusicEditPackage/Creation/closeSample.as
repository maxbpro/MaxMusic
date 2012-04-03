package  MusicEditPackage.Creation
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	import MusicEditPackage.LoadingPackage.*;
	
	public class closeSample extends MovieClip 
	{
		private var mes:Message = null;
		private var length:uint = 0;
		private var url:String = null;
		private var instrument:uint = 0;
		private var main:Main = null;
		private var oldTacks:uint = 0;
		private var newTacks:uint = 0;
		private var oldOpened:String = "";
		private var newOpened:String = "";
		
		public function closeSample() 
		{
			
		}
		
		private function Init(length:uint, url:String, instrument:uint)
		{
			this.length = length;
			this.url = url;
			this.instrument = instrument;
			addEventListener(MouseEvent.CLICK, ClickHandler);
		}
		
		private function ClickHandler(e:MouseEvent)
		{
			mes = new Message(1, "Стоимость открытия (такты): " + length + ".\nОткрыть сэмпл?");
			main = root as Main;
			main.addChild(mes);
			mes.btnYes.addEventListener(MouseEvent.CLICK, YesHandler);
			mes.btnNo.addEventListener(MouseEvent.CLICK, NoHandler);
		}
		
		private function YesHandler(e:MouseEvent)
		{
			main.removeChild(mes);
			oldTacks = int(main.MusicEditMovie.UserPanel.tacks.txt.text);
			if(  (oldTacks-length) >=0)
			{
			   SendQuery();
			}
			else
			{
				var attention:Attention = new Attention("У Вас недостаточно тактов!", main);
				attention.Show();
			}
		}
		
		private function NoHandler(e:MouseEvent)
		{
			main.removeChild(mes);
		}
		
		private function SendQuery()
		{
			var vars:URLVariables = new URLVariables();
			vars['uid'] = PersonInfo.uid;
			newTacks = oldTacks - length;
			vars['tack'] = newTacks;
			vars['key'] = Main.getHash((Math.random()*1000).toString());
			if(PersonInfo.opened != null)
			{
			   for(var i:uint=0; i<PersonInfo.opened.length;i++)
			   {
			       oldOpened += PersonInfo.opened[i] + ",";
			   }
			}
			newOpened = oldOpened + url +",";
			vars['opened'] = newOpened;
			vars['columb'] = PersonInfo.columb + 1;
			vars['hash'] = Main.getHash(PersonInfo.uid,newTacks, newOpened, PersonInfo.columb+1);
			var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/updateClientBalance.php");
			myrequest.method = URLRequestMethod.POST;
			myrequest.data = vars;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, UpdateClientInfoSuccess);
			loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			loader.load(myrequest);
            Key.ShowKey(main);
		}
		
		private function UpdateClientInfoSuccess(e:Event)
		{
			Key.HideKey(main);
			var response:String = e.target.data.response;
			if(response == "success")
			{
				UpdateEnviroment();
			}
			else
			{
				if(response=="atac")
				{
					PersonInfo.atacCount++;
					if(PersonInfo.atacCount>=3)
					{
						var attention:Attention = new Attention("Доступ временно закрыт", main);
			            attention.Show();
					    Key.ShowKey(main, false);
					}
				}
				else
				{
				   var attention:Attention = new Attention("Сервер недоступен", main);
			       attention.Show();
				}
			}
		}
		
		private function UpdateEnviroment()
		{
			PersonInfo.columb++;
			if(PersonInfo.opened == null)
			  PersonInfo.opened = new Array();
			PersonInfo.opened.push(url);
			var urlAr:Array = url.split("/");
			var genre:int = -1;
			switch(urlAr[3])
			{
				case "Dance":
				{
					genre = 0;
					break;
				}
				case "DrumNBass":
				{
					genre = 1;
					break;
				}
				case "Pop":
				{
					genre = 2;
					break;
				}
			}
			var found:Boolean = false;
			var counter:uint=0;
			while (found != true)
			{
				if(Loading.genres[genre][instrument][counter][1] == url)
				{
					Loading.genres[genre][instrument][counter][3] = "open";
					break;
				}
				counter++;
			}
			
			main.MusicEditMovie.initMainSamplesPanel();
		    var mySampleList:SamplesList = new SamplesList(Loading.genres[genre][instrument], main.MusicEditMovie, instrument); 
			main.MusicEditMovie.mainSamplesPanel.samplesListScroll.source = mySampleList;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event)
		{
			if(int(main.MusicEditMovie.UserPanel.tacks.txt.text) > newTacks)
			{
			   main.MusicEditMovie.UserPanel.tacks.txt.text = (int(main.MusicEditMovie.UserPanel.tacks.txt.text) - 1).toString();
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
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
