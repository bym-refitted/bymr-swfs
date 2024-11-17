package com.monsters.pathing
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class PATHING extends MovieClip
   {
      internal static var _poolPathing:Vector.<PATHINGobject>;
      
      internal static var _poolPathingB:Vector.<PATHINGobject>;
      
      internal static var _poolPathingLength:int;
      
      public static var floodDisplay:DisplayObject;
      
      public static var floodBMD:BitmapData;
      
      public static var costDisplay:DisplayObject;
      
      public static var costBMD:BitmapData;
      
      public static var pathmc:DisplayObject;
      
      internal static const PI:Number = Math.PI;
      
      internal static const c180PI:Number = 180 / PI;
      
      internal static const cPI180:Number = PI / 180;
      
      internal static var _gridWidth:int = 164;
      
      internal static var _gridHeight:int = 132;
      
      internal static var _floods:Object = {};
      
      internal static var _costs:Object = {};
      
      internal static var _framenumber:int = 0;
      
      internal static var _clicked:Boolean = false;
      
      internal static var _resetRequested:Boolean = false;
      
      public function PATHING()
      {
         super();
      }
      
      public static function Setup() : *
      {
         var _loc2_:PATHINGobject = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = getTimer();
         _loc4_ = 0;
         while(_loc4_ < _gridWidth)
         {
            _loc5_ = 0;
            while(_loc5_ < _gridHeight)
            {
               _loc3_ = _loc4_ * 1000 + _loc5_;
               _loc2_ = new PATHINGobject();
               _loc2_.pointX = _loc4_;
               _loc2_.pointY = _loc5_;
               _loc2_.cost = 10;
               _costs[_loc3_] = _loc2_;
               _loc5_ += 1;
            }
            _loc4_ += 1;
         }
         _poolPathing = new Vector.<PATHINGobject>();
         _poolPathingB = new Vector.<PATHINGobject>();
         _poolPathingLength = 0;
      }
      
      public static function Cost(param1:Point, param2:Rectangle, param3:int) : *
      {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Rectangle = null;
         var _loc10_:int = 0;
         _loc4_ = FromISO(param1);
         _loc4_.x += param2.x;
         _loc4_.y += param2.y;
         _loc5_ = GlobalLocal(_loc4_);
         _loc9_ = new Rectangle(_loc5_.x,_loc5_.y,param2.width * 0.1,param2.height * 0.1);
         _loc7_ = _loc9_.x;
         while(_loc7_ < _loc9_.x + _loc9_.width)
         {
            _loc8_ = _loc9_.y;
            while(_loc8_ < _loc9_.y + _loc9_.height)
            {
               _loc6_ = _loc7_ * 1000 + _loc8_;
               if(_costs[_loc6_])
               {
                  _loc10_ = int(_costs[_loc6_].cost);
                  _costs[_loc6_].cost += param3;
                  if(_costs[_loc6_].cost < 2)
                  {
                     _costs[_loc6_].cost = 2;
                  }
               }
               _loc8_ += 1;
            }
            _loc7_ += 1;
         }
         return _loc9_;
      }
      
      public static function RegisterBuilding(param1:Rectangle, param2:BFOUNDATION, param3:Boolean) : *
      {
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc4_ = GlobalLocal(FromISO(new Point(param1.x,param1.y)));
         param1.width *= 0.1;
         param1.height *= 0.1;
         _loc6_ = _loc4_.x;
         while(_loc6_ < _loc4_.x + param1.width)
         {
            _loc7_ = _loc4_.y;
            while(_loc7_ < _loc4_.y + param1.height)
            {
               _loc5_ = _loc6_ * 1000 + _loc7_;
               if(_costs[_loc5_])
               {
                  if(param3)
                  {
                     _costs[_loc5_].building = param2;
                  }
                  else
                  {
                     delete _costs[_loc5_].building;
                  }
               }
               _loc7_ += 1;
            }
            _loc6_ += 1;
         }
      }
      
      public static function Tick() : *
      {
         var _loc5_:Point = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:BFOUNDATION = null;
         var _loc11_:Array = null;
         var _loc1_:int = getTimer();
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_resetRequested)
         {
            _resetRequested = false;
            _loc5_ = new Point(0,0);
            Clear();
            _loc8_ = 0;
            while(_loc8_ < _gridWidth)
            {
               _loc9_ = 0;
               while(_loc9_ < _gridHeight)
               {
                  _costs[_loc8_ * 1000 + _loc9_].cost = 10;
                  _loc9_ += 1;
               }
               _loc8_ += 1;
            }
            _loc2_ = getTimer() - _loc1_;
            for each(_loc10_ in BASE._buildingsAll)
            {
               if(Boolean(_loc10_._gridCost) && _loc10_._hp.Get() > 0)
               {
                  for each(_loc11_ in _loc10_._gridCost)
                  {
                     _loc5_.x = _loc10_.x;
                     _loc5_.y = _loc10_.y;
                     PATHING.Cost(_loc5_,_loc11_[0],_loc11_[1]);
                  }
               }
            }
            _loc3_ = getTimer() - _loc1_;
            for each(_loc10_ in BASE._buildingsMushrooms)
            {
               if(_loc10_._gridCost)
               {
                  for each(_loc11_ in _loc10_._gridCost)
                  {
                     _loc5_.x = _loc10_.x;
                     _loc5_.y = _loc10_.y;
                     PATHING.Cost(_loc5_,_loc11_[0],_loc11_[1]);
                  }
               }
            }
            _loc4_ = getTimer() - _loc1_;
         }
         ProcessFlood();
      }
      
      public static function GetPath(param1:Point, param2:Rectangle, param3:Function = null, param4:Boolean = false, param5:BFOUNDATION = null) : *
      {
         var _loc6_:Point = null;
         var _loc7_:Rectangle = null;
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         _loc9_ = param1;
         _loc10_ = new Point(param2.x,param2.y);
         param1.x = int(param1.x);
         param1.y = int(param1.y);
         param2.x = int(param2.x);
         param2.y = int(param2.y);
         _loc6_ = FromISO(param1);
         _loc8_ = FromISO(new Point(param2.x,param2.y));
         _loc7_ = param2;
         _loc7_.x = _loc8_.x;
         _loc7_.y = _loc8_.y;
         _loc6_ = GlobalLocal(_loc6_);
         _loc8_ = GlobalLocal(new Point(_loc7_.x,_loc7_.y));
         _loc7_.x = int(_loc8_.x);
         _loc7_.y = int(_loc8_.y);
         _loc7_.width *= 0.1;
         _loc7_.height *= 0.1;
         GetPathB(_loc6_,_loc7_,_loc9_,_loc10_,param3,param4,param5);
      }
      
      public static function GetPathB(param1:Point, param2:Rectangle, param3:Point, param4:Point, param5:Function = null, param6:Boolean = false, param7:BFOUNDATION = null) : *
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         var _loc18_:Object = null;
         var _loc19_:Object = null;
         var _loc20_:Object = null;
         var _loc21_:int = 0;
         var _loc22_:PATHINGfloodobject = null;
         var _loc23_:int = 0;
         var _loc24_:* = undefined;
         var _loc25_:* = undefined;
         var _loc26_:* = undefined;
         RenderCosts();
         param1.x = int(param1.x);
         param1.y = int(param1.y);
         param2.x = int(param2.x);
         param2.y = int(param2.y);
         _loc10_ = param1.x * 1000 + param1.y;
         _loc9_ = param2.x * 1000 + param2.y;
         if(!_costs[_loc10_] && !_costs[_loc9_])
         {
            param5([param3,param4],param7);
            RenderPath([param3,param4]);
            return;
         }
         if(!_costs[_loc10_])
         {
            _loc11_ = 90 - Math.atan2(param2.y - param1.y,param2.x - param1.x) * 57.2957795;
            _loc12_ = Math.sin(_loc11_ * 0.0174532925) * 5;
            _loc13_ = Math.cos(_loc11_ * 0.0174532925) * 5;
            _loc14_ = 0;
            while(!_costs[_loc10_] && _loc14_ < 2000)
            {
               _loc14_ += 1;
               param1.x += _loc12_;
               param1.y += _loc13_;
               _loc10_ = int(param1.x) * 1000 + int(param1.y);
            }
            param1.x = int(param1.x);
            param1.y = int(param1.y);
         }
         if(!_costs[_loc9_])
         {
            param5([param3,param4],param7);
            RenderPath([param3,param4]);
            return;
         }
         if(param6)
         {
            _loc9_ += 1000000;
         }
         if(!_floods[_loc9_])
         {
            _loc18_ = {};
            _loc19_ = {};
            _loc20_ = {};
            _loc21_ = 0;
            while(_loc21_ < param2.width)
            {
               _loc23_ = 0;
               while(_loc23_ < param2.height)
               {
                  _loc24_ = new PATHINGobject();
                  _loc24_.pointX = param2.x + _loc21_;
                  _loc24_.pointY = param2.y + _loc23_;
                  _loc24_.depth = 0;
                  _loc18_[param2.x + _loc21_ * 1000 + param2.y + _loc23_] = _loc24_;
                  _loc25_ = new PATHINGobject();
                  _loc25_.pointX = param2.x + _loc21_;
                  _loc25_.pointY = param2.y + _loc23_;
                  _loc25_.depth = 0;
                  _loc19_[param2.x + _loc21_ * 1000 + param2.y + _loc23_] = _loc25_;
                  _loc26_ = new PATHINGobject();
                  _loc26_.pointX = param2.x + _loc21_;
                  _loc26_.pointY = param2.y + _loc23_;
                  _loc26_.depth = 0;
                  _loc20_[param2.x + _loc21_ * 1000 + param2.y + _loc23_] = _loc26_;
                  _loc23_ += 1;
               }
               _loc21_ += 1;
            }
            _loc22_ = new PATHINGfloodobject();
            _loc22_.flood = _loc19_;
            _loc22_.edge = _loc18_;
            _loc22_.start = _loc20_;
            _loc22_.ignoreWalls = param6;
            _floods[_loc9_] = _loc22_;
         }
         if(!_floods[_loc9_].startpoints[_loc10_])
         {
            _floods[_loc9_].startpoints[_loc10_] = {
               "startID":_loc10_,
               "callbackfunctions":[],
               "startPoint":param1
            };
         }
         _floods[_loc9_].startpoints[_loc10_].callbackfunctions.push([param5,param6,param7,param4]);
         _floods[_loc9_].pending += 1;
      }
      
      internal static function ProcessFlood(param1:Event = null) : *
      {
         var edgeSquare:PATHINGobject = null;
         var edgeSquareX:int = 0;
         var edgeSquareY:int = 0;
         var o:PATHINGobject = null;
         var pointID:int = 0;
         var pointX:int = 0;
         var pointY:int = 0;
         var processed:int = 0;
         var newEdge:Object = null;
         var newMinDepth:int = 0;
         var steps:int = 0;
         var loops:int = 0;
         var pendingfloodcount:int = 0;
         var tmpCost:int = 0;
         var flood:PATHINGfloodobject = null;
         var e:Event = param1;
         var t:int = getTimer();
         var tt:int = getTimer();
         for each(flood in _floods)
         {
            if(flood.pending)
            {
               pendingfloodcount += 1;
            }
         }
         loops = 25 / pendingfloodcount;
         if(loops < 5)
         {
            loops = 5;
         }
         for each(flood in _floods)
         {
            if(flood.pending)
            {
               tt = getTimer();
               processed = 0;
               steps = 0;
               while(getTimer() - tt < loops && flood.pending > 0)
               {
                  newEdge = {};
                  newMinDepth = 9999999;
                  flood.edgeLength = 0;
                  for each(edgeSquare in flood.edge)
                  {
                     if(edgeSquare.depth <= flood.minDepth)
                     {
                        edgeSquareX = edgeSquare.pointX;
                        edgeSquareY = edgeSquare.pointY;
                        pointX = edgeSquareX - 1;
                        while(pointX < edgeSquareX + 2)
                        {
                           pointY = edgeSquareY - 1;
                           for(; pointY < edgeSquareY + 2; pointY += 1)
                           {
                              if(!(pointX == edgeSquareX && pointY == edgeSquareY))
                              {
                                 pointID = pointX * 1000 + pointY;
                                 if(!flood.flood[pointID])
                                 {
                                    if(!newEdge[pointID])
                                    {
                                       if(_costs[pointID])
                                       {
                                          try
                                          {
                                             processed += 1;
                                             o = new PATHINGobject();
                                             o.pointX = pointX;
                                             o.pointY = pointY;
                                             tmpCost = int(_costs[pointID].cost);
                                             if(flood.ignoreWalls)
                                             {
                                                if(_costs[pointID].building)
                                                {
                                                   tmpCost = 20;
                                                }
                                             }
                                             if(pointX != edgeSquare.pointX && pointY != edgeSquare.pointY)
                                             {
                                                tmpCost *= 1.5;
                                             }
                                          }
                                          catch(e:Error)
                                          {
                                          }
                                          try
                                          {
                                             o.depth = edgeSquare.depth + tmpCost;
                                             if(o.depth < newMinDepth)
                                             {
                                                newMinDepth = o.depth;
                                             }
                                             newEdge[pointID] = o;
                                             flood.flood[pointID] = o;
                                             flood.edgeLength += 1;
                                             steps += 1;
                                          }
                                          catch(e:Error)
                                          {
                                          }
                                          continue;
                                       }
                                    }
                                 }
                              }
                           }
                           pointX += 1;
                        }
                     }
                     else
                     {
                        newEdge[edgeSquare.pointID] = edgeSquare;
                        flood.edgeLength += 1;
                        if(edgeSquare.depth < newMinDepth)
                        {
                           newMinDepth = edgeSquare.depth;
                        }
                     }
                  }
                  flood.edge = newEdge;
                  flood.minDepth = newMinDepth;
                  CheckStartReached(flood);
               }
            }
         }
      }
      
      private static function CheckStartReached(param1:PATHINGfloodobject) : int
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         for each(_loc3_ in param1.startpoints)
         {
            if(Boolean(_loc3_) && Boolean(param1.flood[_loc3_.startID]))
            {
               for each(_loc4_ in _loc3_.callbackfunctions)
               {
                  Path(param1.flood,_loc3_.startID,_loc4_[0],_loc4_[1],_loc4_[2],_loc4_[3]);
                  --param1.pending;
                  _loc2_ += 1;
               }
               _loc3_.callbackfunctions = [];
               delete param1.startpoints[_loc3_.startID];
            }
         }
         return _loc2_;
      }
      
      public static function Path(param1:Object, param2:int, param3:Function, param4:Boolean = false, param5:BFOUNDATION = null, param6:Point = null) : *
      {
         var pointX:int = 0;
         var pointY:int = 0;
         var tempPointID:int = 0;
         var tempPoint:Point = null;
         var nextDepth:int = 0;
         var nextPointX:int = 0;
         var nextPointY:int = 0;
         var nextPointFound:Boolean = false;
         var building:BFOUNDATION = null;
         var moved:Boolean = false;
         var h:* = undefined;
         var v:* = undefined;
         var extras:int = 0;
         var i:int = 0;
         var otherPoints:Array = null;
         var j:* = undefined;
         var otherPointID:* = undefined;
         var weirdPoint:Point = null;
         var pickOne:int = 0;
         var flood:Object = param1;
         var startID:int = param2;
         var cbf:Function = param3;
         var ignoreWalls:Boolean = param4;
         var targetBuilding:BFOUNDATION = param5;
         var targetPoint:Point = param6;
         var t:int = getTimer();
         var waypoints:Array = [];
         var waypointlength:int = 0;
         try
         {
            pointX = int(flood[startID].pointX);
            pointY = int(flood[startID].pointY);
            nextDepth = int(flood[startID].depth);
            waypoints[waypointlength] = ToISO(LocalGlobal(new Point(pointX,pointY)),0);
            waypointlength += 1;
            moved = true;
         }
         catch(e:Error)
         {
         }
         tempPoint = new Point(0,0);
         while(moved)
         {
            moved = false;
            h = -1;
            while(h < 2)
            {
               v = -1;
               while(v < 2)
               {
                  if(!(h == 0 && v == 0))
                  {
                     tempPoint.x = pointX + h;
                     tempPoint.y = pointY + v;
                     tempPointID = tempPoint.x * 1000 + tempPoint.y;
                     if(flood[tempPointID] && flood[tempPointID].depth < nextDepth && flood[tempPointID].depth > 0)
                     {
                        nextPointX = tempPoint.x;
                        nextPointY = tempPoint.y;
                        nextPointFound = true;
                        nextDepth = int(flood[tempPointID].depth);
                        moved = true;
                        if(!ignoreWalls && waypointlength > 1)
                        {
                           if(_costs[tempPointID])
                           {
                              building = _costs[tempPointID].building;
                              if(building)
                              {
                                 if(building._hp.Get() > 0)
                                 {
                                    extras = (building._lvl.Get() ^ 2) + 1;
                                    i = 0;
                                    while(i < extras)
                                    {
                                       waypoints.push(waypoints[waypoints.length - 1]);
                                       i++;
                                    }
                                    cbf(waypoints,building);
                                    RenderPath(waypoints);
                                    return;
                                 }
                              }
                           }
                        }
                        if(!ignoreWalls && nextDepth < 20)
                        {
                           if(Math.random() < 0.6)
                           {
                              otherPoints = new Array();
                              i = -3;
                              while(i < 4)
                              {
                                 j = -3;
                                 while(j < 4)
                                 {
                                    if(Boolean(i) && j)
                                    {
                                       otherPointID = (nextPointX + i) * 1000 + nextPointY + j;
                                       if(flood[otherPointID])
                                       {
                                          if(flood[otherPointID].depth < 20 && flood[otherPointID].depth > 0)
                                          {
                                             weirdPoint = new Point(nextPointX + i,nextPointY + j);
                                             otherPoints.push(weirdPoint);
                                          }
                                       }
                                    }
                                    j++;
                                 }
                                 i++;
                              }
                              if(otherPoints.length > 0)
                              {
                                 pickOne = int(Math.random() * otherPoints.length);
                                 nextPointX = int(otherPoints[pickOne].x);
                                 nextPointY = int(otherPoints[pickOne].y);
                              }
                           }
                        }
                     }
                  }
                  v += 1;
               }
               h += 1;
            }
            try
            {
               if(nextPointFound)
               {
                  pointX = nextPointX;
                  pointY = nextPointY;
                  waypoints[waypointlength] = ToISO(LocalGlobal(Jiggle(nextPointX,nextPointY)),0);
                  waypointlength += 1;
               }
            }
            catch(e:Error)
            {
            }
         }
         if(targetPoint)
         {
            tempPoint = GlobalLocal(FromISO(targetPoint));
            if(!targetBuilding || !_costs[tempPoint.x * 1000 + tempPoint.y])
            {
               waypoints[waypointlength] = targetPoint;
            }
         }
         RenderFlood();
         RenderPath(waypoints);
         cbf(waypoints,targetBuilding);
      }
      
      private static function Jiggle(param1:int, param2:int) : Point
      {
         return new Point(param1 + (Math.random() - 0.5) * 0.4,param2 + (Math.random() - 0.5) * 0.4);
      }
      
      public static function GetBuildingFromISO(param1:Point) : BFOUNDATION
      {
         var _loc2_:Point = FromISO(param1);
         var _loc3_:Point = GlobalLocal(_loc2_);
         var _loc4_:int = 1000 * int(_loc3_.x) + int(_loc3_.y);
         if(_costs[_loc4_])
         {
            return _costs[_loc4_].building;
         }
         return null;
      }
      
      public static function Clear() : *
      {
         var _loc3_:PATHINGfloodobject = null;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = getTimer();
         for each(_loc3_ in _floods)
         {
            for each(_loc5_ in _loc3_.startpoints)
            {
               if(_loc5_.callbackfunctions)
               {
                  _loc6_ = _loc5_.callbackfunctions;
                  _loc7_ = 0;
                  while(_loc7_ < _loc6_.length)
                  {
                     _loc1_.push(_loc6_[_loc7_][0]);
                     _loc7_++;
                  }
               }
            }
         }
         _floods = {};
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc1_[_loc4_]([],null,true);
            _loc4_++;
         }
      }
      
      public static function Cleanup() : *
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in _costs)
         {
            delete _costs[_loc1_];
         }
         _costs = {};
         _floods = {};
      }
      
      public static function LineOfSight(param1:int, param2:int, param3:int, param4:int, param5:BFOUNDATION = null, param6:Boolean = false) : Boolean
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:BFOUNDATION = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc10_:Point = GlobalLocal(FromISO(new Point(param1,param2)));
         var _loc11_:Point = GlobalLocal(FromISO(new Point(param3,param4)));
         param1 = _loc10_.x;
         param2 = _loc10_.y;
         param3 = _loc11_.x;
         param4 = _loc11_.y;
         var _loc12_:Number = param3 - param1;
         var _loc13_:Number = param4 - param2;
         var _loc14_:Number = Math.atan2(_loc13_,_loc12_) * c180PI;
         var _loc15_:Number = Math.sqrt(_loc12_ * _loc12_ + _loc13_ * _loc13_);
         _loc7_ = 0;
         while(_loc7_ < _loc15_)
         {
            _loc17_ = param1 + Math.cos(_loc14_ * cPI180) * _loc7_;
            _loc18_ = param2 + Math.sin(_loc14_ * cPI180) * _loc7_;
            _loc8_ = _loc17_ * 1000 + _loc18_;
            if(!_costs[_loc8_])
            {
               return true;
            }
            _loc9_ = _costs[_loc8_].building;
            if((Boolean(_loc9_)) && _loc9_._hp.Get() > 0)
            {
               if(!(Boolean(param5) && _loc9_ == param5))
               {
                  if(_loc9_._type == 17 || param6)
                  {
                     return false;
                  }
               }
            }
            _loc7_++;
         }
         return true;
      }
      
      public static function ResetCosts() : *
      {
         _resetRequested = true;
      }
      
      public static function Wander(param1:Point, param2:int = 50, param3:Function = null) : *
      {
         var _loc7_:* = undefined;
         param1.x = int(param1.x);
         param1.y = int(param1.y);
         var _loc4_:Array = [];
         var _loc5_:int = 0 - param2;
         while(_loc5_ < param2)
         {
            if(!GRID.Blocked(param1.add(new Point(_loc5_,0 - param2))))
            {
               _loc4_.push(param1.add(new Point(_loc5_,0 - param2)));
            }
            if(!GRID.Blocked(param1.add(new Point(_loc5_,param2))))
            {
               _loc4_.push(param1.add(new Point(_loc5_,param2)));
            }
            if(!GRID.Blocked(param1.add(new Point(0 - param2,_loc5_))))
            {
               _loc4_.push(param1.add(new Point(0 - param2,_loc5_)));
            }
            if(!GRID.Blocked(param1.add(new Point(param2,_loc5_))))
            {
               _loc4_.push(param1.add(new Point(param2,_loc5_)));
            }
            _loc5_ += 10;
         }
         var _loc6_:Point = param1;
         if(_loc4_.length > 0)
         {
            _loc7_ = _loc4_[int(Math.random() * _loc4_.length)];
            GetPath(param1,new Rectangle(_loc7_.x,_loc7_.y,10,10),param3);
         }
      }
      
      public static function RenderFlood() : *
      {
         if(GLOBAL._catchup)
         {
         }
      }
      
      public static function RenderCosts() : *
      {
      }
      
      public static function RenderPath(param1:*, param2:Boolean = false) : *
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
      
      internal static function GlobalLocal(param1:Point) : Point
      {
         param1.x *= 0.1;
         param1.y *= 0.1;
         param1.x += _gridWidth >> 1;
         param1.y += _gridHeight >> 1;
         param1.x = int(param1.x);
         param1.y = int(param1.y);
         return param1;
      }
      
      public static function LocalGlobal(param1:Point) : Point
      {
         param1.x -= _gridWidth >> 1;
         param1.y -= _gridHeight >> 1;
         param1.x *= 10;
         param1.y *= 10;
         return param1;
      }
      
      public static function ToISO(param1:Point, param2:int) : Point
      {
         var _loc4_:int = (param1.x + param1.y) * 0.5 - param2;
         var _loc5_:int = param1.x - param1.y;
         return new Point(_loc5_,_loc4_);
      }
      
      public static function FromISO(param1:Point) : Point
      {
         var _loc2_:int = param1.y - param1.x * 0.5;
         var _loc3_:int = param1.x * 0.5 + param1.y;
         return new Point(_loc3_,_loc2_);
      }
      
      public static function PlotRandom(param1:MouseEvent) : *
      {
         var Done:Function = null;
         var e:MouseEvent = param1;
         Done = function(param1:Array):*
         {
         };
         var p:Point = ToISO(new Point(260,260),0);
         GetPath(ToISO(new Point(-2000,-2000),0),new Rectangle(p.x,p.y,10,10),Done);
      }
   }
}

