package com.monsters.replayableEvents
{
   import com.monsters.chat.Chat;
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Timer;
   
   public class ReplayableEventUI extends EventsBar_CLIP
   {
      public static var CLICKED_ACTION:String = "eventBarAction";
      
      public static var CLICKED_INFO:String = "eventBarInfo";
      
      public var points:int;
      
      public var _timer:Timer;
      
      private var _phase:int;
      
      private const _finalcountdown:int = 86400;
      
      private var _image:String;
      
      private var _titlelogo:String;
      
      public var _event:ReplayableEvent;
      
      private const BASEIMAGEURL:String = "specialevent/";
      
      public var eventText_tLabel:Array = ["tLabel","tLabel"];
      
      public var eventText_barProgressTxt:Array = ["fp_infobar_progressbar","fp_infobar_progressbar"];
      
      public var eventText_bActionTxt:Array = ["btn_info","btn_info"];
      
      public function ReplayableEventUI()
      {
         super();
      }
      
      public function Setup(param1:ReplayableEvent) : void
      {
         this._event = param1;
         bHelp.addEventListener(MouseEvent.CLICK,this.ShowInfoPopup);
         bHelp.buttonMode = true;
         var _loc2_:int = 1;
         if(BASE.isInferno())
         {
            _loc2_ = 2;
         }
         mcBG.gotoAndStop(_loc2_);
         bAction.gotoAndStop(_loc2_);
         mcLogo.visible = false;
         mcLogo.enabled = false;
         mcLogo.mouseEnabled = false;
         this.Update();
      }
      
      public function Update(param1:* = null) : void
      {
         gotoAndStop(this.phase);
         if(Boolean(this._event.buttonCopy) && this.phase > 1)
         {
            bActionTxt.htmlText = this._event.buttonCopy;
            bActionTxt.mouseEnabled = false;
            bActionTxt.visible = true;
            bAction.addEventListener(MouseEvent.CLICK,this.ShowEventPopup);
            bAction.buttonMode = true;
            bAction.visible = true;
            bAction.enabled = true;
         }
         else
         {
            bActionTxt.mouseEnabled = false;
            bActionTxt.visible = false;
            bAction.visible = false;
            bAction.enabled = false;
         }
         this.updateImage();
         this.Tick();
      }
      
      public function Tick(param1:* = null) : void
      {
         this.updateText();
         this.Resize();
      }
      
      public function get phase() : Number
      {
         if(this._event.hasEventStarted)
         {
            this._phase = 2;
         }
         else
         {
            this._phase = 1;
         }
         return this._phase;
      }
      
      public function updateText() : void
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         if(tTitle)
         {
            tTitle.htmlText = this._event.name;
            tTitle.mouseEnabled = false;
            if(this._event.titleImage)
            {
               tTitle.visible = false;
            }
         }
         var _loc1_:int = this._event.timeUntilNextDate;
         if(_loc1_ <= 0)
         {
            tLabel.htmlText = "<b>DATE NOT INITIALIZED!</b>";
         }
         else
         {
            _loc2_ = GLOBAL.ToTime(_loc1_,true);
            tLabel.htmlText = "<b>" + _loc2_ + "</b>";
         }
         tLabel.mouseEnabled = false;
         if(this.phase > 1)
         {
            _loc3_ = 0;
            _loc4_ = this._event.progress;
            _loc5_ = 1;
            _loc5_ = 1;
            _loc4_ = this._event.progress;
            _loc6_ = this.PhaseKey(this.eventText_barProgressTxt);
            _loc3_ = Math.min(100,Math.floor(this._event.progress * 100));
            barProgressTxt.htmlText = "" + _loc6_ + " - " + _loc3_ + " %" + "";
            barProgress.mcBar.width = Math.min(100,this._event.progress * 100);
         }
      }
      
      public function updateImage() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(Boolean(this._event.imageURL) && this._event.imageURL != this._image)
         {
            _loc1_ = this._event.imageURL;
            this._image = _loc1_;
            ImageCache.GetImageWithCallBack(this._image,this.onImageLoaded);
         }
         if(!this._event.hasEventStarted && this._event.titleImage && this._event.titleImage != this._titlelogo)
         {
            _loc2_ = this._event.titleImage;
            this._titlelogo = _loc2_;
            ImageCache.GetImageWithCallBack(this._titlelogo,this.onLogoLoaded);
         }
         else if(this._event.hasEventStarted && mcLogo.visible)
         {
            mcLogo.visible = false;
         }
      }
      
      public function onImageLoaded(param1:String, param2:BitmapData) : void
      {
         while(mcImage.numChildren)
         {
            mcImage.removeChildAt(0);
         }
         mcImage.addChild(new Bitmap(param2));
      }
      
      public function onLogoLoaded(param1:String, param2:BitmapData) : void
      {
         while(mcLogo.numChildren)
         {
            mcLogo.removeChildAt(0);
         }
         var _loc3_:Bitmap = new Bitmap(param2);
         _loc3_.y = -5;
         mcLogo.addChild(_loc3_);
         mcLogo.visible = true;
      }
      
      public function ShowEventPopup(param1:MouseEvent = null) : void
      {
         dispatchEvent(new Event(CLICKED_ACTION));
      }
      
      public function ShowInfoPopup(param1:MouseEvent = null) : void
      {
         dispatchEvent(new Event(CLICKED_INFO));
      }
      
      public function Hide() : void
      {
         if(Boolean(this.parent))
         {
            bHelp.removeEventListener(MouseEvent.CLICK,this.ShowInfoPopup);
            bAction.removeEventListener(MouseEvent.CLICK,this.ShowEventPopup);
            parent.removeChild(this);
         }
      }
      
      public function Resize() : void
      {
         GLOBAL.RefreshScreen();
         x = int(GLOBAL._SCREEN.x + 5 + 30);
         y = int(GLOBAL._SCREEN.y + GLOBAL._SCREEN.height - mcHit.height - 10);
         if(Chat._bymChat && Chat._bymChat.chatBox && Boolean(Chat._bymChat.chatBox.background))
         {
            y = int(Chat._bymChat.y + Chat._bymChat.chatBox.y + Chat._bymChat.chatBox.background.y - 53);
         }
      }
      
      public function PhaseKey(param1:Array, param2:Boolean = true) : String
      {
         if(this.phase - 1 < param1.length - 1)
         {
            if(param2)
            {
               return KEYS.Get(param1[this.phase - 1]);
            }
            return param1[this.phase - 1];
         }
         if(param2)
         {
            return KEYS.Get(param1[param1.length - 1]);
         }
         return param1[param1.length - 1];
      }
   }
}

