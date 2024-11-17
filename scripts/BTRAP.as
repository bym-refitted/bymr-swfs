package
{
   import flash.events.*;
   import flash.geom.Point;
   
   public class BTRAP extends BFOUNDATION
   {
      internal var f:*;
      
      internal var i:*;
      
      internal var creeps:Array;
      
      internal var maxDist:int;
      
      internal var minDist:int;
      
      public var _hasTargets:Boolean;
      
      public var _targetCreeps:Array;
      
      public var _retarget:int;
      
      public function BTRAP()
      {
         super();
         _fired = false;
         this._retarget = 0;
      }
      
      override public function SetProps() : *
      {
         super.SetProps();
         if(GLOBAL._mode != "build")
         {
            _mc.visible = false;
            _mcBase.visible = false;
         }
      }
      
      override public function TickAttack() : *
      {
         if(_countdownBuild.Get() == 0 && !_fired)
         {
            if(!this._hasTargets)
            {
               if(this._retarget == 0)
               {
                  this.FindTargets();
                  this._retarget = 20;
               }
               --this._retarget;
            }
            else
            {
               this.Explode();
            }
         }
      }
      
      public function FindTargets() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         this.creeps = MAP.CreepCellFind(_position,20,-1);
         this._hasTargets = false;
         this._targetCreeps = [];
         var _loc7_:int = 0;
         var _loc8_:* = this.creeps;
         for(_loc3_ in _loc8_)
         {
            _loc1_ = this.creeps[_loc3_];
            _loc2_ = _loc1_.creep;
            _loc4_ = _loc1_.dist;
            _loc5_ = _loc1_.pos;
            this._targetCreeps.push({
               "creep":_loc2_,
               "dist":_loc4_,
               "position":_loc5_
            });
            this._hasTargets = true;
         }
      }
      
      public function Explode() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc10_:Number = NaN;
         var _loc7_:* = MAP.CreepCellFind(new Point(_mc.x,_mc.y),_size,-1);
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         for(_loc3_ in _loc7_)
         {
            _loc1_ = _loc7_[_loc3_];
            _loc2_ = _loc1_.creep;
            if(_loc2_._health.Get() > 0)
            {
               _loc8_++;
               _loc4_ = _loc1_.dist;
               _loc5_ = _loc1_.pos;
               if(POWERUPS.CheckPowers(POWERUPS.ALLIANCE_ARMAMENT,"DEFENSE"))
               {
                  _loc10_ = POWERUPS.Apply(POWERUPS.ALLIANCE_ARMAMENT,[null,_buildingProps.damage[0]]);
                  _loc2_._health.Add(-(_loc2_._damageMult * (_loc10_ / _buildingProps.size) * (_buildingProps.size - _loc4_ * 0.5)));
               }
               else
               {
                  _loc2_._health.Add(-(_loc2_._damageMult * (_buildingProps.damage[0] / _buildingProps.size) * (_buildingProps.size - _loc4_ * 0.5)));
               }
               if(_loc2_._health.Get() <= 0)
               {
                  _loc9_++;
                  GIBLETS.Create(new Point(_mc.x,_mc.y + 3),0.8,75,2);
               }
            }
         }
         if(_loc8_ > 0)
         {
            _fired = true;
            if(_loc9_ == _loc8_)
            {
               ATTACK.Log("trap" + _id,"<font color=\"#FF0000\">" + KEYS.Get("attack_log_trapkilled",{
                  "v1":KEYS.Get(_buildingProps.name),
                  "v2":_loc9_
               }) + "</font>");
            }
            else if(_loc9_ > 0)
            {
               ATTACK.Log("trap" + _id,"<font color=\"#FF0000\">" + KEYS.Get("attack_log_trapdamagedkilled",{
                  "v1":KEYS.Get(_buildingProps.name),
                  "v2":_loc8_,
                  "v3":_loc9_
               }) + "</font>");
            }
            else
            {
               ATTACK.Log("trap" + _id,"<font color=\"#FF0000\">" + KEYS.Get("attack_log_trapdamaged",{
                  "v1":KEYS.Get(_buildingProps.name),
                  "v2":_loc8_
               }) + "</font>");
            }
            EFFECTS.Scorch(new Point(_mc.x,_mc.y + 5));
         }
         this._hasTargets = false;
         _mc.gotoAndStop(2);
         _mc.visible = true;
         _hp.Set(0);
         SOUNDS.Play("trap");
         if(GLOBAL._mode == "build")
         {
            RecycleC();
         }
      }
   }
}

