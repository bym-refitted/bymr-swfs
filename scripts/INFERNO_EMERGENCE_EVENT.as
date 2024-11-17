package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import gs.TweenLite;
   
   public class INFERNO_EMERGENCE_EVENT
   {
      private namespace postEvent;
      
      private namespace duringEvent;
      
      public static var isAttackActive:Boolean;
      
      private static var _lastLevel:uint;
      
      private static var _isPostEvent:Boolean;
      
      private static var _currentDate:Date;
      
      private static var ns:Namespace;
      
      public static const TOWN_HALL_LEVEL_REQUIREMENT:int = 5;
      
      public static const _LAST_LEVEL_LABEL:String = "lastLevel";
      
      public static const EVENT_END_DATE:Date = new Date(2012,0,14);
      
      private static const _MINIMUM_BASE_HEALTH:Number = 0.1;
      
      private static const _SHOULD_RUN_EVENT:Boolean = true;
      
      private static const _ATTACK_DELAY:Number = 3;
      
      private static const _FOCUS_DELAY:Number = 3;
      
      private static const _SHAKE_AMOUNT:Number = 100;
      
      private static const _LAST_TIME_LABEL:String = "lastTime";
      
      private static const _WARNING_KEY:String = "emerge_earthquake";
      
      public function INFERNO_EMERGENCE_EVENT()
      {
         super();
      }
      
      private static function get _intermissionDuration() : Number
      {
         return GLOBAL._flags.event2;
      }
      
      private static function get _maxLevel() : Number
      {
         return GLOBAL._flags.event1;
      }
      
      public static function get Lvl() : Number
      {
         return _lastLevel;
      }
      
      public static function Initialize() : Boolean
      {
         if(GLOBAL._mode != "build")
         {
            return false;
         }
         _lastLevel = GLOBAL.StatGet(_LAST_LEVEL_LABEL);
         _currentDate = new Date();
         if(ShouldShowPortal() && _maxLevel > 5 || BASE.isInferno() && MAPROOM_DESCENT.DescentPassed && GLOBAL._mode == "build")
         {
            INFERNOPORTAL.AddPortal(5);
            return false;
         }
         ns = IsPostEvent() ? postEvent : duringEvent;
         if(ShouldShowUpgradePopup())
         {
            ShowUpgradePopup();
         }
         if(!ShouldShowPortal())
         {
            return false;
         }
         SetupPortal();
         return true;
      }
      
      private static function ShowUpgradePopup() : void
      {
         if(GLOBAL.StatGet(INFERNO_EMERGENCE_POPUPS.INFERNO_UPGRADE_SHOWN) == 0)
         {
            INFERNO_EMERGENCE_POPUPS.ShowUpgrade();
            GLOBAL.StatSet(INFERNO_EMERGENCE_POPUPS.INFERNO_UPGRADE_SHOWN,1);
         }
      }
      
      private static function SetupPortal() : void
      {
         var _loc1_:INFERNOPORTAL = INFERNOPORTAL.AddPortal(_lastLevel);
         if(_lastLevel == 0)
         {
            _loc1_.Hide();
            TweenLite.delayedCall(_FOCUS_DELAY,FocusOnPortal);
         }
         else if(Boolean(ns::ShouldUpgradePortal(_lastLevel)) && isBaseReadyForAttack())
         {
            TweenLite.delayedCall(_FOCUS_DELAY,FocusOnPortal);
         }
      }
      
      private static function Save() : void
      {
         GLOBAL.StatSet(_LAST_LEVEL_LABEL,INFERNOPORTAL.building._lvl.Get(),false);
         GLOBAL.StatSet(_LAST_TIME_LABEL,_currentDate.time / 1000,false);
         BASE.Save(0,false,true);
      }
      
      internal static function ShouldUpgradePortal(param1:uint) : Boolean
      {
         var _loc2_:Number = GLOBAL.StatGet(_LAST_TIME_LABEL);
         if(_currentDate.time / 1000 - _loc2_ >= _intermissionDuration)
         {
            if(param1 < _maxLevel)
            {
               return true;
            }
         }
         return false;
      }
      
      internal static function ShouldUpgradePortal(param1:uint) : Boolean
      {
         return ShouldUpgradePortal(param1);
      }
      
      internal static function GetUpgradeLevel() : Number
      {
         return _lastLevel + 1;
      }
      
      internal static function GetUpgradeLevel() : Number
      {
         if(isLastDay())
         {
            return _maxLevel;
         }
         return GetUpgradeLevel();
      }
      
      public static function FocusOnPortal() : void
      {
         if(!ShouldShowPortal())
         {
            return;
         }
         if(POPUPS._open || BUILDINGOPTIONS._open)
         {
            TweenLite.delayedCall(1,FocusOnPortal);
            return;
         }
         UI2.Hide("top");
         UI2.Hide("wmbar");
         UI2.Hide("bottom");
         var _loc1_:MovieClip = INFERNOPORTAL.building._mc;
         MAP.FocusTo(_loc1_.x,_loc1_.y,2,0,0,true,FocusedOnPortal);
      }
      
      private static function FocusedOnPortal() : void
      {
         if(!ShouldShowPortal())
         {
            return;
         }
         if(_lastLevel == 0)
         {
            ShowStartPopup();
         }
         else
         {
            UpgradePortal();
         }
      }
      
      private static function UpgradePortal(param1:Event = null) : void
      {
         if(!ShouldShowPortal())
         {
            return;
         }
         var _loc2_:INFERNOPORTAL = INFERNOPORTAL.building;
         _loc2_.Show();
         _loc2_.SetLevel(ns::GetUpgradeLevel());
         Save();
         if(!isBaseReadyForAttack())
         {
            return;
         }
         UI2.Show("warning");
         UI2._warning.Update("<font size=\"26\">" + KEYS.Get(_WARNING_KEY) + "</font>");
         BASE.Shake(_SHAKE_AMOUNT);
         TweenLite.delayedCall(_ATTACK_DELAY,ShowWarningPopup);
      }
      
      private static function ShowStartPopup() : void
      {
         INFERNO_EMERGENCE_POPUPS.ShowDialogue(_lastLevel).addEventListener(INFERNO_EMERGENCE_POPUPS.EVENT_DIALOGUE_DEFAULT,UpgradePortal,false,0,true);
      }
      
      private static function ShowWarningPopup() : void
      {
         isAttackActive = true;
         INFERNO_EMERGENCE_POPUPS.ShowWarning(_lastLevel);
      }
      
      public static function TriggerAttack(param1:Event) : void
      {
         INFERNO_PORTAL_ATTACK.SpawnAttack();
      }
      
      private static function isBaseReadyForAttack() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:BFOUNDATION = null;
         var _loc5_:Number = NaN;
         for each(_loc4_ in BASE._buildingsMain)
         {
            _loc2_ += _loc4_._hp.Get();
            _loc3_ += _loc4_._hpMax.Get();
         }
         _loc5_ = _loc2_ / _loc3_;
         return _loc2_ / _loc3_ > _MINIMUM_BASE_HEALTH;
      }
      
      public static function ShouldShowPortal() : Boolean
      {
         return _SHOULD_RUN_EVENT && !GLOBAL._flags.viximo && !GLOBAL._flags.kongregate && GLOBAL._mode == "build" && (ns == duringEvent || ns == postEvent && GLOBAL._bTownhall._lvl.Get() >= TOWN_HALL_LEVEL_REQUIREMENT || ns == postEvent && _lastLevel > 0) && _maxLevel > 0 && (BASE._yardType == BASE.MAIN_YARD || BASE._yardType == BASE.INFERNO_YARD) && TUTORIAL._stage > 200;
      }
      
      public static function ShouldRunEvent() : Boolean
      {
         return _SHOULD_RUN_EVENT && !GLOBAL._flags.viximo && !GLOBAL._flags.kongregate && GLOBAL._mode == "build" && (ns == duringEvent || ns == postEvent && GLOBAL._bTownhall._lvl.Get() >= TOWN_HALL_LEVEL_REQUIREMENT || ns == postEvent && _lastLevel > 0) && _maxLevel > 0 && _lastLevel < 5 && BASE._yardType == BASE.MAIN_YARD && TUTORIAL._stage > 200;
      }
      
      public static function ShouldShowUpgradePopup() : Boolean
      {
         return _SHOULD_RUN_EVENT && !GLOBAL._flags.viximo && !GLOBAL._flags.kongregate && GLOBAL._mode == "build" && _maxLevel > 0 && (BASE._yardType == BASE.MAIN_YARD || BASE._yardType == BASE.INFERNO_YARD) && TUTORIAL._stage > 200;
      }
      
      public static function IsPostEvent() : Boolean
      {
         return _currentDate.time / 1000 > EVENT_END_DATE.time / 1000;
      }
      
      public static function isLastDay() : Boolean
      {
         return _currentDate.date + 2 >= EVENT_END_DATE.date;
      }
      
      public static function EndRound() : void
      {
         isAttackActive = false;
      }
   }
}

