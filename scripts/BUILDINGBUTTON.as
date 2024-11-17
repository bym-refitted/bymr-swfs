package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.*;
   
   public class BUILDINGBUTTON extends BUILDINGBUTTON_CLIP
   {
      public var _buildingProps:Object;
      
      public var _id:int;
      
      public function BUILDINGBUTTON()
      {
         super();
      }
      
      public function Setup(param1:int, param2:Boolean = true) : *
      {
         var _loc6_:String = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:* = undefined;
         var _loc10_:int = 0;
         this._id = param1;
         this._buildingProps = GLOBAL._buildingProps[this._id - 1];
         mouseChildren = false;
         if(param2)
         {
            addEventListener(MouseEvent.CLICK,this.ShowInfo);
            buttonMode = true;
         }
         tName.htmlText = "<b>" + KEYS.Get(this._buildingProps.name) + "</b>";
         mcSale.visible = this._buildingProps.sale == 1;
         mcSale.t.htmlText = "<b>" + KEYS.Get("ui_building_sale") + "</b>";
         mcNew.t.htmlText = "<b>" + KEYS.Get("str_new_caps") + "</b>";
         var _loc3_:int = 0;
         if(GLOBAL._bTownhall)
         {
            if(Boolean(this._buildingProps.costs[0].re) && Boolean(this._buildingProps.costs[0].re[0]))
            {
               _loc8_ = int(this._buildingProps.costs[0].re[0][0]);
               _loc3_ = this._buildingProps.costs[0].re[0][0] == INFERNOQUAKETOWER.UNDERHALL_ID ? GLOBAL.StatGet(BUILDING14.UNDERHALL_LEVEL) : GLOBAL._bTownhall._lvl.Get();
            }
            else
            {
               _loc3_ = GLOBAL._bTownhall._lvl.Get();
            }
         }
         var _loc4_:int = int(this._buildingProps.quantity[_loc3_]);
         var _loc5_:int = 0;
         for(_loc6_ in BASE._buildingsAll)
         {
            _loc9_ = BASE._buildingsAll[_loc6_];
            if(_loc9_._type == this._id)
            {
               _loc5_++;
            }
         }
         if(this._buildingProps.type == "decoration")
         {
            _loc10_ = BASE.BuildingStorageCount(this._id);
            if(_loc10_ > 0)
            {
               tQuantity.htmlText = "<font color=\"#0000CC\"><b>" + KEYS.Get("bdg_numinstorage",{"v1":_loc10_}) + "</b></font>";
            }
            else
            {
               tQuantity.htmlText = "<font color=\"#333333\"><b>" + STORE._storeItems["BUILDING" + this._id].c[0] + " " + KEYS.Get("#r_shiny#") + "</b></font>";
            }
         }
         else if(_loc5_ >= _loc4_)
         {
            tQuantity.htmlText = "<b><font color=\"#CC0000\">" + _loc5_ + " / " + _loc4_ + "</font></b>";
         }
         else
         {
            tQuantity.htmlText = "<b>" + _loc5_ + " / " + _loc4_ + "</b>";
         }
         if(Boolean(this._buildingProps.buildingbuttons) && Boolean(BASE._buildingsStored["bl" + this._id]) && this._buildingProps.buildingbuttons.length >= BASE._buildingsStored["bl" + this._id].Get())
         {
            _loc7_ = "buildingbuttons/" + this._buildingProps.buildingbuttons[BASE._buildingsStored["bl" + this._id].Get() - 1] + ".jpg";
         }
         else if(Boolean(this._buildingProps.buildingbuttons) && this._buildingProps.buildingbuttons.length > 0)
         {
            _loc7_ = "buildingbuttons/" + this._buildingProps.buildingbuttons[0] + ".jpg";
         }
         else
         {
            _loc7_ = "buildingbuttons/" + this._id + ".jpg";
         }
         mcNew.visible = false;
         if(GLOBAL._newThings && Boolean(this._buildingProps.isNew))
         {
            mcNew.visible = true;
         }
         ImageCache.GetImageWithCallBack(_loc7_,this.ImageLoaded);
      }
      
      public function ImageLoaded(param1:String, param2:BitmapData) : void
      {
         mcBG.addChild(new Bitmap(param2));
      }
      
      public function ShowInfo(param1:MouseEvent) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(Boolean(this._buildingProps.costs[0].re[0]) && this._buildingProps.costs[0].re[0][0] == INFERNOQUAKETOWER.UNDERHALL_ID)
         {
            if(!MAPROOM_DESCENT.DescentPassed)
            {
               GLOBAL.Message(KEYS.Get("quake_tower_requirement"));
               return;
            }
            _loc2_ = int(this._buildingProps.costs[0].re[0][2]);
            _loc3_ = GLOBAL.StatGet(BUILDING14.UNDERHALL_LEVEL);
            if(!_loc3_)
            {
               GLOBAL.Message(KEYS.Get("base_builderr_noinfstate",{"v1":_loc2_}));
               return;
            }
            if(_loc3_ < _loc2_)
            {
               GLOBAL.Message(KEYS.Get("base_builderr_uhlevelreqd",{"v1":_loc2_}));
               return;
            }
         }
         SOUNDS.Play("click1");
         MovieClip(parent.parent).ShowInfo(this._id);
      }
      
      public function Update() : *
      {
      }
   }
}

