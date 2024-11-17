package
{
   import com.monsters.ui.*;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import gs.*;
   import gs.easing.*;
   
   public class UI2
   {
      public static var _top:UI_TOP;
      
      public static var _visitor:*;
      
      public static var _warning:*;
      
      public static var _protected:*;
      
      public static var _tutorial:*;
      
      public static var _lastSwitch:*;
      
      public static var _queue:*;
      
      public static var _guestSave:*;
      
      public static var _fullScreen:*;
      
      public static var _soundmute:*;
      
      public static var _quests:*;
      
      public static var _baseSelect:*;
      
      public static var _research:*;
      
      public static var _creatures:*;
      
      public static var _map:*;
      
      public static var _attack:*;
      
      public static var _selectedBuilding:*;
      
      public static var _bottomName:*;
      
      public static var _lastBase:*;
      
      public static var _scareAway:*;
      
      public static var _progressBars:*;
      
      public static var _showTop:Boolean;
      
      public static var _showBottom:Boolean;
      
      public static var _showWarning:Boolean;
      
      public static var _scrollMap:Boolean;
      
      public static var _showProtected:Boolean;
      
      public static var _wildMonsterBar:UI_WILDMONSTERBAR;
      
      public static var _debugWarningTxt:TextField;
      
      private static var _timers:Array = new Array();
      
      public static var _debugWarningTxtVal:String = "DEBUG MODE";
      
      public function UI2()
      {
         super();
      }
      
      public static function Setup() : *
      {
         try
         {
            _tutorial = GLOBAL._layerUI.addChild(new MovieClip());
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A1: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            _top = GLOBAL._layerUI.addChild(new UI_TOP());
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A3: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            _warning = GLOBAL._layerUI.addChild(new UI_WARNING());
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A4: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            if(GLOBAL._mode != "build")
            {
               _visitor = GLOBAL._layerUI.addChild(new UI_VISITOR());
            }
            else
            {
               _visitor = null;
            }
            _top.mc.x = 0;
            _top.mc.y = 4;
            _showTop = true;
            _showBottom = false;
            _showProtected = false;
            _showWarning = false;
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A5: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            UI_BOTTOM.Setup();
            UI_WORKERS.Setup();
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A6: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            _top.Setup();
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A7: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            if(GLOBAL.flagsShouldChatExist() && GLOBAL._bymChat._open)
            {
               GLOBAL.initChat();
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A8 CHAT1: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            if(GLOBAL.flagsShouldChatDisplay())
            {
               GLOBAL.setChatPosition(GLOBAL._layerUI,10,5 * 60);
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A9 CHAT2: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            _timers = new Array();
            _timers.push(_top.mcProtected);
            _timers.push(_top.mcReinforcements);
            if(!GLOBAL._flags.viximo && !GLOBAL._flags.kongregate)
            {
               _timers.push(_top.mcSpecialEvent);
               if(GLOBAL._countryCode != "ph")
               {
                  _top.mcSpecialEvent.buttonMode = true;
                  _top.mcSpecialEvent.mouseChildren = false;
                  _top.mcSpecialEvent.addEventListener(MouseEvent.CLICK,SPECIALEVENT.TimerClicked);
               }
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A10 TIMERS: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            if(GLOBAL._aiDesignMode)
            {
               DebugWarning();
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A11 Debug Warning: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
      }
      
      public static function SetupHUD() : *
      {
         try
         {
            _tutorial = GLOBAL._layerUI.addChild(new MovieClip());
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.SetupHUD A1: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            UI_BOTTOM.Setup();
            UI_BOTTOM.Hide();
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.SetupHUD A6: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            if(GLOBAL.flagsShouldChatExist() && GLOBAL._bymChat._open)
            {
               GLOBAL.initChat();
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A8 CHAT1: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            if(GLOBAL.flagsShouldChatDisplay())
            {
               GLOBAL.setChatPosition(GLOBAL._layerUI,10,5 * 60);
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A9 CHAT2: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
      }
      
      public static function Show(param1:String) : void
      {
         if(param1 == "top" && !_showTop)
         {
            _showTop = true;
            _top.mc.visible = true;
         }
         else if(param1 == "bottom" && !_showBottom)
         {
            _showBottom = true;
            UI_BOTTOM.Show();
            if(TUTORIAL._stage >= 200)
            {
               UI_WORKERS.Show();
            }
         }
         else if(param1 == "warning" && !_showWarning)
         {
            _showWarning = true;
            if(GLOBAL._render)
            {
               TweenLite.to(_warning.mc,1,{
                  "y":0,
                  "ease":Elastic.easeOut
               });
            }
            else
            {
               _warning.mc.y = 0;
            }
         }
         else if(param1 == "scareAway")
         {
            if(GLOBAL._render && !_scareAway)
            {
               _scareAway = GLOBAL._layerUI.addChild(new UI_BAITERSCAREAWAY());
               ResizeHandler();
            }
         }
         else if(param1 == "wmbar")
         {
            if(GLOBAL._render)
            {
               _wildMonsterBar = new UI_WILDMONSTERBAR();
               GLOBAL._layerUI.addChild(_wildMonsterBar);
               _wildMonsterBar.y = 0;
               ResizeHandler();
            }
         }
      }
      
      public static function Clear() : void
      {
         if(_top)
         {
            _top.Clear();
            if(_top.parent)
            {
               _top.parent.removeChild(_top);
            }
            _top = null;
         }
         UI_BOTTOM.Clear();
         if(_warning)
         {
            if(_warning.parent)
            {
               _warning.parent.removeChild(_warning);
            }
            _warning = null;
         }
         if(_scareAway)
         {
            if(_scareAway.parent)
            {
               _scareAway.parent.removeChild(_scareAway);
            }
            _scareAway = null;
         }
         if(Boolean(_wildMonsterBar) && Boolean(_wildMonsterBar.parent))
         {
            _wildMonsterBar.parent.removeChild(_wildMonsterBar);
            _wildMonsterBar = null;
         }
         if(Boolean(_debugWarningTxt) && Boolean(_debugWarningTxt.parent))
         {
            _debugWarningTxt.parent.removeChild(_debugWarningTxt);
            _debugWarningTxt = null;
         }
      }
      
      public static function Hide(param1:String) : void
      {
         var what:String = param1;
         if(what == "top" && _showTop)
         {
            _showTop = false;
            _top.mc.visible = false;
         }
         else if(what == "bottom" && _showBottom)
         {
            _showBottom = false;
            UI_BOTTOM.Hide();
            UI_WORKERS.Hide();
         }
         else if(what == "warning" && _showWarning)
         {
            _showWarning = false;
            if(GLOBAL._bymChat)
            {
               GLOBAL._bymChat.show();
            }
            if(GLOBAL._render)
            {
               TweenLite.to(_warning.mc,0.5,{
                  "y":-100,
                  "ease":Back.easeIn
               });
            }
            else
            {
               _warning.mc.y = -100;
            }
         }
         else if(what == "scareAway" && _scareAway)
         {
            if(GLOBAL._layerUI.contains(_scareAway))
            {
               GLOBAL._layerUI.removeChild(_scareAway);
               if(GLOBAL._bymChat)
               {
                  GLOBAL._bymChat.show();
               }
               _scareAway = null;
            }
         }
         else if(what == "wmbar")
         {
            if(_wildMonsterBar != null)
            {
               if(GLOBAL._render)
               {
                  TweenLite.to(_wildMonsterBar,0.5,{
                     "y":_wildMonsterBar.y - 22,
                     "onComplete":function():*
                     {
                        _wildMonsterBar.parent.removeChild(_wildMonsterBar);
                        _wildMonsterBar = null;
                        ResizeHandler();
                     }
                  });
               }
               else
               {
                  try
                  {
                     _wildMonsterBar.parent.removeChild(_wildMonsterBar);
                  }
                  catch(e:*)
                  {
                  }
                  _wildMonsterBar.y -= 20;
                  _wildMonsterBar = null;
               }
            }
         }
         else if(what == "chat" && Boolean(GLOBAL._bymChat))
         {
            if(GLOBAL._layerUI.contains(GLOBAL._bymChat))
            {
               GLOBAL._bymChat.hide();
            }
         }
         if(GLOBAL._render)
         {
            ResizeHandler();
         }
      }
      
      public static function Disable() : void
      {
      }
      
      public static function Enable() : void
      {
      }
      
      public static function Update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:MovieClip = null;
         if(!GLOBAL._catchup)
         {
            if(_top)
            {
               _top.Update();
               if(TUTORIAL._stage < 190)
               {
                  if(_top.mcProtected.visible)
                  {
                     _top.mcProtected.visible = false;
                  }
                  if(_top.mcReinforcements.visible)
                  {
                     _top.mcReinforcements.visible = false;
                  }
                  if(Boolean(_top.mcSpecialEvent) && _top.mcSpecialEvent.visible)
                  {
                     _top.mcSpecialEvent.visible = false;
                  }
                  if(_top.mcSave.visible)
                  {
                     _top.mcSave.visible = false;
                  }
                  if(_top.mcZoom.visible)
                  {
                     _top.mcZoom.visible = false;
                  }
                  if(_top.mcFullscreen.visible)
                  {
                     _top.mcFullscreen.visible = false;
                  }
                  if(_top.mcBuffHolder.visible)
                  {
                     _top.mcBuffHolder.visible = false;
                  }
               }
               else
               {
                  if(BASE._isProtected - GLOBAL.Timestamp() > 0 && GLOBAL._mode == "build")
                  {
                     if(!_top.mcProtected.visible)
                     {
                        _top.mcProtected.visible = true;
                     }
                     if(BASE._isProtected - GLOBAL.Timestamp() > 86400)
                     {
                        _top.mcProtected.tCountdown.htmlText = GLOBAL.ToTime(BASE._isProtected - GLOBAL.Timestamp(),true,false);
                     }
                     else
                     {
                        _top.mcProtected.tCountdown.htmlText = GLOBAL.ToTime(BASE._isProtected - GLOBAL.Timestamp(),true);
                     }
                  }
                  else if(_top.mcProtected.visible)
                  {
                     _top.mcProtected.visible = false;
                  }
                  if(BASE._isReinforcements - GLOBAL.Timestamp() > 0 && GLOBAL._mode == "build")
                  {
                     if(!_top.mcReinforcements.visible)
                     {
                        _top.mcReinforcements.visible = true;
                     }
                     if(BASE._isReinforcements - GLOBAL.Timestamp() > 86400)
                     {
                        _top.mcReinforcements.tCountdown.htmlText = GLOBAL.ToTime(BASE._isReinforcements - GLOBAL.Timestamp(),true,false);
                     }
                     else
                     {
                        _top.mcReinforcements.tCountdown.htmlText = GLOBAL.ToTime(BASE._isReinforcements - GLOBAL.Timestamp(),true);
                     }
                  }
                  else if(_top.mcReinforcements.visible)
                  {
                     _top.mcReinforcements.visible = false;
                  }
                  if(Boolean(_top.mcSpecialEvent) && _top.mcSpecialEvent.visible)
                  {
                     _top.mcSpecialEvent.visible = false;
                  }
                  if(Boolean(UI_BOTTOM._nextwave) && UI_BOTTOM._nextwave.visible)
                  {
                     UI_BOTTOM._nextwave.visible = false;
                  }
                  if(!_top.mcSave.visible)
                  {
                     _top.mcSave.visible = true;
                  }
                  if(!_top.mcZoom.visible)
                  {
                     _top.mcZoom.visible = true;
                  }
                  if(!_top.mcFullscreen.visible)
                  {
                     _top.mcFullscreen.visible = true;
                  }
                  if(_top.mcBuffHolder.visible)
                  {
                     _top.mcBuffHolder.visible = true;
                  }
                  if(!GLOBAL._chatInited || !GLOBAL._bymChat.IsConnected)
                  {
                     GLOBAL.initChat();
                  }
                  if(GLOBAL._bymChat && GLOBAL._chatInited && GLOBAL._bymChat.IsConnected)
                  {
                     GLOBAL._bymChat.toggleVisibleB();
                  }
               }
               if(GLOBAL._mode != "build" || !GLOBAL._flags.saveicon)
               {
                  _top.mcSave.visible = false;
               }
               _loc1_ = 35;
               for each(_loc2_ in _timers)
               {
                  if(_loc2_.visible)
                  {
                     _loc2_.y = _loc1_;
                     _loc1_ += 30;
                  }
               }
               _top.mcSave.y = 3;
               _top.mcZoom.y = 3;
               _top.mcFullscreen.y = 3;
               _top.mcSound.y = 3;
               _top.mcMusic.y = 3;
               _top.mcBuffHolder.y = 6;
            }
            if(GLOBAL._mode == "build")
            {
               UI_BOTTOM.Update();
               UI_BOTTOM.Resize();
               if(_scareAway)
               {
                  GLOBAL.RefreshScreen();
                  _scareAway.x = GLOBAL._SCREEN.x + GLOBAL._SCREEN.width - _scareAway.mcBG.width - 10;
                  _scareAway.y = GLOBAL._SCREENHUD.y - (_scareAway.mcBG.height + 10);
               }
            }
            else
            {
               UI_BOTTOM.Resize();
               if(_visitor)
               {
                  _visitor.Update();
               }
               if(UI_BOTTOM._missions)
               {
                  UI_BOTTOM._missions.Update();
               }
            }
            BUILDINGINFO.Update();
         }
      }
      
      public static function ResizeHandler(param1:Event = null) : void
      {
         var _loc4_:Rectangle = null;
         var _loc2_:* = GLOBAL._ROOT.stage.stageWidth;
         var _loc3_:* = GLOBAL.GetGameHeight();
         var _loc5_:int = _wildMonsterBar != null ? 40 : 0;
         _loc4_ = new Rectangle(0 - (_loc2_ - GLOBAL._SCREENINIT.width) / 2,0 - (_loc3_ - (GLOBAL._SCREENINIT.height + _loc5_)) / 2,_loc2_,_loc3_);
         if(_wildMonsterBar)
         {
            _wildMonsterBar.back.width = _loc4_.width;
            _wildMonsterBar.x = _loc4_.x;
            _wildMonsterBar.y = _loc4_.y - 20;
            _wildMonsterBar.info.x = _loc4_.width - 79;
            _wildMonsterBar.eta_txt.x = _loc4_.width - 190;
         }
         if(_top)
         {
            _top.x = _loc4_.x + 10;
            _top.y = _loc4_.y + 4;
            _top.mcProtected.x = _loc4_.width - 125;
            _top.mcReinforcements.x = _loc4_.width - 125;
            _top.mcSpecialEvent.x = _loc4_.width - 125;
            _top.mcSave.x = _loc4_.width - 160;
            _top.mcZoom.x = _loc4_.width - 130;
            _top.mcFullscreen.x = _loc4_.width - 100;
            _top.mcSound.x = _loc4_.width - 70;
            _top.mcMusic.x = _loc4_.width - 40;
            _top.mcBuffHolder.x = _loc4_.width - 200;
         }
         if(_warning)
         {
            _warning.x = _loc4_.x + _loc4_.width / 2 - _warning.width / 2 + 50;
            _warning.y = _loc4_.y + 10;
         }
         if(_visitor)
         {
            _visitor.Update();
            _visitor.mc.x = GLOBAL._SCREEN.x + GLOBAL._SCREEN.width - _visitor.mc.mcBG.width - 10;
            _visitor.mc.y = GLOBAL._SCREENHUD.y - (_visitor.mc.height + 10);
         }
         if(_scareAway)
         {
            GLOBAL.RefreshScreen();
            _scareAway.x = GLOBAL._SCREEN.x + GLOBAL._SCREEN.width - _scareAway.mcBG.width - 10;
            _scareAway.y = GLOBAL._SCREENHUD.y - (_scareAway.mcBG.height + 10);
         }
         if(GLOBAL._bymChat)
         {
            GLOBAL._bymChat.position();
         }
         if(_debugWarningTxt)
         {
            DebugWarning();
         }
         UI_BOTTOM.Resize();
         UI_WORKERS.Resize();
      }
      
      public static function TimersVisible() : int
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         for each(_loc2_ in _timers)
         {
            if(_loc2_.visible)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public static function DebugWarning() : void
      {
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.font = "Verdana";
         _loc2_.bold = true;
         _loc2_.size = 72;
         _loc2_.align = TextFormatAlign.CENTER;
         _loc2_.color = 0xff0000;
         _loc2_.letterSpacing = -11;
         if(!_debugWarningTxt)
         {
            _debugWarningTxt = new TextField();
         }
         _debugWarningTxt.mouseEnabled = false;
         _debugWarningTxt.alpha = 0.8;
         _debugWarningTxt.width = 400;
         _debugWarningTxt.height = 100;
         _debugWarningTxt.autoSize = TextFieldAutoSize.LEFT;
         _debugWarningTxt.text = "DEBUG MODE";
         _debugWarningTxt.setTextFormat(_loc2_);
         _debugWarningTxt.x = GLOBAL._SCREEN.x + 15;
         _debugWarningTxt.y = GLOBAL._SCREEN.y + GLOBAL._SCREEN.height - _debugWarningTxt.height * 0.75;
         GLOBAL._layerUI.addChild(_debugWarningTxt);
      }
      
      public static function DebugWarningEdit(param1:String = null) : void
      {
         var _loc2_:String = "DEBUG MODE";
         if(param1)
         {
            _loc2_ = param1;
         }
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.font = "Verdana";
         _loc3_.bold = true;
         _loc3_.size = 36;
         _loc3_.align = TextFormatAlign.CENTER;
         _loc3_.color = 0xff0000;
         _loc3_.letterSpacing = -2;
         _debugWarningTxt.mouseEnabled = false;
         _debugWarningTxt.alpha = 0.8;
         _debugWarningTxt.width = 400;
         _debugWarningTxt.height = 100;
         _debugWarningTxt.autoSize = TextFieldAutoSize.LEFT;
         _debugWarningTxt.text = _loc2_;
         _debugWarningTxt.setTextFormat(_loc3_);
         _debugWarningTxt.x = GLOBAL._SCREEN.x + 15;
         _debugWarningTxt.y = GLOBAL._SCREEN.y + GLOBAL._SCREEN.height - _debugWarningTxt.height * 0.75;
      }
   }
}

