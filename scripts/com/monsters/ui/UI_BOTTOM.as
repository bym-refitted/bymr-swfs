package com.monsters.ui
{
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class UI_BOTTOM
   {
      private static var _mc:UI_MENU;
      
      public function UI_BOTTOM()
      {
         super();
      }
      
      public static function Setup() : *
      {
         _mc = new UI_MENU();
         _mc.Setup();
         _mc.bBuild.addEventListener(MouseEvent.CLICK,BUILDINGS.Show);
         _mc.bQuests.addEventListener(MouseEvent.CLICK,QUESTS.Show);
         _mc.bStore.addEventListener(MouseEvent.CLICK,STORE.Show(1,1));
         _mc.bMap.addEventListener(MouseEvent.CLICK,GLOBAL.ShowMap);
         GLOBAL._layerUI.addChild(_mc);
         if(BASE._isOutpost)
         {
            _mc.bKits.addEventListener(MouseEvent.CLICK,ShowStarterKits);
         }
         if(!UI2._showBottom)
         {
            Hide();
         }
      }
      
      public static function ShowStarterKits(param1:MouseEvent = null) : *
      {
         POPUPS.Push(new popup_prefab_help());
      }
      
      public static function Update() : *
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         for each(_loc2_ in QUESTS._completed)
         {
            if(_loc2_ == 1)
            {
               _loc1_ += 1;
            }
         }
         if(_loc1_ > 0)
         {
            _mc.bQuests.Alert = "<b>" + _loc1_ + "</b>";
         }
         else
         {
            _mc.bQuests.Alert = "";
         }
         if(Boolean(GLOBAL._bStore) || Boolean(BASE._isOutpost))
         {
            _mc.bStore.Enabled = true;
         }
         else
         {
            _mc.bStore.Enabled = false;
         }
         if(Boolean(GLOBAL._bMap) || Boolean(BASE._isOutpost))
         {
            _mc.bMap.Enabled = true;
         }
         else
         {
            _mc.bMap.Enabled = false;
         }
      }
      
      public static function Resize() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:Rectangle = null;
         if(Boolean(_mc) && _mc._loaded)
         {
            _loc1_ = GLOBAL._ROOT.stage.stageWidth;
            _loc2_ = GLOBAL._ROOT.stage.stageHeight;
            _loc3_ = new Rectangle(0 - (_loc1_ - 760) / 2,0 - (_loc2_ - 520) / 2,_loc1_,_loc2_);
            _mc.x = int(_loc3_.x + _loc3_.width - (_mc.wood.width + 10));
            _mc.y = int(522 + (_loc2_ - 520) / 2 - (_mc.wood.height + 10));
         }
      }
      
      public static function Clear() : void
      {
         if(Boolean(_mc) && Boolean(_mc.parent))
         {
            _mc.bBuild.removeEventListener(MouseEvent.CLICK,BUILDINGS.Show);
            _mc.bQuests.removeEventListener(MouseEvent.CLICK,QUESTS.Show);
            _mc.bStore.removeEventListener(MouseEvent.CLICK,STORE.Show(1,1));
            _mc.bMap.removeEventListener(MouseEvent.CLICK,GLOBAL.ShowMap);
            _mc.parent.removeChild(_mc);
            _mc = null;
         }
      }
      
      public static function Show() : *
      {
         _mc.visible = true;
      }
      
      public static function Hide() : *
      {
         _mc.bQuests.Alert = "";
         _mc.visible = false;
      }
   }
}

