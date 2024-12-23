package com.monsters.maproom_inferno
{
   import com.cc.utils.SecNum;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.text.TextFieldAutoSize;
   
   public class PlayerBase extends PlayerBaseInferno_CLIP
   {
      public var data:Object;
      
      public var mapX:int;
      
      public var mapY:int;
      
      private var loader:Loader;
      
      public var image:Sprite;
      
      public var nameBox:Sprite;
      
      private var pin:Sprite;
      
      public function PlayerBase(param1:Number, param2:Number)
      {
         var tgtWidth:Number;
         var onLoadError:Function = null;
         var baseID:Number = param1;
         var baseSeed:Number = param2;
         onLoadError = function(param1:IOErrorEvent):void
         {
         };
         super();
         this.data = {};
         this.data.baseid = new SecNum(Number(baseID));
         this.data.baseseed = new SecNum(Number(baseSeed));
         this.data.ownerName = "My Yard";
         this.loader = new Loader();
         try
         {
            if(LOGIN._playerPic.length > 5)
            {
               this.loader.load(new URLRequest(LOGIN._playerPic),new LoaderContext(true));
            }
         }
         catch(e:*)
         {
         }
         this.loader.x = placeholder.x;
         this.loader.y = placeholder.y;
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageComplete);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
         this.image = new Sprite();
         addChild(this.image);
         this.image.addChild(photoFrame_mc);
         this.image.addChild(placeholder);
         this.image.addChild(this.loader);
         this.image.addChild(frame_mc);
         name_txt.autoSize = TextFieldAutoSize.LEFT;
         name_txt.htmlText = "<b>" + KEYS.Get("map_mybase");
         name_txt.x = name_txt.textWidth * -0.5;
         this.nameBox = new Sprite();
         this.nameBox.addChild(box_mc);
         this.nameBox.addChild(name_txt);
         addChild(this.nameBox);
         this.nameBox.x = -2;
         tgtWidth = name_txt.textWidth + 14;
         box_mc.width = tgtWidth < 51 ? 51 : tgtWidth;
         addChild(nail);
         this.mouseChildren = false;
      }
      
      private function onImageComplete(param1:Event) : void
      {
         this.loader.height = 44;
         this.loader.width = 44;
      }
   }
}

