package com.cc.utils
{
   public class SecNum
   {
      internal var _o:Object;
      
      public function SecNum(param1:*)
      {
         super();
         if(param1 is String)
         {
            this.BadNum(0);
            return;
         }
         var _loc2_:int = Math.random() * 99999;
         var _loc3_:Number = int(param1) ^ _loc2_;
         var _loc4_:Number = param1 + _loc2_ * 2 ^ _loc2_;
         this._o = {
            "s":_loc2_,
            "n":_loc4_,
            "x":_loc3_
         };
      }
      
      public function Set(param1:int) : *
      {
         var _loc2_:int = Math.random() * 99999;
         var _loc3_:Number = param1 ^ _loc2_;
         var _loc4_:Number = param1 + _loc2_ * 2 ^ _loc2_;
         var _loc5_:Object = {
            "s":_loc2_,
            "n":_loc4_,
            "x":_loc3_
         };
         this._o = null;
         this._o = _loc5_;
      }
      
      public function Add(param1:int) : int
      {
         if(param1 is String)
         {
            this.BadNum(1);
            return 0;
         }
         param1 += this.Get();
         this.Set(param1);
         return param1;
      }
      
      public function Get() : int
      {
         var _loc1_:Number = this._o.x ^ this._o.s;
         var _loc2_:Number = (this._o.n ^ this._o.s) - this._o.s * 2;
         if(_loc1_ == _loc2_)
         {
            return _loc1_;
         }
         this.BadNum(2);
         return 0;
      }
      
      public function BadNum(param1:int) : void
      {
         LOGGER.Log("err","SecNum" + param1);
         GLOBAL.ErrorMessage("SecNum");
      }
   }
}

