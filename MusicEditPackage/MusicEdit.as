package MusicEditPackage 
{
	
	import flash.display.MovieClip;
	import MusicEditPackage.*;
	import flash.events.*;
	import fl.data.DataProvider;
	import com.adobe.serialization.json.JSON;
	import MusicEditPackage.Field.MainField;
	import MusicEditPackage.LoadingPackage.Loading;
	import MusicEditPackage.Projects.Project;
	import MusicEditPackage.ProjectIO.*;
	import MusicEditPackage.Analizator.Summation;
	import flash.utils.Timer;
	
	public class MusicEdit extends MovieClip 
	{
		public var mainField:MainField = null;
		private var main:Main = null;
		public var currentProject:Project = null; 
		
		public var arrayOfProjects:DataProvider= null;
	    public var read:Boolean = false;
		private static var isLoaded:Boolean = false;
		
		public function MusicEdit() 
		{
			Mode.mode = "Dance";
			panel.btnPlay.addEventListener(MouseEvent.CLICK, Mix);
			panel.btnNext.addEventListener(MouseEvent.CLICK, btnNextHandler);
			panel.btnPrev.addEventListener(MouseEvent.CLICK, btnPrevHandler);
			panel.btnBegin.addEventListener(MouseEvent.CLICK, btnBeginHandler);
			panel.btnEnd.addEventListener(MouseEvent.CLICK, btnEndHandler);
			panel.btnPause.addEventListener(MouseEvent.CLICK, btnPauseHandler);
			btnHelp.addEventListener(MouseEvent.CLICK, onHelpShow);
			panel.btnPause.visible = false;
			var btnColumnAdd1:btnColumnAdd = new btnColumnAdd();
			btnColumnAdd1.addEventListener(MouseEvent.CLICK, ColumnAdd);
			btnColumnAdd1.x = 364; btnColumnAdd1.y = 234;
			addChild(btnColumnAdd1);
			arrayOfProjects = new DataProvider();
			if(MusicEdit.isLoaded == false)
			{
			   addEventListener(Event.ADDED_TO_STAGE, Added);
			   MusicEdit.isLoaded = true;
			}
		}
		
		private function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			var loading:Loading = new Loading(this);
			main = root as Main;
		}
		
		public function ShowDemo()
		{
			
			//arDemo:  0 - columnNum  1 - title  2  - genre  3 - infoAr
			//var projectDemo:String = '[6,"Demo","Dance",["0,maxb-pro.ru/Dance/Voice/DANCE_VOCALS003_140_A_SL1.mp3,Vocal3,2,0,free","16,maxb-pro.ru/Dance/Voice/DANCE_VOCALS003_140_A_SL1.mp3,Vocal3,2,0,open","32,maxb-pro.ru/Dance/Voice/DANCE_VOCALS003_140_A_SL1.mp3,Vocal3,2,0,free","48,maxb-pro.ru/Dance/Voice/DANCE_VOCALS003_140_A_SL1.mp3,Vocal3,2,0,free"]]';
		    var projectDemo:String = '[40,"Demo","Dance",["0,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","15,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","30,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","45,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","46,http://www.maxb-pro.ru/Dance/Drum/HIHAT011_DANCE_140_X_SC1.mp3,HIHAT011,1,1,free","60,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","62,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","75,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","77,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","90,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","92,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","105,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","107,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS017_DANCE_140_A_SC1.mp3,SNTHBS017,1,0,free","120,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","122,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","123,http://www.maxb-pro.ru/Dance/Keys/DANCE_PAD078_140_A_SL1.mp3,PAD078,4,3,open","135,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","137,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","150,http://www.maxb-pro.ru/Dance/Drum/HIHAT014_DANCE_140_X_SC1.mp3,HIHAT014,1,1,open","152,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","165,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","167,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS017_DANCE_140_A_SC1.mp3,SNTHBS017,1,0,free","180,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","182,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","183,http://www.maxb-pro.ru/Dance/Keys/DANCE_PAD078_140_A_SL1.mp3,PAD078,4,3,open","195,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","197,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","210,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","212,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","225,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","227,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS017_DANCE_140_A_SC1.mp3,SNTHBS017,1,0,free","240,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","242,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","255,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","257,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","258,http://www.maxb-pro.ru/Dance/Keys/DANCE_PAD087_140_A_SL1.mp3,PAD087,4,3,free","270,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","272,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","285,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","287,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS017_DANCE_140_A_SC1.mp3,SNTHBS017,1,0,free","300,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","302,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS027_DANCE_140_A_SC1.mp3,SNTHBS027,1,0,free","315,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","317,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS027_DANCE_140_A_SC1.mp3,SNTHBS027,1,0,free","319,http://www.maxb-pro.ru/Dance/Xtra/XTRA019_DANCE_140_X_SC1.mp3,XTRA019,2,7,free","330,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","332,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","335,http://www.maxb-pro.ru/Dance/Keys/DANCE_SYNTH037_140_A_SL1.mp3,SYNTH037,2,3,free","345,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","347,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS017_DANCE_140_A_SC1.mp3,SNTHBS017,1,0,free","360,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","362,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","363,http://www.maxb-pro.ru/Dance/Keys/DANCE_PAD032_140_A_SL1.mp3,PAD032,4,3,open","365,http://www.maxb-pro.ru/Dance/Keys/DANCE_SYNTH032_140_A_SL1.mp3,SYNTH032,4,3,open","375,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","377,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","382,http://www.maxb-pro.ru/Dance/Drum/KICK011_DANCE_140_X_SC1.mp3,KICK011,1,1,free","390,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","392,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","405,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","407,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS017_DANCE_140_A_SC1.mp3,SNTHBS017,1,0,free","412,http://www.maxb-pro.ru/Dance/Drum/KICK011_DANCE_140_X_SC1.mp3,KICK011,1,1,free","420,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","422,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","423,http://www.maxb-pro.ru/Dance/Keys/DANCE_PAD032_140_A_SL1.mp3,PAD032,4,3,open","425,http://www.maxb-pro.ru/Dance/Keys/DANCE_SYNTH032_140_A_SL1.mp3,SYNTH032,4,3,open","435,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","437,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","442,http://www.maxb-pro.ru/Dance/Drum/KICK011_DANCE_140_X_SC1.mp3,KICK011,1,1,free","450,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","452,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS019_DANCE_140_A_SC1.mp3,SNTHBS019,1,0,free","456,http://www.maxb-pro.ru/Dance/Xtra/XTRA007_DANCE_140_X_SC1.mp3,XTRA007,2,7,free","465,http://www.maxb-pro.ru/Dance/Drum/HIHAT013_DANCE_140_X_SC1.mp3,HIHAT013,1,1,free","467,http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS020_DANCE_140_A_SC1.mp3,SNTHBS020,1,0,open","487,http://www.maxb-pro.ru/Dance/Xtra/XTRA021_DANCE_140_X_SC1.mp3,XTRA021,1,7,free"]]';
		    
			var arDemo:Array = JSON.decode(projectDemo);
			infoPanel.title.text = arDemo[1];
			mainField = new MainField(arDemo[0],16,scrollPanel);
			Mode.ModeChange(arDemo[2], this);
			Decoder.Decode(mainField,arDemo[3], this);
			Project.scrollPanel = scrollPanel;
			
			currentProject = new Project(arDemo[1]);
			
			UserPanel.tacks.txt.text = PersonInfo.tack;
			initMainSamplesPanel();
			if(PersonInfo.tack == 30)
			     onHelpShow(null);
		}
		
		
		
		public function initMainSamplesPanel()
		{
			mainSamplesPanel.InitMainSamplesPanel(this);
		}
		
		public function updateScrollPanel()
		{
			scrollPanel.source = mainField;
		}
		
		
		private function Mix(e:MouseEvent)
		{
			Key.ShowKey(main);
			var timer:Timer = new Timer(50,1);
			timer.addEventListener(TimerEvent.TIMER, tick);
			timer.start();
		}
		
		
		
		private function tick(e:TimerEvent)
		{
			Summation.Mix(mainField);
		}
		
		public function Play()
		{
			Key.HideKey(main);
			Summation.PlayDinamic(Summation.outputSignal, this);
		}
				 
		
		private function ColumnAdd(e:MouseEvent)
		{
			mainField.ColumnAdd();
			scrollPanel.update();
		}
		
		private function btnNextHandler(e:MouseEvent)
		{
			mainField.gotoRight();
		}
		
		private function btnPrevHandler(e:MouseEvent)
		{
			mainField.gotoLeft();
		}
		
		private function btnBeginHandler(e:MouseEvent)
		{
			mainField.gotoBegin();
		}
		private function btnEndHandler(e:MouseEvent)
		{
			mainField.gotoEnd();
		}
		
		private function btnPauseHandler(e:MouseEvent)
		{
			Summation.Stop();
		}
		
		
		
		public function PauseShow()
		{
			panel.btnPause.visible = true;
			panel.btnPlay.visible = false;
		}
		
		public function PauseHide()
		{
			panel.btnPause.visible = false;
			panel.btnPlay.visible = true;
		}
		
		public function onHelpShow(e:MouseEvent)
		{
			main.addChild(new MainHelp());
		}
		
		
	}
	
}
