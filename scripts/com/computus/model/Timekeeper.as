package com.computus.model
{
   import flash.events.*;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class Timekeeper extends EventDispatcher
   {
      private static var _instance:Timekeeper;
      
      protected var time:Number;
      
      protected var isTicking:Boolean = false;
      
      protected var tickFrequency:int = 1000;
      
      protected var tickDuration:Number = 1000;
      
      private var regulator:Timer;
      
      private var regulatorAcc:int;
      
      private var regulatorCache:int = 0;
      
      public function Timekeeper()
      {
         if(_instance == null)
         {
            super();
            this.init();
            _instance = this;
         }
         else
         {
            LOGGER.Log("err","Timekeeper dupe");
         }
      }
      
      public function destroy() : void
      {
         this.regulator.removeEventListener(TimerEvent.TIMER,this.onTimerEvent);
      }
      
      public function setRealTimeValue() : void
      {
         var _loc1_:* = new Date();
         this.time = _loc1_.valueOf();
      }
      
      public function setRealTimeTick() : void
      {
         this.setTickDuration(1000);
         this.setTickFrequency(1000);
      }
      
      public function getValue() : Number
      {
         return this.time;
      }
      
      public function setValue(param1:Number) : void
      {
         var _loc2_:* = undefined;
         if(this.time != param1)
         {
            this.time = param1;
            _loc2_ = new TimekeeperEvent(TimekeeperEvent.CHANGE,this.time);
            dispatchEvent(_loc2_);
         }
      }
      
      public function getTickDuration() : Number
      {
         return this.tickDuration;
      }
      
      public function setTickDuration(param1:Number) : void
      {
         this.tickDuration = param1;
      }
      
      public function getTickFrequency() : int
      {
         return this.tickFrequency;
      }
      
      public function setTickFrequency(param1:int) : void
      {
         this.tickFrequency = param1;
      }
      
      public function stopTicking() : void
      {
         this.isTicking = false;
      }
      
      public function startTicking() : void
      {
         this.isTicking = true;
      }
      
      private function init() : void
      {
         this.regulatorAcc = 0;
         this.regulatorCache = getTimer();
         this.regulator = new Timer(50);
         this.regulator.addEventListener(TimerEvent.TIMER,this.onTimerEvent);
         this.regulator.start();
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         var _loc2_:* = getTimer();
         var _loc3_:* = _loc2_ - this.regulatorCache;
         this.regulatorAcc += _loc3_;
         if(this.regulatorAcc > this.tickFrequency)
         {
            if(this.isTicking == true)
            {
               this.setValue(this.time + this.tickDuration);
            }
            this.regulatorAcc -= this.tickFrequency;
         }
         this.regulatorCache = _loc2_;
      }
   }
}
