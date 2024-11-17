package com.monsters.components
{
   public class Component implements ITickable
   {
      public var owner:CreepBase;
      
      public var name:String;
      
      public var priority:uint;
      
      public function Component()
      {
         super();
      }
      
      public function register(param1:CreepBase, param2:String = null) : void
      {
         if(!this.owner)
         {
         }
         if(!param2)
         {
            param2 = this.toString();
         }
         this.name = param2;
         this.owner = param1;
         this.onRegister();
      }
      
      public function unregister() : void
      {
         if(this.owner)
         {
         }
         this.owner = null;
         this.name = null;
         this.onUnregister();
      }
      
      protected function onUnregister() : void
      {
      }
      
      protected function onRegister() : void
      {
      }
      
      public function tick(param1:int = 1) : Boolean
      {
         return true;
      }
      
      public function destoy() : void
      {
      }
      
      public function toString() : String
      {
         return this.name + ", " + this;
      }
   }
}

