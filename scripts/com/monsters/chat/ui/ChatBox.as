package com.monsters.chat.ui
{
   import com.monsters.display.ScrollSet;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import gs.TweenLite;
   import gs.easing.*;
   
   public class ChatBox extends AbstractChatBox implements IChatDisplay
   {
      private static var _popupignore:bubblepopupRight;
      
      private static var _popupignoredo:DisplayObject;
      
      private var _shell:Sprite;
      
      private var _maximized:Boolean = false;
      
      private var _open:Boolean = true;
      
      private var _animating:Boolean = false;
      
      private var _mask:Sprite;
      
      private var _thumb:Sprite;
      
      private var _display:Sprite;
      
      private var _panel:Sprite;
      
      private var _thumbWidth:int = 15;
      
      private var _thumbHeight:int = 15;
      
      private var _scrollbar:ScrollSet;
      
      private var _sendBtn:Button;
      
      public var _headerBar:MovieClip;
      
      public var _alertsCounter:int;
      
      public var _chatWidth:int = 0;
      
      private var _chatHistory:Array;
      
      private var _chatMessages:MovieClip;
      
      private var fmt_nameOffset:TextFormat;
      
      private var _originProps:Object = {
         "screenHeight":4 * 60,
         "screenWidth":400
      };
      
      private var _maxProps:Object = {
         "screenHeight":4 * 60,
         "maskHeight":225,
         "y":-280,
         "scrollerY":-250,
         "scrollHeight":226,
         "inputY":-24
      };
      
      private var _openProps:Object = {
         "screenHeight":114,
         "maskHeight":105,
         "y":-160,
         "scrollerY":-130,
         "scrollHeight":105,
         "inputY":-24
      };
      
      private var _closeProps:Object = {
         "screenHeight":114,
         "maskHeight":105,
         "y":0,
         "scrollerY":30,
         "scrollHeight":105,
         "inputY":27
      };
      
      private var _chatWidthDefault:Object = {
         "sizeW":440,
         "headerW":440,
         "headerX":-5,
         "titleTxtX":100,
         "alertX":245,
         "arrowUpX":400,
         "arrowDownX":400,
         "borderW":432,
         "mcMaskW":400,
         "tOutputW":370,
         "mcScreenW":410,
         "inputWoodBgW":440,
         "inputTxtBgW":6 * 60,
         "inputTxtW":350,
         "sendBtnX":383,
         "scrollerX":400,
         "ignoreBtnX":365
      };
      
      private var _chatWidthShort:Object = {
         "sizeW":390,
         "headerW":390,
         "headerX":-5,
         "titleTxtX":80,
         "alertX":230,
         "arrowUpX":350,
         "arrowDownX":350,
         "borderW":380,
         "mcMaskW":350,
         "tOutputW":320,
         "mcScreenW":6 * 60,
         "inputWoodBgW":390,
         "inputTxtBgW":310,
         "inputTxtW":305,
         "sendBtnX":333,
         "scrollerX":350,
         "ignoreBtnX":315
      };
      
      public function ChatBox()
      {
         super(new ChatBox_CLIP());
         this._shell = new Sprite();
         this.background.addChild(this._shell);
         if(Boolean(this._chatMessages) && Boolean(this._chatMessages.parent))
         {
            this._chatMessages.parent.removeChild(this._chatMessages);
            this._chatMessages = null;
         }
         this._chatMessages = new MovieClip();
         this._shell.addChild(this._chatMessages);
         this._chatMessages.x = this.background.mcScreen.x;
         this._chatMessages.y = this.background.mcScreen.y;
         this._shell.addChild(this._chatMessages);
         this._shell.mask = this.background.mcMask;
         this._scrollbar = new ScrollSet();
         this.background.addChild(this._scrollbar);
         this._scrollbar.initWith(this._shell,this.background.mcMask,0,64,20);
         this._scrollbar.x = 400;
         this._scrollbar.y = 30;
         this._scrollbar.autoHide = false;
         this._scrollbar.visible = false;
         this._sendBtn = new Button_CLIP();
         this._sendBtn.Setup("Say");
         this._sendBtn.x = 383;
         this._sendBtn.y = 11;
         this._sendBtn.width = 45;
         this._sendBtn.height = 30;
         this._sendBtn.Highlight = false;
         this._sendBtn.Enabled = true;
         this._sendBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.handleSendClick);
         this.inputbar.addChild(this._sendBtn);
         this.background._output.addEventListener(TextEvent.LINK,this.handleLinkClick);
         this.input.addEventListener(MouseEvent.MOUSE_UP,this.onInputFocus);
         this.background.alert.alert_txt.autoSize = TextFieldAutoSize.LEFT;
         this.background.alert.alert_txt.multiline = false;
         this.background.alert.alert_txt.wordWrap = false;
         this.background.alert.alert_txt.selectable = false;
         this.background.alert.alert_txt.mouseEnabled = false;
         this.background.alert.alert_txt.type = TextFieldType.DYNAMIC;
         this._chatHistory = [];
         this._originProps.screenWidth = this.background.mcScreen.width;
         this._originProps.screenHeight = this.background.mcScreen.height;
      }
      
      public static function PopupShow(param1:int, param2:int, param3:String, param4:MovieClip) : *
      {
         PopupHide();
         _popupignore = new bubblepopupRight();
         _popupignore.Setup(param1,param2,param3);
         _popupignore.Nudge("left");
         _popupignoredo = param4.addChild(_popupignore);
      }
      
      public static function PopupUpdate(param1:String) : *
      {
         if(_popupignore)
         {
            _popupignore.Update(param1);
         }
      }
      
      public static function PopupHide() : *
      {
         if(Boolean(_popupignore) && Boolean(_popupignore.parent))
         {
            _popupignore.parent.removeChild(_popupignore);
            _popupignore = null;
         }
      }
      
      private function handleSendClick(param1:MouseEvent) : void
      {
         GLOBAL._bymChat.SendMessage();
         this.forceFocus();
      }
      
      private function handleLinkClick(param1:TextEvent) : void
      {
         var points:Array = null;
         var e:TextEvent = param1;
         var actions:Array = e.text.split(".");
         try
         {
            if(actions[0] == "location")
            {
               if(actions[1] == "moveto")
               {
                  points = actions[2].split(",");
               }
            }
         }
         catch(e:Error)
         {
            this.push("<font color=\'#FF0000\'>Action Failed!</font>");
         }
      }
      
      public function get Scrollbar() : *
      {
         return this._scrollbar;
      }
      
      private function onInputFocus(param1:MouseEvent) : void
      {
         if(stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            GLOBAL.goFullScreen(null);
            stage.focus = this.input;
            MAP.Release(null);
         }
      }
      
      private function forceFocus() : void
      {
         stage.focus = this.input;
         MAP.Release(null);
      }
      
      override public function init() : void
      {
         this.background.arrowUp.addEventListener(MouseEvent.MOUSE_DOWN,this.toggleHide);
         this.background.arrowUp.addEventListener(MouseEvent.MOUSE_OVER,onHideOver);
         this.background.arrowUp.addEventListener(MouseEvent.MOUSE_OUT,onHideOut);
         this.background.arrowUp.mouseChildren = false;
         this.background.arrowUp.buttonMode = true;
         this.background.arrowUp.useHandCursor = true;
         this.background.arrowUp.gotoAndStop(1);
         this.background.arrowDown.addEventListener(MouseEvent.MOUSE_DOWN,this.toggleHide);
         this.background.arrowDown.addEventListener(MouseEvent.MOUSE_OVER,onHideOver);
         this.background.arrowDown.addEventListener(MouseEvent.MOUSE_OUT,onHideOut);
         this.background.arrowDown.mouseChildren = false;
         this.background.arrowDown.buttonMode = true;
         this.background.arrowDown.useHandCursor = true;
         this.background.arrowDown.gotoAndStop(1);
         this.input.maxChars = 100;
         this.background.addEventListener(MouseEvent.CLICK,this.toggleHide);
         this._maximized = false;
         this.toggleHide();
      }
      
      private function showHelp(... rest) : void
      {
      }
      
      private function hideHelp(... rest) : void
      {
      }
      
      private function toggleHide(param1:MouseEvent = null) : void
      {
         var _loc4_:Object = null;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         if(param1 != null)
         {
            if(param1.currentTarget == this.background.arrowUp)
            {
               _loc2_ = true;
            }
            else if(param1.currentTarget == this.background.arrowDown)
            {
               _loc2_ = false;
            }
            if(param1.currentTarget == this.background)
            {
               _loc3_ = true;
               if(GLOBAL._bymChat._open)
               {
                  return;
               }
            }
         }
         if(this._animating)
         {
            return;
         }
         if(this._maximized && GLOBAL._bymChat._open)
         {
            if(!(!_loc2_ && !_loc3_))
            {
               return;
            }
            _loc4_ = this._openProps;
            this.background.arrowUp.gotoAndStop(1);
            this.background.arrowDown.gotoAndStop(1);
            this.background.arrowUp.buttonMode = true;
            this.background.arrowDown.buttonMode = true;
         }
         else if(GLOBAL._bymChat._open && !_loc3_)
         {
            this.ClearAlert();
            if(param1 == null || !_loc2_)
            {
               GLOBAL._bymChat._open = !GLOBAL._bymChat._open;
               _loc4_ = this._closeProps;
               this.background.arrowUp.gotoAndStop(1);
               this.background.arrowDown.gotoAndStop(2);
               this.background.arrowUp.buttonMode = true;
               this.background.arrowDown.buttonMode = false;
            }
            else if(_loc2_)
            {
               _loc4_ = this._maxProps;
               this.background.arrowUp.gotoAndStop(2);
               this.background.arrowDown.gotoAndStop(1);
               this.background.arrowUp.buttonMode = false;
               this.background.arrowDown.buttonMode = true;
            }
            else if(_loc3_)
            {
               return;
            }
         }
         else if(!GLOBAL._bymChat._open)
         {
            if(!(_loc2_ || _loc3_))
            {
               return;
            }
            GLOBAL._bymChat._open = !GLOBAL._bymChat._open;
            _loc4_ = this._openProps;
            this.background.arrowUp.gotoAndStop(1);
            this.background.arrowDown.gotoAndStop(1);
            this.background.arrowUp.buttonMode = true;
            this.background.arrowDown.buttonMode = true;
         }
         if(_loc4_ == null)
         {
            return;
         }
         this._scrollbar.visible = false;
         TweenLite.to(this.background,0.5,{
            "y":_loc4_.y,
            "onComplete":this.toggleVisibleB
         });
         TweenLite.to(this.background.mcScreen,0.5,{"height":_loc4_.screenHeight});
         TweenLite.to(this.background.mcMask,0.5,{"height":_loc4_.maskHeight});
         TweenLite.to(this._scrollbar,0.5,{"y":_loc4_.scrollerY});
         if(GLOBAL._bymChat._open)
         {
            TweenLite.to(this.inputbar,0.5,{
               "y":_loc4_.inputY,
               "autoAlpha":1,
               "ease":Expo.easeOut
            });
            TweenLite.to(this.background.alert,0.5,{
               "autoAlpha":0,
               "ease":Expo.easeOut
            });
         }
         else
         {
            TweenLite.to(this.inputbar,0.5,{
               "y":_loc4_.inputY,
               "autoAlpha":0,
               "ease":Quad.easeIn
            });
         }
         this._maximized = !this._maximized;
         this._animating = true;
      }
      
      private function toggleVisibleB() : void
      {
         this._animating = false;
         var _loc1_:Object = this._maximized ? this._maxProps : this._openProps;
         this._scrollbar.initWith(this._shell,this.background.mcMask,0,_loc1_.scrollHeight,20);
         this._scrollbar.visible = this._shell.height > this.background.mcMask.height;
         if(!GLOBAL._bymChat._open)
         {
            GLOBAL._bymChat.toggleMinimizedStat(true);
            this._scrollbar.visible = false;
         }
         else
         {
            if(GLOBAL.StatGet("chatmin") != 0)
            {
            }
            GLOBAL._bymChat.toggleMinimizedStat(false);
            this.forceFocus();
         }
         this._scrollbar.scrollTo(1,0);
         this.update();
      }
      
      public function ResizeWindow() : void
      {
         if(GLOBAL._mode == "build" && Boolean(BASE._isOutpost))
         {
            if(this._chatWidth != this._chatWidthShort.sizeW)
            {
               this.background.header.width = this._chatWidthShort.headerW;
               this.background.tTitle.x = this._chatWidthShort.titleTxtX;
               this.background.alert.x = this._chatWidthShort.alertX;
               this.background.arrowUp.x = this._chatWidthShort.arrowUpX;
               this.background.arrowDown.x = this._chatWidthShort.arrowDownX;
               this.background.border.width = this._chatWidthShort.borderW;
               this.background.mcMask.width = this._chatWidthShort.mcMaskW;
               this.background.mcScreen.width = this._chatWidthShort.mcScreenW;
               this.background._output.width = this._chatWidthShort.tOutputW;
               this.inputbar.inputWoodBg.width = this._chatWidthShort.inputWoodBgW;
               this.input.width = this._chatWidthShort.inputTxtW;
               this.inputbar.inputTxtBG.width = this._chatWidthShort.inputTxtBgW;
               this._sendBtn.x = this._chatWidthShort.sendBtnX;
               this._scrollbar.x = this._chatWidthShort.scrollerX;
               this._chatWidth = this._chatWidthShort.sizeW;
            }
         }
         else if(this._chatWidth != this._chatWidthDefault.sizeW)
         {
            this.background.header.width = this._chatWidthDefault.headerW;
            this.background.tTitle.x = this._chatWidthDefault.titleTxtX;
            this.background.alert.x = this._chatWidthDefault.alertX;
            this.background.arrowUp.x = this._chatWidthDefault.arrowUpX;
            this.background.arrowDown.x = this._chatWidthDefault.arrowDownX;
            this.background.border.width = this._chatWidthDefault.borderW;
            this.background.mcMask.width = this._chatWidthDefault.mcMaskW;
            this.background.mcScreen.width = this._chatWidthDefault.mcScreenW;
            this.background._output.width = this._chatWidthDefault.tOutputW;
            this.inputbar.inputWoodBg.width = this._chatWidthDefault.inputWoodBgW;
            this.input.width = this._chatWidthDefault.inputTxtW;
            this.inputbar.inputTxtBG.width = this._chatWidthDefault.inputTxtBgW;
            this._sendBtn.x = this._chatWidthDefault.sendBtnX;
            this._scrollbar.x = this._chatWidthDefault.scrollerX;
            this._chatWidth = this._chatWidthDefault.sizeW;
         }
      }
      
      public function ResizeMessages() : void
      {
         var _loc1_:Number = 0;
         if(Boolean(this._chatMessages) && Boolean(this._chatMessages.parent))
         {
            this._chatMessages.parent.removeChild(this._chatMessages);
            this._chatMessages = null;
         }
         this._chatMessages = new MovieClip();
         this._shell.addChild(this._chatMessages);
         this._chatMessages.x = this.background.mcMask.x;
         this._chatMessages.y = this.background.mcMask.y;
         var _loc4_:int = 0;
         while(_loc4_ < this._chatHistory.length)
         {
            this._chatHistory[_loc4_].y = _loc1_;
            this._chatHistory[_loc4_].scaleY = 1;
            if(this._chatHistory[_loc4_].isOwnMessage)
            {
               this._chatHistory[_loc4_].bg.gotoAndStop(3);
            }
            else
            {
               this._chatHistory[_loc4_].bg.gotoAndStop(_loc4_ % 2 + 1);
            }
            if(GLOBAL._mode == "build" && Boolean(BASE._isOutpost))
            {
               this._chatHistory[_loc4_].txt.width = this._chatWidthShort.tOutputW;
               this._chatHistory[_loc4_].ignoreBtn.x = this._chatWidthShort.ignoreBtnX;
            }
            else
            {
               this._chatHistory[_loc4_].txt.width = this._chatWidthDefault.tOutputW;
               this._chatHistory[_loc4_].ignoreBtn.x = this._chatWidthDefault.ignoreBtnX;
            }
            this._chatMessages.addChild(this._chatHistory[_loc4_]);
            _loc1_ += this._chatHistory[_loc4_].height;
            _loc4_++;
         }
         if(!this._scrollbar.visible && GLOBAL._bymChat._open)
         {
            this._scrollbar.visible = this._shell.height > this.background.mcMask.height;
         }
         addChild(this._scrollbar);
         this._scrollbar.update();
         if(!this._scrollbar.dragging)
         {
            this._scrollbar.scrollTo(1,0);
         }
      }
      
      public function UpdateAlert(param1:int = 0) : void
      {
         var _loc2_:String = null;
         if(!GLOBAL._bymChat._open)
         {
            this._alertsCounter += param1;
            _loc2_ = this._alertsCounter < 100 ? String(this._alertsCounter) : "99+";
            this.background.alert.alert_txt.htmlText = "<b>" + _loc2_ + "</b>";
            this.background.alert.alert_txt.x = 2;
            this.background.alert.bg.width = this.background.alert.alert_txt.width + 6;
         }
         if(this._alertsCounter > 0 && !GLOBAL._bymChat._open)
         {
            TweenLite.to(this.background.alert,0.5,{
               "autoAlpha":1,
               "ease":Circ.easeIn
            });
         }
         else if(GLOBAL._bymChat._open && this.background.alert.alpha != 0)
         {
            TweenLite.to(this.background.alert,0.5,{
               "autoAlpha":0,
               "ease":Expo.easeOut
            });
         }
      }
      
      public function ClearAlert() : void
      {
         if(GLOBAL._bymChat._open)
         {
            this._alertsCounter = 0;
            this.UpdateAlert();
         }
      }
      
      override public function push(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:Boolean = false) : void
      {
         var _loc10_:ChatBox_msg_name_CLIP = null;
         var _loc6_:Object = {
            "msg":param1,
            "username":param2,
            "userid":param3,
            "msgtype":param4
         };
         var _loc7_:ChatBox_msg_CLIP = new ChatBox_msg_CLIP();
         _loc7_.txt.htmlText = param1;
         _loc7_.txt.autoSize = TextFieldAutoSize.LEFT;
         _loc7_.bg.height = _loc7_.txt.height;
         _loc7_.addEventListener(MouseEvent.ROLL_OVER,this.OnMsgMouseOver);
         _loc7_.addEventListener(MouseEvent.ROLL_OUT,this.OnMsgMouseOut);
         _loc7_.ignoreBtn.visible = false;
         _loc7_.ignoreBtn.buttonMode = true;
         _loc7_.msgData = _loc6_;
         _loc7_.isOwnMessage = param3 == LOGIN._playerID.toString();
         if(param2 != null)
         {
            _loc7_.ignoreBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.OnMsgIgnoreMouseDown);
            _loc7_.ignoreBtn.addEventListener(MouseEvent.ROLL_OVER,this.OnMsgIgnoreRollOver);
            _loc7_.ignoreBtn.addEventListener(MouseEvent.ROLL_OUT,this.OnMsgIgnoreRollOut);
            _loc10_ = new ChatBox_msg_name_CLIP();
            _loc10_.label.htmlText = param2;
            _loc10_.label.autoSize = TextFieldAutoSize.LEFT;
            _loc10_.bg.width = _loc10_.label.textWidth;
            _loc10_.label.visible = false;
            _loc10_.x = 0;
            _loc10_.y = 0;
            _loc10_.addEventListener(MouseEvent.MOUSE_DOWN,this.OnMsgNameMouseDown);
            _loc10_.addEventListener(MouseEvent.ROLL_OVER,this.OnMsgNameRollOver);
            _loc10_.addEventListener(MouseEvent.ROLL_OUT,this.OnMsgNameRollOut);
            _loc7_.addChild(_loc10_);
         }
         this._chatHistory.push(_loc7_);
         if(!param5)
         {
            while(_chats.length > 40)
            {
               _chats.shift();
            }
         }
         this.ResizeMessages();
      }
      
      override public function update() : void
      {
         super.update();
         this.ResizeWindow();
         this.ResizeMessages();
      }
      
      override public function clearChat() : void
      {
         super.clearChat();
         this._chatHistory = [];
      }
      
      override public function get background() : MovieClip
      {
         return this._displayAssets.frame;
      }
      
      override public function get input() : TextField
      {
         return this._displayAssets.input._input;
      }
      
      override public function get output() : TextField
      {
         return this.background._output;
      }
      
      public function get inputbar() : MovieClip
      {
         return this._displayAssets.input;
      }
      
      public function OnMsgMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:ChatBox_msg_CLIP = null;
         if(param1.currentTarget && param1.currentTarget.msgData && !param1.currentTarget.isOwnMessage)
         {
            if(param1.currentTarget.msgData.userid)
            {
               _loc2_ = param1.currentTarget as ChatBox_msg_CLIP;
               _loc2_.ignoreBtn.visible = true;
            }
         }
      }
      
      public function OnMsgMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:ChatBox_msg_CLIP = param1.currentTarget as ChatBox_msg_CLIP;
         _loc2_.ignoreBtn.visible = false;
      }
      
      public function OnMsgIgnoreMouseDown(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget.parent) && Boolean(param1.currentTarget.parent.msgData))
         {
            GLOBAL._bymChat.ignoreUser(param1.currentTarget.parent.msgData.userid);
         }
      }
      
      public function OnMsgIgnoreRollOver(param1:MouseEvent) : void
      {
         var _loc3_:* = param1.currentTarget.y + param1.currentTarget.height / 2;
         PopupShow(param1.currentTarget.x - 10,_loc3_,"Click to ignore user",param1.currentTarget.parent as MovieClip);
      }
      
      public function OnMsgIgnoreRollOut(param1:MouseEvent) : void
      {
         PopupHide();
      }
      
      public function OnMsgNameMouseDown(param1:MouseEvent) : void
      {
      }
      
      public function OnMsgNameRollOver(param1:MouseEvent) : void
      {
      }
      
      public function OnMsgNameRollOut(param1:MouseEvent) : void
      {
      }
   }
}

