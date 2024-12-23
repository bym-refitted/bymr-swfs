package com.monsters.maproom3.data
{
   import com.monsters.enums.EnumYardType;
   import com.monsters.maproom3.MapRoom3;
   import com.monsters.maproom3.MapRoom3Cell;
   import com.monsters.maproom3.bookmarks.Bookmark;
   import com.monsters.maproom3.tiles.MapRoom3TileSetManager;
   import com.monsters.maproom_manager.IMapRoomCell;
   import com.monsters.maproom_manager.MapRoomManager;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class MapRoom3Data
   {
      private static const CELL_LOAD_BUFFER_X:int = 30;
      
      private static const CELL_LOAD_BUFFER_Y:int = 30;
      
      private static const MAX_CELLS_TO_REQUEST:int = 500;
      
      private static const DEFAULT_CELL_EXPIRIY_TIME:int = 2 * 60 * 1000;
      
      private static const PLAYER_CELL_EXPIRIY_TIME:int = 500 * 60;
      
      private static const CELL_CREATION_LOOP_TIMEOUT:int = 25;
      
      public static var DEBUG_WORLD_ID:int = 0;
      
      private var m_Width:int;
      
      private var m_Height:int;
      
      private var m_BorderCell:MapRoom3Cell;
      
      private var m_MapRoom3Cells:Vector.<MapRoom3Cell>;
      
      private var m_PlayerOwnedCells:Vector.<IMapRoomCell>;
      
      private var m_AllianceDataById:Dictionary = new Dictionary();
      
      private var m_PendingCellDataRequest:Object = null;
      
      private var m_ExpiryTimeByCellId:Dictionary = new Dictionary();
      
      private var m_CreatingMapData:Object = null;
      
      private var m_CellCreationIndexX:int = -1;
      
      private var m_CellCreationIndexY:int = -1;
      
      private var m_InitialCellData:Object = null;
      
      private var m_InitialPlayerCellData:Object = null;
      
      private var m_InitialCentrePoint:Point = null;
      
      public function MapRoom3Data(param1:Object = null)
      {
         super();
         if(param1 == null)
         {
            param1 = GenerateDefaultMapData();
         }
         this.m_Width = param1.width;
         this.m_Height = param1.height;
         this.m_BorderCell = new MapRoom3Cell(0,0,MapRoom3TileSetManager.BORDER_CELL_HEIGHT,EnumYardType.BORDER);
         var _loc2_:int = this.m_Width * this.m_Height;
         this.m_MapRoom3Cells = new Vector.<MapRoom3Cell>(_loc2_);
         this.m_PlayerOwnedCells = new Vector.<IMapRoomCell>();
         this.m_CreatingMapData = param1;
         this.m_CellCreationIndexX = 0;
         this.m_CellCreationIndexY = 0;
         this.UpdateCellCreation();
      }
      
      public static function GetCellsRequestURL() : String
      {
         return MapRoomManager.instance.mapRoom3URL + "getcells";
      }
      
      private static function GenerateDefaultMapData() : Object
      {
         var _loc4_:int = 0;
         var _loc2_:Object = {};
         _loc2_.width = 500;
         _loc2_.height = 500;
         _loc2_.data = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < 500)
         {
            _loc4_ = 0;
            while(_loc4_ < 500)
            {
               _loc2_.data.push({
                  "h":0,
                  "t":EnumYardType.EMPTY
               });
               _loc4_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get mapWidth() : Number
      {
         return this.m_Width;
      }
      
      public function get mapHeight() : Number
      {
         return this.m_Height;
      }
      
      public function get playerOwnedCells() : Vector.<IMapRoomCell>
      {
         return this.m_PlayerOwnedCells;
      }
      
      public function get homeCell() : IMapRoomCell
      {
         return Boolean(this.m_PlayerOwnedCells) && Boolean(this.m_PlayerOwnedCells.length) ? this.m_PlayerOwnedCells[0] : null;
      }
      
      public function get allianceDataById() : Dictionary
      {
         return this.m_AllianceDataById;
      }
      
      public function get areAllCellsCreated() : Boolean
      {
         return this.m_CreatingMapData == null;
      }
      
      public function get isInitialCellDataLoaded() : Boolean
      {
         return this.m_InitialCellData != null && this.m_InitialPlayerCellData != null;
      }
      
      public function UpdateCellCreation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         if(this.areAllCellsCreated == true)
         {
            return;
         }
         var _loc3_:int = getTimer();
         this.m_CellCreationIndexX;
         while(this.m_CellCreationIndexX < this.m_Width)
         {
            this.m_CellCreationIndexY;
            while(this.m_CellCreationIndexY < this.m_Height)
            {
               _loc1_ = this.GetCellIndex(this.m_CellCreationIndexX,this.m_CellCreationIndexY);
               _loc2_ = this.m_CreatingMapData.data[_loc1_];
               this.m_MapRoom3Cells[_loc1_] = new MapRoom3Cell(this.m_CellCreationIndexX,this.m_CellCreationIndexY,_loc2_.h,_loc2_.t);
               if(getTimer() - _loc3_ > CELL_CREATION_LOOP_TIMEOUT)
               {
                  return;
               }
               ++this.m_CellCreationIndexY;
            }
            this.m_CellCreationIndexY = 0;
            ++this.m_CellCreationIndexX;
         }
         this.m_CreatingMapData = null;
      }
      
      public function LoadInitialCellData(param1:Point) : void
      {
         var _loc3_:* = 0;
         var _loc4_:Number = 0;
         if(this.areAllCellsCreated)
         {
            _loc3_ = this.m_MapRoom3Cells.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this.m_MapRoom3Cells[_loc4_].ClearData();
               _loc4_++;
            }
            this.m_PlayerOwnedCells.length = 0;
         }
         this.m_InitialCentrePoint = param1;
         var _loc2_:Array = [];
         if(DEBUG_WORLD_ID)
         {
            _loc2_.push(["worldid",DEBUG_WORLD_ID]);
         }
         new URLLoaderApi().load(MapRoomManager.instance.mapRoom3URL + "initworldmap",_loc2_,this.OnInitialPlayerCellDataLoaded);
      }
      
      private function OnInitialPlayerCellDataLoaded(param1:Object) : void
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         this.m_InitialPlayerCellData = param1;
         if(this.m_InitialCentrePoint == null)
         {
            this.m_InitialCentrePoint = new Point(param1.celldata[0].x,param1.celldata[0].y);
         }
         var _loc2_:Array = [];
         var _loc3_:int = Math.max(0,this.m_InitialCentrePoint.x - CELL_LOAD_BUFFER_X);
         var _loc4_:int = Math.min(this.m_Width,this.m_InitialCentrePoint.x + CELL_LOAD_BUFFER_Y + 1);
         var _loc5_:int = Math.max(0,this.m_InitialCentrePoint.y - CELL_LOAD_BUFFER_Y);
         var _loc6_:int = Math.min(this.m_Height,this.m_InitialCentrePoint.y + CELL_LOAD_BUFFER_Y + 1);
         var _loc7_:int = _loc3_;
         while(_loc7_ < _loc4_)
         {
            _loc9_ = _loc5_;
            while(_loc9_ < _loc6_)
            {
               _loc10_ = MapRoomManager.instance.CalculateCellId(_loc7_,_loc9_);
               _loc2_.push(_loc10_);
               _loc9_++;
            }
            _loc7_++;
         }
         var _loc8_:Array = [["cellids",JSON.encode(_loc2_)]];
         if(DEBUG_WORLD_ID)
         {
            _loc8_.push(["worldid",DEBUG_WORLD_ID]);
         }
         new URLLoaderApi().load(GetCellsRequestURL(),_loc8_,this.OnInitialCellDataLoaded);
      }
      
      private function OnInitialCellDataLoaded(param1:Object) : void
      {
         this.m_InitialCellData = param1;
      }
      
      public function ParseInitialCellData() : void
      {
         if(this.m_InitialPlayerCellData != null)
         {
            this.ParseCellData(this.m_InitialPlayerCellData);
         }
         if(this.m_InitialCellData != null)
         {
            this.ParseCellData(this.m_InitialCellData);
         }
      }
      
      private function GetCellIndex(param1:int, param2:int) : int
      {
         return param1 < 0 || param2 < 0 || param1 >= this.m_Width || param2 >= this.m_Height ? -1 : param2 * this.m_Width + param1;
      }
      
      public function GetMapRoom3Cell(param1:int, param2:int) : MapRoom3Cell
      {
         var _loc3_:int = this.GetCellIndex(param1,param2);
         if(_loc3_ != -1 && this.m_MapRoom3Cells.length > _loc3_)
         {
            return this.m_MapRoom3Cells[_loc3_];
         }
         return this.m_BorderCell;
      }
      
      public function Clear() : void
      {
         this.m_PendingCellDataRequest = null;
         this.m_InitialCellData = null;
         this.m_InitialPlayerCellData = null;
         this.m_InitialCentrePoint = null;
         this.m_ExpiryTimeByCellId = new Dictionary();
         this.m_AllianceDataById = new Dictionary();
      }
      
      public function LoadBookmarkedCells(param1:Vector.<Bookmark>) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(this.m_PendingCellDataRequest != null)
         {
            return;
         }
         var _loc2_:Array = [];
         var _loc3_:int = getTimer();
         var _loc4_:int = int(param1.length);
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1[_loc5_].cellX;
            _loc8_ = param1[_loc5_].cellY;
            if(!(_loc7_ < 0 || _loc7_ >= this.m_Width || _loc8_ < 0 || _loc8_ >= this.m_Height))
            {
               _loc9_ = MapRoomManager.instance.CalculateCellId(_loc7_,_loc8_);
               if(!(this.m_ExpiryTimeByCellId[_loc9_] != null && (this.m_ExpiryTimeByCellId[_loc9_] == -1 || _loc3_ < this.m_ExpiryTimeByCellId[_loc9_])))
               {
                  this.m_ExpiryTimeByCellId[_loc9_] = -1;
                  _loc2_.push(_loc9_);
                  if(_loc2_.length >= MAX_CELLS_TO_REQUEST)
                  {
                     break;
                  }
               }
            }
            _loc5_++;
         }
         if(_loc2_.length == 0)
         {
            return;
         }
         var _loc6_:Array = [["cellids",JSON.encode(_loc2_)]];
         if(DEBUG_WORLD_ID)
         {
            _loc6_.push(["worldid",DEBUG_WORLD_ID]);
         }
         this.m_PendingCellDataRequest = _loc6_;
         new URLLoaderApi().load(GetCellsRequestURL(),_loc6_,this.OnCellDataLoaded);
      }
      
      public function UpdateCellLoading(param1:Point) : void
      {
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         if(this.m_PendingCellDataRequest != null)
         {
            return;
         }
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = -1;
         var _loc7_:int = param1.x;
         var _loc8_:int = param1.y;
         var _loc9_:int = getTimer();
         var _loc10_:int = CELL_LOAD_BUFFER_X * CELL_LOAD_BUFFER_Y * 4;
         var _loc11_:Number = 0;
         while(_loc11_ < _loc10_)
         {
            _loc13_ = _loc7_ + _loc3_;
            _loc14_ = _loc8_ + _loc4_;
            if(_loc3_ == _loc4_ || _loc3_ < 0 && _loc3_ == -_loc4_ || _loc3_ > 0 && _loc3_ == 1 - _loc4_)
            {
               _loc16_ = _loc5_;
               _loc5_ = -_loc6_;
               _loc6_ = _loc16_;
            }
            _loc3_ += _loc5_;
            _loc4_ += _loc6_;
            if(!(_loc13_ < 0 || _loc13_ >= this.m_Width || _loc14_ < 0 || _loc14_ >= this.m_Height))
            {
               _loc15_ = MapRoomManager.instance.CalculateCellId(_loc13_,_loc14_);
               if(!(this.m_ExpiryTimeByCellId[_loc15_] != null && (this.m_ExpiryTimeByCellId[_loc15_] == -1 || _loc9_ < this.m_ExpiryTimeByCellId[_loc15_])))
               {
                  this.m_ExpiryTimeByCellId[_loc15_] = -1;
                  _loc2_.push(_loc15_);
                  if(_loc2_.length >= MAX_CELLS_TO_REQUEST)
                  {
                     break;
                  }
               }
            }
            _loc11_++;
         }
         if(_loc2_.length == 0)
         {
            return;
         }
         var _loc12_:Array = [["cellids",JSON.encode(_loc2_)]];
         if(DEBUG_WORLD_ID)
         {
            _loc12_.push(["worldid",DEBUG_WORLD_ID]);
         }
         this.m_PendingCellDataRequest = _loc12_;
         new URLLoaderApi().load(GetCellsRequestURL(),_loc12_,this.OnCellDataLoaded);
      }
      
      private function OnCellDataLoaded(param1:Object) : void
      {
         if(this.m_PendingCellDataRequest == null)
         {
            return;
         }
         this.m_PendingCellDataRequest = null;
         this.ParseCellData(param1);
      }
      
      private function ParseCellData(param1:Object) : void
      {
         var _loc2_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:MapRoom3Cell = null;
         var _loc8_:int = 0;
         _loc2_ = param1.celldata;
         var _loc3_:int = getTimer();
         var _loc4_:uint = _loc2_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc2_[_loc5_];
            _loc7_ = this.GetMapRoom3Cell(_loc6_.x,_loc6_.y);
            _loc7_.Setup(_loc6_);
            _loc8_ = MapRoomManager.instance.CalculateCellId(_loc7_.cellX,_loc7_.cellY);
            this.m_ExpiryTimeByCellId[_loc8_] = _loc3_ + DEFAULT_CELL_EXPIRIY_TIME;
            if(_loc7_.isOwnedByPlayer)
            {
               this.m_ExpiryTimeByCellId[_loc8_] = _loc3_ + PLAYER_CELL_EXPIRIY_TIME;
               this.UpdateCellsInAttackRange(_loc7_);
               if(this.m_PlayerOwnedCells.indexOf(_loc7_) == -1)
               {
                  this.m_PlayerOwnedCells.push(_loc7_);
               }
            }
            if(_loc7_.cellType == EnumYardType.STRONGHOLD)
            {
               this.UpdateCellsInStrongholdRange(_loc7_);
            }
            _loc5_++;
         }
         if(param1.alliancedata != null)
         {
            this.OnAllianceDataLoaded(param1.alliancedata);
         }
         if(MapRoom3.mapRoom3Window != null)
         {
            MapRoom3.mapRoom3Window.Refresh();
         }
      }
      
      private function UpdateCellsInAttackRange(param1:MapRoom3Cell) : void
      {
         var _loc2_:MapRoom3Cell = null;
         var _loc3_:Vector.<MapRoom3Cell> = null;
         _loc3_ = this.GetHexCellsInRange(param1,param1.attackRange);
         var _loc4_:uint = _loc3_.length;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc5_];
            param1.AddCellInAttackRange(_loc2_);
            _loc2_.AddInAttackRangeOf(param1);
            _loc5_++;
         }
      }
      
      private function UpdateCellsInStrongholdRange(param1:MapRoom3Cell) : void
      {
         var _loc2_:MapRoom3Cell = null;
         var _loc3_:Vector.<MapRoom3Cell> = null;
         _loc3_ = this.GetHexCellsInRange(param1,param1.attackRange);
         var _loc4_:uint = _loc3_.length;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc5_];
            _loc2_.AddInRangeOfStronghold(param1);
            _loc5_++;
         }
      }
      
      private function OnAllianceDataLoaded(param1:Array) : void
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc2_:uint = param1.length;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = int(_loc4_.alliance_id);
            if(this.m_AllianceDataById[_loc5_] != null)
            {
               this.m_AllianceDataById[_loc5_].Map(_loc4_);
            }
            else
            {
               this.m_AllianceDataById[_loc5_] = new MapRoom3AllianceData(_loc4_);
            }
            _loc3_++;
         }
      }
      
      public function GetHexCellsInRange(param1:MapRoom3Cell, param2:int) : Vector.<MapRoom3Cell>
      {
         var _loc3_:MapRoom3Cell = null;
         var _loc12_:int = 0;
         var _loc4_:Vector.<MapRoom3Cell> = new Vector.<MapRoom3Cell>();
         var _loc5_:int = param1.cellX;
         var _loc6_:int = param1.cellY;
         var _loc7_:int = _loc5_ - (!!(_loc6_ % 2) ? Math.floor(Number(param2) * 0.5) : Math.ceil(Number(param2) * 0.5));
         var _loc8_:int = _loc7_ + param2;
         var _loc9_:int = _loc6_ - param2;
         var _loc10_:int = _loc6_ + param2;
         var _loc11_:int = _loc9_;
         while(_loc11_ <= _loc10_)
         {
            _loc12_ = _loc7_;
            while(_loc12_ <= _loc8_)
            {
               _loc3_ = this.GetMapRoom3Cell(_loc12_,_loc11_);
               if(_loc3_ != null && _loc3_ != this.m_BorderCell)
               {
                  _loc4_.push(_loc3_);
               }
               _loc12_++;
            }
            if(_loc11_ < _loc6_)
            {
               if(_loc11_ % 2)
               {
                  _loc8_++;
               }
               else
               {
                  _loc7_--;
               }
            }
            else if(_loc11_ % 2)
            {
               _loc7_++;
            }
            else
            {
               _loc8_--;
            }
            _loc11_++;
         }
         return _loc4_;
      }
   }
}

