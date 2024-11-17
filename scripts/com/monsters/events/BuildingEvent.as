package com.monsters.events
{
   import flash.events.Event;
   
   public class BuildingEvent extends Event
   {
      public static const UPGRADED:String = "buildingUpgraded";
      
      public static const PLACED_FOR_CONSTRUCTION:String = "buildingPlacedForConstruction";
      
      private var _building:BFOUNDATION;
      
      public function BuildingEvent(param1:String, param2:BFOUNDATION)
      {
         super(param1);
         this._building = param2;
      }
      
      public function get building() : BFOUNDATION
      {
         return this._building;
      }
   }
}

