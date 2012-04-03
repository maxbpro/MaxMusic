package MusicHitsPackage 
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class MusicHits extends MovieClip 
	{
		private var showCubes:Boolean = false;
		private var winCubes:InfoCubes = null;
		private var songs:Array = null;
		private var mv:MovieClip = null;
		private var localY:uint = 0;
		private var counter:uint = 0;
		private var timer:Timer = null;
		private var main:Main = null;
		
		public function MusicHits() 
		{
			btnRe.addEventListener(MouseEvent.CLICK, ShowRespects);
			btnHits.addEventListener(MouseEvent.CLICK, ReadMp3Songs);
			btnQuestion.addEventListener(MouseEvent.CLICK, OpenCubes);
		}
		
		public function Init()
		{
			main = root as Main;
			var st:String = PersonInfo.getStatus();
			PersonPanel.status.txt.text = st;
			if(st == "Воздыхатель")
			{
			   var format:TextFormat = PersonPanel.status.txt.getTextFormat();
			   trace(format);
			   format.size = 12;
			   PersonPanel.status.txt.setTextFormat(format);
			}
			PersonPanel.photo.source = null;
			PersonPanel.photo.source = PersonInfo.photoUrl;
			PersonPanel.photo.load();
			if((parent as Main).showWinRespect == false)
			{
			    ReadMp3Songs(null);
			}
			else
			{
				ShowRespects(null);
				(parent as Main).showWinRespect = false;
			}
		}
		
		public function ReadMp3Songs(e:MouseEvent)
		{
			   mainScreen.source = null;
			   var vars:URLVariables = new URLVariables();
			   vars['auth'] = PersonInfo.flashVars.auth_key;
			   vars['uid'] = PersonInfo.uid;
			   vars['key'] = Main.getHash((Math.random()*1000).toString());
			   var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/ReadTableSongs.php");
			   myrequest.method = URLRequestMethod.POST;
			   myrequest.data = vars;
			   var loader:URLLoader = new URLLoader();
			   loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			   loader.addEventListener(Event.COMPLETE, ReadTableSongsSuccess);
			   loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			   loader.load(myrequest);
			   Key.ShowKey(root as Main);
		}
		
		private function ReadTableSongsSuccess(e:Event)
		{
			Key.HideKey(root as Main);
			if(e.target.data.response == "success")
			{
				var result:String = e.target.data.result;
				mv = new MovieClip();
				localY = 0;
				counter = 0;
				songs = result.split('^');
				timer = new Timer(2000);
				timer.addEventListener(TimerEvent.TIMER, TimerTick);
				timer.start();
				
			}
			else
			{
				if(e.target.data.response =="atac")
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
				   var attention:Attention = new Attention("Сервер недоступен", root as Main);
				   attention.Show();
				}
			}
		}
		
		private function TimerTick(e:TimerEvent)
		{
				if(counter<songs.length-1)
				{
					var property:Array = songs[counter].split(';');
					var mp3Player:Mp3Player = new Mp3Player(property[0], property[1], property[2], property[3] , uint(property[4]));
					mp3Player.y = localY;
					mv.addChild(mp3Player);
					localY += (mp3Player.height-3.8);
				
				   mainScreen.source = null;
				   mainScreen.source = mv;
				   counter++;
				}
				else
				{
					timer.stop();
					timer.removeEventListener(TimerEvent.TIMER, TimerTick);
					timer = null;
				}
		}
		
		
		private function ShowRespects(e:MouseEvent)
		{
			Key.ShowKey( root as Main)
			var mv:MovieClip = new MovieClip();
			var respectPanel:RespectPanel = new RespectPanel("fanat", "Воздыхатель");
			mv.addChild(respectPanel);
			respectPanel = new RespectPanel("painter","Маляр");
			respectPanel.y = 190;
			mv.addChild(respectPanel);
			respectPanel = new RespectPanel("columb", "Колумб");
			respectPanel.y = 380;
			mv.addChild(respectPanel);
			respectPanel = new RespectPanel("creater", "Творец", true);
			respectPanel.y = 570;
			mv.addChild(respectPanel);
			mainScreen.source = null;
			mainScreen.source = mv;
		}
		

		
		
		private function OpenCubes(e:MouseEvent)
		{
			if(showCubes==false)
			{
				winCubes = new InfoCubes();
				(root as Main).addChild(winCubes);
				winCubes.btnClose.addEventListener(MouseEvent.CLICK, closeWinCubes);
				showCubes = true;
			}
			else
			{
				if(winCubes != null)
				{
				   (root as Main).removeChild(winCubes);
				   winCubes = null;
				}
				showCubes = false;
			}
			  
		}
		
		private function closeWinCubes(e:MouseEvent)
		{
			(root as Main).removeChild(winCubes);
			winCubes = null;
		}
		
		private function IOFail(e:IOErrorEvent)
		{
			Key.HideKey(root as Main);
			var attention:Attention = new Attention(e.text, root as Main);
			attention.Show();
		}
	}
	
}
