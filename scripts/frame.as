package
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class frame extends MovieClip
   {
      private var _bottomLeft:Bitmap;
      
      private var _bottomRight:Bitmap;
      
      private var _topLeft:Bitmap;
      
      private var _topRight:Bitmap;
      
      private var _fillerLeft:Bitmap;
      
      private var _fillerRight:Bitmap;
      
      private var _fillerTop:Bitmap;
      
      private var _fillerBottom:Bitmap;
      
      private var _buttonClose:Bitmap;
      
      private var _buttonHelp:Bitmap;
      
      private var _background:Bitmap;
      
      private var _frameMC:MovieClip;
      
      private var _frameDO:DisplayObject;
      
      private var _backgroundMC:MovieClip;
      
      private var _backgroundDO:DisplayObject;
      
      private var _customCloseFunction:Function = null;
      
      public function frame()
      {
         super();
         this.Setup();
      }
      
      public function Setup(param1:Boolean = true, param2:Function = null) : *
      {
         var _loc3_:Boolean = false;
         var _loc4_:MovieClip = null;
         this.Clear();
         this._customCloseFunction = param2;
         _loc3_ = false;
         if(BASE.isInferno())
         {
            this._bottomLeft = new Bitmap(new frame3_bottom_left(0,0));
            this._bottomRight = new Bitmap(new frame3_bottom_right(0,0));
            this._topLeft = new Bitmap(new frame3_top_left(0,0));
            this._topRight = new Bitmap(new frame3_top_right(0,0));
            this._fillerTop = new Bitmap(new frame3_filler_top(0,0));
            this._fillerLeft = new Bitmap(new frame3_filler_left(0,0));
            this._fillerRight = new Bitmap(new frame3_filler_right(0,0));
            this._fillerBottom = new Bitmap(new frame3_filler_bottom(0,0));
            this._background = new Bitmap(new frame3_background(0,0));
            this._buttonClose = new Bitmap(new frame_button_close(0,0));
            if(_loc3_)
            {
               this._buttonHelp = new Bitmap(new frame_button_help(0,0));
            }
            this._topLeft.x = x - 31;
            this._topLeft.y = y - 18;
            this._topRight.x = x + width - 80;
            this._topRight.y = y - 18;
            this._bottomLeft.x = x - 31;
            this._bottomLeft.y = y + height - 69 + 20;
            this._bottomRight.x = x + width - 80;
            this._bottomRight.y = y + height - 66 + 17;
            this._background.x = x + 10;
            this._background.y = y + 10;
            this._background.width = width - 20;
            this._background.height = height - 20;
            this._buttonClose.x = x + width - 32;
            this._buttonClose.y = y - 5;
            if(_loc3_)
            {
               this._buttonHelp.x = x + width - 55;
            }
            if(_loc3_)
            {
               this._buttonHelp.y = y - 5;
            }
            this._fillerTop.x = x + 56;
            this._fillerTop.y = y - 7;
            this._fillerTop.width = width - 105;
            this._fillerLeft.x = x - 8;
            this._fillerLeft.y = y + 50;
            this._fillerLeft.height = height - 80;
            this._fillerRight.x = x + width - 16;
            this._fillerRight.y = y + 50;
            this._fillerRight.height = height - 95;
            this._fillerBottom.x = x + 40;
            this._fillerBottom.y = y + height - 11;
            this._fillerBottom.width = width - 90;
         }
         else
         {
            this._bottomLeft = new Bitmap(new frame2_bottom_left(0,0));
            this._bottomRight = new Bitmap(new frame2_bottom_right(0,0));
            this._topLeft = new Bitmap(new frame2_top_left(0,0));
            this._topRight = new Bitmap(new frame2_top_right(0,0));
            this._fillerTop = new Bitmap(new frame2_filler_top(0,0));
            this._fillerLeft = new Bitmap(new frame2_filler_left(0,0));
            this._fillerRight = new Bitmap(new frame2_filler_right(0,0));
            this._fillerBottom = new Bitmap(new frame2_filler_bottom(0,0));
            this._background = new Bitmap(new frame2_background(0,0));
            this._buttonClose = new Bitmap(new frame_button_close(0,0));
            if(_loc3_)
            {
               this._buttonHelp = new Bitmap(new frame_button_help(0,0));
            }
            this._topLeft.x = x - 11;
            this._topLeft.y = y - 10;
            this._topRight.x = x + width - 66 + 11;
            this._topRight.y = y - 9;
            this._bottomLeft.x = x - 12;
            this._bottomLeft.y = y + height - 69 + 15;
            this._bottomRight.x = x + width - 68 + 11;
            this._bottomRight.y = y + height - 66 + 16;
            this._background.x = x + 10;
            this._background.y = y + 10;
            this._background.width = width - 20;
            this._background.height = height - 20;
            this._buttonClose.x = x + width - 20;
            this._buttonClose.y = y - 10;
            if(_loc3_)
            {
               this._buttonHelp.x = x + width - 48;
            }
            if(_loc3_)
            {
               this._buttonHelp.y = y - 11;
            }
            this._fillerTop.x = x + 56;
            this._fillerTop.y = y - 7;
            this._fillerTop.width = width - 105;
            this._fillerLeft.x = x - 8;
            this._fillerLeft.y = y + 50;
            this._fillerLeft.height = height - 100;
            this._fillerRight.x = x + width - 16;
            this._fillerRight.y = y + 50;
            this._fillerRight.height = height - 95;
            this._fillerBottom.x = x + 40;
            this._fillerBottom.y = y + height - 11;
            this._fillerBottom.width = width - 90;
         }
         this._frameMC = new MovieClip();
         this._frameMC.mouseEnabled = false;
         this._frameMC.addChild(this._background);
         this._frameMC.addChild(this._fillerTop);
         if(height > 100)
         {
            this._frameMC.addChild(this._fillerLeft);
         }
         if(height > 95)
         {
            this._frameMC.addChild(this._fillerRight);
         }
         this._frameMC.addChild(this._fillerBottom);
         this._frameMC.addChild(this._bottomLeft);
         this._frameMC.addChild(this._bottomRight);
         this._frameMC.addChild(this._topLeft);
         this._frameMC.addChild(this._topRight);
         if(param1)
         {
            _loc4_ = new MovieClip();
            _loc4_.addChild(this._buttonClose);
            _loc4_.addEventListener(MouseEvent.CLICK,this.BtnClose);
            _loc4_.buttonMode = true;
            this._frameMC.addChild(_loc4_);
         }
         if(param1 && _loc3_)
         {
            _loc4_ = new MovieClip();
            _loc4_.addChild(this._buttonHelp);
            _loc4_.addEventListener(MouseEvent.CLICK,this.BtnHelp);
            _loc4_.buttonMode = true;
            this._frameMC.addChild(_loc4_);
         }
         this._frameDO = parent.addChild(this._frameMC);
         var _loc5_:int = parent.getChildIndex(this);
         parent.setChildIndex(this._frameDO,_loc5_);
         this.visible = false;
      }
      
      public function Clear() : *
      {
         try
         {
            if(this._frameDO.parent)
            {
               this._frameDO.parent.removeChild(this._frameDO);
            }
            if(this._backgroundDO.parent)
            {
               this._backgroundDO.parent.removeChild(this._backgroundDO);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function BtnClose(param1:MouseEvent = null) : *
      {
         if("Hide" in parent)
         {
            (parent as MovieClip).Hide();
         }
         else if(Boolean(this._customCloseFunction))
         {
            this._customCloseFunction();
         }
         else
         {
            POPUPS.Next();
         }
      }
      
      private function BtnHelp(param1:MouseEvent = null) : *
      {
         if("Help" in parent)
         {
            (parent as MovieClip).Help();
         }
      }
      
      private function BtnFullScreen(param1:MouseEvent = null) : *
      {
         GLOBAL.goFullScreen();
         if("FullScreen" in parent)
         {
            (parent as MovieClip).FullScreen();
         }
      }
   }
}

