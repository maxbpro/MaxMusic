package  MusicEditPackage
{
	import flash.events.*;
	import com.nbilyk.file.MultipartURLLoader;
	import com.adobe.serialization.json.JSON;
	import flash.utils.ByteArray;
	import vk.events.CustomEvent;
	
	public class SendToWall 
	{
		
		private static var main:Main = null;
		private static var uid:String = null;
		private static var mes:Message = null;
		private static var upload:String = null;
		private static var file:ByteArray = null;

		public function SendToWall() 
		{
			// constructor code
		}
		
		public static function Send(file2:ByteArray,uid2:String, main2:Main)
		{
			main = main2;
			uid = uid2;
			file = file2;
			PersonInfo.VK.api('getUserSettings', {}, getUserSettingsSuc, Failed);
		}
		
		private static function getUserSettingsSuc(response:Object)
		{
			 if (uint(response) & 8200)
			 {
                  PersonInfo.VK.api('audio.getUploadServer',{}, getUploadServerSuc, Failed); 
				  Key.ShowKey(main);
		     }
		     else
		     {
			      PersonInfo.VK.callMethod("showSettingsBox",8200);
			      PersonInfo.VK.addEventListener("onSettingsChanged", onSettingsChanged);
		     }
		}
		
		private static function onSettingsChanged(e:CustomEvent)
		{
			if(uint(e.params[0]) & 8200)
			{
				  PersonInfo.VK.api('audio.getUploadServer',{}, getUploadServerSuc, Failed); 
				  Key.ShowKey(main);
			}
			else
			{
				PersonInfo.VK.callMethod("showSettingsBox",8200);
				PersonInfo.VK.addEventListener('onSettingsChanged', onSettingsChanged);
			}
		
		}
		
		private static function getUploadServerSuc(response:Object)
		{
			Key.HideKey(main);
			upload = response.upload_url;
			
			mes = new Message(1, "Стоимость публикации 20 тактов.Опубликовать на стене?");
			mes.btnYes.addEventListener(MouseEvent.CLICK, onYes);
			mes.btnNo.addEventListener(MouseEvent.CLICK, onNo);
			main.addChild(mes);
		}
		
		private static function onNo(e:MouseEvent)
		{
			main.removeChild(mes);
		}
		
		private static function onYes(e:MouseEvent)
		{
			main.removeChild(mes);
			if(int(main.MusicEditMovie.UserPanel.tacks.txt.text) - 20 >= 0)
			{
			   var title:String = main.MusicEditMovie.currentProject.title;
		       var mll:MultipartURLLoader = new MultipartURLLoader();
               mll.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
		       mll.addEventListener(Event.COMPLETE, sendSuccess);
			   mll.addFile(file, "file.mp3", "file");
               mll.load(upload);
			   Key.ShowKey(main);
			}
			else
			{
				var attention:Attention = new Attention("Недостаточно тактов!", main);
			    attention.Show();
			}
		}
		
		private static function sendSuccess(e:Event)
		{
			 var st:String = e.currentTarget.loader.data;
			 var res:Object = JSON.decode(st,false);

		     PersonInfo.VK.api('audio.save',{server: res.server, audio: res.audio, hash:res.hash, audio_hash: res.audio_hash,
							   artist:PersonInfo.first_name + " " + PersonInfo.last_name, 
							   title: main.MusicEditMovie.currentProject.title }, Post, Failed); 
	
							   
		}
		
		private static function Post(res:Object)
		{
			 PersonInfo.VK.api('wall.post',{owner_id: uid, attachments: "audio" + res.owner_id+"_"+res.aid }, onSendFinish,Failed);
		}
		
		private static function onSendFinish(response:Object)
		{
			Key.HideKey(main);
			   
			if(uint(response.post_id)>0)
			{
			   // Обновляем окружение
			  main.UpdateEnv(PersonInfo.fanat,PersonInfo.columb,++PersonInfo.painter, PersonInfo.creater, 
									   20, PersonInfo.songs, null, "Публикация завершена!","Ошибка публикации. Сервер недоступен!");
			}
			else
			{
				var attention:Attention = new Attention(response.text, main);
			    attention.Show();
			}
		   
		}
		
		private static function IOFail(e:IOErrorEvent)
		{
			Key.HideKey(main);
			var attention:Attention = new Attention(e.text, main);
			attention.Show();
		}
		
		private static function Failed(e:Object)
		{
			Key.HideKey(main);
			var attention:Attention = new Attention("Сервер Вконтакте недоступен", main);
		    attention.Show();
		}

	}
	
}
