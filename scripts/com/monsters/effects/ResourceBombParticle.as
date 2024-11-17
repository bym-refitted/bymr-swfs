package com.monsters.effects
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gs.TweenLite;
   import gs.easing.Sine;
   
   internal class ResourceBombParticle
   {
      internal var mc:DisplayObject;
      
      internal var container:MovieClip;
      
      internal var bmd_frame:BitmapData;
      
      internal var mctop:MovieClip;
      
      internal var mcbottom:MovieClip;
      
      internal var animframe:int;
      
      internal var variation:int;
      
      public function ResourceBombParticle(param1:MovieClip, param2:MovieClip, param3:Point, param4:ResourceBomb, param5:String, param6:int, param7:int)
      {
         var offset:Point;
         var Add:Function = null;
         var Hit:Function = null;
         var Anim:Function = null;
         var mct:MovieClip = param1;
         var mcb:MovieClip = param2;
         var position:Point = param3;
         var bomb:ResourceBomb = param4;
         var id:String = param5;
         var delay:int = param6;
         var resourceid:int = param7;
         super();
         Add = function():*
         {
            mc.visible = true;
         };
         Hit = function():*
         {
            var _loc1_:Point = null;
            mctop.removeChild(mc);
            animframe = 0;
            _loc1_ = new Point(0,0);
            if(resourceid == 1)
            {
               bmd_frame.copyPixels(ResourceBombs.bmd_twigs,new Rectangle(24 * variation,30,24,30),new Point(0,0));
               mc = mcbottom.addChild(new Bitmap(bmd_frame));
               bomb.RemoveParticle(id);
               _loc1_.x = -12;
               _loc1_.y = -15;
            }
            else if(resourceid == 2)
            {
               variation = int(Math.random() * 4);
               bmd_frame = new BitmapData(80,85,true,0xffffff);
               bmd_frame.copyPixels(ResourceBombs.bmd_pebblehit,new Rectangle(0,85 * variation,80,85),new Point(0,0));
               mc = mcbottom.addChild(new Bitmap(bmd_frame));
               mc.addEventListener(Event.ENTER_FRAME,Anim);
               _loc1_.x = -40;
               _loc1_.y = -50;
            }
            else
            {
               variation = int(Math.random() * 4);
               bmd_frame = new BitmapData(81,52,true,0xffffff);
               bmd_frame.copyPixels(ResourceBombs.bmd_putty,new Rectangle(0,81 * variation,81,52),new Point(0,0));
               mc = mcbottom.addChild(new Bitmap(bmd_frame));
               mc.addEventListener(Event.ENTER_FRAME,Anim);
               _loc1_.x = -40;
               _loc1_.y = -26;
            }
            mc.x = position.x + _loc1_.x;
            mc.y = position.y + _loc1_.y;
            bomb.Damage(position);
         };
         Anim = function(param1:Event):*
         {
            var _loc3_:Rectangle = null;
            if(resourceid == 2)
            {
               if(animframe == 20)
               {
                  mc.removeEventListener(Event.ENTER_FRAME,Anim);
                  bomb.RemoveParticle(id);
               }
               else
               {
                  _loc3_ = new Rectangle(80 * animframe,85 * variation,80,85);
                  bmd_frame.copyPixels(ResourceBombs.bmd_pebblehit,_loc3_,new Point(0,0));
                  ++animframe;
               }
            }
            else if(animframe == 14)
            {
               mc.removeEventListener(Event.ENTER_FRAME,Anim);
               bomb.RemoveParticle(id);
            }
            else
            {
               _loc3_ = new Rectangle(81 * animframe,81 * variation,81,52);
               bmd_frame.copyPixels(ResourceBombs.bmd_putty,_loc3_,new Point(0,0));
               ++animframe;
            }
         };
         this.mctop = mct;
         this.mcbottom = mcb;
         offset = new Point();
         if(resourceid == 1)
         {
            this.variation = int(Math.random() * 5);
            this.bmd_frame = new BitmapData(24,30,true,0xffffff);
            this.bmd_frame.copyPixels(ResourceBombs.bmd_twigs,new Rectangle(24 * this.variation,0,24,30),new Point(0,0));
            this.mc = this.mctop.addChild(new Bitmap(this.bmd_frame));
            offset.x = -12;
            offset.y = -15;
         }
         else if(resourceid == 2)
         {
            this.variation = int(Math.random() * 18);
            this.bmd_frame = new BitmapData(27,17,true,0xffffff);
            this.bmd_frame.copyPixels(ResourceBombs.bmd_pebble,new Rectangle(27 * this.variation,0,27,17),new Point(0,0));
            this.mc = this.mctop.addChild(new Bitmap(this.bmd_frame));
            offset.x = -40;
            offset.y = -42;
         }
         else if(resourceid == 3)
         {
            this.bmd_frame = new BitmapData(81,52,true,0xffffff);
            this.bmd_frame.copyPixels(ResourceBombs.bmd_putty,new Rectangle(0,0,81,52),new Point(0,0));
            this.mc = this.mctop.addChild(new Bitmap(this.bmd_frame));
            offset.x = -40;
            offset.y = -26;
         }
         this.mc.x = position.x + 100 + offset.x;
         this.mc.y = position.y - 400 + offset.y;
         this.mc.visible = false;
         this.mc.cacheAsBitmap = true;
         if(resourceid == 3)
         {
            TweenLite.to(this.mc,0.3 + Math.random() * 0.5,{
               "delay":1,
               "x":position.x,
               "y":position.y,
               "onStart":Add,
               "onComplete":Hit,
               "ease":Sine.easeIn
            });
         }
         else
         {
            TweenLite.to(this.mc,0.3 + Math.random() * 0.5,{
               "delay":1 + Math.random() * (delay * 2),
               "x":position.x,
               "y":position.y,
               "onStart":Add,
               "onComplete":Hit,
               "ease":Sine.easeIn
            });
         }
      }
   }
}

