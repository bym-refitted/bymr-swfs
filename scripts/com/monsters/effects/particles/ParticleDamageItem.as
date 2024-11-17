package com.monsters.effects.particles
{
   import flash.geom.Point;
   import gs.*;
   import gs.easing.*;
   
   public class ParticleDamageItem extends ParticleDamageItem_CLIP
   {
      public var _mc:*;
      
      public function ParticleDamageItem()
      {
         super();
      }
      
      public function Init(param1:Point, param2:int, param3:Boolean = false) : *
      {
         var _loc4_:* = "<b>" + param2 + "</b>";
         if(param2 < 0)
         {
            _loc4_ = "<b>" + param2 * -1 + "</b>";
         }
         this._mc = MAP._PROJECTILES.addChild(this);
         this._mc.x = param1.x - 5 + Math.random() * 10;
         this._mc.y = param1.y - 5 + Math.random() * 10;
         if(param3)
         {
            this._mc.tLootA.htmlText = "<font color=\"#6666ff\">" + _loc4_ + "</font>";
         }
         else if(param2 < 0)
         {
            this._mc.tLootA.htmlText = "<font color=\"#00ff00\">" + _loc4_ + "</font>";
         }
         else
         {
            this._mc.tLootA.htmlText = _loc4_;
         }
         this._mc.tLootB.htmlText = _loc4_;
         this._mc.cacheAsBitmap = true;
         TweenLite.to(this._mc,1,{
            "y":param1.y - (17 + Math.random() * 6),
            "ease":Cubic.easeInOut,
            "onComplete":this.Remove
         });
      }
      
      public function Remove() : *
      {
         this._mc.x = this._mc.y = -10000;
         try
         {
            MAP._PROJECTILES.removeChild(this._mc);
         }
         catch(e:Error)
         {
         }
         ParticleDamage.Remove(this);
      }
   }
}

