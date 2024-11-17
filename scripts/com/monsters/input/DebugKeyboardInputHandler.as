package com.monsters.input
{
   import com.monsters.chat.Chat;
   import flash.events.KeyboardEvent;
   import flash.geom.*;
   import gs.*;
   import gs.easing.*;
   
   public class DebugKeyboardInputHandler extends KeyboardInputHandler
   {
      private var _championLevel:Number = 4;
      
      private var _creepType:String = BASE.isInferno() ? "IC" : "C";
      
      private var _monsterAbilityLevel:uint = 1;
      
      private var _monsterLevel:uint = 1;
      
      private var debugGoEasy:Boolean = false;
      
      public function DebugKeyboardInputHandler(param1:SingletonLock)
      {
         super(singletonLock);
      }
      
      public static function get instance() : KeyboardInputHandler
      {
         KeyboardInputHandler.s_Instance = KeyboardInputHandler.s_Instance || new DebugKeyboardInputHandler(new SingletonLock());
         return KeyboardInputHandler.s_Instance;
      }
      
      public function get goEasy() : Boolean
      {
         return this.debugGoEasy;
      }
      
      public function set goEasy(param1:Boolean) : void
      {
         this.debugGoEasy = param1;
      }
      
      override public function OnKeyDown(param1:KeyboardEvent) : void
      {
         super.OnKeyDown(param1);
         if(!GLOBAL._flags.viximo && Chat._bymChat && Chat._bymChat.chatInputHasFocus() && !GLOBAL._aiDesignMode)
         {
            return;
         }
      }
      
      private function ToggleCreepType() : void
      {
         this._creepType = this._creepType == "C" ? "IC" : "C";
      }
      
      private function UpgradeCreatureAbility(param1:uint) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in ACADEMY._upgrades)
         {
            this._monsterAbilityLevel = param1;
            GLOBAL._wmCreaturePowerups[_loc2_] = param1;
         }
      }
      
      private function UpgradeCreatureLevel(param1:uint) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in CREATURELOCKER._creatures)
         {
            if(!(_loc2_.substr(0,1) == "I" || _loc2_ == "C200"))
            {
               this._monsterLevel = param1;
               ACADEMY._upgrades[_loc2_] = {"level":param1};
            }
         }
      }
   }
}

class SingletonLock
{
   public function SingletonLock()
   {
      super();
   }
}
