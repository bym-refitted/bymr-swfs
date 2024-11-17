package
{
   import com.cc.utils.SecNum;
   import com.monsters.ai.TRIBES;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gs.TweenLite;
   import gs.easing.Quad;
   
   public class HOUSING
   {
      public static var _mc:*;
      
      public static var _open:Boolean;
      
      public static var _housingCapacity:SecNum;
      
      public static var _housingUsed:SecNum;
      
      public static var _housingSpace:SecNum;
      
      public static var _housingBuildingUpgrading:Boolean;
      
      public static var _creatures:Object;
      
      public function HOUSING()
      {
         super();
      }
      
      public static function Data(param1:Object) : void
      {
         var _loc2_:String = null;
         _creatures = {};
         for(_loc2_ in param1)
         {
            _creatures[_loc2_] = new SecNum(int(param1[_loc2_]));
         }
         if(_creatures.C100)
         {
            _creatures.C12 = _creatures.C100;
            delete _creatures.C100;
         }
      }
      
      public static function Show(param1:MouseEvent = null) : *
      {
         _open = true;
         GLOBAL.BlockerAdd();
         _mc = GLOBAL._layerWindows.addChild(new HOUSINGPOPUP());
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
      
      public static function HousingSpace() : void
      {
         var c:int = 0;
         var building:BFOUNDATION = null;
         var n:String = null;
         var value:int = 0;
         try
         {
            _housingCapacity = new SecNum(0);
            _housingUsed = new SecNum(0);
            _housingSpace = new SecNum(0);
            _housingBuildingUpgrading = false;
            c = 0;
            for each(building in BASE._buildingsAll)
            {
               if(building._type == 15)
               {
                  if(building._countdownBuild.Get() <= 0 && building._hp.Get() > 10)
                  {
                     value = int(GLOBAL._buildingProps[14].capacity[building._lvl.Get() - 1]);
                     if(GLOBAL._extraHousing >= GLOBAL.Timestamp() && GLOBAL._extraHousingPower.Get() > 0)
                     {
                        value *= 1 + GLOBAL._extraHousingPower.Get() * 0.25;
                     }
                     _housingCapacity.Add(value);
                     c++;
                  }
                  if(building._countdownBuild.Get() + building._countdownUpgrade.Get() > 0)
                  {
                     _housingBuildingUpgrading = true;
                  }
               }
            }
            for(n in _creatures)
            {
               _housingUsed.Add(CREATURES.GetProperty(n,"cStorage") * _creatures[n].Get());
            }
            _housingSpace.Set(_housingCapacity.Get() - _housingUsed.Get());
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("HOUSING.HousingSpace: " + e.message + " | " + e.getStackTrace());
         }
      }
      
      public static function HousingStore(param1:String, param2:Point, param3:Boolean = false, param4:int = 0) : *
      {
         var _loc7_:CREEP = null;
         var _loc8_:Array = null;
         var _loc9_:String = null;
         var _loc10_:BFOUNDATION = null;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         if(param4 > 0)
         {
            LOGGER.Log("log","Instant monster hack");
            GLOBAL.ErrorMessage();
            return;
         }
         if(param1 == "C100")
         {
            param1 = "C12";
         }
         var _loc5_:* = CREATURES.GetProperty(param1,"cStorage");
         var _loc6_:Boolean = (GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview") && TRIBES.TribeForBaseID(BASE._wmID).behaviour == "juice";
         if(_housingSpace.Get() < _loc5_ && !_loc6_)
         {
            return false;
         }
         if(!param3)
         {
            if(_creatures[param1])
            {
               _creatures[param1].Add(1);
            }
            else
            {
               _creatures[param1] = new SecNum(1);
            }
            HousingSpace();
            if(GLOBAL._render)
            {
               if(_loc6_)
               {
                  _loc7_ = CREATURES.Spawn(param1,MAP._BUILDINGTOPS,"juice",param2,0);
                  _loc7_.ModeJuice();
               }
               else
               {
                  _loc8_ = [];
                  for(_loc9_ in BASE._buildingsAll)
                  {
                     if(BASE._buildingsAll[_loc9_]._type == 15 && BASE._buildingsAll[_loc9_]._countdownBuild.Get() <= 0 && BASE._buildingsAll[_loc9_]._hp.Get() > 0)
                     {
                        _loc10_ = BASE._buildingsAll[_loc9_];
                        _loc11_ = _loc10_._mc.x - param2.x;
                        _loc12_ = _loc10_._mc.y - param2.y;
                        _loc13_ = int(Math.sqrt(_loc11_ * _loc11_ + _loc12_ * _loc12_));
                        _loc8_.push({
                           "mc":BASE._buildingsAll[_loc9_],
                           "dist":_loc13_
                        });
                     }
                  }
                  if(_loc8_.length == 0)
                  {
                     return false;
                  }
                  _loc8_.sortOn(["dist"],Array.NUMERIC);
                  _loc10_ = _loc8_[0].mc;
                  CREATURES.Spawn(param1,MAP._BUILDINGTOPS,"housing",param2,0,GRID.FromISO(_loc10_._mc.x,_loc10_._mc.y),_loc10_);
               }
            }
         }
         return true;
      }
      
      public static function Cull(param1:Boolean = false) : *
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         _housingCapacity = new SecNum(0);
         _housingUsed = new SecNum(0);
         _housingSpace = new SecNum(0);
         for(_loc2_ in BASE._buildingsAll)
         {
            if(BASE._buildingsAll[_loc2_]._type == 15 && BASE._buildingsAll[_loc2_]._countdownBuild.Get() <= 0 && BASE._buildingsAll[_loc2_]._hp.Get() > 0)
            {
               _loc3_ = int(GLOBAL._buildingProps[14].capacity[BASE._buildingsAll[_loc2_]._lvl.Get() - 1]);
               if(GLOBAL._extraHousing >= GLOBAL.Timestamp() && GLOBAL._extraHousingPower.Get() > 0)
               {
                  _loc3_ *= 1 + GLOBAL._extraHousingPower.Get() * 0.25;
               }
               _housingCapacity.Add(_loc3_);
            }
         }
         for(_loc2_ in _creatures)
         {
            if(_creatures[_loc2_].Get() <= 0)
            {
               delete _creatures[_loc2_];
            }
            else
            {
               _housingUsed.Add(CREATURES.GetProperty(_loc2_,"cStorage") * _creatures[_loc2_].Get());
            }
         }
         while(_housingUsed.Get() > _housingCapacity.Get())
         {
            _housingUsed.Set(0);
            for(_loc2_ in _creatures)
            {
               if(_creatures[_loc2_].Get() > 0)
               {
                  _creatures[_loc2_].Add(-1);
                  _housingUsed.Add(CREATURES.GetProperty(_loc2_,"cStorage") * _creatures[_loc2_].Get());
               }
               else
               {
                  _creatures[_loc2_].Set(0);
               }
            }
         }
         HousingSpace();
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
               _loc4_ = _creatures[_loc3_].Get();
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
                  CREATURES.Spawn(_loc3_,MAP._BUILDINGTOPS,"pen",PointInHouse(_loc8_),Math.random() * 360,_loc8_,_loc7_);
                  _loc5_++;
               }
            }
         }
      }
      
      public static function PointInHouse(param1:Point) : Point
      {
         var _loc2_:Rectangle = new Rectangle(40,40,80,80);
         return GRID.ToISO(param1.x + (_loc2_.x + Math.random() * _loc2_.width),param1.y + (_loc2_.y + Math.random() * _loc2_.height),0);
      }
      
      public static function Update() : *
      {
         if(_open)
         {
            _mc.Update();
         }
      }
      
      public static function Export() : *
      {
         var _loc2_:String = null;
         var _loc1_:Object = {};
         for(_loc2_ in _creatures)
         {
            _loc1_[_loc2_] = _creatures[_loc2_].Get();
         }
         return _loc1_;
      }
   }
}

