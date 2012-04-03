package  MusicEditPackage.LoadingPackage
{
	
	public class FillSamplesInfo 
	{
		

		public function FillSamplesInfo() 
		{
			// constructor code
		}
		
		public static function Init(): Vector.<Object>
		{
			var stLengths:String = new String();
			var genres:Vector.<Object> = new Vector.<Object>();  // 0 - Dance   1  - DrumNBass  2 - POP
			       
			var instruments:Vector.<Object> = new Vector.<Object>();    //0 - BassBeat, 1 - DrumLoop ...
			
			// BassBeats
			
			stLengths = "2,2,2,2,2,2,2,2,2,2,2,4,4,1,2,2,2,2,2,2,2,4,4,2,2,2,2,2,2,2,4,4,2,2,2,1,2,2,2,2,2,2,2,2,2,2,2,4,4,2,2,2,3,4,4,4,2,2,4,4,4,4,2,2,4,4,4,4,2,4,4,4,4,4,2,4,4,4,4,4,4,4,4,4,1,4,4,2,4,2,4,4,2,4,2,4,4,1,1,1,1,1,4,4,1,1,1,4,4,4,4,4,1,1,1,1,1,4,4,1,2,1,4,4,1,1,1,4,4,1,1,1,4,4,1,1,1,1,4,4,1,2,4,4,1,1,1,1,4,4,1,1,1,1,4,4,1,1,1,1,4,4,1,1,1,1,4,4,1,1,1,1,4,4,1,1,1,1,4,4,1,1,1,1,4,4,1,1,1,1,4,4,1,1,1,1";
			var instrument:Vector.<Object> =  FillTitleUrlLength(196, "BASS", "http://www.maxb-pro.ru/Dance/BassBeats/DANCE_BASS", "_140_A_SL1.mp3", stLengths.split(","));
			stLengths = "2,2,2,2,2,2,2,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,2,2,2,2,2";
			instrument = instrument.concat( FillTitleUrlLength(151,"BEATS","http://www.maxb-pro.ru/Dance/BassBeats/DANCE_BEATS","_140_X_SL1.mp3", stLengths.split(",")));
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
			instrument = instrument.concat( FillTitleUrlLength(76,"SNTHBS","http://www.maxb-pro.ru/Dance/BassBeats/SNTHBASS","_DANCE_140_A_SC1.mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			
			// Drum
			
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1";
			instrument =  FillTitleUrlLength(15, "CLAP", "http://maxb-pro.ru/Dance/Drum/CLAP", "_DANCE_140_X_SC1.mp3", stLengths.split(","));
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
			instrument = instrument.concat( FillTitleUrlLength(16,"HIHAT","http://www.maxb-pro.ru/Dance/Drum/HIHAT","_DANCE_140_X_SC1.mp3", stLengths.split(",")));
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
			instrument = instrument.concat( FillTitleUrlLength(16,"KICK","http://www.maxb-pro.ru/Dance/Drum/KICK","_DANCE_140_X_SC1.mp3", stLengths.split(",")));
		    instruments.push(instrument);
			
			//Loop
			
			stLengths = "1,1,1,1,1";
			instrument = FillTitleUrlLength(6,"LOOP","http://www.maxb-pro.ru/Dance/Loop/DRUMLOOP","_DANCE_140_X_SC1.mp3", stLengths.split(","));
			instruments.push(instrument);
			
			
			// Keys
			
			stLengths = "2,4,4,8,4,4,4,4,8,8,4,4,8,8,4,4,8,7,4,4,2,8,8,4,4,2,2,2,4,4,4,4,4,4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,8,8,8,8,8,8,4,4,4,4,4,2,2,2,2,2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4,4,4,4,4,4,8,8,8,8,8";
			instrument =  FillTitleUrlLength(95, "PAD", "http://www.maxb-pro.ru/Dance/Keys/DANCE_PAD", "_140_A_SL1.mp3", stLengths.split(","));
			stLengths = "2,2,2,3,2,2,4,4,2,2,4,4,8,2,2,2,2,2,2,2,2,4,2,2,2,2,2,4,4,4,3,4,4,2,4,2,2,4,4,1,2,4,2,2,2,2,4,4,4,3";
			instrument = instrument.concat( FillTitleUrlLength(51,"SYNTH","http://www.maxb-pro.ru/Dance/Keys/DANCE_SYNTH","_140_A_SL1.mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			//Fx
			
			stLengths = "3,3,4,2,2,2,2,2,2,2,2,2,2,2,4,4,4,4,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,3,4,3,1,4,3,1,1,1,1,1,2,1,4,1,2,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,2,1,1,1";
			instrument = FillTitleUrlLength(121,"FX","http://www.maxb-pro.ru/Dance/Fx/DANCE_FX","_140_X_SL1.mp3", stLengths.split(","));
			instruments.push(instrument);
			
			//Sphere
			
			stLengths = "6,6,8,8,8,8,8,8,8,8,8,8,8,8,6,8,8,8,8,6,8,8,8,8,8,8,8,8,8,7,8,8,8,8,6,8,8,8,8,6";
			instrument =  FillTitleUrlLength(41, "SPR(L)", "http://www.maxb-pro.ru/Dance/Sphere/SYNTHPAD", "_DANCE_140_A_SC1(L).mp3", stLengths.split(","));
			stLengths = "6,6,8,8,8,8,8,8,8,8,8,8,8,8,6,8,8,8,8,6,8,8,8,8,8,8,8,8,8,7,8,8,8,8,6,8,8,8,8,6";
			instrument = instrument.concat( FillTitleUrlLength(41,"SPR(R)","http://www.maxb-pro.ru/Dance/Sphere/SYNTHPAD","_DANCE_140_A_SC1(R).mp3", stLengths.split(",")));
			
			instruments.push(instrument);
			
			
			
			// Voice
			
			stLengths = "1,1,1,1,1,3,1,1,1,1,1,1,1,1,1,1,2,2,1,3,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,2,4,1,1,4,1,3,1,1,2,4,4,4,2,2,5,5,3,5,4,5,2,1,1,1,2,1,1,1,2,1,3,1,1,1,1,2,1,1,1,1,2,2,2,2,1,1,2,1,1";
			instrument =  FillTitleUrlLength(100, "VOCALS", "http://www.maxb-pro.ru/Dance/Voice/DANCE_VOCALS", "_140_A_SL1.mp3", stLengths.split(","));
			stLengths = "1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
			instrument = instrument.concat( FillTitleUrlLength(23,"RAPBOY","http://www.maxb-pro.ru/Dance/Voice/RAPBOY","_DANCE_140_X_SC1.mp3", stLengths.split(",")));
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
			instrument = instrument.concat( FillTitleUrlLength(23,"VCEFX","http://www.maxb-pro.ru/Dance/Voice/VOICEFX","_DANCE_140_X_SC1.mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			
		
			
			//Xtra
			
			stLengths = "2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,4,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1";
			instrument =  FillTitleUrlLength(51, "EXTRA", "http://www.maxb-pro.ru/Dance/Xtra/DANCE_EXTRA", "_140_A_SL1.mp3", stLengths.split(","));
			stLengths = "2,2,2,2,2,2,2,2,2,2,2,2,1,2,2,2,2,3,2,2,1,2";
			instrument = instrument.concat( FillTitleUrlLength(23,"XTRA","http://www.maxb-pro.ru/Dance/Xtra/XTRA","_DANCE_140_X_SC1.mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			
			
			
			  // заталкиваем Dance
		    genres.push(instruments);
			
			
			
			
			
			
			//DRUM N BASE
			instruments = new Vector.<Object>();
			
			//BassBeats

			stLengths = "4,4,4,4,4,4,4,4,4,2,2,2,2,2,2,2,2,2,2,2,2,2,1,2,2,2,2,2,2,1,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2,2";
			instrument =  FillTitleUrlLength(60, "BASS", "http://www.maxb-pro.ru/DrumNBass/BassBeats/SNTHBASS", "_DB_160_C_SC1.mp3", stLengths.split(","));
			stLengths = "4,4,4,4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2";
			instrument = instrument.concat( FillTitleUrlLength(26,"UPRIGH","http://www.maxb-pro.ru/DrumNBass/BassBeats/UPRIGHT","_DB_160_C_SC1.mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			//Drum
			
			stLengths = "1,2,2,4";
			instrument =  FillTitleUrlLength(5, "CYMBL", "http://www.maxb-pro.ru/DrumNBass/Drum/CYMBALE", "_DB_160_X_SC1.mp3", stLengths.split(","));
			stLengths = "1,1,1,1,1,1,1,1,1,1,1";
			instrument = instrument.concat( FillTitleUrlLength(12, "HIHAT", "http://www.maxb-pro.ru/DrumNBass/Drum/HIHAT", "_DB_160_X_SC1.mp3", stLengths.split(",")));
			stLengths = "1,1,1,1,1,2,2,2,1,1";
			instrument = instrument.concat( FillTitleUrlLength(11, "KICK", "http://www.maxb-pro.ru/DrumNBass/Drum/KICK", "_DB_160_X_SC1.mp3", stLengths.split(",")));
			stLengths = "2,2,3,2,2,2,2,2,4,4,3,3,2,2,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,8,1,1,1,1,1,1,1,1";
			instrument = instrument.concat( FillTitleUrlLength(39,"PERC","http://www.maxb-pro.ru/DrumNBass/Drum/PERCLOOP","_DB_160_X_SC1.mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			//Loop
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
			instrument = FillTitleUrlLength(97, "LOOP", "http://www.maxb-pro.ru/DrumNBass/Loop/DRUMLOOP", "_DB_160_X_SC1.mp3", stLengths.split(","));
			instruments.push(instrument);
			
			//Keys

			stLengths = "5,5,4,4,4,4,4,2,2,2,2,1,2,2,2";
			instrument =  FillTitleUrlLength(16, "SYN(L)", "http://www.maxb-pro.ru/DrumNBass/Keys/SYNTH", "_DB_160_C_SC1(L).mp3", stLengths.split(","));
			stLengths = "5,5,4,4,4,4,4,2,2,2,2,1,2,2,2,2,2,2,2,1,4,1,1,2,2,2,2,2";
			instrument = instrument.concat( FillTitleUrlLength(29,"SYN(R)","http://www.maxb-pro.ru/DrumNBass/Keys/SYNTH","_DB_160_C_SC1(R).mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			//Fx

			stLengths = "4,1,2,2,2,1,2,4,4,2,2,4,2,4,8,4,2,4,2,4,2,4,4,2,4,1,1,1,1,3";
			instrument =  FillTitleUrlLength(31, "FX", "http://www.maxb-pro.ru/DrumNBass/Fx/FX", "_DB_160_X_SC1.mp3", stLengths.split(","));
			instruments.push(instrument);
			
			
			
			//Sphere
			
			stLengths = "2,2,2,2,2,2,2,2,2";
			instrument =  FillTitleUrlLength(10, "SPHERE", "http://www.maxb-pro.ru/DrumNBass/Sphere/SPHERE", "_DB_160_C_SC1.mp3", stLengths.split(","));
			stLengths = "4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2,2,2,2,4,2,2,4";
			instrument = instrument.concat( FillTitleUrlLength(26,"PAD(R)","http://www.maxb-pro.ru/DrumNBass/Sphere/SYNTHPAD","_DB_160_C_SC1(R).mp3", stLengths.split(",")));
			stLengths = "4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2,2,2,2,4,2,2,4";
			instrument = instrument.concat( FillTitleUrlLength(26,"PAD(L)","http://www.maxb-pro.ru/DrumNBass/Sphere/SYNTHPAD","_DB_160_C_SC1(L).mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			//Voice
			
			stLengths = "2,3,1,3,4,4,4,3,3,3,3,4,2,2,4,4,3,1,2,2,4";
			instrument =  FillTitleUrlLength(22, "BOY", "http://www.maxb-pro.ru/DrumNBass/Voice/VOICEBOY", "_DB_160_X_SC1.mp3", stLengths.split(","));
			instruments.push(instrument);
			
			//Xtra
			stLengths = "2,2,4,4,4,4,2,4,2,4,4,4,4,4,2,5,4,2,2,2,2";
			instrument =  FillTitleUrlLength(22, "XTR(L)", "http://www.maxb-pro.ru/DrumNBass/Xtra/XTRA", "_DB_160_C_SC1(L).mp3", stLengths.split(","));
			stLengths = "2,2,4,4,4,4,2,4,2,4,4,4,4,4,2,5,4,2,2,2,2";
			instrument = instrument.concat( FillTitleUrlLength(22,"XTR(R)","http://www.maxb-pro.ru/DrumNBass/Xtra/XTRA","_DB_160_C_SC1(R).mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			
			// заталкиваем DRUM N BASE
		    genres.push(instruments);
			
			
			
			
			//POP

			instruments = new Vector.<Object>();
			//BassBeats
			stLengths = "2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,4";
			instrument =  FillTitleUrlLength(71, "BASS", "http://www.maxb-pro.ru/Pop/BassBeats/ELECBASS", "_POP_90_D_SC1.mp3", stLengths.split(","));
			instruments.push(instrument);
			
			//Drum
			
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
			instrument =  FillTitleUrlLength(33, "PRCSSN", "http://www.maxb-pro.ru/Pop/Drum/PERCUSSN", "_POP_90_X_SC1.mp3", stLengths.split(","));
			instruments.push(instrument);
			
			//Loop
			
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
			instrument =  FillTitleUrlLength(81, "LOOP", "http://www.maxb-pro.ru/Pop/Loop/DRUMLOOP", "_POP_90_X_SC1.mp3", stLengths.split(","));
			instruments.push(instrument);
			
			//Keys

			stLengths = "2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2";
			instrument =  FillTitleUrlLength(51, "PIANO", "http://www.maxb-pro.ru/Pop/Keys/PIANO", "_POP_90_D_SC1.mp3", stLengths.split(","));
			instruments.push(instrument);
			
			//Guitar
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,1,2,2,2,2,2,1,2,2,2,2,2,2,2,2,2,2,2,2,2,1,2,2,2,2,2,1,1,2,2,2,1,1,2,2,2,2,2,2,2";
			instrument =  FillTitleUrlLength(71, "ACST", "http://www.maxb-pro.ru/Pop/Guitar/ACSTGUIT", "_POP_90_D_SC1.mp3", stLengths.split(","));
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2";
			instrument = instrument.concat( FillTitleUrlLength(46,"ELEC","http://www.maxb-pro.ru/Pop/Guitar/ELECGUIT","_POP_90_D_SC1.mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			//Sphere
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,4,4,4,4,4,4,4";
			instrument =  FillTitleUrlLength(31, "SPR(L)", "http://www.maxb-pro.ru/Pop/Sphere/SYNTHPAD", "_POP_90_D_SC1(L).mp3", stLengths.split(","));
			stLengths = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,4,4,4,4,4,4,4";
			instrument = instrument.concat( FillTitleUrlLength(31,"SPR(R)","http://www.maxb-pro.ru/Pop/Sphere/SYNTHPAD","_POP_90_D_SC1(R).mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			//Voice
			
			stLengths = "1,2,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,1,1,1,1,1,1,2,2,2,2,2,2,2,4,4,4,4,3,5,4";
			instrument =  FillTitleUrlLength(38, "BOY", "http://www.maxb-pro.ru/Pop/Voice/VOICEBOY", "_POP_90_D_SC1.mp3", stLengths.split(","));
			stLengths = "2,2,2,2,2,2,2,2,2,1,1,2,2,4,1,4,4,2,2,1";
			instrument = instrument.concat( FillTitleUrlLength(21,"GIRL","http://www.maxb-pro.ru/Pop/Voice/VOICEGRL","_POP_90_D_SC1.mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			//Xtra
			
			stLengths = "2,2,2,2,2,2,2,2";
			instrument =  FillTitleUrlLength(9, "STRING", "http://www.maxb-pro.ru/Pop/Xtra/STRING", "_POP_90_D_SC1(R).mp3", stLengths.split(","));
			stLengths = "2,2,2,2,2,2,2,2";
			instrument = instrument.concat( FillTitleUrlLength(9,"STRING","http://www.maxb-pro.ru/Pop/Xtra/STRING","_POP_90_D_SC1(L).mp3", stLengths.split(",")));
			stLengths = "4,4,2,2";
			instrument = instrument.concat( FillTitleUrlLength(5,"XTR(R)","http://www.maxb-pro.ru/Pop/Xtra/XTRA","_POP_90_D_SC1(R).mp3", stLengths.split(",")));
			stLengths = "4,4,2,2";
			instrument = instrument.concat( FillTitleUrlLength(5,"XTR(L)","http://www.maxb-pro.ru/Pop/Xtra/XTRA","_POP_90_D_SC1(L).mp3", stLengths.split(",")));
			instruments.push(instrument);
			
			
			// заталкиваем POp
		    genres.push(instruments);
			
			
			return genres;
		}
		
		private static function FillTitleUrlLength(  count:uint ,title:String , urlBegin:String, urlEnd:String ,
												     lengths:Array): Vector.<Object>
		{
		    var samples:Vector.<Object> = new Vector.<Object>();
			
			for(var i:uint=1; i < count; i++)
			{
		        var contents:Vector.<String> = new Vector.<String>();
				var url:String = new String();
				if(i<10)
				{
					 contents.push(title + "00" + i); 
			         url = urlBegin + "00" + i + urlEnd;
			         contents.push(url);
				}
				else
				{
					if(i<100)
					{
						contents.push(title + "0" + i); 
						url = urlBegin + "0" + i + urlEnd;
			            contents.push(url);
					}
					else
					{
						contents.push(title + i); 
			            url = urlBegin  + i + urlEnd;
			            contents.push(url);
					}
				}
			   
				contents.push(lengths[i-1]);
				if(i%2==0)
				{
					if(PersonInfo.opened!= null)
					{
					   if(PersonInfo.opened.indexOf(url)!= -1)
				          contents.push("open");
					   else
					      contents.push("close");
					}
					else
					  contents.push("close");
				}
				else
				{
					contents.push("free");
				}
				
				
		
				
				samples.push(contents);
		    }
			
			return samples;
		}
		
		
		
		

	}
	
}
