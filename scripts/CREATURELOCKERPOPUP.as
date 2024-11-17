package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import gs.*;
   import gs.easing.*;
   
   public class CREATURELOCKERPOPUP extends CREATURELOCKERPOPUP_CLIP
   {
      public var _mcList:*;
      
      public var _mcCreep:*;
      
      public var _tempCreatureList:Array;
      
      public var _creatureID:String;
      
      public var _portraitImage:DisplayObject;
      
      public var _instantUnlockCost:int;
      
      private var _guidePage:int = 1;
      
      public function CREATURELOCKERPOPUP()
      {
         super();
         bPrevious.SetupKey("btn_previous");
         bPrevious.addEventListener(MouseEvent.CLICK,this.PagePrevious);
         bNext.SetupKey("btn_next");
         bNext.addEventListener(MouseEvent.CLICK,this.PageNext);
         bInstant.addEventListener(MouseEvent.CLICK,this.InstantUnlock);
         this.List();
         if(CREATURELOCKER._unlocking != null)
         {
            CREATURELOCKER._page = CREATURELOCKER._creatures[CREATURELOCKER._unlocking].page;
            this.ShowB(CREATURELOCKER._unlocking);
         }
         else
         {
            CREATURELOCKER._page = CREATURELOCKER._creatures[CREATURELOCKER._popupCreatureID].page;
            this.ShowB(CREATURELOCKER._popupCreatureID);
         }
         title_txt.text = KEYS.Get("cloc_title");
         prod_label_txt.htmlText = KEYS.Get("cloc_prodstats_label");
         speed_txt.htmlText = "<b>" + KEYS.Get("mon_att_speed") + "</b>";
         health_txt.htmlText = "<b>" + KEYS.Get("mon_att_health") + "</b>";
         damage_txt.htmlText = "<b>" + KEYS.Get("mon_att_damage") + "</b>";
         goo_txt.htmlText = "<b>" + KEYS.Get("mon_att_cost") + "</b>";
         housing_txt.htmlText = "<b>" + KEYS.Get("mon_att_housing") + "</b>";
         time_txt.htmlText = "<b>" + KEYS.Get("mon_att_time") + "</b>";
      }
      
      public function PagePrevious(param1:MouseEvent) : *
      {
         if(CREATURELOCKER._page > 1)
         {
            --CREATURELOCKER._page;
         }
         this.List();
      }
      
      public function PageNext(param1:MouseEvent) : *
      {
         if(CREATURELOCKER._page < 4)
         {
            ++CREATURELOCKER._page;
         }
         this.List();
      }
      
      public function List() : *
      {
         var _loc1_:String = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(CREATURELOCKER._page > 1)
         {
            bPrevious.enabled = true;
         }
         else
         {
            bPrevious.enabled = false;
         }
         if(CREATURELOCKER._page < 4)
         {
            bNext.enabled = true;
         }
         else
         {
            bNext.enabled = false;
         }
         this._tempCreatureList = [];
         for(_loc1_ in CREATURELOCKER._creatures)
         {
            _loc4_ = CREATURELOCKER._creatures[_loc1_];
            if(!_loc4_.blocked && _loc4_.page == CREATURELOCKER._page)
            {
               _loc4_.id = _loc1_;
               this._tempCreatureList.push(_loc4_);
            }
         }
         this._tempCreatureList.sortOn(["order"],Array.NUMERIC);
         if(this._mcList)
         {
            mcList.removeChild(this._mcList);
         }
         this._mcList = mcList.addChild(new MovieClip());
         this._mcList.x = 10;
         this._mcList.y = 10;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._tempCreatureList.length)
         {
            _loc4_ = this._tempCreatureList[_loc3_];
            _loc1_ = _loc4_.id;
            _loc5_ = CREATURELOCKER._lockerData[_loc1_];
            _loc6_ = this._mcList.addChild(new CreatureLockerItem());
            _loc6_.y = _loc2_;
            _loc2_ += 40;
            _loc7_ = "<b>" + KEYS.Get(_loc4_.name) + "</b>";
            if(_loc5_)
            {
               if(_loc5_.t == 1)
               {
                  _loc7_ += "<br>" + GLOBAL.ToTime(_loc5_.e - GLOBAL.Timestamp());
               }
               else
               {
                  _loc7_ += "<br><font color=\"#333333\">" + KEYS.Get("mon_unlocked") + "</font>";
               }
            }
            else
            {
               _loc7_ += "<br><font color=\"#CC0000\">" + KEYS.Get("mon_locked") + "</font>";
            }
            _loc6_.tLabel.htmlText = _loc7_;
            _loc6_.addEventListener(MouseEvent.MOUSE_DOWN,this.Show(_loc1_));
            _loc6_.buttonMode = true;
            _loc6_.mouseChildren = false;
            _loc6_.mouseEnabled = true;
            if(CREATURELOCKER._unlocking == _loc1_)
            {
               _loc6_.gotoAndStop(2);
            }
            else
            {
               _loc6_.gotoAndStop(1);
            }
            _loc6_.mcTick.visible = false;
            if(_loc5_)
            {
               if(_loc5_.t == 1)
               {
                  _loc6_.mcBar.width = 156 / (_loc5_.e - _loc5_.s) * (GLOBAL.Timestamp() - _loc5_.s);
               }
               else if(_loc5_.t == 2)
               {
                  _loc6_.mcTick.visible = true;
                  _loc6_.mcBar.visible = false;
               }
            }
            else
            {
               _loc6_.mcBar.width = 0;
            }
            _loc3_++;
         }
      }
      
      public function Show(param1:String) : *
      {
         var creatureID:String = param1;
         return function(param1:MouseEvent = null):*
         {
            ShowB(creatureID);
         };
      }
      
      public function ShowB(param1:String) : *
      {
         var data:Object;
         var str:String;
         var maxSpeed:int;
         var maxHealth:int;
         var maxDamage:int;
         var maxTime:int;
         var maxResource:int;
         var maxStorage:int;
         var c:String = null;
         var dam:int = 0;
         var UpdatePortrait:Function = null;
         var putty:int = 0;
         var time:int = 0;
         var timeCost:int = 0;
         var resourcesCost:int = 0;
         var creatureID:String = param1;
         UpdatePortrait = function(param1:String, param2:BitmapData):*
         {
            _portraitImage = mcImage.addChild(new Bitmap(param2));
         };
         this._creatureID = creatureID;
         if(!creatureID)
         {
            this._creatureID = "C1";
         }
         CREATURELOCKER._popupCreatureID = this._creatureID;
         this.List();
         data = CREATURELOCKER._creatures[this._creatureID];
         tDescription.htmlText = "<b>" + KEYS.Get(data.name) + "</b><br>" + KEYS.Get(data.description);
         str = "";
         if(CREATURELOCKER._unlocking != null)
         {
            str = KEYS.Get("mon_infounlocking");
         }
         else if(Boolean(CREATURELOCKER._lockerData[this._creatureID]) && CREATURELOCKER._lockerData[this._creatureID].t == 2)
         {
            str = KEYS.Get("mon_infounlocked");
         }
         else
         {
            str = KEYS.Get("mon_infotounlock",{"v1":GLOBAL.ToTime(data.time)});
            if(BASE._resources.r3.Get() < data.resource)
            {
               str += "<font color=\"#CC0000\">";
            }
            str += "<b>" + KEYS.Get(GLOBAL._resourceNames[2]) + "</b>: " + GLOBAL.FormatNumber(data.resource) + "<br>";
            if(BASE._resources.r3.Get() < data.resource)
            {
               str += "</font>";
            }
            if(GLOBAL._bLocker._lvl.Get() < data.level)
            {
               str += "<font color=\"#CC0000\">";
            }
            str += KEYS.Get("mon_infolockerlevelrequired",{"v1":data.level});
            if(GLOBAL._bLocker._lvl.Get() < data.level)
            {
               str += "</font>";
            }
         }
         tCosts.htmlText = str;
         maxSpeed = 0;
         maxHealth = 0;
         maxDamage = 0;
         maxTime = 0;
         maxResource = 0;
         maxStorage = 0;
         for(c in CREATURELOCKER._creatures)
         {
            if(CREATURES.GetProperty(c,"speed") > maxSpeed)
            {
               maxSpeed = CREATURES.GetProperty(c,"speed");
            }
            if(CREATURES.GetProperty(c,"health") > maxHealth)
            {
               maxHealth = CREATURES.GetProperty(c,"health");
            }
            if(CREATURES.GetProperty(c,"damage") > maxDamage)
            {
               maxDamage = CREATURES.GetProperty(c,"damage");
            }
            if(CREATURES.GetProperty(c,"cTime") > maxTime)
            {
               maxTime = CREATURES.GetProperty(c,"cTime");
            }
            if(CREATURES.GetProperty(c,"cResource") > maxResource)
            {
               maxResource = CREATURES.GetProperty(c,"cResource");
            }
            if(CREATURES.GetProperty(c,"cStorage") > maxStorage)
            {
               maxStorage = CREATURES.GetProperty(c,"cStorage");
            }
         }
         TweenLite.to(bSpeed.mcBar,0.4,{
            "width":100 / maxSpeed * CREATURES.GetProperty(this._creatureID,"speed"),
            "ease":Circ.easeInOut,
            "delay":0
         });
         TweenLite.to(bHealth.mcBar,0.4,{
            "width":100 / maxHealth * CREATURES.GetProperty(this._creatureID,"health"),
            "ease":Circ.easeInOut,
            "delay":0.05
         });
         TweenLite.to(bDamage.mcBar,0.4,{
            "width":100 / maxDamage * CREATURES.GetProperty(this._creatureID,"damage"),
            "ease":Circ.easeInOut,
            "delay":0.1
         });
         TweenLite.to(bResource.mcBar,0.4,{
            "width":100 / maxTime * CREATURES.GetProperty(this._creatureID,"cTime"),
            "ease":Circ.easeInOut,
            "delay":0.15
         });
         TweenLite.to(bStorage.mcBar,0.4,{
            "width":100 / maxResource * CREATURES.GetProperty(this._creatureID,"cResource"),
            "ease":Circ.easeInOut,
            "delay":0.2
         });
         TweenLite.to(bTime.mcBar,0.4,{
            "width":100 / maxStorage * CREATURES.GetProperty(this._creatureID,"cStorage"),
            "ease":Circ.easeInOut,
            "delay":0.25
         });
         tSpeed.text = KEYS.Get("mon_statsspeed",{"v1":CREATURES.GetProperty(this._creatureID,"speed")});
         tHealth.text = CREATURES.GetProperty(this._creatureID,"health").toString();
         dam = CREATURES.GetProperty(this._creatureID,"damage");
         if(dam > 0)
         {
            tDamage.text = dam.toString();
         }
         else
         {
            tDamage.text = -dam + " (" + KEYS.Get("str_heal") + ")";
         }
         tResource.text = CREATURES.GetProperty(this._creatureID,"cResource") + " " + KEYS.Get(GLOBAL._resourceNames[3]);
         tStorage.text = KEYS.Get("mon_statsstorage",{"v1":CREATURES.GetProperty(this._creatureID,"cStorage")});
         tTime.text = GLOBAL.ToTime(CREATURES.GetProperty(this._creatureID,"cTime"),true);
         if(CREATURELOCKER._lockerData[this._creatureID])
         {
            if(CREATURELOCKER._lockerData[this._creatureID].t == 2)
            {
               mcButtons.gotoAndStop(1);
               mcButtons.bStart.SetupKey("mon_unlocked");
               mcButtons.bStart.Enabled = false;
               mcButtons.bStart.Highlight = false;
               bInstant.visible = false;
            }
            else
            {
               mcButtons.gotoAndStop(2);
               mcButtons.bStop.SetupKey("btn_cancel");
               mcButtons.bStop.addEventListener(MouseEvent.CLICK,this.Stop);
               mcButtons.bSpeedup.SetupKey("btn_speedup");
               mcButtons.bSpeedup.addEventListener(MouseEvent.CLICK,this.Speedup);
               mcButtons.bSpeedup.Highlight = true;
               bInstant.visible = false;
            }
         }
         else
         {
            mcButtons.gotoAndStop(1);
            mcButtons.bStart.SetupKey("btn_startunlocking");
            mcButtons.bStart.Enabled = true;
            mcButtons.bStart.Highlight = true;
            mcButtons.bStart.addEventListener(MouseEvent.CLICK,this.Start);
            putty = int(CREATURELOCKER._creatures[this._creatureID].resource);
            time = int(CREATURELOCKER._creatures[this._creatureID].time);
            timeCost = STORE.GetTimeCost(time);
            resourcesCost = Math.ceil(Math.pow(Math.sqrt(putty / 2),0.75));
            this._instantUnlockCost = timeCost + resourcesCost;
            bInstant.Setup("Unlock Instantly for " + this._instantUnlockCost + " Shiny");
            bInstant.visible = true;
            bInstant.Enabled = true;
            bInstant.Highlight = true;
         }
         if(Boolean(this._portraitImage) && Boolean(this._portraitImage.parent))
         {
            this._portraitImage.parent.removeChild(this._portraitImage);
         }
         ImageCache.GetImageWithCallBack("monsters/" + this._creatureID + "-portrait.jpg",UpdatePortrait,true,1);
      }
      
      public function Start(param1:MouseEvent) : *
      {
         if(CREATURELOCKER.Start(this._creatureID))
         {
            this.Update();
         }
      }
      
      public function Stop(param1:MouseEvent) : *
      {
         GLOBAL.Message(KEYS.Get("mon_confirmcancel",{"v1":KEYS.Get(CREATURELOCKER._creatures[CREATURELOCKER._unlocking].name)}),KEYS.Get("btn_yes"),CREATURELOCKER.Cancel);
      }
      
      public function Speedup(param1:MouseEvent) : *
      {
         STORE.ShowB(3,0,["SP1","SP2","SP3","SP4"]);
      }
      
      public function Update() : *
      {
         this.ShowB(this._creatureID);
         this.Tick();
      }
      
      public function Tick() : *
      {
         this.List();
      }
      
      public function InstantUnlock(param1:MouseEvent) : *
      {
         var creature:Object;
         var img:String;
         var StreamPost:Function;
         var mc:popup_monster = null;
         var _body:String = null;
         var e:MouseEvent = param1;
         if(BASE._credits.Get() < this._instantUnlockCost)
         {
            POPUPS.DisplayGetShiny();
            return;
         }
         if(GLOBAL._bLocker._lvl.Get() < CREATURELOCKER._creatures[this._creatureID].level)
         {
            GLOBAL.Message(KEYS.Get("mon_upgradelocker",{"v1":CREATURELOCKER._creatures[this._creatureID].level}));
            return;
         }
         if(CREATURELOCKER._unlocking && CREATURELOCKER._lockerData[CREATURELOCKER._unlocking] && CREATURELOCKER._lockerData[CREATURELOCKER._unlocking] == this._creatureID)
         {
            delete CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].s;
            delete CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e;
         }
         creature = CREATURELOCKER._creatures[this._creatureID];
         img = "quests/monster" + this._creatureID.substr(1) + ".v2.png";
         if(creature.stream.length > 1)
         {
            img = creature.stream[2];
         }
         CREATURELOCKER._lockerData[this._creatureID] = {"t":2};
         ACADEMY._upgrades[this._creatureID] = {"level":1};
         GLOBAL._playerCreatureUpgrades[this._creatureID] = {"level":1};
         LOGGER.Stat([46,int(this._creatureID.substr(1))]);
         if(GLOBAL._mode == "build")
         {
            StreamPost = function(param1:String, param2:String, param3:String):*
            {
               var st:String = param1;
               var sd:String = param2;
               var im:String = param3;
               return function(param1:MouseEvent = null):*
               {
                  GLOBAL.CallJS("sendFeed",["unlock-end",st,sd,im,0]);
                  POPUPS.Next();
               };
            };
            mc = new popup_monster();
            mc.bSpeedup.SetupKey("btn_warnyourfriends");
            _body = "";
            if(creature.stream.length > 1)
            {
               _body = KEYS.Get(creature.stream[1]);
            }
            mc.bSpeedup.addEventListener(MouseEvent.CLICK,StreamPost(KEYS.Get(creature.stream[0]),_body,img));
            mc.bSpeedup.Highlight = true;
            mc.bAction.visible = false;
            mc.tText.htmlText = KEYS.Get("pop_unlock_complete",{"v1":KEYS.Get(CREATURELOCKER._creatures[this._creatureID].name)});
            POPUPS.Push(mc,null,null,null,this._creatureID + "-150.png");
         }
         CREATURELOCKER._unlocking = null;
         QUESTS.Check();
         BASE.Purchase("IUN",this._instantUnlockCost,"creaturelocker");
         this.Update();
      }
      
      public function Help(param1:MouseEvent = null) : void
      {
         this._guidePage += 1;
         if(this._guidePage > 2)
         {
            this._guidePage = 1;
         }
         this.gotoAndStop(this._guidePage);
         if(this._guidePage > 1)
         {
            this.txtGuide.htmlText = KEYS.Get("loc_tut_" + (this._guidePage - 1));
            if(this._guidePage == 2)
            {
               this.bContinue.addEventListener(MouseEvent.CLICK,this.Help);
               this.bContinue.SetupKey("btn_continue");
            }
         }
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         CREATURELOCKER.Hide(param1);
      }
   }
}
