package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class PLANNERPOPUP extends PLANNERPOPUP_CLIP
   {
      public var _thumbnailsMC:*;
      
      public var _buildingInfoMC:*;
      
      public var _windowRect:Rectangle = new Rectangle(35,65,565,425);
      
      public var _dragPoint:Point;
      
      public var _dragOffset:Point;
      
      public var _dragging:Boolean = false;
      
      public var _dragged:Boolean = false;
      
      public var _buildings:*;
      
      public var _ranges:*;
      
      public var _zoom:Number = 0.3;
      
      public var _toggleRanges:Boolean = false;
      
      private var _guidePage:int = 1;
      
      public function PLANNERPOPUP()
      {
         super();
         tName.visible = false;
         mcNameBG.visible = false;
         tName.autoSize = "left";
         this._buildings = mcMap.addChild(new MovieClip());
         this._ranges = mcMap.addChild(new MovieClip());
         this._buildings.mouseEnabled = false;
         this._ranges.mouseEnabled = false;
         this._ranges.visible = false;
         this.Setup();
         title_txt.text = KEYS.Get("planner_title");
      }
      
      public function Setup() : *
      {
         var _loc1_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:BFOUNDATION = null;
         mcMap.x = this._windowRect.x + this._windowRect.width / 2;
         mcMap.y = this._windowRect.y + this._windowRect.height / 2;
         addEventListener(MouseEvent.MOUSE_DOWN,this.DragStart);
         addEventListener(MouseEvent.MOUSE_UP,this.DragStop);
         mcMap.scaleX = mcMap.scaleY = this._zoom;
         for each(_loc3_ in BASE._buildingsMushrooms)
         {
            _loc1_ = this._buildings.addChild(new plannerBuilding(_loc3_,this._ranges));
         }
         for each(_loc4_ in BASE._buildingsAll)
         {
            _loc1_ = this._buildings.addChild(new plannerBuilding(_loc4_,this._ranges));
         }
         bZoom1.SetupKey("planner_zoomout_btn");
         bZoom1.addEventListener(MouseEvent.CLICK,this.ToggleZoom);
         bZoom1.Enabled = false;
         bZoom2.SetupKey("planner_zoomin_btn");
         bZoom2.addEventListener(MouseEvent.CLICK,this.ToggleZoom);
         bRanges.SetupKey("planner_showranges_btn");
         bRanges.addEventListener(MouseEvent.CLICK,this.ToggleRanges);
         bExpand.SetupKey("planner_expand_btn");
         if(!BASE._isOutpost)
         {
            bExpand.addEventListener(MouseEvent.CLICK,STORE.Show(1,1,["ENL"]));
            bExpand.visible = true;
         }
         else
         {
            bExpand.visible = false;
         }
         if(Boolean(STORE._storeData.ENL) && STORE._storeData.ENL.q == 5)
         {
            bExpand.Enabled = false;
         }
         var _loc5_:int = 1;
         if(STORE._storeData.ENL)
         {
            _loc5_ = STORE._storeData.ENL.q + 1;
         }
         var _loc6_:int = _loc5_ + 2;
         while(_loc6_ < 7)
         {
            mcMap["mc" + _loc6_].visible = false;
            _loc6_++;
         }
         _loc6_ = 1;
         while(_loc6_ < _loc5_)
         {
            mcMap["mc" + _loc6_].visible = false;
            _loc6_++;
         }
         if(_loc5_ < 6)
         {
            mcMap["mc" + (_loc5_ + 1)].alpha = 0.5;
         }
      }
      
      public function Remove() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._buildings.numChildren)
         {
            this._buildings.getChildAt(_loc1_).Remove();
            _loc1_++;
         }
      }
      
      public function DragStart(param1:MouseEvent = null) : *
      {
         this._dragging = true;
         this._dragged = false;
         this._dragOffset = new Point(mcMap.x - mouseX,mcMap.y - mouseY);
         this._dragPoint = new Point(mcMap.x,mcMap.y);
         this.addEventListener(Event.ENTER_FRAME,this.Drag);
      }
      
      public function Drag(param1:Event = null) : *
      {
         if(Math.abs(mcMap.x - (mouseX + this._dragOffset.x)) > 10 || Math.abs(mcMap.y - (mouseY + this._dragOffset.y)) > 10)
         {
            mcMap.x = int((mouseX + this._dragOffset.x) / 10) * 10;
            mcMap.y = int((mouseY + this._dragOffset.y) / 10) * 10;
            this._dragged = true;
            this.Bounds();
         }
      }
      
      public function Bounds() : *
      {
         if(GLOBAL._mapWidth * this._zoom > this._windowRect.width)
         {
            if(mcMap.x + GLOBAL._mapWidth * 1.2 * this._zoom / 2 < this._windowRect.width + this._windowRect.x)
            {
               mcMap.x = this._windowRect.width + this._windowRect.x - GLOBAL._mapWidth * 1.2 * this._zoom / 2;
            }
            if(mcMap.y + GLOBAL._mapHeight * 1.2 * this._zoom / 2 < this._windowRect.height + this._windowRect.y)
            {
               mcMap.y = this._windowRect.height + this._windowRect.y - GLOBAL._mapHeight * 1.2 * this._zoom / 2;
            }
            if(mcMap.x - GLOBAL._mapWidth * 1.2 * this._zoom / 2 > this._windowRect.x)
            {
               mcMap.x = this._windowRect.x + GLOBAL._mapWidth * 1.2 * this._zoom / 2;
            }
            if(mcMap.y - GLOBAL._mapHeight * 1.2 * this._zoom / 2 > this._windowRect.y)
            {
               mcMap.y = this._windowRect.y + GLOBAL._mapHeight * 1.2 * this._zoom / 2;
            }
         }
         else
         {
            mcMap.x = this._windowRect.x + this._windowRect.width / 2;
            mcMap.y = this._windowRect.y + this._windowRect.height / 2;
         }
      }
      
      public function DragStop(param1:MouseEvent = null) : *
      {
         this._dragging = false;
         this.removeEventListener(Event.ENTER_FRAME,this.Drag);
      }
      
      public function ToggleRanges(param1:MouseEvent = null) : *
      {
         if(this._toggleRanges)
         {
            this._toggleRanges = false;
            bRanges.SetupKey("planner_showranges_btn");
         }
         else
         {
            this._toggleRanges = true;
            bRanges.SetupKey("planner_hideranges_btn");
         }
         this._ranges.visible = this._toggleRanges;
      }
      
      public function ToggleZoom(param1:MouseEvent = null) : *
      {
         if(param1.target.labelKey == "planner_zoomout_btn")
         {
            if(this._zoom == 0.75)
            {
               this._zoom = 0.3;
            }
            if(this._zoom == 1.2)
            {
               this._zoom = 0.75;
            }
         }
         else
         {
            if(this._zoom == 0.75)
            {
               this._zoom = 1.2;
            }
            if(this._zoom == 0.3)
            {
               this._zoom = 0.75;
            }
         }
         if(this._zoom == 1.2)
         {
            bZoom2.Enabled = false;
         }
         else
         {
            bZoom2.Enabled = true;
         }
         if(this._zoom == 0.3)
         {
            bZoom1.Enabled = false;
         }
         else
         {
            bZoom1.Enabled = true;
         }
         mcMap.scaleX = mcMap.scaleY = this._zoom;
         this.Bounds();
      }
      
      private function Help(param1:MouseEvent) : void
      {
         this._guidePage += 1;
         if(this._guidePage > 6)
         {
            this._guidePage = 1;
         }
         this.gotoAndStop(this._guidePage);
         if(this._guidePage > 1)
         {
            this.txtGuide.htmlText = KEYS.Get("planner_tut_" + (this._guidePage - 1));
            if(this._guidePage == 2)
            {
               this.bContinue.addEventListener(MouseEvent.CLICK,this.Help);
               this.bContinue.SetupKey("btn_continue");
            }
         }
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         PLANNER.Hide();
      }
      
      public function Resize() : void
      {
         this.x = 0;
         this.y = 0;
      }
   }
}

