package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import gs.*;
   import gs.easing.*;
   
   public class CHAMPIONCAGEPOPUP extends GUARDIANCAGEPOPUP_CLIP
   {
      public static var page1Assets:Array;
      
      public static var page2Assets:Array;
      
      public static var pagesArr:Array;
      
      public static var statsArr:Array;
      
      public static var buffsArr:Array;
      
      public static var feedIcons:Array;
      
      private static var statsStringsArr:Array;
      
      private static var buffsStringsArr:Array;
      
      public static var _bCage:CHAMPIONCAGE;
      
      public static var _page:int = 0;
      
      public static var _maxSpeed:Number = 4;
      
      public static var _maxHealth:Number = 250000;
      
      public static var _maxDamage:Number = 160 * 60;
      
      public static var _maxBuff:Number = 100;
      
      public static var _maxLevel:Number = 6;
      
      public static var _isFeed:Boolean = false;
      
      public static var _useBonusIndicators:Boolean = false;
      
      private var guard:CHAMPIONMONSTER;
      
      private var guardType:int;
      
      private var guardLevel:int;
      
      private var foodBonus:int;
      
      private var guardID:String;
      
      private var totalFeeds:Number;
      
      private var currFeeds:Number;
      
      public function CHAMPIONCAGEPOPUP()
      {
         super();
         tTitle.htmlText = KEYS.Get("gcage_title");
         _bCage = GLOBAL._bCage as CHAMPIONCAGE;
         page1Assets = [mcImage,tEvoStage,damage_txt,tDamage,bDamage,health_txt,tHealth,bHealth,speed_txt,tSpeed,bSpeed,buff_txt,tBuff,bBuff,tEvoDesc,tHP,barHP,bHeal];
         page2Assets = [barDNA,barDNA_bg,barDNA_mask,mcCurrGuardian,mcNextGuardian,tNextFeed,tFeedsFrom,mcInstant,mcFeed1,mcFeed2,gFeedBG,bEvolve,bFeedTimer,tNextFeedTitle];
         pagesArr = [page1Assets,page2Assets];
         statsArr = [damage_txt,tDamage,bDamage,health_txt,tHealth,bHealth,speed_txt,tSpeed,bSpeed,buff_txt,tBuff,bBuff];
         buffsArr = [damage_txt2,tDamage2,bDamage2,health_txt2,tHealth2,bHealth2,speed_txt2,tSpeed2,bSpeed2,buff_txt2,tBuff2,bBuff2,tBuffDesc,day1,day2,day3];
         feedIcons = [mcFeed1,mcFeed2];
         this.Setup(0);
         mcCurrGuardian.stop();
         mcNextGuardian.stop();
      }
      
      public static function FeedClick(param1:MouseEvent) : *
      {
         _bCage.FeedGuardian(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),false);
         CHAMPIONCAGE.Hide(param1);
      }
      
      public function Setup(param1:int = 0) : *
      {
         if(GLOBAL._mode == "build")
         {
            if(GLOBAL._bCage)
            {
               this.UpdateVars();
               b1.SetupKey("btn_champion",false,0,0);
               b1.addEventListener(MouseEvent.CLICK,this.SwitchClick(0));
               b2.SetupKey("btn_evolution",false,0,0);
               if(this.guardLevel == 6)
               {
                  b2.SetupKey("btn_dailyfeed",false,0,0);
               }
               b2.addEventListener(MouseEvent.CLICK,this.SwitchClick(1));
               tEvoStage.mouseEnabled = false;
               tTitle.mouseEnabled = false;
               this.Switch(param1);
            }
            else
            {
               GLOBAL.Message(KEYS.Get("cage_notbuilt"));
            }
         }
      }
      
      public function UpdateVars() : void
      {
         if(CREATURES._guardian)
         {
            this.guard = CREATURES._guardian;
            this.guardType = CREATURES._guardian._type;
            this.guardLevel = CREATURES._guardian._level.Get();
            this.foodBonus = CREATURES._guardian._foodBonus.Get();
            this.guardID = CREATURES._guardian._creatureID;
            this.totalFeeds = CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"feedCount");
            this.currFeeds = CREATURES._guardian._feeds.Get();
         }
      }
      
      public function Switch(param1:int = 0) : *
      {
         var _loc2_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         this.UpdateVars();
         mcInstant.bAction.removeEventListener(MouseEvent.CLICK,this.InstantClick);
         mcInstant.bAction.removeEventListener(MouseEvent.CLICK,this.EvolveClick);
         bEvolve.removeEventListener(MouseEvent.CLICK,FeedClick);
         bHeal.removeEventListener(MouseEvent.CLICK,this.HealClick);
         _loc2_ = 0;
         while(_loc2_ < pagesArr.length)
         {
            if(_loc2_ == param1)
            {
               _loc4_ = 0;
               while(_loc4_ < pagesArr[_loc2_].length)
               {
                  pagesArr[_loc2_][_loc4_].visible = true;
                  if(pagesArr[_loc2_][_loc4_] is MovieClip)
                  {
                     pagesArr[_loc2_][_loc4_].enabled = true;
                  }
                  _loc4_++;
               }
               _page = param1;
               window.gotoAndStop(param1 + 1);
            }
            else
            {
               _loc5_ = 0;
               while(_loc5_ < pagesArr[_loc2_].length)
               {
                  pagesArr[_loc2_][_loc5_].visible = false;
                  if(pagesArr[_loc2_][_loc4_] is MovieClip)
                  {
                     pagesArr[_loc2_][_loc5_].enabled = false;
                  }
                  _loc5_++;
               }
            }
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < buffsArr.length)
         {
            buffsArr[_loc3_].visible = false;
            if(buffsArr[_loc3_] is MovieClip)
            {
               buffsArr[_loc3_].enabled = true;
            }
            _loc3_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            bDamage["mcBuff" + _loc2_].width = 0;
            bHealth["mcBuff" + _loc2_].width = 0;
            bSpeed["mcBuff" + _loc2_].width = 0;
            bBuff["mcBuff" + _loc2_].width = 0;
            bDamage2["mcBuff" + _loc2_].width = 0;
            bHealth2["mcBuff" + _loc2_].width = 0;
            bSpeed2["mcBuff" + _loc2_].width = 0;
            bBuff2["mcBuff" + _loc2_].width = 0;
            _loc2_++;
         }
         if(CREATURES._guardian)
         {
            if(param1 == 0)
            {
               this.UpdatePortrait();
               this.UpdateStats();
               bHeal.SetupKey("btn_healchampion",false,0,0);
               if(CREATURES._guardian._health.Get() >= CREATURES._guardian._maxHealth)
               {
                  bHeal.Enabled = false;
                  bHeal.removeEventListener(MouseEvent.CLICK,this.HealClick);
               }
               else
               {
                  bHeal.Enabled = true;
                  bHeal.addEventListener(MouseEvent.CLICK,this.HealClick);
               }
               b1.Highlight = true;
               b2.Highlight = false;
               window.gotoAndStop(param1 + 1);
            }
            else if(param1 == 1)
            {
               b1.Highlight = false;
               b2.Highlight = true;
               window.gotoAndStop(param1 + 1);
               this.UpdateDNA();
               this.UpdateStats();
               _loc6_ = CREATURES._guardian._feedTime.Get() < GLOBAL.Timestamp();
               if(CREATURES._guardian._level.Get() < 6)
               {
                  tNextFeedTitle.x = -85;
                  tNextFeedTitle.width = 170;
                  tNextFeed.x = -80;
                  tNextFeed.width = 160;
                  bFeedTimer.x = -85;
                  bFeedTimer.width = 170;
                  if(_loc6_)
                  {
                     mcInstant.visible = true;
                     mcInstant.enabled = true;
                     mcInstant.tDescription.htmlText = "<b>" + KEYS.Get("gcage_instantFeed") + "</b>";
                     mcInstant.bAction.Highlight = false;
                     _loc7_ = CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedShiny");
                     mcInstant.bAction.Setup(KEYS.Get("btn_useshiny",{"v1":_loc7_}),false,0,0);
                     mcInstant.bAction.addEventListener(MouseEvent.CLICK,this.InstantClick);
                     bEvolve.SetupKey("btn_feednow",false,0,0);
                     bEvolve.visible = true;
                     bEvolve.Enabled = true;
                     bEvolve.Highlight = false;
                     bEvolve.removeEventListener(MouseEvent.CLICK,this.CantFeedClick);
                     bEvolve.addEventListener(MouseEvent.CLICK,FeedClick);
                  }
                  else
                  {
                     mcInstant.visible = true;
                     mcInstant.enabled = true;
                     mcInstant.tDescription.htmlText = "<b>" + KEYS.Get("gcage_instantEvolve") + "</b>";
                     mcInstant.bAction.Highlight = false;
                     mcInstant.bAction.Enabled = true;
                     _loc8_ = CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedShiny");
                     _loc8_ = _loc8_ * 2;
                     _loc8_ = _loc8_ * (CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedCount") - CREATURES._guardian._feeds.Get());
                     mcInstant.bAction.Setup(KEYS.Get("btn_useshiny",{"v1":_loc8_}),false,0,0);
                     mcInstant.bAction.removeEventListener(MouseEvent.CLICK,this.InstantClick);
                     mcInstant.bAction.addEventListener(MouseEvent.CLICK,this.EvolveClick);
                     bEvolve.SetupKey("btn_feednow",false,0,0);
                     bEvolve.visible = true;
                     bEvolve.Enabled = false;
                     bEvolve.Highlight = false;
                     bEvolve.removeEventListener(MouseEvent.CLICK,FeedClick);
                     bEvolve.addEventListener(MouseEvent.CLICK,this.CantFeedClick);
                  }
               }
               else if(this.guardLevel == _maxLevel)
               {
                  _loc4_ = 0;
                  while(_loc4_ < buffsArr.length)
                  {
                     buffsArr[_loc4_].visible = true;
                     if(buffsArr[_loc4_] is MovieClip)
                     {
                        buffsArr[_loc4_].enabled = true;
                     }
                     _loc4_++;
                  }
                  this.tFeedsFrom.visible = false;
                  this.tFeedsFrom.htmlText = "<b>" + KEYS.Get("gcage_fullyEvolved") + "</b>";
                  tNextFeedTitle.x = -75;
                  tNextFeedTitle.width = 315;
                  tNextFeed.x = -70;
                  tNextFeed.width = 305;
                  bFeedTimer.x = -75;
                  bFeedTimer.width = 315;
                  tBuffDesc.htmlText = KEYS.Get("gcage_feedBuffDesc");
                  if(_loc6_)
                  {
                     mcInstant.visible = true;
                     mcInstant.enabled = true;
                     mcInstant.tDescription.htmlText = "<b>" + KEYS.Get("gcage_instantBuff") + "</b>";
                     mcInstant.bAction.Highlight = false;
                     mcInstant.bAction.Enabled = true;
                     _loc7_ = CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._foodBonus.Get() + 1,"bonusFeedShiny");
                     mcInstant.bAction.Setup(KEYS.Get("btn_useshiny",{"v1":_loc7_}),false,0,0);
                     mcInstant.bAction.addEventListener(MouseEvent.CLICK,this.InstantClick);
                     bEvolve.SetupKey("btn_feednow",false,0,0);
                     bEvolve.visible = true;
                     bEvolve.Enabled = true;
                     bEvolve.Highlight = false;
                     bEvolve.addEventListener(MouseEvent.CLICK,FeedClick);
                  }
                  else
                  {
                     mcInstant.visible = true;
                     mcInstant.enabled = true;
                     mcInstant.tDescription.htmlText = "<b>" + KEYS.Get("gcage_instantBuffAdd") + "</b>";
                     mcInstant.bAction.Highlight = false;
                     mcInstant.bAction.Enabled = true;
                     _loc8_ = CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._foodBonus.Get() + 1,"bonusFeedShiny");
                     _loc8_ = _loc8_ * 2;
                     mcInstant.bAction.Setup(KEYS.Get("btn_useshiny",{"v1":_loc8_}),false,0,0);
                     mcInstant.bAction.removeEventListener(MouseEvent.CLICK,this.InstantClick);
                     if(CREATURES._guardian._foodBonus.Get() >= 3)
                     {
                        mcInstant.bAction.Enabled = false;
                        mcInstant.bAction.addEventListener(MouseEvent.CLICK,this.CantInstantClick);
                     }
                     else
                     {
                        mcInstant.bAction.addEventListener(MouseEvent.CLICK,this.InstantClick);
                     }
                     bEvolve.SetupKey("btn_feednow",false,0,0);
                     bEvolve.visible = true;
                     bEvolve.Enabled = false;
                     bEvolve.Highlight = false;
                     bEvolve.removeEventListener(MouseEvent.CLICK,FeedClick);
                     bEvolve.addEventListener(MouseEvent.CLICK,this.CantFeedClick);
                  }
                  mcNextGuardian.visible = false;
                  this.barDNA.visible = false;
                  this.barDNA_bg.visible = false;
               }
               else
               {
                  bEvolve.visible = false;
                  mcInstant.visible = false;
                  mcFeed1.visible = false;
                  mcFeed2.visible = false;
                  mcNextGuardian.visible = false;
                  this.tNextFeed.visible = false;
                  this.barDNA.visible = false;
                  this.barDNA_bg.visible = false;
                  this.tFeedsFrom.htmlText = "<b>" + KEYS.Get("gcage_fullyEvolved") + "</b>";
               }
            }
         }
      }
      
      private function UpdatePortrait() : *
      {
         var UpdatePortraitIcon:Function;
         if(CREATURES._guardian)
         {
            UpdatePortraitIcon = function(param1:String, param2:BitmapData):*
            {
               mcImage.addChild(new Bitmap(param2));
            };
            if(mcImage)
            {
               while(mcImage.numChildren)
               {
                  mcImage.removeChildAt(0);
               }
            }
            ImageCache.GetImageWithCallBack("monsters/G" + CREATURES._guardian._type + "_L" + CREATURES._guardian._level.Get() + "-250.png",UpdatePortraitIcon);
         }
      }
      
      private function FeedIconLoaded(param1:String, param2:BitmapData) : *
      {
         feedIcons[0].mcImage.addChild(new Bitmap(param2));
         feedIcons[0].mcImage.width = 30;
         feedIcons[0].mcImage.height = 27;
      }
      
      private function FeedIconLoaded2(param1:String, param2:BitmapData) : *
      {
         feedIcons[1].mcImage.addChild(new Bitmap(param2));
         feedIcons[1].mcImage.width = 30;
         feedIcons[1].mcImage.height = 27;
      }
      
      private function UpdateDNA() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         if(CREATURES._guardian)
         {
            if(mcCurrGuardian.numChildren == 0)
            {
               ImageCache.loadImageAndAddChild("monsters/G" + CREATURES._guardian._type + "_L" + CREATURES._guardian._level.Get() + "-150.png",mcCurrGuardian);
               ImageCache.loadImageAndAddChild("monsters/G" + CREATURES._guardian._type + "_L" + (CREATURES._guardian._level.Get() + 1) + "-150G.png",mcNextGuardian);
            }
            _loc2_ = -517;
            _loc3_ = 222;
            _loc4_ = this.currFeeds / this.totalFeeds;
            barDNA_mask.x = _loc2_ + _loc4_ * _loc3_;
            _loc5_ = CREATURES._guardian._feedTime.Get();
            if(_loc5_ < GLOBAL.Timestamp())
            {
               tNextFeedTitle.htmlText = "<b>" + KEYS.Get("gcage_hungry") + "</b>";
               tNextFeed.htmlText = GLOBAL.ToTime(_loc5_ + CHAMPIONCAGE.STARVETIMER - GLOBAL.Timestamp());
            }
            else
            {
               tNextFeedTitle.htmlText = "<b>" + KEYS.Get("gcage_nextFeedIn") + "</b>";
               tNextFeed.htmlText = GLOBAL.ToTime(CREATURES._guardian._feedTime.Get() - GLOBAL.Timestamp());
            }
            tFeedsFrom.htmlText = Math.max(0,this.totalFeeds - this.currFeeds) + KEYS.Get("gcage_feedsFromEvo");
            feedIcons[0].visible = false;
            feedIcons[1].visible = false;
            _loc6_ = CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"feeds");
            _loc7_ = 1;
            for(_loc8_ in _loc6_)
            {
               _loc9_ = int(_loc6_[_loc8_]);
               _loc10_ = KEYS.Get(CREATURELOCKER.getShortCreatureName(_loc8_));
               _loc11_ = "monsters/" + _loc8_ + "-small.png";
               if(HOUSING._creatures[_loc8_] == null || HOUSING._creatures[_loc8_] && HOUSING._creatures[_loc8_].Get() < _loc9_)
               {
                  feedIcons[_loc7_ - 1].tName.htmlText = "<font color=\"#ff0000\"><b>" + _loc9_ + " " + _loc10_ + "</b></font>";
               }
               else
               {
                  feedIcons[_loc7_ - 1].tName.htmlText = "<font color=\"#000000\"><b>" + _loc9_ + " " + _loc10_ + "</b></font>";
               }
               if(_loc7_ == 1)
               {
                  ImageCache.GetImageWithCallBack(_loc11_,this.FeedIconLoaded);
               }
               else if(_loc7_ == 2)
               {
                  ImageCache.GetImageWithCallBack(_loc11_,this.FeedIconLoaded2);
               }
               feedIcons[_loc7_ - 1].visible = true;
               _loc7_++;
               if(_loc7_ >= 3)
               {
                  break;
               }
            }
         }
      }
      
      private function UpdateStats() : *
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:Number = NaN;
         this.UpdateVars();
         if(CREATURES._guardian)
         {
            tEvoStage.htmlText = "<b>" + KEYS.Get("gcage_evo") + "</b>" + " Stage " + CREATURES._guardian._level.Get();
            damage_txt.htmlText = "<b>" + KEYS.Get("gcage_labelDamage") + "</b>";
            health_txt.htmlText = "<b>" + KEYS.Get("gcage_labelHealth") + "</b>";
            speed_txt.htmlText = "<b>" + KEYS.Get("gcage_labelSpeed") + "</b>";
            buff_txt.htmlText = "<b>" + KEYS.Get("gcage_labelBuff") + "</b>";
            damage_txt2.htmlText = "<b>" + KEYS.Get("gcage_labelDamage") + "</b>";
            health_txt2.htmlText = "<b>" + KEYS.Get("gcage_labelHealth") + "</b>";
            speed_txt2.htmlText = "<b>" + KEYS.Get("gcage_labelSpeed") + "</b>";
            buff_txt2.htmlText = "<b>" + KEYS.Get("gcage_labelBuff") + "</b>";
            tEvoDesc.htmlText = KEYS.Get(CHAMPIONCAGE._guardians["G" + CREATURES._guardian._type].description);
            if(Boolean(CHAMPIONCAGE._guardians["G" + CREATURES._guardian._type].powerLevel2Desc) && CREATURES._guardian._powerLevel.Get() > 1)
            {
               tEvoDesc.htmlText += "<br/><b>" + KEYS.Get("mon_specialability") + "</b>" + "<br/>* " + KEYS.Get(CHAMPIONCAGE._guardians["G" + CREATURES._guardian._type].powerLevel2Desc);
               if(Boolean(KEYS.Get(CHAMPIONCAGE._guardians["G" + CREATURES._guardian._type].powerLevel3Desc)) && CREATURES._guardian._powerLevel.Get() > 2)
               {
                  tEvoDesc.htmlText += "* " + KEYS.Get(CHAMPIONCAGE._guardians["G" + CREATURES._guardian._type].powerLevel3Desc);
               }
            }
            _loc1_ = CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"damage");
            _loc2_ = CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"health");
            _loc3_ = CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"speed");
            _loc4_ = CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"buffs") * 100;
            if(this.foodBonus > 0)
            {
               _loc1_ += CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.foodBonus,"bonusDamage");
               _loc2_ += CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.foodBonus,"bonusHealth");
               _loc3_ += CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.foodBonus,"bonusSpeed");
               _loc4_ += CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.foodBonus,"bonusBuffs") * 100;
            }
            _loc5_ = CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"damage");
            _loc6_ = CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"health");
            _loc7_ = CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"speed");
            _loc8_ = CHAMPIONCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"buffs") * 100;
            _loc9_ = int(_loc3_ * 10) / 10;
            tDamage.htmlText = "" + _loc1_;
            tHealth.htmlText = "" + _loc2_;
            tSpeed.htmlText = "" + _loc9_;
            tBuff.htmlText = "" + int(_loc4_) + "%";
            tHP.htmlText = Math.floor(this.guard._health.Get()) + " / " + Math.floor(this.guard._maxHealth);
            TweenLite.to(bDamage.mcBar,0.4,{
               "width":100 / _maxDamage * _loc1_,
               "ease":Circ.easeInOut,
               "delay":0
            });
            if(this.guardLevel == _maxLevel && _useBonusIndicators)
            {
               _loc10_ = this.foodBonus;
               while(_loc10_ <= 3)
               {
                  if(_loc10_ > 0)
                  {
                     (bDamage["mcBuff" + _loc10_] as MovieClip).gotoAndStop(_loc10_ + 1);
                     TweenLite.to(bDamage["mcBuff" + _loc10_],0,{
                        "width":100 / _maxDamage * (_loc5_ + CHAMPIONCAGE.GetGuardianProperty(this.guardID,_loc10_,"bonusDamage")) + 2,
                        "ease":Circ.easeInOut,
                        "delay":0
                     });
                  }
                  _loc10_++;
               }
            }
            TweenLite.to(bHealth.mcBar,0.4,{
               "width":100 / _maxHealth * _loc2_,
               "ease":Circ.easeInOut,
               "delay":0.05
            });
            if(this.guardLevel == _maxLevel && _useBonusIndicators)
            {
               _loc10_ = this.foodBonus;
               while(_loc10_ <= 3)
               {
                  if(_loc10_ > 0)
                  {
                     TweenLite.to(bHealth["mcBuff" + _loc10_],0,{
                        "width":100 / _maxHealth * (_loc6_ + CHAMPIONCAGE.GetGuardianProperty(this.guardID,_loc10_,"bonusHealth")) + 2,
                        "ease":Circ.easeInOut,
                        "delay":0
                     });
                     bHealth["mcBuff" + _loc10_].gotoAndStop(1 + _loc10_);
                  }
                  _loc10_++;
               }
            }
            TweenLite.to(bSpeed.mcBar,0.4,{
               "width":100 / _maxSpeed * _loc3_,
               "ease":Circ.easeInOut,
               "delay":0.1
            });
            if(this.guardLevel == _maxLevel && _useBonusIndicators)
            {
               _loc10_ = this.foodBonus;
               while(_loc10_ <= 3)
               {
                  if(_loc10_ > 0)
                  {
                     TweenLite.to(bSpeed["mcBuff" + _loc10_],0,{
                        "width":100 / _maxSpeed * (_loc7_ + CHAMPIONCAGE.GetGuardianProperty(this.guardID,_loc10_,"bonusSpeed")) + 2,
                        "ease":Circ.easeInOut,
                        "delay":0
                     });
                     bSpeed["mcBuff" + _loc10_].gotoAndStop(1 + _loc10_);
                  }
                  _loc10_++;
               }
            }
            TweenLite.to(bBuff.mcBar,0.4,{
               "width":100 / _maxBuff * _loc4_,
               "ease":Circ.easeInOut,
               "delay":0.15
            });
            if(this.guardLevel == _maxLevel && _useBonusIndicators)
            {
               _loc10_ = this.foodBonus;
               while(_loc10_ <= 3)
               {
                  if(_loc10_ > 0)
                  {
                     TweenLite.to(bBuff["mcBuff" + _loc10_],0,{
                        "width":100 / _maxBuff * (_loc8_ + CHAMPIONCAGE.GetGuardianProperty(this.guardID,_loc10_,"bonusBuffs")) + 2,
                        "ease":Circ.easeInOut,
                        "delay":0
                     });
                     bBuff["mcBuff" + _loc10_].gotoAndStop(1 + _loc10_);
                  }
                  _loc10_++;
               }
            }
            if(this.guardLevel == _maxLevel)
            {
               day1.tDay.htmlText = KEYS.Get("gcage_day") + " 1";
               day1.bonusDamage.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusDamage") ? "+" + GLOBAL.FormatNumber(Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusDamage")])) + "" : "";
               day1.bonusHealth.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusHealth") ? "+" + GLOBAL.FormatNumber(Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusHealth")])) + "" : "";
               day1.bonusSpeed.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusSpeed") ? "+" + Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusSpeed")]) + "" : "";
               day1.bonusBuff.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusBuffs") ? "+" + Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusBuffs")]) * 100 + "%" + "" : "";
               day2.tDay.htmlText = KEYS.Get("gcage_day") + " 2";
               day2.bonusDamage.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusDamage") ? "+" + GLOBAL.FormatNumber(Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusDamage") - CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusDamage")])) + "" : "";
               day2.bonusHealth.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusHealth") ? "+" + GLOBAL.FormatNumber(Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusHealth") - CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusHealth")])) + "" : "";
               day2.bonusSpeed.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusSpeed") ? "+" + Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusSpeed") - CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusSpeed")]) + "" : "";
               day2.bonusBuff.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusBuffs") ? "+" + Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusBuffs") - CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,1,"bonusBuffs")]) * 100 + "%" + "" : "";
               day3.tDay.htmlText = KEYS.Get("gcage_day") + " 3";
               day3.bonusDamage.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,3,"bonusDamage") ? "+" + GLOBAL.FormatNumber(Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,3,"bonusDamage") - CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusDamage")])) + "" : "";
               day3.bonusHealth.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,3,"bonusHealth") ? "+" + GLOBAL.FormatNumber(Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,3,"bonusHealth") - CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusHealth")])) + "" : "";
               day3.bonusSpeed.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,3,"bonusSpeed") ? "+" + Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,3,"bonusSpeed") - CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusSpeed")]) + "" : "";
               day3.bonusBuff.htmlText = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,3,"bonusBuffs") ? "+" + Number([CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,3,"bonusBuffs") - CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,2,"bonusBuffs")]) * 100 + "%" + "" : "";
               _loc11_ = 1;
               while(_loc11_ <= 3)
               {
                  if(_loc11_ < this.foodBonus + 1)
                  {
                     this["day" + _loc11_].alpha = 1;
                     this["day" + _loc11_].mcDivider.alpha = 0;
                     if(_loc11_ <= this.foodBonus)
                     {
                        this["day" + _loc11_].bonusDamage.htmlText = "";
                        this["day" + _loc11_].bonusHealth.htmlText = "";
                        this["day" + _loc11_].bonusSpeed.htmlText = "";
                        this["day" + _loc11_].bonusBuff.htmlText = "";
                     }
                  }
                  else if(_loc11_ == this.foodBonus + 1)
                  {
                     this["day" + _loc11_].alpha = 1;
                     this["day" + _loc11_].mcDivider.alpha = 0.8;
                     this["day" + _loc11_].bonusDamage.htmlText = "<b>" + this["day" + _loc11_].bonusDamage.htmlText + "</b>";
                     this["day" + _loc11_].bonusHealth.htmlText = "<b>" + this["day" + _loc11_].bonusHealth.htmlText + "</b>";
                     this["day" + _loc11_].bonusSpeed.htmlText = "<b>" + this["day" + _loc11_].bonusSpeed.htmlText + "</b>";
                     this["day" + _loc11_].bonusBuff.htmlText = "<b>" + this["day" + _loc11_].bonusBuff.htmlText + "</b>";
                  }
                  else
                  {
                     this["day" + _loc11_].alpha = 0.5;
                     this["day" + _loc11_].mcDivider.alpha = 1;
                  }
                  _loc11_++;
               }
               tDamage2.htmlText = "" + _loc1_;
               tHealth2.htmlText = "" + _loc2_;
               tSpeed2.htmlText = "" + _loc9_;
               tBuff2.htmlText = "" + int(_loc4_) + "%";
               _loc12_ = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._foodBonus.Get() + 1,"bonusDamage") ? 1 : 0;
               _loc13_ = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._foodBonus.Get() + 1,"bonusHealth") ? 1 : 0;
               _loc14_ = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._foodBonus.Get() + 1,"bonusSpeed") ? 1 : 0;
               _loc15_ = !!CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._foodBonus.Get() + 1,"bonusBuffs") ? 1 : 0;
               _loc16_ = 25.5;
               TweenLite.to(bDamage2.mcBar,0.4,{
                  "width":_loc16_ + this.foodBonus * 25,
                  "ease":Circ.easeInOut,
                  "delay":0
               });
               TweenLite.to(bHealth2.mcBar,0.4,{
                  "width":_loc16_ + this.foodBonus * 25,
                  "ease":Circ.easeInOut,
                  "delay":0.05
               });
               TweenLite.to(bSpeed2.mcBar,0.4,{
                  "width":_loc16_ + this.foodBonus * 25,
                  "ease":Circ.easeInOut,
                  "delay":0.1
               });
               TweenLite.to(bBuff2.mcBar,0.4,{
                  "width":_loc16_ * _loc15_ + this.foodBonus * 25 * _loc15_,
                  "ease":Circ.easeInOut,
                  "delay":0.15
               });
            }
            barHP.mcBar.width = 100 / this.guard._maxHealth * Math.max(1,this.guard._health.Get());
            bFeedTimer.mcBar.width = 100 / CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedTime") * (CREATURES._guardian._feedTime.Get() - GLOBAL.Timestamp());
         }
      }
      
      private function UpdateFeeds() : *
      {
      }
      
      public function Tick() : *
      {
         var _loc1_:int = CREATURES._guardian._feedTime.Get();
         if(_loc1_ < GLOBAL.Timestamp())
         {
            if(_page == 1)
            {
               this.Switch(1);
            }
            tNextFeedTitle.htmlText = "<b>" + KEYS.Get("gcage_hungry") + "</b>";
            tNextFeed.htmlText = GLOBAL.ToTime(_loc1_ + CHAMPIONCAGE.STARVETIMER - GLOBAL.Timestamp());
            bFeedTimer.mcBar.width = 0;
         }
         else
         {
            tNextFeedTitle.htmlText = "<b>" + KEYS.Get("gcage_nextFeedIn") + "</b>";
            tNextFeed.htmlText = GLOBAL.ToTime(CREATURES._guardian._feedTime.Get() - GLOBAL.Timestamp());
            bFeedTimer.mcBar.width = Math.max(100,100 / CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedTime") * (CREATURES._guardian._feedTime.Get() - GLOBAL.Timestamp()));
         }
         this.UpdateStats();
         if(CREATURES._guardian._health.Get() >= CREATURES._guardian._maxHealth)
         {
            bHeal.removeEventListener(MouseEvent.CLICK,this.HealClick);
            bHeal.Enabled = false;
         }
      }
      
      public function SwitchClick(param1:int) : *
      {
         var page:int = param1;
         return function(param1:MouseEvent = null):*
         {
            Switch(page);
         };
      }
      
      public function HealClick(param1:MouseEvent) : *
      {
         if(CREATURES._guardian._health.Get() < CREATURES._guardian._maxHealth)
         {
            CHAMPIONCAGE.HealGuardian();
            this.Switch(0);
         }
         else
         {
            this.Switch(0);
         }
      }
      
      public function EvolveClick(param1:MouseEvent) : *
      {
         var _loc2_:int = 0;
         if(CREATURES._guardian._level.Get() < 6)
         {
            _loc2_ = CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedShiny");
            _loc2_ *= 2;
            _loc2_ *= CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedCount") - CREATURES._guardian._feeds.Get();
            this.EvolveClickB();
         }
         else if(CREATURES._guardian._level.Get() == 6)
         {
            _loc2_ = CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._foodBonus.Get(),"bonusFeedShiny");
            _loc2_ *= 2;
            this.EvolveClickB();
         }
      }
      
      public function EvolveClickB() : *
      {
         var _loc1_:int = 0;
         if(CREATURES._guardian._level.Get() < 6)
         {
            _loc1_ = CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedShiny");
            _loc1_ *= 2;
            _loc1_ *= CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedCount") - CREATURES._guardian._feeds.Get();
            if(BASE._credits.Get() < _loc1_)
            {
               POPUPS.DisplayGetShiny();
               return;
            }
            CREATURES._guardian.LevelSet(CREATURES._guardian._level.Get() + 1,_loc1_);
            BASE.Purchase("IEV",_loc1_,"cage");
            CHAMPIONCAGE.Hide();
            BASE.Save();
         }
      }
      
      public function InstantClick(param1:MouseEvent) : *
      {
         if(CREATURES._guardian._level.Get() < 6)
         {
            _bCage.FeedGuardian(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),true);
            CHAMPIONCAGE.Hide(param1);
         }
         else if(CREATURES._guardian._level.Get() == 6)
         {
            _bCage.FeedGuardian(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),true);
            CHAMPIONCAGE.Hide(param1);
         }
      }
      
      public function CantFeedClick(param1:MouseEvent) : *
      {
         if(CREATURES._guardian._level.Get() <= 6 && CREATURES._guardian._foodBonus.Get() < 3)
         {
            GLOBAL.Message(KEYS.Get("gcage_msgNotHungry"));
         }
         else if(CREATURES._guardian._level.Get() == 6 && CREATURES._guardian._foodBonus.Get() >= 3)
         {
            GLOBAL.Message(KEYS.Get("gcage_msgFullBuff"));
         }
      }
      
      public function CantInstantClick(param1:MouseEvent) : *
      {
         GLOBAL.Message(KEYS.Get("gcage_msgFullBuff"));
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         CHAMPIONCAGE.Hide(param1);
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

