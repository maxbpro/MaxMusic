package  
{
	
	import flash.display.*;
	import flash.events.*;
	
	public class MainHelp extends MovieClip 
	{
		private var currentSprite:Sprite = null;
		
		public function MainHelp() 
		{
			Edit.addEventListener(MouseEvent.CLICK, ShowEditHelp);
			Public.addEventListener(MouseEvent.CLICK, ShowPublicHelp);
			Hit.addEventListener(MouseEvent.CLICK, ShowHitHelp);
			Re.addEventListener(MouseEvent.CLICK, ShowReHelp);
			btnClose.addEventListener(MouseEvent.CLICK, onClose);
			ShowEditHelp(null);
		}
		
		private function ShowEditHelp(e:MouseEvent)
		{
			if(currentSprite != null)
			{
				removeChild(currentSprite);
				currentSprite = null;
			}
			currentSprite = new EditHelp();
			currentSprite.x = 127;
			currentSprite.y = 241;
			addChild(currentSprite);
		}
		private function ShowPublicHelp(e:MouseEvent)
		{
			if(currentSprite != null)
			{
				removeChild(currentSprite);
				currentSprite = null;
			}
			currentSprite = new PublicHelp();
			currentSprite.x = 127;
			currentSprite.y = 241;
			addChild(currentSprite);
			
		}
		private function ShowHitHelp(e:MouseEvent)
		{
			if(currentSprite != null)
			{
				removeChild(currentSprite);
				currentSprite = null;
			}
			currentSprite = new HitHelp();
			currentSprite.x = 127;
			currentSprite.y = 241;
			addChild(currentSprite);
		}
		private function ShowReHelp(e:MouseEvent)
		{
			if(currentSprite != null)
			{
				removeChild(currentSprite);
				currentSprite = null;
			}
			currentSprite = new ReHelp();
			currentSprite.x = 127;
			currentSprite.y = 241;
			addChild(currentSprite);
		}
		
		private function onClose(e:MouseEvent)
		{
			(root as Main).removeChild(this);
			currentSprite = null;
		}
	}
	
}
