package
{
   import com.monsters.maproom_advanced.MapRoomCell;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.Point;
   
   public class BTOWER extends BFOUNDATION
   {
      internal var creeps:Array;
      
      internal var maxDist:int;
      
      internal var minDist:int;
      
      public var _hasTargets:Boolean;
      
      public var _targetCreeps:Array;
      
      public var _priority:int;
      
      public var _retarget:int;
      
      public var _top:int;
      
      public var _fireTick:int = 0;
      
      private var pointA:Point;
      
      private var pointB:Point;
      
      public function BTOWER()
      {
         super();
         this._priority = 1;
         this._retarget = 0;
      }
      
      public static function AdjustTowerRange(param1:MapRoomCell, param2:int) : int
      {
         if(GLOBAL._advancedMap && BASE._isOutpost && param1 && param1._height && param1._height >= 100)
         {
            return int(param1._height * param2 / GLOBAL._averageAltitude.Get());
         }
         return param2;
      }
      
      public function Props() : *
      {
         var _loc1_:int = 0;
         if(_lvl.Get() > 0)
         {
            if(Boolean(GLOBAL._advancedMap) && (BASE._isOutpost || GLOBAL._mode == "wmattack"))
            {
               _loc1_ = int(GLOBAL._buildingProps[_type - 1].stats[_lvl.Get() - 1].range);
               super._range = _loc1_;
               if(GLOBAL._currentCell)
               {
                  super._range = AdjustTowerRange(GLOBAL._currentCell,_loc1_);
               }
            }
            else
            {
               super._range = GLOBAL._buildingProps[_type - 1].stats[_lvl.Get() - 1].range;
            }
            super._damage = GLOBAL._buildingProps[_type - 1].stats[_lvl.Get() - 1].damage;
            super._rate = GLOBAL._buildingProps[_type - 1].stats[_lvl.Get() - 1].rate;
            super._splash = GLOBAL._buildingProps[_type - 1].stats[_lvl.Get() - 1].splash;
            super._speed = GLOBAL._buildingProps[_type - 1].stats[_lvl.Get() - 1].speed;
         }
         this._fireTick = super._rate;
      }
      
      override public function Place(param1:MouseEvent = null) : *
      {
         ++GLOBAL._bTowerCount;
         GLOBAL._bTower = this;
         super.Place(param1);
      }
      
      override public function Description() : *
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _specialDescription = KEYS.Get("bdg_tower_desc");
         super.Description();
         _upgradeDescription = "";
         if(_lvl.Get() > 0 && _lvl.Get() < _buildingProps.costs.length)
         {
            _loc1_ = _buildingProps.stats[_lvl.Get() - 1];
            _loc2_ = _buildingProps.stats[_lvl.Get()];
            _loc3_ = int(_loc1_.range);
            _loc4_ = int(_loc2_.range);
            if(BASE._isOutpost)
            {
               _loc3_ = BTOWER.AdjustTowerRange(GLOBAL._currentCell,_loc3_);
               _loc4_ = BTOWER.AdjustTowerRange(GLOBAL._currentCell,_loc4_);
            }
            if(_loc1_.range < _loc2_.range)
            {
               _upgradeDescription += KEYS.Get("bdg_tower_rangeupgrade",{
                  "v1":_loc3_,
                  "v2":_loc4_
               }) + "<br>";
            }
            if(_loc1_.damage * (40 / _loc1_.rate) < _loc2_.damage * (40 / _loc2_.rate))
            {
               _upgradeDescription += KEYS.Get("bdg_tower_damageupgrade",{
                  "v1":int(_loc1_.damage * (40 / _loc1_.rate)),
                  "v2":int(_loc2_.damage * (40 / _loc2_.rate))
               }) + "<br>";
            }
            if(_loc1_.splash < _loc2_.splash)
            {
               _upgradeDescription += KEYS.Get("bdg_tower_explosionupgrade",{
                  "v1":_loc1_.splash,
                  "v2":_loc2_.splash
               }) + "<br>";
            }
         }
      }
      
      override public function Tick() : *
      {
         super.Tick();
         if(_countdownBuild.Get() + _countdownUpgrade.Get() + _countdownFortify.Get() == 0 && !_repairing)
         {
            CatchupRemove();
         }
      }
      
      override public function TickAttack() : *
      {
         var _loc1_:Boolean = false;
         var _loc2_:* = undefined;
         if(_hp.Get() > 0 && _countdownBuild.Get() + _countdownUpgrade.Get() + _countdownFortify.Get() == 0)
         {
            --this._fireTick;
            if(this._fireTick <= 0)
            {
               this._fireTick += _rate * 2;
               if(!this._hasTargets || !this.targetInRange())
               {
                  this.FindTargets(1,this._priority);
                  this._fireTick = 30;
                  if(CREEPS._creepCount > 150)
                  {
                     this._fireTick += CREEPS._creepCount / 15;
                  }
               }
               else
               {
                  _loc1_ = false;
                  for(_loc2_ in this._targetCreeps)
                  {
                     if(this._targetCreeps[_loc2_].creep._health.Get() > 0)
                     {
                        this.Fire(this._targetCreeps[_loc2_].creep);
                     }
                     else
                     {
                        _loc1_ = true;
                        this._targetCreeps = [];
                     }
                  }
                  if(Boolean(this._retarget) || _loc1_)
                  {
                     this.FindTargets(1,this._priority);
                     this._fireTick = 30;
                     if(CREEPS._creepCount > 150)
                     {
                        this._fireTick += CREEPS._creepCount / 15;
                     }
                  }
               }
            }
         }
      }
      
      public function targetInRange() : Boolean
      {
         var _loc1_:Point = null;
         var _loc3_:Number = NaN;
         var _loc4_:* = undefined;
         var _loc2_:Point = GRID.FromISO(_mc.x,_mc.y);
         _loc2_.add(new Point(_footprint[0].width * 0.5,_footprint[0].height * 0.5));
         for(_loc4_ in this._targetCreeps)
         {
            _loc1_ = GRID.FromISO(this._targetCreeps[_loc4_].creep._tmpPoint.x,this._targetCreeps[_loc4_].creep._tmpPoint.y);
            _loc3_ = GLOBAL.QuickDistanceSquared(_loc2_,_loc1_);
            if(_loc3_ < this._range * this._range)
            {
               return true;
            }
         }
         return false;
      }
      
      public function Fire(param1:*) : *
      {
      }
      
      override public function Update(param1:Boolean = false) : *
      {
         super.Update(param1);
      }
      
      override public function Damage(param1:int, param2:int, param3:int, param4:int = 1, param5:Boolean = true) : void
      {
         if(POWERUPS.CheckPowers(POWERUPS.ALLIANCE_ARMAMENT,"DEFENSE"))
         {
            param1 = int(POWERUPS.Apply(POWERUPS.ALLIANCE_ARMAMENT,[param1]));
         }
         var _loc6_:int = param1;
         if(_fortification.Get() > 0)
         {
            _loc6_ *= 100 - (_fortification.Get() * 10 + 10);
            _loc6_ = _loc6_ / 100;
         }
         _hp.Add(-_loc6_);
         if(_hp.Get() <= 0)
         {
            _hp.Set(0);
            if(!_destroyed)
            {
               Destroyed(param5);
            }
         }
         else if(_class != "wall")
         {
            ATTACK.Log("b" + _id,"<font color=\"#990000\">" + KEYS.Get("attack_log_%damaged",{
               "v1":_lvl.Get(),
               "v2":KEYS.Get(_buildingProps.name),
               "v3":100 - int(100 / _hpMax.Get() * _hp.Get())
            }) + "</font>");
         }
         this.Update();
         BASE.Save();
      }
      
      override public function Upgraded() : *
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Upgraded();
         this.Props();
         if(GLOBAL._mode == "build")
         {
            Brag = function(param1:MouseEvent):*
            {
               var _loc2_:String = "build-cannon.png";
               if(_type == 21)
               {
                  _loc2_ = "build-sniper.png";
               }
               if(_type == 25)
               {
                  _loc2_ = "build-lightning.png";
               }
               if(_type == 23)
               {
                  _loc2_ = "build-laser.png";
               }
               if(_type == 115)
               {
                  _loc2_ = "build-aerial.v2.png";
               }
               if(_type == 118)
               {
                  _loc2_ = "build_railgun.png";
               }
               GLOBAL.CallJS("sendFeed",["build-" + String(_buildingProps.name).toLowerCase(),KEYS.Get("pop_tupgraded_streamtitle",{
                  "v1":_lvl.Get(),
                  "v2":KEYS.Get(_buildingProps.name)
               }),"",_loc2_]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_tupgraded_title",{
               "v1":KEYS.Get(_buildingProps.name),
               "v2":_lvl.Get()
            }) + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_tupgraded_body",{"v1":KEYS.Get(_buildingProps.name)});
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function Constructed() : *
      {
         super.Constructed();
         this.Props();
      }
      
      public function FindTargets(param1:int, param2:int) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         if(_type == 21 || _type == 25)
         {
            _loc9_ = 1;
         }
         if(_type == 115)
         {
            _loc9_ = 2;
         }
         this.creeps = MAP.CreepCellFind(_position.add(new Point(_footprint[0].width / 2,_footprint[0].height / 2)),_range,_loc9_);
         this._hasTargets = false;
         if(this.creeps.length > 0)
         {
            this._targetCreeps = [];
            if(param2 == 1)
            {
               this.creeps.sortOn(["dist"],Array.NUMERIC);
            }
            else if(param2 == 2)
            {
               this.creeps.sortOn(["dist"],Array.NUMERIC | Array.DESCENDING);
            }
            else if(param2 == 3)
            {
               this.creeps.sortOn(["hp"],Array.NUMERIC | Array.DESCENDING);
            }
            else if(param2 == 4)
            {
               this.creeps.sortOn(["hp"],Array.NUMERIC);
            }
            _loc8_ = 0;
            for(_loc5_ in this.creeps)
            {
               if(++_loc8_ <= param1)
               {
                  _loc3_ = this.creeps[_loc5_];
                  _loc4_ = _loc3_.creep;
                  _loc6_ = _loc3_.dist;
                  _loc7_ = _loc3_.pos;
                  this._targetCreeps.push({
                     "creep":_loc4_,
                     "dist":_loc6_,
                     "position":_loc7_
                  });
                  this._hasTargets = true;
               }
            }
         }
      }
      
      override public function RecycleC() : *
      {
         GLOBAL._bTower = null;
         --GLOBAL._bTowerCount;
         super.RecycleC();
      }
      
      override public function Cancel() : *
      {
         GLOBAL._bTower = null;
         --GLOBAL._bTowerCount;
         super.Cancel();
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         ++GLOBAL._bTowerCount;
         GLOBAL._bTower = this;
         this.Props();
      }
   }
}

