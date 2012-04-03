package  MusicHitsPackage
{
	
	import flash.display.MovieClip;
	import MusicHitsPackage.NotesEncoder;
	import flash.display.Sprite;
	
	
	public class PersonHitsForEdit extends Sprite
	{
		
		
		public function PersonHitsForEdit() 
		{
			NotesEncoder.Encode(PersonInfo.fanat);
			var line:Sprite = NotesEncoder.GetLineNotes();
			line.x = 150;
			line.y = -5;
			addChild(line);
			
			NotesEncoder.Encode(PersonInfo.painter);
			line = NotesEncoder.GetLineNotes();
			line.x = 100;
			line.y = 57;
			addChild(line);
			
			NotesEncoder.Encode(PersonInfo.columb);
			line = NotesEncoder.GetLineNotes();
			line.x = 100;
			line.y = 114;
			addChild(line);
			
			NotesEncoder.Encode(PersonInfo.creater);
			line = NotesEncoder.GetLineNotes();
			line.x = 100;
			line.y = 170;
			addChild(line);
		}
	}
	
}
