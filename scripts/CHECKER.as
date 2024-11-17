package
{
   import com.monsters.effects.ResourceBombs;
   import com.monsters.maproom_advanced.MapRoom;
   
   public class CHECKER
   {
      private static var displayed:Boolean;
      
      private static var checkedAllYards:Boolean = false;
      
      public function CHECKER()
      {
         super();
      }
      
      public static function Check() : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:Array = ["e62d46a32543629641c35d4358f4865f","280d2443b3ac8d0f0ab08b7c796b0dfc","b62c46b38d18036ec147390edba0f996"];
         if(GLOBAL._local && !checkedAllYards)
         {
            checkedAllYards = true;
            GLOBAL._buildingProps = GLOBAL._yardProps;
            if(GLOBAL.Check() != _loc1_[0])
            {
               GLOBAL.ErrorMessage("Fix the main yard checker, it\'s wrong",GLOBAL.ERROR_ORANGE_BOX_ONLY);
            }
            GLOBAL._buildingProps = GLOBAL._outpostProps;
            if(GLOBAL.Check() != _loc1_[1])
            {
               GLOBAL.ErrorMessage("Fix the outpost checker, it\'s wrong",GLOBAL.ERROR_ORANGE_BOX_ONLY);
            }
            GLOBAL._buildingProps = INFERNOYARDPROPS._infernoYardProps;
            if(GLOBAL.Check() != _loc1_[2])
            {
               GLOBAL.ErrorMessage("Fix the inferno yard checker, it\'s wrong",GLOBAL.ERROR_ORANGE_BOX_ONLY);
            }
            switch(BASE._yardType)
            {
               case BASE.INFERNO_YARD:
                  GLOBAL._buildingProps = INFERNOYARDPROPS._infernoYardProps;
                  break;
               case BASE.OUTPOST:
                  GLOBAL._buildingProps = GLOBAL._outpostProps;
                  break;
               case BASE.MAIN_YARD:
               default:
                  GLOBAL._buildingProps = GLOBAL._yardProps;
            }
         }
         var _loc2_:String = GLOBAL.Check();
         if(_loc2_ != _loc1_[BASE._yardType])
         {
            if(_loc2_ != _loc1_[0] && _loc2_ != _loc1_[1] && _loc2_ != _loc1_[2] && _loc2_ != _loc1_[3])
            {
               LOGGER.Log("hak","CHECKER.buildingprops " + BASE._yardType + " " + _loc2_);
               GLOBAL.ErrorMessage("CHECKER.buildingprops " + BASE._yardType);
            }
            else
            {
               LOGGER.Log("err","CHECKER.buildingprops yard mismatch " + BASE._yardType + " " + _loc2_);
            }
         }
         if(!GLOBAL._flags.kongregate && !GLOBAL._flags.viximo)
         {
            if(BASE._yardType >= BASE.INFERNO_YARD)
            {
               if(QUESTS.CheckB() != "f824e2629f24188985fbeb687bc55fc2")
               {
                  LOGGER.Log("err","CHECKER.Quests FB " + QUESTS.CheckB());
                  GLOBAL.ErrorMessage("CHECKER.Quests FB");
               }
            }
            else if(QUESTS.CheckB() != "c0cf095e090535eb44828f8b28687400")
            {
               LOGGER.Log("err","CHECKER.Quests FB " + QUESTS.CheckB());
               GLOBAL.ErrorMessage("CHECKER.Quests FB");
            }
         }
         else if(QUESTS.CheckB() != "828e0e95c8b19c4586d0a820ea2bc162")
         {
            LOGGER.Log("err","CHECKER.Quests K/V " + QUESTS.CheckB());
            GLOBAL.ErrorMessage("CHECKER.Quests K/V");
         }
         if(CHAMPIONCAGE.Check() != "99fa0737508999fe1bb4cce06cac4e2e")
         {
            LOGGER.Log("hak","CHECKER.Guardian " + CHAMPIONCAGE.Check());
            GLOBAL.ErrorMessage("CHECKER.GUARDIANCAGE");
         }
         if(CREATURELOCKER.Check() != "3598a0066c04d0a2650a1e34e6dd1dae")
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
         var _loc3_:Boolean = false;
         for(_loc4_ in BASE._buildingsAll)
         {
            _loc5_ = BASE._buildingsAll[_loc4_];
            if(Boolean(_loc5_._hpLvl) && _loc5_._hpLvl != _loc5_._lvl.Get())
            {
               LOGGER.Log("log","CHECKER.building-level");
               GLOBAL.ErrorMessage("CHECKER.building-level");
            }
            if(!_loc3_ && !GLOBAL._catchup && _loc5_._class == "resource")
            {
               _loc6_ = Number(_loc5_._stored.Get());
               _loc7_ = int(_loc5_._countdownProduce.Get());
               _loc5_._stored.Set(0);
               _loc5_._countdownProduce.Set(10);
               _loc5_.Tick();
               if(_loc5_._stored.Get() != 0)
               {
                  LOGGER.Log("hak","CHECKER.building-tick 1");
                  GLOBAL.ErrorMessage("CHECKER.building-tick 1");
               }
               _loc8_ = int(_loc5_._buildingProps.produce[_loc5_._lvl.Get() - 1]);
               if(Boolean(GLOBAL._advancedMap) && BASE._yardType == BASE.OUTPOST)
               {
                  _loc8_ = BRESOURCE.AdjustProduction(GLOBAL._currentCell,_loc8_);
               }
               if(GLOBAL._harvesterOverdrive >= GLOBAL.Timestamp() && GLOBAL._harvesterOverdrivePower.Get() > 0)
               {
                  _loc8_ *= GLOBAL._harvesterOverdrivePower.Get();
               }
               _loc5_._stored.Set(0);
               _loc5_._countdownProduce.Set(1);
               _loc5_.Tick();
               if(_loc5_._stored.Get() > _loc8_)
               {
                  if(_loc5_._stored.Get() / 2 > _loc8_)
                  {
                     LOGGER.Log("err","CHECKER.building-tick 2 expected: " + _loc8_ + " actual: " + _loc5_._stored.Get());
                     GLOBAL.ErrorMessage("CHECKER.building-tick 2");
                  }
                  else
                  {
                     LOGGER.Log("err","CHECKER.building-tick 2 LOW ERROR expected: " + _loc8_ + " actual: " + _loc5_._stored.Get());
                  }
               }
               if(_loc5_._countdownProduce.Get() <= 0)
               {
                  LOGGER.Log("hak","CHECKER.building-tick 3");
                  GLOBAL.ErrorMessage("CHECKER.building-tick 3");
               }
               _loc3_ = true;
               _loc5_._stored.Set(_loc6_);
               _loc5_._countdownProduce.Set(_loc7_);
            }
         }
         _loc4_ = 1;
         while(_loc4_ < 5)
         {
            if(Boolean(ATTACK["_hpLoot" + _loc4_]) && ATTACK["_hpLoot" + _loc4_] != ATTACK._loot["r" + _loc4_].Get())
            {
               LOGGER.Log("log","CHECKER.loot" + _loc4_ + ": " + ATTACK["_hpLoot" + _loc4_] + " instead of " + ATTACK._loot["r" + _loc4_].Get());
            }
            _loc4_++;
         }
      }
   }
}

