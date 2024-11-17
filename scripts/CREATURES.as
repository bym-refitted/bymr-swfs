package
{
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class CREATURES
   {
      public static var _creatures:Object;
      
      public static var _creatureID:int;
      
      public static var _creatureCount:int;
      
      public static var _mcBody:*;
      
      public static var _mcLegs:*;
      
      public static var _ticks:int;
      
      public static var _guardian:GUARDIANMONSTER;
      
      public function CREATURES()
      {
         super();
         _creatures = {};
         _creatureID = 0;
         _creatureCount = 0;
         _ticks = 0;
         _guardian = null;
      }
      
      public static function GetProperty(param1:String, param2:String, param3:int = 0) : Number
      {
         var stat:Array = null;
         var monsterID:String = param1;
         var statID:String = param2;
         var level:int = param3;
         if(!monsterID)
         {
            return 0;
         }
         try
         {
            try
            {
               if(monsterID == "C100")
               {
                  monsterID = "C12";
               }
               if(!ACADEMY._upgrades[monsterID])
               {
                  ACADEMY._upgrades[monsterID] = {"level":1};
                  if(GLOBAL._mode == "build")
                  {
                     GLOBAL._playerCreatureUpgrades[monsterID] = {"level":1};
                  }
               }
               stat = CREATURELOCKER._creatures[monsterID].props[statID];
               if(!stat)
               {
                  return 0;
               }
               if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
               {
                  if(!GLOBAL._attackerCreatureUpgrades[monsterID])
                  {
                     GLOBAL._attackerCreatureUpgrades[monsterID] = {"level":1};
                  }
                  if(level == 0 && Boolean(GLOBAL._attackerCreatureUpgrades[monsterID]))
                  {
                     level = int(GLOBAL._attackerCreatureUpgrades[monsterID].level);
                  }
               }
               else if(level == 0 && Boolean(ACADEMY._upgrades[monsterID]))
               {
                  level = int(ACADEMY._upgrades[monsterID].level);
               }
               if(stat.length < level)
               {
                  level = int(stat.length);
               }
            }
            catch(e:Error)
            {
            }
            return stat[level - 1];
         }
         catch(e:Error)
         {
         }
         return 0;
      }
      
      public static function Tick() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc1_:int = getTimer();
         for(_loc3_ in _creatures)
         {
            _loc2_ = _creatures[_loc3_];
            if(_loc2_.Tick())
            {
               if(_loc2_._health.Get() <= 0)
               {
                  SOUNDS.Play("splat" + (int(Math.random() * 3) + 1));
                  EFFECTS.CreepSplat(_loc2_._creatureID,_loc2_._tmpPoint.x,_loc2_._tmpPoint.y);
               }
               _loc2_.Clear();
               MAP._BUILDINGTOPS.removeChild(_loc2_);
               --_creatureCount;
               delete _creatures[_loc3_];
            }
         }
         if(_creatureCount <= 0)
         {
            _creatureCount = 0;
         }
      }
      
      public static function Spawn(param1:String, param2:*, param3:String, param4:Point, param5:Number, param6:Point = null, param7:BFOUNDATION = null) : CREEP
      {
         var _loc8_:CREEP = null;
         ++_creatureID;
         ++_creatureCount;
         _loc8_ = MAP._BUILDINGTOPS.addChild(new CREEP(param1,param3,param4,param5,param6,true,param7));
         _creatures[_creatureID] = _loc8_;
         if(GLOBAL._render)
         {
            _loc8_._spawned = true;
         }
         return _loc8_;
      }
      
      public static function Clear() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:String = null;
         for(_loc2_ in _creatures)
         {
            _loc1_ = _creatures[_loc2_];
            _loc1_.Clear();
            MAP._BUILDINGTOPS.removeChild(_loc1_);
         }
         _creatures = {};
         _creatureCount = 0;
         if(_guardian)
         {
            MAP._BUILDINGTOPS.removeChild(_guardian);
            _guardian.Clear();
            _guardian = null;
         }
      }
   }
}

