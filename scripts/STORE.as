package
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import com.monsters.display.ImageCache;
   import com.monsters.display.ScrollSet;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.geom.Rectangle;
   import flash.net.*;
   
   public class STORE
   {
      public static var _storeTabs:Array;
      
      public static var _storeItems:Object;
      
      public static var _storeInventory:Object;
      
      public static var _grouping:Array;
      
      public static var _storeData:Object;
      
      public static var _mc:STOREPOPUP;
      
      public static var _streamline:STREAMLINESPEEDUP_CLIP;
      
      public static var _streamline_time:Number;
      
      public static var _streamline_cost:Number;
      
      public static var _items:Object;
      
      public static var _itemsHeight:int;
      
      public static var _jumpTo:int;
      
      public static var _scrollRect:Rectangle;
      
      public static var _code:String;
      
      public static var _cost:int;
      
      public static var _quantity:int;
      
      public static var _duration:int;
      
      public static var _update:Array;
      
      public static var _tab:int;
      
      public static var _page:Number;
      
      public static var _open:Boolean;
      
      public static var _facebookPurchaseItemCode:String;
      
      public static var _scroller:ScrollSet;
      
      public static var _zazzleMC:MovieClip;
      
      public static var _scrollPos:Number = 0;
      
      public static var _scrollUpdate:Boolean = true;
      
      public static var _scrollPosUpdate:Boolean = false;
      
      public static var _customPage:Array = [];
      
      public static var _repairCount:int = 0;
      
      public function STORE()
      {
         super();
      }
      
      public static function Data(param1:Object, param2:Object, param3:Object = null) : *
      {
         _storeItems = {};
         _storeData = {};
         _storeInventory = {};
         GLOBAL._monsterOverdrive = new SecNum(0);
         if(!param1 || !param2)
         {
            return;
         }
         if(param1 != null)
         {
            _storeItems = param1;
            _storeData = param2;
            if(param3)
            {
               InventoryImport(param3);
            }
            Variables();
            ProcessPurchases();
         }
      }
      
      private static function InventoryImport(param1:Object) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            _storeInventory[_loc2_] = new SecNum(param1[_loc2_]);
         }
      }
      
      public static function InventoryExport() : String
      {
         var _loc2_:String = null;
         var _loc1_:Object = {};
         for(_loc2_ in _storeInventory)
         {
            _loc1_[_loc2_] = _storeInventory[_loc2_].Get();
         }
         return com.adobe.serialization.json.JSON.encode(_loc1_);
      }
      
      public static function GetTimeCost(param1:int, param2:Boolean = true) : int
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         if(param2 && param1 <= 5 * 60)
         {
            return 0;
         }
         _loc3_ = Math.ceil(param1 * 20 / 60 / 60);
         _loc4_ = int(Math.sqrt(param1 * 0.8));
         return Math.min(_loc3_,_loc4_);
      }
      
      public static function Variables() : *
      {
         var _loc2_:int = 0;
         var _loc6_:BFOUNDATION = null;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:BFOUNDATION = null;
         var _loc12_:Number = 0;
         var _loc13_:Number = 0;
         var _loc14_:Number = 0;
         var _loc15_:Number = 0;
         var _loc16_:Object = null;
         var _loc17_:int = 0;
         var _loc18_:String = null;
         if(BASE._yardType == BASE.OUTPOST)
         {
            _grouping = [[["BST","BLK2","BLK3","BLK4","BLK5"]],[["BR11","BR12","BR13","BR21","BR22","BR23","BR31","BR32","BR33","BR41","BR42","BR43"]],[["SP1","SP2","SP3","SP4","POD","FIX","HOD","HOD2","HOD3"]],[["PRO1","PRO2","PRO3","TOD","EXH"]]];
         }
         else if(BASE._yardType == BASE.MAIN_YARD)
         {
            _grouping = [[["BEW","BST","ENL","BLK2","BLK3","BLK4","BLK5"]],[["BR11","BR12","BR13","BR21","BR22","BR23","BR31","BR32","BR33","BR41","BR42","BR43","BIP","MUSK"]],[["SP1","SP2","SP3","SP4","POD","FIX","HOD","HOD2","HOD3"]],[["PRO1","PRO2","PRO3","MOD","MDOD","MSOD","EXH","TOD"]]];
         }
         else
         {
            _grouping = [[["BLK2I","BLK3I"]],[["BR11I","BR12I","BR13I","BR21I","BR22I","BR23I","BR31I","BR32I","BR33I","BR41I","BR42I","BR43I","BIP"]],[["SP1","SP2","SP3","SP4","FIX","HODI","HOD2I","HOD3I"]],[["PRO1","PRO2","PRO3","EXHI","TODI"]]];
         }
         var _loc1_:int = 1;
         while(_loc1_ <= 4)
         {
            _loc17_ = BASE._resources["r" + _loc1_ + "max"] * 0.1;
            if(BASE.isInferno())
            {
               _loc16_ = _storeItems["BR" + _loc1_ + "1I"];
            }
            else
            {
               _loc16_ = _storeItems["BR" + _loc1_ + "1"];
            }
            _loc16_.t = KEYS.Get("str_top_extra",{
               "v1":GLOBAL.FormatNumber(_loc17_),
               "v2":KEYS.Get(GLOBAL._resourceNames[_loc1_ - 1])
            });
            if(BASE._resources["r" + _loc1_].Get() + BASE._resources["r" + _loc1_ + "max"] * 0.1 < BASE._resources["r" + _loc1_ + "max"])
            {
               _loc16_.c = [Math.ceil(Math.pow(Math.sqrt(_loc17_ / 2),0.75))];
               _loc16_.d = KEYS.Get("str_top_10pct",{
                  "v1":GLOBAL._resourceNames[_loc1_ - 1],
                  "v2":GLOBAL._resourceNames[_loc1_ - 1],
                  "v3":GLOBAL.FormatNumber(BASE._resources["r" + _loc1_].Get() + _loc17_)
               });
               _loc16_.quantity = _loc17_;
            }
            else
            {
               _loc16_.d = KEYS.Get("str_top_10pct_noroom",{"v1":GLOBAL._resourceNames[_loc1_ - 1]});
               _loc16_.c = [0];
               _loc16_.quantity = 0;
            }
            _loc17_ = BASE._resources["r" + _loc1_ + "max"] * 0.5;
            if(BASE.isInferno())
            {
               _loc16_ = _storeItems["BR" + _loc1_ + "2I"];
            }
            else
            {
               _loc16_ = _storeItems["BR" + _loc1_ + "2"];
            }
            _loc16_.t = KEYS.Get("str_top_extra",{
               "v1":GLOBAL.FormatNumber(_loc17_),
               "v2":KEYS.Get(GLOBAL._resourceNames[_loc1_ - 1])
            });
            if(BASE._resources["r" + _loc1_].Get() + BASE._resources["r" + _loc1_ + "max"] * 0.5 < BASE._resources["r" + _loc1_ + "max"])
            {
               _loc16_.c = [Math.ceil(Math.pow(Math.sqrt(_loc17_ / 2),0.75))];
               _loc16_.d = KEYS.Get("str_top_50pct",{
                  "v1":GLOBAL._resourceNames[_loc1_ - 1],
                  "v2":GLOBAL._resourceNames[_loc1_ - 1],
                  "v3":GLOBAL.FormatNumber(BASE._resources["r" + _loc1_].Get() + _loc17_)
               });
               _loc16_.quantity = _loc17_;
            }
            else
            {
               _loc16_.d = KEYS.Get("str_top_50pct_noroom",{"v1":GLOBAL._resourceNames[_loc1_ - 1]});
               _loc16_.c = [0];
               _loc16_.quantity = 0;
            }
            if(BASE.isInferno())
            {
               _loc16_ = _storeItems["BR" + _loc1_ + "3I"];
            }
            else
            {
               _loc16_ = _storeItems["BR" + _loc1_ + "3"];
            }
            _loc16_.t = KEYS.Get("str_top_fill_label",{"v1":GLOBAL._resourceNames[_loc1_ - 1]});
            if(BASE._resources["r" + _loc1_ + "max"] > BASE._resources["r" + _loc1_].Get())
            {
               _loc17_ = BASE._resources["r" + _loc1_ + "max"] - BASE._resources["r" + _loc1_].Get();
               _loc16_.c = [Math.ceil(Math.pow(Math.sqrt(_loc17_ / 2),0.75))];
               _loc16_.d = KEYS.Get("str_top_fill",{
                  "v1":GLOBAL.FormatNumber(_loc17_),
                  "v2":GLOBAL._resourceNames[_loc1_ - 1]
               });
               _loc16_.quantity = _loc17_;
            }
            else
            {
               _loc16_.d = KEYS.Get("str_resourcesfull",{"v1":KEYS.Get(GLOBAL._resourceNames[_loc1_ - 1])});
               _loc16_.c = [0];
               _loc16_.quantity = 0;
            }
            _loc1_++;
         }
         if(GLOBAL._selectedBuilding)
         {
            if(GLOBAL._selectedBuilding._repairing)
            {
               _loc2_ = GetTimeCost(GLOBAL._selectedBuilding._repairTime);
            }
            else if(GLOBAL._selectedBuilding._countdownBuild.Get() > 0)
            {
               _loc2_ = GetTimeCost(GLOBAL._selectedBuilding._countdownBuild.Get());
            }
            else if(GLOBAL._selectedBuilding._countdownUpgrade.Get() > 0)
            {
               _loc2_ = GetTimeCost(GLOBAL._selectedBuilding._countdownUpgrade.Get());
            }
            else if(GLOBAL._selectedBuilding._countdownFortify.Get() > 0)
            {
               _loc2_ = GetTimeCost(GLOBAL._selectedBuilding._countdownFortify.Get());
            }
            else if(GLOBAL._selectedBuilding._type == 8)
            {
               for(_loc18_ in CREATURELOCKER._lockerData)
               {
                  if(CREATURELOCKER._lockerData[_loc18_].t == 1)
                  {
                     _loc2_ = GetTimeCost(CREATURELOCKER._lockerData[_loc18_].e - GLOBAL.Timestamp());
                     break;
                  }
               }
            }
            else if(GLOBAL._selectedBuilding._type == 26 && Boolean(ACADEMY._monsterID))
            {
               _loc2_ = GetTimeCost(ACADEMY._upgrades[ACADEMY._monsterID].time.Get() - GLOBAL.Timestamp());
            }
            else if(GLOBAL._selectedBuilding._type == 116 && Boolean((GLOBAL._bLab as MONSTERLAB)._upgrading))
            {
               _loc2_ = GetTimeCost((GLOBAL._bLab as MONSTERLAB)._upgradeFinishTime.Get() - GLOBAL.Timestamp());
            }
            _storeItems.SP4.c = [_loc2_];
         }
         var _loc4_:int = 0;
         _repairCount = 0;
         var _loc5_:int = 0;
         for each(_loc6_ in BASE._buildingsAll)
         {
            if(_loc6_._repairing)
            {
               _repairCount += 1;
               if(_loc6_._repairTime > 5 * 60)
               {
                  _loc4_ += _loc6_._repairTime;
                  _loc5_ += 1;
               }
            }
         }
         _storeItems.FIX.c = [GetTimeCost(_loc4_) + _loc5_ * 10];
         _storeItems.FIX.d = KEYS.Get("desc_repairbdgs",{"v1":_repairCount});
         _storeItems.FIX.t = KEYS.Get("str_repairbdgs");
         _loc7_ = 0;
         _loc8_ = 0;
         _loc9_ = 0;
         _loc10_ = 0;
         _loc12_ = 3;
         _loc13_ = 6;
         _loc14_ = 10;
         _loc15_ = 15;
         for each(_loc11_ in BASE._buildingsWalls)
         {
            if(_loc11_._lvl == null || _loc11_._lvl.Get() <= 1)
            {
               _loc8_ += _loc12_;
               _loc9_ += 10000;
               _loc10_ += 1;
            }
         }
         if(BASE.isInferno())
         {
            _storeItems.BLK2I.c = [_loc8_];
            _storeItems.BLK2I.d = KEYS.Get("bi_wall_2_str_desc",{
               "v1":_loc10_,
               "v2":GLOBAL.FormatNumber(_loc9_)
            });
            _storeItems.BLK2I.t = KEYS.Get("#bi_wall_2#");
         }
         else
         {
            _storeItems.BLK2.c = [_loc8_];
            _storeItems.BLK2.d = KEYS.Get("desc_stonewalls",{
               "v1":_loc10_,
               "v2":GLOBAL.FormatNumber(_loc9_)
            });
            _storeItems.BLK2.t = KEYS.Get("str_stonewalls");
         }
         _loc8_ = 0;
         _loc10_ = 0;
         _loc9_ = 0;
         for each(_loc11_ in BASE._buildingsWalls)
         {
            if(_loc11_._lvl.Get() <= 1)
            {
               _loc8_ += _loc12_ + _loc13_;
               _loc9_ += 110000;
               _loc10_ += 1;
            }
            if(_loc11_._lvl.Get() == 2)
            {
               _loc8_ += _loc13_;
               _loc9_ += 100000;
               _loc10_ += 1;
            }
         }
         if(BASE.isInferno())
         {
            _storeItems.BLK3I.c = [_loc8_];
            _storeItems.BLK3I.d = KEYS.Get("bi_wall_3_str_desc",{
               "v1":_loc10_,
               "v2":GLOBAL.FormatNumber(_loc9_)
            });
            _storeItems.BLK3I.t = KEYS.Get("#bi_wall_3#");
         }
         else
         {
            _storeItems.BLK3.c = [_loc8_];
            _storeItems.BLK3.d = KEYS.Get("desc_metalwalls",{
               "v1":_loc10_,
               "v2":GLOBAL.FormatNumber(_loc9_)
            });
            _storeItems.BLK3.t = KEYS.Get("str_metalwalls");
         }
         if(!BASE.isInferno())
         {
            _loc8_ = 0;
            _loc10_ = 0;
            _loc9_ = 0;
            for each(_loc11_ in BASE._buildingsWalls)
            {
               if(_loc11_._lvl.Get() <= 1)
               {
                  _loc8_ += _loc12_ + _loc13_ + _loc14_;
                  _loc9_ += 310000;
                  _loc10_ += 1;
               }
               if(_loc11_._lvl.Get() == 2)
               {
                  _loc8_ += _loc13_ + _loc14_;
                  _loc9_ += 300000;
                  _loc10_ += 1;
               }
               if(_loc11_._lvl.Get() == 3)
               {
                  _loc8_ += _loc14_;
                  _loc9_ += 200000;
                  _loc10_ += 1;
               }
            }
            _storeItems.BLK4.c = [_loc8_];
            _storeItems.BLK4.d = KEYS.Get("desc_goldwalls",{
               "v1":_loc10_,
               "v2":GLOBAL.FormatNumber(_loc9_)
            });
            _storeItems.BLK4.t = KEYS.Get("str_goldwalls");
            _loc8_ = 0;
            _loc10_ = 0;
            _loc9_ = 0;
            for each(_loc11_ in BASE._buildingsWalls)
            {
               if(_loc11_._lvl.Get() <= 1)
               {
                  _loc8_ += _loc12_ + _loc13_ + _loc14_ + _loc15_;
                  _loc9_ += 710000;
                  _loc10_ += 1;
               }
               if(_loc11_._lvl.Get() == 2)
               {
                  _loc8_ += _loc13_ + _loc14_ + _loc15_;
                  _loc9_ += 700000;
                  _loc10_ += 1;
               }
               if(_loc11_._lvl.Get() == 3)
               {
                  _loc8_ += _loc14_ + _loc15_;
                  _loc9_ += 600000;
                  _loc10_ += 1;
               }
               if(_loc11_._lvl.Get() == 4)
               {
                  _loc8_ += _loc15_;
                  _loc9_ += 400000;
                  _loc10_ += 1;
               }
            }
            _storeItems.BLK5.c = [_loc8_];
            _storeItems.BLK5.d = KEYS.Get("desc_blackwalls",{
               "v1":_loc10_,
               "v2":GLOBAL.FormatNumber(_loc9_)
            });
            _storeItems.BLK5.t = KEYS.Get("str_blackwalls");
         }
         if(GLOBAL._bBaiter != null)
         {
            _storeItems.MUSK.c = [Math.ceil((MONSTERBAITER._muskLimit - MONSTERBAITER._musk) / 50)];
         }
         if(BASE.isInferno())
         {
            _storeItems.HODI.d = "Speed up all harvester production for 12 hours.";
            _storeItems.HODI.t = "Harvester Overdrive";
         }
         else
         {
            _storeItems.HOD.d = "Speed up all harvester production for 12 hours.";
            _storeItems.HOD.t = "Harvester Overdrive";
            _storeItems.POD.d = KEYS.Get("store_pod_desc");
            _storeItems.POD.t = KEYS.Get("store_pod_title");
         }
         _storeItems.EXH.d = KEYS.Get(BASE.isInferno() ? "store_exhi_desc" : "store_exh_desc");
         _storeItems.EXH.t = KEYS.Get("store_exh_title");
         _storeItems.EXHI.d = KEYS.Get(BASE.isInferno() ? "store_exhi_desc" : "store_exh_desc");
         _storeItems.EXHI.t = KEYS.Get("store_exc_title");
      }
      
      public static function AddInventory(param1:String) : *
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = int(_grouping.length);
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = int(_grouping[_loc6_].length);
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               _loc5_ = int(_grouping[_loc6_][_loc7_].length);
               _loc8_ = 0;
               while(_loc8_ < _loc5_)
               {
                  if(_grouping[_loc6_][_loc7_][_loc8_] == param1)
                  {
                     _loc2_ = true;
                     break;
                  }
                  _loc8_++;
               }
               if(_loc2_)
               {
                  break;
               }
               _loc7_++;
            }
            if(_loc2_)
            {
               break;
            }
            _loc6_++;
         }
         if(_loc2_)
         {
            if(_storeInventory[param1])
            {
               _storeInventory[param1].Add(1);
            }
            else
            {
               _storeInventory[param1] = new SecNum(1);
            }
            Update();
            BASE.Save();
         }
      }
      
      public static function GetInventory(param1:String) : int
      {
         if(param1.substr(0,2) == "SP")
         {
            param1 = param1.substr(0,3);
         }
         if(_storeInventory[param1])
         {
            return _storeInventory[param1].Get();
         }
         return 0;
      }
      
      public static function Show(param1:int = 1, param2:int = 1, param3:Array = null, param4:Boolean = false) : *
      {
         var tab:int = param1;
         var page:int = param2;
         var customPage:Array = param3;
         var force:Boolean = param4;
         return function(param1:MouseEvent):*
         {
            ShowB(tab,page,customPage,force);
         };
      }
      
      public static function ShowB(param1:int, param2:Number = 0, param3:Array = null, param4:Boolean = false) : *
      {
         if(GLOBAL._mode == "build")
         {
            if(Boolean(GLOBAL._bStore) || Boolean(BASE._yardType))
            {
               SOUNDS.Play("click1");
               if(BASE._yardType || GLOBAL._bStore._canFunction || param4)
               {
                  if(!_open)
                  {
                     _open = true;
                     _mc = new STOREPOPUP();
                     _mc.Center();
                     _mc.ScaleUp();
                     GLOBAL.BlockerAdd();
                     GLOBAL._layerWindows.addChild(_mc);
                     if(GLOBAL._newBuilding)
                     {
                        GLOBAL._newBuilding.Cancel();
                     }
                     if(BUILDINGS._open)
                     {
                        BUILDINGS.Hide();
                     }
                  }
                  _customPage = param3;
                  if(TUTORIAL._stage < 200)
                  {
                     _mc.tShinyBalance.visible = false;
                     _mc.bAdd.visible = false;
                  }
                  else
                  {
                     _mc.tShinyBalance.visible = true;
                     _mc.bAdd.SetupKey("ui_topaddshiny");
                     _mc.bAdd.addEventListener(MouseEvent.MOUSE_DOWN,BUY.Show);
                     if(BASE._credits.Get() <= 250)
                     {
                        _mc.bAdd.Highlight = true;
                     }
                  }
                  _mc.b1.SetupKey("str_construction",false,0,0,"#ECBF88");
                  _mc.b1.addEventListener(MouseEvent.CLICK,SwitchClick(1,0,true));
                  _mc.b2.SetupKey("str_resources",false,0,0,"#ECBF88");
                  _mc.b2.addEventListener(MouseEvent.CLICK,SwitchClick(2,0,true));
                  _mc.b3.SetupKey("str_speedups",false,0,0,"#ECBF88");
                  _mc.b3.addEventListener(MouseEvent.CLICK,SwitchClick(3,0,true));
                  _mc.b4.SetupKey("str_protection",false,0,0,"#ECBF88");
                  _mc.b4.addEventListener(MouseEvent.CLICK,SwitchClick(4,0,true));
                  if(!GLOBAL._flags.viximo && !GLOBAL._flags.kongregate)
                  {
                     _mc.b5.SetupKey("str_zazzle",false,0,0,"#ECBF88");
                     _mc.b5.addEventListener(MouseEvent.CLICK,SwitchClick(5,0,true));
                  }
                  else
                  {
                     _mc.b5.visible = false;
                  }
                  Switch(param1,param2,_customPage);
               }
               else
               {
                  GLOBAL.Message(KEYS.Get("str_damaged"));
               }
            }
            else
            {
               GLOBAL.Message(KEYS.Get("str_notbuilt"));
            }
         }
         Update();
      }
      
      public static function SpeedUp(param1:String) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc5_:MONSTERLAB = null;
         var _loc6_:String = null;
         if(GLOBAL._showStreamlinedSpeedUps && TUTORIAL._completed)
         {
            CalcCost(param1);
            _streamline = null;
            _loc2_ = GLOBAL._selectedBuilding;
            _loc3_ = _loc2_._countdownUpgrade.Get() + _loc2_._countdownBuild.Get() + _loc2_._countdownFortify.Get();
            if(_loc2_._repairing)
            {
               _loc3_ = _loc2_._repairTime;
            }
            if(GLOBAL._mode == "build" && _loc2_)
            {
               _streamline = new STREAMLINESPEEDUP_CLIP();
               if(_loc3_ > 0)
               {
                  if(_streamline_cost == 0)
                  {
                     _streamline.tTitle.x = -210;
                     _streamline.tDescription.x = -210;
                     _streamline.tTitle.htmlText = KEYS.Get("streamspd_close_title");
                     _streamline.tDescription.htmlText = KEYS.Get("streamspd_close_desc");
                     _streamline.mcInstant.tDescription.visible = false;
                     _streamline.mcInstant.gCoin.visible = false;
                     _streamline.mcInstant.gArrow.visible = false;
                     _streamline.mcStoreIcon.visible = false;
                     _streamline.mcInstant.bAction.Setup(KEYS.Get("str_finishnow"));
                  }
                  else
                  {
                     _streamline.tTitle.x = -100;
                     _streamline.tDescription.x = -100;
                     _streamline.tTitle.htmlText = KEYS.Get("streamspd_title");
                     _streamline.tDescription.htmlText = KEYS.Get("streamspd_desc",{"v1":GLOBAL.ToTime(_streamline_time,false,false)});
                     _streamline.mcInstant.tDescription.visible = true;
                     _streamline.mcInstant.gCoin.visible = true;
                     _streamline.mcInstant.gArrow.visible = true;
                     _streamline.mcStoreIcon.visible = true;
                     _streamline.mcInstant.tDescription.htmlText = "<b>" + KEYS.Get("streamspd_upgrade") + "</b>";
                     _streamline.mcInstant.bAction.Setup(KEYS.Get("btn_useshiny",{"v1":_streamline_cost}));
                  }
               }
               else if(_loc2_._type == 8)
               {
                  if(CREATURELOCKER._unlocking != null)
                  {
                     _loc3_ = 0;
                     _loc3_ = CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e - GLOBAL.Timestamp();
                     _loc4_ = CREATURELOCKER._creatures[CREATURELOCKER._unlocking].name;
                     if(_loc3_ > 0)
                     {
                        if(param1 == "SP1")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_closeenough");
                           _streamline.tDescription.htmlText = KEYS.Get("str_closeenough_unlock",{"v1":_loc4_});
                           if(_loc3_ <= 300)
                           {
                              _streamline.tDescription.htmlText = KEYS.Get("str_closeenough_unlock",{"v1":_loc4_});
                           }
                        }
                        else if(param1.substr(0,3) == "SP2")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_30minutes_unlocklabel");
                           _streamline.tDescription.htmlText = KEYS.Get("str_30minutes_unlockdesc",{"v1":_loc4_});
                        }
                        else if(param1.substr(0,3) == "SP3")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_60minutes_unlocklabel");
                           _streamline.tDescription.htmlText = KEYS.Get("str_60minutes_unlockdesc",{"v1":_loc4_});
                        }
                        else if(param1.substr(0,3) == "SP4")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_finishnow_unlocklabel",{"v1":_loc4_});
                           _streamline.tDescription.htmlText = KEYS.Get("str_finishnow_unlocktimesave",{
                              "v1":GLOBAL.ToTime(_loc3_,false,false),
                              "v2":_loc4_
                           });
                        }
                     }
                  }
               }
               else if(_loc2_._type == 26)
               {
                  if(ACADEMY._monsterID != null)
                  {
                     _loc3_ = ACADEMY._upgrades[ACADEMY._monsterID].time.Get() - GLOBAL.Timestamp();
                     _loc4_ = CREATURELOCKER._creatures[ACADEMY._monsterID].name;
                     if(_loc3_ > 0)
                     {
                        if(param1 == "SP1")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_closeenough");
                           _streamline.tDescription.htmlText = KEYS.Get("str_closeenough_traindesc",{"v1":_loc4_});
                           if(_loc3_ <= 300)
                           {
                              _streamline.tDescription.htmlText = KEYS.Get("str_closeenough_traindesc_ok",{"v1":_loc4_});
                           }
                        }
                        else if(param1.substr(0,3) == "SP2")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_30minutes_trainlabel");
                           _streamline.tDescription.htmlText = KEYS.Get("str_30minutes_traindesc",{"v1":_loc4_});
                        }
                        else if(param1.substr(0,3) == "SP3")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_60minutes_trainlabel");
                           _streamline.tDescription.htmlText = KEYS.Get("str_60minutes_traindesc",{"v1":_loc4_});
                        }
                        else if(param1.substr(0,3) == "SP4")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_finishnow_trainlabel",{"v1":_loc4_});
                           _streamline.tDescription.htmlText = KEYS.Get("str_finishnow_unlocktimesave",{
                              "v1":GLOBAL.ToTime(_loc3_,false,false),
                              "v2":_loc4_
                           });
                        }
                     }
                  }
               }
               else if(_loc2_._type == 116)
               {
                  _loc5_ = _loc2_ as MONSTERLAB;
                  if(_loc5_._upgrading != null)
                  {
                     _loc3_ = _loc5_._upgradeFinishTime.Get() - GLOBAL.Timestamp();
                     _loc4_ = KEYS.Get(CREATURELOCKER._creatures[_loc5_._upgrading].name);
                     _loc6_ = KEYS.Get(MONSTERLAB._powerupProps[_loc5_._upgrading].name);
                     if(_loc3_ > 0)
                     {
                        if(param1 == "SP1")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_closeenough");
                           _streamline.tDescription.htmlText = KEYS.Get("str_closeenough_powerupdesc",{
                              "v1":_loc4_,
                              "v2":_loc6_
                           });
                           if(_loc3_ <= 300)
                           {
                              _streamline.tDescription.htmlText = KEYS.Get("str_closeenough_powerupdesc_ok",{
                                 "v1":_loc4_,
                                 "v2":_loc6_
                              });
                           }
                        }
                        else if(param1.substr(0,3) == "SP2")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_30minutes_poweruplabel",{"v1":_loc6_});
                           _streamline.tDescription.htmlText = KEYS.Get("str_30minutes_powerupdesc",{
                              "v1":_loc4_,
                              "v2":_loc6_
                           });
                        }
                        else if(param1.substr(0,3) == "SP3")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_60minutes_poweruplabel",{"v1":_loc6_});
                           _streamline.tDescription.htmlText = KEYS.Get("str_60minutes_powerupdesc",{
                              "v1":_loc4_,
                              "v2":_loc6_
                           });
                        }
                        else if(param1.substr(0,3) == "SP4")
                        {
                           _streamline.tTitle.htmlText = KEYS.Get("str_finishnow_poweruplabel",{"v1":_loc6_});
                           _streamline.tDescription.htmlText = KEYS.Get("str_finishnow_unlocktimesave",{
                              "v1":GLOBAL.ToTime(_loc3_,false,false),
                              "v2":_loc4_,
                              "v3":_loc6_
                           });
                        }
                     }
                  }
               }
               if(_loc3_ <= 300)
               {
                  _streamline.mcInstant.bAction.Setup(KEYS.Get("str_finishnow"));
               }
               else
               {
                  _streamline.mcInstant.bAction.Setup(KEYS.Get("btn_useshiny",{"v1":_streamline_cost}));
               }
               _streamline.mcInstant.bAction.addEventListener(MouseEvent.CLICK,StreamlineBuy);
               _streamline.mcInstant.gCoin.mouseEnabled = false;
               POPUPS.Push(_streamline,null,null,null,null);
            }
         }
         else if(param1 == "SP4")
         {
            STORE.ShowB(3,0,["SP1","SP2","SP3","SP4"]);
         }
         else if(param1 == "FIX")
         {
            STORE.ShowB(3,1,["FIX"],true);
         }
      }
      
      public static function StreamlineBuy(param1:MouseEvent = null) : void
      {
         if(_streamline_time < 5 * 60)
         {
            STORE.BuyB("SP1");
            POPUPS.Next();
         }
         else
         {
            if(_streamline_cost > BASE._credits.Get())
            {
               POPUPS.Next();
               POPUPS.DisplayGetShiny(param1);
               return;
            }
            STORE.BuyB("SP4");
            POPUPS.Next();
         }
      }
      
      public static function SwitchClick(param1:int, param2:int, param3:Boolean = false) : *
      {
         var tab:int = param1;
         var page:int = param2;
         var click:Boolean = param3;
         return function(param1:MouseEvent = null):*
         {
            _customPage = null;
            Switch(tab,page,null,click);
            _scroller.ScrollTo(0,0);
         };
      }
      
      public static function CalcCost(param1:String, param2:Boolean = false) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc19_:String = null;
         var _loc21_:* = null;
         var _loc24_:MONSTERLAB = null;
         var _loc25_:String = null;
         var _loc26_:int = 0;
         var _loc27_:Boolean = false;
         var _loc28_:Boolean = false;
         var _loc29_:Boolean = false;
         var _loc30_:Boolean = false;
         var _loc31_:BFOUNDATION = null;
         var _loc9_:String = param1;
         var _loc10_:Object = _storeItems[_loc9_];
         var _loc11_:Object = _storeData[_loc9_];
         var _loc12_:int = 0;
         var _loc16_:* = GLOBAL._selectedBuilding;
         var _loc17_:Boolean = false;
         var _loc18_:Array = _loc10_.c;
         _loc19_ = _loc9_;
         Variables();
         if(_loc19_.substr(0,2) == "SP")
         {
            _loc19_ = _loc19_.substr(0,3);
         }
         if(Boolean(_storeInventory[_loc19_]) && _storeInventory[_loc19_].Get() > 0)
         {
         }
         if(Boolean(_loc10_.fbc_cost) && _loc10_.fbc_cost[0] > 0)
         {
            _loc17_ = true;
            _loc18_ = _loc10_.fbc_cost;
         }
         if(_loc9_.substr(0,2) == "SP")
         {
            if(_loc9_ != "SP1")
            {
               if(_loc9_.substr(0,3) != "SP2")
               {
                  if(_loc9_.substr(0,3) != "SP3")
                  {
                     if(_loc9_.substr(0,3) == "SP4")
                     {
                     }
                  }
               }
            }
            if(_loc16_)
            {
               _loc12_ = _loc16_._countdownUpgrade.Get() + _loc16_._countdownBuild.Get() + _loc16_._countdownFortify.Get();
               if(_loc16_._repairing)
               {
                  _loc12_ = int(_loc16_._repairTime);
               }
               if(_loc12_ > 0)
               {
                  _loc14_ = "build";
                  _loc15_ = "building";
                  if(_loc16_._countdownUpgrade.Get() > 0)
                  {
                     _loc14_ = "upgrade";
                     _loc15_ = "upgrading";
                  }
                  if(_loc16_._countdownFortify.Get() > 0)
                  {
                     _loc14_ = "fortify";
                     _loc15_ = "fortifying";
                  }
                  if(_loc16_._repairing)
                  {
                     _loc14_ = "repair";
                     _loc15_ = "repairing";
                  }
                  if(_loc9_ != "SP1")
                  {
                     if(_loc9_.substr(0,3) != "SP2")
                     {
                        if(_loc9_.substr(0,3) != "SP3")
                        {
                           if(_loc9_.substr(0,3) == "SP4")
                           {
                           }
                        }
                     }
                  }
               }
               else if(_loc16_._type == 8)
               {
                  if(CREATURELOCKER._unlocking != null)
                  {
                     _loc12_ = 0;
                     _loc12_ = CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e - GLOBAL.Timestamp();
                     _loc13_ = CREATURELOCKER._creatures[CREATURELOCKER._unlocking].name;
                     if(_loc12_ > 0)
                     {
                        if(_loc9_ != "SP1")
                        {
                           if(_loc9_.substr(0,3) != "SP2")
                           {
                              if(_loc9_.substr(0,3) != "SP3")
                              {
                                 if(_loc9_.substr(0,3) == "SP4")
                                 {
                                 }
                              }
                           }
                        }
                     }
                  }
               }
               else if(_loc16_._type == 26)
               {
                  if(ACADEMY._monsterID != null)
                  {
                     _loc12_ = ACADEMY._upgrades[ACADEMY._monsterID].time.Get() - GLOBAL.Timestamp();
                     _loc13_ = CREATURELOCKER._creatures[ACADEMY._monsterID].name;
                     if(_loc12_ > 0)
                     {
                        if(_loc9_ != "SP1")
                        {
                           if(_loc9_.substr(0,3) != "SP2")
                           {
                              if(_loc9_.substr(0,3) != "SP3")
                              {
                                 if(_loc9_.substr(0,3) == "SP4")
                                 {
                                 }
                              }
                           }
                        }
                     }
                  }
               }
               else if(_loc16_._type == 116)
               {
                  _loc24_ = _loc16_ as MONSTERLAB;
                  if(_loc24_._upgrading != null)
                  {
                     _loc12_ = _loc24_._upgradeFinishTime.Get() - GLOBAL.Timestamp();
                     _loc13_ = KEYS.Get(CREATURELOCKER._creatures[_loc24_._upgrading].name);
                     _loc25_ = KEYS.Get(MONSTERLAB._powerupProps[_loc24_._upgrading].name);
                     if(_loc12_ > 0)
                     {
                        if(_loc9_ != "SP1")
                        {
                           if(_loc9_.substr(0,3) != "SP2")
                           {
                              if(_loc9_.substr(0,3) != "SP3")
                              {
                                 if(_loc9_.substr(0,3) == "SP4")
                                 {
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         else if(_loc9_.substr(0,3) != "BEW")
         {
            if(_loc9_ != "BST")
            {
               if(_loc9_ != "ENL")
               {
                  if(_loc9_ != "BIP")
                  {
                     if(_loc9_ != "MUSK")
                     {
                        if(_loc9_ != "HOD")
                        {
                           if(_loc9_ != "HOD2")
                           {
                              if(_loc9_ != "HOD3")
                              {
                                 if(_loc9_ != "PRO1")
                                 {
                                    if(_loc9_ != "PRO2")
                                    {
                                       if(_loc9_ != "PRO3")
                                       {
                                          if(_loc9_ != "TOD")
                                          {
                                             if(_loc9_ != "MOD")
                                             {
                                                if(_loc9_ != "MDOD")
                                                {
                                                   if(_loc9_ == "MSOD")
                                                   {
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         _loc4_ = 0;
         _loc5_ = int(_loc10_.c.length);
         if(_loc11_)
         {
            _loc4_ = _loc11_.q;
         }
         if(_loc10_.i)
         {
            _loc4_ = 0;
         }
         _loc6_ = "<b>" + _loc10_.t + "</b><br>" + _loc10_.d;
         if(_loc9_ == "BIP" && _storeData.BIP && _storeData.BIP.q < 10)
         {
            _loc6_ += " (Total increase of " + (_storeData.BIP.q + 1) * 10 + "%)";
         }
         var _loc20_:String = "";
         if(_loc9_.substr(0,2) == "BR" && _loc10_.c[0] == 0)
         {
            _loc19_ = _loc9_;
            if(_loc19_.substr(0,2) == "SP")
            {
               _loc19_ = _loc19_.substr(0,3);
            }
            if(!(_storeInventory[_loc19_] && _storeInventory[_loc19_].Get() > 0))
            {
               _loc20_ = KEYS.Get("str_prob_cantbuymore");
            }
         }
         if(_loc9_.substr(0,2) == "SP")
         {
            if(!_loc16_)
            {
               _loc20_ = KEYS.Get("str_prob_nobuilding");
            }
            else if(_loc16_)
            {
               _loc12_ = 0;
               if(_loc16_._repairing)
               {
                  _loc12_ = int(_loc16_._repairTime);
               }
               else if(_loc16_._countdownUpgrade.Get() + _loc16_._countdownBuild.Get() + _loc16_._countdownFortify.Get() > 0)
               {
                  _loc12_ = _loc16_._countdownUpgrade.Get() + _loc16_._countdownBuild.Get() + _loc16_._countdownFortify.Get();
               }
               else
               {
                  if(_loc16_._type == 8 && CREATURELOCKER._unlocking != null)
                  {
                     _loc12_ = CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e - GLOBAL.Timestamp();
                  }
                  if(_loc16_._type == 26 && ACADEMY._monsterID != null)
                  {
                     _loc12_ = ACADEMY._upgrades[ACADEMY._monsterID].time.Get() - GLOBAL.Timestamp();
                  }
                  if(_loc16_._type == 116 && (GLOBAL._bLab as MONSTERLAB)._upgrading != null)
                  {
                     _loc12_ = (GLOBAL._bLab as MONSTERLAB)._upgradeFinishTime.Get() - GLOBAL.Timestamp();
                  }
               }
               if(_loc12_ == 0)
               {
                  _loc20_ = KEYS.Get("str_prob_nothing");
               }
               else if(_loc9_ == "SP1" && _loc12_ > 300)
               {
                  _loc20_ = KEYS.Get("str_prob_morethan5");
               }
               else if(_loc9_.substr(0,3) == "SP2" && (_loc12_ < 3600 && !_storeInventory.SP2 || _storeInventory.SP2 && _loc12_ <= 300))
               {
                  _loc20_ = KEYS.Get("str_prob_notneeded");
               }
               else if(_loc9_.substr(0,3) == "SP3" && (_loc12_ < 7200 && !_storeInventory.SP3 || _storeInventory.SP3 && _loc12_ <= 300))
               {
                  _loc20_ = KEYS.Get("str_prob_notneeded");
               }
               else if(_loc9_.substr(0,3) == "SP4" && _loc12_ <= 300)
               {
                  _loc20_ = KEYS.Get("str_prob_notneeded");
               }
            }
            else
            {
               _loc20_ = KEYS.Get("str_prob_nothingselected");
            }
         }
         if(_loc9_.substr(0,3) == "HOD" && !GLOBAL._bHatchery)
         {
            _loc20_ = KEYS.Get("str_prob_nohatcheries");
         }
         if(_loc9_ == "CLOD" && !GLOBAL._bLocker)
         {
            _loc20_ = KEYS.Get("str_prob_nolocker");
         }
         if(_loc9_ == "MUSK")
         {
            if(GLOBAL._bBaiter == null)
            {
               _loc20_ = KEYS.Get("str_prob_nobaiter");
            }
            else if(MONSTERBAITER._musk >= MONSTERBAITER._muskLimit)
            {
               _loc20_ = KEYS.Get("str_prob_muskfull");
            }
         }
         if(_loc9_ == "FIX")
         {
            if(_repairCount == 0)
            {
               _loc20_ = KEYS.Get("str_prob_notneeded");
            }
         }
         if(_loc9_.substr(0,3) == "BLK")
         {
            _loc26_ = GLOBAL._bTownhall._lvl.Get();
            if(BASE._yardType == BASE.OUTPOST)
            {
               _loc26_ = 7;
            }
            if(BASE._yardType != BASE.OUTPOST && _loc26_ < 3 && _loc9_.substr(3,1) == "2")
            {
               _loc20_ = KEYS.Get("upgradeth",{"v1":3});
            }
            else if(BASE._yardType != BASE.OUTPOST && _loc26_ < 4 && _loc9_.substr(3,1) == "3")
            {
               _loc20_ = KEYS.Get("upgradeth",{"v1":4});
            }
            else if(BASE._yardType != BASE.OUTPOST && _loc26_ < 5 && _loc9_.substr(3,1) == "4")
            {
               _loc20_ = KEYS.Get("upgradeth",{"v1":5});
            }
            else if(BASE._yardType != BASE.OUTPOST && _loc26_ < 6 && _loc9_.substr(3,1) == "5")
            {
               _loc20_ = KEYS.Get("upgradeth",{"v1":6});
            }
            else
            {
               _loc27_ = false;
               _loc28_ = false;
               _loc29_ = false;
               _loc30_ = false;
               for each(_loc31_ in BASE._buildingsWalls)
               {
                  if(_loc31_._lvl.Get() == 1 && _loc26_ >= 3)
                  {
                     _loc27_ = true;
                     _loc28_ = true;
                     _loc29_ = true;
                     _loc30_ = true;
                     break;
                  }
                  if(_loc31_._lvl.Get() == 2 && _loc26_ >= 4)
                  {
                     _loc28_ = true;
                     _loc29_ = true;
                     _loc30_ = true;
                  }
                  if(_loc31_._lvl.Get() == 3 && _loc26_ >= 5)
                  {
                     _loc29_ = true;
                     _loc30_ = true;
                  }
                  if(_loc31_._lvl.Get() == 4 && _loc26_ >= 6)
                  {
                     _loc30_ = true;
                  }
               }
            }
         }
         var _loc22_:Number = 0;
         var _loc23_:Number = 0;
         if(_loc17_)
         {
            _loc21_ = "<b><font color=\"#335280\">" + GLOBAL.FormatNumber(_loc10_.fbc_cost[_loc4_]) + "</font></b>";
            _loc22_ = Number(_loc10_.fbc_cost[_loc4_]);
         }
         else
         {
            _loc21_ = "<b>" + GLOBAL.FormatNumber(_loc10_.c[_loc4_]) + "</b>";
            _loc22_ = Number(_loc10_.c[_loc4_]);
            if(_loc10_.c[_loc4_] == 0 && _loc20_ == "")
            {
               _loc21_ = "<font color=\"#0000CC\"><b>" + KEYS.Get("str_buy_free") + "</b></font>";
               _loc22_ = 0;
            }
         }
         if(_loc20_ != "")
         {
            _loc19_ = _loc9_;
            if(_loc19_.substr(0,2) == "SP")
            {
               _loc19_ = _loc19_.substr(0,3);
            }
            if(Boolean(_storeInventory[_loc19_]) && _storeInventory[_loc19_].Get() > 0)
            {
               _loc7_ = "<font color=\"#0000ff\"><b>" + _storeInventory[_loc19_].Get() + "</b></font>";
               _loc23_ = Number(_storeInventory[_loc19_].Get());
            }
            else
            {
               _loc7_ = _loc21_;
               _loc23_ = _loc22_;
            }
         }
         else
         {
            if(BASE._pendingPurchase.length > 0)
            {
            }
            if(_loc4_ >= _loc5_ && !_loc10_.i || _loc9_.substr(0,3) == "BEW" && QUEUE._workerCount >= 5 || _loc9_.substr(0,2) == "BR" && BASE._resources["r" + _loc9_.substr(2,1)].Get() >= BASE._resources["r" + _loc9_.substr(2,1) + "max"])
            {
               _loc19_ = _loc9_;
               if(_loc19_.substr(0,2) == "SP")
               {
                  _loc19_ = _loc19_.substr(0,3);
               }
               if(Boolean(_storeInventory[_loc19_]) && _storeInventory[_loc19_].Get() > 0)
               {
                  _loc7_ = "<font color=\"#0000ff\"><b>" + _storeInventory[_loc19_].Get() + "</b></font>";
                  _loc23_ = Number(_storeInventory[_loc19_].Get());
               }
               else
               {
                  _loc7_ = "<font color=\"#CC0000\">" + KEYS.Get("str_prob_soldout") + "</font>";
                  _loc23_ = -1;
               }
            }
            else
            {
               _loc19_ = _loc9_;
               if(_loc19_.substr(0,2) == "SP")
               {
                  _loc19_ = _loc19_.substr(0,3);
               }
               if(Boolean(_storeInventory[_loc19_]) && Boolean(_storeInventory[_loc19_].Get()))
               {
                  _loc7_ = "<font color=\"#0000ff\"><b>" + _storeInventory[_loc19_].Get() + "</b></font>";
                  _loc23_ = Number(_storeInventory[_loc19_].Get());
               }
               else
               {
                  if(_loc10_.i)
                  {
                     _loc4_ = 0;
                  }
                  _loc7_ = _loc21_;
                  _loc23_ = _loc22_;
               }
            }
         }
         _streamline_time = _loc12_;
         _streamline_cost = _loc23_;
         if(param2)
         {
            return _loc23_;
         }
         return _loc7_;
      }
      
      public static function Switch(param1:int, param2:Number, param3:Array = null, param4:Boolean = false) : *
      {
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = null;
         var _loc13_:Array = null;
         var _loc20_:String = null;
         var _loc21_:Object = null;
         var _loc22_:Object = null;
         var _loc23_:* = undefined;
         var _loc24_:int = 0;
         var _loc25_:String = null;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:* = undefined;
         var _loc29_:Boolean = false;
         var _loc30_:Array = null;
         var _loc31_:String = null;
         var _loc32_:String = null;
         var _loc33_:* = null;
         var _loc34_:MONSTERLAB = null;
         var _loc35_:String = null;
         var _loc36_:int = 0;
         var _loc37_:Boolean = false;
         var _loc38_:Boolean = false;
         var _loc39_:Boolean = false;
         var _loc40_:Boolean = false;
         var _loc41_:BFOUNDATION = null;
         if(param4)
         {
            SOUNDS.Play("click1");
         }
         Variables();
         ZazzleClear();
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(!_customPage)
         {
            if(param2 < 0)
            {
               param2 = 0;
            }
            if(param2 > 1)
            {
               param2 = 1;
            }
         }
         if(param1 == _tab)
         {
            _scrollUpdate = false;
         }
         else
         {
            _scrollUpdate = true;
         }
         if(param2 == _page)
         {
            _scrollPosUpdate = false;
         }
         else
         {
            _scrollPosUpdate = true;
         }
         _tab = param1;
         _page = param2;
         var _loc5_:int = 1;
         while(_loc5_ <= 5)
         {
            (_mc["b" + _loc5_] as ButtonBrown).Highlight = false;
            _loc5_++;
         }
         if(!_customPage)
         {
            (_mc["b" + _tab] as ButtonBrown).Highlight = true;
            _mc.window.gotoAndStop(_tab);
         }
         else
         {
            _mc.window.gotoAndStop(6);
         }
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         _update = [];
         if(Boolean(_items) && Boolean(_items.parent))
         {
            _items.parent.removeChild(_items);
            _items = null;
         }
         _items = _mc.window.content.addChild(new MovieClip());
         _items.x = 5;
         _items.y = 8;
         if(_scroller && _scroller.parent && _scrollUpdate)
         {
            _scroller.parent.removeChild(_scroller);
            _scroller = null;
         }
         if(_scrollUpdate)
         {
            _scroller = new ScrollSet();
            _scroller.x = 327;
            _scroller.y = -200.05;
            _scroller.width = 21;
            _mc.addChild(_scroller);
            _scroller.AutoHideEnabled = false;
         }
         if(_customPage)
         {
            _loc13_ = _customPage;
         }
         else if(param1 == 5)
         {
            _loc13_ = [];
            ZazzleAdd();
         }
         else
         {
            _loc13_ = _grouping[_tab - 1][0];
         }
         var _loc14_:Number = 0;
         var _loc16_:Number = 0;
         var _loc19_:int = 0;
         while(_loc19_ < _loc13_.length)
         {
            _loc20_ = _loc13_[_loc19_];
            _loc21_ = _storeItems[_loc20_];
            _loc22_ = _storeData[_loc20_];
            _loc23_ = new STOREITEM();
            _loc24_ = 0;
            _loc28_ = GLOBAL._selectedBuilding;
            _loc29_ = false;
            _loc30_ = _loc21_.c;
            _loc31_ = _loc20_;
            _loc23_.name = _loc31_;
            if(_loc31_.substr(0,2) == "SP")
            {
               _loc31_ = _loc31_.substr(0,3);
            }
            if(Boolean(_storeInventory[_loc31_]) && _storeInventory[_loc31_].Get() > 0)
            {
               _loc23_.gotoAndStop(2);
            }
            else
            {
               _loc23_.gotoAndStop(1);
            }
            if(Boolean(_loc21_.fbc_cost) && _loc21_.fbc_cost[0] > 0)
            {
               _loc29_ = true;
               _loc30_ = _loc21_.fbc_cost;
            }
            if(_loc20_.substr(0,2) == "SP")
            {
               if(_loc20_ == "SP1")
               {
                  _loc21_.t = KEYS.Get("str_closeenough");
               }
               else if(_loc20_.substr(0,3) == "SP2")
               {
                  _loc21_.t = KEYS.Get("str_30minutes");
               }
               else if(_loc20_.substr(0,3) == "SP3")
               {
                  _loc21_.t = KEYS.Get("str_60minutes");
               }
               else if(_loc20_.substr(0,3) == "SP4")
               {
                  _loc21_.t = KEYS.Get("str_finishnow");
               }
               _loc21_.d = KEYS.Get("str_speedup_na");
               if(_loc28_)
               {
                  _loc24_ = _loc28_._countdownUpgrade.Get() + _loc28_._countdownBuild.Get() + _loc28_._countdownFortify.Get();
                  if(_loc28_._repairing)
                  {
                     _loc24_ = int(_loc28_._repairTime);
                  }
                  if(_loc24_ > 0)
                  {
                     _loc26_ = KEYS.Get("str_build");
                     _loc27_ = KEYS.Get("str_building");
                     if(_loc28_._countdownUpgrade.Get() > 0)
                     {
                        _loc26_ = KEYS.Get("str_upgrade");
                        _loc27_ = KEYS.Get("str_upgrading");
                     }
                     if(_loc28_._countdownFortify.Get() > 0)
                     {
                        _loc26_ = KEYS.Get("str_fortify");
                        _loc27_ = KEYS.Get("str_fortifying");
                     }
                     if(_loc28_._repairing)
                     {
                        _loc26_ = KEYS.Get("str_repair");
                        _loc27_ = KEYS.Get("str_repairing");
                     }
                     if(_loc20_ == "SP1")
                     {
                        _loc21_.t = KEYS.Get("str_closeenough");
                        _loc21_.d = KEYS.Get("str_closeenough_desc",{
                           "v1":_loc27_,
                           "v2":_loc28_._buildingProps.name
                        });
                        if(_loc24_ <= 300)
                        {
                           _loc21_.d = KEYS.Get("str_closeenough_desc_ok",{
                              "v1":_loc27_,
                              "v2":_loc28_._buildingProps.name
                           });
                        }
                     }
                     else if(_loc20_.substr(0,3) == "SP2")
                     {
                        _loc21_.t = KEYS.Get("str_30minutes");
                        _loc21_.d = KEYS.Get("str_30minutes_desc",{
                           "v1":_loc26_,
                           "v2":_loc28_._buildingProps.name
                        });
                     }
                     else if(_loc20_.substr(0,3) == "SP3")
                     {
                        _loc21_.t = KEYS.Get("str_60minutes");
                        _loc21_.d = KEYS.Get("str_60minutes_desc",{
                           "v1":_loc26_,
                           "v2":_loc28_._buildingProps.name
                        });
                     }
                     else if(_loc20_.substr(0,3) == "SP4")
                     {
                        _loc21_.t = KEYS.Get("str_finishnow_desc",{"v1":_loc26_});
                        _loc21_.d = KEYS.Get("str_finishnow_timesave",{
                           "v1":GLOBAL.ToTime(_loc24_,false,false),
                           "v2":_loc27_,
                           "v3":_loc28_._buildingProps.name
                        });
                     }
                  }
                  else if(_loc28_._type == 8)
                  {
                     if(CREATURELOCKER._unlocking != null)
                     {
                        _loc24_ = 0;
                        _loc24_ = CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e - GLOBAL.Timestamp();
                        _loc25_ = CREATURELOCKER._creatures[CREATURELOCKER._unlocking].name;
                        if(_loc24_ > 0)
                        {
                           if(_loc20_ == "SP1")
                           {
                              _loc21_.t = KEYS.Get("str_closeenough");
                              _loc21_.d = KEYS.Get("str_closeenough_unlock",{"v1":_loc25_});
                              if(_loc24_ <= 300)
                              {
                                 _loc21_.d = KEYS.Get("str_closeenough_unlock",{"v1":_loc25_});
                              }
                           }
                           else if(_loc20_.substr(0,3) == "SP2")
                           {
                              _loc21_.t = KEYS.Get("str_30minutes_unlocklabel");
                              _loc21_.d = KEYS.Get("str_30minutes_unlockdesc",{"v1":_loc25_});
                           }
                           else if(_loc20_.substr(0,3) == "SP3")
                           {
                              _loc21_.t = KEYS.Get("str_60minutes_unlocklabel");
                              _loc21_.d = KEYS.Get("str_60minutes_unlockdesc",{"v1":_loc25_});
                           }
                           else if(_loc20_.substr(0,3) == "SP4")
                           {
                              _loc21_.t = KEYS.Get("str_finishnow_unlocklabel",{"v1":_loc25_});
                              _loc21_.d = KEYS.Get("str_finishnow_unlocktimesave",{
                                 "v1":GLOBAL.ToTime(_loc24_,false,false),
                                 "v2":_loc25_
                              });
                           }
                        }
                     }
                  }
                  else if(_loc28_._type == 26)
                  {
                     if(ACADEMY._monsterID != null)
                     {
                        _loc24_ = ACADEMY._upgrades[ACADEMY._monsterID].time.Get() - GLOBAL.Timestamp();
                        _loc25_ = CREATURELOCKER._creatures[ACADEMY._monsterID].name;
                        if(_loc24_ > 0)
                        {
                           if(_loc20_ == "SP1")
                           {
                              _loc21_.t = KEYS.Get("str_closeenough");
                              _loc21_.d = KEYS.Get("str_closeenough_traindesc",{"v1":_loc25_});
                              if(_loc24_ <= 300)
                              {
                                 _loc21_.d = KEYS.Get("str_closeenough_traindesc_ok",{"v1":_loc25_});
                              }
                           }
                           else if(_loc20_.substr(0,3) == "SP2")
                           {
                              _loc21_.t = KEYS.Get("str_30minutes_trainlabel");
                              _loc21_.d = KEYS.Get("str_30minutes_traindesc",{"v1":_loc25_});
                           }
                           else if(_loc20_.substr(0,3) == "SP3")
                           {
                              _loc21_.t = KEYS.Get("str_60minutes_trainlabel");
                              _loc21_.d = KEYS.Get("str_60minutes_traindesc",{"v1":_loc25_});
                           }
                           else if(_loc20_.substr(0,3) == "SP4")
                           {
                              _loc21_.t = KEYS.Get("str_finishnow_trainlabel",{"v1":_loc25_});
                              _loc21_.d = KEYS.Get("str_finishnow_unlocktimesave",{
                                 "v1":GLOBAL.ToTime(_loc24_,false,false),
                                 "v2":_loc25_
                              });
                           }
                        }
                     }
                  }
                  else if(_loc28_._type == 116)
                  {
                     _loc34_ = _loc28_ as MONSTERLAB;
                     if(_loc34_._upgrading != null)
                     {
                        _loc24_ = _loc34_._upgradeFinishTime.Get() - GLOBAL.Timestamp();
                        _loc25_ = KEYS.Get(CREATURELOCKER._creatures[_loc34_._upgrading].name);
                        _loc35_ = KEYS.Get(MONSTERLAB._powerupProps[_loc34_._upgrading].name);
                        if(_loc24_ > 0)
                        {
                           if(_loc20_ == "SP1")
                           {
                              _loc21_.t = KEYS.Get("str_closeenough");
                              _loc21_.d = KEYS.Get("str_closeenough_powerupdesc",{
                                 "v1":_loc25_,
                                 "v2":_loc35_
                              });
                              if(_loc24_ <= 300)
                              {
                                 _loc21_.d = KEYS.Get("str_closeenough_powerupdesc_ok",{
                                    "v1":_loc25_,
                                    "v2":_loc35_
                                 });
                              }
                           }
                           else if(_loc20_.substr(0,3) == "SP2")
                           {
                              _loc21_.t = KEYS.Get("str_30minutes_poweruplabel",{"v1":_loc35_});
                              _loc21_.d = KEYS.Get("str_30minutes_powerupdesc",{
                                 "v1":_loc25_,
                                 "v2":_loc35_
                              });
                           }
                           else if(_loc20_.substr(0,3) == "SP3")
                           {
                              _loc21_.t = KEYS.Get("str_60minutes_poweruplabel",{"v1":_loc35_});
                              _loc21_.d = KEYS.Get("str_60minutes_powerupdesc",{
                                 "v1":_loc25_,
                                 "v2":_loc35_
                              });
                           }
                           else if(_loc20_.substr(0,3) == "SP4")
                           {
                              _loc21_.t = KEYS.Get("str_finishnow_poweruplabel",{"v1":_loc35_});
                              _loc21_.d = KEYS.Get("str_finishnow_unlocktimesave",{
                                 "v1":GLOBAL.ToTime(_loc24_,false,false),
                                 "v2":_loc25_,
                                 "v3":_loc35_
                              });
                           }
                        }
                     }
                  }
               }
            }
            else if(_loc20_.substr(0,3) == "BEW")
            {
               _loc21_.t = KEYS.Get("str_code_bew_title2");
               _loc21_.d = KEYS.Get("str_code_bew_body2");
            }
            else if(_loc20_ == "BST")
            {
               _loc21_.t = KEYS.Get("str_code_bst_title2");
               _loc21_.d = KEYS.Get("str_code_bst_body2");
            }
            else if(_loc20_ == "ENL")
            {
               _loc21_.t = KEYS.Get("str_code_enl_title2");
               _loc21_.d = KEYS.Get("str_code_enl_body2");
            }
            else if(_loc20_ == "BIP")
            {
               _loc21_.t = KEYS.Get("str_code_bip_title");
               _loc21_.d = KEYS.Get("str_code_bip_body2");
            }
            else if(_loc20_ == "MUSK")
            {
               _loc21_.t = KEYS.Get("str_code_musk_title");
               _loc21_.d = KEYS.Get("str_code_musk_body");
            }
            else if(_loc20_ == "HOD")
            {
               _loc21_.t = KEYS.Get("str_code_hod_title2");
               _loc21_.d = KEYS.Get("str_code_hod_body2");
            }
            else if(_loc20_ == "HOD2")
            {
               _loc21_.t = KEYS.Get("str_code_hod2_title2");
               _loc21_.d = KEYS.Get("str_code_hod2_body2");
            }
            else if(_loc20_ == "HOD3")
            {
               _loc21_.t = KEYS.Get("str_code_hod3_title2");
               _loc21_.d = KEYS.Get("str_code_hod3_body2");
            }
            else if(_loc20_ == "HODI")
            {
               _loc21_.t = KEYS.Get("str_code_hodi_title2");
               _loc21_.d = KEYS.Get("str_code_hodi_body2");
            }
            else if(_loc20_ == "HOD2I")
            {
               _loc21_.t = KEYS.Get("str_code_hod2i_title2");
               _loc21_.d = KEYS.Get("str_code_hod2i_body2");
            }
            else if(_loc20_ == "HOD3I")
            {
               _loc21_.t = KEYS.Get("str_code_hod3i_title2");
               _loc21_.d = KEYS.Get("str_code_hod3i_body2");
            }
            else if(_loc20_ == "PRO1")
            {
               _loc21_.t = KEYS.Get("str_code_pro1_title2");
               _loc21_.d = KEYS.Get("str_code_pro1_body2");
            }
            else if(_loc20_ == "PRO2")
            {
               _loc21_.t = KEYS.Get("str_code_pro2_title2");
               _loc21_.d = KEYS.Get("str_code_pro2_body2");
            }
            else if(_loc20_ == "PRO3")
            {
               _loc21_.t = KEYS.Get("str_code_pro3_title2");
               _loc21_.d = KEYS.Get("str_code_pro3_body2");
            }
            else if(_loc20_ == "TOD")
            {
               _loc21_.t = KEYS.Get("str_code_tod_title");
               _loc21_.d = KEYS.Get("str_code_tod_body");
            }
            else if(_loc20_ == "TODI")
            {
               _loc21_.t = KEYS.Get("str_code_tod_title");
               _loc21_.d = KEYS.Get("todi_body");
            }
            else if(_loc20_ == "MOD")
            {
               _loc21_.t = KEYS.Get("str_code_mod_title");
               _loc21_.d = KEYS.Get("str_code_mod_body");
            }
            else if(_loc20_ == "MDOD")
            {
               _loc21_.t = KEYS.Get("str_code_mdod_title");
               _loc21_.d = KEYS.Get("str_code_mdod_body");
            }
            else if(_loc20_ == "MSOD")
            {
               _loc21_.t = KEYS.Get("str_code_msod_title");
               _loc21_.d = KEYS.Get("str_code_msod_body");
            }
            _loc6_ = 0;
            _loc7_ = int(_loc21_.c.length);
            if(_loc22_)
            {
               _loc6_ = _loc22_.q;
            }
            if(_loc21_.i)
            {
               _loc6_ = 0;
            }
            _loc8_ = "<b>" + _loc21_.t + "</b><br>" + _loc21_.d;
            if(_loc20_ == "BIP" && _storeData.BIP && _storeData.BIP.q < 10)
            {
               _loc8_ += " " + KEYS.Get("store_total%increase",{"v1":(_storeData.BIP.q + 1) * 10});
            }
            _loc32_ = "";
            if(_loc20_.substr(0,2) == "BR" && _loc21_.c[0] == 0)
            {
               _loc31_ = _loc20_;
               if(_loc31_.substr(0,2) == "SP")
               {
                  _loc31_ = _loc31_.substr(0,3);
               }
               if(!(_storeInventory[_loc31_] && _storeInventory[_loc31_].Get() > 0))
               {
                  _loc32_ = KEYS.Get("str_prob_cantbuymore");
               }
            }
            if(_loc20_.substr(0,2) == "SP")
            {
               if(!_loc28_)
               {
                  _loc32_ = KEYS.Get("str_prob_nobuilding");
               }
               else if(_loc28_)
               {
                  _loc24_ = 0;
                  if(_loc28_._repairing)
                  {
                     _loc24_ = int(_loc28_._repairTime);
                  }
                  else if(_loc28_._countdownUpgrade.Get() + _loc28_._countdownBuild.Get() + _loc28_._countdownFortify.Get() > 0)
                  {
                     _loc24_ = _loc28_._countdownUpgrade.Get() + _loc28_._countdownBuild.Get() + _loc28_._countdownFortify.Get();
                  }
                  else
                  {
                     if(_loc28_._type == 8 && CREATURELOCKER._unlocking != null)
                     {
                        _loc24_ = CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e - GLOBAL.Timestamp();
                     }
                     if(_loc28_._type == 26 && ACADEMY._monsterID != null)
                     {
                        _loc24_ = ACADEMY._upgrades[ACADEMY._monsterID].time.Get() - GLOBAL.Timestamp();
                     }
                     if(_loc28_._type == 116 && (GLOBAL._bLab as MONSTERLAB)._upgrading != null)
                     {
                        _loc24_ = (GLOBAL._bLab as MONSTERLAB)._upgradeFinishTime.Get() - GLOBAL.Timestamp();
                     }
                  }
                  if(_loc24_ == 0)
                  {
                     _loc32_ = KEYS.Get("str_prob_nothing");
                  }
                  else if(_loc20_ == "SP1" && _loc24_ > 300)
                  {
                     _loc32_ = KEYS.Get("str_prob_morethan5");
                  }
                  else if(_loc20_.substr(0,3) == "SP2" && (_loc24_ < 3600 && !_storeInventory.SP2 || _storeInventory.SP2 && _loc24_ <= 300))
                  {
                     _loc32_ = KEYS.Get("str_prob_notneeded");
                  }
                  else if(_loc20_.substr(0,3) == "SP3" && (_loc24_ < 7200 && !_storeInventory.SP3 || _storeInventory.SP3 && _loc24_ <= 300))
                  {
                     _loc32_ = KEYS.Get("str_prob_notneeded");
                  }
                  else if(_loc20_.substr(0,3) == "SP4" && _loc24_ <= 300)
                  {
                     _loc32_ = KEYS.Get("str_prob_notneeded");
                  }
               }
               else
               {
                  _loc32_ = KEYS.Get("str_prob_nothingselected");
               }
            }
            if(_loc20_.substr(0,3) == "HOD" && !GLOBAL._bHatchery)
            {
               _loc32_ = KEYS.Get("str_prob_nohatcheries");
            }
            if(_loc20_ == "CLOD" && !GLOBAL._bLocker)
            {
               _loc32_ = KEYS.Get("str_prob_nolocker");
            }
            if(_loc20_ == "MUSK")
            {
               if(GLOBAL._bBaiter == null)
               {
                  _loc32_ = KEYS.Get("str_prob_nobaiter");
               }
               else if(MONSTERBAITER._musk >= MONSTERBAITER._muskLimit)
               {
                  _loc32_ = KEYS.Get("str_prob_muskfull");
               }
            }
            if(_loc20_ == "FIX")
            {
               if(_repairCount == 0)
               {
                  _loc32_ = KEYS.Get("str_prob_notneeded");
               }
            }
            if(_loc20_.substr(0,3) == "BLK")
            {
               _loc36_ = GLOBAL._bTownhall._lvl.Get();
               if(BASE._yardType == BASE.OUTPOST)
               {
                  _loc36_ = 7;
               }
               if(BASE._yardType != BASE.OUTPOST && _loc36_ < 3 && _loc20_.substr(3,1) == "2")
               {
                  _loc32_ = KEYS.Get("upgradeth",{"v1":3});
               }
               else if(BASE._yardType != BASE.OUTPOST && _loc36_ < 4 && _loc20_.substr(3,1) == "3")
               {
                  _loc32_ = KEYS.Get("upgradeth",{"v1":4});
               }
               else if(BASE._yardType != BASE.OUTPOST && _loc36_ < 5 && _loc20_.substr(3,1) == "4")
               {
                  _loc32_ = KEYS.Get("upgradeth",{"v1":5});
               }
               else if(BASE._yardType != BASE.OUTPOST && _loc36_ < 6 && _loc20_.substr(3,1) == "5")
               {
                  _loc32_ = KEYS.Get("upgradeth",{"v1":6});
               }
               else
               {
                  _loc37_ = false;
                  _loc38_ = false;
                  _loc39_ = false;
                  _loc40_ = false;
                  for each(_loc41_ in BASE._buildingsWalls)
                  {
                     if(_loc41_._lvl.Get() == 1 && _loc36_ >= 3)
                     {
                        _loc37_ = true;
                        _loc38_ = true;
                        _loc39_ = true;
                        _loc40_ = true;
                        break;
                     }
                     if(_loc41_._lvl.Get() == 2 && _loc36_ >= 4)
                     {
                        _loc38_ = true;
                        _loc39_ = true;
                        _loc40_ = true;
                     }
                     if(!BASE.isInferno())
                     {
                        if(_loc41_._lvl.Get() == 3 && _loc36_ >= 5)
                        {
                           _loc39_ = true;
                           _loc40_ = true;
                        }
                        if(_loc41_._lvl.Get() == 4 && _loc36_ >= 6)
                        {
                           _loc40_ = true;
                        }
                     }
                  }
                  if(_loc20_.substr(3,1) == "2" && !_loc37_)
                  {
                     _loc32_ = KEYS.Get("str_prob_notneeded");
                  }
                  if(_loc20_.substr(3,1) == "3" && !_loc38_)
                  {
                     _loc32_ = KEYS.Get("str_prob_notneeded");
                  }
                  if(_loc20_.substr(3,1) == "4" && !_loc39_)
                  {
                     _loc32_ = KEYS.Get("str_prob_notneeded");
                  }
                  if(_loc20_.substr(3,1) == "5" && !_loc40_)
                  {
                     _loc32_ = KEYS.Get("str_prob_notneeded");
                  }
               }
            }
            if(_loc29_)
            {
               _loc33_ = "<b><font color=\"#335280\">" + GLOBAL.FormatNumber(_loc21_.fbc_cost[_loc6_]) + "</font></b>";
            }
            else
            {
               _loc33_ = "<b>" + GLOBAL.FormatNumber(_loc21_.c[_loc6_]) + "</b>";
               if(_loc21_.c[_loc6_] == 0 && _loc32_ == "")
               {
                  _loc33_ = "<font color=\"#0000CC\"><b>" + KEYS.Get("str_buy_free") + "</b></font>";
               }
            }
            if(_loc32_ != "")
            {
               _loc23_.mcScreen.visible = true;
               _loc23_.mcScreen.enabled = true;
               _loc31_ = _loc20_;
               if(_loc31_.substr(0,2) == "SP")
               {
                  _loc31_ = _loc31_.substr(0,3);
               }
               if(Boolean(_storeInventory[_loc31_]) && _storeInventory[_loc31_].Get() > 0)
               {
                  _loc9_ = "<font color=\"#0000ff\"><b>" + _storeInventory[_loc31_].Get() + "</b></font>";
               }
               else
               {
                  _loc9_ = _loc33_;
               }
               _loc10_ = "<font color=\"#CC0000\">" + _loc32_ + "</font></i>";
               _loc23_.bBuy.Enabled = false;
            }
            else
            {
               if(BASE._pendingPurchase.length > 0)
               {
                  _loc23_.bBuy.Enabled = false;
               }
               if(_loc6_ >= _loc7_ && !_loc21_.i || _loc20_.substr(0,3) == "BEW" && QUEUE._workerCount >= 5 || _loc20_.substr(0,2) == "BR" && BASE._resources["r" + _loc20_.substr(2,1)].Get() >= BASE._resources["r" + _loc20_.substr(2,1) + "max"])
               {
                  _loc23_.mcScreen.visible = true;
                  _loc23_.mcScreen.enabled = true;
                  _loc23_.bBuy.Enabled = false;
                  _loc31_ = _loc20_;
                  if(_loc31_.substr(0,2) == "SP")
                  {
                     _loc31_ = _loc31_.substr(0,3);
                  }
                  if(Boolean(_storeInventory[_loc31_]) && _storeInventory[_loc31_].Get() > 0)
                  {
                     _loc9_ = "<font color=\"#0000ff\"><b>" + _storeInventory[_loc31_].Get() + "</b></font>";
                     _loc10_ = "<font color=\"#0000CC\">" + KEYS.Get("store_inyourinventory",{"v1":_storeInventory[_loc31_].Get()}) + "</font>";
                  }
                  else
                  {
                     _loc9_ = "<font color=\"#CC0000\">" + KEYS.Get("str_prob_soldout") + "</font>";
                     if(_loc21_.du > 0)
                     {
                        _loc10_ = "<font color=\"#CC0000\">" + KEYS.Get("store_rebuy",{"v1":GLOBAL.ToTime(_storeData[_loc20_].e - GLOBAL.Timestamp(),true)}) + "</font>";
                     }
                     else if(_loc6_ == 0)
                     {
                        _loc10_ = "<font color=\"#0000CC\">" + KEYS.Get("str_purchased") + "</font>";
                     }
                     else
                     {
                        _loc10_ = "<font color=\"#0000CC\">" + KEYS.Get("str_purchased_xtimes",{
                           "v1":_loc6_,
                           "v2":_loc7_
                        }) + "</font>";
                     }
                  }
               }
               else
               {
                  _loc23_.mcScreen.visible = false;
                  _loc23_.mcScreen.enabled = false;
                  _loc23_.bBuy.Highlight = true;
                  _loc31_ = _loc20_;
                  if(_loc31_.substr(0,2) == "SP")
                  {
                     _loc31_ = _loc31_.substr(0,3);
                  }
                  if(Boolean(_storeInventory[_loc31_]) && Boolean(_storeInventory[_loc31_].Get()))
                  {
                     _loc23_.bBuy.Highlight = true;
                     _loc9_ = "<font color=\"#0000ff\"><b>" + _storeInventory[_loc31_].Get() + "</b></font>";
                     _loc10_ = "<font color=\"#0000CC\">" + KEYS.Get("store_inyourinventory",{"v1":_storeInventory[_loc31_].Get()}) + "</font>";
                  }
                  else
                  {
                     if(_loc21_.i)
                     {
                        _loc6_ = 0;
                     }
                     _loc9_ = _loc33_;
                     if(_loc21_.du > 0)
                     {
                        _loc10_ = "<font color=\"#0000CC\">" + KEYS.Get("str_buy_cooldown",{"v1":GLOBAL.ToTime(_loc21_.du)}) + "</font>";
                     }
                     else if(_loc21_.i)
                     {
                        _loc10_ = "<font color=\"#0000CC\">" + KEYS.Get("str_buyoften") + "</font>";
                     }
                     else
                     {
                        if(_loc6_ == 0 && _loc7_ == 1)
                        {
                           _loc10_ = "<font color=\"#0000CC\">" + KEYS.Get("str_buy_once") + "</font>";
                        }
                        if(_loc6_ == 0 && _loc7_ > 1)
                        {
                           _loc10_ = "<font color=\"#0000CC\">" + KEYS.Get("str_buy_xtimes",{"v1":_loc7_}) + "</font>";
                        }
                        if(_loc6_ > 0)
                        {
                           _loc10_ = "<font color=\"#0000CC\">" + KEYS.Get("str_buy_xtimesof",{
                              "v1":_loc6_,
                              "v2":_loc7_
                           }) + "</font>";
                        }
                     }
                  }
               }
            }
            _loc23_.x = _loc12_;
            _loc23_.y = _loc11_;
            _loc23_.tA.htmlText = _loc8_ + " ";
            _loc23_.tB.htmlText = _loc9_;
            _loc23_.tC.htmlText = _loc10_ + " ";
            _loc31_ = _loc20_;
            if(_loc31_.substr(0,2) == "SP")
            {
               _loc31_ = _loc31_.substr(0,3);
            }
            if(Boolean(_storeInventory[_loc31_]) && _storeInventory[_loc31_].Get() > 0)
            {
               _loc23_.bBuy.SetupKey("btn_use");
            }
            else
            {
               _loc23_.bBuy.SetupKey("btn_buy");
            }
            if(_loc23_.bBuy.Enabled)
            {
               _loc23_.bBuy.addEventListener(MouseEvent.MOUSE_DOWN,Buy(_loc20_));
            }
            if(_loc20_.substr(0,2) == "SP")
            {
               _loc23_.mcIcon.gotoAndStop(_loc20_.substr(0,3));
            }
            else
            {
               _loc23_.mcIcon.gotoAndStop(_loc20_);
            }
            _items.addChild(_loc23_);
            _loc16_++;
            _loc14_ = Math.floor(_loc16_ / 3);
            _loc12_ = _loc16_ % 3 * 220 + _loc16_ % 3 * 0;
            _loc11_ = _loc14_ * 150 + _loc14_ * 8;
            _loc19_++;
         }
         _mc.window.content.mask = _mc.window.msk;
         if(_scrollUpdate)
         {
            _scroller.Init(_mc.window.content as Sprite,_mc.window.msk as MovieClip,0,0,391,30);
            if(_scrollPosUpdate)
            {
               _scroller.ScrollTo(0,0);
            }
         }
      }
      
      public static function Update() : *
      {
         if(_open)
         {
            _mc.tShinyBalance.htmlText = "<b>" + GLOBAL.FormatNumber(BASE._credits.Get()) + " <font size=\"12\">" + KEYS.Get("#r_shiny#") + "</font></b>";
            Switch(_tab,_page);
         }
      }
      
      public static function Hide(param1:MouseEvent = null) : *
      {
         if(_open)
         {
            GLOBAL.BlockerRemove();
            SOUNDS.Play("close");
            _open = false;
            GLOBAL._layerWindows.removeChild(_mc);
            _tab = 0;
            _page = 0;
            _mc = null;
         }
      }
      
      public static function Buy(param1:String) : *
      {
         var itemCode:String = param1;
         return function(param1:MouseEvent = null):*
         {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            if(BASE._pendingPurchase.length == 0)
            {
               _loc2_ = _storeItems[itemCode];
               if(Boolean(_loc2_.fbc_cost) && _loc2_.fbc_cost[0] > 0)
               {
                  _loc5_ = true;
                  _loc4_ = _loc2_.fbc_cost;
               }
               else
               {
                  _loc5_ = false;
                  _loc4_ = _loc2_.c;
               }
               _loc3_ = _loc4_[0];
               if(Boolean(_storeData[itemCode]) && !_loc2_.i)
               {
                  _loc3_ = _loc4_[_storeData[itemCode].q];
               }
               if(_loc5_)
               {
                  FacebookCreditPurchase(itemCode);
               }
               else
               {
                  _loc6_ = itemCode;
                  if(_loc6_.substr(0,2) == "SP")
                  {
                     _loc6_ = _loc6_.substr(0,3);
                  }
                  if(Boolean(_storeInventory[_loc6_]) && _storeInventory[_loc6_].Get() > 0)
                  {
                     _storeInventory[_loc6_].Add(-1);
                     if(_storeInventory[_loc6_].Get() <= 0)
                     {
                        delete _storeInventory[_loc6_];
                     }
                     BuyB(itemCode,true);
                  }
                  else if(BASE._credits.Get() >= _loc3_)
                  {
                     BuyB(itemCode);
                  }
                  else
                  {
                     POPUPS.DisplayGetShiny();
                  }
               }
            }
         };
      }
      
      public static function BuyB(param1:String, param2:Boolean = false) : *
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc11_:BFOUNDATION = null;
         var _loc12_:int = 0;
         var _loc13_:BFOUNDATION = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:String = null;
         var _loc17_:MONSTERLAB = null;
         var _loc18_:BFOUNDATION = null;
         var _loc19_:String = null;
         var _loc3_:* = _storeItems[param1];
         var _loc6_:int = int(_loc3_.quantity);
         if(param2)
         {
            _loc7_ = false;
            _loc5_ = _loc3_.c;
         }
         else if(Boolean(_loc3_.fbc_cost) && _loc3_.fbc_cost[0] > 0)
         {
            _loc7_ = true;
            _loc5_ = _loc3_.fbc_cost;
         }
         else
         {
            _loc7_ = false;
            _loc5_ = _loc3_.c;
         }
         _loc4_ = int(_loc5_[0]);
         if(Boolean(_storeData[param1]) && !_loc3_.i)
         {
            _loc4_ = int(_loc5_[_storeData[param1].q]);
         }
         if(_storeData[param1] && _storeData[param1].q >= _loc3_.c.length && !_loc3_.i)
         {
            GLOBAL.Message(KEYS.Get("str_prob_alreadyhave"));
            return false;
         }
         var _loc9_:int = int(_loc3_.quantity);
         if(_loc9_ == 0)
         {
            _loc9_ = 1;
         }
         if(param1.substr(0,2) == "BR" || param1.substr(0,3) == "SP4" || param1 == "MUSK")
         {
            _loc9_ = _loc4_;
         }
         var _loc10_:int = _loc9_;
         if(!_loc7_ && !param2)
         {
            BASE._credits.Add(-_loc4_);
            BASE._hpCredits -= _loc4_;
         }
         if(param1.substr(0,3) == "BEW")
         {
            QUEUE.Spawn(1);
         }
         if(param1.substr(0,3) == "BLK")
         {
            _loc12_ = int(param1.substr(3,1));
            for each(_loc11_ in BASE._buildingsWalls)
            {
               if(_loc11_._countdownBuild.Get() > 0)
               {
                  _loc11_.Constructed();
               }
               if(_loc11_._countdownUpgrade.Get() > 0)
               {
                  _loc11_.Upgraded();
               }
               while(_loc11_._lvl.Get() < _loc12_)
               {
                  _loc11_.Upgraded();
               }
            }
            _loc10_ = _loc4_;
            if(BASE.isInferno())
            {
               if(_loc12_ == 2)
               {
                  GLOBAL.Message("<b>" + KEYS.Get("msg_wallsgranite") + "</b>");
               }
               else if(_loc12_ == 3)
               {
                  GLOBAL.Message("<b>" + KEYS.Get("msg_wallsforgedsteel") + "</b>");
               }
            }
            else if(_loc12_ == 2)
            {
               GLOBAL.Message("<b>" + KEYS.Get("msg_wallsstone") + "</b>");
            }
            else if(_loc12_ == 3)
            {
               GLOBAL.Message("<b>" + KEYS.Get("msg_wallsmetal") + "</b>");
            }
            else if(_loc12_ == 4)
            {
               GLOBAL.Message("<b>" + KEYS.Get("msg_wallsgold") + "</b>");
            }
            else if(_loc12_ == 5)
            {
               GLOBAL.Message("<b>" + KEYS.Get("msg_wallsblackdiamond") + "</b>");
            }
         }
         if(param1.substr(0,2) == "BR")
         {
            BASE.Fund(int(param1.substr(2,1)),int(_loc6_));
            BASE.PointsAdd(Math.ceil(_loc6_ * 0.3));
         }
         if(param1.substr(0,3) == "HOD")
         {
            if(param2)
            {
               LOGGER.Stat([76,"overdriveused"]);
            }
         }
         if(param1.substr(0,2) == "SP")
         {
            _loc13_ = GLOBAL._selectedBuilding;
            _loc14_ = 0;
            if(param1.substr(2,1) == "1")
            {
               _loc14_ = 5 * 60;
            }
            if(param1.substr(2,1) == "2")
            {
               _loc14_ = 60 * 60;
            }
            if(param1.substr(2,1) == "3")
            {
               _loc14_ = 2 * 60 * 60;
            }
            if(_loc13_._repairing)
            {
               _loc15_ = _loc13_._lvl.Get() == 0 ? 0 : _loc13_._lvl.Get() - 1;
               _loc13_._hp.Add(Math.ceil(_loc13_._hpMax.Get() / _loc13_._repairTime) * _loc14_);
               _loc16_ = param1.substr(2,1);
               if(_loc16_ == "4" || _loc16_ == "1" || _loc13_._hp.Get() > _loc13_._hpMax.Get())
               {
                  _loc13_._hp.Set(_loc13_._hpMax.Get());
                  LOGGER.Stat([26,_loc13_._type,0,1,_loc4_]);
               }
               else
               {
                  LOGGER.Stat([26,_loc13_._type,0,0,_loc4_]);
               }
            }
            else if(_loc13_._countdownBuild.Get())
            {
               _loc13_._countdownBuild.Add(-_loc14_);
               _loc8_ = 0;
               if(_loc13_._countdownBuild.Get() <= 0 || param1.substr(2,1) == "4")
               {
                  _loc8_ = 1;
                  _loc13_._countdownBuild.Set(0);
                  _loc13_.Constructed();
                  _loc13_.Update();
               }
               LOGGER.Stat([1,_loc13_._type,0,_loc8_,_loc4_]);
            }
            else if(_loc13_._countdownUpgrade.Get())
            {
               _loc13_._countdownUpgrade.Add(-_loc14_);
               _loc8_ = 0;
               if(_loc13_._countdownUpgrade.Get() <= 0 || param1.substr(2,1) == "4")
               {
                  _loc8_ = 1;
                  _loc13_._countdownUpgrade.Set(0);
                  _loc13_.Upgraded();
                  _loc13_.Update();
                  LOGGER.Stat([2,_loc13_._type,_loc13_._lvl.Get(),1,_loc4_]);
               }
               else
               {
                  LOGGER.Stat([2,_loc13_._type,_loc13_._lvl.Get() + 1,0,_loc4_]);
               }
            }
            else if(_loc13_._countdownFortify.Get())
            {
               _loc13_._countdownFortify.Add(-_loc14_);
               _loc8_ = 0;
               if(_loc13_._countdownFortify.Get() <= 0 || param1.substr(2,1) == "4")
               {
                  _loc8_ = 1;
                  _loc13_._countdownFortify.Set(0);
                  _loc13_.Fortified();
                  _loc13_.Update();
                  LOGGER.Stat([67,_loc13_._type,_loc13_._lvl.Get(),1,_loc4_]);
               }
               else
               {
                  LOGGER.Stat([67,_loc13_._type,_loc13_._lvl.Get() + 1,0,_loc4_]);
               }
            }
            else if(_loc13_._type == 8)
            {
               _loc8_ = 0;
               if(CREATURELOCKER._unlocking != null && CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].t == 1)
               {
                  CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e -= _loc14_;
                  if(param1.substr(2,1) == "4" || CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e < GLOBAL.Timestamp())
                  {
                     _loc8_ = 1;
                     CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e = GLOBAL.Timestamp();
                  }
               }
               LOGGER.Stat([3,int(CREATURELOCKER._unlocking.substr(1)),0,_loc8_,_loc4_]);
               CREATURELOCKER.Update();
            }
            else if(_loc13_._type == 26)
            {
               _loc8_ = 0;
               if(ACADEMY._monsterID != null)
               {
                  ACADEMY._upgrades[ACADEMY._monsterID].time.Add(-_loc14_);
                  if(param1.substr(2,1) == "4" || ACADEMY._upgrades[ACADEMY._monsterID].time.Get() < GLOBAL.Timestamp())
                  {
                     _loc8_ = 1;
                     ACADEMY._upgrades[ACADEMY._monsterID].time.Set(GLOBAL.Timestamp() + 1);
                     LOGGER.Stat([4,ACADEMY._monsterID.substr(1),ACADEMY._upgrades[ACADEMY._monsterID].level,1,_loc4_]);
                  }
                  else
                  {
                     LOGGER.Stat([4,ACADEMY._monsterID.substr(1),ACADEMY._upgrades[ACADEMY._monsterID].level + 1,0,_loc4_]);
                  }
               }
               ACADEMY.Update();
            }
            else if(_loc13_._type == 116)
            {
               _loc8_ = 0;
               _loc17_ = GLOBAL._bLab as MONSTERLAB;
               if((Boolean(_loc17_)) && _loc17_._upgrading != null)
               {
                  _loc17_._upgradeFinishTime.Add(-_loc14_);
                  if(param1.substr(2,1) == "4" || _loc17_._upgradeFinishTime.Get() < GLOBAL.Timestamp())
                  {
                     _loc8_ = 1;
                     _loc17_._upgradeFinishTime.Set(GLOBAL.Timestamp() + 1);
                     LOGGER.Stat([51,_loc17_._upgrading.substr(1),_loc17_._upgradeLevel,1,_loc4_]);
                  }
                  else
                  {
                     LOGGER.Stat([51,_loc17_._upgrading.substr(1),_loc17_._upgradeLevel,0,_loc4_]);
                  }
               }
            }
            QUESTS.Check();
         }
         if(param1 == "FIX")
         {
            _loc10_ = int(_storeItems.FIX.c);
            for each(_loc18_ in BASE._buildingsAll)
            {
               if(_loc18_._hp.Get() < _loc18_._hpMax.Get())
               {
                  _loc18_._hp.Set(_loc18_._hpMax.Get());
                  _loc18_.Repaired();
               }
            }
            if(param2)
            {
               _loc6_ = int(_storeData[param1].c);
            }
         }
         if(param1 == "MUSK")
         {
            MONSTERBAITER.Fill();
         }
         _loc9_ = 1;
         if(_loc3_.i)
         {
            _loc9_ = _loc6_;
         }
         if(_storeData[param1])
         {
            _storeData[param1].q += _loc9_;
            if(_loc3_.du > 0)
            {
               _storeData[param1].s = GLOBAL.Timestamp();
               _storeData[param1].e = GLOBAL.Timestamp() + _loc3_.du;
            }
         }
         else
         {
            _storeData[param1] = {"q":_loc9_};
            if(_loc3_.du > 0)
            {
               _storeData[param1].s = GLOBAL.Timestamp();
               _storeData[param1].e = GLOBAL.Timestamp() + _loc3_.du;
            }
         }
         BASE.CalcResources();
         UI2.Update();
         ProcessPurchases();
         if(param1 == "ENL")
         {
            MAP.Edge();
         }
         if(param1 == "BIP")
         {
            BASE.CalcResources();
         }
         if(_loc7_)
         {
            BASE.Save(0,false,true);
         }
         else if(_loc4_ > 0)
         {
            if(param2)
            {
               _loc19_ = param1;
               if(_loc19_.substr(0,2) == "SP")
               {
                  _loc19_ = _loc19_.substr(0,3);
               }
               BASE.Purchase(_loc19_,1,"store",true);
            }
            else
            {
               BASE.Purchase(param1,_loc10_,"store");
            }
         }
         else
         {
            BASE.Save();
         }
         if(_loc3_.a)
         {
            Hide();
         }
         else
         {
            Switch(_tab,_page);
         }
         LOGGER.Stat([13,param1,_loc4_]);
         if(!param2)
         {
            BuyC(param1,_loc4_);
         }
      }
      
      public static function BuyC(param1:String, param2:int) : *
      {
         var Brag:Function;
         var arr:* = undefined;
         var mc:MovieClip = null;
         var itemCode:String = param1;
         var cost:int = param2;
         if(TUTORIAL._stage > 200)
         {
            arr = [];
            switch(itemCode)
            {
               case "BEW":
                  arr = [KEYS.Get("str_code_bew_title"),KEYS.Get("str_code_bew_body",{"v1":QUEUE._workerCount}),KEYS.Get("str_code_bew_stream"),KEYS.Get("str_code_bew_streambody",{"v1":QUEUE._workerCount}),"purchased-worker.png"];
                  break;
               case "BST":
                  arr = [KEYS.Get("str_code_bst_title"),KEYS.Get("str_code_bst_body"),KEYS.Get("str_code_bst_stream"),KEYS.Get("str_code_bst_streambody"),"purchased-tools.png"];
                  break;
               case "ENL":
                  PLANNER.Update();
                  arr = [KEYS.Get("str_code_enl_title"),KEYS.Get("str_code_enl_body"),KEYS.Get("str_code_enl_stream"),KEYS.Get("str_code_enl_stream"),"purchased-enlarge.png"];
                  break;
               case "BIP":
                  arr = [KEYS.Get("str_code_bip_title"),KEYS.Get("str_code_bip_body"),KEYS.Get("str_code_bip_stream"),KEYS.Get("str_code_bip_streambody"),"purchased-packing.png"];
                  break;
               case "HOD":
                  arr = [KEYS.Get("str_code_hod_title"),KEYS.Get("str_code_hod_body"),KEYS.Get("str_code_hod_stream"),KEYS.Get("str_code_hod_streambody"),"purchased-hatchery.png"];
                  break;
               case "HOD2":
                  arr = [KEYS.Get("str_code_hod2_title"),KEYS.Get("str_code_hod2_body"),KEYS.Get("str_code_hod2_stream"),KEYS.Get("str_code_hod2_streambody"),"purchased-hatchery.png"];
                  break;
               case "HOD3":
                  arr = [KEYS.Get("str_code_hod3_title"),KEYS.Get("str_code_hod3_body"),KEYS.Get("str_code_hod3_stream"),KEYS.Get("str_code_hod3_streambody"),"purchased-hatchery.png"];
                  break;
               case "HODI":
                  arr = [KEYS.Get("str_code_hodi_title"),KEYS.Get("str_code_hodi_body"),KEYS.Get("str_code_hodi_stream"),KEYS.Get("str_code_hodi_streambody"),"purchased-hatchery.png"];
                  break;
               case "HOD2I":
                  arr = [KEYS.Get("str_code_hod2i_title"),KEYS.Get("str_code_hod2i_body"),KEYS.Get("str_code_hod2i_stream"),KEYS.Get("str_code_hod2i_streambody"),"purchased-hatchery.png"];
                  break;
               case "HOD3I":
                  arr = [KEYS.Get("str_code_hod3i_title"),KEYS.Get("str_code_hod3i_body"),KEYS.Get("str_code_hod3i_stream"),KEYS.Get("str_code_hod3i_streambody"),"purchased-hatchery.png"];
                  break;
               case "TOD":
                  arr = [KEYS.Get("tod_title2"),KEYS.Get("tod_body"),KEYS.Get("str_code_tod_stream"),KEYS.Get("str_code_tod_streambody"),"purchased-tod3.png"];
                  break;
               case "TODI":
                  arr = [KEYS.Get("todi_title2"),KEYS.Get("todi_body"),KEYS.Get("str_code_todi_stream"),KEYS.Get("str_code_todi_streambody"),"purchased-todi.png"];
                  break;
               case "MOD":
                  arr = [KEYS.Get("mod_title"),KEYS.Get("mod_body"),KEYS.Get("str_code_mod_stream"),KEYS.Get("str_code_mod_streambody"),"purchased-mod3.png"];
                  break;
               case "MDOD":
                  arr = [KEYS.Get("mdod_title"),KEYS.Get("mdod_body"),KEYS.Get("str_code_mdod_stream"),KEYS.Get("str_code_mdod_streambody"),"purchased-mdod3.png"];
                  break;
               case "MSOD":
                  arr = [KEYS.Get("msod_title"),KEYS.Get("msod_body"),KEYS.Get("str_code_msod_stream"),KEYS.Get("str_code_msod_streambody"),"purchased-msod3.png"];
                  break;
               case "EXH":
                  arr = [KEYS.Get("exh_title"),KEYS.Get("exh_body"),KEYS.Get("str_code_exh_stream"),KEYS.Get("str_code_exh_streambody"),"purchased-exh.png"];
                  break;
               case "CLOD":
                  arr = [KEYS.Get("str_code_clod_title"),KEYS.Get("str_code_clod_body"),KEYS.Get("str_code_clod_stream"),KEYS.Get("str_code_clod_streambody"),"purchased-locker.png"];
                  break;
               case "PRO1":
                  arr = [KEYS.Get("str_code_pro1_title"),KEYS.Get("str_code_pro1_body"),KEYS.Get("str_code_pro1_stream"),"","purchased-protection1.png"];
                  break;
               case "PRO2":
                  arr = [KEYS.Get("str_code_pro2_title"),KEYS.Get("str_code_pro2_body"),KEYS.Get("str_code_pro2_stream"),"","purchased-protection2.png"];
                  break;
               case "PRO3":
                  arr = [KEYS.Get("str_code_pro3_title"),KEYS.Get("str_code_pro3_body"),KEYS.Get("str_code_pro3_stream"),"","purchased-protection3.png"];
            }
            if(arr.length > 0)
            {
               Brag = function(param1:MouseEvent):*
               {
                  GLOBAL.CallJS("sendFeed",["store-" + itemCode,arr[2],arr[3],arr[4]]);
                  POPUPS.Next();
               };
               mc = new popup_purchase();
               mc.gotoAndStop(itemCode);
               mc.tA.htmlText = "<b>" + arr[0] + "</b>";
               mc.tB.htmlText = arr[1];
               (mc.bPost as Button).SetupKey("btn_brag");
               mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
               mc.bPost.Highlight = true;
               POPUPS.Push(mc,null,null,"");
            }
            else if(cost > 0 && !_storeItems[itemCode].a)
            {
               GLOBAL.Message(KEYS.Get("msg_purchase_complete",{"v1":_storeItems[itemCode].t}));
            }
         }
      }
      
      public static function FacebookCreditPurchase(param1:String) : *
      {
         var _loc2_:Object = _storeItems[param1];
         var _loc3_:int = int(_loc2_.fbc_cost[0]);
         if(Boolean(_storeData[param1]) && !_loc2_.i)
         {
            _loc3_ = int(_loc2_.fbc_cost[_storeData[param1].q]);
         }
         GLOBAL.CallJS("cc.fbcBuyItem",[param1,"fbcBuyItem"]);
         _facebookPurchaseItemCode = param1;
         PLEASEWAIT.Show(KEYS.Get("msg_openingfb"));
      }
      
      public static function FacebookCreditPurchaseB(param1:String) : *
      {
         if(int(com.adobe.serialization.json.JSON.decode(param1).success) == 1)
         {
            BuyB(_facebookPurchaseItemCode);
         }
         PLEASEWAIT.Hide();
      }
      
      public static function ProcessPurchases() : *
      {
         var enl:int = 0;
         var c:* = undefined;
         try
         {
            GLOBAL._mapWidth = 1000;
            GLOBAL._mapHeight = 800;
            if(_storeData.ENL)
            {
               enl = 0;
               while(enl < _storeData.ENL.q)
               {
                  GLOBAL._mapWidth *= 1.1;
                  GLOBAL._mapHeight *= 1.1;
                  enl++;
               }
               GLOBAL._mapWidth = Math.ceil(GLOBAL._mapWidth / 20) * 20;
               GLOBAL._mapHeight = Math.ceil(GLOBAL._mapHeight / 20) * 20;
            }
            GLOBAL._hatcheryOverdrive = 0;
            if(Boolean(_storeData.HOD) && _storeData.HOD.e < GLOBAL.Timestamp())
            {
               delete _storeData.HOD;
            }
            if(Boolean(_storeData.HOD2) && _storeData.HOD2.e < GLOBAL.Timestamp())
            {
               delete _storeData.HOD2;
            }
            if(Boolean(_storeData.HOD3) && _storeData.HOD3.e < GLOBAL.Timestamp())
            {
               delete _storeData.HOD3;
            }
            GLOBAL._hatcheryOverdrivePower.Set(0);
            if(_storeData.HOD3)
            {
               GLOBAL._hatcheryOverdrive = _storeData.HOD3.e - GLOBAL.Timestamp();
               GLOBAL._hatcheryOverdrivePower.Set(10);
            }
            else if(_storeData.HOD2)
            {
               GLOBAL._hatcheryOverdrive = _storeData.HOD2.e - GLOBAL.Timestamp();
               GLOBAL._hatcheryOverdrivePower.Set(6);
            }
            else if(_storeData.HOD)
            {
               GLOBAL._hatcheryOverdrive = _storeData.HOD.e - GLOBAL.Timestamp();
               GLOBAL._hatcheryOverdrivePower.Set(4);
            }
            else if(_storeData.HOD3I)
            {
               GLOBAL._hatcheryOverdrive = _storeData.HOD3I.e - GLOBAL.Timestamp();
               GLOBAL._hatcheryOverdrivePower.Set(10);
            }
            else if(_storeData.HOD2I)
            {
               GLOBAL._hatcheryOverdrive = _storeData.HOD2I.e - GLOBAL.Timestamp();
               GLOBAL._hatcheryOverdrivePower.Set(6);
            }
            else if(_storeData.HODI)
            {
               GLOBAL._hatcheryOverdrive = _storeData.HODI.e - GLOBAL.Timestamp();
               GLOBAL._hatcheryOverdrivePower.Set(4);
            }
            GLOBAL._harvesterOverdrive = 0;
            GLOBAL._harvesterOverdrivePower.Set(0);
            if(Boolean(_storeData.POD) && _storeData.POD.e > GLOBAL.Timestamp())
            {
               GLOBAL._harvesterOverdrive = _storeData.POD.e;
               GLOBAL._harvesterOverdrivePower.Set(2);
            }
            GLOBAL._extraHousing = 0;
            if(Boolean(_storeData.EXH) && _storeData.EXH.e < GLOBAL.Timestamp())
            {
               delete _storeData.EXH;
            }
            GLOBAL._extraHousingPower.Set(0);
            if(_storeData.EXH && _storeData.EXH.e > GLOBAL.Timestamp() && !BASE.isInferno())
            {
               GLOBAL._extraHousing = _storeData.EXH.e;
               GLOBAL._extraHousingPower.Set(1);
            }
            if(_storeData.EXHI && _storeData.EXHI.e > GLOBAL.Timestamp() && BASE.isInferno())
            {
               GLOBAL._extraHousing = _storeData.EXHI.e;
               GLOBAL._extraHousingPower.Set(1);
            }
            GLOBAL._towerOverdrive = new SecNum(0);
            if(Boolean(_storeData.TOD) && _storeData.TOD.e < GLOBAL.Timestamp())
            {
               delete _storeData.TOD;
            }
            if(_storeData.TOD)
            {
               GLOBAL._towerOverdrive.Set(_storeData.TOD.e);
            }
            if(Boolean(_storeData.TODI) && _storeData.TODI.e < GLOBAL.Timestamp())
            {
               delete _storeData.TODI;
            }
            if(_storeData.TODI)
            {
               GLOBAL._towerOverdrive.Set(_storeData.TODI.e);
            }
            GLOBAL._monsterOverdrive.Set(0);
            if(GLOBAL._mode == "build")
            {
               GLOBAL._attackerMonsterOverdrive.Set(0);
            }
            if(BASE.isInferno())
            {
               GLOBAL._playerMonsterOverdrive.Set(0);
            }
            if(Boolean(_storeData.MOD) && _storeData.MOD.e < GLOBAL.Timestamp())
            {
               delete _storeData.MOD;
            }
            if(_storeData.MOD)
            {
               GLOBAL._monsterOverdrive.Set(_storeData.MOD.e);
               if(GLOBAL._mode == "build" && BASE._yardType == BASE.MAIN_YARD)
               {
                  GLOBAL._playerMonsterOverdrive.Set(_storeData.MOD.e);
               }
               for each(c in CREATURES._creatures)
               {
                  c.UpdateBuffs();
               }
            }
            GLOBAL._monsterDefenseOverdrive.Set(0);
            if(GLOBAL._mode == "build")
            {
               GLOBAL._attackerMonsterDefenseOverdrive.Set(0);
            }
            if(BASE.isInferno())
            {
               GLOBAL._playerMonsterDefenseOverdrive.Set(0);
            }
            if(Boolean(_storeData.MDOD) && _storeData.MDOD.e < GLOBAL.Timestamp())
            {
               delete _storeData.MDOD;
            }
            if(_storeData.MDOD)
            {
               GLOBAL._monsterDefenseOverdrive.Set(_storeData.MDOD.e);
               if(GLOBAL._mode == "build" && BASE._yardType == BASE.MAIN_YARD)
               {
                  GLOBAL._playerMonsterDefenseOverdrive.Set(_storeData.MDOD.e);
               }
               for each(c in CREATURES._creatures)
               {
                  c.UpdateBuffs();
               }
            }
            GLOBAL._monsterSpeedOverdrive.Set(0);
            if(GLOBAL._mode == "build")
            {
               GLOBAL._attackerMonsterSpeedOverdrive.Set(0);
            }
            if(BASE.isInferno())
            {
               GLOBAL._playerMonsterSpeedOverdrive.Set(0);
            }
            if(Boolean(_storeData.MSOD) && _storeData.MSOD.e < GLOBAL.Timestamp())
            {
               delete _storeData.MSOD;
            }
            if(_storeData.MSOD)
            {
               GLOBAL._monsterSpeedOverdrive.Set(_storeData.MSOD.e);
               if(GLOBAL._mode == "build" && !BASE._yardType)
               {
                  GLOBAL._playerMonsterSpeedOverdrive.Set(_storeData.MSOD.e);
               }
               for each(c in CREATURES._creatures)
               {
                  c.UpdateBuffs();
               }
            }
            if(BASE._isProtected >= GLOBAL.Timestamp() && (Boolean(_storeData.PRO1) || Boolean(_storeData.PRO2) || Boolean(_storeData.PRO3)))
            {
               BASE._isSanctuary = BASE._isProtected;
               UI2.Hide("wmbar");
            }
            GLOBAL._lockerOverdrive = 0;
            if(Boolean(_storeData.CLOD) && _storeData.CLOD.e < GLOBAL.Timestamp())
            {
               delete _storeData.CLOD;
            }
            if(_storeData.CLOD)
            {
               GLOBAL._lockerOverdrive = _storeData.CLOD.e - GLOBAL.Timestamp();
            }
            GLOBAL._buildTime = 1;
            if(Boolean(_storeData.BST) && _storeData.BST.e < GLOBAL.Timestamp())
            {
               delete _storeData.BST;
            }
            if(_storeData.BST)
            {
               GLOBAL._buildTime -= 0.2;
            }
            GLOBAL._upgradePacking = 1;
            if(_storeData.BIP)
            {
               GLOBAL._upgradePacking += 0.1 * _storeData.BIP.q;
            }
            GLOBAL._upgradePacking = int(GLOBAL._upgradePacking * 100) / 100;
            GLOBAL._researchTime = 1;
            if(Boolean(_storeData.RQT) && _storeData.RQT.e < GLOBAL.Timestamp())
            {
               delete _storeData.RQT;
            }
            if(_storeData.RQT)
            {
               GLOBAL._researchTime -= 0.2;
            }
            GLOBAL._designSlots = 4;
            if(_storeData.DSL)
            {
               GLOBAL._designSlots += _storeData.DSL.q;
            }
            Update();
         }
         catch(e:Error)
         {
            LOGGER.Log("err","Store.ProcessPurchases: " + e.message + " | " + e.getStackTrace());
         }
      }
      
      public static function CheckUpgrade(param1:String) : *
      {
         return _storeData[param1];
      }
      
      public static function updateCredits(param1:String) : *
      {
         POPUPS.Next();
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
         if(_loc2_.error == 0)
         {
            if(LOGIN.checkHash(param1))
            {
               BASE._credits.Set(int(_loc2_.credits));
               BASE._hpCredits = int(_loc2_.credits);
               GLOBAL._credits.Set(int(_loc2_.credits));
            }
            else
            {
               LOGGER.Log("err","STORE.updateCrddits " + param1);
            }
         }
         else
         {
            GLOBAL.ErrorMessage(_loc2_.error,GLOBAL.ERROR_ORANGE_BOX_ONLY);
         }
      }
      
      public static function ZazzleAdd() : void
      {
         var img:*;
         var ZazzleImageLoaded:Function = null;
         ZazzleImageLoaded = function(param1:String, param2:BitmapData):void
         {
            var _loc4_:int = 0;
            if(_zazzleMC.numChildren)
            {
               _loc4_ = _zazzleMC.numChildren;
               while(_loc4_--)
               {
                  _zazzleMC.removeChildAt(_loc4_);
               }
            }
            var _loc3_:* = new Bitmap(param2);
            _loc3_.x = (670 - _loc3_.width) / 2;
            _loc3_.y = (390 - _loc3_.height) / 2;
            _zazzleMC.addChild(_loc3_);
            _zazzleMC.buttonMode = true;
            _zazzleMC.useHandCursor = true;
            _zazzleMC.addEventListener(MouseEvent.CLICK,ZazzleClick);
         };
         ZazzleClear();
         _zazzleMC = new MovieClip();
         _mc.window.addChild(_zazzleMC);
         img = "popups/ZAZZLE_AD.v2.jpg";
         ImageCache.GetImageWithCallBack(img,ZazzleImageLoaded);
      }
      
      public static function ZazzleClear() : void
      {
         if(Boolean(_zazzleMC) && Boolean(_zazzleMC.parent))
         {
            _zazzleMC.parent.removeChild(_zazzleMC);
            _zazzleMC = null;
         }
      }
      
      public static function ZazzleClick(param1:Event = null) : void
      {
         GLOBAL.gotoURL("http://www.zazzle.com/backyardmonsters/",null,true,[63,1]);
      }
   }
}

