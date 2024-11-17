package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class ACADEMYPOPUP extends ACADEMYPOPUP_CLIP
   {
      public static var _monsterID:String;
      
      public static var _page:int = 1;
      
      public static var _maxSpeed:int = 0;
      
      public static var _maxHealth:int = 0;
      
      public static var _maxDamage:int = 0;
      
      public static var _maxTime:int = 0;
      
      public static var _maxResource:int = 0;
      
      public static var _maxStorage:int = 0;
      
      public static var _instantUpgradeCost:int = 0;
      
      private var _portraitImage:DisplayObject;
      
      private var _guidePage:int = 1;
      
      public function ACADEMYPOPUP()
      {
         var _loc2_:String = null;
         super();
         bPrevious.addEventListener(MouseEvent.CLICK,this.Previous);
         bPrevious.mcArrow.gotoAndStop(2);
         bNext.addEventListener(MouseEvent.CLICK,this.Next);
         bNext.mcArrow.gotoAndStop(2);
         var _loc1_:int = 1;
         while(_loc1_ < 5)
         {
            bB["mcR" + _loc1_].visible = false;
            if(_loc1_ != 3)
            {
               bB["mcR" + _loc1_].alpha = 0.25;
            }
            bB["mcR" + _loc1_].tTitle.htmlText = "<b>" + KEYS.Get(GLOBAL._resourceNames[_loc1_ - 1]) + "</b>";
            bB["mcR" + _loc1_].tValue.htmlText = "<b>0</b>";
            bB["mcR" + _loc1_].gotoAndStop(_loc1_);
            _loc1_++;
         }
         bB.mcTime.visible = false;
         bB.mcTime.tTitle.htmlText = "<b>" + KEYS.Get("#r_time#") + "</b>";
         bB.mcTime.gotoAndStop(6);
         for(_loc2_ in CREATURELOCKER._creatures)
         {
            if(CREATURES.GetProperty(_loc2_,"speed",10) > _maxSpeed)
            {
               _maxSpeed = CREATURES.GetProperty(_loc2_,"speed",10);
            }
            if(CREATURES.GetProperty(_loc2_,"health",10) > _maxHealth)
            {
               _maxHealth = CREATURES.GetProperty(_loc2_,"health",10);
            }
            if(CREATURES.GetProperty(_loc2_,"damage",10) > _maxDamage)
            {
               _maxDamage = CREATURES.GetProperty(_loc2_,"damage",10);
            }
            if(CREATURES.GetProperty(_loc2_,"cTime",10) > _maxTime)
            {
               _maxTime = CREATURES.GetProperty(_loc2_,"cTime",10);
            }
            if(CREATURES.GetProperty(_loc2_,"cResource",10) > _maxResource)
            {
               _maxResource = CREATURES.GetProperty(_loc2_,"cResource",10);
            }
            if(CREATURES.GetProperty(_loc2_,"cStorage",10) > _maxStorage)
            {
               _maxStorage = CREATURES.GetProperty(_loc2_,"cStorage",10);
            }
         }
         if(ACADEMY._building._upgrading)
         {
            _page = int(String(ACADEMY._building._upgrading).substr(1));
         }
         this.Setup("C" + _page);
         speed_txt.htmlText = "<b>" + KEYS.Get("acad_att_speed") + "</b>";
         health_txt.htmlText = "<b>" + KEYS.Get("acad_att_health") + "</b>";
         damage_txt.htmlText = "<b>" + KEYS.Get("acad_att_damage") + "</b>";
         cost_txt.htmlText = "<b>" + KEYS.Get("acad_att_cost") + "</b>";
         housing_txt.htmlText = "<b>" + KEYS.Get("acad_att_housing") + "</b>";
         time_txt.htmlText = "<b>" + KEYS.Get("acad_att_time") + "</b>";
         before_txt.htmlText = "<b>" + KEYS.Get("acad_att_before") + "</b>";
         after_txt.htmlText = "<b>" + KEYS.Get("acad_att_after") + "</b>";
      }
      
      public function Setup(param1:String) : *
      {
         _monsterID = param1;
         if(!ACADEMY._upgrades[_monsterID])
         {
            ACADEMY._upgrades[_monsterID] = {"level":1};
         }
         this.Update(true);
      }
      
      private function UpdatePortrait(param1:String, param2:BitmapData, param3:Array) : *
      {
         if(Boolean(this._portraitImage) && Boolean(this._portraitImage.parent))
         {
            this._portraitImage.parent.removeChild(this._portraitImage);
            this._portraitImage = null;
         }
         if(param3[0] == _monsterID)
         {
            this._portraitImage = mcImage.addChild(new Bitmap(param2));
         }
      }
      
      private function CalculateInstantCost() : *
      {
         var _loc1_:Array = CREATURELOCKER._creatures[_monsterID].trainingCosts[ACADEMY._upgrades[_monsterID].level - 1];
         var _loc2_:String = KEYS.Get(CREATURELOCKER._creatures[_monsterID].name);
         var _loc3_:int = int(_loc1_[0]);
         var _loc4_:int = int(_loc1_[1]);
         var _loc5_:int = STORE.GetTimeCost(_loc4_);
         var _loc6_:int = Math.ceil(Math.pow(Math.sqrt(_loc3_ / 2),0.75));
         _instantUpgradeCost = _loc5_ + _loc6_;
      }
      
      public function Update(param1:Boolean = false) : *
      {
         var _loc7_:Boolean = false;
         var _loc2_:Object = ACADEMY._upgrades[_monsterID];
         var _loc3_:Object = ACADEMY.StartMonsterUpgrade(_monsterID,true);
         var _loc4_:Array = CREATURELOCKER._creatures[_monsterID].trainingCosts[ACADEMY._upgrades[_monsterID].level - 1];
         if(Boolean(this._portraitImage) && Boolean(this._portraitImage.parent))
         {
            this._portraitImage.parent.removeChild(this._portraitImage);
            this._portraitImage = null;
         }
         ImageCache.GetImageWithCallBack("monsters/" + _monsterID + "-portrait.jpg",this.UpdatePortrait,true,1,"",[_monsterID]);
         if(_loc2_.time)
         {
            bA.bAction.removeEventListener(MouseEvent.CLICK,this.SpeedUp);
            bA.bAction.removeEventListener(MouseEvent.CLICK,this.InstantMonsterUpgrade);
            bB.bAction.removeEventListener(MouseEvent.CLICK,this.StartMonsterUpgrade);
            bB.bAction.removeEventListener(MouseEvent.CLICK,this.CancelMonsterUpgrade);
            bA.gArrow.visible = false;
            bA.tDescription.visible = false;
            bA.gCoin.visible = false;
            bA.bAction.SetupKey("btn_speedup");
            bA.bAction.addEventListener(MouseEvent.CLICK,this.SpeedUp);
            bA.bAction.Highlight = true;
            bA.bAction.Enabled = true;
            bB.bAction.SetupKey("btn_cancel");
            bB.bAction.addEventListener(MouseEvent.CLICK,this.CancelMonsterUpgrade);
            bB.bAction.visible = true;
            bB.mcR1.visible = false;
            bB.mcR2.visible = false;
            bB.mcR3.visible = false;
            bB.mcR4.visible = false;
            bB.mcTime.visible = false;
            if(_monsterID == ACADEMY._building._upgrading)
            {
               bPrevious.visible = bNext.visible = false;
            }
         }
         else
         {
            if(!_loc3_.error)
            {
               bA.tDescription.htmlText = KEYS.Get("academy_traininstantly");
               this.CalculateInstantCost();
               bA.gArrow.visible = true;
               bA.tDescription.visible = true;
               bA.gCoin.visible = true;
               bA.bAction.removeEventListener(MouseEvent.CLICK,this.SpeedUp);
               bA.bAction.Setup(KEYS.Get("btn_useshiny",{"v1":_instantUpgradeCost}));
               bA.bAction.removeEventListener(MouseEvent.CLICK,this.SpeedUp);
               bA.bAction.Enabled = true;
               bA.bAction.Highlight = true;
               bA.bAction.removeEventListener(MouseEvent.CLICK,this.InstantMonsterUpgrade);
               bA.bAction.addEventListener(MouseEvent.CLICK,this.InstantMonsterUpgrade);
               bB.bAction.SetupKey("acad_starttraining_btn");
               bB.bAction.addEventListener(MouseEvent.CLICK,this.StartMonsterUpgrade);
               bB.bAction.removeEventListener(MouseEvent.CLICK,this.CancelMonsterUpgrade);
               bB.bAction.visible = true;
               bB.mcR1.visible = true;
               bB.mcR2.visible = true;
               bB.mcR3.visible = true;
               bB.mcR3.tValue.htmlText = "<b><font color=\"#" + (_loc4_[0] > GLOBAL._resources.r3.Get() ? "FF0000" : "000000") + "\">" + GLOBAL.FormatNumber(_loc4_[0]) + "</font></b>";
               bB.mcR4.visible = true;
               bB.mcTime.visible = true;
               bB.mcTime.tValue.htmlText = "<b>" + GLOBAL.ToTime(_loc4_[1]) + "</b>";
            }
            else if(_loc3_.status == KEYS.Get("acad_err_putty"))
            {
               bA.tDescription.visible = true;
               bA.gArrow.visible = true;
               bA.gCoin.visible = true;
               bA.tDescription.htmlText = KEYS.Get("academy_traininstantly");
               bB.mcR1.visible = true;
               bB.mcR2.visible = true;
               bB.mcR3.visible = true;
               bB.mcR3.tValue.htmlText = "<b><font color=\"#" + (_loc4_[0] > GLOBAL._resources.r3.Get() ? "FF0000" : "000000") + "\">" + GLOBAL.FormatNumber(_loc4_[0]) + "</font></b>";
               bB.mcR4.visible = true;
               bB.mcTime.visible = true;
               bB.mcTime.tValue.htmlText = "<b>" + GLOBAL.ToTime(_loc4_[1]) + "</b>";
               this.CalculateInstantCost();
               bA.bAction.Setup(KEYS.Get("btn_useshiny",{"v1":_instantUpgradeCost}));
               bA.bAction.removeEventListener(MouseEvent.CLICK,this.InstantMonsterUpgrade);
               bA.bAction.addEventListener(MouseEvent.CLICK,this.InstantMonsterUpgrade);
               bA.bAction.removeEventListener(MouseEvent.CLICK,this.SpeedUp);
               bA.bAction.Enabled = true;
               bA.bAction.Highlight = true;
               bB.bAction.Setup(_loc3_.errorMessage);
               bB.bAction.removeEventListener(MouseEvent.CLICK,this.StartMonsterUpgrade);
               bB.bAction.removeEventListener(MouseEvent.CLICK,this.CancelMonsterUpgrade);
               bB.bAction.Enabled = false;
               bB.bAction.visible = true;
            }
            else if(bA.label != _loc3_.errorMessage)
            {
               bA.gArrow.visible = false;
               bA.tDescription.visible = false;
               bA.gCoin.visible = false;
               bB.mcR1.visible = false;
               bB.mcR2.visible = false;
               bB.mcR3.visible = false;
               bB.mcR4.visible = false;
               bB.mcTime.visible = false;
               bA.bAction.removeEventListener(MouseEvent.CLICK,this.InstantMonsterUpgrade);
               bA.bAction.removeEventListener(MouseEvent.CLICK,this.SpeedUp);
               bA.bAction.Setup(_loc3_.errorMessage);
               bA.bAction.Enabled = false;
               bA.bAction.Highlight = false;
               bB.bAction.removeEventListener(MouseEvent.CLICK,this.StartMonsterUpgrade);
               bB.bAction.removeEventListener(MouseEvent.CLICK,this.CancelMonsterUpgrade);
               bB.bAction.visible = false;
            }
            bA.bAction.Highlight = false;
            bPrevious.visible = bNext.visible = true;
         }
         var _loc5_:* = "<b>" + KEYS.Get("acad_mon_name") + "</b> " + KEYS.Get(CREATURELOCKER._creatures[_monsterID].name) + "<br>";
         _loc5_ = _loc5_ + ("<b>" + KEYS.Get("acad_mon_status") + "</b> " + _loc3_.status);
         _loc5_ = _loc5_ + ("<br>" + KEYS.Get(CREATURELOCKER._creatures[_monsterID].description));
         tName.htmlText = _loc5_;
         var _loc6_:int = CREATURES.GetProperty(_monsterID,"damage");
         if(_loc6_ > 0)
         {
            _loc7_ = false;
         }
         else
         {
            _loc7_ = true;
         }
         bSpeedA.mcBar.width = 100 / _maxSpeed * CREATURES.GetProperty(_monsterID,"speed");
         bHealthA.mcBar.width = 100 / _maxHealth * CREATURES.GetProperty(_monsterID,"health");
         if(!_loc7_)
         {
            bDamageA.mcBar.width = 100 / _maxDamage * _loc6_;
         }
         else
         {
            bDamageA.mcBar.width = 100 / _maxDamage * -_loc6_;
         }
         bResourceA.mcBar.width = 100 / _maxResource * CREATURES.GetProperty(_monsterID,"cResource");
         bStorageA.mcBar.width = 100 / _maxStorage * CREATURES.GetProperty(_monsterID,"cStorage");
         bTimeA.mcBar.width = 100 / _maxTime * CREATURES.GetProperty(_monsterID,"cTime");
         tSpeedA.htmlText = KEYS.Get("mon_att_speedvalue",{"v1":CREATURES.GetProperty(_monsterID,"speed")});
         tHealthA.htmlText = CREATURES.GetProperty(_monsterID,"health").toString();
         if(!_loc7_)
         {
            tDamageA.htmlText = _loc6_.toString();
         }
         else
         {
            tDamageA.htmlText = -_loc6_ + " (" + KEYS.Get("str_heal") + ")";
         }
         tResourceA.htmlText = KEYS.Get("mon_att_costvalue",{"v1":CREATURES.GetProperty(_monsterID,"cResource")});
         tStorageA.htmlText = KEYS.Get("mon_att_housingvalue",{"v1":CREATURES.GetProperty(_monsterID,"cStorage")});
         tTimeA.htmlText = GLOBAL.ToTime(CREATURES.GetProperty(_monsterID,"cTime"),true);
         var _loc8_:int = ACADEMY._upgrades[_monsterID].level + 1;
         _loc6_ = CREATURES.GetProperty(_monsterID,"damage",_loc8_);
         if(_loc7_)
         {
            _loc6_ = -_loc6_;
         }
         bSpeedB.mcBar.width = 100 / _maxSpeed * CREATURES.GetProperty(_monsterID,"speed",_loc8_);
         bHealthB.mcBar.width = 100 / _maxHealth * CREATURES.GetProperty(_monsterID,"health",_loc8_);
         bDamageB.mcBar.width = 100 / _maxDamage * _loc6_;
         bResourceB.mcBar.width = 100 / _maxResource * CREATURES.GetProperty(_monsterID,"cResource",_loc8_);
         bStorageB.mcBar.width = 100 / _maxStorage * CREATURES.GetProperty(_monsterID,"cStorage",_loc8_);
         bTimeB.mcBar.width = 100 / _maxTime * CREATURES.GetProperty(_monsterID,"cTime",_loc8_);
         tSpeedB.htmlText = KEYS.Get("mon_att_speedvalue",{"v1":CREATURES.GetProperty(_monsterID,"speed",_loc8_)});
         tHealthB.htmlText = CREATURES.GetProperty(_monsterID,"health",_loc8_).toString();
         if(!_loc7_)
         {
            tDamageB.htmlText = _loc6_.toString();
         }
         else
         {
            tDamageB.htmlText = _loc6_ + " (" + KEYS.Get("str_heal") + ")";
         }
         tResourceB.htmlText = KEYS.Get("mon_att_costvalue",{"v1":CREATURES.GetProperty(_monsterID,"cResource",_loc8_)});
         tStorageB.htmlText = KEYS.Get("mon_att_housingvalue",{"v1":CREATURES.GetProperty(_monsterID,"cStorage",_loc8_)});
         tTimeB.htmlText = GLOBAL.ToTime(CREATURES.GetProperty(_monsterID,"cTime",_loc8_),true);
         if(CREATURES.GetProperty(_monsterID,"speed") != CREATURES.GetProperty(_monsterID,"speed",_loc8_))
         {
            bSpeedB.mcBar.gotoAndStop(2);
         }
         else
         {
            bSpeedB.mcBar.gotoAndStop(1);
         }
         if(CREATURES.GetProperty(_monsterID,"health") != CREATURES.GetProperty(_monsterID,"health",_loc8_))
         {
            bHealthB.mcBar.gotoAndStop(2);
         }
         else
         {
            bHealthB.mcBar.gotoAndStop(1);
         }
         if(CREATURES.GetProperty(_monsterID,"damage") != CREATURES.GetProperty(_monsterID,"damage",_loc8_))
         {
            bDamageB.mcBar.gotoAndStop(2);
         }
         else
         {
            bDamageB.mcBar.gotoAndStop(1);
         }
         if(CREATURES.GetProperty(_monsterID,"cResource") != CREATURES.GetProperty(_monsterID,"cResource",_loc8_))
         {
            bResourceB.mcBar.gotoAndStop(2);
         }
         else
         {
            bResourceB.mcBar.gotoAndStop(1);
         }
         if(CREATURES.GetProperty(_monsterID,"cStorage") != CREATURES.GetProperty(_monsterID,"cStorage",_loc8_))
         {
            bStorageB.mcBar.gotoAndStop(2);
         }
         else
         {
            bStorageB.mcBar.gotoAndStop(1);
         }
         if(CREATURES.GetProperty(_monsterID,"cTime") != CREATURES.GetProperty(_monsterID,"cTime",_loc8_))
         {
            bTimeB.mcBar.gotoAndStop(2);
         }
         else
         {
            bTimeB.mcBar.gotoAndStop(1);
         }
      }
      
      public function StartMonsterUpgrade(param1:MouseEvent) : *
      {
         ACADEMY.StartMonsterUpgrade(_monsterID);
         this.Setup(_monsterID);
      }
      
      public function InstantMonsterUpgrade(param1:MouseEvent) : *
      {
         var Post:Function;
         var building:* = undefined;
         var monsterName:String = null;
         var popupMC:popup_monster = null;
         var e:MouseEvent = param1;
         if(BASE._credits.Get() < _instantUpgradeCost)
         {
            POPUPS.DisplayGetShiny();
            return;
         }
         if(ACADEMY._upgrades[_monsterID].time)
         {
            delete ACADEMY._upgrades[_monsterID].time;
         }
         if(ACADEMY._upgrades[_monsterID].duration)
         {
            delete ACADEMY._upgrades[_monsterID].duration;
         }
         ++ACADEMY._upgrades[_monsterID].level;
         if(GLOBAL._playerCreatureUpgrades[_monsterID])
         {
            ++GLOBAL._playerCreatureUpgrades[_monsterID].level;
         }
         else
         {
            GLOBAL._playerCreatureUpgrades[_monsterID].level = ACADEMY._upgrades[_monsterID].level;
         }
         for each(building in BASE._buildingsAll)
         {
            if(building._type == 26)
            {
            }
            if(building._type == 26 && building._upgrading == _monsterID)
            {
               building._upgrading = null;
               break;
            }
         }
         LOGGER.Stat([47,_monsterID.substr(1),ACADEMY._upgrades[_monsterID].level]);
         if(GLOBAL._mode == "build")
         {
            Post = function():*
            {
               GLOBAL.CallJS("sendFeed",["academy-training",KEYS.Get("acad_stream_title",{
                  "v1":monsterName,
                  "v2":ACADEMY._upgrades[_monsterID].level
               }),KEYS.Get("acad_stream_description"),CREATURELOCKER._creatures[_monsterID].stream[2],0]);
               POPUPS.Next();
            };
            monsterName = CREATURELOCKER._creatures[_monsterID].name;
            popupMC = new popup_monster();
            popupMC.tText.htmlText = KEYS.Get("acad_pop_complete",{"v1":monsterName});
            popupMC.bAction.SetupKey("btn_warnyourfriends");
            popupMC.bAction.addEventListener(MouseEvent.CLICK,Post);
            popupMC.bAction.Highlight = true;
            popupMC.bSpeedup.visible = false;
            POPUPS.Push(popupMC,null,null,null,"" + _monsterID + "-150.png");
         }
         BASE.Purchase("ITR",_instantUpgradeCost,"academy");
      }
      
      public function CancelMonsterUpgrade(param1:MouseEvent) : *
      {
         GLOBAL.Message(KEYS.Get("acad_confirmcancel",{"v1":CREATURELOCKER._creatures[_monsterID].name}),KEYS.Get("acad_confirmcancel_btn"),this.CancelMonsterUpgradeB);
      }
      
      public function CancelMonsterUpgradeB() : *
      {
         ACADEMY.CancelMonsterUpgrade(_monsterID);
         this.Setup(_monsterID);
      }
      
      public function SpeedUp(param1:MouseEvent) : *
      {
         ACADEMY._monsterID = _monsterID;
         STORE.SpeedUp("SP4");
      }
      
      public function Previous(param1:MouseEvent) : *
      {
         --_page;
         if(_page == 0)
         {
            _page = 15;
         }
         this.Setup("C" + _page);
      }
      
      public function Next(param1:MouseEvent) : *
      {
         ++_page;
         if(_page == 16)
         {
            _page = 1;
         }
         this.Setup("C" + _page);
      }
      
      public function Help(param1:MouseEvent = null) : void
      {
         this._guidePage += 1;
         if(this._guidePage > 5)
         {
            this._guidePage = 1;
         }
         this.gotoAndStop(this._guidePage);
         if(this._guidePage > 1)
         {
            this.txtGuide.htmlText = KEYS.Get("acad_tut_" + (this._guidePage - 1));
            if(this._guidePage == 2)
            {
               this.bContinue.addEventListener(MouseEvent.CLICK,this.Help);
               this.bContinue.SetupKey("btn_continue");
            }
         }
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         ACADEMY.Hide(param1);
      }
      
      public function Center() : void
      {
         POPUPSETTINGS.AlignToCenter(this);
      }
      
      public function ScaleUp() : void
      {
         POPUPSETTINGS.ScaleUp(this);
      }
   }
}

