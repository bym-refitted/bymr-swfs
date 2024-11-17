package com.monsters.chat.ui
{
   import com.monsters.display.ScrollSet;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import gs.TweenLite;
   import gs.easing.*;
   
   public class ChatBox extends AbstractChatBox implements IChatDisplay
   {
      private static var _popupignore:bubblepopupRight;
      
      private static var _popupignoredo:DisplayObject;
      
      private var _shell:Sprite;
      
      private var _maximized:Boolean = false;
      
      private var _open:Boolean = true;
      
      public var _animating:Boolean = false;
      
      private var _useAlerts:Boolean = false;
      
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
      
      private var _enabled:Boolean = true;
      
      private var _runOnce:Number = 0;
      
      private var _originProps:Object = {
         "screenHeight":4 * 60,
         "screenWidth":380
      };
      
      private var _maxProps:Object = {
         "screenHeight":470,
         "maskHeight":458,
         "y":-500,
         "scrollerY":-470,
         "scrollHeight":454,
         "inputY":-12
      };
      
      private var _openProps:Object = {
         "screenHeight":4 * 60,
         "maskHeight":136,
         "y":-178,
         "scrollerY":-148,
         "scrollHeight":2 * 60,
         "inputY":-12
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
         "sizeW":380,
         "headerW":380,
         "headerX":-5,
         "titleTxtX":70,
         "alertX":220,
         "arrowUpX":343,
         "arrowUpY":16,
         "arrowDownX":325,
         "arrowDownY":13,
         "borderW":380,
         "mcMaskW":348,
         "tOutputW":330,
         "mcScreenW":350,
         "inputWoodBgW":380,
         "inputTxtBgW":310,
         "inputTxtW":310,
         "sendBtnX":331,
         "scrollerX":347,
         "ignoreBtnX":315
      };
      
      private var _chatWidthShort:Object = {
         "sizeW":390,
         "headerW":390,
         "headerX":-5,
         "titleTxtX":80,
         "alertX":230,
         "arrowUpX":343,
         "arrowUpY":16,
         "arrowDownX":325,
         "arrowDownY":13,
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
         if(!this._useAlerts)
         {
            this.background.alert.visible = false;
         }
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
         this._scrollbar.Init(this._shell,this.background.mcMask,0,0,35);
         this._scrollbar.x = 400;
         this._scrollbar.y = 30;
         this._scrollbar.AutoHideEnabled = false;
         this._scrollbar.visible = false;
         this._sendBtn = new Button_CLIP();
         this._sendBtn.Setup("Say");
         this._sendBtn.x = 383;
         this._sendBtn.y = 8;
         this._sendBtn.width = 40;
         this._sendBtn.height = 26;
         this._sendBtn.Highlight = false;
         this._sendBtn.Enabled = true;
         this._sendBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.handleSendClick);
         this.inputbar.addChild(this._sendBtn);
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
      
      public static function PopupShow(param1:int, param2:int, param3:String, param4:MovieClip) : void
      {
         PopupHide();
         _popupignore = new bubblepopupRight();
         _popupignore.Setup(param1,param2,param3);
         _popupignore.Nudge("left");
         _popupignoredo = param4.addChild(_popupignore);
      }
      
      public static function PopupUpdate(param1:String) : void
      {
         if(_popupignore)
         {
            _popupignore.Update(param1);
         }
      }
      
      public static function PopupHide() : void
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
      
      public function get Scrollbar() : *
      {
         return this._scrollbar;
      }
      
      private function onInputFocus(param1:Event) : void
      {
         if(stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            GLOBAL.goFullScreen(null);
         }
         this.forceFocus();
      }
      
      private function forceFocus() : void
      {
         stage.focus = this.input;
         MAP.Release(null);
      }
      
      override public function init() : void
      {
         this.background.arrowUp.addEventListener(MouseEvent.CLICK,this.toggleHide);
         this.background.arrowUp.addEventListener(MouseEvent.MOUSE_OVER,onHideOver);
         this.background.arrowUp.addEventListener(MouseEvent.MOUSE_OUT,onHideOut);
         this.background.arrowUp.mouseChildren = false;
         this.background.arrowUp.buttonMode = true;
         this.background.arrowUp.useHandCursor = true;
         this.background.arrowUp.gotoAndStop(1);
         this.background.arrowDown.mouseChildren = false;
         this.background.arrowDown.buttonMode = true;
         this.background.arrowDown.useHandCursor = true;
         this.background.arrowDown.gotoAndStop(1);
         this.background.arrowDown.enabled = false;
         this.background.arrowDown.visible = false;
         this.background.mcToggle.addEventListener(MouseEvent.CLICK,this.OnChatDisableClick);
         this.background.mcToggle.mouseChildren = false;
         this.background.mcToggle.buttonMode = true;
         this.background.mcToggle.useHandCursor = true;
         this.background.mcToggle.gotoAndStop(this._enabled ? 2 : 1);
         this.input.addEventListener(FocusEvent.FOCUS_IN,this.onInputFocus);
         this.input.maxChars = 100;
         this.ClearAlert();
         this.UpdateAlert();
         this.background.alert.visible = false;
         if(GLOBAL.StatGet("chatmin") == 1)
         {
            this._enabled = false;
            this._maximized = false;
         }
         else
         {
            this._enabled = true;
            this._maximized = false;
         }
         if(!GLOBAL._bymChat.initialized)
         {
            this.OnChatDisableClick();
         }
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
         if(param1 != null)
         {
            if(param1.currentTarget == this.background.arrowUp)
            {
               if(this._maximized)
               {
                  _loc2_ = false;
               }
               else
               {
                  _loc2_ = true;
               }
            }
            if(param1.currentTarget == this.background.mcToggle)
            {
               if(this._enabled)
               {
                  _loc2_ = true;
                  this._maximized = false;
               }
               else
               {
                  _loc2_ = false;
                  this._maximized = false;
               }
            }
         }
         if(this._animating)
         {
            return;
         }
         if(param1 == null)
         {
            if(GLOBAL._bymChat._open)
            {
               _loc4_ = this._openProps;
            }
            else
            {
               _loc4_ = this._closeProps;
            }
            this._maximized = false;
            this.background.arrowUp.gotoAndStop(1);
            this.background.arrowDown.gotoAndStop(1);
            this.background.arrowUp.buttonMode = true;
            this.background.arrowDown.buttonMode = false;
         }
         else if(this._maximized && GLOBAL._bymChat._open)
         {
            if(_loc2_)
            {
               return;
            }
            _loc4_ = this._openProps;
            this._maximized = false;
            this.background.arrowUp.gotoAndStop(1);
            this.background.arrowDown.gotoAndStop(1);
            this.background.arrowUp.buttonMode = true;
            this.background.arrowDown.buttonMode = true;
         }
         else if(GLOBAL._bymChat._open)
         {
            this.ClearAlert();
            if(!_loc2_)
            {
               GLOBAL._bymChat._open = false;
               _loc4_ = this._closeProps;
               this._maximized = false;
               this.background.arrowUp.gotoAndStop(1);
               this.background.arrowDown.gotoAndStop(2);
               this.background.arrowUp.buttonMode = true;
               this.background.arrowDown.buttonMode = false;
               GLOBAL.StatSet("chatmin",1);
            }
            else if(_loc2_)
            {
               _loc4_ = this._maxProps;
               this._maximized = true;
               this.background.arrowUp.gotoAndStop(1);
               this.background.arrowDown.gotoAndStop(1);
               this.background.arrowUp.buttonMode = true;
               this.background.arrowDown.buttonMode = false;
               GLOBAL.StatSet("chatmin",0);
            }
         }
         else if(!GLOBAL._bymChat._open)
         {
            if(!_loc2_)
            {
               return;
            }
            GLOBAL._bymChat._open = true;
            _loc4_ = this._openProps;
            this._maximized = false;
            this.background.arrowUp.gotoAndStop(1);
            this.background.arrowDown.gotoAndStop(1);
            this.background.arrowUp.buttonMode = true;
            this.background.arrowDown.buttonMode = true;
            GLOBAL.StatSet("chatmin",0);
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
         this._animating = true;
         var _loc6_:int = _loc4_ == this._closeProps ? 0 : 1;
         if(TUTORIAL._completed)
         {
            if(this._maximized)
            {
               TweenLite.to(this.background.arrowUp,0.5,{
                  "rotation":3 * 60,
                  "autoAlpha":_loc6_,
                  "y":this._chatWidthDefault.arrowDownY,
                  "ease":Expo.easeOut
               });
            }
            else
            {
               TweenLite.to(this.background.arrowUp,0.5,{
                  "rotation":0,
                  "autoAlpha":_loc6_,
                  "y":this._chatWidthDefault.arrowUpY,
                  "ease":Expo.easeOut
               });
            }
         }
      }
      
      private function toggleVisibleB() : void
      {
         this._animating = false;
         var _loc1_:Object = this._maximized ? this._maxProps : this._openProps;
         this._scrollbar.Update();
         this._scrollbar.visible = this._shell.height > this.background.mcMask.height;
         if(!GLOBAL._bymChat._open)
         {
            GLOBAL._bymChat.toggleMinimizedStat(true);
            this._scrollbar.visible = false;
         }
         else if(GLOBAL.StatGet("chatmin") != 0)
         {
            GLOBAL._bymChat.toggleMinimizedStat(false);
         }
         this._scrollbar.ScrollTo(1,0);
         this.update();
      }
      
      public function ResizeWindow() : void
      {
         if(this._chatWidth != this._chatWidthDefault.sizeW)
         {
            this.background.header.width = this._chatWidthDefault.headerW;
            this.background.tTitle.x = this._chatWidthDefault.titleTxtX;
            this.background.alert.x = this._chatWidthDefault.alertX;
            this.background.arrowUp.x = this._chatWidthDefault.arrowUpX;
            this.background.arrowDown.x = this._chatWidthDefault.arrowDownX;
            this.background.arrowUp.y = this._chatWidthDefault.arrowUpY;
            this.background.arrowDown.y = this._chatWidthDefault.arrowDownY;
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
            if(this._chatHistory[_loc4_].isOwnMessage)
            {
               this._chatHistory[_loc4_].bg.gotoAndStop(3);
            }
            else
            {
               this._chatHistory[_loc4_].bg.gotoAndStop(_loc4_ % 2 + 1);
            }
            this._chatHistory[_loc4_].y = _loc1_;
            this._chatHistory[_loc4_].scaleY = 1;
            this._chatHistory[_loc4_].txt.width = this._chatWidthDefault.tOutputW;
            this._chatHistory[_loc4_].ignoreBtn.x = this._chatWidthDefault.ignoreBtnX;
            this._chatMessages.addChild(this._chatHistory[_loc4_]);
            _loc1_ += this._chatHistory[_loc4_].height;
            _loc4_++;
         }
         if(!this._scrollbar.visible && GLOBAL._bymChat._open)
         {
            this._scrollbar.visible = this._shell.height > this.background.mcMask.height;
         }
         addChild(this._scrollbar);
         this._scrollbar.Update();
         if(!this._scrollbar.IsDragging)
         {
            this._scrollbar.ScrollTo(1,0);
         }
      }
      
      public function UpdateAlert(param1:int = 0) : void
      {
         var _loc2_:String = null;
         if(!this._useAlerts)
         {
            this.background.alert.visible = false;
            return;
         }
         if(!GLOBAL._bymChat._open)
         {
            this._alertsCounter += param1;
            _loc2_ = this._alertsCounter < 100 ? String(this._alertsCounter) : "99+";
            this.background.alert.alert_txt.htmlText = "<b>" + _loc2_ + "</b>";
            this.background.alert.alert_txt.x = 2;
            this.background.alert.bg.width = this.background.alert.alert_txt.width + 6;
         }
         if(this._alertsCounter > 0 && !GLOBAL._bymChat._open && this._useAlerts)
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
         var _loc9_:ChatBox_msg_name_CLIP = null;
         var _loc6_:String = param2;
         if(_loc6_ != null)
         {
            _loc6_ = _loc6_.substr(_loc6_.indexOf("["));
            if(_loc6_ != null)
            {
               _loc6_ = _loc6_.substring(0,_loc6_.indexOf("<") - 1);
            }
         }
         var _loc7_:Object = {
            "msg":param1,
            "username":_loc6_,
            "userid":param3,
            "msgtype":param4
         };
         var _loc8_:ChatBox_msg_CLIP = new ChatBox_msg_CLIP();
         _loc8_.txt.htmlText = param1;
         _loc8_.txt.autoSize = TextFieldAutoSize.LEFT;
         _loc8_.bg.height = _loc8_.txt.height;
         _loc8_.addEventListener(MouseEvent.ROLL_OVER,this.OnMsgMouseOver);
         _loc8_.addEventListener(MouseEvent.ROLL_OUT,this.OnMsgMouseOut);
         _loc8_.ignoreBtn.visible = false;
         _loc8_.ignoreBtn.buttonMode = true;
         _loc8_.msgData = _loc7_;
         _loc8_.isOwnMessage = param3 == LOGIN._playerID.toString();
         if(param2 != null)
         {
            _loc8_.ignoreBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.OnMsgIgnoreMouseDown);
            _loc8_.ignoreBtn.addEventListener(MouseEvent.ROLL_OVER,this.OnMsgIgnoreRollOver);
            _loc8_.ignoreBtn.addEventListener(MouseEvent.ROLL_OUT,this.OnMsgIgnoreRollOut);
            _loc9_ = new ChatBox_msg_name_CLIP();
            _loc9_.label.htmlText = param2;
            _loc9_.label.autoSize = TextFieldAutoSize.LEFT;
            _loc9_.bg.width = _loc9_.label.textWidth;
            _loc9_.label.visible = false;
            _loc9_.x = 0;
            _loc9_.y = 0;
            _loc9_.addEventListener(MouseEvent.MOUSE_DOWN,this.OnMsgNameMouseDown);
            _loc9_.addEventListener(MouseEvent.ROLL_OVER,this.OnMsgNameRollOver);
            _loc9_.addEventListener(MouseEvent.ROLL_OUT,this.OnMsgNameRollOut);
            _loc8_.addChild(_loc9_);
         }
         this._chatHistory.push(_loc8_);
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
         if(!TUTORIAL._completed)
         {
            this.background.arrowUp.visible = TUTORIAL._completed;
            this.background.mcToggle.visible = TUTORIAL._completed;
         }
         else if(GLOBAL._mode == "build")
         {
            this.background.arrowUp.visible = TUTORIAL._completed;
            this.background.mcToggle.visible = TUTORIAL._completed;
         }
         this.UpdateChatStatus();
      }
      
      public function UpdateChatStatus() : void
      {
         this.background.mcToggle.gotoAndStop(this._enabled ? 2 : 1);
         if(GLOBAL._bymChat.isLoggingOut)
         {
            this.background.mcToggle.gotoAndStop(3);
         }
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
               if(_loc2_.msgData.msgtype == "IgnoreList")
               {
                  if(GLOBAL._bymChat.userIsIgnored(_loc2_.msgData.userid))
                  {
                     _loc2_.ignoreBtn.gotoAndStop(2);
                     _loc2_.ignoreBtn.visible = true;
                  }
               }
               else if(!GLOBAL._bymChat.userIsIgnored(_loc2_.msgData.userid))
               {
                  _loc2_.ignoreBtn.gotoAndStop(1);
                  _loc2_.ignoreBtn.visible = true;
               }
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
            if(param1.currentTarget.parent.msgData.msgtype == "IgnoreList")
            {
               GLOBAL._bymChat.unignoreUser(param1.currentTarget.parent.msgData.userid);
            }
            else
            {
               GLOBAL._bymChat.ignoreUser(param1.currentTarget.parent.msgData.userid,param1.currentTarget.parent.msgData.username);
            }
         }
      }
      
      public function OnMsgIgnoreRollOver(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.currentTarget.parent.msgData.msgtype == "IgnoreList" ? "Click to unignore user" : "Click to ignore user";
         var _loc3_:* = param1.currentTarget.y + param1.currentTarget.height / 2;
         PopupShow(param1.currentTarget.x - 10,_loc3_,_loc2_,param1.currentTarget.parent as MovieClip);
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
      
      private function OnChatDisableClick(param1:MouseEvent = null) : void
      {
         if(this._animating)
         {
            return;
         }
         if(param1 && param1.currentTarget == this.background.mcToggle && TUTORIAL._completed)
         {
            this._enabled = !this._enabled;
         }
         if(TUTORIAL._completed && !GLOBAL._bymChat.isLoggingOut)
         {
            this.EnableInput(this._enabled);
            if(!this._enabled && GLOBAL._bymChat.IsJoined)
            {
               GLOBAL._bymChat.disableChat();
               LOGGER.Stat([68,"hide"]);
            }
            else if(GLOBAL.flagsShouldChatExist())
            {
               if(!GLOBAL._bymChat.IsConnected)
               {
                  GLOBAL.connectAndLogin();
                  LOGGER.Stat([68,"unhide"]);
               }
            }
            this.UpdateChatStatus();
            this.toggleHide(param1);
         }
      }
      
      public function EnableInput(param1:Boolean) : void
      {
         if(param1)
         {
            this.input.text = "";
            this.input.visible = true;
         }
         else
         {
            this.input.text = "";
            this.input.visible = false;
         }
      }
      
      public function ClearInputText() : void
      {
         this.input.text = "";
      }
      
      public function get chatEnabled() : Boolean
      {
         return this._enabled;
      }
      
      public function inputHasFocus() : Boolean
      {
         return stage != null && stage.focus == this.input;
      }
      
      public function disableChatBoxForAB() : void
      {
         this._sendBtn.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleSendClick);
         this.input.removeEventListener(MouseEvent.MOUSE_UP,this.onInputFocus);
         this._sendBtn.enabled = false;
         this._sendBtn.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleSendClick);
         this.EnableInput(false);
      }
   }
}

