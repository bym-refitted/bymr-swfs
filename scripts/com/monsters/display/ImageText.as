package com.monsters.display
{
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ImageText
   {
      public function ImageText()
      {
         super();
      }
      
      public static function Get(param1:String, param2:int = 13, param3:int = 0, param4:Array = null) : BitmapData
      {
         var _loc5_:TextFormat = new TextFormat();
         _loc5_.font = "GROBOLD";
         _loc5_.size = param2;
         _loc5_.color = 0xffffff;
         _loc5_.letterSpacing = param3;
         var _loc6_:TextField = new TextField();
         _loc6_.embedFonts = true;
         _loc6_.antiAliasType = AntiAliasType.NORMAL;
         _loc6_.width = 10 * 60;
         _loc6_.defaultTextFormat = _loc5_;
         _loc6_.text = param1;
         if(param4)
         {
            _loc6_.filters = param4;
         }
         else
         {
            _loc6_.filters = [new GlowFilter(0,1,2,2,5,2)];
         }
         var _loc7_:BitmapData = new BitmapData(_loc6_.textWidth + 5,_loc6_.textHeight + 5,true,0);
         _loc7_.draw(_loc6_);
         return _loc7_;
      }
   }
}

