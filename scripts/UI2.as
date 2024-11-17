package
{
   import com.monsters.ui.*;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
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
            GLOBAL.ErrorMessage("UI2.Setup A1: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
         }
         if(GLOBAL._flags.showProgressBar == 1)
         {
            try
            {
               _progressBars = GLOBAL._layerUI.addChild(new UI_PROGRESSBAR());
               UI_PROGRESSBAR.Setup();
            }
            catch(e:Error)
            {
               GLOBAL.ErrorMessage("UI2.Setup A2: " + e.message + " | " + e.getStackTrace());
               GLOBAL.ErrorMessage();
            }
         }
         try
         {
            _top = GLOBAL._layerUI.addChild(new UI_TOP());
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A3: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
         }
         try
         {
            _warning = GLOBAL._layerUI.addChild(new UI_WARNING());
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A4: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
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
            GLOBAL.ErrorMessage("UI2.Setup A5: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
         }
         try
         {
            UI_BOTTOM.Setup();
            if(GLOBAL._flags.showProgressBar == 0)
            {
               UI_WORKERS.Setup();
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A6: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
         }
         try
         {
            _top.Setup();
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A7: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
         }
         try
         {
            if(GLOBAL._flags != null && Boolean(GLOBAL._flags.hasOwnProperty("chat")) && GLOBAL._flags.chat != 0)
            {
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A8 CHAT1: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
         }
         try
         {
            if(GLOBAL._flags != null && Boolean(GLOBAL._flags.hasOwnProperty("chat")) && GLOBAL._flags.chat == 2 && GLOBAL._chatEnabled)
            {
               GLOBAL.setChatPosition(GLOBAL._layerUI,10,5 * 60);
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("UI2.Setup A9 CHAT2: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
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
            if(GLOBAL._flags.showProgressBar == 1)
            {
               if(TUTORIAL._stage >= 200)
               {
                  UI_PROGRESSBAR.Show();
               }
            }
            else if(TUTORIAL._stage >= 200)
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
         if(GLOBAL._bymChat)
         {
            if(GLOBAL._bymChat.parent)
            {
               GLOBAL._bymChat.parent.removeChild(GLOBAL._bymChat);
            }
            GLOBAL._bymChat = null;
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
            if(GLOBAL._flags.showProgressBar == 1)
            {
               UI_PROGRESSBAR.Hide();
            }
            else
            {
               UI_WORKERS.Hide();
            }
         }
         else if(what == "warning" && _showWarning)
         {
            _showWarning = false;
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
               GLOBAL._layerUI.removeChild(GLOBAL._bymChat);
               GLOBAL._bymChat = null;
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
               }
               if(GLOBAL._mode != "build" || !GLOBAL._flags.saveicon)
               {
                  _top.mcSave.visible = false;
               }
               _top.mcProtected.y = 35;
               _top.mcSave.y = 3;
               _top.mcZoom.y = 3;
               _top.mcFullscreen.y = 3;
               _top.mcSound.y = 3;
               _top.mcMusic.y = 3;
            }
            if(GLOBAL._mode == "build")
            {
               UI_BOTTOM.Update();
               if(GLOBAL._flags.showProgressBar == 1)
               {
                  UI_PROGRESSBAR.Update();
               }
            }
            else if(_visitor)
            {
               _visitor.Update();
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
         _loc4_ = new Rectangle(0 - (_loc2_ - 760) / 2,0 - (_loc3_ - (520 + _loc5_)) / 2,_loc2_,_loc3_);
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
            _top.mcSave.x = _loc4_.width - 160;
            _top.mcZoom.x = _loc4_.width - 130;
            _top.mcFullscreen.x = _loc4_.width - 100;
            _top.mcSound.x = _loc4_.width - 70;
            _top.mcMusic.x = _loc4_.width - 40;
         }
         if(_warning)
         {
            _warning.x = _loc4_.x + _loc4_.width / 2 - _warning.width / 2 + 50;
            _warning.y = _loc4_.y + 10;
         }
         if(_visitor)
         {
            if(GLOBAL._mode == "view" || GLOBAL._mode == "help")
            {
               if(GLOBAL._bymChat)
               {
                  _visitor.mc.x = GLOBAL._bymChat.x + GLOBAL._bymChat.width + 10;
               }
               else
               {
                  _visitor.mc.x = _loc4_.x + 10;
               }
            }
            else
            {
               _visitor.mc.x = _loc4_.x + 10;
            }
            _visitor.mc.y = 522 + (_loc3_ - 520) / 2 - 62;
         }
         if(_scareAway)
         {
            _scareAway.x = _loc4_.x + 10;
            _scareAway.y = 522 + (_loc3_ - 520) / 2 - 62;
         }
         if(GLOBAL._bymChat)
         {
            GLOBAL._bymChat.position();
         }
         UI_BOTTOM.Resize();
         UI_WORKERS.Resize();
      }
   }
}

