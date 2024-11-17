package com.monsters.autobanking
{
   import com.cc.utils.SecNum;
   
   public class AutoBankManager
   {
      public static const AUTOBANK_FIX:Boolean = false;
      
      public function AutoBankManager(param1:ManagerEnforcer)
      {
         super();
      }
      
      public static function setLocalGIP(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc2_:Object = BASE._processedGIP;
         for(_loc3_ in _loc2_)
         {
            if(_loc3_ === "t")
            {
               if(AUTOBANK_FIX && GLOBAL._mode === GLOBAL.MODE_ATTACK && BASE._yardType === BASE.OUTPOST)
               {
                  param1[_loc3_] = BASE._lastProcessedGIP;
               }
               else if(BASE._yardType != BASE.INFERNO_YARD)
               {
                  param1[_loc3_] = GLOBAL.Timestamp();
               }
               else
               {
                  param1[_loc3_] = BASE._lastProcessedGIP;
               }
            }
            else
            {
               param1[_loc3_] = {
                  "r1":BASE._processedGIP[_loc3_]["r1"].Get(),
                  "r2":BASE._processedGIP[_loc3_]["r2"].Get(),
                  "r3":BASE._processedGIP[_loc3_]["r3"].Get(),
                  "r4":BASE._processedGIP[_loc3_]["r4"].Get()
               };
            }
         }
      }
      
      public static function autobank(param1:int = 10) : void
      {
         var _loc3_:int = 0;
         var _loc4_:SecNum = null;
         var _loc5_:Array = null;
         var _loc6_:SecNum = null;
         var _loc2_:Object = BASE._GIP;
         if(GLOBAL._advancedMap)
         {
            _loc4_ = new SecNum(0);
            _loc5_ = [new SecNum(0),new SecNum(0),new SecNum(0),new SecNum(0)];
            if(GLOBAL._harvesterOverdrive >= GLOBAL.Timestamp() && Boolean(GLOBAL._harvesterOverdrivePower.Get()))
            {
               _loc6_ = GLOBAL._harvesterOverdrivePower;
            }
            else
            {
               _loc6_ = new SecNum(1);
            }
            if(Boolean(_loc2_["r1"]) && Boolean(_loc2_["r1"].Get()))
            {
               _loc5_[0].Set(BASE.Fund(1,_loc2_["r1"].Get() * _loc6_.Get() * param1 / 10,false,null,false,false));
               _loc4_.Add(_loc5_[0].Get());
            }
            if(Boolean(_loc2_["r2"]) && Boolean(_loc2_["r2"].Get()))
            {
               _loc5_[1].Set(BASE.Fund(2,_loc2_["r2"].Get() * _loc6_.Get() * param1 / 10,false,null,false,false));
               _loc4_.Add(_loc5_[1].Get());
            }
            if(Boolean(_loc2_["r3"]) && Boolean(_loc2_["r3"].Get()))
            {
               _loc5_[2].Set(BASE.Fund(3,_loc2_["r3"].Get() * _loc6_.Get() * param1 / 10,false,null,false,false));
               _loc4_.Add(_loc5_[2].Get());
            }
            if(Boolean(_loc2_["r4"]) && Boolean(_loc2_["r4"].Get()))
            {
               _loc5_[3].Set(BASE.Fund(4,_loc2_["r4"].Get() * _loc6_.Get() * param1 / 10,false,null,false,false));
               _loc4_.Add(_loc5_[3].Get());
            }
            --BASE._autobankCounter;
            BASE.PointsAdd(Math.ceil(_loc4_.Get() * 0.375));
            if(param1 > 10)
            {
               _loc3_ = 1;
               while(_loc3_ < 5)
               {
                  if(_loc5_[_loc3_ - 1].Get() > 0)
                  {
                     LOGGER.Stat([96,_loc3_,_loc5_[_loc3_ - 1].Get()]);
                  }
                  _loc3_++;
               }
               BASE._autobankCounter = 10;
            }
            else if(BASE._autobankCounter == 0)
            {
               _loc3_ = 1;
               while(_loc3_ < 5)
               {
                  if(_loc5_[_loc3_ - 1].Get() > 0)
                  {
                     LOGGER.Stat([96,_loc3_,_loc5_[_loc3_ - 1].Get() * 10]);
                  }
                  _loc3_++;
               }
               BASE._autobankCounter = 10;
            }
         }
      }
   }
}

final class ManagerEnforcer
{
   public function ManagerEnforcer()
   {
      super();
   }
}
