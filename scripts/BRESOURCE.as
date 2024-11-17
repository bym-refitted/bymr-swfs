package
{
   import com.cc.utils.SecNum;
   import com.monsters.interfaces.ILootable;
   import com.monsters.maproom_advanced.MapRoomCell;
   import flash.display.MovieClip;
   import flash.events.*;
   
   public class BRESOURCE extends BFOUNDATION implements ILootable
   {
      public static const RESOURCE_TWIGS:uint = 1;
      
      public static const RESOURCE_PEBBLES:uint = 2;
      
      public static const RESOURCE_PUTTY:uint = 3;
      
      public static const RESOURCE_GOO:uint = 4;
      
      public static const RESOURCE_BONE:uint = 5;
      
      public static const RESOURCE_COAL:uint = 6;
      
      public static const RESOURCE_SULFUR:uint = 7;
      
      public static const RESOURCE_MAGMA:uint = 8;
      
      private static const _RESOURCE_BONUS:Number = 1.5;
      
      private static const _RESOURCE_ALLIANCE_BONUS:Number = 1.15;
      
      public function BRESOURCE()
      {
         super();
      }
      
      public static function AdjustProduction(param1:MapRoomCell, param2:int) : int
      {
         if(GLOBAL._advancedMap && BASE._yardType == BASE.OUTPOST && param1 && param1._height && param1._height >= 100)
         {
            return Math.max(int(param2 * GLOBAL._averageAltitude.Get() / param1._height),1);
         }
         return param2;
      }
      
      public static function GetResourceNameKey(param1:uint) : String
      {
         if(param1 <= 3 && BASE.isInferno())
         {
            param1 += 4;
         }
         switch(param1)
         {
            case 0:
               return "#r_twigs#";
            case 1:
               return "#r_pebbles#";
            case 2:
               return "#r_putty#";
            case 3:
               return "#r_goo#";
            case 4:
               return "#r_bone#";
            case 5:
               return "#r_coal#";
            case 6:
               return "#r_sulfur#";
            case 7:
               return "#r_magma#";
            case 8:
               return "#r_shiny#";
            default:
               return null;
         }
      }
      
      override public function SetProps() : void
      {
         super.SetProps();
         _spriteAlert = new mc_buildingalerticon();
         _spriteAlert.cacheAsBitmap = true;
         _spriteAlert.mouseChildren = false;
         _spriteAlert.mouseEnabled = false;
      }
      
      override public function PlaceB() : void
      {
         super.PlaceB();
      }
      
      override public function Click(param1:MouseEvent = null) : void
      {
         super.Click(param1);
      }
      
      override public function Damage(param1:int, param2:int, param3:int, param4:int = 1, param5:Boolean = true, param6:SecNum = null) : int
      {
         var _loc8_:Number = NaN;
         var _loc7_:int = param1;
         if(_fortification.Get() > 0)
         {
            _loc7_ *= 100 - (_fortification.Get() * 10 + 10);
            _loc7_ = _loc7_ / 100;
         }
         if(param5)
         {
            _loc8_ = !!param6 ? param6.Get() * 0.01 : 1;
            if(param4 == 3)
            {
               this.Loot(_loc7_ * 2 * _loc8_);
            }
            else
            {
               this.Loot(_loc7_ * 0.5 * _loc8_);
            }
         }
         super.Damage(param1,param2,param3,param4,param5,param6);
         return _loc7_;
      }
      
      override public function Loot(param1:int) : void
      {
         var _loc2_:int = 0;
         if(_stored.Get() >= param1)
         {
            _loc2_ = param1;
         }
         else
         {
            _loc2_ = _stored.Get();
         }
         if(_loc2_ > 0)
         {
            _stored.Add(int(-_loc2_));
            ATTACK.Loot(_type,_loc2_,_mc.x,_mc.y,0,this);
            if(BASE.isOutpost)
            {
               if(_loc2_ > 0)
               {
                  BASE._resources["r" + _type].Add(-_loc2_);
                  BASE._hpResources["r" + _type] -= _loc2_;
                  if(BASE._deltaResources["r" + _type])
                  {
                     BASE._deltaResources["r" + _type].Add(-_loc2_);
                     BASE._hpDeltaResources["r" + _type] -= _loc2_;
                  }
                  else
                  {
                     BASE._deltaResources["r" + _type] = new SecNum(-_loc2_);
                     BASE._hpDeltaResources["r" + _type] = -_loc2_;
                  }
                  BASE._deltaResources.dirty = true;
                  BASE._hpDeltaResources.dirty = true;
               }
            }
         }
         if(_stored.Get() <= 0)
         {
            _looted = true;
            _canFunction = false;
            _producing = 0;
         }
         super.Loot(_loc2_);
      }
      
      override public function Destroyed(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.Loot(_stored.Get());
         }
         super.Destroyed(param1);
      }
      
      override public function Constructed() : void
      {
         super.Constructed();
         if(!_producing)
         {
            this.StartProduction();
         }
      }
      
      override public function Upgraded() : void
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Upgraded();
         if(!_producing)
         {
            this.StartProduction();
         }
         if(GLOBAL._mode == "build" && _lvl.Get() >= 3 && TUTORIAL._stage > 200 && !BASE.isInferno())
         {
            Brag = function(param1:MouseEvent):void
            {
               var _loc2_:String = "upgrade-twigsnapper.png";
               var _loc3_:String = KEYS.Get("#r_twigs#");
               if(_type == 2)
               {
                  _loc2_ = "upgrade-pebbleshiner.png";
                  _loc3_ = KEYS.Get("#r_pebbles#");
               }
               if(_type == 3)
               {
                  _loc2_ = "upgrade-puttysquisher.png";
                  _loc3_ = KEYS.Get("#r_puttys#");
               }
               if(_type == 4)
               {
                  _loc2_ = "upgrade-goofactory.png";
                  _loc3_ = KEYS.Get("#r_goos#");
               }
               GLOBAL.CallJS("sendFeed",["build-" + String(_buildingProps.name).toLowerCase(),KEYS.Get("pop_rupgraded_streamtitle",{
                  "v1":_lvl.Get(),
                  "v2":KEYS.Get(_buildingProps.name)
               }),KEYS.Get("pop_rupgraded_streambody"),_loc2_]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_rupgraded_title",{
               "v1":KEYS.Get(_buildingProps.name),
               "v2":_lvl.Get()
            }) + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_rupgraded_body",{
               "v1":KEYS.Get(_buildingProps.name),
               "v2":KEYS.Get(GLOBAL._resourceNames[_type - 1])
            });
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.v2.png");
         }
      }
      
      override public function Description() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         super.Description();
         var _loc1_:int = _buildingProps.produce[_lvl.Get() - 1] / _buildingProps.cycleTime[_lvl.Get() - 1] * 60 * 60;
         if(BASE._yardType == BASE.OUTPOST)
         {
            _loc1_ = AdjustProduction(GLOBAL._currentCell,_loc1_);
         }
         if(_hp.Get() < _hpMax.Get())
         {
            if(_countdownUpgrade.Get() + _countdownFortify.Get() <= 0)
            {
               _loc5_ = _buildingProps.cycleTime[_lvl.Get() - 1] + Math.ceil(_buildingProps.cycleTime[_lvl.Get() - 1] * (4 - 4 / _hpMax.Get() * _hp.Get()));
               _loc6_ = _buildingProps.produce[_lvl.Get() - 1] / _loc5_ * 60 * 60;
               if(BASE._yardType == BASE.OUTPOST)
               {
                  _loc6_ = AdjustProduction(GLOBAL._currentCell,_loc6_);
               }
               _loc7_ = 100 - Math.ceil(100 / _hpMax.Get() * _hp.Get());
               _loc8_ = _lvl.Get() == 0 ? int(_buildingProps.repairTime[0]) : int(_buildingProps.repairTime[_lvl.Get() - 1]);
               _loc8_ = Math.min(60 * 60,_loc8_);
               if(_hp.Get() > _hpMax.Get() * 0.5)
               {
                  _repairDescription = "<font color=\"#FF0000\">" + KEYS.Get("bdg_resourcedamaged_reduced",{"v1":_loc7_}) + "</font><br>";
               }
               else
               {
                  _repairDescription = "<font color=\"#FF0000\">" + KEYS.Get("bdg_resourcedamaged_halted",{"v1":_loc7_}) + "</font><br>";
               }
               if(_repairing == 0)
               {
                  _repairDescription += KEYS.Get("bdg_resourcedamaged_repair");
               }
               else
               {
                  _loc8_ = Math.ceil(_hpMax.Get() / _loc8_);
                  _repairDescription += KEYS.Get("bdg_resourcedamaged_remaining",{"v1":GLOBAL.ToTime(int((_hpMax.Get() - _hp.Get()) / _loc8_))});
               }
            }
         }
         else
         {
            _specialDescription = KEYS.Get("bdg_resource_produces",{
               "v1":GLOBAL.FormatNumber(_loc1_),
               "v2":KEYS.Get(GLOBAL._resourceNames[_type - 1]),
               "v3":GLOBAL.FormatNumber(_buildingProps.capacity[_lvl.Get() - 1]),
               "v4":GLOBAL._resourceNames[_type - 1]
            });
            if(_producing)
            {
               _loc2_ = _buildingProps.capacity[_lvl.Get() - 1] - _stored.Get();
               _loc3_ = 60 / _buildingProps.cycleTime[_lvl.Get() - 1] * _buildingProps.produce[_lvl.Get() - 1];
               if(BASE._yardType == BASE.OUTPOST)
               {
                  _loc3_ = AdjustProduction(GLOBAL._currentCell,_loc3_);
               }
               _loc4_ = _loc2_ / _loc3_ * 60;
               _specialDescription += " " + KEYS.Get("bdg_resource_befullin",{"v1":GLOBAL.ToTime(_loc4_)});
            }
            else
            {
               _specialDescription += " <font color=\"#FF0000\">" + KEYS.Get("bdg_resource_full") + "</font>";
            }
         }
         if(_lvl.Get() < _buildingProps.costs.length)
         {
            _loc9_ = _buildingProps.produce[_lvl.Get()] / _buildingProps.cycleTime[_lvl.Get()] * 60 * 60;
            _loc10_ = _loc4_;
            _loc2_ = int(_buildingProps.capacity[_lvl.Get()]);
            if(BASE._yardType == BASE.OUTPOST)
            {
               _loc3_ = 60 / _buildingProps.cycleTime[_lvl.Get()] * AdjustProduction(GLOBAL._currentCell,_buildingProps.produce[_lvl.Get()]);
            }
            else
            {
               _loc3_ = 60 / _buildingProps.cycleTime[_lvl.Get()] * _buildingProps.produce[_lvl.Get()];
            }
            _loc4_ = _loc2_ / _loc3_ * 60;
            _upgradeDescription = "";
            _upgradeDescription += KEYS.Get("bdg_resource_upproduction",{
               "v1":GLOBAL.FormatNumber(_loc1_),
               "v2":GLOBAL.FormatNumber(_loc9_)
            }) + "<br>";
            if(!BASE.isOutpost)
            {
               _upgradeDescription += KEYS.Get("bdg_resource_upcapacity",{
                  "v1":GLOBAL.FormatNumber(_buildingProps.capacity[_lvl.Get() - 1]),
                  "v2":GLOBAL.FormatNumber(_buildingProps.capacity[_lvl.Get()])
               });
            }
         }
      }
      
      override public function get tickLimit() : int
      {
         var _loc1_:int = 0;
         if(BASE.isOutpost)
         {
            return super.tickLimit;
         }
         _loc1_ = _buildingProps.capacity[_lvl.Get() - 1] - _stored.Get();
         if(_loc1_ > 0)
         {
            return Math.min(this.productionValue * this.productionTimeout,super.tickLimit);
         }
         return super.tickLimit;
      }
      
      override public function Tick(param1:int) : void
      {
         var _loc2_:int = 0;
         super.Tick(param1);
         if(BASE.isOutpost)
         {
            _canFunction = _hp.Get() >= 0;
            if(!GLOBAL._catchup)
            {
               if(_countdownProduce.Add(-1) <= 0 && _canFunction)
               {
                  if(_hp.Get() > 0)
                  {
                     ResourcePackages.Create(BASE.isInferno() ? _type + 4 : _type,this,1);
                  }
                  _countdownProduce.Set(10 + Math.random() * 10);
               }
            }
         }
         else if(_countdownBuild.Get() + _countdownUpgrade.Get() + _countdownFortify.Get() == 0)
         {
            _canFunction = _hp.Get() >= _hpMax.Get() * 0.5;
            if(_canFunction)
            {
               if(_producing)
               {
                  _loc2_ = param1;
                  while(_loc2_ > 0 && Boolean(_producing))
                  {
                     if(_countdownProduce.Get() <= _loc2_)
                     {
                        _loc2_ -= _countdownProduce.Get();
                        _countdownProduce.Set(0);
                        this.Produce();
                     }
                     else
                     {
                        _countdownProduce.Add(-_loc2_);
                        _loc2_ = 0;
                     }
                  }
               }
               else if(_stored.Get() > _buildingProps.capacity[_lvl.Get() - 1])
               {
                  LOGGER.Log("hak","Resource gatherer storage capacity exceeded");
                  GLOBAL.ErrorMessage("BRESOURCE overcapacity hack");
                  _stored.Set(_buildingProps.capacity[_lvl.Get() - 1]);
               }
               else if(_stored.Get() < _buildingProps.capacity[_lvl.Get() - 1] && _hp.Get() > 0)
               {
                  this.StartProduction();
               }
            }
         }
         if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
         {
            if(_stored.Get() < 0)
            {
               LOGGER.Log("hak","Attack harvester storage < 0");
               GLOBAL.ErrorMessage();
            }
         }
      }
      
      override public function Update(param1:Boolean = false) : void
      {
         super.Update(param1);
         if(GLOBAL._render || param1)
         {
            if(_producing == 0 && GLOBAL._mode == "build" && _countdownBuild.Get() + _countdownUpgrade.Get() + _countdownFortify.Get() == 0 && _hp.Get() > _hpMax.Get() * 0.5)
            {
               if(!_mcAlert)
               {
                  _mcAlert = _mc.addChild(_spriteAlert);
                  _mcAlert.x = -3;
                  _mcAlert.y = -50;
               }
            }
            else
            {
               if(_mcAlert)
               {
                  _mc.removeChild(_spriteAlert);
               }
               _mcAlert = null;
            }
         }
      }
      
      override public function StartProduction() : void
      {
         if(_hp.Get() > 0)
         {
            if(_stored.Get() >= _buildingProps.capacity[_lvl.Get() - 1])
            {
               _producing = 0;
            }
            else
            {
               _producing = 1;
               _countdownProduce.Set(this.productionTimeout);
            }
         }
      }
      
      public function get productionTimeout() : int
      {
         return _buildingProps.cycleTime[_lvl.Get() - 1] + Math.ceil(_buildingProps.cycleTime[_lvl.Get() - 1] * (4 - 4 / _hpMax.Get() * _hp.Get()));
      }
      
      private function ApplyTerrainBonus(param1:int) : int
      {
         var _loc3_:Number = NaN;
         var _loc2_:* = "r" + _type + "bonus";
         if(BASE._yardType == BASE.INFERNO_YARD && BASE._resources[_loc2_] == 1)
         {
            _loc3_ = _RESOURCE_BONUS;
            param1 *= _loc3_;
         }
         return param1;
      }
      
      public function Produce() : void
      {
         if(_prefab)
         {
            _producing = 0;
         }
         if(_hp.Get() <= 0)
         {
            _producing = 0;
         }
         if(_lvl.Get() <= 0)
         {
            _producing = 0;
         }
         if(Math.max(_countdownProduce.Get(),0))
         {
            LOGGER.Log("hak","BRESOURCE.Produce hack");
            GLOBAL.ErrorMessage("BRESOURCE production hack");
            return;
         }
         if(_producing)
         {
            _stored.Set(Math.min(_stored.Get() + this.productionValue,_buildingProps.capacity[_lvl.Get() - 1]));
            if(_stored.Get() >= _buildingProps.capacity[_lvl.Get() - 1])
            {
               _producing = 0;
            }
         }
         if(_producing)
         {
            this.StartProduction();
         }
      }
      
      public function get productionValue() : int
      {
         var _loc1_:int = int(_buildingProps.produce[_lvl.Get() - 1]);
         if(Boolean(GLOBAL._advancedMap) && BASE._yardType == BASE.OUTPOST)
         {
            _loc1_ = AdjustProduction(GLOBAL._currentCell,_loc1_);
         }
         if(GLOBAL._harvesterOverdrive >= GLOBAL.Timestamp() && GLOBAL._harvesterOverdrivePower.Get() > 0)
         {
            _loc1_ *= GLOBAL._harvesterOverdrivePower.Get();
         }
         return this.ApplyTerrainBonus(_loc1_);
      }
      
      override public function Bank() : void
      {
         var _loc3_:SecNum = null;
         var _loc1_:SecNum = new SecNum(_stored.Get());
         var _loc2_:SecNum = new SecNum(_buildingProps.capacity[_lvl.Get() - 1]);
         if(_loc1_.Get() > _loc2_.Get())
         {
            _loc1_.Set(_loc2_.Get());
         }
         if(_loc1_.Get() > 0)
         {
            _loc3_ = new SecNum(BASE.Fund(_type,_loc1_.Get(),false,this));
            if(_loc3_.Get() > 0)
            {
               ResourcePackages.Create(BASE.isInferno() ? _type + 4 : _type,this,_loc1_.Get());
               if(TUTORIAL._stage < 200)
               {
                  BASE.PointsAdd(_loc3_.Get());
               }
               else
               {
                  BASE.PointsAdd(Math.ceil(_loc3_.Get() * 0.5));
               }
            }
            BASE.CalcResources();
            if(_loc1_.Get() > QUESTS._global.singleclickbank)
            {
               QUESTS._global.singleclickbank = _loc1_.Get();
            }
            if(!GLOBAL._catchup)
            {
               QUESTS.Check();
            }
            LOGGER.Stat([32,_type,_loc1_.Get()]);
         }
      }
      
      override public function Repair() : void
      {
         super.Repair();
         if(!_producing)
         {
            this.StartProduction();
         }
      }
      
      override public function Repaired() : void
      {
         super.Repaired();
      }
      
      public function Fund(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param1 < 4)
         {
            _loc3_ = int(_buildingProps.capacity[_lvl.Get()]);
            if(_stored.Get() + param2 < _loc3_)
            {
               _stored.Add(param2);
               this.Update();
               return 0;
            }
            param2 -= _loc3_ - _stored.Get();
            _stored.Set(_loc3_);
            this.Update();
            return param2;
         }
         if(_type != 4)
         {
            _loc3_ = Math.ceil(_buildingProps.capacity[_lvl.Get()] / 2);
            if(_energy + param2 < _loc3_)
            {
               _energy += param2;
               this.Update();
               return 0;
            }
            param2 -= _loc3_ - _energy;
            _energy = _loc3_;
            this.Update();
            return param2;
         }
         return param2;
      }
      
      override public function Export() : Object
      {
         var _loc1_:Object = null;
         if(BASE.isOutpost)
         {
            return super.Export();
         }
         _loc1_ = super.Export();
         _loc1_.st = _stored.Get();
         _loc1_.pr = _producing;
         if(_countdownProduce.Get() > 0)
         {
            _loc1_.cP = _countdownProduce.Get();
         }
         return _loc1_;
      }
      
      override public function Setup(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         super.Setup(param1);
         if(BASE.isOutpost)
         {
            _loc3_ = _hp.Get() / _hpMax.Get();
            if(_loc3_ <= 0)
            {
               _loc2_ = 0;
            }
            else if(_loc3_ <= 0.5)
            {
               _loc2_ = 0.25 * _buildingProps.capacity[_lvl.Get() - 1];
            }
            else
            {
               _loc2_ = 0.5 * _buildingProps.capacity[_lvl.Get() - 1];
            }
            _producing = 1;
            _countdownProduce.Set(Math.random() * 10);
         }
         else
         {
            _loc2_ = int(param1.st);
            _producing = int(param1.pr);
            _countdownProduce.Set(int(param1.cP));
         }
         if(_loc2_ >= 0)
         {
            _stored.Set(_loc2_);
         }
         else
         {
            _stored.Set(0);
            LOGGER.Log("err","Harvester storage < 0 mode: " + GLOBAL._mode);
         }
      }
   }
}

