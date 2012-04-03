package MusicEditPackage.Creation
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import MusicEditPackage.*;
	import fl.events.*;
	import fl.controls.*;
    import MusicEditPackage.LoadingPackage.*;
	import flash.net.*;
	
	public class MainSamplesPanel extends MovieClip 
	{
		private var mainMusic:MusicEdit = null;
		public static var currentStyleIsReal:Boolean = true;
		private var question:Message = null;
		private var main:Main = null;
		private var help:Help = null;
		
		public function MainSamplesPanel( ) 
		{
			cmboxGenres.addEventListener(Event.CHANGE, styleChanged);
		}
		
		public function InitMainSamplesPanel(mainMusic:MusicEdit)
		{
			 this.mainMusic = mainMusic;
			 main = root as Main;
			 btnBassBeats.addEventListener(MouseEvent.CLICK, btnBassBeatsHandler);
			 btnDrum.addEventListener(MouseEvent.CLICK, btnDrumHandler);
			 btnLoop.addEventListener(MouseEvent.CLICK, btnLoopHandler);
			 btnKeys.addEventListener(MouseEvent.CLICK, btnKeysHandler);
			 btnFx.addEventListener(MouseEvent.CLICK, btnFxHandler);
			 btnSphere.addEventListener(MouseEvent.CLICK, btnSphereHandler);
			 btnVoice.addEventListener(MouseEvent.CLICK, btnVoiceHandler);
			 btnXtra.addEventListener(MouseEvent.CLICK, btnXtraHandler);
			 if(Mode.mode=="Dance")
			 {
				 cmboxGenres.selectedIndex = 0;
				 styleChanged(null);
			 }
			 else
			 {
				 if(Mode.mode =="DrumNBass")
				 {
						cmboxGenres.selectedIndex = 1; 
						styleChanged(null);
				 }
				 else
				 {
					 if(Mode.mode =="Pop")
					 {
							cmboxGenres.selectedIndex = 2; 
							styleChanged(null);
					 }
				 }
				 
			 }
			 //Invite
			 if(PersonInfo.invite == 0)
			 {
				bonus.addEventListener(MouseEvent.ROLL_OVER, overInvite); 
				bonus.addEventListener(MouseEvent.ROLL_OUT, outInvite);
				bonus.addEventListener(MouseEvent.CLICK, showInvite);
			 }
			 else
			 {
				 bonus.visible = false;
				 bonus.removeEventListener(MouseEvent.CLICK, showInvite);
			 }
		    
		}
		
		private function overInvite(e:MouseEvent)
		{
			bonus.txt.textColor = 0xFFFFFF;
			buttonMode = true;
			
	     help = new Help("Стоимость сэмпла равна числу его тактов. После открытия сэмпл можно использовать неограниченное количество раз", root as Main,155,115, e.stageX, e.stageY );

		
	        if(main != null)
			{
			    help = new Help("Пригласите друзей и получите бонус в 20 тактов!", main,120,60,e.stageX, e.stageY);
				help.Show();
			}
		}
		
		private function outInvite(e:MouseEvent)
		{
			bonus.txt.textColor = 0xFF0000;
			buttonMode = false;
			if(help != null)
			   help.Hide();
		}
		
		private function showInvite(e:MouseEvent)
		{
		    question  = new Message(1, "Вы хотите выбрать друзей, которым будет отправлено приглашение?");
			main.addChild(question);
			question.btnYes.addEventListener(MouseEvent.CLICK, btnYes);
			question.btnNo.addEventListener(MouseEvent.CLICK, HideQuestion);
		}
		
		private function btnYes(e:MouseEvent)
		{
			main.removeChild(question);
			PersonInfo.VK.callMethod('showInviteBox');
			var vars:URLVariables = new URLVariables();
			vars['hash'] = Main.getHash(PersonInfo.uid);
			vars['uid'] = PersonInfo.uid;
			vars['key'] = Main.getHash((Math.random()*1000).toString());
			var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/InviteFriends.php");
			myrequest.method = URLRequestMethod.POST;
			myrequest.data = vars;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			loader.addEventListener(Event.COMPLETE, inviteFriendsSuccess);
			loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			loader.load(myrequest);
			removeChild(bonus);
		    bonus = null;
			PersonInfo.invite = 1;
		}
		
	    private function inviteFriendsSuccess(e:Event)
		{
			if(e.target.data.response == "success")
			{
				main.UpdateEnv(PersonInfo.fanat,PersonInfo.columb,PersonInfo.painter,PersonInfo.creater,-20,
							   PersonInfo.songs, null,"Бонус получен", "Сервер временно недоступен");
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
		
		private function HideQuestion(e:MouseEvent)
		{
			main.removeChild(question);
		}
		
		private function btnBassBeatsHandler(e:MouseEvent)
	    { 
		     var mySampleList:SamplesList = new SamplesList(Loading.genres[cmboxGenres.selectedIndex][0], mainMusic, 0); 
			 samplesListScroll.source = mySampleList;
			 
	    }
		private function btnDrumHandler(e:MouseEvent)
	    {
		     var mySampleList:SamplesList = new SamplesList(Loading.genres[cmboxGenres.selectedIndex][1], mainMusic, 1);
			 samplesListScroll.source = mySampleList;
	    }
		private function btnLoopHandler(e:MouseEvent)
	    {
		     var mySampleList:SamplesList = new SamplesList(Loading.genres[cmboxGenres.selectedIndex][2], mainMusic, 2);
			 samplesListScroll.source = mySampleList;
	    }
		
		private function btnKeysHandler(e:MouseEvent)
	    {
		     var mySampleList:SamplesList = new SamplesList(Loading.genres[cmboxGenres.selectedIndex][3], mainMusic, 3);
			 samplesListScroll.source = mySampleList;
	    }
		private function btnFxHandler(e:MouseEvent)
	    {
		     var mySampleList:SamplesList = new SamplesList(Loading.genres[cmboxGenres.selectedIndex][4], mainMusic,  4);
			 samplesListScroll.source = mySampleList;
	    }
		private function btnSphereHandler(e:MouseEvent)
	    {
		     var mySampleList:SamplesList = new SamplesList(Loading.genres[cmboxGenres.selectedIndex][5], mainMusic, 5);
			 samplesListScroll.source = mySampleList;
	    }
		
		private function btnVoiceHandler(e:MouseEvent)
	    {
		     var mySampleList:SamplesList = new SamplesList(Loading.genres[cmboxGenres.selectedIndex][6], mainMusic, 6);
			 samplesListScroll.source = mySampleList;
	    }
		
		private function btnXtraHandler(e:MouseEvent)
	    {
		     var mySampleList:SamplesList = new SamplesList(Loading.genres[cmboxGenres.selectedIndex][7], mainMusic , 7);
			 samplesListScroll.source = mySampleList;
	    }
		
		private function styleChanged(e:Event)
		{
			switch(cmboxGenres.selectedIndex)
			{
				case 0:
				{
					pictures.gotoAndStop(1);
					if(Mode.mode == "Dance")
					  currentStyleIsReal = true;
					else
					  currentStyleIsReal = false;
					samplesListScroll.source = null;
					btnFx.txt.text = "FX";
					break;
				}
				case 1:
				{
					pictures.gotoAndStop(2);
					if(Mode.mode == "DrumNBass")
					  currentStyleIsReal = true;
					else
					  currentStyleIsReal = false;
					samplesListScroll.source = null;
					btnFx.txt.text = "FX";
					break;
				}
				case 2:
				{
					pictures.gotoAndStop(3);
					if(Mode.mode == "Pop")
					  currentStyleIsReal = true;
					else
					  currentStyleIsReal = false;
					samplesListScroll.source = null;
					btnFx.txt.text = "Guitar";
					break;
				}
			}
			
		}
		public static function GetColor(instrument:uint):Array
		{
			var colors:Array = new Array();
			switch(instrument)
			{
				case 0:
				{
					colors = [0xCC00FF, 0xFF6633];
					break;
				}
				case 1:
				{
					colors = [0x70A662, 0x7BF017];
					break;
				}
				case 2:
				{
					colors = [0xC9090B, 0xF733BB];
					break;
				}
				case 3:
				{
					colors = [0x999999, 0xCCCCCC];
					break;
				}
				case 4:
				{
					colors = [0xFFFF66, 0x00CCFF];
					break;
				}
				case 5:
				{
					colors = [0x1027EE, 0x0B2C72];
					break;
				}
				case 6:
				{
					colors = [0xE98319, 0xF7FC15];
					break;
				}
				case 7:
				{
					colors = [0x9900FF, 0x99FF66];
					break;
				}
			}
			return colors;
		}
		
		
		private function IOFail(e:IOErrorEvent)
		{
			var attention:Attention = new Attention("Сервер недоступен", main);
			attention.Show();
		}
	}
	
	
	
}
