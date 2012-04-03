package  MusicEditPackage.Projects
{
	import flash.net.*;
	import flash.events.*;
	import fl.containers.ScrollPane;
	import MusicEditPackage.*;
	import MusicEditPackage.Field.MainField;

	
	public class Project 
	{
		public var title:String = null;
		public static var  scrollPanel:ScrollPane = null;
		private var winProj:winProjects = null;
		private var info:String = null;
		private var main:Main = null;

		public function Project(title:String) 
		{
			this.title = title;
			main = scrollPanel.root as Main;
		}
		
		public function New():MainField
		{
			var mainField:MainField = new MainField(25,16,scrollPanel);
			return mainField;
		}

		
		public function Open(winProj:winProjects)
		{
			this.winProj = winProj;
			var vars:URLVariables = new URLVariables();
			vars['hash'] = Main.getHash(PersonInfo.uid,PersonInfo.achive,title);
			vars['uid'] = PersonInfo.uid;
			vars['achive'] = PersonInfo.achive;
			vars['name'] = title;
			vars['key'] = Main.getHash((Math.random()*1000).toString());
			var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/openProject.php");
			myrequest.method = URLRequestMethod.POST;
			myrequest.data = vars;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, openProjectSuccess);
			loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			loader.load(myrequest);
			Key.ShowKey(main);
		}
		
		private function openProjectSuccess(e:Event)
		{
			Key.HideKey(main);
			var response:String = e.target.data['response'];
			if(response != "error")
			{
			   winProj.btnYesOpenTwoHandler(response);
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
		
		
		
		public function Save(info:String, winProj:winProjects)
		{
			try
			{
			   this.winProj = winProj;
			   var vars:URLVariables = new URLVariables();
			   vars['hash'] = Main.getHash(PersonInfo.uid, PersonInfo.achive, title);
			   vars['uid'] = PersonInfo.uid;
			   vars['achive'] = PersonInfo.achive;
		       vars['name'] = title;
			   vars['info'] = info;
			   vars['key'] = Main.getHash((Math.random()*1000).toString());
			   var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/saveProject.php");
			   myrequest.method = URLRequestMethod.POST;
			   myrequest.data = vars;
			   var loader:URLLoader = new URLLoader();
			   loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			   loader.addEventListener(Event.COMPLETE, SaveSuccess);
			   loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			   loader.load(myrequest);
			   Key.ShowKey(main);
			}
			catch(ex:Error)
			{
				
			}
		}
		
		
		private function SaveSuccess(e:Event)
		{
			 Key.HideKey(main);
			 var response:String = e.target.data['response'];
			 if (response == "success")
			 {
			     winProj.btnYesSaveTwoHandler();
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
		
		public function Delete(winProj:winProjects)
		{
			this.winProj = winProj;
			var vars:URLVariables = new URLVariables();
			vars['hash'] = Main.getHash(PersonInfo.uid, PersonInfo.achive, title);
		    vars['uid'] = PersonInfo.uid;
			vars['achive'] = PersonInfo.achive;
		    vars['name'] = title;
			vars['key'] = Main.getHash((Math.random()*1000).toString());
			var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/deleteProject.php");
			myrequest.method = URLRequestMethod.POST;
			myrequest.data = vars;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, DeleteSuccess);
			loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			loader.load(myrequest);
			Key.ShowKey(main);
		}
		
		private function DeleteSuccess(e:Event)
		{
			 Key.HideKey(main);
			 var response:String = e.target.data['response'];
			 if(response=="success")
			 {
			    winProj.btnDeleteYesHanlderTwo();
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
					 var attention:Attention = new Attention("Ошибка при удалении", main);
			         attention.Show();
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
