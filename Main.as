package  
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.system.Security;
	import MusicEditPackage.Creation.SamplePrototype.Sample;
	import flash.net.*;
	import MusicEditPackage.winSendToHits;
	import vk.APIConnection;
	import com.adobe.crypto.MD5;

	
	public class Main extends MovieClip
	{
        private var showWinSending:Boolean = false;
		public var showWinRespect:Boolean = false;
		private var newTacks:uint = 0;
		private var outputTextSuc:String = null;
		private var outputTextFail:String = null;
			
		public function Main() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Added);
		}
		
		private function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			stage.stageFocusRect = false;
			stage.showDefaultContextMenu = false;
			
			var flashVars:Object = stage.loaderInfo.parameters as Object;
			PersonInfo.flashVars = flashVars;
			PersonInfo.uid = flashVars['viewer_id'];
		    PersonInfo.VK = new APIConnection(flashVars);
			PersonInfo.VK.api('getProfiles',{uids:PersonInfo.uid, fields:'photo_medium'}, onSuccess, onFailed);
		}
		
		private function onSuccess(e:Object)
		{
			PersonInfo.photoUrl = e[0].photo_medium;
			PersonInfo.first_name = e[0].first_name;
			PersonInfo.last_name = e[0].last_name;
			MusicEditMovie.UserPanel.photo.source = PersonInfo.photoUrl;
			MusicEditMovie.UserPanel.photo.load();
		}
		
		private function onFailed(e:Object)
		{
            Key.HideKey(this);
			var attention:Attention = new Attention("Сервер Вконтакте недоступен", this);
			attention.Show();
			//Key.ShowKey(this,false);
		}
		
		
		public function UpdateEnv(fanat:uint, columb:uint, painter:uint, creater:uint, delta:uint, songs:String, 
								  win:MovieClip, outputTextSuc:String, outputTextFail:String)
		{
			this.outputTextSuc = outputTextSuc;
			this.outputTextFail = outputTextFail;
			PersonInfo.songs = songs;
			PersonInfo.fanat = fanat;
			PersonInfo.painter = painter;
			PersonInfo.creater = creater;
			PersonInfo.columb = columb;
			PersonInfo.tack = PersonInfo.tack - delta;
			newTacks = PersonInfo.tack;
			var vars:URLVariables = new URLVariables();
			vars['hash'] = Main.getHash(PersonInfo.uid, PersonInfo.fanat, PersonInfo.painter, PersonInfo.creater, PersonInfo.columb, PersonInfo.tack, PersonInfo.songs);
			vars['uid'] = PersonInfo.uid;
			vars['fanat'] = PersonInfo.fanat;
			vars['painter'] = PersonInfo.painter;
			vars['creater'] = PersonInfo.creater;
			vars['columb'] = PersonInfo.columb;
			vars['tack'] = PersonInfo.tack;
			vars['songs'] = PersonInfo.songs;

			var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/UpdateEnv.php");
			myrequest.method = URLRequestMethod.POST;
			myrequest.data = vars;
			var loader:URLLoader = new URLLoader();
		    loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, OnSuccess);
			loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			loader.load(myrequest);
			Key.ShowKey(this);
			if(uint(MusicEditMovie.UserPanel.tacks.txt.text)> newTacks)
			{
			   addEventListener(Event.ENTER_FRAME, onEnterFrameReduce);
			}
			else
			{
			   addEventListener(Event.ENTER_FRAME, onEnterFrameAdd);
			}
			if(win != null)
			{
			   removeChild(win);
			   win = null;
			}
		}
		
		private function OnSuccess(e:Event)
		{
			Key.HideKey(this);
			if(e.target.data.response == "success")
			{
			   var attention:Attention = new Attention(outputTextSuc, this);
	           attention.Show();
			}
			else
			{
				 var attention:Attention = new Attention(outputTextFail, this);
	            attention.Show();
			} 
		}
		
		private function onEnterFrameReduce(e:Event)
		{
			if(int(MusicEditMovie.UserPanel.tacks.txt.text) > newTacks)
			{
			   MusicEditMovie.UserPanel.tacks.txt.text = (int(MusicEditMovie.UserPanel.tacks.txt.text) - 1).toString();
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrameReduce);
			}
		}
		
		private function onEnterFrameAdd(e:Event)
		{
			if(int(MusicEditMovie.UserPanel.tacks.txt.text) < newTacks)
			{
			   MusicEditMovie.UserPanel.tacks.txt.text = (int(MusicEditMovie.UserPanel.tacks.txt.text) + 1).toString();
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrameAdd);
			}
		}
		
		public static function getHash(... args):String
		{
			var st:String = "";
			for(var i:uint=0; i<args.length; i++)
			{
				st = st + args[i] + "_" ;
			}
			st = MD5.hash(st);
			st = st + PersonInfo.flashVars.auth_key;
			return st;
		}
		
		
		private function IOFail(e:IOErrorEvent)
		{
            Key.HideKey(this);
			var attention:Attention = new Attention("Сервер недоступен", this);
			attention.Show();
		}
		
		
		

	}
	
}
