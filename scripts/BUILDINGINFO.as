package
{
   import com.monsters.radio.RADIO;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import gs.*;
   import gs.easing.*;
   
   internal class BUILDINGINFO
   {
      public static var _mc:MovieClip;
      
      public static var _buttonsMC:*;
      
      public static var _building:BFOUNDATION;
      
      public static var _clickPoint:Point;
      
      public static var _props:Object;
      
      private static var _positionSet:Boolean = false;
      
      public function BUILDINGINFO()
      {
         super();
      }
      
      public static function Show(param1:BFOUNDATION) : *
      {
         if(GLOBAL._selectedBuilding && Boolean(GLOBAL._selectedBuilding._moving))
         {
            return;
         }
         _positionSet = false;
         _building = param1;
         _props = GLOBAL._buildingProps[_building._type - 1];
         _mc = MAP._BUILDINGINFO.addChild(new buildingInfo());
         _mc.tName.autoSize = TextFieldAutoSize.CENTER;
         var _loc2_:* = "<b>" + KEYS.Get(_props.name) + "</b>";
         if(_building._lvl.Get() > 0 && GLOBAL._buildingProps[param1._type - 1].costs && GLOBAL._buildingProps[param1._type - 1].costs.length > 1)
         {
            _loc2_ += "<br><b>" + KEYS.Get("bdg_infopop_levelnum",{"v1":param1._lvl.Get()}) + "</b>";
            if(_building._class == "tower" && _building._type != 22 && GLOBAL._towerOverdrive && GLOBAL._towerOverdrive.Get() >= GLOBAL.Timestamp() && _building._countdownBuild.Get() == 0 && _building._countdownUpgrade.Get() == 0)
            {
               _loc2_ += "<font color=\"#0000ff\"> <br><b>(25% Boost)</b></font>";
            }
         }
         _mc.tName.htmlText = _loc2_;
         _mc.removeEventListener(Event.ENTER_FRAME,Tick);
         _mc.addEventListener(Event.ENTER_FRAME,Tick);
         if(GLOBAL._zoomed)
         {
            _mc.scaleY = 2;
            _mc.scaleX = 2;
         }
         Update();
      }
      
      public static function Update() : *
      {
         var _loc4_:BFOUNDATION = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc11_:Button_CLIP = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:TextField = null;
         var _loc1_:Array = [];
         var _loc2_:Boolean = true;
         var _loc3_:int = 0;
         for each(_loc4_ in BASE._buildingsAll)
         {
            if(_loc4_._hp.Get() < _loc4_._hpMax.Get())
            {
               _loc3_ += 1;
            }
         }
         if(_mc)
         {
            if(GLOBAL._mode == "build")
            {
               if(_building._hp.Get() < _building._hpMax.Get())
               {
                  _loc2_ = false;
                  if(_building._repairing == 0)
                  {
                     _loc1_.push(["btn_repair",30]);
                  }
                  else
                  {
                     _loc1_.push(["btn_speedup",30,_loc3_ >= 2 ? false : true]);
                     if(_loc3_ >= 2)
                     {
                        _loc1_.push(["btn_repairall",30,true]);
                     }
                  }
               }
               else if(_building._countdownBuild.Get() > 0)
               {
                  _loc2_ = false;
                  _loc1_.push(["btn_speedup",30,true]);
                  if(TUTORIAL._stage > 100 && _building._buildingProps.type != "decoration")
                  {
                     _loc1_.push(["btn_stopbuild",26]);
                  }
               }
               else if(_building._countdownUpgrade.Get() > 0)
               {
                  _loc2_ = false;
                  _loc1_.push(["btn_speedup",30,true]);
                  if(TUTORIAL._stage > 100)
                  {
                     _loc1_.push(["btn_stopupgrade",26]);
                  }
               }
               else
               {
                  if(_props.type == "resource" && TUTORIAL._stage != 20 && TUTORIAL._stage != 21)
                  {
                     _loc1_.push(["btn_bank",30,0,GLOBAL.FormatNumber(_building._stored.Get())]);
                  }
                  if(_props.type == "resource" && TUTORIAL._stage >= 200)
                  {
                     _loc1_.push(["btn_bankall",30]);
                  }
               }
               if(TUTORIAL._stage > 4)
               {
                  if(_loc2_)
                  {
                     _loc10_ = false;
                     if(_building._countdownBuild.Get() + _building._countdownUpgrade.Get() > 0 || _building._repairing > 0)
                     {
                        _loc1_.push(["btn_speedup",30,true]);
                        _loc10_ = true;
                     }
                     if(_props.id == 8)
                     {
                        _loc1_.push(["btn_openlocker",30,true]);
                        if(CREATURELOCKER._unlocking != null && !_loc10_)
                        {
                           _loc1_.push(["btn_speedup",30,true]);
                        }
                     }
                     else if(_props.id == 9)
                     {
                        _loc1_.push(["btn_juicemonsters",30,true]);
                        if(CREATURES._guardian)
                        {
                           _loc1_.push(["btn_juiceguardian",30,true]);
                        }
                     }
                     else if(_props.id == 10)
                     {
                        _loc1_.push(["btn_yardplanner",30,true]);
                     }
                     else if(_props.id == 11 || _props.id == 5 || _props.id == 51)
                     {
                        _loc1_.push(["btn_viewmap",30,true]);
                     }
                     else if(_props.id == 12)
                     {
                        _loc1_.push(["btn_openstore",30,true]);
                     }
                     else if(_props.id == 13)
                     {
                        if(GLOBAL._bHatcheryCC)
                        {
                           _loc1_.push(["btn_openhcc",30,true]);
                        }
                        else
                        {
                           _loc1_.push(["btn_viewhatchery",30,true]);
                        }
                        if(!GLOBAL._hatcheryOverdrive && !_loc10_ && TUTORIAL._stage > 200)
                        {
                           _loc1_.push(["btn_speedup",30,true]);
                        }
                     }
                     else if(_props.id == 15)
                     {
                        _loc1_.push(["btn_viewhousing",30,true]);
                     }
                     else if(_props.id == 19)
                     {
                        _loc1_.push(["btn_openbaiter",30,true]);
                     }
                     else if(_props.id == 22)
                     {
                        _loc1_.push(["btn_openbunker",30,true]);
                     }
                     else if(_props.id == 16)
                     {
                        _loc1_.push(["btn_openhcc",30,true]);
                        if(!GLOBAL._hatcheryOverdrive && !_loc10_)
                        {
                           _loc1_.push(["btn_speedup",30,true]);
                        }
                     }
                     else if(_props.id == 26)
                     {
                        _loc1_.push(["btn_openacademy",30,true]);
                        if(Boolean(_building._upgrading) && !_loc10_)
                        {
                           _loc1_.push(["btn_speedup",30,true]);
                        }
                     }
                     else if(_props.id == 113)
                     {
                        _loc1_.push(["btn_openradio",30,true]);
                     }
                     else if(_props.id == 114)
                     {
                        _loc1_.push(["btn_opencage",30,true]);
                     }
                     else if(_props.id == 116)
                     {
                        _loc1_.push(["btn_openlab",30,true]);
                     }
                  }
                  if(_loc2_ && _props.type != "mushroom")
                  {
                     if(_props.type != "decoration")
                     {
                        _loc1_.push(["btn_upgrade",30]);
                     }
                     if(_props.type == "wall")
                     {
                        _loc1_.push(["btn_upgradeall",30,1]);
                     }
                     if(_props.type == "resource")
                     {
                        if(!GLOBAL._harvesterOverdrive || GLOBAL._harvesterOverdrive < GLOBAL.Timestamp())
                        {
                           _loc1_.push(["btn_speedup",30,1]);
                        }
                     }
                     if(TUTORIAL._stage >= 200)
                     {
                        _loc1_.push(["btn_move",30]);
                        _loc1_.push(["btn_more",30]);
                     }
                  }
                  if(_loc2_ && _props.type == "taunt")
                  {
                     _loc1_.push(["btn_viewmessage",30]);
                  }
               }
            }
            else if(LOGIN._playerID == _building._senderid)
            {
               _loc1_.push(["btn_editmessage",26]);
            }
            else if(_props.type == "taunt")
            {
               _loc1_.push(["btn_viewmessage",30]);
            }
            else
            {
               _loc1_.push(["btn_help",30]);
            }
            if(_props.type == "mushroom")
            {
               _loc1_.push(["btn_pick",30,true]);
            }
            _loc5_ = _mc.tName.y + _mc.tName.height + 5;
            if(!_positionSet)
            {
               _positionSet = true;
               _clickPoint = new Point(MAP._GROUND.mouseX,MAP._GROUND.mouseY);
               _mc.x = int(_clickPoint.x) - 60;
               _mc.y = int(_clickPoint.y) - _loc5_ - 15;
            }
            if(_buttonsMC)
            {
               _mc.removeChild(_buttonsMC);
            }
            _buttonsMC = _mc.addChild(new MovieClip());
            _loc6_ = 0;
            while(_loc6_ < _loc1_.length)
            {
               _loc11_ = new Button_CLIP();
               _buttonsMC.addChild(_loc11_);
               if(_loc1_[_loc6_][0] == "btn_move")
               {
                  _loc11_.SetupKey(_loc1_[_loc6_][0],false,52,_loc1_[_loc6_][1]);
                  _loc11_.x = 6;
                  _loc11_.y = _loc5_;
               }
               else if(_loc1_[_loc6_][0] == "btn_more")
               {
                  _loc11_.SetupKey(_loc1_[_loc6_][0],false,55,_loc1_[_loc6_][1]);
                  _loc11_.x = 60;
                  _loc11_.y = _loc5_;
                  _loc5_ += _loc11_.height + 2;
               }
               else if(_loc1_[_loc6_][0] == "btn_bank")
               {
                  _loc11_.labelKey = "btn_bank";
                  _loc11_.Setup(KEYS.Get("btn_bank",{"v1":_loc1_[_loc6_][3]}),false,110,_loc1_[_loc6_][1]);
                  _loc11_.x = 6;
                  _loc11_.y = _loc5_;
                  _loc5_ += _loc11_.height + 2;
               }
               else if(_loc1_[_loc6_][0] == "btn_bankall")
               {
                  _loc11_.labelKey = "btn_bankall";
                  _loc11_.SetupKey(_loc1_[_loc6_][0],false,110,_loc1_[_loc6_][1]);
                  _loc11_.x = 6;
                  _loc11_.y = _loc5_;
                  _loc5_ += _loc11_.height + 2;
               }
               else
               {
                  _loc11_.SetupKey(_loc1_[_loc6_][0],false,110,_loc1_[_loc6_][1]);
                  _loc11_.x = 6;
                  _loc11_.y = _loc5_;
                  _loc5_ += _loc11_.height + 2;
               }
               _loc12_ = _loc1_[_loc6_][0] == "btn_bank" ? 4 : 3;
               if(_loc1_[_loc6_][2])
               {
                  _loc11_.Highlight = true;
               }
               if(_loc1_[_loc6_][_loc12_])
               {
                  _loc11_.Enabled = false;
               }
               _loc11_.addEventListener(MouseEvent.MOUSE_DOWN,Special);
               _loc6_++;
            }
            _loc5_ += 5;
            _loc7_ = "";
            if(_building._hp.Get() < _building._hpMax.Get())
            {
               _loc8_ = 0;
               if(_building._lvl.Get() == 0)
               {
                  _loc8_ = int(_building._buildingProps.repairTime[0]);
               }
               else
               {
                  _loc8_ = int(_building._buildingProps.repairTime[_building._lvl.Get() - 1]);
               }
               _loc8_ = Math.min(60 * 60,_loc8_);
               _loc8_ = Math.ceil(_building._hpMax.Get() / _loc8_);
               if(_building._repairing)
               {
                  _loc7_ = KEYS.Get("ui_repairing",{"v1":GLOBAL.ToTime(int((_building._hpMax.Get() - _building._hp.Get()) / _loc8_),true,true)});
               }
            }
            else if(_building._countdownBuild.Get() > 0)
            {
               _loc7_ = KEYS.Get("ui_building",{"v1":GLOBAL.ToTime(_building._countdownBuild.Get(),true,true)});
            }
            else if(_building._countdownUpgrade.Get() > 0)
            {
               _loc7_ = KEYS.Get("ui_upgrading",{"v1":GLOBAL.ToTime(_building._countdownUpgrade.Get(),true,true)});
            }
            else if(_building._class == "resource")
            {
               if(_building._producing)
               {
                  _loc13_ = _building._buildingProps.capacity[_building._lvl.Get() - 1] - _building._stored.Get();
                  _loc14_ = 60 / _building._buildingProps.cycleTime[_building._lvl.Get() - 1] * _building._buildingProps.produce[_building._lvl.Get() - 1];
                  if(BASE._isOutpost)
                  {
                     _loc14_ = BRESOURCE.AdjustProduction(GLOBAL._currentCell,_loc14_);
                  }
                  if(GLOBAL._harvesterOverdrive >= GLOBAL.Timestamp() && GLOBAL._harvesterOverdrivePower.Get() > 0)
                  {
                     _loc14_ *= GLOBAL._harvesterOverdrivePower.Get();
                  }
                  _loc15_ = _loc13_ / _loc14_ * 60;
                  _loc16_ = 100 / _building._buildingProps.capacity[_building._lvl.Get() - 1] * _building._stored.Get();
                  _loc7_ = KEYS.Get("ui_producing",{
                     "v1":KEYS.Get(GLOBAL._resourceNames[_building._type - 1]),
                     "v2":GLOBAL.ToTime(_loc15_,true,true),
                     "v3":_loc16_
                  });
               }
               else
               {
                  _loc7_ = KEYS.Get("ui_buildingfull");
               }
            }
            if(_loc7_ != "")
            {
               _loc9_ = MAP._GROUND.x + _mc.x;
               if(_loc9_ < 500)
               {
                  _mc.gotoAndStop(2);
                  _loc17_ = _mc.tInfoRight;
               }
               else
               {
                  _mc.gotoAndStop(3);
                  _loc17_ = _mc.tInfoLeft;
               }
               _loc17_.autoSize = TextFieldAutoSize.CENTER;
               _loc17_.htmlText = _loc7_;
               if(_loc17_.height + 10 > _loc5_)
               {
                  _loc5_ = _loc17_.height + 10;
               }
               if(_loc17_.height < _loc5_)
               {
                  _loc17_.y = (_loc5_ - _loc17_.height) * 0.5;
               }
            }
            _mc.mcBG.height = _loc5_;
         }
      }
      
      public static function Tick(param1:Event) : *
      {
         if(_mc.mouseX > 150 || _mc.mouseX < -30 || _mc.mouseY > _mc.mcBG.height + 20 || _mc.mouseY < -50)
         {
            Hide();
         }
      }
      
      public static function Hide(param1:MouseEvent = null) : *
      {
         if(_mc)
         {
            _mc.removeEventListener(Event.ENTER_FRAME,Tick);
            MAP._BUILDINGINFO.removeChild(_mc);
            _mc = null;
            _buttonsMC = null;
            if(!STORE._open && !HATCHERY._open && !HATCHERYCC._open && !CREATURELOCKER._open && !ACADEMY._open && !MONSTERBUNKER._open)
            {
               BASE.BuildingDeselect();
            }
         }
      }
      
      public static function Special(param1:MouseEvent) : *
      {
         var _loc2_:BFOUNDATION = null;
         var _loc3_:MONSTERLAB = null;
         if(param1.target.labelKey == "btn_bank")
         {
            _building.Bank();
            SALESPECIALSPOPUP.Check();
         }
         if(param1.target.labelKey == "btn_bankall")
         {
            for each(_loc2_ in BASE._buildingsAll)
            {
               if(_loc2_._class == "resource" && _loc2_._countdownUpgrade.Get() == 0 && _loc2_._countdownBuild.Get() == 0 && _loc2_._hp.Get() == _loc2_._hpMax.Get())
               {
                  _loc2_.Bank();
               }
            }
            SALESPECIALSPOPUP.Check();
         }
         if(param1.target.labelKey == "btn_openlocker")
         {
            CREATURELOCKER.Show();
         }
         if(param1.target.labelKey == "btn_viewmap")
         {
            GLOBAL.ShowMap();
         }
         if(param1.target.labelKey == "btn_openlab")
         {
            _loc3_ = GLOBAL._bLab as MONSTERLAB;
            _loc3_.Show();
         }
         if(param1.target.labelKey == "btn_viewhatchery")
         {
            HATCHERY.Show(_building as BUILDING13);
         }
         if(param1.target.labelKey == "btn_viewhousing" || param1.target.labelKey == "btn_juicemonsters")
         {
            HOUSING.Show();
         }
         if(param1.target.labelKey == "btn_juiceguardian")
         {
            GUARDIANCAGE.ShowJuice();
         }
         if(param1.target.labelKey == "btn_openstore")
         {
            STORE.ShowB(1,0);
         }
         if(param1.target.labelKey == "btn_yardplanner")
         {
            PLANNER.Show();
         }
         if(param1.target.labelKey == "btn_openbunker")
         {
            MONSTERBUNKER.Show();
         }
         if(param1.target.labelKey == "btn_stopbuild")
         {
            _building.Recycle();
         }
         if(param1.target.labelKey == "btn_stopupgrade")
         {
            _building.UpgradeCancel();
         }
         if(param1.target.labelKey == "btn_openhcc")
         {
            HATCHERYCC.Show();
         }
         if(param1.target.labelKey == "btn_openbaiter")
         {
            MONSTERBAITER.Show();
         }
         if(param1.target.labelKey == "btn_openacademy")
         {
            ACADEMY.Show(_building);
         }
         if(param1.target.labelKey == "btn_repair")
         {
            _building.Repair();
         }
         if(param1.target.labelKey == "btn_repairall")
         {
            STORE.ShowB(3,1,["FIX"]);
         }
         if(param1.target.labelKey == "btn_help")
         {
            _building.Help();
         }
         if(param1.target.labelKey == "btn_openradio")
         {
            RADIO.Show();
         }
         if(param1.target.labelKey == "btn_opencage")
         {
            GUARDIANCAGE.Show();
         }
         if(param1.target.labelKey == "btn_move")
         {
            _building.StartMove();
         }
         if(param1.target.labelKey == "btn_upgrade")
         {
            BUILDINGOPTIONS.Show(_building,"upgrade");
         }
         if(param1.target.labelKey == "btn_upgradeall")
         {
            STORE.ShowB(1,0,["BLK2","BLK3","BLK4","BLK5"]);
         }
         if(param1.target.labelKey == "btn_more")
         {
            BUILDINGOPTIONS.Show(_building,"more");
         }
         if(param1.target.labelKey == "btn_pick")
         {
            MUSHROOMS.PickWorker(_building);
         }
         if(param1.target.labelKey == "btn_speedup")
         {
            if(Boolean(_building._repairing) || _building._countdownBuild.Get() + _building._countdownUpgrade.Get() > 0)
            {
               STORE.ShowB(3,0,["SP1","SP2","SP3","SP4"]);
            }
            else if(_props.id == 8)
            {
               STORE.ShowB(3,0,["SP1","SP2","SP3","SP4"]);
            }
            else if(_props.id == 13 || _props.id == 16)
            {
               STORE.ShowB(3,1,["HOD","HOD2","HOD3"]);
            }
            else if(_props.id == 26)
            {
               STORE.ShowB(3,0,["SP1","SP2","SP3","SP4"]);
            }
            else if(_props.type == "resource")
            {
               STORE.ShowB(3,1,["POD"]);
            }
         }
         if(param1.target.labelKey == "btn_viewmessage")
         {
            SIGNS.ShowMessage(_building);
         }
         if(param1.target.labelKey == "btn_editmessage")
         {
            SIGNS.EditForBuilding(_building);
         }
         Hide();
      }
   }
}

