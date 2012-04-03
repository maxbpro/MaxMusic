package MusicHitsPackage 
{
	
	import flash.display.MovieClip;
	import flash.media.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import fl.events.*;
	import flash.display.Shape;
	import flash.utils.ByteArray;
	import flash.display.Graphics;
	import fl.containers.ScrollPane;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.utils.Timer;
	import flash.net.*;
	import vk.APIConnection;

	public class Mp3Player extends MovieClip 
	{
		private const PLOT_HEIGHT:int = 100; 
        private const CHANNEL_LENGTH:int = 125; 
		private var sound:Sound = null;
		private var channel:SoundChannel = null;
		public var url:String = null;
		private var time:String = null;
		private var myText:String = null;
		private var info:String = null;
		private var voices:uint = 0;
		
		private var position:Number = 0;
		private var isDownLoaded:Boolean = false;
		private var mixBytes:ByteArray = null;
		private var main:Main = null;
		private var DateObject:Date = null;
		private var timer:Timer = null;
		private var mes:Message = null;
		
		
		public function Mp3Player(url:String, time:String, myText:String, info:String, voices:uint ) 
		{
			this.url = url;
			this.time = time;
			this.myText = myText;
			this.info = info;
			this.voices = voices;
			btnPlay.addEventListener(MouseEvent.CLICK, DownloadStart);
			visualPanel.btnPlay.addEventListener(MouseEvent.CLICK, DownloadStart);
			btnPause.addEventListener(MouseEvent.CLICK, Pause);
			btnStop.addEventListener(MouseEvent.CLICK, Stop);
			btnPause.mouseEnabled = false;
			btnStop.mouseEnabled = false;
			slider.maximum = 100;
			btnYes.addEventListener(MouseEvent.CLICK, SendVoice);
	        addEventListener(Event.ADDED_TO_STAGE, Added);
		}
		
		private function Added(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, Added);
			note.text = myText;
			voicesLabel.text = voices.toString();
			title.text = basename(url);
			
			var infoAr:Array = info.split('|');
                
				
			// photo infoAr[0] - uid
			PersonInfo.VK.api('getProfiles', {uids: infoAr[0], fields: 'last_name, first_name, photo_medium'}, onSuccess, onFailed);
				
			NotesEncoder.Encode(infoAr[1]);
			var line:Sprite = NotesEncoder.GetLineNotes();
			line.width /= 2; line.height /=2;
			line.x = 190; line.y = 100;
		    addChild(line);
			NotesEncoder.Encode(infoAr[2]);
			var line:Sprite = NotesEncoder.GetLineNotes();
			line.width /= 2; line.height /=2;
			line.x = 190; line.y = 125;
            addChild(line);
			NotesEncoder.Encode(infoAr[3]);
			var line:Sprite = NotesEncoder.GetLineNotes();
			line.width /= 2; line.height /=2;
			line.x = 190; line.y =145;
			addChild(line);
			NotesEncoder.Encode(infoAr[4]);
			var line:Sprite = NotesEncoder.GetLineNotes();
			line.x = 190; line.y = 162;
			line.width /= 2; line.height /=2;
			addChild(line);
			
			main = root as Main;
			DateObject = new Date(Number(time)*1000);
			var nowDate:Date = new Date();
			
			if( (nowDate.getTime() - DateObject.getTime()) > 604800000)
			{
			   var cube:Sprite = TimeConvertToCube(   nowDate.getTime() - DateObject.getTime()   );
			   cube.x = 12; cube.y = 134;
			   addChild(cube);
			}
			
			timer = new Timer(5000);
			timer.addEventListener(TimerEvent.TIMER, onTick);
			timer.start();
			
		}
		
		private function onSuccess(e:Object)
		{
			photo.source = e[0].photo_medium;
			photo.load();
			fio.text = e[0].first_name + " " + e[0].last_name;
		}
		
		private function onFailed(e:Object)
		{
			var attention:Attention = new Attention("Сервер Вконтакте недоступен", root as Main);
			attention.Show();
		}
		
		
		private function DownloadStart(e:MouseEvent)
		{
			if(isDownLoaded == false)
			{
			   sound = new Sound();
			   sound.load(new URLRequest(url));
			   isDownLoaded = true;
			   position = 0;
			}
			mixBytes = new ByteArray();
			channel = sound.play(position);
		    addEventListener(Event.ENTER_FRAME, onEnterFrame);
		    channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		    btnPause.mouseEnabled = true;
	   	    btnStop.mouseEnabled = true;
			btnPlay.mouseEnabled = false;
			visualPanel.visible = false;
			
		}
		
		private function onEnterFrame(e:Event)
		{
			var estimatedLength:int = Math.ceil(sound.length/(sound.bytesLoaded/sound.bytesTotal));
			var percent:uint = Math.round(100 *(channel.position/estimatedLength));
			txtTime.text = getMinutes(Math.round(channel.position/1000)) + " / " + getMinutes(Math.round(estimatedLength/1000));
			slider.value = percent;
			SoundMixer.computeSpectrum(mixBytes, false, 0);
			
            var g:Graphics = mainCanvas.graphics; 
            g.clear(); 
            g.lineStyle(0, 0x6600CC); 
            g.beginFill(Math.random() * 0xFFFFFF); 
            g.moveTo(0, 100); 
     
            var n:Number = 0; 
         
            // left channel 
            for (var i:int = 0; i < CHANNEL_LENGTH; i++)  
            { 
               n = (mixBytes.readFloat() * 200); 
               g.lineTo(i*3 , PLOT_HEIGHT - n); 
            } 
            g.lineTo(CHANNEL_LENGTH*3, 100); 
            g.endFill(); 
     
            // right channel 
           g.lineStyle(0, 0xCC0066); 
           g.beginFill(Math.random() * 0xFFFFFF, 0.5); 
           g.moveTo(CHANNEL_LENGTH * 3, 100); 
     
           for (i = CHANNEL_LENGTH; i > 0; i--)  
           { 
              n = (mixBytes.readFloat() * 200); 
              g.lineTo(i * 3, PLOT_HEIGHT - n); 
           } 
           g.lineTo(0, 100); 
           g.endFill(); 
		}
		
		private function Pause(e:MouseEvent)
		{
			position = channel.position;
			channel.stop();
			btnPlay.mouseEnabled = true;
			visualPanel.visible = true;
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function Stop(e:MouseEvent)
		{
			channel.stop();
			position = 0;
			btnPlay.mouseEnabled = true;
			visualPanel.visible = true;
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onSoundComplete(e:Event)
		{ 
		    removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			position = 0;
			btnPlay.mouseEnabled = true;
			visualPanel.visible = true;
		}
		
		
		
		
		private function getMinutes(secondsAll:uint):String
		{
			var minutes:uint = Math.floor(secondsAll/60);
			var st:String = minutes.toString();
			st += ":";
			var seconds:uint = secondsAll - 60*minutes;
			if(seconds<10)
			  st = st + "0" + seconds.toString();
			else
			  st = st + seconds.toString();
			return st;
		}
		
		
		
		
		
		
		
		private function basename(path:String):String 
		{
             var index:Number = path.lastIndexOf('/');
             path = path.substr(index + 1);
			 path = path.replace(".mp3","");
			 return path;
        }
		
		private function onTick(e:TimerEvent)
		{
			var delta:Date = new Date(((new Date()).getTime() - DateObject.getTime()));
			var year:Number = (new Date()).getUTCFullYear() - DateObject.getUTCFullYear();
			var month:Number = (new Date()).getUTCMonth() - DateObject.getUTCMonth();
			
			day.text = (year*365+month*30+(delta.getUTCDate() -1)).toString();
			hour.text = (delta.getUTCHours()-1).toString();
			minute.text = delta.getUTCMinutes().toString();
			second.text = delta.getUTCSeconds().toString();
	        
		}
        
        private function TimeConvertToCube(time:Number):Sprite
		{
			const WEEK:Number = 604800000;
			var cube:Sprite =  null;
			if(time >= 27*WEEK)
			{
				cube = new Cube9Big();
				return cube;
			}
			else
			{
				if(time >= 26*WEEK)
				{
					cube = new Cube8Big();
				    return cube;
				}
				else
				{
					if(time >= 25*WEEK)
					{
						cube = new Cube7Big();
				 
				        return cube;
					}
					else
					{
						if(time >= 24*WEEK)
						{
							cube = new Cube6Big();
				      
				            return cube;
						}
						else
						{
							if(time >= 23*WEEK)
							{
								cube = new Cube5Big();
				               
				                return cube;
							}
							else
							{
								if(time >= 22*WEEK)
								{
									cube = new Cube4Big();
				                 
				                    return cube;
								}
								else
								{
									if(time >= 21*WEEK)
									{
										cube = new Cube3Big();
				                  
				                        return cube;
									}
									else
									{
										if(time >= 20*WEEK)
										{
											cube = new Cube2Big();
				
				                            return cube;
										}
										else
										{
											if(time >= 19*WEEK)
											{
												cube = new Cube1Big();
				         
				                                return cube;
											}
											else
											{
												if(time >= 18*WEEK)
												{
													cube = new Cube9Big();
				                                    cube.width = 100; cube.height = 75;
				                                    return cube;
												}
												else
												{
													if(time >= 17*WEEK)
													{
														cube = new Cube8Big();
				                                        cube.width = 100; cube.height = 75;
				                                        return cube;
													}
													else
													{
														if(time >= 16*WEEK)
														{
															cube = new Cube7Big();
				                                            cube.width = 100; cube.height = 75;
				                                            return cube;
														}
														else
														{
															if(time >= 15*WEEK)
															{
																cube = new Cube6Big();
				                                                cube.width = 100; cube.height = 75;
				                                                return cube;
															}
															else
															{
																if(time >= 14*WEEK)
																{
																	cube = new Cube5Big();
				                                                    cube.width = 100; cube.height = 75;
				                                                    return cube;
																}
																else
																{
																	if(time >= 13*WEEK)
																	{
																		cube = new Cube4Big();
				                                                        cube.width = 100; cube.height = 75;
				                                                        return cube;
																	}
																	else
																	{
																		if(time >= 12*WEEK)
																		{
																			cube = new Cube3Big();
				                                                            cube.width = 100; cube.height = 75;
				                                                            return cube;
																		}
																		else
																		{
																			if(time >= 11*WEEK)
																			{
																				cube = new Cube2Big();
				                                                                cube.width = 100; cube.height = 75;
				                                                                return cube;
																			}
																			else
																			{
																				if(time >= 10*WEEK)
																				{
																					cube = new Cube1Big();
				                                                                    cube.width = 100; cube.height = 75;
				                                                                    return cube;
																				}
																				else
																				{
																					if(time >= 9*WEEK)
																					{
																						cube = new Cube9Big();
																						cube.width = 75; cube.height = 50;
				                                                                        return cube;
																					}
																					else
																					{
																						if(time >= 8*WEEK)
																						{
																							cube = new Cube8Big();
																							cube.width = 75; cube.height = 50;
				                                                                            return cube;
																						}
																						else
																						{
																							if(time >= 7*WEEK)
																							{
																								cube = new Cube7Big();
																								cube.width = 75; cube.height = 50;
				                                                                                return cube;
																							}
																							else
																							{
																								if(time >= 6*WEEK)
																								{
																									cube = new Cube6Big();
																									cube.width = 75; cube.height = 50;
				                                                                                    return cube;
																								}
																								else
																								{
																									if(time >= 5*WEEK)
																									{
																										cube = new Cube5Big();
																										cube.width = 75; cube.height = 50;
				                                                                                        return cube;
																									}
																									else
																									{
																										if(time >= 44*WEEK)
																										{
																											cube = new Cube4Big();
				                                                                                            cube.width = 75; cube.height = 50;
																											return cube;
																										}
																										else
																										{
																											if(time >= 3*WEEK)
																											{
																												cube = new Cube3Big();
				                                                                                                cube.width = 75; cube.height = 50;
																												return cube;
																											}
																											else
																											{
																												if(time >= 2*WEEK)
																												{
																													cube = new Cube2Big();
																													cube.width = 75; cube.height = 50;
				                                                                                                    return cube;
																												}
																												else
																												{
																													if(time >= WEEK)
																													{
																														cube = new Cube1Big();
																														cube.width = 75; cube.height = 50;
				                                                                                                        return cube;
																													}
																													else
																													{
																														return null;
																													}
																												}
																											}
																										}
																									}
																								}
																							}
																						}
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			return null;
			
		}
		
		private var withBalance:Boolean = false;
		
		private function SendVoice(e:MouseEvent)
		{
			if(PersonInfo.songs.search(url.replace("http://maxb-pro.ru/Songs/",""))!= -1)
			{
				//contains
				mes= new Message(1, "Вы уже голосовали.Теперь стоимость 5 тактов. Проголосовать?");
				main.addChild(mes);
				mes.btnNo.addEventListener(MouseEvent.CLICK, closeMessage);
				mes.btnYes.addEventListener(MouseEvent.CLICK, YesSendVoice);
				withBalance = true;
			}
			else
			{
				mes= new Message(1, "Проголосовать?");
				main.addChild(mes);
				mes.btnNo.addEventListener(MouseEvent.CLICK, closeMessage);
				mes.btnYes.addEventListener(MouseEvent.CLICK, YesSendVoice);
				withBalance = false;
			}
		}
		
		private function closeMessage(e:MouseEvent)
		{
			if(mes != null)
			   main.removeChild(mes);
		}
		
		private function YesSendVoice(e:MouseEvent)
		{
			   var vars:URLVariables = new URLVariables();
			   vars['hash'] = Main.getHash(PersonInfo.uid,url);
			   vars['uid'] = PersonInfo.uid;
			   vars['url'] = url;
			   vars['key'] = Main.getHash((Math.random()*1000).toString());
			   var myrequest:URLRequest = new URLRequest("http://maxb-pro.ru/AddVoice.php");
			   myrequest.method = URLRequestMethod.POST;
			   myrequest.data = vars;
			   var loader:URLLoader = new URLLoader();
			   loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			   loader.addEventListener(Event.COMPLETE, SendVoiceSuccess);
			   loader.addEventListener(IOErrorEvent.IO_ERROR, IOFail);
			   loader.load(myrequest);
			   Key.ShowKey(main);
		}
		
		
		private function SendVoiceSuccess(e:Event)
		{
			Key.HideKey(main);
			if(e.target.data.response == "success")
			{
			   voicesLabel.text = (int(voicesLabel.text)+1).toString();
			   if(withBalance)
			   {
			      main.UpdateEnv(++PersonInfo.fanat,PersonInfo.columb,PersonInfo.painter,PersonInfo.creater, 
						         5, PersonInfo.songs, mes , "Вы проголосовали!", "Сервер недоступен!");
			   }
			   else
			   {
				   main.UpdateEnv(++PersonInfo.fanat,PersonInfo.columb,PersonInfo.painter,PersonInfo.creater, 
						         0, PersonInfo.songs + url.replace("http://maxb-pro.ru/Songs/","") + ",", mes, "Вы проголосовали!", "Сервер недоступен!");
			   }
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
				   var attention:Attention = new Attention("Сервер недоступен", main);
				   attention.Show();
				}
			}
		}
		
		
		
		private function IOFail(e:IOErrorEvent)
		{
			Key.HideKey(main);
			var attention:Attention = new Attention("Сервер недоступен", root as Main);
			attention.Show();
		}

		
		
	}
	
}
