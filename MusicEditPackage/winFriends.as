package MusicEditPackage 
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.ByteArray;
	import flash.text.TextField;
	import vk.events.CustomEvent;
	
	public class winFriends extends MovieClip 
	{
		
		private var friends:Vector.<Friend> = null;
		private var file:ByteArray = null;
		private var responseFriendsInfo:Object = null;
		private var main:Main = null;
				
		public function winFriends(file:ByteArray) 
		{
			this.file = file;
			addEventListener(Event.ADDED_TO_STAGE, Added);
		}
		
		private function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			back.addEventListener(MouseEvent.MOUSE_OUT, Close);
			main = root as Main;
			PersonInfo.VK.api('getUserSettings', {},getUserSettingsSuccess, Failed);
			
		}
		
		private function getUserSettingsSuccess(response:Object)
		{
			 if (uint(response) & 2)
			 {
				  Key.ShowKey(main);
                  PersonInfo.VK.api('friends.get',{fields:'uid,last_name, first_name, photo_medium'}, onSuccess,Failed);  
		     }
		     else
		     {
			     PersonInfo.VK.callMethod("showSettingsBox",2);
				 PersonInfo.VK.addEventListener('onSettingsChanged', onSettingsChanged);
		     }
		}
		
		private function onSettingsChanged(e:CustomEvent)
		{
			if(uint(e.params[0]) & 2)
			{
				  Key.ShowKey(main);
                  PersonInfo.VK.api('friends.get',{fields:'uid,last_name, first_name, photo_medium'}, onSuccess,Failed);  
		     
			}
			else
			{
				PersonInfo.VK.callMethod("showSettingsBox",2);
				PersonInfo.VK.addEventListener('onSettingsChanged', onSettingsChanged);
			}
			
			  
		}
		
		private function Failed(e:Object)
		{
			Key.HideKey(main);
			back.addEventListener(MouseEvent.MOUSE_OUT, Close);
			var attention:Attention = new Attention("Сервер Вконтакте недоступен",  root as Main);
		    attention.Show();
		}
			
		
		
		private function onSuccess(response:Object)
		{
			Key.HideKey(main);
			
			responseFriendsInfo = response;
			var mv:MovieClip = new MovieClip();
			var localY:uint = 5;
			var localX:uint = 10;
			var counter:uint=0;
			var indexName:uint = 0;
			friends = new Vector.<Friend>();

			for(var i:uint=0; i<response.length; i++)
			{
				var friend:Friend = new Friend(response[i].last_name, response[i].first_name, response[i].photo_medium, response[i].uid, i, file);
				friends.push(friend);

				friend.x = localX;  friend.y = localY;
				mv.addChild(friend);
				counter++;
				indexName++;
				localX = localX + friend.width + 10;
				if(counter==4)
				{
					counter = 0;
					localY = localY + friend.height + 10;
					localX = 10;
					
				}
			}
			
			
			
			scroll.source = mv;
			input.addEventListener(Event.CHANGE,onInputChanged);
		}
		
		private function Close(e:MouseEvent)
		{
			if (e.relatedObject != null  &&  !(e.relatedObject is TextField) && !(e.relatedObject is Friend))
			  (root as Main).removeChild(this);
		}
		
	
		
		private function onInputChanged(e:Event)
		{
			var st:String  = e.currentTarget.text;
			if(st == "")
			{
				onSuccess(responseFriendsInfo);
			}
			else
			{
				
				var mv:MovieClip = new MovieClip();
				var localY:uint = 5;
			    var localX:uint = 10;
			    var counter:uint=0;
				
				for(var i:uint=0; i<friends.length; i++)
				{
					if(friends[i].last_name.search(st) != -1 || friends[i].first_name.search(st) != -1)
					{
						friends[i].x = localX;  friends[i].y = localY;
						mv.addChild(friends[i]);
						counter++;
				        localX = localX + friends[i].width + 10;
						if(counter==4)
				        {
					        counter = 0;
					        localY = localY + friends[i].height + 10;
					        localX = 10;
				        }
					}
				}    
				scroll.source = null;
			    scroll.source = mv;
				
				 
				 
			}
		}
	}
	
}
