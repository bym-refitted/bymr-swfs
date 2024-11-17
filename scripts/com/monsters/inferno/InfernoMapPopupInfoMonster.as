package com.monsters.inferno
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class InfernoMapPopupInfoMonster extends MapRoomPopupInfoMonster_CLIP
   {
      private var _imageRequested:Boolean = false;
      
      public function InfernoMapPopupInfoMonster()
      {
         super();
      }
      
      public function Setup(param1:int, param2:int, param3:String, param4:int) : *
      {
         var creatureProps:* = undefined;
         var names:Object = null;
         var ImageLoaded:Function = null;
         var X:int = param1;
         var Y:int = param2;
         var monsterID:String = param3;
         var quantity:int = param4;
         ImageLoaded = function(param1:String, param2:BitmapData):*
         {
            mcImage.addChild(new Bitmap(param2));
            mcImage.width = 30;
            mcImage.height = 27;
         };
         creatureProps = CREATURELOCKER._creatures[monsterID];
         if(!creatureProps)
         {
            return;
         }
         names = {
            "G1":"Gorgo",
            "G2":"Drull",
            "G3":"Fomor"
         };
         x = X;
         y = Y;
         if(monsterID.substr(0,1) == "G")
         {
            tName.htmlText = "<b>" + names[monsterID.substr(0,2)] + "</b>";
         }
         else if(quantity)
         {
            tName.htmlText = "<b>" + KEYS.Get(creatureProps.name) + ": " + GLOBAL.FormatNumber(quantity) + "</b>";
         }
         else
         {
            tName.htmlText = "<b>" + KEYS.Get(creatureProps.name) + "</b>";
         }
         if(!this._imageRequested)
         {
            ImageCache.GetImageWithCallBack("monsters/" + monsterID + "-small.png",ImageLoaded);
            this._imageRequested = true;
         }
      }
   }
}

