package
{
   import com.monsters.events.CreepEvent;
   import com.monsters.monsters.MonsterBase;
   import com.monsters.monsters.champions.ChampionBase;
   import com.monsters.monsters.creeps.CREEP;
   import com.monsters.monsters.creeps.CREEP_INFERNO;
   import flash.geom.Point;
   
   public class CREATURES
   {
      public static var _creatures:Object;
      
      public static var _creatureID:int;
      
      public static var _creatureCount:int;
      
      public static var _ticks:int;
      
      public static var _guardianList:Vector.<ChampionBase> = new Vector.<ChampionBase>();
      
      public function CREATURES()
      {
         super();
         _creatures = {};
         _creatureID = 0;
         _creatureCount = 0;
         _ticks = 0;
         _guardianList.length = 0;
      }
      
      public static function GetProperty(param1:String, param2:String, param3:int = 0, param4:Boolean = true) : Number
      {
         var stat:Array = null;
         var checkID:String = null;
         var monsterID:String = param1;
         var statID:String = param2;
         var level:int = param3;
         var friendly:Boolean = param4;
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
               checkID = monsterID;
               if(CREATURELOCKER._creatures[checkID].dependent)
               {
                  checkID = CREATURELOCKER._creatures[checkID].dependent;
               }
               if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack" || !friendly)
               {
                  if(!GLOBAL._attackerCreatureUpgrades)
                  {
                     GLOBAL._attackerCreatureUpgrades = GLOBAL._playerCreatureUpgrades;
                  }
                  if(!GLOBAL._attackerCreatureUpgrades[monsterID])
                  {
                     GLOBAL._attackerCreatureUpgrades[monsterID] = {"level":1};
                  }
                  if(level == 0)
                  {
                     if(!friendly)
                     {
                        if(GLOBAL._attackerCreatureUpgrades[checkID] != null)
                        {
                           level = int(GLOBAL._attackerCreatureUpgrades[checkID].level);
                        }
                     }
                     else if(ACADEMY._upgrades[checkID] != null)
                     {
                        level = int(ACADEMY._upgrades[checkID].level);
                     }
                  }
               }
               else if(level == 0 && ACADEMY._upgrades[checkID] != null)
               {
                  level = int(ACADEMY._upgrades[checkID].level);
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
         var _loc1_:MonsterBase = null;
         var _loc2_:String = null;
         for(_loc2_ in _creatures)
         {
            _loc1_ = _creatures[_loc2_];
            if(_loc1_.Tick(1))
            {
               if(_loc1_._health.Get() <= 0)
               {
                  SOUNDS.Play("splat" + (int(Math.random() * 3) + 1));
                  EFFECTS.CreepSplat(_loc1_._creatureID,_loc1_._tmpPoint.x,_loc1_._tmpPoint.y);
               }
               _loc1_.Clear();
               MAP._BUILDINGTOPS.removeChild(_loc1_);
               --_creatureCount;
               delete _creatures[_loc2_];
            }
         }
         if(_creatureCount <= 0)
         {
            _creatureCount = 0;
         }
      }
      
      public static function Spawn(param1:String, param2:*, param3:String, param4:Point, param5:Number, param6:Point = null, param7:BFOUNDATION = null) : *
      {
         var _loc8_:* = undefined;
         if(!CREATURELOCKER._creatures[param1])
         {
            return null;
         }
         ++_creatureID;
         ++_creatureCount;
         if(BASE.isInferno() || param1.substr(0,1) == "I")
         {
            _loc8_ = MAP._BUILDINGTOPS.addChild(new CREEP_INFERNO(param1,param3,param4,param5,param6,true,param7));
         }
         else
         {
            _loc8_ = MAP._BUILDINGTOPS.addChild(new CREEP(param1,param3,param4,param5,param6,true,param7));
         }
         _creatures[_creatureID] = _loc8_;
         if(GLOBAL._render)
         {
            _loc8_._spawned = true;
         }
         GLOBAL.eventDispatcher.dispatchEvent(new CreepEvent(CreepEvent.DEFENDING_CREEP_SPAWNED,_loc8_));
         return _loc8_;
      }
      
      public static function Clear() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         for(_loc2_ in _creatures)
         {
            _loc1_ = _creatures[_loc2_];
            _loc1_.Clear();
            MAP._BUILDINGTOPS.removeChild(_loc1_);
         }
         _creatures = {};
         _creatureCount = 0;
         _loc3_ = 0;
         while(_loc3_ < _guardianList.length)
         {
            MAP._BUILDINGTOPS.removeChild(_guardianList[_loc3_]);
            _guardianList[_loc3_] = null;
            _loc3_++;
         }
         _guardianList.length = 0;
      }
      
      public static function get _guardian() : ChampionBase
      {
         var _loc1_:int = 0;
         while(_loc1_ < _guardianList.length)
         {
            if(Boolean(_guardianList[_loc1_]) && CHAMPIONCAGE.isBasicGuardian(_guardianList[_loc1_]._creatureID))
            {
               return _guardianList[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public static function get _krallen() : ChampionBase
      {
         var _loc1_:int = 0;
         while(_loc1_ < _guardianList.length)
         {
            if(Boolean(_guardianList[_loc1_]) && _guardianList[_loc1_]._creatureID == "G5")
            {
               return _guardianList[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public static function getGuardian(param1:int) : ChampionBase
      {
         var _loc2_:int = 0;
         while(_loc2_ < _guardianList.length)
         {
            if(int(_guardianList[_loc2_]._creatureID.substr(1)) == param1)
            {
               return _guardianList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function getGuardianIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < _guardianList.length)
         {
            if(int(_guardianList[_loc2_]._creatureID.substr(1)) == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public static function set _guardian(param1:ChampionBase) : void
      {
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < _guardianList.length)
         {
            if(Boolean(_guardianList[_loc3_]) && CHAMPIONCAGE.isBasicGuardian(_guardianList[_loc3_]._creatureID))
            {
               _loc2_ = _loc3_;
            }
            _loc3_++;
         }
         if(_loc2_ == -1)
         {
            if(param1)
            {
               _guardianList.unshift(param1);
            }
         }
         else if(!param1)
         {
            _guardianList.splice(_loc2_,1);
         }
         else
         {
            _guardianList[_loc2_] = param1;
         }
      }
      
      public static function addGuardian(param1:ChampionBase) : Boolean
      {
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < _guardianList.length)
         {
            if(_guardianList[_loc3_]._creatureID == param1._creatureID)
            {
               _loc2_ = _loc3_;
            }
            _loc3_++;
         }
         if(_loc2_ == -1)
         {
            if(param1)
            {
               _guardianList.push(param1);
               return true;
            }
         }
         return false;
      }
      
      public static function removeGuardianType(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < _guardianList.length)
         {
            if(int(_guardianList[_loc2_]._creatureID.substr(1)) == param1)
            {
               break;
            }
            _loc2_++;
         }
         if(_loc2_ < _guardianList.length)
         {
            MAP._BUILDINGTOPS.removeChild(_guardianList[_loc2_]);
            if(_guardianList[_loc2_] == _guardian)
            {
               _guardian = null;
            }
            else
            {
               _guardianList.splice(_loc2_,1);
            }
         }
      }
      
      public static function removeAllGuardians() : void
      {
         var _loc1_:int = int(_guardianList.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            MAP._BUILDINGTOPS.removeChild(_guardianList[_loc2_]);
            _loc2_++;
         }
         _guardianList.length = 0;
      }
   }
}

