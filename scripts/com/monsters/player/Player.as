package com.monsters.player
{
   import com.monsters.interfaces.IHandler;
   import com.monsters.kingOfTheHill.KOTHHandler;
   import com.monsters.monsters.components.ITickable;
   import com.monsters.replayableEvents.ReplayableEventHandler;
   import com.monsters.rewarding.RewardHandler;
   import com.monsters.subscriptions.SubscriptionHandler;
   
   public class Player
   {
      private static const HANDLER_REWARD:int = 0;
      
      private static const HANDLER_KOTH:int = 1;
      
      private static const HANDLER_SUBSCRIPTIONS:int = 2;
      
      public var ID:int;
      
      public var name:String;
      
      public var lastName:String;
      
      public var picture:String;
      
      public var timePlayed:int;
      
      public var level:int;
      
      public var email:String;
      
      public var proxyMail:String;
      
      private var _handlers:Vector.<IHandler> = Vector.<IHandler>([RewardHandler.instance,KOTHHandler.instance,SubscriptionHandler.instance]);
      
      public function Player()
      {
         super();
      }
      
      public function initialize() : void
      {
      }
      
      public function initializeHandlers(param1:Object) : void
      {
         var _loc3_:IHandler = null;
         var _loc2_:int = 0;
         while(_loc2_ < GLOBAL.player.handlers.length)
         {
            _loc3_ = GLOBAL.player.handlers[_loc2_];
            _loc3_.initialize(param1[_loc3_.name]);
            if(_loc2_ == 0 && GLOBAL.isAtHome())
            {
               ReplayableEventHandler.initialize(param1["events"]);
            }
            _loc2_++;
         }
      }
      
      public function get rewards() : RewardHandler
      {
         return this._handlers[HANDLER_REWARD] as RewardHandler;
      }
      
      public function get handlers() : Vector.<IHandler>
      {
         return this._handlers;
      }
      
      public function set handlers(param1:Vector.<IHandler>) : void
      {
         this._handlers = param1;
      }
      
      public function tick() : void
      {
         var _loc3_:IHandler = null;
         var _loc1_:int = int(this.handlers.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.handlers[_loc2_];
            if(_loc3_ is ITickable)
            {
               ITickable(_loc3_).tick();
            }
            _loc2_++;
         }
      }
   }
}

