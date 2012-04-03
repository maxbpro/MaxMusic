package MusicHitsPackage 
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import vk.APIConnection;
	
	public class RespectPanel extends MovieClip 
	{
		private var index:uint=0;
		private var krit:String = null;
		private var counter:uint = 0;
		private var rows:Array = null;
		private var title:String = null;
		private var keyHideFlag:Boolean = false;
		private var uidsRef:String = "";
		private var main:Main = null;
		
		public function RespectPanel(krit:String, title:String, keyHideFlag:Boolean = false) 
		{
			this.krit = krit;
			this.title = title;
			this.keyHideFlag = keyHideFlag;
			person0.addEventListener(MouseEvent.ROLL_OVER, Over, false, 0, true);
			person1.addEventListener(MouseEvent.ROLL_OVER, Over, false, 0, true);
			person2.addEventListener(MouseEvent.ROLL_OVER, Over, false, 0, true);
			person3.addEventListener(MouseEvent.ROLL_OVER, Over, false, 0, true);
			person4.addEventListener(MouseEvent.ROLL_OVER, Over, false, 0, true);
			person5.addEventListener(MouseEvent.ROLL_OVER, Over, false, 0, true);
			person6.addEventListener(MouseEvent.ROLL_OVER, Over, false, 0, true);
			person7.addEventListener(MouseEvent.ROLL_OVER, Over, false, 0, true);
			person8.addEventListener(MouseEvent.ROLL_OVER, Over, false, 0, true);
			person9.addEventListener(MouseEvent.ROLL_OVER, Over, false, 0, true);
			person0.addEventListener(MouseEvent.ROLL_OUT, Out, false, 0, true);
			person1.addEventListener(MouseEvent.ROLL_OUT, Out, false, 0, true);
			person2.addEventListener(MouseEvent.ROLL_OUT, Out, false, 0, true);
			person3.addEventListener(MouseEvent.ROLL_OUT, Out, false, 0, true);
			person4.addEventListener(MouseEvent.ROLL_OUT, Out, false, 0, true);
			person5.addEventListener(MouseEvent.ROLL_OUT, Out, false, 0, true);
			person6.addEventListener(MouseEvent.ROLL_OUT, Out, false, 0, true);
			person7.addEventListener(MouseEvent.ROLL_OUT, Out, false, 0, true);
			person8.addEventListener(MouseEvent.ROLL_OUT, Out, false, 0, true);
			person9.addEventListener(MouseEvent.ROLL_OUT, Out, false, 0, true);
			addEventListener(Event.ADDED_TO_STAGE, Added);
		}
		
		private function Added(e:Event)
		{
			main = root as Main;
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			person0.infoPanel.visible = true;
			person1.infoPanel.visible = false;
			person2.infoPanel.visible = false;
			person3.infoPanel.visible = false;
			person4.infoPanel.visible = false;
			person5.infoPanel.visible = false;
			person6.infoPanel.visible = false;
			person7.infoPanel.visible = false;
			person8.infoPanel.visible = false;
			person9.infoPanel.visible = false;
			LoadInfo();
			txt.text = title;
		}
		
		private function LoadInfo()
		{
			var vars:URLVariables = new URLVariables();
			vars['uid'] = PersonInfo.uid;
			vars['hash'] = Main.getHash(PersonInfo.uid, krit);
			vars['krit'] = krit;
			vars['key'] = Main.getHash((Math.random()*1000).toString());
			var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/GetRespect.php");
			myrequest.method = URLRequestMethod.POST;
			myrequest.data = vars;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, GetRespectSuccess, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail, false, 0, true);
			loader.load(myrequest);
			
		}
		
		private function GetRespectSuccess(e:Event)
		{
			
			if(e.target.data.response=="success")
			{
			   rows = e.target.data.result.split('!');
			   counter = 0;
			   LoadInfoPersons();
			}
			else
			{
				if(e.target.data.response=="atac")
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
					var attention:Attention = new Attention("Сервер временно недоступен", main);
			        attention.Show();
				}
			}
		}
		
		private function LoadInfoPersons()
		{
			if(counter == rows.length-1 )
			{
				if(keyHideFlag == true)
				  Key.HideKey(main);
				LoadPic();
			}
			else
			{
				var row:Array = rows[counter].split(';');
				var person:RespectPerson = getChildByName("person" + counter) as RespectPerson;
				NotesEncoder.Encode(row[1]);
				var line:Sprite = NotesEncoder.GetLineNotes();
				line.width /= 2; line.height /=2;
				line.x = 100; line.y = 0;
			    person.infoPanel.addChild(line);
				
				NotesEncoder.Encode(row[3]);
				var line:Sprite = NotesEncoder.GetLineNotes();
				line.width /= 2; line.height /=2;
				line.x = 70; line.y = 20;
			    person.infoPanel.addChild(line);
				
				NotesEncoder.Encode(row[4]);
				var line:Sprite = NotesEncoder.GetLineNotes();
				line.width /= 2; line.height /=2;
				line.x = 70; line.y =38;
			    person.infoPanel.addChild(line);
				
				NotesEncoder.Encode(row[2]);
				var line:Sprite = NotesEncoder.GetLineNotes();
				line.x = 70; line.y = 57;
				line.width /= 2; line.height /=2;
			    person.infoPanel.addChild(line);
				
				uidsRef = uidsRef + row[0] + ",";
				
				counter++;
				LoadInfoPersons();
			}
		}
		
		private function LoadPic()
		{
			PersonInfo.VK.api('getProfiles', {uids: uidsRef , fields:'last_name,first_name,photo_medium' }, onSuccess, onFailed);
		}
		
		private function onSuccess(e:Object)
		{
			for (var i:uint=0; i<e.length; i++)
			{
				var mv:MovieClip = getChildByName("person" + i) as MovieClip;
				mv.photo.source = null;
				mv.photo.source = e[i].photo_medium;
				mv.photo.load();
				mv.fio.text = e[i].first_name + " " + e[i].last_name;
			}
		}
		
		
		private function onFailed(e:Object)
		{
			var attention:Attention = new Attention("Сервер Вконтакте недоступен", main);
			attention.Show();
		}
		
		private function Over(e:MouseEvent)
		{
			index = uint(e.currentTarget.name.toString().charAt(e.currentTarget.name.length-1));
			for(var i:uint=0; i<index; i++)
			{
				(getChildByName("person"+i) as RespectPerson).visible = false;
			}
			(getChildByName("person"+index) as RespectPerson).infoPanel.visible = true;
		}
		
		
		
		private function Out(e:MouseEvent)
		{
			index = uint(e.currentTarget.name.toString().charAt(e.currentTarget.name.length-1));
			for(var i:uint=0; i<index; i++)
			{
				(getChildByName("person"+i) as RespectPerson).visible = true;
			}
			(getChildByName("person"+index) as RespectPerson).infoPanel.visible = false;
			person0.infoPanel.visible = true;
		}
		
		private function IOFail(e:IOErrorEvent)
		{
			Key.HideKey(main);
			var attention:Attention = new Attention("Сервер недоступен", main);
			attention.Show();
		}
		
		
	}
	
}
