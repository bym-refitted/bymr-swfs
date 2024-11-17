package com.monsters.monsters.components.abilities
{
   import com.cc.utils.SecNum;
   import com.monsters.monsters.MonsterBase;
   import com.monsters.monsters.champions.ChampionBase;
   import com.monsters.monsters.components.Component;
   
   public class ProximityLootBuff extends Component
   {
      protected var _radiusSqrd:SecNum;
      
      protected var _championOwner:ChampionBase;
      
      public function ProximityLootBuff()
      {
         super();
      }
      
      override public function register(param1:MonsterBase, param2:String = null) : void
      {
         super.register(param1,param2);
         this._championOwner = param1 as ChampionBase;
         this._radiusSqrd = new SecNum(this._championOwner._buffRadius * this._championOwner._buffRadius);
      }
      
      override public function unregister() : void
      {
         this._championOwner = null;
         super.onUnregister();
      }
      
      override public function tick(param1:int = 1) : Boolean
      {
         var _loc4_:Object = null;
         var _loc5_:MonsterBase = null;
         var _loc2_:Object = CREEPS._creeps;
         var _loc3_:Function = GLOBAL.QuickDistanceSquared;
         if(owner._behaviour !== MonsterBase.k_sBHVR_ATTACK && owner._behaviour !== MonsterBase.k_sBHVR_BOUNCE)
         {
            return false;
         }
         if(owner._frameNumber % 50 == 0)
         {
            for each(_loc4_ in _loc2_)
            {
               _loc5_ = _loc4_ as MonsterBase;
               if(!(_loc4_ === owner || !_loc5_))
               {
                  if((_loc5_._lootMult < 1 + this._championOwner._buff || _loc5_._lootMultTime <= GLOBAL.Timestamp()) && _loc3_(this._championOwner._tmpPoint,_loc5_._tmpPoint) < this._radiusSqrd.Get())
                  {
                     _loc5_.ModeLootBuff(GLOBAL.Timestamp() + 1,1 + this._championOwner._buff);
                  }
               }
            }
         }
         return true;
      }
   }
}

