package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class UI_WORKERS
   {
      private static var _do:DisplayObject;
      
      private static var _mc:MovieClip;
      
      private static var _workers:Array;
      
      private static var _popupdo:DisplayObject;
      
      private static var _popupID:int;
      
      private static var _popupmc:bubblepopupRight;
      
      private static var _popupmc2:bubblepopup;
      
      private static var _maxWorkers:int;
      
      private static var _workerMCOffset:int = 45;
      
      public function UI_WORKERS()
      {
         super();
      }
      
      public static function Setup() : *
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         if(Boolean(_do) && Boolean(_do.parent))
         {
            _do.parent.removeChild(_do);
            _do = null;
         }
         _mc = new MovieClip();
         _workers = [];
         if(GLOBAL._mode == "build")
         {
            _maxWorkers = 5;
            if(BASE._isOutpost)
            {
               _maxWorkers = 1;
            }
            if(!GLOBAL._chatEnabled || GLOBAL._flags && GLOBAL._flags.hasOwnProperty("chat") && GLOBAL._flags.chat != 2)
            {
               _loc1_ = 0;
               while(_loc1_ < _maxWorkers)
               {
                  _loc2_ = new icon_worker();
                  _loc2_.x = 10 + _loc1_ * 45;
                  _loc2_.mouseChildren = false;
                  _loc2_.addEventListener(MouseEvent.CLICK,MouseClicked(_loc1_));
                  _loc2_.addEventListener(MouseEvent.MOUSE_OVER,MouseOver(_loc1_));
                  _loc2_.addEventListener(MouseEvent.MOUSE_OUT,MouseOut);
                  _loc2_.buttonMode = true;
                  _mc.addChild(_loc2_);
                  _workers.push({
                     "purchased":false,
                     "active":false,
                     "id":0,
                     "message":"",
                     "mc":_loc2_
                  });
                  _loc1_++;
               }
            }
            else
            {
               _loc1_ = 0;
               while(_loc1_ < _maxWorkers)
               {
                  _loc2_ = new icon_worker();
                  _loc2_.y = 20 + _loc1_ * _workerMCOffset;
                  _loc2_.mouseChildren = false;
                  _loc2_.addEventListener(MouseEvent.CLICK,MouseClicked(_loc1_));
                  _loc2_.addEventListener(MouseEvent.MOUSE_OVER,MouseOver(_loc1_));
                  _loc2_.addEventListener(MouseEvent.MOUSE_OUT,MouseOut);
                  _loc2_.buttonMode = true;
                  _mc.addChild(_loc2_);
                  _workers.push({
                     "purchased":false,
                     "active":false,
                     "id":0,
                     "message":"",
                     "mc":_loc2_
                  });
                  _loc1_++;
               }
            }
            _do = GLOBAL._layerUI.addChild(_mc);
         }
         Update();
         if(!UI2._showBottom)
         {
            Hide();
         }
      }
      
      private static function MouseOver(param1:int) : *
      {
         var i:int = param1;
         return function(param1:MouseEvent = null):*
         {
            var _loc3_:* = undefined;
            var _loc2_:* = _workers[i];
            if(_loc2_.purchased)
            {
               if(_loc2_.active)
               {
                  _loc3_ = _loc2_.message;
               }
               else
               {
                  _loc3_ = KEYS.Get("ui_worker_idle");
               }
            }
            else
            {
               _loc3_ = KEYS.Get("ui_worker_hire");
            }
            if(!GLOBAL._chatEnabled || GLOBAL._flags && GLOBAL._flags.hasOwnProperty("chat") && GLOBAL._flags.chat != 2)
            {
               PopupShow(_mc.x + 30 + i * _workerMCOffset,_mc.y,_loc3_,i);
            }
            else
            {
               PopupShow(_mc.x - 5,_mc.y + i * _workerMCOffset + _workerMCOffset * 0.5,_loc3_,i);
            }
         };
      }
      
      private static function MouseOut(param1:MouseEvent) : *
      {
         PopupHide();
      }
      
      private static function MouseClicked(param1:int) : *
      {
         var i:int = param1;
         return function(param1:MouseEvent = null):*
         {
            if(_workers[i])
            {
               if(_workers[i].purchased)
               {
                  QUEUE.JumpToWorker(i);
               }
               else
               {
                  STORE.ShowB(1,0,["BEW"]);
               }
            }
         };
      }
      
      public static function Update() : *
      {
         var _loc3_:Object = null;
         var _loc4_:* = undefined;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         while(_loc2_ < _workers.length)
         {
            _loc3_ = _workers[_loc2_];
            if(Boolean(QUEUE._stack) && Boolean(QUEUE._stack[_loc2_]))
            {
               _loc4_ = QUEUE._stack[_loc2_];
               if(_loc3_.id != _loc4_.id)
               {
                  _loc3_.id = _loc4_.id;
               }
               _loc3_.message = "<b>" + _loc4_.title + "</b> " + _loc4_.message;
               if(!_loc3_.purchased)
               {
                  _loc3_.purchased = true;
                  _loc1_ = true;
               }
               if(_loc3_.active != _loc4_.active)
               {
                  _loc3_.active = _loc4_.active;
                  _loc1_ = true;
               }
               if(Boolean(_loc3_.active) && _popupID == _loc2_)
               {
                  PopupUpdate(_loc3_.message);
               }
            }
            _loc2_++;
         }
         if(_loc1_)
         {
            Render();
         }
      }
      
      public static function Resize() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:Rectangle = null;
         if(!GLOBAL._chatEnabled || GLOBAL._flags && GLOBAL._flags.hasOwnProperty("chat") && GLOBAL._flags.chat != 2)
         {
            if(_mc)
            {
               _loc1_ = GLOBAL._ROOT.stage.stageWidth;
               _loc2_ = GLOBAL.GetGameHeight();
               _loc3_ = new Rectangle(0 - (_loc1_ - 760) / 2,0 - (_loc2_ - 520) / 2,_loc1_,_loc2_);
               _mc.x = int(_loc3_.x);
               _mc.y = int(522 + (_loc2_ - 520) / 2 - 50);
            }
         }
         else if(_mc)
         {
            _loc1_ = GLOBAL._ROOT.stage.stageWidth;
            _loc2_ = GLOBAL._ROOT.stage.stageHeight;
            _loc3_ = new Rectangle(0 - (_loc1_ - 760) / 2,(-520 - _loc2_) / 2,_loc1_,_loc2_);
            _mc.x = int(_loc3_.x + _loc3_.width) - _workerMCOffset;
            if(BASE._isProtected - GLOBAL.Timestamp() > 0 && GLOBAL._mode == "build")
            {
               _mc.y = int((520 - _loc2_) / 2 + 70);
            }
            else
            {
               _mc.y = int((520 - _loc2_) / 2 + 50);
            }
         }
      }
      
      private static function Render() : *
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < _maxWorkers)
         {
            _loc2_ = _workers[_loc1_];
            if(_loc2_.purchased)
            {
               if(_loc2_.active)
               {
                  _loc2_.mc.gotoAndStop(2);
               }
               else
               {
                  _loc2_.mc.gotoAndStop(1);
               }
               if(STORE._storeData.BST)
               {
                  _loc2_.mc.mcIcon.gotoAndStop(2);
               }
               else
               {
                  _loc2_.mc.mcIcon.gotoAndStop(1);
               }
            }
            else
            {
               _loc2_.mc.gotoAndStop(3);
               _loc2_.mc.label_txt.htmlText = "<b>" + KEYS.Get("ui_worker_hireicon") + "</b>";
            }
            _loc1_++;
         }
      }
      
      public static function PopupShow(param1:int, param2:int, param3:String, param4:int) : *
      {
         PopupHide();
         if(!GLOBAL._chatEnabled || GLOBAL._flags && GLOBAL._flags.hasOwnProperty("chat") && GLOBAL._flags.chat != 2)
         {
            _popupID = param4;
            _popupmc2 = new bubblepopup();
            _popupmc2.Setup(param1,param2,param3);
            _popupmc2.Nudge("up");
            _popupdo = GLOBAL._layerUI.addChild(_popupmc2);
         }
         else
         {
            _popupID = param4;
            _popupmc = new bubblepopupRight();
            _popupmc.Setup(param1,param2,param3);
            _popupmc.Nudge("left");
            _popupdo = GLOBAL._layerUI.addChild(_popupmc);
         }
      }
      
      public static function PopupUpdate(param1:String) : *
      {
         if(_popupmc)
         {
            _popupmc.Update(param1);
         }
         else if(_popupmc2)
         {
            _popupmc2.Update(param1);
         }
      }
      
      public static function PopupHide() : *
      {
         if(_popupdo)
         {
            GLOBAL._layerUI.removeChild(_popupdo);
            _popupdo = null;
         }
      }
      
      public static function Show() : *
      {
         if(TUTORIAL._stage < 192)
         {
            _mc.visible = false;
         }
         else
         {
            _mc.visible = true;
         }
      }
      
      public static function Hide() : *
      {
         _mc.visible = false;
      }
   }
}
