package com.monsters.rendering
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   use namespace monsters_render;
   
   public class Renderer
   {
      monsters_render var _canvas:BitmapData;
      
      monsters_render var _viewRect:Rectangle;
      
      private const _rasterData:Vector.<RasterData> = new Vector.<RasterData>();
      
      private const _matrix:Matrix = new Matrix();
      
      private const _pt:Point = new Point();
      
      private const _bm:Bitmap = new Bitmap();
      
      private var _curRasterData:Vector.<RasterData>;
      
      private var _curCopyIndex:uint;
      
      private var _curDrawIndex:uint;
      
      public function Renderer(param1:BitmapData, param2:Rectangle)
      {
         super();
         this.monsters_render::_canvas = param1;
         this.monsters_render::_viewRect = param2;
      }
      
      public function set canvas(param1:BitmapData) : void
      {
         this.monsters_render::_canvas = param1;
      }
      
      public function render(param1:Vector.<RasterData>) : void
      {
         this._curRasterData = param1;
         this._curDrawIndex = 0;
         this._curCopyIndex = 0;
         this._curRasterData.fixed = true;
         this.rasterize();
         this._curRasterData.fixed = false;
      }
      
      private function cull() : void
      {
         var _loc1_:RasterData = null;
         var _loc2_:Rectangle = null;
         for each(_loc1_ in this._curRasterData)
         {
            _loc2_ = _loc1_.monsters_render::_rect;
            _loc2_.x = _loc1_.monsters_render::_pt.x;
            _loc2_.y = _loc1_.monsters_render::_pt.y;
            if(this.monsters_render::_viewRect.intersects(_loc2_))
            {
               this._rasterData[this._rasterData.length] = _loc1_;
            }
         }
      }
      
      private function sortRasterData(param1:RasterData, param2:RasterData) : Number
      {
         return param1.monsters_render::_depth - param2.monsters_render::_depth;
      }
      
      private function rasterize() : void
      {
         var _loc1_:RasterData = null;
         var _loc2_:BitmapData = null;
         this.monsters_render::_canvas.lock();
         for each(_loc1_ in this._curRasterData)
         {
            _loc2_ = _loc1_.monsters_render::_data as BitmapData;
            this._pt.x = _loc1_.monsters_render::_pt.x;
            this._pt.y = _loc1_.monsters_render::_pt.y;
            if(_loc2_ && !_loc1_.monsters_render::_blendMode && !_loc1_.monsters_render::_filter && (_loc1_.monsters_render::_scaleX & _loc1_.monsters_render::_scaleY) === 100)
            {
               this.monsters_render::_canvas.copyPixels(_loc2_,_loc2_.rect,this._pt);
            }
            else
            {
               this._matrix.createBox(_loc1_.monsters_render::_scaleX * 0.01,_loc1_.monsters_render::_scaleY * 0.01,0,this._pt.x,this._pt.y);
               if(Boolean(_loc1_.monsters_render::_filter) && Boolean(_loc2_))
               {
                  this._bm.bitmapData = _loc2_;
                  this._bm.filters = [_loc1_.monsters_render::_filter];
                  this.monsters_render::_canvas.draw(this._bm,this._matrix,null,_loc1_.monsters_render::_blendMode);
               }
               else
               {
                  this.monsters_render::_canvas.draw(_loc1_.monsters_render::_data,this._matrix,null,_loc1_.monsters_render::_blendMode);
               }
            }
         }
         this.monsters_render::_canvas.unlock();
      }
   }
}

