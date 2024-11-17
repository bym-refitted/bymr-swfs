package
{
   import com.monsters.ai.TRIBES;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gs.TweenLite;
   import gs.easing.Quad;
   
   public class MONSTERBUNKER
   {
      public static var _mc:*;
      
      public static var _open:Boolean;
      
      public static var _bunkerCapacity:int;
      
      public static var _bunkerUsed:int;
      
      public static var _bunkerSpace:int;
      
      public static var _housingBuildingUpgrading:Boolean;
      
      public static var _creatures:Object;
      
      public function MONSTERBUNKER()
      {
         super();
      }
      
      public static function Data(param1:Object) : void
      {
         _creatures = param1;
         if(_creatures.C100)
         {
            _creatures.C12 = _creatures.C100;
            delete _creatures.C100;
         }
      }
      
      public static function Show(param1:MouseEvent = null) : *
      {
         Hide(param1);
         _open = true;
         GLOBAL.BlockerAdd();
         _mc = GLOBAL._layerWindows.addChild(new MONSTERBUNKERPOPUP());
         _mc.x = 380;
         _mc.y = 260;
         _mc.scaleY = 0.9;
         _mc.scaleX = 0.9;
         TweenLite.to(_mc,0.2,{
            "scaleX":1,
            "scaleY":1,
            "ease":Quad.easeOut
         });
      }
      
      public static function Hide(param1:MouseEvent = null) : *
      {
         if(_open)
         {
            GLOBAL.BlockerRemove();
            SOUNDS.Play("close");
            GLOBAL._layerWindows.removeChild(_mc);
            _open = false;
            _mc = null;
         }
      }
      
      public static function BunkerStore(param1:String, param2:BUILDING22, param3:Boolean = false) : *
      {
         var _loc6_:CREEP = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:BFOUNDATION = null;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         if(param1 == "C100")
         {
            param1 = "C12";
         }
         var _loc4_:* = CREATURES.GetProperty(param1,"cStorage");
         var _loc5_:Boolean = (GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview") && TRIBES.TribeForID(BASE._wmID).behaviour == "juice";
         if(_bunkerSpace < _loc4_ && !_loc5_)
         {
            return false;
         }
         if(!param3)
         {
            if(param2._monsters[param1])
            {
               param2._monsters[param1] += 1;
            }
            else
            {
               param2._monsters[param1] = 1;
            }
            if(GLOBAL._render)
            {
               if(_loc5_)
               {
                  _loc6_ = CREATURES.Spawn(param1,MAP._BUILDINGTOPS,"juice",new Point(param2.x,param2.y),0);
                  _loc6_.ModeJuice();
               }
               else
               {
                  _loc7_ = [];
                  for(_loc8_ in BASE._buildingsAll)
                  {
                     if(BASE._buildingsAll[_loc8_]._type == 15 && BASE._buildingsAll[_loc8_]._countdownBuild.Get() <= 0 && BASE._buildingsAll[_loc8_]._hp.Get() > 0)
                     {
                        _loc9_ = BASE._buildingsAll[_loc8_];
                        _loc10_ = _loc9_._mc.x - param2.x;
                        _loc11_ = _loc9_._mc.y - param2.y;
                        _loc12_ = int(Math.sqrt(_loc10_ * _loc10_ + _loc11_ * _loc11_));
                        _loc7_.push({
                           "mc":BASE._buildingsAll[_loc8_],
                           "dist":_loc12_
                        });
                     }
                  }
                  if(_loc7_.length == 0)
                  {
                     return false;
                  }
                  _loc7_.sortOn(["dist"],Array.NUMERIC);
                  _loc9_ = _loc7_[0].mc;
                  CREATURES.Spawn(param1,MAP._BUILDINGTOPS,"bunkering",new Point(param2._mc.x,param2._mc.y),0,GRID.FromISO(_loc9_._mc.x,_loc9_._mc.y),_loc9_);
               }
            }
         }
         return true;
      }
      
      public static function Cull() : *
      {
         _bunkerCapacity = 0;
         _bunkerUsed = 0;
         _bunkerSpace = 0;
      }
      
      public static function Populate() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:Point = null;
         var _loc1_:Array = [];
         for each(_loc2_ in BASE._buildingsAll)
         {
            if(_loc2_._type == 15 && _loc2_._hp.Get() > 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         if(_loc1_.length > 0)
         {
            for(_loc3_ in _creatures)
            {
               _loc4_ = _creatures[_loc3_];
               if(_loc4_ > 50)
               {
                  _loc4_ = 50;
               }
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc6_ = Math.random() * _loc1_.length;
                  _loc7_ = _loc1_[_loc6_];
                  _loc8_ = GRID.FromISO(_loc7_.x,_loc7_.y);
                  CREATURES.Spawn(_loc3_,MAP._BUILDINGTOPS,"pen",PointInBunker(_loc8_),Math.random() * 360,_loc8_,_loc7_);
                  _loc5_++;
               }
            }
         }
      }
      
      public static function PointInBunker(param1:Point) : Point
      {
         var _loc2_:Rectangle = new Rectangle(30,40,110,80);
         return GRID.ToISO(param1.x + (_loc2_.x + Math.random() * _loc2_.width),param1.y + (_loc2_.y + Math.random() * _loc2_.height),0);
      }
      
      public static function Tick() : *
      {
         if(_open)
         {
            _mc.Update();
         }
      }
   }
}

