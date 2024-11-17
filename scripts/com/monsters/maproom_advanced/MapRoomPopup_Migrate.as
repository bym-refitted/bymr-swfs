package com.monsters.maproom_advanced
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapRoomPopup_Migrate extends MapRoomPopup_Migrate_CLIP
   {
      private static var instance:MapRoomPopup_Migrate;
      
      private var _closeHandler:Function;
      
      public function MapRoomPopup_Migrate(param1:Function = null)
      {
         var _loc6_:icon_costs = null;
         super();
         this._closeHandler = param1;
         var _loc2_:int = GLOBAL._bMap.InstantUpgradeCost();
         var _loc3_:Object = GLOBAL._bMap.UpgradeCost();
         tTitle.htmlText = KEYS.Get("msg_mr2pop_title");
         tDescription.htmlText = KEYS.Get("msg_mr2pop_desc");
         ImageCache.GetImageWithCallBack("popups/outpost-takeover.png",this.onAssetLoaded);
         mcInstant.tDescription.htmlText = KEYS.Get("buildoptions_upgradeinstant");
         mcInstant.bAction.Setup("<b>" + KEYS.Get("btn_useshiny",{"v1":_loc2_}) + "</b>");
         mcInstant.bAction.Highlight = true;
         mcInstant.bAction.addEventListener(MouseEvent.CLICK,this.InstantUpgrade,false,0,true);
         mcInstant.gCoin.mouseEnabled = false;
         mcInstant.gCoin.mouseChildren = false;
         mcResources.bAction.SetupKey("buildoptions_resources");
         mcResources.bAction.addEventListener(MouseEvent.CLICK,this.Upgrade,false,0,true);
         var _loc4_:Array = GLOBAL._resourceNames;
         var _loc5_:int = 1;
         while(_loc5_ < 5)
         {
            _loc6_ = mcResources["mcR" + _loc5_] as icon_costs;
            _loc6_.tTitle.htmlText = "<b>" + KEYS.Get(_loc4_[_loc5_ - 1]) + "</b>";
            _loc6_.tValue.htmlText = "<b>" + GLOBAL.FormatNumber(_loc3_["r" + _loc5_]) + "</b>";
            if(Boolean(BASE._resources["r" + _loc5_]) && BASE._resources["r" + _loc5_].Get() < _loc3_["r" + _loc5_])
            {
               _loc6_.tValue.htmlText = "<font color=\"#FF0000\">" + _loc6_.tValue.htmlText + "</font>";
            }
            _loc6_.gotoAndStop(_loc5_);
            _loc5_++;
         }
         _loc6_ = mcResources.mcTime;
         mcResources.mcTime.tTitle.htmlText = "<b>" + KEYS.Get(_loc4_[5]) + "</b>";
         mcResources.mcTime.tValue.htmlText = "<b>" + GLOBAL.ToTime(_loc3_.time,true,false) + "</b>";
         mcResources.mcTime.gotoAndStop(_loc5_);
      }
      
      public static function Show(param1:Function = null) : void
      {
         if(instance)
         {
            Hide();
         }
         instance = new MapRoomPopup_Migrate(param1);
         GLOBAL._layerWindows.addChild(instance);
         POPUPSETTINGS.AlignToCenter(instance);
         POPUPSETTINGS.ScaleUp(instance);
      }
      
      public static function Hide() : void
      {
         if(!instance)
         {
            return;
         }
         GLOBAL._layerWindows.removeChild(instance);
         instance = null;
      }
      
      public function Hide() : void
      {
         if(Boolean(this._closeHandler))
         {
            this._closeHandler();
         }
         MapRoomPopup_Migrate.Hide();
      }
      
      private function onAssetLoaded(param1:String, param2:BitmapData) : void
      {
         mcImage.addChild(new Bitmap(param2));
      }
      
      private function InstantUpgrade(param1:Event) : void
      {
         this.Hide();
         GLOBAL._bMap.DoInstantUpgrade();
      }
      
      private function Upgrade(param1:Event) : void
      {
         this.Hide();
         GLOBAL._bMap.Upgrade();
      }
   }
}

