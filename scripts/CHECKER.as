package
{
   import com.monsters.effects.ResourceBombs;
   import com.monsters.maproom_advanced.MapRoom;
   import package_1.class_1;
   
   public class CHECKER
   {
      private static var displayed:Boolean;
      
      public function CHECKER()
      {
         super();
      }
      
      public static function Check() : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!BASE._isOutpost)
         {
            if(GLOBAL.Check() != "7e8f81e0c3ac9670f370cafa9ab15300")
            {
               LOGGER.Log("err","CHECKER.buildingprops YARD " + GLOBAL.Check());
               GLOBAL.ErrorMessage("");
            }
         }
         else if(GLOBAL.Check() != "c9698832f35d6319cefc9cee774f6013")
         {
            LOGGER.Log("err","CHECKER.buildingprops OUTPOST " + GLOBAL.Check());
            GLOBAL.ErrorMessage("");
         }
         if(!GLOBAL._flags.kongregate)
         {
            if(QUESTS.CheckB() != "229df3c5be8059752f9af3e15090021e")
            {
               LOGGER.Log("err","CHECKER.Quests " + QUESTS.CheckB());
               GLOBAL.ErrorMessage("");
            }
         }
         else if(QUESTS.CheckB() != "6fe6aa0a9cb56c49dcf94e2063d243cb")
         {
            LOGGER.Log("err","CHECKER.Quests " + QUESTS.CheckB());
            GLOBAL.ErrorMessage("");
         }
         if(GUARDIANCAGE.Check() != "52828a21e22ced0235fd56298c222347")
         {
            LOGGER.Log("err","CHECKER.Guardian " + GUARDIANCAGE.Check());
            GLOBAL.ErrorMessage("");
         }
         if(CREATURELOCKER.Check() != "ea0d5156021f5c577457789ab85d0891")
         {
            LOGGER.Log("err","CHECKER.Creatures " + CREATURELOCKER.Check());
            GLOBAL.ErrorMessage("");
         }
         if(ResourceBombs.Check() != class_1.method_1(-811,-459))
         {
            LOGGER.Log("err","CHECKER.ResourceBombs " + ResourceBombs.Check());
            GLOBAL.ErrorMessage("");
         }
         if(GLOBAL._mode == "build" && BASE._credits.Get() != BASE._hpCredits)
         {
            LOGGER.Log("log","CHECKER.Credits " + BASE._hpCredits + " vs " + BASE._credits.Get());
            GLOBAL.ErrorMessage();
         }
         if(BASE._resources.r1.Get() != BASE._hpResources.r1)
         {
            if(BASE._hpResources.r1)
            {
               LOGGER.Log("log","CHECKER.resource1 base secure:" + BASE._resources.r1.Get() + " unsecure:" + BASE._hpResources.r1);
            }
            else
            {
               LOGGER.Log("log","CHECKER.resource1 base");
            }
            GLOBAL.ErrorMessage();
         }
         if(BASE._resources.r2.Get() != BASE._hpResources.r2)
         {
            if(BASE._hpResources.r2)
            {
               LOGGER.Log("log","CHECKER.resource2 base secure:" + BASE._resources.r2.Get() + " unsecure:" + BASE._hpResources.r2);
            }
            else
            {
               LOGGER.Log("log","CHECKER.resource2 base");
            }
            GLOBAL.ErrorMessage();
         }
         if(BASE._resources.r3.Get() != BASE._hpResources.r3)
         {
            if(BASE._hpResources.r3)
            {
               LOGGER.Log("log","CHECKER.resource3 base secure:" + BASE._resources.r3.Get() + " unsecure:" + BASE._hpResources.r3);
            }
            else
            {
               LOGGER.Log("log","CHECKER.resource3 base");
            }
            GLOBAL.ErrorMessage();
         }
         if(BASE._resources.r4.Get() != BASE._hpResources.r4)
         {
            if(BASE._hpResources.r4)
            {
               LOGGER.Log("log","CHECKER.resource4 base secure:" + BASE._resources.r4.Get() + " unsecure:" + BASE._hpResources.r4);
            }
            else
            {
               LOGGER.Log("log","CHECKER.resource4 base");
            }
            GLOBAL.ErrorMessage();
         }
         if(GLOBAL._resources.r1.Get() != GLOBAL._hpResources.r1 && GLOBAL._resources.r1.Get() && Boolean(GLOBAL._hpResources.r1))
         {
            if(GLOBAL._hpResources)
            {
               LOGGER.Log("log","CHECKER.resource1 global secure:" + GLOBAL._resources.r1.Get() + " unsecure:" + GLOBAL._hpResources.r1);
            }
            else
            {
               LOGGER.Log("log","CHECKER.resource1 global");
            }
            GLOBAL.ErrorMessage();
         }
         if(GLOBAL._resources.r2.Get() != GLOBAL._hpResources.r2 && GLOBAL._resources.r2.Get() && Boolean(GLOBAL._hpResources.r2))
         {
            if(GLOBAL._hpResources)
            {
               LOGGER.Log("log","CHECKER.resource2 global secure:" + GLOBAL._resources.r2.Get() + " unsecure:" + GLOBAL._hpResources.r2);
            }
            else
            {
               LOGGER.Log("log","CHECKER.resource2 global");
            }
            GLOBAL.ErrorMessage();
         }
         if(GLOBAL._resources.r3.Get() != GLOBAL._hpResources.r3 && GLOBAL._resources.r3.Get() && Boolean(GLOBAL._hpResources.r3))
         {
            if(GLOBAL._hpResources)
            {
               LOGGER.Log("log","CHECKER.resource3 global secure:" + GLOBAL._resources.r3.Get() + " unsecure:" + GLOBAL._hpResources.r3);
            }
            else
            {
               LOGGER.Log("log","CHECKER.resource3 global");
            }
            GLOBAL.ErrorMessage();
         }
         if(GLOBAL._resources.r4.Get() != GLOBAL._hpResources.r4)
         {
            if(GLOBAL._hpResources)
            {
               LOGGER.Log("log","CHECKER.resource4 global secure:" + GLOBAL._resources.r4.Get() + " unsecure:" + GLOBAL._hpResources.r4);
            }
            else
            {
               LOGGER.Log("log","CHECKER.resource4 global");
            }
            GLOBAL.ErrorMessage();
         }
         if(GLOBAL._advancedMap)
         {
            if(MapRoom._mc)
            {
               MapRoom._mc.Check();
            }
         }
         var _loc1_:Boolean = false;
         for(_loc2_ in BASE._buildingsAll)
         {
            _loc3_ = BASE._buildingsAll[_loc2_];
            if(Boolean(_loc3_._hpLvl) && _loc3_._hpLvl != _loc3_._lvl.Get())
            {
               LOGGER.Log("log","CHECKER.building-level");
               GLOBAL.ErrorMessage();
            }
            if(!_loc1_ && !GLOBAL._catchup && _loc3_._class == "resource")
            {
               _loc4_ = Number(_loc3_._stored.Get());
               _loc5_ = int(_loc3_._countdownProduce.Get());
               _loc3_._stored.Set(0);
               _loc3_._countdownProduce.Set(10);
               _loc3_.Tick();
               if(_loc3_._stored.Get() != 0)
               {
                  LOGGER.Log("log","CHECKER.building-tick 1");
                  GLOBAL.ErrorMessage();
               }
               _loc6_ = int(_loc3_._buildingProps.produce[_loc3_._lvl.Get() - 1]);
               if(Boolean(GLOBAL._advancedMap) && Boolean(BASE._isOutpost))
               {
                  _loc6_ = BRESOURCE.AdjustProduction(GLOBAL._currentCell,_loc6_);
               }
               if(GLOBAL._harvesterOverdrive >= GLOBAL.Timestamp() && GLOBAL._harvesterOverdrivePower.Get() > 0)
               {
                  _loc6_ *= GLOBAL._harvesterOverdrivePower.Get();
               }
               _loc3_._stored.Set(0);
               _loc3_._countdownProduce.Set(1);
               _loc3_.Tick();
               if(_loc3_._stored.Get() > _loc6_)
               {
                  LOGGER.Log("log","CHECKER.building-tick 2");
                  GLOBAL.ErrorMessage();
               }
               if(_loc3_._countdownProduce.Get() <= 0)
               {
                  LOGGER.Log("log","CHECKER.building-tick 3");
                  GLOBAL.ErrorMessage();
               }
               _loc1_ = true;
               _loc3_._stored.Set(_loc4_);
               _loc3_._countdownProduce.Set(_loc5_);
            }
         }
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            if(Boolean(ATTACK["_hpLoot" + _loc2_]) && ATTACK["_hpLoot" + _loc2_] != ATTACK._loot["r" + _loc2_].Get())
            {
               LOGGER.Log("log","CHECKER.loot" + _loc2_ + ": " + ATTACK["_hpLoot" + _loc2_] + " instead of " + ATTACK._loot["r" + _loc2_].Get());
            }
            _loc2_++;
         }
      }
   }
}

