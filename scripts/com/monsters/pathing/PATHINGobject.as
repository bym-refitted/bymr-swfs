package com.monsters.pathing
{
   public class PATHINGobject
   {
      public var pointX:int;
      
      public var pointY:int;
      
      public var pointID:int;
      
      public var depth:int;
      
      public var blocked:int;
      
      public var cost:int;
      
      public var tempCost:int;
      
      public var building:BFOUNDATION;
      
      public function PATHINGobject()
      {
         super();
      }
      
      public function Init() : *
      {
         this.pointX = 0;
         this.pointY = 0;
         this.pointID = 0;
         this.depth = 0;
         this.blocked = 0;
         this.cost = 0;
         this.tempCost = 0;
         this.building = null;
      }
   }
}

