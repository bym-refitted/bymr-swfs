package com.monsters.ai
{
   import com.monsters.pathing.PATHING;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class PROCESS_INFERNO1 implements IPROCESS
   {
      public var _solutions:Vector.<Solution>;
      
      private var solsProcessed:uint = 0;
      
      public var _inProgress:Boolean;
      
      public var _intelligence:Number;
      
      private var processStepResolution:int = 3;
      
      public function PROCESS_INFERNO1()
      {
         super();
      }
      
      public function Trigger(param1:Number = 1) : void
      {
         this._intelligence = param1;
         this._inProgress = true;
         this._solutions = new Vector.<Solution>();
         var _loc2_:Number = GLOBAL._mapWidth;
         var _loc3_:Number = GLOBAL._mapHeight;
         var _loc4_:int = 0;
         while(_loc4_ < WMATTACK._attackResolution)
         {
            this._solutions.push(new Solution(360 / WMATTACK._attackResolution * _loc4_,_loc2_,_loc3_));
            _loc4_ += 1;
         }
         this.solsProcessed = 0;
         this.Process(this._solutions[0],this.onProcess);
      }
      
      public function Process(param1:Solution, param2:Function) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Point = null;
         var _loc6_:Number = NaN;
         var _loc5_:Array = [];
         for each(_loc3_ in BASE._buildingsMain)
         {
            if(_loc3_._hp.Get() > 0 && !_loc3_._looted)
            {
               _loc4_ = GRID.FromISO(_loc3_.x,_loc3_.y);
               _loc6_ = Point.distance(param1.entryPoint,_loc4_);
               _loc5_.push({
                  "building":_loc3_,
                  "distance":_loc6_
               });
            }
         }
         if(_loc5_.length > 0)
         {
            _loc5_.sortOn("distance",Array.NUMERIC);
            param1.targetBuilding = _loc5_[0].building;
            param1.targetHP += param1.targetBuilding._hp.Get();
            if(param1.targetHP > 50000)
            {
               param1.targetHP = 50000;
            }
            param1.wayPoints = PATHING.GetPath(GRID.ToISO(param1.entryPoint.x,param1.entryPoint.y,0),new Rectangle(param1.targetBuilding.x,param1.targetBuilding.y,param1.targetBuilding._footprint[0].width,param1.targetBuilding._footprint[0].height),param2);
         }
      }
      
      public function onProcess(param1:Array, param2:BFOUNDATION = null, param3:int = 0, param4:Boolean = false, param5:BFOUNDATION = null) : void
      {
         this._solutions[this.solsProcessed].wayPoints = param1;
         this._solutions[this.solsProcessed].distanceToTarget = param1.length;
         this.solsProcessed += 1;
         if(this.solsProcessed < WMATTACK._attackResolution)
         {
            this.Process(this._solutions[this.solsProcessed],this.onProcess);
         }
         else
         {
            this.beginProcessB();
         }
      }
      
      public function beginProcessB() : void
      {
         var _loc2_:Solution = null;
         var _loc3_:int = 0;
         var _loc1_:Array = [].concat();
         for each(_loc2_ in this._solutions)
         {
            this.ProcessB(_loc2_);
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn(["damageTaken","distanceToTarget","targetHP"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.NUMERIC]);
         _loc3_ = int((_loc1_.length - 1) * this._intelligence);
         this.ProcessC(_loc1_[_loc3_]);
         this._inProgress = false;
         WMATTACK.Queue(_loc1_[_loc3_]);
      }
      
      public function ProcessB(param1:Solution) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.wayPoints.length)
         {
            param1.damageTaken += WMATTACK._damageBias * this.processStepResolution * WMATTACK.dpsAtPoint(param1,param1.wayPoints[_loc2_]);
            _loc2_ += this.processStepResolution;
         }
      }
      
      public function ProcessC(param1:Solution) : void
      {
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc26_:* = undefined;
         var _loc2_:Object = {};
         var _loc3_:int = 0;
         while(_loc3_ < WMATTACK._monsterKeys.length)
         {
            _loc2_[WMATTACK._monsterKeys[_loc3_]] = 0;
            _loc3_ += 1;
         }
         var _loc4_:Number = 0;
         for(_loc5_ in BASE._buildingsAll)
         {
            _loc26_ = BASE._buildingsAll[_loc5_];
            if(_loc26_._class != "trap" && _loc26_._class != "wall")
            {
               _loc4_ += 1 * WMATTACK._attackVolumeAmplifier;
            }
            else if(_loc26_._class == "trap" || _loc26_._class == "wall")
            {
               _loc4_ += 0.15 * WMATTACK._attackVolumeAmplifier;
            }
         }
         _loc6_ = this._intelligence * 0.5 + 0.5;
         _loc4_ = int(_loc4_ * _loc6_);
         _loc7_ = 2;
         _loc12_ = 0.25;
         _loc8_ = _loc4_ * _loc12_;
         _loc9_ = _loc8_ / _loc7_;
         _loc11_ = _loc4_ - (_loc8_ + _loc9_);
         _loc13_ = BASE.BaseLevel().level / 40;
         if(_loc13_ < 0)
         {
            _loc13_ = 0;
         }
         if(_loc13_ > 1)
         {
            _loc13_ = 1;
         }
         var _loc14_:String = WMATTACK._infernoAnything[int((WMATTACK._infernoAnything.length - 1) * _loc13_)];
         var _loc15_:String = WMATTACK._infernoTanks[int((WMATTACK._tanks.length - 1) * _loc13_)];
         var _loc16_:String = WMATTACK._infernoDps[int((WMATTACK._dps.length - 1) * _loc13_)];
         var _loc17_:String = WMATTACK._infernoHunters[int((WMATTACK._infernoHunters.length - 1) * _loc13_)];
         var _loc18_:Number = 0;
         var _loc19_:Object = {};
         var _loc20_:Number = GLOBAL._mapWidth * 0.25;
         var _loc22_:Number = Point.distance(param1.entryPoint,new Point(param1.targetBuilding.x,param1.targetBuilding.y));
         if(_loc22_ < 100)
         {
            _loc20_ += 100 - _loc22_;
         }
         if(_loc8_ >= 1)
         {
            if(_loc18_ == 0)
            {
               _loc18_ = _loc20_ / CREATURELOCKER._creatures[_loc15_].props.speed[0];
            }
            _loc19_[_loc15_] = _loc18_ * CREATURELOCKER._creatures[_loc15_].props.speed[0];
         }
         if(_loc9_ >= 1)
         {
            if(_loc18_ == 0)
            {
               _loc18_ = _loc20_ / CREATURELOCKER._creatures[_loc16_].props.speed[0];
            }
            _loc19_[_loc16_] = _loc18_ * CREATURELOCKER._creatures[_loc16_].props.speed[0];
         }
         if(_loc10_ >= 1)
         {
            if(_loc18_ == 0)
            {
               _loc18_ = _loc20_ / CREATURELOCKER._creatures[_loc14_].props.speed[0];
            }
            _loc19_[_loc14_] = _loc18_ * CREATURELOCKER._creatures[_loc14_].props.speed[0];
         }
         if(_loc11_ >= 1)
         {
            if(_loc18_ == 0)
            {
               _loc18_ = _loc20_ / CREATURELOCKER._creatures[_loc17_].props.speed[0];
            }
            _loc19_[_loc17_] = _loc18_ * CREATURELOCKER._creatures[_loc17_].props.speed[0];
         }
         _loc2_[_loc15_] = int(_loc8_);
         if(_loc15_ == _loc16_)
         {
            _loc2_[_loc15_] += int(_loc9_);
         }
         else
         {
            _loc2_[_loc16_] = int(_loc9_);
         }
         if(_loc15_ == _loc17_)
         {
            _loc2_[_loc15_] += int(_loc11_);
         }
         else
         {
            _loc2_[_loc17_] = int(_loc11_);
         }
         var _loc23_:Object = {};
         _loc23_[_loc15_] = int(_loc8_);
         var _loc24_:Object = {};
         _loc24_[_loc16_] = int(_loc9_);
         var _loc25_:Object = {};
         _loc25_[_loc17_] = int(_loc11_);
         for(_loc5_ in _loc2_)
         {
            if(_loc2_[_loc5_] == 0)
            {
               delete _loc2_[_loc5_];
            }
         }
         param1.attack = _loc2_;
         param1.tanks = _loc23_;
         param1.dps = _loc24_;
         param1.anything = _loc25_;
         param1.distances = _loc19_;
      }
   }
}

