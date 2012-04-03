package MusicEditPackage.Creation
{
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.DisplayObject;
	import MusicEditPackage.MusicEdit;
	
	
	public class SamplesList extends MovieClip 
	{
		private static const WEITHOfCell:uint = 50;
		private static const HIGHTOfCell:uint = 30;
		private var mainMusic:MusicEdit = null;
		private var instrument:uint = 0;
		private var localX:uint = 10;
		private var localY:uint = 10;
		private var index:uint = 0;
		private var samples:Vector.<Object> = null;
		
		public function SamplesList(samples:Vector.<Object>, mainMusic:MusicEdit, instrument:uint) 
		{
			this.samples = samples;
			this.mainMusic = mainMusic;
			this.instrument = instrument;
			FillSamplesList(uint(samples[index][2]));
		}
		
		private function FillSamplesList(len:uint)
		{
			
			DeterminePosition(len);
			DrawSamplePreview(len);
			index++;
			if (index >= samples.length)
			   return;
			FillSamplesList(uint(samples[index][2]));
		}
		
		private function DeterminePosition(len:uint)
		{
			if (localX+WEITHOfCell*len > 260)
			{
				localX = 10;
				localY += 40;
			}
		}
		
		private function DrawSamplePreview(len:uint)
		{
			 var previewSample1:PreviewSample = new PreviewSample(samples[index][0], samples[index][1], len, mainMusic, instrument,samples[index][3]);
		     previewSample1.x = localX; 
			 previewSample1.y = localY;
		     previewSample1.name = samples[index][0];
		     addChild(previewSample1);
			 localX = localX + WEITHOfCell*len + 25;
		}
		
		
	}
	
}
