package com.monsters.ui
{
   import com.monsters.missions.UI_MISSIONMENU;
   import flash.events.MouseEvent;
   
   public class UI_BOTTOM
   {
      public static var _nextwave:UI_NEXTWAVE;
      
      public static var _mc:UI_MENU;
      
      public static var _missions:UI_MISSIONMENU;
      
      public function UI_BOTTOM()
      {
         super();
      }
      
      public static function Setup() : *
      {
         _mc = new UI_MENU();
         if(!_missions && !GLOBAL._flags.viximo)
         {
            _missions = new UI_MISSIONMENU();
         }
         _mc.Setup();
         _mc.bBuild.addEventListener(MouseEvent.CLICK,BUILDINGS.Show);
         _mc.bQuests.addEventListener(MouseEvent.CLICK,QUESTS.Show);
         _mc.bStore.addEventListener(MouseEvent.CLICK,STORE.Show(1,1));
         _mc.bMap.addEventListener(MouseEvent.CLICK,GLOBAL.ShowMap);
         if(_missions)
         {
            GLOBAL._layerUI.addChild(_missions);
         }
         if(_mc)
         {
            GLOBAL._layerUI.addChild(_mc);
         }
         if(BASE._isOutpost)
         {
            _mc.bKits.addEventListener(MouseEvent.CLICK,ShowStarterKits);
         }
         if(!UI2._showBottom)
         {
            Hide();
         }
         _nextwave = new UI_NEXTWAVE();
         _nextwave.Setup();
         if(_nextwave)
         {
            GLOBAL._layerUI.addChild(_nextwave);
         }
         _nextwave.visible = false;
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
            if(Boolean(GLOBAL._flags.viximo) || Boolean(GLOBAL._flags.kongregate))
            {
               _mc.bQuests.Alert = "<b>" + _loc1_ + "</b>";
            }
         }
         else
         {
            _mc.bQuests.Alert = "";
         }
         if(_missions)
         {
            _missions.Update();
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
         if(Boolean(_mc) && _mc._loaded)
         {
            _mc.Resize();
         }
         if(_nextwave)
         {
            _nextwave.Resize();
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
         if(_mc)
         {
            _mc.visible = true;
         }
         if(_missions)
         {
            _missions.visible = true;
         }
         if(GLOBAL.flagsShouldChatDisplay())
         {
            if(GLOBAL._bymChat)
            {
               GLOBAL._bymChat.show();
            }
         }
         if(_nextwave && SPECIALEVENT.EventActive() && UI_NEXTWAVE.ShouldDisplay())
         {
            _nextwave.visible = true;
         }
      }
      
      public static function Hide() : *
      {
         if(_mc)
         {
            _mc.bQuests.Alert = "";
            _mc.visible = false;
         }
         if(!GLOBAL.flagsShouldChatDisplay())
         {
            if(GLOBAL._bymChat)
            {
               GLOBAL._bymChat.hide();
            }
         }
         if(_nextwave)
         {
            _nextwave.visible = false;
         }
      }
   }
}

