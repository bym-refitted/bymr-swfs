package com.computus.model
{
   import flash.events.Event;
   
   public class TimekeeperEvent extends Event
   {
      public static const CHANGE:String = "change";
      
      public var time:Number;
      
      public function TimekeeperEvent(param1:String, param2:Number)
      {
         super(param1,true);
         this.time = param2;
         GLOBAL.Tick();
      }
      
      override public function clone() : Event
      {
         return new TimekeeperEvent(type,this.time);
      }
   }
}

