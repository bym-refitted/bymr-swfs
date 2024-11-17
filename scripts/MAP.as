package
{
   import com.cc.screenshot.screenshot;
   import com.monsters.pathing.PATHING;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.getTimer;
   import gs.*;
   import gs.easing.*;
   
   public class MAP
   {
      public static var _dragX:*;
      
      public static var _dragY:*;
      
      public static var tx:*;
      
      public static var ty:*;
      
      public static var targX:*;
      
      public static var targY:*;
      
      public static var d:*;
      
      public static var _startX:*;
      
      public static var _startY:*;
      
      public static var _autoScroll:Boolean;
      
      public static var _dragging:*;
      
      public static var _dragged:*;
      
      public static var _dragDistance:*;
      
      public static var _EFFECTSBMP:BitmapData;
      
      public static var _GROUND:*;
      
      public static var _EDGE:*;
      
      public static var _UNDERLAY:*;
      
      public static var _RESOURCES:*;
      
      public static var _BUILDINGBASES:*;
      
      public static var _WORKERS:*;
      
      public static var _WALLS:*;
      
      public static var _EFFECTS:*;
      
      public static var _CREEPSMC:*;
      
      public static var _BUILDINGFOOTPRINTS:*;
      
      public static var _BUILDINGINFO:*;
      
      public static var _PROJECTILES:*;
      
      public static var _FIREBALLS:*;
      
      public static var _EFFECTSTOP:*;
      
      public static var _BUILDINGTOPS:*;
      
      public static var _damageGrid:Object;
      
      public static var _following:Boolean;
      
      public static var _inited:Boolean = false;
      
      public static var stage:* = GLOBAL._ROOT.stage;
      
      public static var _creepCells:Object = {};
      
      public static var _sortArray:Array = [];
      
      public static var _sortTo:int = 0;
      
      public static var _canScroll:Boolean = true;
      
      private static var _catapultsSetup:Boolean = false;
      
      public static var vol:Number = 1;
      
      private static var keyunlock:int = 0;
      
      public function MAP(param1:String)
      {
         var tiles:Array = null;
         var tile:* = undefined;
         var h:* = undefined;
         var v:* = undefined;
         var g:* = undefined;
         var efxbmp:* = undefined;
         var texture:String = param1;
         super();
         try
         {
            tx = GLOBAL._SCREENINIT.width / 2;
            ty = GLOBAL._SCREENINIT.height / 2;
            _GROUND = GLOBAL._layerMap.addChild(new MovieClip());
            tiles = [];
            tile = MAPBG.MakeTile(texture);
            h = -2;
            while(h < 2)
            {
               v = -2;
               while(v < 2)
               {
                  g = _GROUND.addChild(new Bitmap(tile));
                  g.x = h * 998;
                  g.y = v * 498;
                  g.cacheAsBitmap = true;
                  v++;
               }
               h++;
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","MAP.Setup A: " + e.message + " | " + e.getStackTrace());
         }
         try
         {
            _GROUND.x = tx;
            _GROUND.y = ty;
            _UNDERLAY = _GROUND.addChild(new MovieClip());
            _EFFECTSBMP = new BitmapData(3200,30 * 60,true,0);
            efxbmp = _GROUND.addChild(new Bitmap(_EFFECTSBMP));
            efxbmp.x = 0 - _EFFECTSBMP.width * 0.5;
            efxbmp.y = 0 - _EFFECTSBMP.height * 0.5;
            _EFFECTS = _GROUND.addChild(new MovieClip());
            _EFFECTS.mouseEnabled = false;
            _EFFECTS.mouseChildren = false;
            _EFFECTS.tabChildren = false;
            _BUILDINGBASES = _GROUND.addChild(new MovieClip());
            _BUILDINGBASES.mouseEnabled = false;
            _BUILDINGBASES.mouseChildren = true;
            _BUILDINGBASES.tabChildren = false;
            _BUILDINGFOOTPRINTS = _GROUND.addChild(new MovieClip());
            _BUILDINGFOOTPRINTS.mouseEnabled = false;
            _BUILDINGFOOTPRINTS.mouseChildren = false;
            _BUILDINGFOOTPRINTS.tabChildren = false;
            _CREEPSMC = _GROUND.addChild(new MovieClip());
            _CREEPSMC.mouseEnabled = false;
            _CREEPSMC.mouseChildren = true;
            _CREEPSMC.tabChildren = false;
            _BUILDINGTOPS = _GROUND.addChild(new MovieClip());
            _BUILDINGTOPS.mouseEnabled = false;
            _BUILDINGTOPS.mouseChildren = true;
            _BUILDINGTOPS.tabChildren = false;
            _RESOURCES = _GROUND.addChild(new MovieClip());
            _RESOURCES.mouseEnabled = false;
            _RESOURCES.mouseChildren = false;
            _RESOURCES.tabChildren = false;
            _BUILDINGINFO = _GROUND.addChild(new MovieClip());
            _BUILDINGINFO.mouseEnabled = false;
            _BUILDINGINFO.mouseChildren = true;
            _BUILDINGINFO.tabChildren = false;
            _PROJECTILES = _GROUND.addChild(new MovieClip());
            _PROJECTILES.mouseEnabled = false;
            _PROJECTILES.mouseChildren = false;
            _PROJECTILES.tabChildren = false;
            _FIREBALLS = _GROUND.addChild(new MovieClip());
            _FIREBALLS.mouseEnabled = false;
            _FIREBALLS.mouseChildren = false;
            _FIREBALLS.tabChildren = false;
            _EFFECTSTOP = _GROUND.addChild(new MovieClip());
            _EFFECTSTOP.mouseEnabled = false;
            _EFFECTSTOP.mouseChildren = false;
            _EFFECTSTOP.tabChildren = false;
            _dragged = false;
            _creepCells = {};
            _GROUND.addEventListener(MouseEvent.MOUSE_DOWN,Click);
            _GROUND.addEventListener(Event.ENTER_FRAME,Scroll);
            if(!GLOBAL._local)
            {
               GLOBAL._ROOT.stage.addEventListener(KeyboardEvent.KEY_DOWN,KeyDownPublic);
            }
            GLOBAL._ROOT.stage.addEventListener(KeyboardEvent.KEY_UP,KeyUp);
            _EDGE = null;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","MAP.Setup B: " + e.message + " | " + e.getStackTrace());
         }
         Edge();
         _inited = true;
      }
      
      public static function Clear() : void
      {
         if(_GROUND)
         {
            _GROUND.removeEventListener(MouseEvent.MOUSE_DOWN,Click);
            _GROUND.removeEventListener(Event.ENTER_FRAME,Scroll);
         }
         _BUILDINGBASES = null;
         _BUILDINGFOOTPRINTS = null;
         _RESOURCES = null;
         _BUILDINGINFO = null;
         _PROJECTILES = null;
         _FIREBALLS = null;
         _EFFECTS = null;
         _EFFECTSTOP = null;
         _GROUND = null;
         if(_EFFECTSBMP)
         {
            _EFFECTSBMP.dispose();
         }
         _EFFECTSBMP = null;
         _inited = false;
      }
      
      public static function Edge() : *
      {
         var iso:Point = null;
         try
         {
            if(_EDGE)
            {
               _UNDERLAY.removeChild(_EDGE);
            }
            _EDGE = _UNDERLAY.addChild(new MovieClip());
            _EDGE.graphics.lineStyle(2,0xffffff,0.5);
            iso = GRID.ToISO((0 - GLOBAL._mapWidth) / 2,(0 - GLOBAL._mapHeight) / 2,0);
            _EDGE.graphics.moveTo(iso.x,iso.y);
            iso = GRID.ToISO(GLOBAL._mapWidth / 2,(0 - GLOBAL._mapHeight) / 2,0);
            _EDGE.graphics.lineTo(iso.x,iso.y);
            iso = GRID.ToISO(GLOBAL._mapWidth / 2,GLOBAL._mapHeight / 2,0);
            _EDGE.graphics.lineTo(iso.x,iso.y);
            iso = GRID.ToISO((0 - GLOBAL._mapWidth) / 2,GLOBAL._mapHeight / 2,0);
            _EDGE.graphics.lineTo(iso.x,iso.y);
            iso = GRID.ToISO((0 - GLOBAL._mapWidth) / 2,(0 - GLOBAL._mapHeight) / 2,0);
            _EDGE.graphics.lineTo(iso.x,iso.y);
            _EDGE.cacheAsBitmap = true;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","MAP.Edge: " + e.message + " | " + e.getStackTrace());
         }
      }
      
      public static function SortDepth(param1:Boolean = false, param2:Boolean = false) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc3_:int = getTimer();
         _sortArray = [];
         var _loc6_:int = 0;
         while(_loc6_ < _BUILDINGTOPS.numChildren)
         {
            if(_BUILDINGTOPS.getChildAt(_loc6_))
            {
               _loc4_ = _BUILDINGTOPS.getChildAt(_loc6_);
               _loc5_ = int(_loc4_.y);
               _loc5_ = _loc5_ + _loc4_._middle;
               _sortArray.push({
                  "depth":_loc5_ * 1000 + _loc4_.x,
                  "mc":_loc4_
               });
            }
            _loc6_++;
         }
         _sortArray.sortOn("depth",Array.NUMERIC);
         _loc6_ = 0;
         while(_loc6_ < _sortArray.length)
         {
            if(_BUILDINGTOPS.getChildIndex(_sortArray[_loc6_].mc) != _loc6_)
            {
               _BUILDINGTOPS.setChildIndex(_sortArray[_loc6_].mc,_loc6_);
            }
            _loc6_++;
         }
      }
      
      public static function KeyDownPublic(param1:KeyboardEvent) : *
      {
         if(param1.shiftKey)
         {
            if(keyunlock == 0 && param1.keyCode == 38)
            {
               keyunlock = 1;
            }
            else if(keyunlock == 1 && param1.keyCode == 40)
            {
               keyunlock = 2;
            }
            else if(keyunlock == 2 && param1.keyCode == 37)
            {
               keyunlock = 3;
            }
            else if(keyunlock == 3 && param1.keyCode == 39)
            {
               screenshot.Show();
            }
            else
            {
               keyunlock = 0;
            }
         }
      }
      
      public static function KeyDownLocal(param1:KeyboardEvent) : *
      {
         if(param1.shiftKey)
         {
            if(keyunlock == 0 && param1.keyCode == 38)
            {
               keyunlock = 1;
            }
            else if(keyunlock == 1 && param1.keyCode == 40)
            {
               keyunlock = 2;
            }
            else if(keyunlock == 2 && param1.keyCode == 37)
            {
               keyunlock = 3;
            }
            else if(keyunlock == 3 && param1.keyCode == 39)
            {
               screenshot.Show();
            }
            else
            {
               keyunlock = 0;
            }
         }
         if(!GLOBAL._flags.viximo && !GLOBAL._flags.kongregate && GLOBAL._bymChat && GLOBAL._bymChat.chatInputHasFocus() && !GLOBAL._aiDesignMode)
         {
            return;
         }
      }
      
      public static function KeyUp(param1:KeyboardEvent) : *
      {
      }
      
      public static function Click(param1:MouseEvent = null) : *
      {
         if(UI2._scrollMap)
         {
            _dragX = stage.mouseX - _GROUND.x;
            _dragY = stage.mouseY - _GROUND.y;
            _startX = _GROUND.x;
            _startY = _GROUND.y;
            _dragging = true;
            stage.addEventListener(MouseEvent.MOUSE_UP,Release);
         }
      }
      
      public static function Release(param1:MouseEvent) : *
      {
         _dragging = false;
         _dragged = false;
         stage.removeEventListener(MouseEvent.MOUSE_UP,Release);
      }
      
      public static function Focus(param1:*, param2:*) : *
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!GLOBAL._catchup)
         {
            if(GLOBAL._zoomed)
            {
               param1 /= 3;
               param2 /= 3;
            }
            tx = 0 - (param1 - 380);
            ty = 0 - (param2 - 335);
            if(GLOBAL._zoomed)
            {
               tx /= 3;
               ty /= 3;
            }
            _loc3_ = int(stage.stageWidth);
            _loc4_ = GLOBAL.GetGameHeight();
            if(GLOBAL._zoomed)
            {
               _loc3_ *= 3;
               _loc4_ *= 3;
            }
            _GROUND.x = tx;
            _GROUND.y = ty;
         }
      }
      
      public static function FocusTo(param1:int, param2:int, param3:Number, param4:Number = 0, param5:Number = 0, param6:Boolean = true, param7:Function = null) : *
      {
         var FocusToDone:Function;
         var w:int = 0;
         var h:int = 0;
         var X:int = param1;
         var Y:int = param2;
         var time:Number = param3;
         var delay:Number = param4;
         var pause:Number = param5;
         var ease:Boolean = param6;
         var callback:Function = param7;
         if(!GLOBAL._catchup)
         {
            FocusToDone = function():*
            {
               tx = _GROUND.x;
               ty = _GROUND.y;
               _autoScroll = false;
               if(callback != null)
               {
                  callback();
               }
            };
            if(pause > 0)
            {
               UI2.Hide("top");
               UI2.Hide("bottom");
            }
            if(GLOBAL._zoomed)
            {
               X /= 3;
               Y /= 3;
            }
            _autoScroll = true;
            tx = 0 - (X - 380);
            ty = 0 - (Y - 340);
            w = int(stage.stageWidth);
            h = GLOBAL.GetGameHeight();
            if(GLOBAL._zoomed)
            {
               w *= 3;
               h *= 3;
            }
            if(ease)
            {
               TweenLite.to(_GROUND,time,{
                  "x":tx,
                  "y":ty,
                  "ease":Cubic.easeInOut,
                  "delay":delay,
                  "onComplete":FocusToDone,
                  "overwrite":false
               });
            }
            else
            {
               TweenLite.to(_GROUND,time,{
                  "x":tx,
                  "y":ty,
                  "ease":Linear.easeNone,
                  "delay":delay,
                  "onComplete":FocusToDone,
                  "overwrite":false
               });
            }
         }
      }
      
      public static function FollowStart() : *
      {
         UI2.Hide("top");
         UI2.Hide("bottom");
         _following = true;
      }
      
      public static function FollowStop() : *
      {
         UI2.Show("top");
         UI2.Show("bottom");
         _following = false;
      }
      
      public static function Scroll(param1:Event = null) : *
      {
         var _loc7_:int = 0;
         var _loc8_:MovieClip = null;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         if(_following)
         {
            tx = 0;
            ty = 0;
            _loc7_ = 0;
            for each(_loc8_ in CREEPS._creeps)
            {
               if(_loc8_._behaviour == "attack" || _loc8_._behaviour == "loot")
               {
                  _loc7_++;
                  tx += _loc8_.x;
                  ty += _loc8_.y;
               }
            }
            if(_loc7_ <= 0)
            {
               tx = _dragX;
               ty = _dragY;
               if(CREEPS._creepCount == 0)
               {
                  FollowStop();
               }
               return;
            }
            tx /= _loc7_;
            ty /= _loc7_;
            tx = 0 - tx + GLOBAL._ROOT.stage.stageWidth / 2;
            ty = 0 - ty + GLOBAL.GetGameHeight() / 2;
            _dragX = tx;
            _dragY = ty;
         }
         else if(_dragging && UI2._scrollMap && !_autoScroll && _canScroll)
         {
            tx = int(stage.mouseX - _dragX);
            ty = int(stage.mouseY - _dragY);
            _loc9_ = stage.mouseX - (_dragX + _startX);
            _loc10_ = stage.mouseY - (_dragY + _startY);
            _dragDistance = Math.abs(Math.sqrt(_loc9_ * _loc9_ + _loc10_ * _loc10_));
            if(_dragDistance > 10)
            {
               _dragged = true;
            }
         }
         var _loc2_:int = GLOBAL._ROOT.stage.stageWidth;
         var _loc3_:int = GLOBAL.GetGameHeight();
         if(GLOBAL._zoomed)
         {
            _loc2_ *= 3;
            _loc3_ *= 3;
         }
         var _loc4_:int = (_loc2_ - 1700) / 2 - 375;
         if(tx < _loc4_)
         {
            tx = _loc4_;
         }
         _loc4_ = 1700 - _loc2_ / 2 + 375;
         if(tx > _loc4_)
         {
            tx = _loc4_;
         }
         var _loc5_:int = 990;
         var _loc6_:int = 320;
         if(GLOBAL._zoomed)
         {
            _loc5_ = 1210;
            _loc6_ = 380;
         }
         _loc4_ = (_loc3_ - _loc5_) / 2 - _loc6_;
         if(ty < _loc4_)
         {
            ty = _loc4_;
         }
         _loc4_ = _loc5_ - _loc3_ / 2 + _loc6_;
         if(ty > _loc4_)
         {
            ty = _loc4_;
         }
         d = 2;
         targX = _GROUND.x;
         targY = _GROUND.y;
         if(targX < tx)
         {
            targX += int((tx - targX) / 2);
         }
         else if(targX > tx)
         {
            targX -= int((targX - tx) / 2);
         }
         if(Math.abs(targX - tx) <= 2)
         {
            targX = tx;
            --d;
         }
         if(targY < ty - 1)
         {
            targY += (ty - targY) / 2;
         }
         else
         {
            targY -= (targY - ty) / 2;
         }
         if(Math.abs(targY - ty) <= 2)
         {
            targY = ty;
            --d;
         }
         if(!(d == 0 || _autoScroll))
         {
            _GROUND.x = int(targX);
            _GROUND.y = int(targY);
         }
      }
      
      public static function CreepCellAdd(param1:Point, param2:String, param3:MovieClip) : *
      {
         param1 = GRID.FromISO(param1.x,param1.y);
         var _loc4_:String = "node" + int(param1.x / 100) + "|" + int(param1.y / 100);
         if(!_creepCells[_loc4_])
         {
            _creepCells[_loc4_] = new Object();
         }
         _creepCells[_loc4_]["creep" + param2] = param3;
         return _loc4_;
      }
      
      public static function CreepCellMove(param1:Point, param2:String, param3:MovieClip, param4:String) : *
      {
         param1 = GRID.FromISO(param1.x,param1.y);
         var _loc5_:* = "node" + int(param1.x / 100) + "|" + int(param1.y / 100);
         if(_loc5_ != param4)
         {
            CreepCellDelete(param2,param4);
            return CreepCellAdd(GRID.ToISO(param1.x,param1.y,0),param2,param3);
         }
      }
      
      public static function CreepCellDelete(param1:String, param2:String) : *
      {
         if(_creepCells[param2])
         {
            delete _creepCells[param2]["creep" + param1];
         }
      }
      
      public static function CreepCellFind(param1:Point, param2:Number, param3:int = 0, param4:* = null) : Array
      {
         var _loc11_:int = 0;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         param1 = PATHING.FromISO(param1);
         var _loc5_:int = int(param1.x / 100);
         var _loc6_:int = int(param1.y / 100);
         var _loc7_:int = int(param2 / 100) + 1;
         var _loc8_:Array = [];
         var _loc9_:Number = param2 * param2;
         var _loc10_:int = _loc5_ - _loc7_;
         while(_loc10_ <= _loc5_ + _loc7_)
         {
            _loc11_ = _loc6_ - _loc7_;
            while(_loc11_ <= _loc6_ + _loc7_)
            {
               _loc12_ = "node" + _loc10_ + "|" + _loc11_;
               for(_loc13_ in _creepCells[_loc12_])
               {
                  _loc14_ = _creepCells[_loc12_][_loc13_];
                  if(_loc14_._health.Get() > 0 && _loc14_._visible && _loc14_._blinkState == 0 && _loc14_ != param4)
                  {
                     if((param3 < 0 || _loc14_._invisibleTime == 0) && (_loc14_._movement != "fly" && param3 < 2 || _loc14_._movement == "fly" && param3 > 0))
                     {
                        _loc15_ = _loc14_._health.Get();
                        _loc16_ = PATHING.FromISO(_loc14_._tmpPoint);
                        _loc17_ = int(GLOBAL.QuickDistanceSquared(param1,_loc16_));
                        if(_loc17_ < _loc9_)
                        {
                           _loc8_.push({
                              "creep":_loc14_,
                              "dist":Math.sqrt(_loc17_),
                              "pos":_loc16_,
                              "hp":_loc15_
                           });
                        }
                     }
                  }
               }
               _loc11_++;
            }
            _loc10_++;
         }
         return _loc8_;
      }
      
      public static function OnLand(param1:int, param2:int, param3:int) : *
      {
         return true;
      }
   }
}

