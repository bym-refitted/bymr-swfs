package
{
   import com.cc.utils.SecNum;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING13 extends BFOUNDATION
   {
      public var _frameNumber:int;
      
      public var _timeStamp:int;
      
      public var _finishCost:SecNum;
      
      public var _finishQueue:Object = {};
      
      public var _finishAll:Boolean = true;
      
      public function BUILDING13()
      {
         super();
         this._frameNumber = 0;
         _type = 13;
         _inProduction = "";
         _monsterQueue = [];
         _productionStage.Set(0);
         _footprint = [new Rectangle(0,0,100,100)];
         _gridCost = [[new Rectangle(0,0,100,100),10],[new Rectangle(10,10,80,80),200]];
         _spoutPoint = new Point(-28,-58);
         _spoutHeight = 97;
         _taken = new SecNum(0);
         this._finishCost = new SecNum(0);
         if(BASE.isInferno())
         {
            _animRandomStart = false;
         }
         SetProps();
      }
      
      override public function PlaceB() : *
      {
         super.PlaceB();
      }
      
      override public function TickFast(param1:Event = null) : *
      {
         if(GLOBAL._render && _animLoaded && _countdownBuild.Get() + _countdownUpgrade.Get() == 0 && _inProduction != "" && _productionStage.Get() == 1 && _canFunction)
         {
            if(GLOBAL._render && _animLoaded && _countdownBuild.Get() + _countdownUpgrade.Get() == 0 && _canFunction)
            {
               if(GLOBAL._mode == "build" && this._frameNumber % 2 == 0 && CREEPS._creepCount == 0)
               {
                  this.AnimFrame();
               }
               else if(this._frameNumber % 7 == 0)
               {
                  this.AnimFrame();
               }
            }
         }
         else if(_animTick != 0)
         {
            _animTick = 0;
            super.AnimFrame(false);
         }
         ++this._frameNumber;
      }
      
      override public function AnimFrame(param1:Boolean = true) : *
      {
         super.AnimFrame(param1);
         if(GLOBAL._hatcheryOverdrivePower.Get() == 10)
         {
            _animTick += 4;
         }
         else if(GLOBAL._hatcheryOverdrivePower.Get() == 6)
         {
            _animTick += 2;
         }
         else if(GLOBAL._hatcheryOverdrivePower.Get() == 4)
         {
            ++_animTick;
         }
         if(_animTick >= 30)
         {
            _animTick -= 30;
         }
      }
      
      override public function Description() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.Description();
         if(GLOBAL._hatcheryOverdrive > 0)
         {
            _buildingTitle += " <font color=\"#CC0000\">" + KEYS.Get("building_hatcheryoverdrive_title",{
               "v1":GLOBAL._hatcheryOverdrivePower.Get(),
               "v2":GLOBAL.ToTime(GLOBAL._hatcheryOverdrive)
            }) + "</font>";
         }
         if(_inProduction == "")
         {
            _specialDescription = "<font color=\"#CC0000\">" + KEYS.Get("building_hatchery_noprod",{"v1":GLOBAL._buildingProps[12].name}) + "</font>";
         }
         else if(_canFunction)
         {
            if(CREATURES.GetProperty(_inProduction,"cResource") < BASE._resources.r3.Get() && _productionStage.Get() == 3)
            {
               _specialDescription = "<font color=\"#CC0000\">" + KEYS.Get("building_hatchery_res",{"v1":GLOBAL._resourceNames[3]}) + "</font>";
            }
            else if(_productionStage.Get() == 2 && !HOUSING.HousingStore(_inProduction,new Point(_mc.x,_mc.y),true))
            {
               _specialDescription = "<font color=\"#CC0000\">" + KEYS.Get("building_hatchery_housing",{
                  "v1":GLOBAL._buildingProps[14].name,
                  "v2":CREATURELOCKER._creatures[_inProduction].name
               }) + "</font>";
            }
            else if(_productionStage.Get() == 1)
            {
               _loc1_ = CREATURES.GetProperty(_inProduction,"cTime");
               _loc2_ = 100 / _loc1_ * _countdownProduce.Get();
               if(_loc2_ < 0)
               {
                  _loc2_ = 0;
               }
               if(GLOBAL._hatcheryOverdrive)
               {
                  _loc1_ = int(_loc1_ / GLOBAL._hatcheryOverdrivePower.Get());
               }
               _specialDescription = "Producing a " + CREATURELOCKER._creatures[_inProduction].name + "<br>";
               if(_productionStage.Get() == 1)
               {
                  _specialDescription += 100 - _loc2_ + "% ";
                  if(_loc2_ < 10)
                  {
                     _specialDescription += KEYS.Get("building_hatchery_stage7");
                  }
                  else if(_loc2_ < 20)
                  {
                     _specialDescription += KEYS.Get("building_hatchery_stage6");
                  }
                  else if(_loc2_ < 30)
                  {
                     _specialDescription += KEYS.Get("building_hatchery_stage5");
                  }
                  else if(_loc2_ < 60)
                  {
                     _specialDescription += KEYS.Get("building_hatchery_stage4");
                  }
                  else if(_loc2_ < 70)
                  {
                     _specialDescription += KEYS.Get("building_hatchery_stage3",{"v1":GLOBAL._resourceNames[3]});
                  }
                  else if(_loc2_ < 80)
                  {
                     _specialDescription += KEYS.Get("building_hatchery_stage2");
                  }
                  else
                  {
                     _specialDescription += KEYS.Get("building_hatchery_stage1",{"v1":GLOBAL._resourceNames[3]});
                  }
               }
            }
         }
         else
         {
            _specialDescription = "<font color=\"#CC0000\">" + KEYS.Get("building_hatchery_damaged") + "</font>";
         }
      }
      
      public function ResetProduction() : *
      {
         if(_taken.Get() > 0)
         {
            BASE.Fund(4,_taken.Get());
         }
         _taken.Set(0);
         _hasResources = false;
         _countdownProduce.Set(0);
         _hpCountdownProduce = 0;
         if(_inProduction == "")
         {
            _productionStage.Set(0);
         }
         else
         {
            _productionStage.Set(3);
         }
      }
      
      public function StartProduction() : *
      {
         _inProduction = "";
         _productionStage.Set(0);
         _taken.Set(0);
         if(_monsterQueue.length > 0)
         {
            _inProduction = _monsterQueue[0][0];
            if(_inProduction == "C100")
            {
               _inProduction = "C12";
            }
            --_monsterQueue[0][1];
            if(_monsterQueue[0][1] <= 0)
            {
               _monsterQueue.splice(0,1);
            }
            HATCHERY.Tick();
            _productionStage.Set(3);
            this.Tick();
         }
      }
      
      override public function Tick() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         if(_inProduction)
         {
            CatchupAdd();
         }
         if(_inProduction == "C100")
         {
            _inProduction = "C12";
         }
         super.Tick();
         if(this._timeStamp > GLOBAL.Timestamp())
         {
            return;
         }
         if(_countdownBuild.Get() > 0 || _hp.Get() < _hpMax.Get() * 0.5)
         {
            _canFunction = false;
         }
         else
         {
            _canFunction = true;
         }
         if(_canFunction)
         {
            if(!GLOBAL._bHatcheryCC)
            {
               _loc1_ = HOUSING._housingSpace.Get();
               this._finishQueue = {};
               this._finishAll = true;
               _loc2_ = 0;
               if(_inProduction != "" && _loc1_ >= CREATURES.GetProperty(_inProduction,"cStorage"))
               {
                  _loc1_ -= CREATURES.GetProperty(_inProduction,"cStorage");
                  this._finishQueue[_inProduction] = 1;
                  _loc2_ = _countdownProduce.Get();
                  if(_monsterQueue.length > 0)
                  {
                     _loc3_ = int(_monsterQueue.length);
                     _loc4_ = 0;
                     while(_loc4_ < _loc3_)
                     {
                        _loc5_ = _monsterQueue[_loc4_][0];
                        if(_loc1_ >= CREATURES.GetProperty(_loc5_,"cStorage") * _monsterQueue[_loc4_][1])
                        {
                           _loc2_ += CREATURES.GetProperty(_loc5_,"cTime") * _monsterQueue[_loc4_][1];
                           _loc1_ -= CREATURES.GetProperty(_loc5_,"cStorage") * _monsterQueue[_loc4_][1];
                           if(this._finishQueue[_loc5_])
                           {
                              this._finishQueue[_loc5_] += _monsterQueue[_loc4_][1];
                           }
                           else
                           {
                              this._finishQueue[_loc5_] = _monsterQueue[_loc4_][1];
                           }
                        }
                        else if(_loc1_ >= CREATURES.GetProperty(_loc5_,"cStorage"))
                        {
                           _loc2_ += CREATURES.GetProperty(_loc5_,"cTime") * (_loc1_ / CREATURES.GetProperty(_loc5_,"cStorage"));
                           if(this._finishQueue[_loc5_])
                           {
                              this._finishQueue[_loc5_] += _loc1_ / CREATURES.GetProperty(_loc5_,"cStorage");
                           }
                           else
                           {
                              this._finishQueue[_loc5_] = _loc1_ / CREATURES.GetProperty(_loc5_,"cStorage");
                           }
                           this._finishAll = false;
                           break;
                        }
                        _loc4_++;
                     }
                  }
                  this._finishCost.Set(STORE.GetTimeCost(_loc2_,false) * 4);
               }
               else
               {
                  this._finishCost.Set(0);
               }
            }
            if(_countdownBuild.Get() + _countdownUpgrade.Get() == 0 && _hp.Get() > 10)
            {
               if(_inProduction != "" && _productionStage.Get() == 1)
               {
                  if(_countdownProduce.Get() <= 0)
                  {
                     _productionStage.Set(2);
                     this.Tick();
                     return;
                  }
                  _hasResources = true;
                  if(GLOBAL._hatcheryOverdrive)
                  {
                     _countdownProduce.Add(-GLOBAL._hatcheryOverdrivePower.Get());
                  }
                  else
                  {
                     _countdownProduce.Add(-1);
                  }
               }
               if(_productionStage.Get() == 2 && Boolean(_inProduction))
               {
                  _taken.Set(0);
                  if(HOUSING.HousingStore(_inProduction,new Point(_mc.x,_mc.y),false,_countdownProduce.Get()))
                  {
                     this.StartProduction();
                  }
                  else if(GLOBAL._catchup)
                  {
                     _loc6_ = true;
                     if(_repairing || HOUSING._housingBuildingUpgrading || GLOBAL._bHatcheryCC && GLOBAL._bHatcheryCC._countdownUpgrade.Get() > 0)
                     {
                        _loc6_ = false;
                     }
                     if(_loc6_)
                     {
                        CatchupRemove();
                     }
                  }
               }
               if(_productionStage.Get() == 3)
               {
                  _productionStage.Set(4);
                  _hasResources = true;
               }
               if(_productionStage.Get() == 4 && (_hasResources || !GLOBAL._render))
               {
                  _hasResources = true;
                  _countdownProduce.Set(CREATURES.GetProperty(_inProduction,"cTime"));
                  _productionStage.Set(1);
                  this.Tick();
                  return;
               }
            }
         }
      }
      
      public function FinishNow() : *
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:Point = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(!_canFunction)
         {
            GLOBAL.Message(KEYS.Get("building_hcc_cantfunction"));
            return;
         }
         if(BASE._credits.Get() >= this._finishCost.Get())
         {
            _loc1_ = [];
            _loc2_ = HOUSING._housingSpace.Get();
            if(_inProduction != "" && _loc2_ >= CREATURES.GetProperty(_inProduction,"cStorage"))
            {
               _loc3_ = new Point(_mc.x - 10 + Math.random() * 20,_mc.y - 10 + Math.random() * 20);
               HOUSING.HousingStore(_inProduction,_loc3_);
               _loc2_ -= CREATURES.GetProperty(_inProduction,"cStorage");
               _inProduction = "";
               _productionStage.Set(0);
               if(_monsterQueue.length > 0)
               {
                  while(_monsterQueue.length > 0 && _loc2_ > 0)
                  {
                     _loc5_ = _monsterQueue[0][0];
                     _loc6_ = CREATURES.GetProperty(_loc5_,"cStorage");
                     while(_monsterQueue[0][1] > 0 && _loc2_ >= _loc6_)
                     {
                        if(_loc2_ >= _loc6_)
                        {
                           _loc7_ = int(Math.random() * _loc1_.length);
                           _loc3_ = new Point(_mc.x - 10 + Math.random() * 20,_mc.y - 10 + Math.random() * 20);
                           --_monsterQueue[0][1];
                           _loc2_ -= _loc6_;
                           HOUSING.HousingStore(_loc5_,_loc3_);
                        }
                     }
                     if(_monsterQueue[0][1] <= 0)
                     {
                        _monsterQueue.shift();
                     }
                     else if(_loc2_ < _loc6_)
                     {
                        break;
                     }
                  }
               }
            }
            if(_monsterQueue.length > 0)
            {
               _inProduction = _monsterQueue[0][0];
               if(_inProduction == "C100")
               {
                  _inProduction = "C12";
               }
               --_monsterQueue[0][1];
               if(_monsterQueue[0][1] <= 0)
               {
                  _monsterQueue.splice(0,1);
               }
               _productionStage.Set(3);
            }
            else
            {
               _productionStage.Set(0);
            }
            BASE.Purchase("FQ",this._finishCost.Get(),"BUILDING13.FinishNow");
            HATCHERY.Tick();
            this.Tick();
         }
         else
         {
            POPUPS.DisplayGetShiny();
         }
      }
      
      override public function Constructed() : *
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Constructed();
         GLOBAL._bHatchery = this;
         if(GLOBAL._mode == "build" && TUTORIAL._stage > 200 && BASE._yardType == BASE.MAIN_YARD)
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["build-ha",KEYS.Get("pop_hatbuilt_streamtitle"),KEYS.Get("pop_hatbuilt_body"),"build-hatchery.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_hatbuilt_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_hatbuilt_body");
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function Cancel() : *
      {
         GLOBAL._bHatchery = null;
         super.Cancel();
      }
      
      override public function RecycleC() : *
      {
         GLOBAL._bHatchery = null;
         super.RecycleC();
      }
      
      override public function Upgraded() : *
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Upgraded();
         if(GLOBAL._mode == "build" && !BASE.isInferno())
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["upgrade-ha-" + _lvl.Get(),KEYS.Get("pop_hatupgraded_streamtitle",{"v1":_lvl.Get()}),KEYS.Get("pop_hatupgraded_body",{"v1":_lvl.Get()}),"upgrade-hatchery.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_hatupgraded_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_hatupgraded_body",{"v1":_lvl.Get()});
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function Setup(param1:Object) : *
      {
         _monsterQueue = [];
         if(param1.mq)
         {
            _monsterQueue = param1.mq;
         }
         if(param1.saved)
         {
            this._timeStamp = param1.saved;
         }
         else
         {
            this._timeStamp = 0;
         }
         var _loc2_:int = 0;
         while(_loc2_ < _monsterQueue.length)
         {
            if(_monsterQueue[_loc2_][0] == "C100")
            {
               _monsterQueue[_loc2_][0] = "C12";
            }
            _loc2_++;
         }
         super.Setup(param1);
         if(_countdownBuild.Get() == 0 || TUTORIAL._stage < 200)
         {
            GLOBAL._bHatchery = this;
         }
      }
      
      override public function Export() : *
      {
         var _loc1_:* = super.Export();
         if(_monsterQueue.length > 0)
         {
            _loc1_.mq = _monsterQueue;
         }
         return _loc1_;
      }
   }
}

