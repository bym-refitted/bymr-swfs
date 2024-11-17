package com.monsters.ui
{
   import com.monsters.chat.Chat;
   import com.monsters.missions.UI_MISSIONMENU;
   import com.monsters.replayableEvents.monsterMadness.MonsterMadness;
   import com.monsters.replayableEvents.monsterMadness.MonsterMadnessInfoBar;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class UI_BOTTOM
   {
      public static var _nextwave:UI_NEXTWAVE;
      
      public static var _mc:UI_MENU;
      
      public static var _missions:UI_MISSIONMENU;
      
      public static var _monsterMadness:MonsterMadnessInfoBar;
      
      private static var _children:Vector.<DisplayObject>;
      
      public function UI_BOTTOM()
      {
         super();
      }
      
      public static function Setup() : void
      {
         _children = new Vector.<DisplayObject>();
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
         if(BASE._yardType == BASE.OUTPOST)
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
      
      public static function ShowStarterKits(param1:MouseEvent = null) : void
      {
         POPUPS.Push(new popup_prefab_help());
      }
      
      public static function Update() : void
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
         _mc.bQuests.Alert = "";
         if(_missions)
         {
            _missions.Update();
         }
         if(_mc.bStore)
         {
            if(Boolean(GLOBAL._bStore) || Boolean(BASE._yardType))
            {
               _mc.bStore.Enabled = true;
            }
            else
            {
               _mc.bStore.Enabled = false;
            }
         }
         if(Boolean(GLOBAL._bMap) || Boolean(BASE._yardType))
         {
            _mc.bMap.Enabled = true;
         }
         else
         {
            _mc.bMap.Enabled = false;
         }
         if(!_mc._sorted)
         {
            _mc.sortAll();
         }
      }
      
      public static function Resize() : void
      {
         if(Boolean(_mc) && _mc._loaded)
         {
            _mc.Resize();
         }
         if(_nextwave)
         {
            _nextwave.Resize();
         }
         if(TUTORIAL._stage < TUTORIAL._endstage)
         {
            TUTORIAL.Resize();
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
      
      public static function Show() : void
      {
         if(_mc)
         {
            _mc.visible = true;
         }
         if(_missions)
         {
            _missions.visible = true;
         }
         if(Chat.flagsShouldChatDisplay())
         {
            if(Chat._bymChat)
            {
               Chat._bymChat.show();
            }
         }
         if(MonsterMadness.infoBar)
         {
            MonsterMadness.addInfoBar();
         }
         showChildren();
      }
      
      public static function Hide() : void
      {
         if(_mc)
         {
            _mc.bQuests.Alert = "";
            _mc.visible = false;
         }
         if(!Chat.flagsShouldChatDisplay())
         {
            if(Chat._bymChat)
            {
               Chat._bymChat.hide();
            }
         }
         if(_nextwave)
         {
            _nextwave.visible = false;
         }
         if(MonsterMadness.infoBar)
         {
            MonsterMadness.removeInfoBar();
         }
         hideChildren();
      }
      
      private static function hideChildren() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < _children.length)
         {
            _children[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      private static function showChildren() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < _children.length)
         {
            _children[_loc1_].visible = true;
            _loc1_++;
         }
      }
      
      public static function addChild(param1:DisplayObject) : void
      {
         _children.push(param1);
         GLOBAL._layerUI.addChild(param1);
      }
      
      public static function removeChild(param1:DisplayObject) : void
      {
         _children.push(param1);
         var _loc2_:uint = uint(_children.indexOf(param1));
         if(_loc2_)
         {
            _children.splice(_loc2_,1);
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
      }
   }
}

