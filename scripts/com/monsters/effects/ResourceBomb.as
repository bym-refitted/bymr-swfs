package com.monsters.effects
{
   import com.monsters.pathing.PATHING;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class ResourceBomb
   {
      internal var position:Point;
      
      internal var positionFromISO:Point;
      
      internal var size:int;
      
      internal var damage:int;
      
      internal var particles:Object;
      
      internal var i:int;
      
      internal var particleCount:int;
      
      internal var angle:Number;
      
      internal var distance:int;
      
      internal var damageSum:int;
      
      internal var targets:Array;
      
      internal var bomb:Object;
      
      internal var tempPoint:Point;
      
      internal var dist:int;
      
      internal var tempBuilding:Array;
      
      internal var mctop:DisplayObject;
      
      internal var mcbottom:DisplayObject;
      
      internal var totalDamage:int;
      
      internal var resourceid:int;
      
      internal var dpp:*;
      
      public function ResourceBomb(param1:MovieClip, param2:Point, param3:Object, param4:int)
      {
         var _loc5_:* = undefined;
         var _loc6_:BFOUNDATION = null;
         var _loc7_:Point = null;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:Object = null;
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
            for(_loc5_ in BASE._buildingsAll)
            {
               _loc6_ = BASE._buildingsAll[_loc5_];
               _loc7_ = new Point(_loc6_._mc.x,_loc6_._mc.y + _loc6_._middle);
               if(!(_loc6_._class == "trap" || _loc6_._hp.Get() <= 0 || _loc6_._class == "decoration" || _loc6_._class == "enemy" || _loc6_._class == "immovable"))
               {
                  _loc8_ = Math.atan2(this.position.y - _loc7_.y,this.position.x - _loc7_.x);
                  _loc9_ = BASE.EllipseEdgeDistance(_loc8_,this.size,this.size * BASE._angle);
                  _loc8_ = Math.atan2(_loc7_.y - this.position.y,_loc7_.x - this.position.x);
                  _loc10_ = BASE.EllipseEdgeDistance(_loc8_,_loc6_._size * 0.5,_loc6_._size * 0.5 * BASE._angle);
                  _loc11_ = this.position.x - _loc7_.x;
                  _loc12_ = this.position.y - _loc7_.y;
                  _loc13_ = int(Math.sqrt(_loc11_ * _loc11_ + _loc12_ * _loc12_));
                  if(_loc13_ < _loc9_ + _loc10_)
                  {
                     this.targets.push([_loc6_,1 - 1 / (this.size * 0.5) * _loc13_,this.tempPoint,_loc6_._footprint[0].width * 0.5]);
                  }
               }
            }
         }
         else
         {
            for each(_loc14_ in CREEPS._creeps)
            {
               this.tempPoint = PATHING.FromISO(new Point(_loc14_.x,_loc14_.y));
               if(_loc14_._creatureID.substr(0,1) == "G")
               {
                  _loc15_ = SPRITES._sprites[_loc14_._spriteID];
               }
               else
               {
                  _loc15_ = SPRITES._sprites[_loc14_._creatureID];
               }
               this.tempPoint.add(_loc15_.middle);
               _loc13_ = Point.distance(this.positionFromISO,this.tempPoint);
               if(_loc13_ < this.size * 0.5)
               {
                  this.targets.push([_loc14_]);
               }
            }
         }
         this.mctop = MAP._BUILDINGTOPS.addChild(new MovieClip());
         this.mcbottom = MAP._BUILDINGBASES.addChild(new MovieClip());
         _loc5_ = 0;
         while(_loc5_ < this.bomb.particles)
         {
            _loc8_ = Math.random() * 360 * 0.0174532925;
            this.distance = Math.random() * this.size / 2;
            this.particles[_loc5_] = new ResourceBombParticle(MovieClip(this.mctop),MovieClip(this.mcbottom),new Point(this.position.x + Math.sin(_loc8_) * this.distance,this.position.y + Math.cos(_loc8_) * this.distance * 0.5),this,_loc5_.toString(),param4,this.resourceid);
            ++this.particleCount;
            _loc5_++;
         }
         this.dpp = param3.damage / this.particleCount;
      }
      
      public function RemoveParticle(param1:String) : *
      {
         delete this.particles[param1];
         --this.particleCount;
      }
      
      public function Damage(param1:Point) : *
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
         if(this.particleCount == 0)
         {
            return true;
         }
         return false;
      }
      
      public function Freeze() : *
      {
         if(Boolean(this.mctop) && Boolean(this.mctop.parent))
         {
            this.mctop.parent.removeChild(this.mctop);
            this.mcbottom.cacheAsBitmap = true;
         }
      }
   }
}

