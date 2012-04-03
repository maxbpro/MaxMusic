package  MusicEditPackage.Projects
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import MusicEditPackage.*;
	import fl.controls.List;
	import fl.events.*;
	import fl.data.DataProvider;
	import flash.net.*;
	import fl.controls.Label;
	import com.adobe.serialization.json.JSON;
	import MusicEditPackage.Field.MainField;
    import MusicEditPackage.ProjectIO.*;
	
	public class winProjects extends MovieClip 
	{
		private var main:Main = null;
		private var mainMusic:MusicEdit = null;
		private var mainField:MainField= null;
		private var question:Message = null;
		
		public function winProjects() 
		{
			btnOpen.addEventListener(MouseEvent.CLICK, btnOpenHandler);
			btnNew.addEventListener(MouseEvent.CLICK, btnNewHandler);
			btnSave.addEventListener(MouseEvent.CLICK, btnSaveHandler);
			btnDelete.addEventListener(MouseEvent.CLICK, btnDeleteHandler);
			main = root as Main;
			mainMusic = main.MusicEditMovie;
			mainField = mainMusic.scrollPanel.source as MainField;
			listOfProjects.addEventListener(ListEvent.ITEM_CLICK, listItemClickHandler);
			listOfProjects.selectedIndex = -1;
		}
		
		public function InitListOfProjects()
		{
			DeactiveButton(btnSave);
			DeactiveButton(btnDelete);
			DeactiveButton(btnOpen);
			title.text = mainMusic.currentProject.title;
			if(mainMusic.read == false)
			{
			   //listOfProjects.dataProvider = mainMusic.arrayOfProjects;
			   var vars:URLVariables = new URLVariables();
			   vars['hash'] = Main.getHash(PersonInfo.uid, PersonInfo.achive);
			   vars['achive'] = PersonInfo.achive;
		       vars['uid'] = PersonInfo.uid;
			   vars['key'] = Main.getHash((Math.random()*1000).toString());
			   var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/ReadAchive.php");
			   myrequest.method = URLRequestMethod.POST;
			   myrequest.data = vars;
			   var loader:URLLoader = new URLLoader();
			   loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			   loader.addEventListener(Event.COMPLETE, ReadAchiveSuccess);
			   loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			   loader.load(myrequest);
			   winPictures.gotoAndStop(2);
			}
			else
			{
				listOfProjects.dataProvider = mainMusic.arrayOfProjects;
			    listOfProjects.selectedIndex = -1;
			}
		}
		
		
		
		private function ReadAchiveSuccess(e:Event)
		{
			winPictures.gotoAndStop(1);
			var response:String = e.target.data['response'];
			if(response == "success")
			{
			   mainMusic.arrayOfProjects = new DataProvider();
			   var ar:Array = e.target.data['list'].split(",");
			   for(var i:uint=0; i<ar.length-1; i++)
			   {
				   mainMusic.arrayOfProjects.addItem({label: ar[i]});
			   }
			   listOfProjects.dataProvider = mainMusic.arrayOfProjects;
			   listOfProjects.selectedIndex = -1;
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
			}
		}
		
		
		
		//New
		private function btnNewHandler(e:MouseEvent)
		{
			if(mainMusic.currentProject.title != "Demo")
		    {
			   question = new Message(4,"Будет создан новый проект. Сохранить изменения в текущем?");
			   main.addChild(question);
			   question.btnYes.addEventListener(MouseEvent.CLICK, CreatingNewProjectWithSave);
			   question.btnNo.addEventListener(MouseEvent.CLICK, CreatingNewProjectWithoutSave);
			   question.btnCancel.addEventListener(MouseEvent.CLICK, HideQuestion);
		    }
			else
			   CreatingNewProjectWithoutSave(null);
		}
		
		private function CreatingNewProjectWithSave(e:MouseEvent)
		{
			var info:String = Coder.Code(mainField, mainMusic.currentProject.title);
			mainMusic.currentProject.Save(info, this);

			CreatingNewProjectWithoutSave(null);
		}
		
		
		private function CreatingNewProjectWithoutSave(e:MouseEvent)
		{
			if(mainMusic.currentProject.title != "Demo")
			   main.removeChild(question);

			question = new Message(3);
			main.addChild(question);
			question.btnCreate.addEventListener(MouseEvent.CLICK, btnCreateHandler);
			question.btnCancel.addEventListener(MouseEvent.CLICK, HideQuestion);
			
		}
		
		
		private function btnCreateHandler(e:MouseEvent)
		{
			var textIsNormal = true;
			var st:String = question.txtInput.text;
			// проверка на совпадение имен
			for(var i:uint=0; i<mainMusic.arrayOfProjects.length; i++)
			{
				if(st == mainMusic.arrayOfProjects.getItemAt(i).label)
				{
					var attention:Attention = new Attention("Используйте другое наименование",main);
			        attention.Show();
					return;
				}
			}
			// проверка на корректность
			for(i=0; i<st.length; i++)
			{
				if(!(st.charCodeAt(i)>=48 && st.charCodeAt(i)<=57 || st.charCodeAt(i)>=65 && st.charCodeAt(i)<=90
				   || st.charCodeAt(i)>=97 && st.charCodeAt(i)<=122))
				{
					textIsNormal = false;
					break;
				}
			}
			if(textIsNormal == true)
			{
			   mainMusic.currentProject = new Project(st);
			   mainMusic.mainField = mainMusic.currentProject.New();
               mainMusic.updateScrollPanel();
			   mainMusic.arrayOfProjects.addItem({label:st});
			   listOfProjects.dataProvider = mainMusic.arrayOfProjects;
			
			   mainMusic.infoPanel.title.text = question.txtInput.text;
			   Mode.ModeChange(question.cmbGenre.selectedItem.label, mainMusic);
			   title.text = st;
			
			
			   listOfProjects.selectedIndex = -1;
			   main.removeChild(question);
			   mainMusic.read = true;
			}
			else
			{
			   var attention:Attention = new Attention("Наименование должно состоять из символов английского алфавита",main);
			   attention.Show();
			}
		}
		
		
		
		//Save
		private function btnSaveHandler(e:MouseEvent)
		{
			question = new Message(1, "Сохранить изменения в текущем проекте?");
			main.addChild(question);
			question.btnYes.addEventListener(MouseEvent.CLICK, btnYesSaveOneHandler);
			question.btnNo.addEventListener(MouseEvent.CLICK, HideQuestion);
		}
		
		private function btnYesSaveOneHandler(e:MouseEvent)
		{
			var info:String = Coder.Code(mainField, mainMusic.currentProject.title);
			mainMusic.currentProject.Save(info, this);
			main.removeChild(question);
		}
		
		public function btnYesSaveTwoHandler()
		{
			mainMusic.read = false;
			var attention:Attention = new Attention("Сохранение выполнено", main);
			attention.Show();
		}
		
		
		
		//Open
		private function btnOpenHandler(e:MouseEvent)
		{
			question = new Message(1, "Открыть проект? Текущий проект будет закрыт");
			main.addChild(question);
			question.btnYes.addEventListener(MouseEvent.CLICK, btnYesOpenOneHandler);
			question.btnNo.addEventListener(MouseEvent.CLICK, HideQuestion);
		}
		
		private function btnYesOpenOneHandler(e:MouseEvent)
		{
			var currentProjectName:String = listOfProjects.selectedItem.label;
			mainMusic.currentProject = new Project(currentProjectName);
			mainMusic.currentProject.Open(this);
			main.removeChild(question);
		}
		
		public function btnYesOpenTwoHandler(info:String)
		{
            try
			{
			   var ar:Array = JSON.decode(info);
			   var newField:MainField = new MainField(ar[0],16,mainMusic.scrollPanel);
			
			   if(ar[3]!="empty")
		 	   {
			       Decoder.Decode(newField,ar[3],mainMusic);
			   }
			   else
			   {
				   var temp:MainField = mainMusic.currentProject.New();
				   mainMusic.scrollPanel.source = temp;
				   mainMusic.mainField = temp;
			   }
			   mainMusic.infoPanel.title.text = ar[1];
			   Mode.ModeChange(ar[2], mainMusic);
			   title.text = ar[1];
			}
			catch(ex:Error)
			{
				var attention:Attention = new Attention("Проект испорчен",main);
				attention.Show();
			}

		}
		
		
		
		//Delete
		private function btnDeleteHandler(e:MouseEvent)
		{
			question = new Message(1,"Вы хотите удалить текущий проект?");
			main.addChild(question);
			question.btnYes.addEventListener(MouseEvent.CLICK, btnDeleteYesHandler);
			question.btnNo.addEventListener(MouseEvent.CLICK, HideQuestion);
		}
		
		private function btnDeleteYesHandler(e:MouseEvent)
		{
			mainMusic.currentProject.Delete(this);
			mainMusic.arrayOfProjects.removeItem({label:mainMusic.currentProject.title});
			listOfProjects.dataProvider = mainMusic.arrayOfProjects;
			main.removeChild(question);
		}
		
		public function btnDeleteYesHanlderTwo()
		{
			var attention:Attention = new Attention("Проект удален", main);
			attention.Show();
		}
		
		
		
		
		
		
		private function DeactiveButton(mv:MovieClip)
		{
			mv.txt.textColor = 0x000000;
			mv.mouseChildren = false;
			mv.mouseEnabled = false;
		}
		
		private function ActiveButton(mv:MovieClip)
		{
			mv.txt.textColor = 0xFFFFFF;
			mv.mouseChildren = true;
			mv.mouseEnabled = true;;
		}
		
		private function listItemClickHandler(e:ListEvent)
		{
			if(mainMusic.currentProject.title == e.item.label)
			{
				ActiveButton(btnSave);
				ActiveButton(btnDelete);
				DeactiveButton(btnOpen);
			}
			else
			{
			    DeactiveButton(btnSave);
				DeactiveButton(btnDelete);
				ActiveButton(btnOpen);
			}
			
		}
		
		private function IOFail(e:IOErrorEvent)
		{
			winPictures.gotoAndStop(1);
			var attention:Attention = new Attention("Сервер недоступен",main);
			attention.Show();
		}
		
		private function HideQuestion(e:MouseEvent)
		{
			main.removeChild(question);
		}
		
		
		
		
	}
	
}
