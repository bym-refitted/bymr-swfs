package
{
   import com.cc.utils.SecNum;
   import flash.events.*;
   
   public class BSTORAGE extends BFOUNDATION
   {
      public function BSTORAGE()
      {
         super();
      }
      
      override public function Damage(param1:int, param2:int, param3:int, param4:int = 1, param5:Boolean = true) : void
      {
         if(param5)
         {
            if(param4 == 3)
            {
               this.Loot(param1 * 3);
            }
            else
            {
               this.Loot(param1 * 0.5);
            }
         }
         super.Damage(param1,param2,param3,param4,param5);
      }
      
      override public function Loot(param1:int) : *
      {
         var _loc4_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         if(BASE._resources.r1.Get() > 0)
         {
            _loc3_.push({
               "id":1,
               "quantity":BASE._resources.r1.Get()
            });
         }
         if(BASE._resources.r2.Get() > 0)
         {
            _loc3_.push({
               "id":2,
               "quantity":BASE._resources.r2.Get()
            });
         }
         if(BASE._resources.r3.Get() > 0)
         {
            _loc3_.push({
               "id":3,
               "quantity":BASE._resources.r3.Get()
            });
         }
         if(BASE._resources.r4.Get() > 0)
         {
            _loc3_.push({
               "id":4,
               "quantity":BASE._resources.r4.Get()
            });
         }
         if(_loc3_.length > 0)
         {
            _loc4_ = _loc3_[int(Math.random() * _loc3_.length)];
            if(_loc4_.quantity >= Math.ceil(param1))
            {
               _loc2_ = Math.ceil(param1);
            }
            else
            {
               _loc2_ = int(_loc4_.quantity);
            }
            BASE._resources["r" + _loc4_.id].Add(-_loc2_);
            BASE._hpResources["r" + _loc4_.id] -= _loc2_;
            if(BASE._deltaResources["r" + _loc4_.id])
            {
               BASE._deltaResources["r" + _loc4_.id].Add(-_loc2_);
               BASE._hpDeltaResources["r" + _loc4_.id] -= _loc2_;
            }
            else
            {
               BASE._deltaResources["r" + _loc4_.id] = new SecNum(-_loc2_);
               BASE._hpDeltaResources["r" + _loc4_.id] = -_loc2_;
            }
            BASE._deltaResources.dirty = true;
            BASE._hpDeltaResources.dirty = true;
            if(GLOBAL._advancedMap && GLOBAL._currentCell && GLOBAL._currentCell._base == 1)
            {
               _loc2_ *= 0.5;
            }
            else
            {
               _loc2_ *= 0.9;
            }
            if(GLOBAL._mode == "wmattack")
            {
               _loc2_ = int(_loc2_ / 5);
            }
            ATTACK.Loot(_loc4_.id,_loc2_,_mc.x,_mc.y,9);
         }
         else
         {
            param1 = 0;
         }
         super.Loot(param1);
      }
      
      override public function Destroyed(param1:Boolean = true) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc2_ = 0.04;
            if(_type == 14)
            {
               _loc2_ = 0.1;
            }
            if(_type == 112)
            {
               _loc2_ = 0.05;
            }
            _loc3_ = 1;
            while(_loc3_ < 5)
            {
               _loc4_ = int(BASE._resources["r" + _loc3_].Get() * _loc2_);
               if(_type == 6)
               {
                  _loc4_ = Math.min(_loc4_,4000000);
                  if(GLOBAL._advancedMap && GLOBAL._currentCell && GLOBAL._currentCell._base == 1)
                  {
                     _loc4_ = Math.min(_loc4_,500000);
                  }
               }
               if(_type == 14)
               {
                  _loc4_ = Math.min(_loc4_,10000000);
                  if(GLOBAL._advancedMap && GLOBAL._currentCell && GLOBAL._currentCell._base == 1)
                  {
                     _loc4_ = Math.min(_loc4_,2000000);
                  }
               }
               if(_type == 112)
               {
                  _loc4_ = Math.min(_loc4_,5000000);
               }
               if(_loc3_ == 4)
               {
                  _loc4_ = Math.ceil(_loc4_ / 2);
               }
               if(_loc4_ > 0)
               {
                  BASE._resources["r" + _loc3_].Add(-_loc4_);
                  BASE._hpResources["r" + _loc3_] -= _loc4_;
                  if(BASE._deltaResources["r" + _loc3_])
                  {
                     BASE._deltaResources["r" + _loc3_].Add(-_loc4_);
                     BASE._hpDeltaResources["r" + _loc3_] -= _loc4_;
                  }
                  else
                  {
                     BASE._deltaResources["r" + _loc3_] = new SecNum(-_loc4_);
                     BASE._hpDeltaResources["r" + _loc3_] = -_loc4_;
                  }
                  BASE._deltaResources.dirty = true;
                  BASE._hpDeltaResources.dirty = true;
                  ATTACK.Loot(_loc3_,_loc4_,_mc.x,int(_mc.y + 20 - _loc3_ * 10),12);
               }
               _loc3_++;
            }
            ATTACK.Log("b" + _id,"<font color=\"#FF0000\">" + KEYS.Get("attack_log_downedlooted",{
               "v1":_lvl.Get(),
               "v2":_buildingProps.name,
               "v3":int(100 * _loc2_)
            }));
         }
         else
         {
            ATTACK.Log("b" + _id,"<font color=\"#FF0000\">" + KEYS.Get("attack_log_downed",{
               "v1":_lvl.Get(),
               "v2":_buildingProps.name
            }));
         }
         super.Destroyed(param1);
      }
   }
}

