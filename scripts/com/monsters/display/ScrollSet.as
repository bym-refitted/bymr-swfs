package com.monsters.display
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import gs.TweenLite;
   
   public class ScrollSet extends ScrollSet_CLIP
   {
      private var shell:Sprite;
      
      private var _mask:MovieClip;
      
      private var offsetY:Number = 0;
      
      public var dragging:Boolean = false;
      
      public var easing:Number = 1;
      
      public var margin:int = 3;
      
      public var autoHide:Boolean = false;
      
      public var thresh:Number = 0.05;
      
      public var bottomPadding:uint = 0;
      
      private var _hardObjectHeight:int;
      
      private var initialized:Boolean = false;
      
      private var _minScrollHeight:int;
      
      private var _scrollbarHeight:int;
      
      public var updateCallback:Function;
      
      public function ScrollSet()
      {
         super();
      }
      
      public function initWith(param1:Sprite, param2:MovieClip, param3:Number = 0, param4:uint = 315, param5:int = 60) : void
      {
         this._scrollbarHeight = param4;
         this._minScrollHeight = param5;
         this.shell = param1;
         this._mask = param2;
         this.offsetY = param3;
         bg_mc.height = param4;
         scroller_mc.y = this.margin;
         scroller_mc.addEventListener(MouseEvent.MOUSE_DOWN,this.scrollerDown);
         scroller_mc.useHandCursor = true;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.Show);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.Hide);
         if(param1.height < param2.height)
         {
            if(this.parent)
            {
               parent.removeChild(this);
            }
         }
         this.update();
         this.initialized = true;
      }
      
      public function set hardObjectHeight(param1:Number) : void
      {
         this._hardObjectHeight = param1;
         this.onDrag(null);
      }
      
      public function update() : void
      {
         var _loc1_:* = this._mask.height / this.shell.height;
         _loc1_ = Math.min(_loc1_,1);
         var _loc2_:int = bg_mc.height * _loc1_;
         scroller_mc.height = _loc2_ < this._minScrollHeight ? this._minScrollHeight : _loc2_;
         scroller_mc.height = Math.min(scroller_mc.height,this._scrollbarHeight);
         this._hardObjectHeight = this.shell.height;
      }
      
      private function scrollerDown(param1:MouseEvent) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageUp);
         var _loc2_:Rectangle = new Rectangle(scroller_mc.x,bg_mc.y + this.margin,0,bg_mc.height - scroller_mc.height - 2 * this.margin);
         scroller_mc.startDrag(false,_loc2_);
         addEventListener(Event.ENTER_FRAME,this.onDrag);
         this.dragging = true;
      }
      
      private function onDrag(param1:Event = null) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Number = (this.margin + scroller_mc.y) / (bg_mc.height - scroller_mc.height - this.margin);
         if(_loc2_ < this.thresh)
         {
            _loc2_ = 0;
         }
         if(_loc2_ > 1 - this.thresh)
         {
            _loc2_ = 1;
         }
         var _loc3_:Number = this.offsetY - _loc2_ * (this._hardObjectHeight - this._mask.height + this.bottomPadding);
         if(this.easing != 0)
         {
            _loc4_ = this.shell.y - (this.shell.y - _loc3_) / this.easing;
            this.shell.y = int(_loc4_);
         }
         else
         {
            this.shell.y = int(_loc3_);
         }
         if(this.updateCallback != null)
         {
            this.updateCallback();
         }
      }
      
      private function onStageUp(param1:MouseEvent) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onDrag);
         scroller_mc.stopDrag();
         this.dragging = false;
      }
      
      public function isChildVisible(param1:DisplayObject) : Boolean
      {
         var _loc2_:int = param1.y + param1.parent.y;
         if(_loc2_ > this._mask.y && _loc2_ < this._mask.y + this._mask.height)
         {
            return true;
         }
         return false;
      }
      
      public function Show(param1:MouseEvent = null) : void
      {
         TweenLite.to(this,0.3,{"alpha":1});
      }
      
      public function Hide(param1:MouseEvent = null) : void
      {
         if(!this.dragging && this.autoHide)
         {
            TweenLite.to(this,0.3,{"alpha":0.2});
         }
      }
      
      public function scrollTo(param1:Number, param2:Number = 0.5) : void
      {
         var tgtY:Number;
         var oldEase:Number = NaN;
         var pctY:Number = param1;
         var time:Number = param2;
         if(!this.initialized)
         {
            return;
         }
         TweenLite.killTweensOf(scroller_mc);
         oldEase = this.easing;
         this.easing = 1;
         tgtY = pctY * (bg_mc.height - scroller_mc.height - 2 * this.margin) + this.margin;
         if(time == 0)
         {
            scroller_mc.y = tgtY;
            this.onDrag();
         }
         else
         {
            TweenLite.to(scroller_mc,time,{
               "y":tgtY,
               "onUpdate":this.onDrag,
               "onComplete":function():*
               {
                  easing = oldEase;
               }
            });
         }
      }
   }
}

