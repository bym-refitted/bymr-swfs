package
{
   import flash.display.MovieClip;
   import gs.*;
   import gs.easing.*;
   
   public class ParticleLoot extends MovieClip
   {
      public var _mc:*;
      
      public function ParticleLoot(param1:int, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         if(!GLOBAL._catchup)
         {
            this._mc = MAP._PROJECTILES.addChild(this);
            this._mc.x = param1 - 20 + Math.random() * 40;
            this._mc.y = param2 - 5 + Math.random() * 10;
            this._mc.gotoAndStop(param4);
            this._mc.cacheAsBitmap = true;
            TweenLite.to(this._mc,1,{
               "x":x + 10 - Math.random() * 20,
               "y":y + 20,
               "ease":Bounce.easeOut,
               "onComplete":this.Remove
            });
         }
      }
      
      public function Remove() : *
      {
         try
         {
            MAP._PROJECTILES.removeChild(this._mc);
         }
         catch(e:Error)
         {
         }
      }
   }
}

