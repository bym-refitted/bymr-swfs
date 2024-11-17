package com.monsters.ai
{
   import com.cc.utils.SecNum;
   import com.monsters.display.ImageCache;
   import com.monsters.maproom_advanced.MapRoom;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class WMBASE
   {
      public static var _popup:MovieClip;
      
      public static var _bases:Array;
      
      public static var _descentBases:Array;
      
      public static var _startTime:Number;
      
      private static var repairing:Boolean;
      
      public static var _mc:MovieClip;
      
      public static var _type:int;
      
      public static var _destroyed:Boolean;
      
      private static var setupStatus:uint = 0;
      
      private static var callbacks:Array = [];
      
      public static var _repairDelay:int = 2 * 60 * 60;
      
      private static var juiceQ:int = 3;
      
      private static var tick:Number = 0;
      
      private static var _descentMode:Boolean = false;
      
      public function WMBASE()
      {
         super();
      }
      
      public static function Setup() : void
      {
         var _loc1_:BFOUNDATION = null;
         var _loc2_:int = 0;
         _mc = null;
         _destroyed = false;
         _startTime = GLOBAL.Timestamp();
         repairing = true;
         for each(_loc1_ in BASE._buildingsAll)
         {
            if(_loc1_._hp.Get() < _loc1_._hpMax.Get() && _loc1_._repairing != 1)
            {
               repairing = false;
            }
         }
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            GLOBAL._mapWidth *= 1.1;
            GLOBAL._mapHeight *= 1.1;
            GLOBAL._mapWidth = Math.ceil(GLOBAL._mapWidth / 20) * 20;
            GLOBAL._mapHeight = Math.ceil(GLOBAL._mapHeight / 20) * 20;
            _loc2_++;
         }
         if(BASE.isInferno() && BASE._wmID || GLOBAL.InfernoMode(GLOBAL._loadmode))
         {
            return;
         }
         if(TRIBES.TribeForBaseID(BASE._wmID).behaviour == "juice")
         {
            GLOBAL._hatcheryOverdrivePower = new SecNum(10);
         }
      }
      
      public static function Clear() : void
      {
         _bases = [];
         _destroyed = false;
         _descentMode = false;
      }
      
      public static function Data(param1:Array) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         _descentMode = false;
         if(GLOBAL._mode == "build" && Boolean(param1))
         {
            _bases = [];
            for each(_loc2_ in param1)
            {
               _loc3_ = {};
               _loc3_.baseid = _loc2_[0];
               _loc3_.tribe = TRIBES.TribeForBaseID(_loc2_[0]);
               _loc3_.level = _loc2_[1];
               _loc3_.destroyed = _loc2_[2];
               _bases.push(_loc3_);
            }
            _bases.sortOn("level",Array.NUMERIC);
            CheckQuests();
         }
      }
      
      public static function DescentData(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         _descentMode = true;
         if(GLOBAL._mode == "build" && Boolean(param1))
         {
            _loc2_ = 1;
            _descentBases = [];
            for each(_loc3_ in param1)
            {
               _loc4_ = {};
               _loc4_.baseid = _loc3_[0];
               _loc4_.tribe = MAPROOM_DESCENT._descentTribe;
               _loc4_.level = _loc3_[1];
               _loc4_.destroyed = _loc3_[2];
               _descentBases.push(_loc4_);
               if(_loc4_.destroyed == 1)
               {
                  _loc2_++;
               }
            }
            _descentBases.sortOn("level",Array.NUMERIC);
            GLOBAL.StatSet("descentLvl",_loc2_);
            MAPROOM_DESCENT._descentLvl = _loc2_;
         }
      }
      
      public static function AttackerForType(param1:int) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:Array = ChooseBase();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.tribe.type == param1)
            {
               return _loc3_.tribe;
            }
         }
         return {};
      }
      
      public static function TypeForAttackerName(param1:String) : int
      {
         return 0;
      }
      
      public static function Tick() : void
      {
         var _loc1_:BFOUNDATION = null;
         if(!repairing)
         {
            if(GLOBAL.Timestamp() > _startTime + _repairDelay)
            {
               for each(_loc1_ in BASE._buildingsAll)
               {
                  if(_loc1_._hp.Get() < _loc1_._hpMax.Get() && _loc1_._repairing == 0)
                  {
                     _loc1_.Repair();
                  }
               }
               repairing = true;
            }
         }
         if(!GLOBAL._catchup && GLOBAL._bJuicer)
         {
            if(tick % juiceQ == 0 && TRIBES.TribeForBaseID(BASE._wmID).behaviour == "juice" && GLOBAL._bJuicer._hp.Get() > 0.5 * GLOBAL._bJuicer._hpMax.Get() && GLOBAL._bTownhall._hp.Get() > 0)
            {
               for each(_loc1_ in BASE._buildingsAll)
               {
                  if(_loc1_._type == 13 && _loc1_._canFunction && _loc1_._inProduction != "C1")
                  {
                     _loc1_._inProduction = "C1";
                     _loc1_._productionStage.Set(3);
                  }
               }
            }
            ++tick;
         }
      }
      
      public static function ResetAll() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in _bases)
         {
            _loc1_.destroyed = 0;
         }
         for each(_loc1_ in _descentBases)
         {
            _loc1_.destroyed = 0;
         }
      }
      
      public static function DestroyAllDescent() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in _descentBases)
         {
            _loc1_.destroyed = 1;
         }
      }
      
      public static function JuiceOne() : void
      {
         var _loc2_:BFOUNDATION = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         var _loc1_:Array = [];
         for each(_loc2_ in BASE._buildingsAll)
         {
            if(_loc2_._type == 15)
            {
               _loc1_.push(_loc2_);
            }
         }
         for(_loc4_ in HOUSING._creatures)
         {
            if(HOUSING._creatures[_loc4_].Get() > 0)
            {
               _loc3_ = _loc4_;
            }
         }
         if(_loc3_ && GLOBAL._bJuicer && GLOBAL._bJuicer._hp.Get() > 0.5 * GLOBAL._bJuicer._hpMax.Get())
         {
            HOUSING._creatures[_loc3_].Add(-1);
            for each(_loc5_ in CREATURES._creatures)
            {
               if(_loc5_._creatureID == _loc3_ && _loc5_._behaviour != "juice")
               {
                  _loc5_.ModeJuice();
                  return;
               }
            }
         }
      }
      
      public static function CheckQuests() : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc1_:Array = ChooseBase();
         for(_loc2_ in _loc1_)
         {
            if(_loc1_[_loc2_].destroyed == 1)
            {
               if(GLOBAL._mode == "build")
               {
                  _loc3_ = 0;
                  _loc3_ = int(_loc1_[_loc2_].tribe.id);
                  QUESTS.Check("destroy_tribe" + _loc3_,1);
               }
            }
         }
      }
      
      public static function CheckDescentProgress() : int
      {
         var _loc2_:String = null;
         var _loc1_:int = 1;
         if(_descentBases)
         {
            for(_loc2_ in _descentBases)
            {
               if(_descentBases[_loc2_].destroyed == 1)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      public static function Export() : Object
      {
         return ChooseBase();
      }
      
      public static function TownHallDestroyed() : void
      {
         var onImage:Function;
         var shareDown:Function;
         if(GLOBAL._advancedMap)
         {
            GLOBAL.Message(KEYS.Get("msg_yarddestroyed"),KEYS.Get("btn_showmap"),ShowMapAgain);
            MapRoom._mc.ShowInfoEnemy(GLOBAL._currentCell);
         }
         else
         {
            onImage = function(param1:String, param2:BitmapData):void
            {
               var _loc3_:Bitmap = new Bitmap(param2);
               _loc3_.x = 155;
               _loc3_.y = 196;
               _mc.addChild(_loc3_);
            };
            shareDown = function(param1:MouseEvent = null):void
            {
               var _loc2_:Object = TRIBES.TribeForBaseID(BASE._wmID);
               GLOBAL.CallJS("sendFeed",["aibaseDestroyed",_loc2_.succ_stream,_loc2_.succ,_loc2_.streampostpic]);
            };
            _mc = new popup_aibase_success() as MovieClip;
            _mc.Resize = function():void
            {
               _mc.x = 0;
               _mc.y = 0;
            };
            _mc.body_txt.htmlText = BaseForID(BASE._wmID).tribe.succ;
            _mc.b2.SetupKey("btn_brag");
            _mc.b2.Highlight = true;
            _mc.title_txt.htmlText = KEYS.Get("aibase_victory_title");
            _mc.headline_txt.htmlText = "<b>" + KEYS.Get("aibase_victory_headline") + "</b>";
            ImageCache.GetImageWithCallBack(BaseForID(BASE._wmID).tribe.splash,onImage);
            _mc.b2.addEventListener(MouseEvent.MOUSE_DOWN,shareDown);
            _destroyed = true;
            if(Boolean(GLOBAL._advancedMap) && !BASE.isInferno())
            {
               _mc.b1.SetupKey("btn_openmap");
            }
            else
            {
               _mc.b1.SetupKey("btn_returnhome");
            }
            _mc.b1.addEventListener(MouseEvent.MOUSE_DOWN,skipDown);
            GLOBAL._layerWindows.addChild(_mc);
         }
      }
      
      private static function BaseForID(param1:int) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:Array = ChooseBase();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.baseid == param1)
            {
               return _loc3_;
            }
         }
         return {};
      }
      
      private static function skipDown(param1:MouseEvent = null) : void
      {
         if(Boolean(_mc) && Boolean(_mc.parent))
         {
            _mc.parent.removeChild(_mc);
         }
         _mc = null;
         ATTACK.End();
      }
      
      public static function End() : void
      {
         var _loc1_:BFOUNDATION = null;
         if(!GLOBAL._catchup && GLOBAL._mode == "wmattack")
         {
            for each(_loc1_ in BASE._buildingsMain)
            {
               if(_loc1_._hp.Get() == 0 && _loc1_._repairing == 0 && _loc1_._type == 14 && GLOBAL._mode == "wmattack")
               {
                  TownHallDestroyed();
                  return;
               }
            }
         }
         AttackFailed();
      }
      
      public static function AttackFailed() : void
      {
         var onImage:Function;
         var base:Object = null;
         if(GLOBAL._advancedMap)
         {
            GLOBAL.Message(KEYS.Get("msg_notdestroyed"),KEYS.Get("btn_showmap"),ShowMapAgain);
         }
         else
         {
            _mc = new popup_aibase_failure() as MovieClip;
            _mc.Resize = function():*
            {
               _mc.x = 0;
               _mc.y = 0;
            };
            _mc.title_txt.htmlText = KEYS.Get("aibase_defeat_title");
            _mc.headline_txt.htmlText = "<b>" + KEYS.Get("aibase_defeat_headline") + "</b>";
            base = BaseForID(BASE._wmID);
            if(base.tribe)
            {
               onImage = function(param1:String, param2:BitmapData):void
               {
                  var _loc3_:Bitmap = new Bitmap(param2);
                  _loc3_.x = 155;
                  _loc3_.y = 196;
                  if(Boolean(_mc) && Boolean(_mc.parent))
                  {
                     _mc.addChild(_loc3_);
                  }
               };
               ImageCache.GetImageWithCallBack(base.tribe.splash,onImage);
               _mc.body_txt.htmlText = BaseForID(BASE._wmID).tribe.fail;
            }
            if(Boolean(GLOBAL._advancedMap) && !BASE.isInferno())
            {
               _mc.b1.SetupKey("btn_openmap");
            }
            else
            {
               _mc.b1.SetupKey("btn_returnhome");
            }
            _mc.b1.addEventListener(MouseEvent.MOUSE_DOWN,skipDown);
            GLOBAL._layerWindows.addChild(_mc);
         }
         _destroyed = false;
      }
      
      public static function ShowMapAgain() : void
      {
         ATTACK.EndB();
      }
      
      private static function ChooseBase() : Array
      {
         var _loc1_:Array = null;
         if(_descentMode)
         {
            _loc1_ = _descentBases;
         }
         else if(GLOBAL._mode == "build")
         {
            _loc1_ = _bases;
         }
         else
         {
            _loc1_ = _bases;
         }
         return _loc1_;
      }
   }
}

