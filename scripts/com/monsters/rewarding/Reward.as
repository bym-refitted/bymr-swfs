package com.monsters.rewarding
{
   import com.monsters.interfaces.IExportable;
   
   public class Reward implements IExportable
   {
      protected var _id:String;
      
      protected var _name:String;
      
      protected var _description:String;
      
      protected var _value:*;
      
      public function Reward(param1:String)
      {
         super();
         this._id = param1;
      }
      
      public function applyReward() : void
      {
      }
      
      public function get value() : *
      {
         return this._value;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      internal function get id() : String
      {
         return this._id;
      }
      
      public function exportData() : Object
      {
         var _loc1_:Object = {};
         _loc1_["id"] = this.id;
         if(this.value)
         {
            _loc1_["value"] = this.value;
         }
         return _loc1_;
      }
      
      public function importData(param1:Object) : void
      {
         this._id = param1["id"];
         this._value = param1["value"];
      }
   }
}

