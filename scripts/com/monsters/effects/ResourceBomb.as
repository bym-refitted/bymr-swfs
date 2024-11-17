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
         var _loc5_:BFOUNDATION = null;
         var _loc6_:* = undefined;
         var _loc7_:Object = null;
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
            for each(_loc5_ in BASE._buildingsAll)
            {
               if(_loc5_._hp.Get() > 0 && _loc5_._class != "enemy" && _loc5_._class != "trap" && _loc5_._class != "decoration" && _loc5_._class != "immovable")
               {
                  this.tempPoint = PATHING.FromISO(new Point(_loc5_._mc.x,_loc5_._mc.y));
                  this.tempPoint.add(new Point(_loc5_._footprint[0].width * 0.5,_loc5_._footprint[0].height * 0.5));
                  this.dist = Point.distance(this.positionFromISO,this.tempPoint);
                  if(this.dist < this.size * 0.45)
                  {
                     this.targets.push([_loc5_,1 - 1 / (this.size * 0.5) * this.dist,this.tempPoint,_loc5_._footprint[0].width * 0.5]);
                  }
               }
            }
         }
         else
         {
            for each(_loc6_ in CREEPS._creeps)
            {
               this.tempPoint = PATHING.FromISO(new Point(_loc6_.x,_loc6_.y));
               if(_loc6_._creatureID.substr(0,1) == "G")
               {
                  _loc7_ = SPRITES._sprites[_loc6_._spriteID];
               }
               else
               {
                  _loc7_ = SPRITES._sprites[_loc6_._creatureID];
               }
               this.tempPoint.add(_loc7_.middle);
               this.dist = Point.distance(this.positionFromISO,this.tempPoint);
               if(this.dist < this.size * 0.5)
               {
                  this.targets.push([_loc6_]);
               }
            }
         }
         this.mctop = MAP._BUILDINGTOPS.addChild(new MovieClip());
         this.mcbottom = MAP._BUILDINGBASES.addChild(new MovieClip());
         this.i = 0;
         while(this.i < this.bomb.particles)
         {
            this.angle = Math.random() * 360 * 0.0174532925;
            this.distance = Math.random() * this.size / 2;
            this.particles[this.i] = new ResourceBombParticle(MovieClip(this.mctop),MovieClip(this.mcbottom),new Point(this.position.x + Math.sin(this.angle) * this.distance,this.position.y + Math.cos(this.angle) * this.distance * 0.5),this,this.i.toString(),param4,this.resourceid);
            ++this.particleCount;
            ++this.i;
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

