package
{
   import com.monsters.display.ImageCache;
   import com.monsters.sound.SoundLibrary;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   
   public class SOUNDS
   {
      public static var _assets:Array;
      
      private static var soundLibraries:Vector.<SoundLibrary>;
      
      private static var _musicTime:Number;
      
      public static var _musicChannel:SoundChannel;
      
      public static var _muted:int = 0;
      
      public static var _mutedMusic:int = 0;
      
      public static var _setup:Boolean = false;
      
      public static var _loadState:int = 0;
      
      private static var _currentMusic:String = null;
      
      private static var _queuedMusic:String = "musicbuild";
      
      private static var _musicVolume:Number = 0.7;
      
      private static var _musicPan:Number = 0;
      
      public static var _concurrent:Object = {};
      
      public static var _sounds:Object = {
         "click1":new sound_click1(),
         "laser":"sound_laser",
         "wmbstart":"sound_monsterbaiterloop",
         "wmbhorn":"sound_monsterbaiterhorn",
         "purchasepopup":"sound_purchasepop",
         "bankfire":"sound_bankfire",
         "bankland":"sound_bankland",
         "repair1":"sound_repair1",
         "error1":"sound_error1",
         "levelup":"sound_levelup",
         "shotgun":"sound_shotgun",
         "clock1":"sound_clock1",
         "warcry1":"sound_warcry1",
         "splat1":"sound_splat1",
         "splat2":"sound_splat2",
         "splat3":"sound_splat3",
         "splat4":"sound_splat4",
         "splat5":"sound_splat5",
         "snipe1":"sound_snipe1",
         "railgun1":"sound_railgun1",
         "splash1":"sound_splash1",
         "juice":"sound_juice",
         "close":"sound_close",
         "buildingplace":"sound_buildingplace",
         "lightningstart":"sound_lightningstart",
         "lightningfire":"sound_lightningfire",
         "lightningend":"sound_lightningend",
         "chaching":"sound_chaching",
         "pebblebomb":"sound_pebblebomb",
         "twigbomb":"sound_twigbomb",
         "puttybomb":"sound_puttybomb",
         "trap":"sound_trap",
         "damage1":"building_damage_1",
         "damage2":"building_damage_2",
         "damage3":"building_damage_3",
         "destroy1":"building_destroy_1",
         "destroy2":"building_destroy_2",
         "destroy3":"building_destroy_3",
         "destroy4":"building_destroy_4",
         "destroytownhall":"town_hall_destroy",
         "monsterland1":"monster_land_1",
         "monsterland2":"monster_land_2",
         "monsterland3":"monster_land_3",
         "monsterlanddave":"monster_land_dave",
         "hit1":"sound_hit1",
         "hit2":"sound_hit2",
         "hit3":"sound_hit3",
         "hit4":"sound_hit4",
         "hit5":"sound_hit5",
         "arise":"wormzer_arise",
         "dig":"wormzer_dig",
         "bunkerdoor":"bunkerdoor",
         "pumpkintreat":"sound_pumpkin_treat",
         "musicattack":"Music_Attack",
         "musicbuild":"Music_Building",
         "musicpanic":"Music_UnderAttack"
      };
      
      public static var music_volumes:Object = {
         "musicattack":0.7,
         "musicbuild":0.6,
         "musicpanic":0.7
      };
      
      public function SOUNDS()
      {
         super();
      }
      
      public static function DamageSoundIDForLevel(param1:int) : String
      {
         var _loc2_:String = "";
         if(param1 < 3)
         {
            _loc2_ = "damage1";
         }
         else if(param1 < 6)
         {
            _loc2_ = "damage2";
         }
         else
         {
            _loc2_ = "damage3";
         }
         return _loc2_;
      }
      
      public static function DestroySoundIDForLevel(param1:int) : String
      {
         var _loc2_:String = "";
         if(param1 < 2)
         {
            _loc2_ = "destroy1";
         }
         else if(param1 < 5)
         {
            _loc2_ = "destroy2";
         }
         else if(param1 < 8)
         {
            _loc2_ = "destroy3";
         }
         else
         {
            _loc2_ = "destroy4";
         }
         return _loc2_;
      }
      
      public static function Setup() : void
      {
         var surl:String = null;
         var i:int = 0;
         if(!_setup)
         {
            _setup = true;
            try
            {
               _muted = 0;
               if(_mutedMusic == 0)
               {
                  _musicVolume = 0.7;
               }
               else
               {
                  _musicVolume = 0;
               }
               if(GLOBAL.StatGet("mute") == 1)
               {
                  MuteUnmute(true);
               }
               if(GLOBAL.StatGet("mutemusic") == 1)
               {
                  MuteUnmute(true,"music");
               }
            }
            catch(e:Error)
            {
               LOGGER.Log("err","SOUNDS.Setup: " + e.message + " | " + e.getStackTrace());
            }
            surl = GLOBAL._soundPathURL + "uisounds.v" + GLOBAL._soundVersion + ".swf";
            _assets = [surl,GLOBAL._soundPathURL + "othersounds.v" + GLOBAL._soundVersion + ".swf",GLOBAL._soundPathURL + "attacksounds.v" + GLOBAL._soundVersion + ".swf",GLOBAL._soundPathURL + "music.v" + GLOBAL._soundVersion + ".swf"];
            if(GLOBAL._local)
            {
               surl = GLOBAL._soundPathURL + "uisounds.swf";
               _assets = [surl,GLOBAL._soundPathURL + "othersounds.swf",GLOBAL._soundPathURL + "attacksounds.swf",GLOBAL._soundPathURL + "music.swf"];
            }
            soundLibraries = new Vector.<SoundLibrary>();
            i = 0;
            while(i < _assets.length)
            {
               soundLibraries.push(new SoundLibrary(_assets[i]));
               i++;
            }
            i = 0;
            while(i < _assets.length - 1)
            {
               soundLibraries[i].next = soundLibraries[i + 1];
               i++;
            }
         }
         else
         {
            if(_muted == 1)
            {
               UI2._top.mcSound.gotoAndStop(2);
            }
            else
            {
               UI2._top.mcSound.gotoAndStop(1);
            }
            if(_musicVolume == 0)
            {
               UI2._top.mcMusic.gotoAndStop(2);
            }
            else
            {
               UI2._top.mcMusic.gotoAndStop(1);
            }
         }
      }
      
      public static function PlayMusic(param1:String = "") : void
      {
         _queuedMusic = param1;
         if(!_mutedMusic)
         {
            _musicVolume = music_volumes[param1];
         }
      }
      
      public static function PlayMusicB(param1:String = "", param2:Number = 0.7, param3:Number = 0, param4:Number = 0) : void
      {
         var s:SoundLibrary = null;
         var sndC:Class = null;
         var sndO:Sound = null;
         var id:String = param1;
         var volume:Number = param2;
         var pan:Number = param3;
         var position:Number = param4;
         if(_currentMusic == id)
         {
            return;
         }
         try
         {
            if(!_concurrent[id])
            {
               _concurrent[id] = 1;
            }
            if(_concurrent[id] <= 2)
            {
               _concurrent[id] += 1;
               if(_sounds[id] is String)
               {
                  for each(s in soundLibraries)
                  {
                     if(s.loaded)
                     {
                        if(s.li.applicationDomain.hasDefinition(_sounds[id]))
                        {
                           sndC = s.li.applicationDomain.getDefinition(_sounds[id]) as Class;
                           sndO = new sndC() as Sound;
                           if(_musicChannel)
                           {
                              _musicChannel.stop();
                              _musicChannel.removeEventListener(Event.SOUND_COMPLETE,replayMusic);
                           }
                           _musicChannel = sndO.play(position,99999,new SoundTransform(volume,pan));
                           _currentMusic = id;
                           _musicChannel.addEventListener(Event.SOUND_COMPLETE,replayMusic);
                        }
                     }
                  }
               }
               else
               {
                  if(_musicChannel)
                  {
                     _musicChannel.stop();
                     _musicChannel.removeEventListener(Event.SOUND_COMPLETE,replayMusic);
                  }
                  _musicChannel = _sounds[id].play(position,99999,new SoundTransform(volume,pan));
                  _currentMusic = id;
                  _musicChannel.addEventListener(Event.SOUND_COMPLETE,replayMusic);
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","SOUNDS.PlayMusic",e.getStackTrace());
         }
      }
      
      private static function replayMusic(param1:Event) : void
      {
         _queuedMusic = _currentMusic;
         _currentMusic = null;
         PlayMusicB(_queuedMusic);
      }
      
      public static function Play(param1:String = "", param2:Number = 0.8, param3:Number = 0) : void
      {
         var s:SoundLibrary = null;
         var sndC:Class = null;
         var sndO:Sound = null;
         var id:String = param1;
         var volume:Number = param2;
         var pan:Number = param3;
         if(!GLOBAL._catchup && !_muted)
         {
            try
            {
               if(!_concurrent[id])
               {
                  _concurrent[id] = 1;
               }
               if(_concurrent[id] <= 2)
               {
                  _concurrent[id] += 1;
                  if(_sounds[id] is String)
                  {
                     for each(s in soundLibraries)
                     {
                        if(s.loaded)
                        {
                           if(s.li.applicationDomain.hasDefinition(_sounds[id]))
                           {
                              sndC = s.li.applicationDomain.getDefinition(_sounds[id]) as Class;
                              sndO = new sndC() as Sound;
                              sndO.play(0,1,new SoundTransform(volume,pan));
                           }
                        }
                     }
                  }
                  else
                  {
                     _sounds[id].play(0,1,new SoundTransform(volume,pan));
                  }
               }
            }
            catch(e:Error)
            {
               LOGGER.Log("err","SOUNDS.Play error",e.getStackTrace());
            }
         }
      }
      
      public static function Tick() : void
      {
         var _loc1_:String = null;
         var _loc2_:Number = NaN;
         for(_loc1_ in _concurrent)
         {
            if(_concurrent[_loc1_] > 0)
            {
               --_concurrent[_loc1_];
            }
         }
         if(_setup && _loadState == 0 && ImageCache.load.length == 0)
         {
            _loadState = 1;
            (soundLibraries[0] as SoundLibrary).Load();
         }
         if(_currentMusic != _queuedMusic)
         {
            if(_currentMusic)
            {
               _loc2_ = _musicChannel.soundTransform.volume;
               _loc2_ -= 0.05;
               if(_loc2_ <= 0)
               {
                  PlayMusicB(_queuedMusic,_musicVolume,_musicPan);
               }
               else
               {
                  _musicChannel.soundTransform = new SoundTransform(_loc2_,_musicPan);
               }
            }
            else
            {
               PlayMusicB(_queuedMusic,_musicVolume,_musicPan);
            }
         }
      }
      
      public static function TutorialStopMusic() : void
      {
         MuteUnmute(true,"music");
         _queuedMusic = null;
         _currentMusic = null;
      }
      
      public static function StopAll() : void
      {
         SoundMixer.stopAll();
      }
      
      public static function Toggle(param1:MouseEvent = null) : void
      {
         var e:MouseEvent = param1;
         try
         {
            if(_muted == 0)
            {
               MuteUnmute(true);
            }
            else
            {
               MuteUnmute(false);
            }
            if(GLOBAL._mode == "build")
            {
               GLOBAL.StatSet("mute",_muted);
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","SOUNDS.Toggle: " + e.message + " | " + e.getStackTrace());
         }
      }
      
      public static function ToggleMusic(param1:MouseEvent = null) : void
      {
         var e:MouseEvent = param1;
         try
         {
            if(_mutedMusic == 0)
            {
               MuteUnmute(true,"music");
            }
            else
            {
               MuteUnmute(false,"music");
            }
            if(GLOBAL._mode == "build")
            {
               GLOBAL.StatSet("mutemusic",_mutedMusic);
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","SOUNDS.Toggle: " + e.message + " | " + e.getStackTrace());
         }
      }
      
      public static function MuteUnmute(param1:Boolean = true, param2:String = "snd") : void
      {
         var _loc3_:SoundTransform = null;
         if(param2 == "snd")
         {
            if(param1)
            {
               UI2._top.mcSound.gotoAndStop(2);
               _muted = 1;
            }
            else
            {
               UI2._top.mcSound.gotoAndStop(1);
               _muted = 0;
            }
         }
         else if(param2 == "music")
         {
            _loc3_ = new SoundTransform();
            if(param1)
            {
               UI2._top.mcMusic.gotoAndStop(2);
               _musicVolume = 0;
               _mutedMusic = 1;
            }
            else
            {
               UI2._top.mcMusic.gotoAndStop(1);
               _musicVolume = 0.7;
               _mutedMusic = 0;
               if(_currentMusic == null && _queuedMusic == null)
               {
                  switch(GLOBAL._mode)
                  {
                     case "attack":
                     case "wmattack":
                        PlayMusic("musicattack");
                        break;
                     case "build":
                     case "help":
                     case "view":
                     default:
                        PlayMusic("musicbuild");
                  }
               }
            }
            _loc3_.volume = _musicVolume;
            if(_musicChannel)
            {
               _musicChannel.soundTransform = _loc3_;
            }
         }
      }
   }
}

