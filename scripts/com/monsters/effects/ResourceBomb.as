package com.monsters.effects
{
   import com.monsters.pathing.PATHING;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class ResourceBomb
   {
      private var position:Point;
      
      private var positionFromISO:Point;
      
      private var size:int;
      
      private var damage:int;
      
      private var particles:Object;
      
      private var i:int;
      
      private var particleCount:int;
      
      private var angle:Number;
      
      private var distance:int;
      
      private var damageSum:int;
      
      private var targets:Array;
      
      private var bomb:Object;
      
      private var tempPoint:Point;
      
      private var dist:int;
      
      private var tempBuilding:Array;
      
      private var mctop:DisplayObject;
      
      private var mcbottom:DisplayObject;
      
      private var totalDamage:int;
      
      private var resourceid:int;
      
      private var dpp:int;
      
      public function ResourceBomb(param1:MovieClip, param2:Point, param3:Object, param4:int)
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:BFOUNDATION = null;
         var _loc8_:Point = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Object = null;
         var _loc16_:Object = null;
         var _loc17_:Object = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         this.particles = {};
         this.targets = [];
         super();
         this.position = param2;
         this.size = param3.radius;
         this.bomb = param3;
         this.damage = param3.damage;
         this.damageSum = 0;
         this.resourceid = param3.resource;
         this.positionFromISO = PATHING.FromISO(this.position);
         if(this.resourceid != 3)
         {
            for each(_loc7_ in BASE._buildingsAll)
            {
               _loc8_ = new Point(_loc7_._mc.x,_loc7_._mc.y + _loc7_._middle);
               if(!(_loc7_._class == "trap" || _loc7_._hp.Get() <= 0 || _loc7_._class == "decoration" || _loc7_._class == "enemy" || _loc7_._class == "immovable"))
               {
                  _loc9_ = Math.atan2(this.position.y - _loc8_.y,this.position.x - _loc8_.x);
                  _loc10_ = BASE.EllipseEdgeDistanceSqrd(_loc9_,this.size,this.size * BASE._angle);
                  _loc9_ = Math.atan2(_loc8_.y - this.position.y,_loc8_.x - this.position.x);
                  _loc11_ = BASE.EllipseEdgeDistanceSqrd(_loc9_,_loc7_._size * 0.5,_loc7_._size * 0.5 * BASE._angle);
                  _loc12_ = this.position.x - _loc8_.x;
                  _loc13_ = this.position.y - _loc8_.y;
                  _loc14_ = _loc12_ * _loc12_ + _loc13_ * _loc13_;
                  if(_loc14_ * _loc14_ < (_loc10_ + _loc11_) * (_loc10_ + _loc11_))
                  {
                     this.targets.push([_loc7_,1 - 1 / (this.size * 0.5) * this.dist,this.tempPoint,_loc7_._footprint[0].width * 0.5]);
                  }
               }
            }
         }
         else
         {
            _loc17_ = CREEPS._creeps;
            for each(_loc15_ in _loc17_)
            {
               this.tempPoint = PATHING.FromISO(new Point(_loc15_.x,_loc15_.y));
               if(_loc15_._creatureID.substr(0,1) == "G")
               {
                  _loc16_ = SPRITES._sprites[_loc15_._spriteID];
               }
               else
               {
                  _loc16_ = SPRITES._sprites[_loc15_._creatureID];
               }
               this.tempPoint.add(_loc16_.middle);
               _loc18_ = this.positionFromISO.x - this.tempPoint.x;
               _loc19_ = this.positionFromISO.y - this.tempPoint.y;
               _loc20_ = this.size * 0.5;
               if(_loc18_ * _loc18_ + _loc19_ * _loc19_ < _loc20_ * _loc20_)
               {
                  this.targets.push([_loc15_]);
               }
            }
         }
         this.mctop = MAP._BUILDINGTOPS.addChild(new MovieClip());
         this.mcbottom = MAP._BUILDINGBASES.addChild(new MovieClip());
         _loc6_ = int(this.bomb.particles);
         while(_loc5_ < _loc6_)
         {
            _loc9_ = Math.random() * 360 * 0.0174532925;
            this.distance = Math.random() * this.size / 2;
            this.particles[_loc5_] = new ResourceBombParticle(MovieClip(this.mctop),MovieClip(this.mcbottom),new Point(this.position.x + Math.sin(_loc9_) * this.distance,this.position.y + Math.cos(_loc9_) * this.distance * 0.5),this,_loc5_.toString(),param4,this.resourceid);
            ++this.particleCount;
            _loc5_++;
         }
         this.dpp = param3.damage / this.particleCount;
      }
      
      public function RemoveParticle(param1:String) : void
      {
         this.particles[param1].clear();
         delete this.particles[param1];
         --this.particleCount;
      }
      
      public function Damage(param1:Point) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:BFOUNDATION = null;
         var _loc7_:Number = NaN;
         var _loc3_:int = int(this.targets.length);
         param1 = PATHING.FromISO(param1);
         if(this.resourceid != 3)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc5_ = this.targets[_loc2_];
               _loc6_ = _loc5_[0];
               _loc7_ = _loc5_[1] * 0.5 + 0.5;
               _loc4_ = _loc6_._type != 6 ? int(_loc7_ * this.dpp) : this.dpp;
               if(_loc6_._type == 6)
               {
                  _loc4_ *= _loc6_._lvl.Get();
               }
               if(_loc6_._class == "wall")
               {
                  _loc4_ *= 0.06;
               }
               if(_loc6_._class == "tower")
               {
                  _loc4_ *= 0.9;
                  if(_loc6_._type != 22 && _loc6_._type != 128 && (_loc6_ as BTOWER).isJard)
                  {
                     _loc4_ = 0;
                  }
               }
               if(_loc6_._type == 114)
               {
                  _loc4_ = 0;
               }
               this.totalDamage += _loc4_;
               _loc6_.Damage(_loc4_,this.position.x,this.position.y,1,false);
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(this.targets[_loc2_][0]._visible)
               {
                  this.targets[_loc2_][0].ModeEnrage(GLOBAL.Timestamp() + this.bomb.speedlength,this.bomb.speed,this.bomb.damageMult);
               }
               _loc2_++;
            }
         }
      }
      
      public function Tick() : Boolean
      {
         return !this.particleCount;
      }
      
      public function Freeze() : void
      {
         if(Boolean(this.mctop) && Boolean(this.mctop.parent))
         {
            this.mctop.parent.removeChild(this.mctop);
            this.mcbottom.cacheAsBitmap = true;
         }
      }
   }
}

