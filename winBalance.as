package  
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.InteractiveObject;
	import fl.events.*;
	import fl.controls.Slider;
	import flash.net.*;
	import vk.events.CustomEvent;
	
	public class winBalance extends MovieClip 
	{
		private var slider:Slider = null;
		private var currentVotes:uint = 0;
		private var currentTack:uint = 0;
		private var main:Main = null;
		
		public function winBalance() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Added);
		}
		
		private function Added(e:Event)
		{
			main = root as Main;
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			for(var i:uint=0; i<numChildren; i++)
            {
	            var obj:InteractiveObject= getChildAt(i) as InteractiveObject; 
	            if(obj!= null)
	              (getChildAt(i) as InteractiveObject).mouseEnabled = false;
            }
			slider = new Slider();
			slider.x = 43; slider.y = 213;
			slider.minimum = 10; slider.maximum = 99;
			slider.tickInterval = 1;
			addChild(slider);
			slider.addEventListener(SliderEvent.CHANGE, SliderChanged);
			btnBuy1.addEventListener(MouseEvent.CLICK, onBuy1);
			btnBuy3.addEventListener(MouseEvent.CLICK, onBuy3);
			btnBuy6.addEventListener(MouseEvent.CLICK, onBuy6);
			btnBuy.addEventListener(MouseEvent.CLICK, onBuy);
			btnBuy1.mouseEnabled = true;
			btnBuy3.mouseEnabled = true;
			btnBuy6.mouseEnabled = true;
			btnBuy.mouseEnabled = true;
		}
		
		private function SliderChanged(e:SliderEvent)
		{
			lblVoice.text = slider.value.toString();
			lblTack.text = (slider.value * 3 + 2).toString();
		}
		
		private function onBuy1(e:MouseEvent)
		{
			pay(1);
			currentTack = 3;
		}
		
		private function onBuy3(e:MouseEvent)
		{
			pay(3);
			currentTack = 11;
		}
		
		private function onBuy6(e:MouseEvent)
		{
			pay(6);
			currentTack = 22;
		}
		
		private function onBuy(e:MouseEvent)
		{
			pay(uint(slider.value));
			currentTack = uint(lblTack.text);
		}
		
		private function pay(votes:uint):void
		{
			  try
			  {
			      this.currentVotes = votes;
                  PersonInfo.VK.addEventListener("onBalanceChanged", balanceChanged);
			      PersonInfo.VK.callMethod("showPaymentBox", currentVotes);
			  }
			  catch(e:Error)
			  {
				   var attention:Attention = new Attention("Ошибка при работе с балансом", main);
				   attention.Show();
			  }
		}
		// вызов secure.withdrawVotes
		private function balanceChanged(e:CustomEvent):void
		{
			try
			{
			    var vars:URLVariables = new URLVariables();
			    vars['hash'] = Main.getHash(PersonInfo.uid, currentVotes );
			    vars['viewer_id'] = PersonInfo.uid;
			    vars['votes_amount'] = currentVotes;
				vars['key'] = Main.getHash((Math.random()*1000).toString());
			    var myrequest:URLRequest = new URLRequest("http://www.maxb-pro.ru/secureWithDrawVotes.php");
			    myrequest.method = URLRequestMethod.POST;
			    myrequest.data = vars;
			    var loader:URLLoader = new URLLoader();
			    loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			    loader.addEventListener(Event.COMPLETE, SecureWithDrawVotesSuccess);
			    loader.addEventListener(IOErrorEvent.IO_ERROR, InsertIOError);
			    loader.load(myrequest);
			}
			catch(e:Error)
			{
				var attention:Attention = new Attention("Сервер недоступен", main);
				attention.Show();
		    }
		}
		
		private function SecureWithDrawVotesSuccess(e:Event):void
		{
			if(e.target.data.response == "success")
			{
				main.UpdateEnv(PersonInfo.fanat,PersonInfo.columb,PersonInfo.painter,PersonInfo.creater, -currentTack,
							   PersonInfo.songs, null, "Пополнение баланса завершено", "Сервер недоступен");
			}
			else
			{
				var attention:Attention = new Attention("Сервер недоступен", main);
				attention.Show();
			}
			  
		}
		
		
		
		
		private function InsertIOError(e:IOErrorEvent):void
		{
			var attention:Attention = new Attention("Сервер недоступен", main);
			attention.Show();
		}
	}
	
}
