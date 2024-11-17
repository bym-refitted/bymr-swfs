package com.monsters.champions
{
   import com.monsters.interfaces.ILootable;
   import com.monsters.pathing.PATHING;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class KOTHChampion extends CHAMPIONMONSTER
   {
      public function KOTHChampion(param1:String, param2:Point, param3:Number, param4:Point = null, param5:Boolean = false, param6:BFOUNDATION = null, param7:int = 1, param8:int = 0, param9:int = 0, param10:int = 1, param11:int = 20000, param12:int = 0, param13:int = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
      }
      
      override public function Heal() : *
      {
         var _loc1_:int = 0;
         if(GLOBAL._mode == "build")
         {
            _loc1_ = this.GetHealCost();
            if(_loc1_ > 0)
            {
               GLOBAL.Message(KEYS.Get("msg_healchampion",{"v1":_loc1_}),KEYS.Get("str_heal"),this.HealB);
            }
         }
      }
      
      override public function HealB() : *
      {
         var _loc1_:int = 0;
         if(GLOBAL._mode == "build")
         {
            _loc1_ = this.GetHealCost();
            if(_loc1_ > BASE._credits.Get())
            {
               POPUPS.DisplayGetShiny();
               return;
            }
            _health.Set(_maxHealth);
            BASE.Purchase("IHE",_loc1_,"CHAMPION.Heal");
            Export(_friendly);
            LOGGER.Stat([58,_creatureID,_loc1_,_level.Get()]);
            BASE.Save();
         }
      }
      
      override public function GetHealCost() : int
      {
         var _loc1_:Number = (_maxHealth - _health.Get()) / _maxHealth;
         var _loc2_:int = int(_loc1_ * CHAMPIONCAGE.GetGuardianProperty(_creatureID,_level.Get(),"healtime"));
         return STORE.GetTimeCost(_loc2_,false);
      }
      
      override public function FindTarget(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc5_:BFOUNDATION = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Point = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:Number = NaN;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc3_:int = getTimer();
         var _loc12_:Array = [];
         var _loc13_:Object = BASE._buildingsMain;
         _looking = true;
         _loc9_ = PATHING.FromISO(_tmpPoint);
         for each(_loc5_ in _loc13_)
         {
            if(_loc5_._hp.Get() > 0 && _loc5_ is ILootable && !_loc5_._looted)
            {
               _loc10_ = GRID.FromISO(_loc5_._mc.x,_loc5_._mc.y + _loc5_._middle);
               _loc11_ = GLOBAL.QuickDistance(_loc9_,_loc10_) - _loc5_._middle;
               _loc12_.push({
                  "building":_loc5_,
                  "distance":_loc11_
               });
            }
         }
         if(_loc12_.length == 0)
         {
            for each(_loc5_ in _loc13_)
            {
               if(_loc5_._class !== "decoration" && _loc5_._class !== "immovable" && _loc5_._hp.Get() > 0 && _loc5_._class != "enemy")
               {
                  if(_loc5_._class === "tower" && !MONSTERBUNKER.isBunkerBuilding(_loc5_._type))
                  {
                     if((_loc5_ as BTOWER).isJard)
                     {
                        continue;
                     }
                  }
                  _loc10_ = GRID.FromISO(_loc5_._mc.x,_loc5_._mc.y + _loc5_._middle);
                  _loc11_ = GLOBAL.QuickDistance(_loc9_,_loc10_) - _loc5_._middle;
                  _loc12_.push({
                     "building":_loc5_,
                     "distance":_loc11_,
                     "expand":true
                  });
               }
            }
         }
         if(_loc12_.length == 0)
         {
            ModeRetreat();
         }
         else
         {
            _loc12_.sortOn("distance",Array.NUMERIC);
            _loc14_ = 0;
            if(_movement == "burrow")
            {
               _hasTarget = true;
               _hasPath = true;
               _loc15_ = GRID.FromISO(_loc12_[_loc14_].building._mc.x,_loc12_[_loc14_].building._mc.y);
               _loc16_ = int(Math.random() * 4);
               _loc17_ = int(_loc12_[_loc14_].building._footprint[0].height);
               _loc18_ = int(_loc12_[_loc14_].building._footprint[0].width);
               if(_loc16_ == 0)
               {
                  _loc15_.x += Math.random() * _loc17_;
                  _loc15_.y += _loc18_;
               }
               else if(_loc16_ == 1)
               {
                  _loc15_.x += _loc17_;
                  _loc15_.y += _loc18_;
               }
               else if(_loc16_ == 2)
               {
                  _loc15_.x += _loc17_ - Math.random() * _loc17_ / 2;
                  _loc15_.y -= _loc18_ / 4;
               }
               else if(_loc16_ == 3)
               {
                  _loc15_.x -= _loc17_ / 4;
                  _loc15_.y += _loc18_ - Math.random() * _loc18_ / 2;
               }
               _waypoints = [GRID.ToISO(_loc15_.x,_loc15_.y,0)];
               _targetPosition = _waypoints[0];
               _targetBuilding = _loc12_[_loc14_].building;
            }
            else if(_movement == "fly")
            {
               _hasTarget = true;
               _hasPath = true;
               _targetBuilding = _loc12_[_loc14_].building;
               _targetCenter = _targetBuilding._position;
               if(GLOBAL.QuickDistance(_tmpPoint,_targetCenter) < 170)
               {
                  _atTarget = true;
                  _hasPath = true;
                  _targetPosition = _targetCenter;
               }
               else
               {
                  _loc19_ = Math.atan2(_tmpPoint.y - _targetCenter.y,_tmpPoint.x - _targetCenter.x) * 57.2957795;
                  _loc19_ = _loc19_ + (Math.random() * 40 - 20);
                  _loc19_ = _loc19_ / (180 / Math.PI);
                  _loc20_ = 2 * 60 + Math.random() * 10;
                  _loc21_ = new Point(_targetCenter.x + Math.cos(_loc19_) * _loc20_ * 1.7,_targetCenter.y + Math.sin(_loc19_) * _loc20_);
                  _waypoints = [_loc21_];
                  _targetPosition = _waypoints[0];
               }
            }
            else if(GLOBAL._catchup)
            {
               WaypointTo(new Point(_loc12_[0].building._mc.x,_loc12_[0].building._mc.y),_loc12_[0].building);
            }
            else
            {
               _loc14_ = 0;
               while(_loc14_ < 2)
               {
                  if(_loc12_.length > _loc14_)
                  {
                     WaypointTo(new Point(_loc12_[_loc14_].building._mc.x,_loc12_[_loc14_].building._mc.y),_loc12_[_loc14_].building);
                  }
                  _loc14_++;
               }
            }
         }
      }
   }
}

