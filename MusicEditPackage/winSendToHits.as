package MusicEditPackage 
{
	
	import flash.display.MovieClip;
	import flash.utils.ByteArray;
	import com.nbilyk.file.MultipartURLLoader;
	import flash.net.*;
	import flash.events.*;
	import com.nbilyk.file.MultipartURLLoaderEvent;
	
	
	public class winSendToHits extends MovieClip 
	{
		private var bytes:ByteArray = null;
		private var title:String = null;
		private var main:Main = null;
		
		public function winSendToHits(bytes:ByteArray, title:String) 
		{
			this.bytes = bytes;
			this.title = title;
			btnCancel.addEventListener(MouseEvent.CLICK, onCancel);
			btnSend.addEventListener(MouseEvent.CLICK, onSend);
		}
		
		
		private function onSend(e:MouseEvent)
		{   
		   main = root as Main;
		   if (int(main.MusicEditMovie.UserPanel.tacks.txt.text) - 40 >= 0)
		   {
		      var textIsNormal = true;
		      var st:String = txtInput.text;
		      for(var i:uint=0; i<st.length; i++)
			   {
				   if(!((st.charCodeAt(i)>=48 && st.charCodeAt(i)<=57) || (st.charCodeAt(i)>=65 && st.charCodeAt(i)<=90)
				      || (st.charCodeAt(i)>=97 && st.charCodeAt(i)<=122) || (st.charCodeAt(i)>=1040 && st.charCodeAt(i)<=1103)))
				   {
					   textIsNormal = false;
					   break;
				   }
			   }
		       if(textIsNormal == true)
			   {
			      var mll:MultipartURLLoader = new MultipartURLLoader();
                  mll.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			      mll.addEventListener(Event.COMPLETE, UpdataTableSongs);
			      bytes.position = 14;
			      bytes.writeByte(28);
			      bytes.position = 0;
                  mll.addFile(bytes, title +".mp3", title);
			      mll.addVariable("hash", Main.getHash(PersonInfo.uid, title));
			      mll.addVariable("title", title);
			      mll.addVariable("uid", PersonInfo.uid);
				  mll.addVariable("key",Main.getHash(Math.random()*1000).toString());
                  mll.load("http://www.maxb-pro.ru/UploadMp3.php");
			   
			      Key.ShowKey(main);
			   }
			   else
			   {
				   var attention:Attention = new Attention("Текст содержит неверный символ", main);
				   attention.Show();
			   }
		   }
		   else
		   {
			  var attention:Attention = new Attention("Недостаточно тактов!", main);
		      attention.Show(); 
		   }
		}
		
		
		
		private function UpdataTableSongs(e:Event)
		{
		       var vars:URLVariables = new URLVariables();
			   var st:String = "http://maxb-pro.ru/Songs/" + PersonInfo.uid + "/" +(root as Main).MusicEditMovie.currentProject.title + ".mp3";
			   vars['hash'] = Main.getHash(PersonInfo.uid, txtInput.text, st);
			   vars['uid'] = PersonInfo.uid;
			   vars['text'] = txtInput.text;
			   vars['url'] = st;
			   vars['key'] = Main.getHash((Math.random()*1000).toString());
			   var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/UpdateTableSongs.php");
			   myrequest.method = URLRequestMethod.POST;
			   myrequest.data = vars;
			   var loader:URLLoader = new URLLoader();
			   loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			   loader.addEventListener(Event.COMPLETE, UpdataTableSongsSuccess);
			   loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			   loader.load(myrequest);
		}
		
		private function UpdataTableSongsSuccess(e:Event)
		{
			Key.HideKey(main);
			var response:String = e.target.data.response;
			if(response=="success")
			{
		       // Обновляем окружение
			    main.UpdateEnv(PersonInfo.fanat,PersonInfo.columb,PersonInfo.painter, ++PersonInfo.creater, 
									    40, PersonInfo.songs, this, "Публикация завершена!","Ошибка публикации. Сервер недоступен!");
		        
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
				   var attention:Attention = new Attention("Ошибка публикации", main);
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
		
		private function onCancel(e:MouseEvent)
		{
			(root as Main).removeChild(this);
		}
	}
	
}
