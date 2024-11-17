package
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class GRID
   {
      public static var _gridBuildings:Object;
      
      public static var _floods:Object;
      
      public static var _mapWidth:int;
      
      public static var _mapHeight:int;
      
      public static var _mc:*;
      
      public static var _noiseMC:*;
      
      public static var _gridMC:*;
      
      public static var _floodMC:*;
      
      public static var _linePath:*;
      
      public function GRID()
      {
         super();
      }
      
      public static function CreateGrid() : *
      {
         var _loc2_:GRIDobject = null;
         var _loc4_:int = 0;
         var _loc1_:int = getTimer();
         _mapWidth = 2600;
         _mapHeight = 2600;
         _gridBuildings = {};
         Clear();
         var _loc3_:int = 0;
         while(_loc3_ < _mapWidth / 5)
         {
            _loc4_ = 0;
            while(_loc4_ < _mapHeight / 5)
            {
               _loc2_ = new GRIDobject();
               _loc2_.pointX = _loc3_;
               _loc2_.pointY = _loc4_;
               _loc2_.blocked = 0;
               _loc2_.cost = 10;
               _gridBuildings[_loc3_ + _loc4_ * 10000] = _loc2_;
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public static function Block(param1:Rectangle, param2:Boolean = false) : *
      {
         var _loc5_:Point = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:Point = FromISO(param1.x,param1.y);
         var _loc4_:int = 0;
         if(param2)
         {
            _loc4_ = 1;
         }
         param1.x = _loc3_.x;
         param1.y = _loc3_.y;
         var _loc7_:int = 0;
         while(_loc7_ < param1.width)
         {
            _loc8_ = 0;
            while(_loc8_ < param1.height)
            {
               _loc5_ = GlobalLocal(new Point(_loc7_ + param1.x,_loc8_ + param1.y),5);
               _loc6_ = _loc5_.x + _loc5_.y * 10000;
               if(_gridBuildings[_loc6_])
               {
                  _gridBuildings[_loc6_].blocked = _loc4_;
               }
               _loc8_ += 5;
            }
            _loc7_ += 5;
         }
         Clear();
         RenderGrid();
      }
      
      public static function FindSpace(param1:BFOUNDATION) : *
      {
         var _loc4_:Point = null;
         var _loc9_:int = 0;
         var _loc2_:Rectangle = param1._footprint[0];
         var _loc8_:int = 0;
         while(_loc8_ < 2 * 60)
         {
            _loc9_ = 0;
            while(_loc9_ < 100)
            {
               _loc4_ = ToISO(-(GLOBAL._mapWidth * 0.5) + _loc8_ * 10,-(GLOBAL._mapHeight * 0.5) + _loc9_ * 10,0);
               if(!FootprintBlocked(param1._footprint,_loc4_,true))
               {
                  LOGGER.Log("err","GRID.FindSpace " + _loc8_ + ", " + _loc9_ + ", " + _loc4_.x + ", " + _loc4_.y);
                  param1._mc.x = _loc4_.x;
                  param1._mc.y = _loc4_.y;
                  param1._mcBase.x = _loc4_.x;
                  param1._mcBase.y = _loc4_.y;
                  param1._mcFootprint.x = _loc4_.x;
                  param1._mcFootprint.y = _loc4_.y;
                  param1.GridCost(true);
                  return;
               }
               _loc9_++;
            }
            _loc8_++;
         }
      }
      
      public static function FootprintBlocked(param1:Array, param2:Point, param3:Boolean = false, param4:Boolean = false) : Boolean
      {
         var _loc5_:Rectangle = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         param2 = FromISO(param2.x,param2.y);
         for each(_loc5_ in param1)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.width)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc5_.height)
               {
                  if(Blocked(new Point(_loc6_ + _loc5_.x + param2.x,_loc7_ + _loc5_.y + param2.y),param3,param4) > 0)
                  {
                     return true;
                  }
                  _loc7_ += 5;
               }
               _loc6_ += 5;
            }
         }
         return false;
      }
      
      public static function Blocked(param1:Point, param2:Boolean = false, param3:Boolean = false) : int
      {
         var _loc4_:Point = GlobalLocal(new Point(param1.x,param1.y),5);
         var _loc5_:* = _loc4_.x + _loc4_.y * 10000;
         if(!_gridBuildings[_loc5_])
         {
            return 3;
         }
         var _loc6_:int = GLOBAL._mapWidth * 0.5;
         var _loc7_:int = GLOBAL._mapHeight * 0.5;
         if(param2 && !param3 && (param1.x < 0 - _loc6_ || param1.x >= _loc6_ || param1.y < 0 - _loc7_ || param1.y >= _loc7_))
         {
            return 2;
         }
         return _gridBuildings[_loc5_].blocked;
      }
      
      public static function Clear() : *
      {
         _floods = {};
      }
      
      public static function RenderFlood(param1:Point) : *
      {
      }
      
      public static function RenderGrid() : *
      {
         if(GLOBAL._catchup)
         {
         }
      }
      
      public static function RenderPath(param1:*) : *
      {
      }
      
      public static function getNumberAsHexString(param1:uint, param2:uint = 1, param3:Boolean = true) : *
      {
         var _loc4_:String = param1.toString(16).toUpperCase();
         while(param2 > _loc4_.length)
         {
            _loc4_ = "0" + _loc4_;
         }
         if(param3)
         {
            _loc4_ = "0x" + _loc4_;
         }
         return _loc4_;
      }
      
      public static function GlobalLocal(param1:Point, param2:int) : Point
      {
         var _loc3_:* = int((param1.x + _mapWidth * 0.5) / param2);
         var _loc4_:* = int((param1.y + _mapHeight * 0.5) / param2);
         return new Point(_loc3_,_loc4_);
      }
      
      public static function LocalGlobal(param1:Point, param2:int) : Point
      {
         var _loc3_:* = int(param1.x * param2 - _mapWidth * 0.5) + param2 * 0.5;
         var _loc4_:* = int(param1.y * param2 - _mapHeight * 0.5) + param2 * 0.5;
         return new Point(_loc3_,_loc4_);
      }
      
      public static function ToISO(param1:*, param2:*, param3:*) : *
      {
         var _loc5_:Number = (param1 + param2) * 0.5 - param3;
         var _loc6_:Number = param1 - param2;
         return new Point(_loc6_,_loc5_);
      }
      
      public static function FromISO(param1:*, param2:*) : *
      {
         var _loc3_:Number = param2 - param1 * 0.5;
         var _loc4_:Number = param1 * 0.5 + param2;
         return new Point(_loc4_,_loc3_);
      }
   }
}

