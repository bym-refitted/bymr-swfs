package com.monsters.champions
{
   import com.cc.utils.SecNum;
   import com.monsters.interfaces.ILootable;
   import com.monsters.pathing.PATHING;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class KOTHChampion extends CHAMPIONMONSTER
   {
      public static const MAX_POWERLEVEL:int = 2;
      
      public static const TYPE:uint = 5;
      
      public const _lootMults:Vector.<SecNum>;
      
      public function KOTHChampion(param1:String, param2:Point, param3:Number, param4:Point = null, param5:Boolean = false, param6:BFOUNDATION = null, param7:int = 1, param8:int = 0, param9:int = 0, param10:int = 1, param11:int = 20000, param12:int = 0, param13:int = 1)
      {
         var _loc14_:Array = null;
         var _loc17_:Number = 0;
         var _loc18_:Class = null;
         this._lootMults = new Vector.<SecNum>(2,true);
         param13 = Math.min(param13,MAX_POWERLEVEL);
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,0,param13);
         _loc14_ = CHAMPIONCAGE.GetGuardianProperties(_creatureID,"abilities");
         var _loc15_:Number = _powerLevel.Get();
         var _loc16_:uint = _loc14_.length;
         this._lootMults[0] = new SecNum(2);
         this._lootMults[1] = new SecNum(3);
         _buff = CHAMPIONCAGE.GetGuardianProperty(_creatureID,_level.Get(),"buffs");
         while(_loc17_ < _loc16_)
         {
            if(_loc15_ < _loc17_)
            {
               break;
            }
            _loc18_ = _loc14_[_loc17_] as Class;
            if(_loc18_)
            {
               addComponent(new _loc18_());
            }
            _loc17_++;
         }
      }
      
      override public function FindTarget(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc6_:BFOUNDATION = null;
         var _loc10_:Point = null;
         var _loc11_:Point = null;
         var _loc12_:int = 0;
         var _loc14_:String = null;
         var _loc15_:Boolean = false;
         var _loc17_:Object = null;
         var _loc18_:int = 0;
         var _loc19_:Point = null;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:Number = NaN;
         var _loc24_:* = undefined;
         var _loc25_:* = undefined;
         print("TARGETGROUP:" + param1,_targetGroup);
         var _loc3_:Object = BASE._buildingsAll;
         var _loc4_:Object = BASE._buildingsTowers;
         var _loc13_:Array = [];
         var _loc16_:Dictionary = new Dictionary();
         _looking = true;
         _loc10_ = PATHING.FromISO(_tmpPoint);
         for each(_loc6_ in _loc3_)
         {
            if(_loc6_._hp.Get() > 0 && _loc6_ is ILootable)
            {
               if(!_loc6_._looted)
               {
                  _loc11_ = GRID.FromISO(_loc6_._mc.x,_loc6_._mc.y + _loc6_._middle);
                  _loc12_ = GLOBAL.QuickDistance(_loc10_,_loc11_) - _loc6_._middle;
                  _loc13_.push({
                     "building":_loc6_,
                     "distance":_loc12_
                  });
                  _loc15_ = true;
               }
               else
               {
                  _loc16_[_loc6_] = true;
               }
            }
         }
         if(!_loc15_)
         {
            for each(_loc6_ in _loc4_)
            {
               if(MONSTERBUNKER.isBunkerBuilding(_loc6_._type))
               {
                  _loc17_ = _loc6_;
                  if(_loc17_._hp.Get() > 0 && (_loc17_._used > 0 || _loc17_._monstersDispatchedTotal > 0))
                  {
                     _loc11_ = GRID.FromISO(_loc6_._mc.x,_loc6_._mc.y + _loc6_._middle);
                     _loc12_ = GLOBAL.QuickDistance(_loc10_,_loc11_) - _loc6_._middle;
                     _loc13_.push({
                        "building":_loc6_,
                        "distance":_loc12_,
                        "expand":false
                     });
                     _loc15_ = true;
                  }
               }
               else if(_loc6_._class !== "trap" && _loc6_._hp.Get() > 0 && !(_loc6_ as BTOWER).isJard)
               {
                  _loc11_ = GRID.FromISO(_loc6_._mc.x,_loc6_._mc.y + _loc6_._middle);
                  _loc12_ = GLOBAL.QuickDistance(_loc10_,_loc11_) - _loc6_._middle;
                  _loc13_.push({
                     "building":_loc6_,
                     "distance":_loc12_,
                     "expand":false
                  });
                  _loc15_ = true;
               }
            }
         }
         if(!_loc15_)
         {
            for(_loc14_ in _loc16_)
            {
               _loc6_ = _loc16_[_loc14_] as BFOUNDATION;
               _loc11_ = GRID.FromISO(_loc6_._mc.x,_loc6_._mc.y + _loc6_._middle);
               _loc12_ = GLOBAL.QuickDistance(_loc10_,_loc11_) - _loc6_._middle;
               _loc13_.push({
                  "building":_loc6_,
                  "distance":_loc12_,
                  "expand":true
               });
               _loc15_ = true;
            }
         }
         if(_loc13_.length == 0)
         {
            for each(_loc6_ in BASE._buildingsMain)
            {
               if(_loc6_._class != "decoration" && _loc6_._class != "immovable" && _loc6_._hp.Get() > 0 && _loc6_._class != "enemy")
               {
                  if(_loc6_._class == "tower" && !MONSTERBUNKER.isBunkerBuilding(_loc6_._type))
                  {
                     if((_loc6_ as BTOWER).isJard)
                     {
                        continue;
                     }
                  }
                  _loc11_ = GRID.FromISO(_loc6_._mc.x,_loc6_._mc.y + _loc6_._middle);
                  _loc12_ = GLOBAL.QuickDistance(_loc10_,_loc11_) - _loc6_._middle;
                  _loc13_.push({
                     "building":_loc6_,
                     "distance":_loc12_,
                     "expand":true
                  });
               }
            }
         }
         if(_loc13_.length == 0)
         {
            ModeRetreat();
         }
         else
         {
            _loc13_.sortOn("distance",Array.NUMERIC);
            _loc18_ = 0;
            if(_movement == "burrow")
            {
               _hasTarget = true;
               _hasPath = true;
               _loc19_ = GRID.FromISO(_loc13_[_loc18_].building._mc.x,_loc13_[_loc18_].building._mc.y);
               _loc20_ = int(Math.random() * 4);
               _loc21_ = int(_loc13_[_loc18_].building._footprint[0].height);
               _loc22_ = int(_loc13_[_loc18_].building._footprint[0].width);
               if(_loc20_ == 0)
               {
                  _loc19_.x += Math.random() * _loc21_;
                  _loc19_.y += _loc22_;
               }
               else if(_loc20_ == 1)
               {
                  _loc19_.x += _loc21_;
                  _loc19_.y += _loc22_;
               }
               else if(_loc20_ == 2)
               {
                  _loc19_.x += _loc21_ - Math.random() * _loc21_ / 2;
                  _loc19_.y -= _loc22_ / 4;
               }
               else if(_loc20_ == 3)
               {
                  _loc19_.x -= _loc21_ / 4;
                  _loc19_.y += _loc22_ - Math.random() * _loc22_ / 2;
               }
               _waypoints = [GRID.ToISO(_loc19_.x,_loc19_.y,0)];
               _targetPosition = _waypoints[0];
               _targetBuilding = _loc13_[_loc18_].building;
            }
            else if(_movement == "fly")
            {
               _hasTarget = true;
               _hasPath = true;
               _targetBuilding = _loc13_[_loc18_].building;
               _targetCenter = _targetBuilding._position;
               if(GLOBAL.QuickDistance(_tmpPoint,_targetCenter) < 170)
               {
                  _atTarget = true;
                  _hasPath = true;
                  _targetPosition = _targetCenter;
               }
               else
               {
                  _loc23_ = Math.atan2(_tmpPoint.y - _targetCenter.y,_tmpPoint.x - _targetCenter.x) * 57.2957795;
                  _loc23_ = _loc23_ + (Math.random() * 40 - 20);
                  _loc23_ = _loc23_ / (180 / Math.PI);
                  _loc24_ = 2 * 60 + Math.random() * 10;
                  _loc25_ = new Point(_targetCenter.x + Math.cos(_loc23_) * _loc24_ * 1.7,_targetCenter.y + Math.sin(_loc23_) * _loc24_);
                  _waypoints = [_loc25_];
                  _targetPosition = _waypoints[0];
               }
            }
            else if(GLOBAL._catchup)
            {
               WaypointTo(new Point(_loc13_[0].building._mc.x,_loc13_[0].building._mc.y),_loc13_[0].building);
            }
            else
            {
               _loc18_ = 0;
               while(_loc18_ < 2)
               {
                  if(_loc13_.length > _loc18_)
                  {
                     WaypointTo(new Point(_loc13_[_loc18_].building._mc.x,_loc13_[_loc18_].building._mc.y),_loc13_[_loc18_].building);
                  }
                  _loc18_++;
               }
            }
         }
      }
   }
}

