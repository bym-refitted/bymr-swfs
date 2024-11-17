package gs.plugins
{
   import flash.display.*;
   import flash.filters.*;
   import gs.*;
   
   public class GlowFilterPlugin extends FilterPlugin
   {
      public static const VERSION:Number = 1;
      
      public static const API:Number = 1;
      
      public function GlowFilterPlugin()
      {
         super();
         this.propName = "glowFilter";
         this.overwriteProps = ["glowFilter"];
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         _target = param1;
         _type = GlowFilter;
         initFilter(param2,new GlowFilter(0xffffff,0,0,0,Number(param2.strength) || true,int(param2.quality) || true,param2.inner,param2.knockout));
         return true;
      }
   }
}

