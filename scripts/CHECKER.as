package
{
   import com.monsters.effects.ResourceBombs;
   import com.monsters.maproom_advanced.MapRoom;
   
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
            if(GLOBAL.Check() != "5bfd9f7a961f2e4544209e3bc818ff1a")
            {
               if(GLOBAL.Check() == "3d98775e6a82a8f2f189cb71cc6fb4d8")
               {
                  LOGGER.Log("err","CHECKER.buildingprops YARD outpost/yard mismatch " + GLOBAL.Check());
               }
               else
               {
                  LOGGER.Log("hak","CHECKER.buildingprops YARD " + GLOBAL.Check());
                  GLOBAL.ErrorMessage("CHECKER.buildingprops YARD");
               }
            }
         }
         else if(GLOBAL.Check() != "3d98775e6a82a8f2f189cb71cc6fb4d8")
         {
            if(GLOBAL.Check() == "5bfd9f7a961f2e4544209e3bc818ff1a")
            {
               LOGGER.Log("err","CHECKER.buildingprops OUTPOST yard/outpost mismatch " + GLOBAL.Check());
            }
            else
            {
               LOGGER.Log("hak","CHECKER.buildingprops OUTPOST " + GLOBAL.Check());
               GLOBAL.ErrorMessage("CHECKER.buildingprops OUTPOST");
            }
         }
         if(!GLOBAL._flags.kongregate && !GLOBAL._flags.viximo)
         {
            if(QUESTS.CheckB() != "c0cf095e090535eb44828f8b28687400")
            {
               LOGGER.Log("err","CHECKER.Quests " + QUESTS.CheckB());
               GLOBAL.ErrorMessage("CHECKER.Quests");
            }
         }
         else if(QUESTS.CheckB() != "828e0e95c8b19c4586d0a820ea2bc162")
         {
            LOGGER.Log("err","CHECKER.Quests " + QUESTS.CheckB());
            GLOBAL.ErrorMessage("CHECKER.Quests");
         }
         if(CHAMPIONCAGE.Check() != "99fa0737508999fe1bb4cce06cac4e2e")
         {
            LOGGER.Log("hak","CHECKER.Guardian " + CHAMPIONCAGE.Check());
            GLOBAL.ErrorMessage("CHECKER.GUARDIANCAGE");
         }
         if(CREATURELOCKER.Check() != "4f23177e5caa74b4abd2ef4af7fd4107")
         {
            LOGGER.Log("hak","CHECKER.Creatures " + CREATURELOCKER.Check());
            GLOBAL.ErrorMessage("CHECKER.CREATURES");
         }
         if(ResourceBombs.Check() != "51473261afdd50efbddbad1e2098e140")
         {
            LOGGER.Log("hak","CHECKER.ResourceBombs " + ResourceBombs.Check());
            GLOBAL.ErrorMessage("CHECKER.ResourceBombs");
         }
         if(GLOBAL._mode == "build" && BASE._credits.Get() != BASE._hpCredits)
         {
            LOGGER.Log("log","CHECKER.Credits " + BASE._hpCredits + " vs " + BASE._credits.Get());
            GLOBAL.ErrorMessage("CHECKER.Credits");
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
            GLOBAL.ErrorMessage("CHECKER base1");
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
            GLOBAL.ErrorMessage("CHECKER base2");
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
            GLOBAL.ErrorMessage("CHECKER base3");
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
            GLOBAL.ErrorMessage("CHECKER base4");
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
            GLOBAL.ErrorMessage("CHECKER global1");
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
            GLOBAL.ErrorMessage("CHECKER global2");
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
            GLOBAL.ErrorMessage("CHECKER global3");
         }
         if(GLOBAL._resources.r4.Get() != GLOBAL._hpResources.r4 && GLOBAL._resources.r4.Get() && Boolean(GLOBAL._hpResources.r4))
         {
            if(GLOBAL._hpResources)
            {
               LOGGER.Log("log","CHECKER.resource4 global secure:" + GLOBAL._resources.r4.Get() + " unsecure:" + GLOBAL._hpResources.r4);
            }
            else
            {
               LOGGER.Log("log","CHECKER.resource4 global");
            }
            GLOBAL.ErrorMessage("CHECKER global4");
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
               GLOBAL.ErrorMessage("CHECKER.building-level");
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
                  LOGGER.Log("hak","CHECKER.building-tick 1");
                  GLOBAL.ErrorMessage("CHECKER.building-tick 1");
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
                  if(_loc3_._stored.Get() / 2 > _loc6_)
                  {
                     LOGGER.Log("err","CHECKER.building-tick 2 expected: " + _loc6_ + " actual: " + _loc3_._stored.Get());
                     GLOBAL.ErrorMessage("CHECKER.building-tick 2");
                  }
                  else
                  {
                     LOGGER.Log("err","CHECKER.building-tick 2 LOW ERROR expected: " + _loc6_ + " actual: " + _loc3_._stored.Get());
                  }
               }
               if(_loc3_._countdownProduce.Get() <= 0)
               {
                  LOGGER.Log("hak","CHECKER.building-tick 3");
                  GLOBAL.ErrorMessage("CHECKER.building-tick 3");
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

