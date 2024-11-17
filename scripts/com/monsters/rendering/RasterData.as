package com.monsters.rendering
{
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.filters.BitmapFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   use namespace monsters_render;
   
   public class RasterData
   {
      monsters_render static var s_needsSort:Boolean;
      
      private static var s_id:uint;
      
      monsters_render static const s_rasterData:Vector.<RasterData> = new Vector.<RasterData>();
      
      monsters_render static const s_visibleData:Vector.<RasterData> = new Vector.<RasterData>();
      
      monsters_render static const s_unsortedData:Vector.<RasterData> = new Vector.<RasterData>();
      
      monsters_render static const s_debugData:Vector.<RasterData> = new Vector.<RasterData>();
      
      monsters_render const _id:uint = s_id++;
      
      monsters_render var _data:IBitmapDrawable;
      
      monsters_render var _pt:Point;
      
      monsters_render var _depth:Number;
      
      monsters_render var _rect:Rectangle;
      
      monsters_render var _blendMode:String;
      
      monsters_render var _filter:BitmapFilter;
      
      monsters_render var _scaleX:int;
      
      monsters_render var _scaleY:int;
      
      monsters_render var _alpha:uint;
      
      monsters_render var _visible:Boolean;
      
      monsters_render var _unSorted:Boolean;
      
      monsters_render var _cleared:Boolean;
      
      public function RasterData(param1:IBitmapDrawable, param2:Point, param3:Number, param4:String = null, param5:Boolean = false)
      {
         super();
         this.data = param1;
         this.monsters_render::_pt = param2;
         this.monsters_render::_depth = param3;
         this.monsters_render::_blendMode = param4;
         this.monsters_render::_scaleX = this.monsters_render::_scaleY = 100;
         this.monsters_render::_alpha = 4278190080;
         this.monsters_render::_visible = true;
         this.monsters_render::_unSorted = param5;
         monsters_render::s_needsSort = this.monsters_render::_unSorted ? monsters_render::s_needsSort : true;
         if(this.monsters_render::_unSorted)
         {
            monsters_render::s_rasterData[monsters_render::s_rasterData.length] = this;
            monsters_render::s_unsortedData[monsters_render::s_unsortedData.length] = this;
         }
         else
         {
            monsters_render::s_rasterData[monsters_render::s_rasterData.length] = this;
            monsters_render::s_visibleData[monsters_render::s_visibleData.length] = this;
         }
      }
      
      public static function get rasterData() : Vector.<RasterData>
      {
         return monsters_render::s_rasterData;
      }
      
      public static function get visibleData() : Vector.<RasterData>
      {
         return monsters_render::s_visibleData;
      }
      
      public static function get totalMemory() : uint
      {
         var _loc1_:* = 0;
         var _loc2_:RasterData = null;
         var _loc3_:BitmapData = null;
         for each(_loc2_ in monsters_render::s_rasterData)
         {
            _loc3_ = _loc2_.monsters_render::_data as BitmapData;
            if(_loc3_)
            {
               _loc1_ += _loc3_.getPixels(_loc3_.rect).length;
            }
         }
         return _loc1_;
      }
      
      monsters_render static function showDebug() : void
      {
         var _loc1_:RasterData = null;
         var _loc2_:BitmapData = null;
         var _loc3_:Shape = null;
         for each(_loc1_ in monsters_render::s_rasterData)
         {
            _loc2_ = _loc1_.monsters_render::_data as BitmapData;
            if(_loc2_)
            {
               _loc3_ = new Shape();
               _loc3_.graphics.lineStyle(1,0xff0000);
               _loc3_.graphics.beginFill(0x990000,0.4);
               _loc3_.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
               monsters_render::s_debugData[monsters_render::s_debugData.length] = new RasterData(_loc3_,_loc1_.monsters_render::_pt,_loc1_.monsters_render::_depth);
            }
         }
      }
      
      monsters_render static function hideDebug() : void
      {
         var _loc1_:RasterData = null;
         for each(_loc1_ in monsters_render::s_debugData)
         {
            _loc1_.clear(true);
         }
         monsters_render::s_debugData.length = 0;
      }
      
      public static function clear(param1:Boolean = false) : void
      {
         var _loc2_:RasterData = null;
         for each(_loc2_ in monsters_render::s_rasterData)
         {
            _loc2_.clear(param1);
         }
         monsters_render::s_unsortedData.length = monsters_render::s_visibleData.length = monsters_render::s_rasterData.length = monsters_render::s_debugData.length = 0;
      }
      
      public function get id() : uint
      {
         return this.monsters_render::_id;
      }
      
      public function get data() : IBitmapDrawable
      {
         return this.monsters_render::_data;
      }
      
      public function set data(param1:IBitmapDrawable) : void
      {
         this.monsters_render::_data = param1;
         switch(true)
         {
            case this.monsters_render::_data is BitmapData:
               this.monsters_render::_rect = (this.monsters_render::_data as BitmapData).rect;
               break;
            case this.monsters_render::_data is MovieClip:
               this.monsters_render::_rect = (this.monsters_render::_data as MovieClip).getRect(this.monsters_render::_data as MovieClip);
               break;
            default:
               this.monsters_render::_rect = new Rectangle();
         }
      }
      
      public function set pt(param1:Point) : void
      {
         this.monsters_render::_pt = param1;
      }
      
      public function get rect() : Rectangle
      {
         return this.monsters_render::_rect;
      }
      
      public function get depth() : Number
      {
         return this.monsters_render::_depth;
      }
      
      public function set depth(param1:Number) : void
      {
         if(this.monsters_render::_depth !== param1)
         {
            monsters_render::s_needsSort = true;
            this.monsters_render::_depth = param1;
         }
      }
      
      public function set blendMode(param1:String) : void
      {
         this.monsters_render::_blendMode = param1;
      }
      
      public function set filter(param1:BitmapFilter) : void
      {
         this.monsters_render::_filter = param1;
      }
      
      public function set scaleX(param1:Number) : void
      {
         this.monsters_render::_scaleX = param1 * 100 >> 0;
      }
      
      public function set scaleY(param1:Number) : void
      {
         this.monsters_render::_scaleY = param1 * 100 >> 0;
      }
      
      public function set alpha(param1:Number) : void
      {
         this.monsters_render::_alpha = Math.ceil(param1 * 255) << 24;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(!this.monsters_render::_visible && param1)
         {
            if(this.monsters_render::_unSorted)
            {
               monsters_render::s_unsortedData[monsters_render::s_unsortedData.length] = this;
            }
            else
            {
               monsters_render::s_visibleData[monsters_render::s_visibleData.length] = this;
            }
            monsters_render::s_needsSort = true;
         }
         else if(this.monsters_render::_visible && !param1)
         {
            if(this.monsters_render::_unSorted)
            {
               monsters_render::s_unsortedData.splice(monsters_render::s_unsortedData.indexOf(this),1);
            }
            else
            {
               monsters_render::s_visibleData.splice(monsters_render::s_visibleData.indexOf(this),1);
            }
            monsters_render::s_needsSort = true;
         }
         this.monsters_render::_visible = param1;
      }
      
      public function clone() : RasterData
      {
         return new RasterData(this.monsters_render::_data,this.monsters_render::_pt,this.monsters_render::_depth);
      }
      
      public function clear(param1:Boolean = false) : void
      {
         if(this.monsters_render::_cleared)
         {
            return;
         }
         monsters_render::s_rasterData.splice(monsters_render::s_rasterData.indexOf(this),1);
         if(this.monsters_render::_visible)
         {
            if(this.monsters_render::_unSorted)
            {
               monsters_render::s_unsortedData.splice(monsters_render::s_unsortedData.indexOf(this),1);
            }
            else
            {
               monsters_render::s_visibleData.splice(monsters_render::s_visibleData.indexOf(this),1);
            }
         }
         if(param1 && this.monsters_render::_data is BitmapData)
         {
            (this.monsters_render::_data as BitmapData).dispose();
         }
         this.monsters_render::_data = null;
         this.monsters_render::_pt = null;
         this.monsters_render::_rect = null;
         this.monsters_render::_blendMode = null;
         this.monsters_render::_cleared = true;
      }
   }
}

