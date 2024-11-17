package com.monsters.replayableEvents
{
   import com.monsters.chat.Chat;
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   
   public class MultiRewardReplayableEventUI extends MultiRewardEventsBar implements IReplayableEventUI
   {
      public static var CLICKED_ACTION:String = "eventBarAction";
      
      public static var CLICKED_INFO:String = "eventBarInfo";
      
      private var _event:ReplayableEvent;
      
      public function MultiRewardReplayableEventUI()
      {
         super();
      }
      
      public function get eventUI() : DisplayObject
      {
         return this;
      }
      
      public function setup(param1:ReplayableEvent) : void
      {
         var _loc7_:ReplayableEventQuota = null;
         var _loc8_:EventRewardRibbon = null;
         var _loc9_:DisplayObject = null;
         var _loc10_:DisplayObject = null;
         this._event = param1;
         this.stop();
         buttonHelp.addEventListener(MouseEvent.CLICK,this.ShowInfoPopup);
         buttonHelp.buttonMode = true;
         buttonAction.stop();
         buttonAction.addEventListener(MouseEvent.CLICK,this.ShowEventPopup,false,0,true);
         buttonAction.buttonMode = true;
         buttonActionLabel.text = this._event.buttonCopy;
         buttonActionLabel.mouseEnabled = false;
         if(this._event.imageURL)
         {
            ImageCache.GetImageWithCallBack(this._event.imageURL,this.onImageLoaded);
         }
         if(this._event.titleImage)
         {
            ImageCache.GetImageWithCallBack(this._event.titleImage,this.onLogoLoaded);
         }
         var _loc2_:Number = 0;
         var _loc4_:uint = this._event.rewards.length;
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = this._event.rewards[_loc5_];
            if(!(_loc7_.rewardID == null || _loc7_.rewardID == ""))
            {
               _loc8_ = this.getChildByName("reward" + _loc2_) as EventRewardRibbon;
               if(_loc8_ == null)
               {
                  break;
               }
               ImageCache.GetImageWithCallBack(_loc7_.imageURL,this.onRewardImageLoaded,true,4,"",[_loc8_]);
               _loc2_++;
               if(_loc2_ >= 3)
               {
                  break;
               }
            }
            _loc5_++;
         }
         _loc5_ = _loc2_;
         while(_loc5_ < 3)
         {
            this.getChildByName("reward" + _loc5_).visible = false;
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc9_ = this.getChildByName("mouseOverActivationSection" + _loc5_);
            _loc9_.alpha = 0.01;
            _loc9_.addEventListener(MouseEvent.MOUSE_OVER,this.OnProgressBarSectionMouseOver,false,0,true);
            _loc9_.addEventListener(MouseEvent.MOUSE_OUT,this.OnProgressBarSectionMouseOut,false,0,true);
            _loc10_ = this.getChildByName("mouseOverSection" + _loc5_);
            _loc10_.visible = false;
            _loc5_++;
         }
      }
      
      private function OnProgressBarSectionMouseOver(param1:MouseEvent) : void
      {
         var _loc5_:EventRewardRibbon = null;
         var _loc2_:String = param1.target.name.replace("Activation","");
         var _loc3_:DisplayObject = this.getChildByName(_loc2_);
         _loc3_.visible = true;
         var _loc4_:int = int(param1.target.name.replace("mouseOverActivationSection","")) - 2;
         if(_loc4_ >= 0)
         {
            _loc5_ = this.getChildByName("reward" + _loc4_) as EventRewardRibbon;
            TweenLite.to(_loc5_.rewardImage0,0.25,{"y":-50});
            TweenLite.to(_loc5_.rewardRibbon0,0.25,{
               "y":-50,
               "onComplete":this.BringRewardToFront,
               "onCompleteParams":[_loc5_]
            });
         }
      }
      
      private function OnProgressBarSectionMouseOut(param1:MouseEvent) : void
      {
         var _loc5_:EventRewardRibbon = null;
         var _loc2_:String = param1.target.name.replace("Activation","");
         var _loc3_:DisplayObject = this.getChildByName(_loc2_);
         _loc3_.visible = false;
         var _loc4_:int = int(param1.target.name.replace("mouseOverActivationSection","")) - 2;
         if(_loc4_ >= 0)
         {
            _loc5_ = this.getChildByName("reward" + _loc4_) as EventRewardRibbon;
            TweenLite.to(_loc5_.rewardImage0,0.25,{"y":0});
            TweenLite.to(_loc5_.rewardRibbon0,0.25,{"y":0});
            this.SendRewardToBack(_loc5_);
         }
      }
      
      private function BringRewardToFront(param1:DisplayObject) : void
      {
         this.setChildIndex(param1,this.getChildIndex(logoImage));
      }
      
      private function SendRewardToBack(param1:DisplayObject) : void
      {
         this.setChildIndex(param1,this.getChildIndex(eventImage) + 1);
      }
      
      public function update() : void
      {
         var _loc1_:int = this._event.timeUntilNextDate;
         if(_loc1_ <= 0)
         {
            timeLabel.htmlText = "<b>DATE NOT INITIALIZED!</b>";
         }
         else
         {
            timeLabel.htmlText = "<b>" + GLOBAL.ToTime(_loc1_,true) + "</b>";
         }
         if(this._event.hasEventStarted)
         {
            progressBarMask.width = this._event.progress > 0 ? this._event.progress * 360 : 0;
         }
         buttonActionLabel.text = this._event.buttonCopy;
         this.Resize();
      }
      
      private function Resize() : void
      {
         GLOBAL.RefreshScreen();
         x = int(GLOBAL._SCREEN.x + 30);
         y = int(GLOBAL._SCREEN.y + GLOBAL._SCREEN.height - height - 10);
         if(Chat._bymChat && Chat._bymChat.chatBox && Boolean(Chat._bymChat.chatBox.background))
         {
            y = int(Chat._bymChat.y + Chat._bymChat.chatBox.y + Chat._bymChat.chatBox.background.y - 53);
         }
      }
      
      private function onImageLoaded(param1:String, param2:BitmapData) : void
      {
         while(eventImage.numChildren)
         {
            eventImage.removeChildAt(0);
         }
         eventImage.addChild(new Bitmap(param2));
         eventImage.visible = true;
      }
      
      private function onLogoLoaded(param1:String, param2:BitmapData) : void
      {
         while(logoImage.numChildren)
         {
            logoImage.removeChildAt(0);
         }
         logoImage.addChild(new Bitmap(param2));
         logoImage.visible = true;
      }
      
      private function onRewardImageLoaded(param1:String, param2:BitmapData, param3:Array) : void
      {
         var _loc4_:EventRewardRibbon = param3[0] as EventRewardRibbon;
         while(_loc4_.rewardImage0.numChildren)
         {
            _loc4_.rewardImage0.removeChildAt(0);
         }
         _loc4_.rewardImage0.addChild(new Bitmap(param2));
         _loc4_.visible = true;
      }
      
      private function ShowEventPopup(param1:MouseEvent = null) : void
      {
         dispatchEvent(new Event(CLICKED_ACTION));
      }
      
      private function ShowInfoPopup(param1:MouseEvent = null) : void
      {
         dispatchEvent(new Event(CLICKED_INFO));
      }
   }
}

