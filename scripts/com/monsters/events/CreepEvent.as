package com.monsters.events
{
   import flash.events.Event;
   
   public class CreepEvent extends Event
   {
      public static const ATTACKING_CREEP_SPAWNED:String = "attackingCreepSpawned";
      
      public static const DEFENDING_CREEP_SPAWNED:String = "defendingCreepSpawned";
      
      private var m_Creep:CreepBase;
      
      public function CreepEvent(param1:String, param2:CreepBase)
      {
         super(param1);
         this.m_Creep = param2;
      }
      
      public function get creep() : CreepBase
      {
         return this.m_Creep;
      }
   }
}

