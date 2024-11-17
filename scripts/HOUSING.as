package
{
   import com.cc.utils.SecNum;
   import com.monsters.ai.TRIBES;
   import com.monsters.monsters.MonsterBase;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HOUSING
   {
      public static var _mc:HOUSINGPOPUP;
      
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
            if(_loc2_.substr(0,1) == "C" || _loc2_.substr(0,2) == "IC")
            {
               _creatures[_loc2_] = new SecNum(int(param1[_loc2_]));
            }
         }
         if(_creatures.C100)
         {
            _creatures.C12 = _creatures.C100;
            delete _creatures.C100;
         }
      }
      
      public static function Show(param1:MouseEvent = null) : void
      {
         _open = true;
         GLOBAL.BlockerAdd();
         _mc = GLOBAL._layerWindows.addChild(new HOUSINGPOPUP()) as HOUSINGPOPUP;
         _mc.Center();
         _mc.ScaleUp();
      }
      
      public static function Hide(param1:MouseEvent = null) : void
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
         var _loc2_:BFOUNDATION = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         _housingCapacity = new SecNum(0);
         _housingUsed = new SecNum(0);
         _housingSpace = new SecNum(0);
         _housingBuildingUpgrading = false;
         var _loc1_:int = 0;
         for each(_loc2_ in BASE._buildingsHousing)
         {
            if(_loc2_._countdownBuild.Get() <= 0 && _loc2_._hp.Get() > 10)
            {
               _loc4_ = int(_loc2_._buildingProps.capacity[_loc2_._lvl.Get() - 1]);
               if(GLOBAL._extraHousing >= GLOBAL.Timestamp() && GLOBAL._extraHousingPower.Get() > 0)
               {
                  _loc4_ *= 1 + GLOBAL._extraHousingPower.Get() * 0.25;
               }
               _housingCapacity.Add(_loc4_);
               _loc1_++;
            }
            if(_loc2_._countdownBuild.Get() + _loc2_._countdownUpgrade.Get() > 0)
            {
               _housingBuildingUpgrading = true;
            }
         }
         for(_loc3_ in _creatures)
         {
            _housingUsed.Add(CREATURES.GetProperty(_loc3_,"cStorage",0,true) * _creatures[_loc3_].Get());
         }
         _housingSpace.Set(_housingCapacity.Get() - _housingUsed.Get());
      }
      
      public static function HousingStore(param1:String, param2:Point, param3:Boolean = false, param4:int = 0) : Boolean
      {
         var _loc7_:* = undefined;
         var _loc8_:Array = null;
         var _loc9_:BFOUNDATION = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         if(param4 > 0)
         {
            LOGGER.Log("hak","Instant monster hack");
            GLOBAL.ErrorMessage("HOUSING insta monster hack");
            return false;
         }
         if(param1 == "C100")
         {
            param1 = "C12";
         }
         var _loc5_:int = CREATURES.GetProperty(param1,"cStorage",0,true);
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
                  if(_loc7_)
                  {
                     _loc7_.ModeJuice();
                  }
               }
               else
               {
                  _loc8_ = [];
                  for each(_loc9_ in BASE._buildingsHousing)
                  {
                     if(_loc9_._countdownBuild.Get() <= 0 && _loc9_._hp.Get() > 0)
                     {
                        _loc10_ = _loc9_._mc.x - param2.x;
                        _loc11_ = _loc9_._mc.y - param2.y;
                        _loc12_ = int(_loc9_._creatures.length);
                        _loc8_.push({
                           "mc":_loc9_,
                           "dist":_loc12_
                        });
                     }
                  }
                  if(_loc8_.length == 0)
                  {
                     return false;
                  }
                  _loc8_.sortOn(["dist"],Array.NUMERIC);
                  _loc9_ = _loc8_[0].mc;
                  CREATURES.Spawn(param1,MAP._BUILDINGTOPS,"housing",param2,0,GRID.FromISO(_loc9_._mc.x,_loc9_._mc.y),_loc9_);
               }
            }
         }
         return true;
      }
      
      public static function Cull(param1:Boolean = false) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         _housingCapacity = new SecNum(0);
         _housingUsed = new SecNum(0);
         _housingSpace = new SecNum(0);
         for each(_loc2_ in BASE._buildingsHousing)
         {
            if(_loc2_._countdownBuild.Get() <= 0 && _loc2_._hp.Get() > 0)
            {
               _loc4_ = int(_loc2_._buildingProps.capacity[_loc2_._lvl.Get() - 1]);
               if(GLOBAL._extraHousing >= GLOBAL.Timestamp() && GLOBAL._extraHousingPower.Get() > 0)
               {
                  _loc4_ *= 1 + GLOBAL._extraHousingPower.Get() * 0.25;
               }
               _housingCapacity.Add(_loc4_);
            }
         }
         for(_loc3_ in _creatures)
         {
            if(_creatures[_loc3_].Get() <= 0)
            {
               delete _creatures[_loc3_];
            }
            else
            {
               _housingUsed.Add(CREATURES.GetProperty(_loc3_,"cStorage",0,true) * _creatures[_loc3_].Get());
            }
         }
         while(_housingUsed.Get() > _housingCapacity.Get())
         {
            _housingUsed.Set(0);
            for(_loc3_ in _creatures)
            {
               if(_creatures[_loc3_].Get() > 0)
               {
                  _creatures[_loc3_].Add(-1);
                  _housingUsed.Add(CREATURES.GetProperty(_loc3_,"cStorage",0,true) * _creatures[_loc3_].Get());
               }
               else
               {
                  _creatures[_loc3_].Set(0);
               }
            }
         }
         HousingSpace();
      }
      
      public static function Populate() : void
      {
         var _loc2_:BFOUNDATION = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:BFOUNDATION = null;
         var _loc8_:Point = null;
         var _loc1_:Array = [];
         for each(_loc2_ in BASE._buildingsHousing)
         {
            if(_loc2_._hp.Get() > 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         if(_loc1_.length > 0)
         {
            for(_loc3_ in _creatures)
            {
               _loc4_ = int(_creatures[_loc3_].Get());
               if(!BASE.isInferno() && _loc4_ > 50)
               {
                  _loc4_ = 50;
               }
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc6_ = Math.random() * _loc1_.length;
                  _loc7_ = _loc1_[_loc6_];
                  _loc8_ = GRID.FromISO(_loc7_.x,_loc7_.y);
                  CREATURES.Spawn(_loc3_,MAP._BUILDINGTOPS,MonsterBase.k_sBHVR_PEN,PointInHouse(_loc8_),Math.random() * 360,_loc8_,_loc7_);
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
      
      public static function Update() : void
      {
         if(_open)
         {
            _mc.Update();
         }
      }
      
      public static function Export() : Object
      {
         var _loc2_:String = null;
         var _loc1_:Object = {};
         for(_loc2_ in _creatures)
         {
            _loc1_[_loc2_] = _creatures[_loc2_].Get();
         }
         return _loc1_;
      }
      
      public static function isHousingBuilding(param1:int) : Boolean
      {
         return param1 == 15 || param1 == 128;
      }
      
      public static function AddHouse(param1:BFOUNDATION) : void
      {
         if(BASE._buildingsHousing.indexOf(param1) >= 0)
         {
            return;
         }
         BASE._buildingsHousing.push(param1);
         HousingSpace();
         GLOBAL._bHousing = param1;
      }
      
      public static function RemoveHouse(param1:BFOUNDATION) : void
      {
         var _loc2_:int = int(BASE._buildingsHousing.indexOf(param1));
         if(_loc2_ >= 0)
         {
            BASE._buildingsHousing.splice(_loc2_,1);
         }
         GLOBAL._bHousing = null;
         HousingSpace();
      }
      
      public static function GetHousingCreatures() : Array
      {
         var _loc10_:String = null;
         var _loc11_:Object = null;
         var _loc12_:String = null;
         var _loc13_:Object = null;
         var _loc14_:String = null;
         var _loc15_:Object = null;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Object = CREATURELOCKER.GetCreatures("above");
         var _loc5_:* = !BASE.isInferno();
         if(_loc5_)
         {
            for(_loc10_ in _loc4_)
            {
               _loc11_ = CREATURELOCKER._creatures[_loc10_];
               if(!_loc11_.blocked)
               {
                  _loc11_.id = _loc10_;
                  _loc1_.push(_loc11_);
               }
            }
            _loc1_.sortOn(["index"],Array.NUMERIC);
         }
         var _loc6_:Object = CREATURELOCKER.GetCreatures("inferno");
         var _loc7_:Boolean = MAPROOM_DESCENT.DescentPassed;
         if(_loc7_)
         {
            for(_loc12_ in _loc6_)
            {
               _loc13_ = CREATURELOCKER._creatures[_loc12_];
               if(!_loc13_.blocked)
               {
                  _loc13_.id = _loc12_;
                  _loc2_.push(_loc13_);
               }
            }
            _loc2_.sortOn(["index"],Array.NUMERIC);
         }
         if(_loc1_.length > 0)
         {
            _loc3_ = _loc3_.concat(_loc1_);
         }
         if(_loc2_.length > 0)
         {
            _loc3_ = _loc3_.concat(_loc2_);
         }
         var _loc8_:Array = [];
         var _loc9_:int = 0;
         while(_loc9_ < _loc3_.length)
         {
            for(_loc14_ in _creatures)
            {
               if(_loc14_ == _loc3_[_loc9_].id)
               {
                  if(_creatures[_loc14_].Get() > 0)
                  {
                     _loc15_ = _loc3_[_loc9_];
                     _loc15_.quantity = _creatures[_loc14_];
                     _loc8_.push(_loc15_);
                  }
               }
            }
            _loc9_++;
         }
         return _loc8_;
      }
   }
}

