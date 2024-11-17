package com.monsters.maproom_advanced
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class MapRoomPopupInfoMonster extends MapRoomPopupInfoMonster_CLIP
   {
      private var _imageRequested:Boolean = false;
      
      public function MapRoomPopupInfoMonster()
      {
         super();
      }
      
      public function Setup(param1:int, param2:int, param3:String, param4:int) : *
      {
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
            tName.htmlText = "<b>" + KEYS.Get(CREATURELOCKER._creatures[monsterID].name) + ": " + GLOBAL.FormatNumber(quantity) + "</b>";
         }
         else
         {
            tName.htmlText = "<b>" + KEYS.Get(CREATURELOCKER._creatures[monsterID].name) + "</b>";
         }
         if(!this._imageRequested)
         {
            ImageCache.GetImageWithCallBack("monsters/" + monsterID + "-small.png",ImageLoaded);
            this._imageRequested = true;
         }
      }
   }
}

