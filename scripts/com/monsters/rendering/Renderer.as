package com.monsters.rendering
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   use namespace monsters_render;
   
   public class Renderer
   {
      monsters_render static var _debug:Boolean;
      
      private static var _debugShape:Shape;
      
      monsters_render var _canvas:BitmapData;
      
      monsters_render var _viewRect:Rectangle;
      
      private const _matrix:Matrix = new Matrix();
      
      private const _pt:Point = new Point();
      
      private const _bm:Bitmap = new Bitmap();
      
      private var _curCopyIndex:uint;
      
      private var _curDrawIndex:uint;
      
      public function Renderer(param1:BitmapData, param2:Rectangle)
      {
         super();
         this.monsters_render::_canvas = param1;
         this.monsters_render::_viewRect = param2;
      }
      
      public static function get debug() : Boolean
      {
         return monsters_render::_debug;
      }
      
      public static function set debug(param1:Boolean) : void
      {
         monsters_render::_debug = param1;
         if(monsters_render::_debug)
         {
            _debugShape = _debugShape || new Shape();
            RasterData.monsters_render::showDebug();
         }
         else
         {
            _debugShape = null;
            RasterData.monsters_render::hideDebug();
         }
      }
      
      public function set canvas(param1:BitmapData) : void
      {
         this.monsters_render::_canvas = param1;
      }
      
      public function render() : void
      {
         var _loc1_:Vector.<RasterData> = RasterData.monsters_render::s_visibleData;
         this._curDrawIndex = 0;
         this._curCopyIndex = 0;
         _loc1_.fixed = true;
         if(RasterData.monsters_render::s_needsSort)
         {
            _loc1_.sort(this.sortRasterData);
            RasterData.monsters_render::s_needsSort = false;
         }
         this.monsters_render::_canvas.lock();
         this.rasterize(RasterData.monsters_render::s_unsortedData.concat(_loc1_));
         this.monsters_render::_canvas.unlock();
         _loc1_.fixed = false;
      }
      
      private function cull(param1:Vector.<RasterData>) : void
      {
         var _loc3_:RasterData = null;
         var _loc4_:Rectangle = null;
         var _loc2_:Vector.<RasterData> = param1;
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = _loc3_.monsters_render::_rect;
            _loc4_.x = _loc3_.monsters_render::_pt.x;
            _loc4_.y = _loc3_.monsters_render::_pt.y;
            if(this.monsters_render::_viewRect.intersects(_loc4_))
            {
               _loc2_[_loc2_.length] = _loc3_;
            }
         }
      }
      
      private function sortRasterData(param1:RasterData, param2:RasterData) : Number
      {
         return param1.monsters_render::_depth - param2.monsters_render::_depth;
      }
      
      private function rasterize(param1:Vector.<RasterData>) : void
      {
         var _loc3_:RasterData = null;
         var _loc4_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc2_:Vector.<RasterData> = param1;
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = _loc3_.monsters_render::_data as BitmapData;
            this._pt.x = _loc3_.monsters_render::_pt.x;
            this._pt.y = _loc3_.monsters_render::_pt.y;
            if(_loc4_ && !_loc3_.monsters_render::_blendMode && !_loc3_.monsters_render::_filter && (_loc3_.monsters_render::_scaleX & _loc3_.monsters_render::_scaleY) === 100)
            {
               if(_loc3_.monsters_render::_alpha !== 4278190080)
               {
                  _loc5_ = new BitmapData(_loc4_.width,_loc4_.height,true,_loc3_.monsters_render::_alpha);
               }
               this.monsters_render::_canvas.copyPixels(_loc4_,_loc4_.rect,this._pt,_loc5_);
               if(_loc5_)
               {
                  _loc5_.dispose();
                  _loc5_ = null;
               }
            }
            else
            {
               this._matrix.createBox(_loc3_.monsters_render::_scaleX * 0.01,_loc3_.monsters_render::_scaleY * 0.01,0,this._pt.x,this._pt.y);
               if(Boolean(_loc3_.monsters_render::_filter) && Boolean(_loc4_))
               {
                  this._bm.bitmapData = _loc4_;
                  this._bm.filters = [_loc3_.monsters_render::_filter];
                  this.monsters_render::_canvas.draw(this._bm,this._matrix,null,_loc3_.monsters_render::_blendMode);
               }
               else
               {
                  this.monsters_render::_canvas.draw(_loc3_.monsters_render::_data,this._matrix,null,_loc3_.monsters_render::_blendMode);
               }
            }
         }
      }
   }
}

