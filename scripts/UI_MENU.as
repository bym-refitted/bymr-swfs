package
{
   import com.monsters.display.ImageCache;
   import com.monsters.ui.UI_BOTTOM;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import org.bytearray.display.ScaleBitmap;
   
   public class UI_MENU extends Sprite
   {
      public var woodmargin:int = 10;
      
      public var wood:ScaleBitmap;
      
      public var bBuild:StoneButton;
      
      public var bQuests:StoneButton;
      
      public var bStore:StoneButton;
      
      public var bMap:StoneButton;
      
      public var bKits:StoneButton;
      
      public var buttonspacing:int = 3;
      
      public var _loaded:Boolean = false;
      
      public var wood_mc:MovieClip;
      
      public function UI_MENU()
      {
         super();
         this.bBuild = new StoneButton();
         this.bQuests = new StoneButton();
         this.bStore = new StoneButton();
         this.bMap = new StoneButton();
         if(BASE._isOutpost)
         {
            this.bKits = new StoneButton();
         }
      }
      
      public function Setup() : void
      {
         var cbf1:Function = null;
         cbf1 = function():void
         {
            var cbf2:Function = null;
            cbf2 = function(param1:String, param2:BitmapData):void
            {
               wood = new ScaleBitmap(param2.clone());
               wood.scale9Grid = new Rectangle(15,15,10,10);
               addChild(wood);
               addChild(bBuild);
               addChild(bQuests);
               addChild(bStore);
               addChild(bMap);
               if(BASE._isOutpost)
               {
                  addChild(bKits);
               }
               sortAll();
               _loaded = true;
               UI_BOTTOM.Resize();
               UI_BOTTOM.Update();
            };
            bBuild.SetupKey("ui_topbuildings",12);
            bQuests.SetupKey("ui_topquests",12);
            bStore.SetupKey("ui_topstore",12);
            bMap.SetupKey("ui_topmap",12);
            if(BASE._isOutpost)
            {
               bKits.Setup("Kits",12);
            }
            ImageCache.GetImageWithCallBack("ui/wood1.png",cbf2);
         };
         ImageCache.GetImageGroupWithCallBack("bottom_ui",["ui/wood1.png","ui/stone1.png","ui/stone2.png","ui/stone3.png"],cbf1,true,1);
      }
      
      public function sortAll() : void
      {
         var _loc1_:Array = null;
         var _loc2_:StoneButton = null;
         var _loc3_:StoneButton = null;
         var _loc4_:Number = NaN;
         if(BASE._isOutpost)
         {
            _loc1_ = [this.bKits,this.bBuild,this.bQuests,this.bStore,this.bMap];
         }
         else
         {
            _loc1_ = [this.bBuild,this.bQuests,this.bStore,this.bMap];
         }
         for each(_loc3_ in _loc1_)
         {
            if(!_loc2_)
            {
               _loc3_.x = this.woodmargin;
            }
            else
            {
               _loc3_.x = _loc2_.x + _loc2_.getButtonWidth() + this.buttonspacing;
            }
            _loc3_.y = this.wood.height * 0.5 - _loc3_.getButtonHeight() * 0.5;
            _loc2_ = _loc3_;
         }
         _loc4_ = this.bMap.x + this.bMap.width + this.woodmargin;
         this.wood.setSize(_loc4_,this.wood.height);
      }
      
      public function Resize() : void
      {
         if(this._loaded)
         {
            x = int(GLOBAL._SCREEN.x + GLOBAL._SCREEN.width - (this.wood.width + 10));
            y = int(GLOBAL._SCREEN.y + GLOBAL._SCREEN.height - this.wood.height - 10);
            if(Boolean(UI_BOTTOM._missions) && Boolean(UI_BOTTOM._missions.frame))
            {
               y = int(UI_BOTTOM._missions.y + UI_BOTTOM._missions.frame.y - this.wood.height);
            }
         }
      }
   }
}

