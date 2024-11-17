package com.monsters.debug
{
   import com.cc.utils.SecNum;
   import com.monsters.frontPage.FrontPageGraphic;
   import com.monsters.frontPage.FrontPageLibrary;
   import com.monsters.replayableEvents.ReplayableEvent;
   import com.monsters.replayableEvents.ReplayableEventHandler;
   import com.monsters.replayableEvents.ReplayableEventLibrary;
   import com.monsters.replayableEvents.monsterMadness.MonsterMadness;
   import flash.utils.getDefinitionByName;
   
   public class ConsoleCommands
   {
      public function ConsoleCommands()
      {
         super();
      }
      
      public static function initialize() : *
      {
         Console.registerCommand("unlockquest",unlockQuest);
         Console.registerCommand("lockquest",lockQuest);
         Console.registerCommand("lab",creatureLab);
         Console.registerCommand("academy",creatureAcademy);
         Console.registerCommand("setfeedtime",setChampionFeedTime);
         Console.registerCommand("setstarvetime",setChampionStarveTime);
         Console.registerCommand("tut_arrowRotation",tutorialArrowRotation);
         Console.registerCommand("tut_stage",tutorialGetStage);
         Console.registerCommand("afk",forceAFK);
         Console.registerCommand("resetfrontpage",resetFrontPageData);
         Console.registerCommand("frontpageShow",showFrontPageMsg);
         Console.registerCommand("setkorath",setKorathLevel);
         Console.registerCommand("removeDP",removeDamageProtection);
         Console.registerCommand("settime",setERSTime);
         Console.registerCommand("gettime",getERSTime);
         Console.registerCommand("setscore",setERSScore);
         Console.registerCommand("startevent",startERSEvent);
         Console.registerCommand("clearers",clearERSData);
         Console.registerCommand("printJS",printJSCalls);
         Console.registerCommand("fullscreen",toggleFullScreen);
      }
      
      private static function clearERSData(param1:*) : String
      {
         ReplayableEventHandler.doesDebugClear = true;
         return "deleting all ers data....";
      }
      
      private static function setERSTime(param1:*) : String
      {
         if(!ReplayableEventHandler.debugDate)
         {
            ReplayableEventHandler.debugDate = new Date();
         }
         ReplayableEventHandler.debugDate.time = param1 * 1000 as Number;
         return "ERS time is now " + ReplayableEventHandler.debugDate.toUTCString();
      }
      
      private static function getERSTime(param1:*) : String
      {
         if(!ReplayableEventHandler.debugDate)
         {
            return "ERS debug time not set. Using real time " + new Date(GLOBAL.Timestamp() * 1000).toUTCString();
         }
         return ReplayableEventHandler.debugDate.toUTCString();
      }
      
      private static function setERSScore(param1:*) : String
      {
         var _loc2_:ReplayableEvent = ReplayableEventHandler.activeEvent;
         if(!_loc2_)
         {
            return "There is no active event";
         }
         var _loc3_:uint = _loc2_.score;
         _loc2_.score = param1 as uint;
         return _loc2_.name + " score was set from " + _loc3_ + " to " + param1;
      }
      
      private static function startERSEvent(param1:*) : String
      {
         var _loc2_:ReplayableEvent = ReplayableEventLibrary.getEventByID(uint(param1));
         if(!_loc2_)
         {
            return "Invalid event ID";
         }
         var _loc3_:Number = ReplayableEventHandler.currentTime + 7 * 24 * 60 * 60;
         if(!_loc3_)
         {
            return "Could not schedule a start date for this event(probably because there\'s a new LIVE event soon";
         }
         ReplayableEventHandler.scheduleNewEvent(_loc2_,_loc3_);
         ReplayableEventHandler.initialize();
         return "Sucessfully scheduled " + _loc2_.name + " for " + new Date(_loc2_.startDate).toUTCString();
      }
      
      public static function setChampionStarveTime(param1:*) : String
      {
         var _loc2_:* = 0;
         if(CREATURES._guardian)
         {
            _loc2_ = CHAMPIONCAGE.STARVETIMER;
            CHAMPIONCAGE.STARVETIMER = uint(param1);
            CREATURES._guardian._feedTime = new SecNum(GLOBAL.Timestamp());
            return "Champion starve time set to " + CHAMPIONCAGE.STARVETIMER + " from " + _loc2_;
         }
         return "You dont have a champion... idiot";
      }
      
      public static function setChampionFeedTime(param1:*) : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(CREATURES._guardian)
         {
            _loc2_ = CREATURES._guardian._feedTime.Get();
            _loc3_ = GLOBAL.Timestamp() + uint(param1);
            CREATURES._guardian._feedTime = new SecNum(_loc3_);
            return "Champion feed time set to " + GLOBAL.ToTime(_loc3_ - GLOBAL.Timestamp()) + " from " + GLOBAL.ToTime(_loc2_ - GLOBAL.Timestamp());
         }
         return "You dont have a champion... idiot";
      }
      
      public static function getMonsterMadnessScore(param1:*) : String
      {
         return "Monster Madness score is " + MonsterMadness.points;
      }
      
      public static function setMonsterMadnessScore(param1:uint) : String
      {
         var _loc2_:String = MonsterMadness.points.toString();
         MonsterMadness.points = param1;
         return "Monster Madness score has been set temporarily from " + _loc2_ + " to " + param1;
      }
      
      public static function setKorathLevel(param1:int) : String
      {
         if(GLOBAL._mode != "build")
         {
            return "ERROR: can only set level in your base!";
         }
         CHAMPIONCAGE._guardians["G4"].props.powerLevel = param1;
         var _loc2_:Object = CHAMPIONCAGE.GetGuardianData(4);
         if(_loc2_)
         {
            _loc2_.pl = new SecNum(param1);
         }
         return "Korath level targeted: " + param1 + " set: " + _loc2_.pl;
      }
      
      public static function creatureAcademy(param1:String = null, param2:uint = 0) : String
      {
         var _loc3_:String = null;
         if(param1 == null || param1 == "all")
         {
            for(_loc3_ in CREATURELOCKER._creatures)
            {
               ACADEMY._upgrades[param1].powerup = param2;
            }
            return null;
         }
         ACADEMY._upgrades[param1].powerup = param2;
         return KEYS.Get(CREATURELOCKER._creatures[param1].name) + " upgraded to " + param2;
      }
      
      public static function creatureLab(param1:*, param2:uint) : String
      {
         var _loc3_:String = null;
         if(param1 == null || param1 == "all")
         {
            for(_loc3_ in CREATURELOCKER._creatures)
            {
               ACADEMY._upgrades[param1] = {"level":param2};
            }
            return null;
         }
         ACADEMY._upgrades[param1] = {"level":param2};
         return KEYS.Get(CREATURELOCKER._creatures[param1].name) + " upgraded to " + param2;
      }
      
      public static function changeAlpha(param1:Number = 1) : String
      {
         MAP._GROUND.alpha = param1;
         return param1.toString();
      }
      
      public static function unlockQuest(param1:*) : String
      {
         var _loc2_:Object = null;
         if(param1 == null || param1 == "all")
         {
            for each(_loc2_ in QUESTS._quests)
            {
               QUESTS._completed[_loc2_.id] = 1;
            }
            return null;
         }
         QUESTS._completed[param1] = 1;
         return KEYS.Get(QUESTS.GetQuestByID(param1).name);
      }
      
      public static function lockQuest(param1:*) : String
      {
         var _loc2_:Object = null;
         if(param1 == null || param1 == "all")
         {
            for each(_loc2_ in QUESTS._quests)
            {
               delete QUESTS._completed[_loc2_.id];
            }
            return null;
         }
         delete QUESTS._completed[_loc2_.id];
         return KEYS.Get(QUESTS.GetQuestByID(param1).name);
      }
      
      public static function tutorialArrowRotation(param1:Number = 0) : String
      {
         if(TUTORIAL._mcArrow)
         {
            TUTORIAL._mcArrow.mcArrow.rotation = param1;
            return "TUTORIAL._mcArrow: Rotation - " + TUTORIAL._mcArrow.rotation;
         }
         return "TUTORIAL._mcArrow is NULL - there is no arrow to manipulate.";
      }
      
      public static function tutorialGetStage(param1:int = 0) : String
      {
         return "TUTORIAL._stage = " + TUTORIAL._stage;
      }
      
      public static function forceAFK(param1:int = 0) : String
      {
         var _loc2_:String = null;
         if(param1 == 1)
         {
            POPUPS.AFK();
            _loc2_ = "afk";
         }
         else
         {
            POPUPS.Timeout();
            _loc2_ = "timeout";
         }
         return "forcing afk popup type: " + _loc2_;
      }
      
      public static function resetFrontPageData(param1:* = null) : String
      {
         FrontPageLibrary.initialize();
         GLOBAL.StatSet("CM3",0);
         return "reset frontpage save data";
      }
      
      public static function showFrontPageMsg(param1:String) : String
      {
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         var _loc3_:* = new _loc2_();
         print(param1);
         if(_loc3_ == null)
         {
            return "ERROR: " + param1 + " is not a valid class.";
         }
         var _loc4_:FrontPageGraphic = new FrontPageGraphic();
         _loc4_.showMessage(_loc3_);
         POPUPS.Push(_loc4_);
         return "CONSOLE: Adding frontpage graphic: " + param1;
      }
      
      public static function printJSCalls(param1:* = null) : String
      {
         if(param1 != 1 && param1 != 0)
         {
            return "CONSOLE: printJS - ERROR - please provide a 1 or 0 value";
         }
         GLOBAL.debugLogJSCalls = Boolean(param1);
         return "CONSOLE: printJS set to " + GLOBAL.debugLogJSCalls;
      }
      
      public static function toggleFullScreen(param1:* = null) : String
      {
         GLOBAL.goFullScreen();
         return "CONSOLE: Toggle FullScreen, press ESC to exit";
      }
      
      public static function removeDamageProtection(param1:* = null) : String
      {
         BASE._isProtected = 0;
         BASE.Save();
         return "CONSOLE: BASE._isProtected set to: " + Boolean(BASE._isProtected);
      }
   }
}

