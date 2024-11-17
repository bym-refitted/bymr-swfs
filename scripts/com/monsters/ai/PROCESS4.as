package com.monsters.ai
{
   import com.monsters.pathing.PATHING;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class PROCESS4 implements IPROCESS
   {
      public var _solutions:Vector.<Solution>;
      
      private var solsProcessed:uint = 0;
      
      public var _inProgress:Boolean;
      
      public var _intelligence:Number;
      
      private var processStepResolution:int = 3;
      
      public function PROCESS4()
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
            if(_loc3_._hp.Get() > 0 && !_loc3_._looted && (_loc3_._class == "resource" || _loc3_._type == 6 || _loc3_._type == 14))
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
         _loc1_.sortOn(["damageTaken","distanceToTarget"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING]);
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
         var _loc20_:BFOUNDATION = null;
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
            _loc20_ = BASE._buildingsAll[_loc5_];
            if(_loc20_._class == "special" || _loc20_._class == "tower" || _loc20_._class == "trap" || _loc20_._class == "wall" || _loc20_._class == "resource")
            {
               if(_loc20_._class != "trap" && _loc20_._class != "wall")
               {
                  _loc4_ += 1.4 * WMATTACK._attackVolumeAmplifier;
               }
               else if(_loc20_._class == "trap" || _loc20_._class == "wall")
               {
                  _loc4_ += 0.2 * WMATTACK._attackVolumeAmplifier;
               }
            }
         }
         _loc6_ = this._intelligence * 0.5 + 0.5;
         _loc7_ = _loc4_ = int(_loc4_ * _loc6_);
         _loc8_ = BASE.BaseLevel().level / 40;
         if(_loc8_ < 0)
         {
            _loc8_ = 0;
         }
         if(_loc8_ > 1)
         {
            _loc8_ = 1;
         }
         var _loc9_:int = int(WMATTACK._fodder.length - 1) * _loc8_;
         var _loc10_:int = _loc9_ == 0 ? _loc9_ : _loc9_ - 1;
         var _loc11_:int = _loc9_ == WMATTACK._fodder.length - 1 ? _loc9_ : _loc9_ + 1;
         var _loc12_:String = WMATTACK._fodder[_loc10_];
         var _loc13_:String = WMATTACK._fodder[_loc9_];
         var _loc14_:String = WMATTACK._fodder[_loc11_];
         var _loc15_:Number = 0;
         var _loc16_:Object = {};
         var _loc17_:Number = GLOBAL._mapWidth * 0.25;
         var _loc19_:Number = Point.distance(param1.entryPoint,new Point(param1.targetBuilding.x,param1.targetBuilding.y));
         if(_loc19_ < 100)
         {
            _loc17_ += 100 - _loc19_;
         }
         if(_loc15_ == 0)
         {
            _loc15_ = _loc17_ / CREATURELOCKER._creatures[_loc12_].props.speed[0];
         }
         _loc16_[_loc12_] = _loc15_ * CREATURELOCKER._creatures[_loc12_].props.speed[0];
         _loc16_[_loc13_] = _loc15_ * CREATURELOCKER._creatures[_loc13_].props.speed[0];
         _loc16_[_loc14_] = _loc15_ * CREATURELOCKER._creatures[_loc14_].props.speed[0];
         _loc2_[_loc12_] += int(0.33 * _loc7_);
         _loc2_[_loc13_] += int(0.33 * _loc7_);
         _loc2_[_loc14_] += int(0.33 * _loc7_);
         for(_loc5_ in _loc2_)
         {
            if(_loc2_[_loc5_] == 0)
            {
               delete _loc2_[_loc5_];
            }
         }
         param1.attack = _loc2_;
         param1.distances = _loc16_;
      }
   }
}

