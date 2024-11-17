package
{
   import com.cc.utils.SecNum;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING16 extends BFOUNDATION
   {
      public var _finishCost:SecNum;
      
      public var _finishQueue:Object = {};
      
      public var _finishAll:Boolean = true;
      
      public function BUILDING16()
      {
         super();
         _type = 16;
         _monsterQueue = [];
         _footprint = [new Rectangle(0,0,100,100)];
         _gridCost = [[new Rectangle(0,0,100,100),10],[new Rectangle(10,10,80,80),200]];
         _spoutPoint = new Point(0,-5);
         _spoutHeight = 55;
         this._finishCost = new SecNum(0);
         SetProps();
      }
      
      override public function PlaceB() : *
      {
         super.PlaceB();
      }
      
      override public function Description() : *
      {
         super.Description();
      }
      
      override public function Destroyed(param1:Boolean = true) : *
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:SecNum = new SecNum(0);
         if(_monsterQueue.length > 0)
         {
            _loc5_ = int(_monsterQueue.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc2_.Add(CREATURES.GetProperty(_monsterQueue[_loc6_][0],"cResource") * _monsterQueue[_loc6_][1]);
               _loc6_++;
            }
            _monsterQueue = [];
         }
         BASE.Fund(4,Math.ceil(_loc2_.Get() * 0.75),false,this);
         var _loc3_:int = 0;
         if(_loc2_.Get() > 20000)
         {
            _loc3_ = 12;
         }
         else if(_loc2_.Get() > 10000)
         {
            _loc3_ = 9;
         }
         else if(_loc2_.Get() > 5000)
         {
            _loc3_ = 7;
         }
         else if(_loc2_.Get() > 1000)
         {
            _loc3_ = 5;
         }
         else if(_loc2_.Get() > 400)
         {
            _loc3_ = 4;
         }
         else if(_loc2_.Get() > 200)
         {
            _loc3_ = 3;
         }
         else if(_loc2_.Get() > 100)
         {
            _loc3_ = 2;
         }
         else if(_loc2_.Get() > 0)
         {
            _loc3_ = 1;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            ResourcePackages.Spawn(this,GLOBAL._bTownhall,BASE.isInferno() ? 8 : 4,_loc4_);
            _loc4_++;
         }
         super.Destroyed(param1);
      }
      
      public function ResetProduction() : *
      {
         if(_inProduction == "")
         {
            _productionStage.Set(0);
         }
         else
         {
            _productionStage.Set(3);
            _countdownProduce.Set(0);
            _hpCountdownProduce = 0;
         }
      }
      
      public function StartProduction() : *
      {
      }
      
      override public function Tick(param1:int) : void
      {
         var _loc4_:BFOUNDATION = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         super.Tick(param1);
         var _loc2_:int = HOUSING._housingSpace.Get();
         var _loc3_:int = 0;
         this._finishQueue = {};
         this._finishAll = true;
         if(_countdownBuild.Get() == 0 && _hp.Get() > 10)
         {
            _canFunction = true;
            for each(_loc4_ in BASE._buildingsMain)
            {
               if(_loc4_._type == 13 && _loc4_._canFunction)
               {
                  if(_loc4_._inProduction != "" && _loc2_ >= CREATURES.GetProperty(_loc4_._inProduction,"cStorage"))
                  {
                     _loc2_ -= CREATURES.GetProperty(_loc4_._inProduction,"cStorage");
                     if(this._finishQueue[_loc4_._inProduction])
                     {
                        ++this._finishQueue[_loc4_._inProduction];
                     }
                     else
                     {
                        this._finishQueue[_loc4_._inProduction] = 1;
                     }
                     _loc3_ += _loc4_._countdownProduce.Get();
                  }
                  else if(_monsterQueue.length > 0)
                  {
                     if(_loc4_._canFunction && _loc4_._inProduction == "")
                     {
                        _loc4_._inProduction = _monsterQueue[0][0];
                        --_monsterQueue[0][1];
                        if(_monsterQueue[0][1] <= 0)
                        {
                           _monsterQueue.splice(0,1);
                        }
                        _loc4_._productionStage.Set(3);
                        _loc4_.Tick(1);
                        HATCHERYCC.Tick();
                        if(_monsterQueue.length == 0)
                        {
                           return;
                        }
                     }
                  }
               }
            }
            if(_monsterQueue.length > 0 && _loc2_ >= 10)
            {
               _loc5_ = int(_monsterQueue.length);
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc7_ = _monsterQueue[_loc6_][0];
                  if(_loc2_ >= CREATURES.GetProperty(_loc7_,"cStorage") * _monsterQueue[_loc6_][1])
                  {
                     _loc3_ += CREATURES.GetProperty(_loc7_,"cTime") * _monsterQueue[_loc6_][1];
                     _loc2_ -= CREATURES.GetProperty(_loc7_,"cStorage") * _monsterQueue[_loc6_][1];
                     if(this._finishQueue[_loc7_])
                     {
                        this._finishQueue[_loc7_] += _monsterQueue[_loc6_][1];
                     }
                     else
                     {
                        this._finishQueue[_loc7_] = _monsterQueue[_loc6_][1];
                     }
                  }
                  else if(_loc2_ >= CREATURES.GetProperty(_loc7_,"cStorage"))
                  {
                     _loc3_ += CREATURES.GetProperty(_loc7_,"cTime") * (_loc2_ / CREATURES.GetProperty(_loc7_,"cStorage"));
                     if(this._finishQueue[_loc7_])
                     {
                        this._finishQueue[_loc7_] += _loc2_ / CREATURES.GetProperty(_loc7_,"cStorage");
                     }
                     else
                     {
                        this._finishQueue[_loc7_] = _loc2_ / CREATURES.GetProperty(_loc7_,"cStorage");
                     }
                     this._finishAll = false;
                     break;
                  }
                  _loc6_++;
               }
            }
         }
         else
         {
            _canFunction = false;
         }
         if(_canFunction && _loc3_ > 0)
         {
            this._finishCost.Set(STORE.GetTimeCost(_loc3_,false) * 4);
         }
         else
         {
            this._finishCost.Set(0);
         }
      }
      
      public function FinishNow() : *
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:Point = null;
         var _loc4_:BFOUNDATION = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(!_canFunction)
         {
            GLOBAL.Message(KEYS.Get("building_hcc_cantfunction"));
            return;
         }
         if(BASE._credits.Get() >= this._finishCost.Get())
         {
            _loc1_ = [];
            _loc2_ = HOUSING._housingSpace.Get();
            for each(_loc4_ in BASE._buildingsMain)
            {
               if(_loc4_._type == 13 && _loc4_._canFunction)
               {
                  _loc1_.push(_loc4_);
                  if(_loc4_._inProduction != "" && _loc2_ >= CREATURES.GetProperty(_loc4_._inProduction,"cStorage"))
                  {
                     _loc3_ = new Point(_loc4_._mc.x - 10 + Math.random() * 20,_loc4_._mc.y - 10 + Math.random() * 20);
                     HOUSING.HousingStore(_loc4_._inProduction,_loc3_);
                     _loc2_ -= CREATURES.GetProperty(_loc4_._inProduction,"cStorage");
                     _loc4_._inProduction = "";
                     _loc4_._productionStage.Set(0);
                  }
               }
            }
            if(_monsterQueue.length > 0)
            {
               while(_monsterQueue.length > 0 && _loc2_ > 0)
               {
                  _loc6_ = _monsterQueue[0][0];
                  _loc7_ = CREATURES.GetProperty(_loc6_,"cStorage");
                  while(_monsterQueue[0][1] > 0 && _loc2_ >= _loc7_)
                  {
                     if(_loc2_ >= _loc7_)
                     {
                        _loc8_ = int(Math.random() * _loc1_.length);
                        _loc3_ = new Point(_loc1_[_loc8_]._mc.x - 10 + Math.random() * 20,_loc1_[_loc8_]._mc.y - 10 + Math.random() * 20);
                        --_monsterQueue[0][1];
                        _loc2_ -= _loc7_;
                        HOUSING.HousingStore(_loc6_,_loc3_);
                     }
                  }
                  if(_monsterQueue[0][1] <= 0)
                  {
                     _monsterQueue.shift();
                  }
                  else if(_loc2_ < _loc7_)
                  {
                     break;
                  }
               }
            }
            BASE.Purchase("FQ",this._finishCost.Get(),"BUILDING16.FinishNow");
         }
         else
         {
            POPUPS.DisplayGetShiny();
         }
      }
      
      override public function Constructed() : *
      {
         var Brag:Function;
         var building:BFOUNDATION = null;
         var i:int = 0;
         var mc:MovieClip = null;
         super.Constructed();
         GLOBAL._bHatcheryCC = this;
         for each(building in BASE._buildingsMain)
         {
            if(building._type == 13)
            {
               i = 0;
               while(i < building._monsterQueue.length)
               {
                  BASE.Fund(4,building._monsterQueue[i][1] * CREATURES.GetProperty(building._monsterQueue[i][0],"cResource"));
                  i++;
               }
               building._monsterQueue = [];
            }
         }
         if(GLOBAL._mode == "build" && BASE._yardType == BASE.MAIN_YARD)
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["build-hcc",KEYS.Get("pop_hccbuilt_streamtitle"),KEYS.Get("pop_hccbuilt_streambody"),"build-hatcherycontrolcenter.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_hccbuilt_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_hccbuilt_body");
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.v2.png");
         }
      }
      
      override public function RecycleC() : *
      {
         GLOBAL._bHatcheryCC = null;
         super.RecycleC();
      }
      
      override public function Upgraded() : *
      {
         super.Upgraded();
      }
      
      override public function Setup(param1:Object) : *
      {
         _monsterQueue = [];
         if(param1.mq)
         {
            _monsterQueue = param1.mq;
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
         if(_countdownBuild.Get() == 0)
         {
            GLOBAL._bHatcheryCC = this;
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

