package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import gs.*;
   import gs.easing.*;
   
   public class GUARDIANCAGEPOPUP extends GUARDIANCAGEPOPUP_CLIP
   {
      public static var page1Assets:Array;
      
      public static var page2Assets:Array;
      
      public static var pagesArr:Array;
      
      public static var feedIcons:Array;
      
      public static var _bCage:GUARDIANCAGE;
      
      public static var _page:int = 0;
      
      public static var _maxSpeed:Number = 3.6;
      
      public static var _maxHealth:Number = 200000;
      
      public static var _maxDamage:Number = 0x1f40;
      
      public static var _maxBuff:Number = 60;
      
      public static var _maxLevel:Number = 6;
      
      public static var _isFeed:Boolean = false;
      
      private var guard:GUARDIANMONSTER;
      
      private var guardType:int;
      
      private var guardLevel:int;
      
      private var guardID:String;
      
      private var totalFeeds:Number;
      
      private var currFeeds:Number;
      
      public function GUARDIANCAGEPOPUP()
      {
         super();
         _bCage = GLOBAL._bCage as GUARDIANCAGE;
         page1Assets = [mcImage,tEvoStage,damage_txt,tDamage,bDamage,health_txt,tHealth,bHealth,speed_txt,tSpeed,bSpeed,buff_txt,tBuff,bBuff,tEvoDesc,tHP,barHP,bHeal];
         page2Assets = [barDNA,barDNA_bg,barDNA_mask,mcCurrGuardian,mcNextGuardian,tNextFeed,tFeedsFrom,mcInstant,mcFeed1,mcFeed2,gFeedBG,bEvolve];
         pagesArr = [page1Assets,page2Assets];
         feedIcons = [mcFeed1,mcFeed2];
         this.Setup(0);
         mcCurrGuardian.stop();
         mcNextGuardian.stop();
      }
      
      public static function FeedClick(param1:MouseEvent) : *
      {
         _bCage.FeedGuardian(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),false);
         GUARDIANCAGE.Hide(param1);
      }
      
      public function Setup(param1:int = 0) : *
      {
         if(GLOBAL._mode == "build")
         {
            if(GLOBAL._bCage)
            {
               b1.Setup("Champion",false,0,0);
               b1.addEventListener(MouseEvent.CLICK,this.SwitchClick(0));
               b2.Setup("Evolution",false,0,0);
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
            this.guardID = CREATURES._guardian._creatureID;
            this.totalFeeds = GUARDIANCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"feedCount");
            this.currFeeds = CREATURES._guardian._feeds.Get();
         }
      }
      
      public function Switch(param1:int = 0) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this.UpdateVars();
         mcInstant.bAction.removeEventListener(MouseEvent.CLICK,this.InstantClick);
         mcInstant.bAction.removeEventListener(MouseEvent.CLICK,this.EvolveClick);
         bEvolve.removeEventListener(MouseEvent.CLICK,FeedClick);
         bHeal.removeEventListener(MouseEvent.CLICK,this.HealClick);
         var _loc2_:* = 0;
         while(_loc2_ < pagesArr.length)
         {
            if(_loc2_ == param1)
            {
               _loc3_ = 0;
               while(_loc3_ < pagesArr[_loc2_].length)
               {
                  pagesArr[_loc2_][_loc3_].visible = true;
                  if(pagesArr[_loc2_][_loc3_] is MovieClip)
                  {
                     pagesArr[_loc2_][_loc3_].enabled = true;
                  }
                  _loc3_++;
               }
               _page = param1;
               window.gotoAndStop(param1 + 1);
            }
            else
            {
               _loc4_ = 0;
               while(_loc4_ < pagesArr[_loc2_].length)
               {
                  pagesArr[_loc2_][_loc4_].visible = false;
                  if(pagesArr[_loc2_][_loc3_] is MovieClip)
                  {
                     pagesArr[_loc2_][_loc4_].enabled = false;
                  }
                  _loc4_++;
               }
            }
            _loc2_++;
         }
         if(CREATURES._guardian)
         {
            if(param1 == 0)
            {
               this.UpdatePortrait();
               this.UpdateStats();
               bHeal.Setup("Heal Champion",false,0,0);
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
               if(CREATURES._guardian._level.Get() < 6)
               {
                  _loc5_ = this.guard._feedTime.Get() < GLOBAL.Timestamp();
                  if(_loc5_)
                  {
                     mcInstant.visible = true;
                     mcInstant.enabled = true;
                     mcInstant.tDescription.htmlText = "<b>Keep your monsters and feed instantly!</b>";
                     mcInstant.bAction.Highlight = false;
                     _loc6_ = GUARDIANCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedShiny");
                     mcInstant.bAction.Setup("Use " + _loc6_ + " Shiny",false,0,0);
                     mcInstant.bAction.addEventListener(MouseEvent.CLICK,this.InstantClick);
                     bEvolve.Setup("Feed Now",false,0,0);
                     bEvolve.visible = true;
                     bEvolve.Enabled = true;
                     bEvolve.Highlight = false;
                     bEvolve.addEventListener(MouseEvent.CLICK,FeedClick);
                  }
                  else
                  {
                     mcInstant.visible = true;
                     mcInstant.enabled = true;
                     mcInstant.tDescription.htmlText = "<b>Evolve your Champion instantly!</b>";
                     mcInstant.bAction.Highlight = false;
                     mcInstant.bAction.Enabled = true;
                     _loc7_ = GUARDIANCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedShiny");
                     _loc7_ = _loc7_ * 2;
                     _loc7_ = _loc7_ * (GUARDIANCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedCount") - CREATURES._guardian._feeds.Get());
                     mcInstant.bAction.Setup("Use " + _loc7_ + " Shiny",false,0,0);
                     mcInstant.bAction.removeEventListener(MouseEvent.CLICK,this.InstantClick);
                     mcInstant.bAction.addEventListener(MouseEvent.CLICK,this.EvolveClick);
                     bEvolve.Setup("Feed Now",false,0,0);
                     bEvolve.visible = true;
                     bEvolve.Enabled = false;
                     bEvolve.Highlight = false;
                     bEvolve.removeEventListener(MouseEvent.CLICK,FeedClick);
                     bEvolve.addEventListener(MouseEvent.CLICK,this.CantFeedClick);
                  }
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
                  this.tFeedsFrom.htmlText = "<b>Fully Evolved!</b>";
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
      
      private function UpdateDNA() : void
      {
         var FeedIconLoaded:Function;
         var FeedIconLoaded2:Function;
         var MASKSTART:Number = NaN;
         var MASKLENGTH:Number = NaN;
         var feedRatio:Number = NaN;
         var time:int = 0;
         var feedReqs:* = undefined;
         var feedReqCount:Number = NaN;
         var cName:String = null;
         var cID:String = null;
         var cImage:String = null;
         var i:* = undefined;
         var guardIndex:int = 1;
         if(CREATURES._guardian)
         {
            if(CREATURES._guardian._type == 1)
            {
               guardIndex = 1;
               guardIndex += CREATURES._guardian._level.Get() - 1;
               mcCurrGuardian.gotoAndStop(guardIndex);
               mcNextGuardian.gotoAndStop(Math.min(guardIndex + 1,6));
            }
            else if(CREATURES._guardian._type == 2)
            {
               guardIndex = 7;
               guardIndex += CREATURES._guardian._level.Get() - 1;
               mcCurrGuardian.gotoAndStop(guardIndex);
               mcNextGuardian.gotoAndStop(Math.min(guardIndex + 1,12));
            }
            else if(CREATURES._guardian._type == 3)
            {
               guardIndex = 13;
               guardIndex += CREATURES._guardian._level.Get() - 1;
               mcCurrGuardian.gotoAndStop(guardIndex);
               mcNextGuardian.gotoAndStop(Math.min(guardIndex + 1,18));
            }
            MASKSTART = -517;
            MASKLENGTH = 222;
            feedRatio = this.currFeeds / this.totalFeeds;
            barDNA_mask.x = MASKSTART + feedRatio * MASKLENGTH;
            time = CREATURES._guardian._feedTime.Get();
            if(time < GLOBAL.Timestamp())
            {
               tNextFeed.htmlText = "<b>Hungry!  Will Starve In <br>" + GLOBAL.ToTime(time + 86400 - GLOBAL.Timestamp()) + "!</b>";
            }
            else
            {
               tNextFeed.htmlText = "<b>Feed Me In <br>" + GLOBAL.ToTime(CREATURES._guardian._feedTime.Get() - GLOBAL.Timestamp()) + "</b>";
            }
            tFeedsFrom.htmlText = Math.max(0,this.totalFeeds - this.currFeeds) + " Feeds from Evolution ";
            feedIcons[0].visible = false;
            feedIcons[1].visible = false;
            feedReqs = GUARDIANCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"feeds");
            feedReqCount = 0;
            i = 1;
            while(i <= 13)
            {
               cName = KEYS.Get(CREATURELOCKER._creatures["C" + i].name);
               cID = "C" + i;
               cImage = "monsters/" + cID + "-small.png";
               if(feedReqs["C" + i])
               {
                  FeedIconLoaded = function(param1:String, param2:BitmapData):*
                  {
                     feedIcons[0].mcImage.addChild(new Bitmap(param2));
                     feedIcons[0].mcImage.width = 30;
                     feedIcons[0].mcImage.height = 27;
                  };
                  FeedIconLoaded2 = function(param1:String, param2:BitmapData):*
                  {
                     feedIcons[1].mcImage.addChild(new Bitmap(param2));
                     feedIcons[1].mcImage.width = 30;
                     feedIcons[1].mcImage.height = 27;
                  };
                  feedReqCount++;
                  if(HOUSING._creatures["C" + i] == null || HOUSING._creatures["C" + i] && HOUSING._creatures["C" + i].Get() < feedReqs["C" + i])
                  {
                     feedIcons[feedReqCount - 1].tName.htmlText = "<font color=\"#ff0000\"><b>" + feedReqs[cID] + " " + cName + "</b></font>";
                  }
                  else
                  {
                     feedIcons[feedReqCount - 1].tName.htmlText = "<font color=\"#000000\"><b>" + feedReqs[cID] + " " + cName + "</b></font>";
                  }
                  if(feedReqCount == 1)
                  {
                     ImageCache.GetImageWithCallBack(cImage,FeedIconLoaded);
                  }
                  else if(feedReqCount == 2)
                  {
                     ImageCache.GetImageWithCallBack(cImage,FeedIconLoaded2);
                  }
                  feedIcons[feedReqCount - 1].visible = true;
               }
               if(feedReqCount >= 2)
               {
                  break;
               }
               i++;
            }
         }
      }
      
      private function UpdateStats() : *
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(CREATURES._guardian)
         {
            tEvoStage.htmlText = "<b>Evolution:<b> Stage " + CREATURES._guardian._level.Get();
            damage_txt.htmlText = "<b>Damage<b>";
            health_txt.htmlText = "<b>Health<b>";
            speed_txt.htmlText = "<b>Speed<b>";
            buff_txt.htmlText = "<b>Buff<b>";
            _loc1_ = KEYS.Get("mon_gorgodesc");
            _loc2_ = KEYS.Get("mon_drulldesc");
            _loc3_ = KEYS.Get("mon_fomordesc");
            switch(CREATURES._guardian._type)
            {
               case 1:
                  tEvoDesc.htmlText = _loc1_;
                  break;
               case 2:
                  tEvoDesc.htmlText = _loc2_;
                  break;
               case 3:
                  tEvoDesc.htmlText = _loc3_;
            }
            _loc4_ = GUARDIANCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"damage");
            _loc5_ = GUARDIANCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"health");
            _loc6_ = GUARDIANCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"speed");
            _loc7_ = GUARDIANCAGE.GetGuardianProperty(this.guardID,this.guardLevel,"buffs") * 100;
            tDamage.htmlText = "" + _loc4_;
            tHealth.htmlText = "" + _loc5_;
            tSpeed.htmlText = "" + _loc6_;
            tBuff.htmlText = "" + int(_loc7_) + "%";
            tHP.htmlText = Math.floor(this.guard._health.Get()) + " / " + Math.floor(this.guard._maxHealth);
            TweenLite.to(bDamage.mcBar,0.4,{
               "width":100 / _maxDamage * _loc4_,
               "ease":Circ.easeInOut,
               "delay":0
            });
            TweenLite.to(bHealth.mcBar,0.4,{
               "width":100 / _maxHealth * _loc5_,
               "ease":Circ.easeInOut,
               "delay":0.05
            });
            TweenLite.to(bSpeed.mcBar,0.4,{
               "width":100 / _maxSpeed * _loc6_,
               "ease":Circ.easeInOut,
               "delay":0.1
            });
            TweenLite.to(bBuff.mcBar,0.4,{
               "width":100 / _maxBuff * _loc7_,
               "ease":Circ.easeInOut,
               "delay":0.15
            });
            barHP.mcBar.width = 100 / this.guard._maxHealth * Math.max(1,this.guard._health.Get());
         }
      }
      
      private function UpdateFeeds() : *
      {
      }
      
      public function Tick() : *
      {
         var _loc1_:int = 0;
         if(CREATURES._guardian._level.Get() < 6)
         {
            _loc1_ = CREATURES._guardian._feedTime.Get();
            if(_loc1_ < GLOBAL.Timestamp())
            {
               if(_page == 1)
               {
                  this.Switch(1);
               }
               tNextFeed.htmlText = "<b>Hungry!  Will Starve In <br>" + GLOBAL.ToTime(_loc1_ + 86400 - GLOBAL.Timestamp()) + "!</b>";
            }
            else
            {
               tNextFeed.htmlText = "<b>Feed Me In <br>" + GLOBAL.ToTime(CREATURES._guardian._feedTime.Get() - GLOBAL.Timestamp()) + "</b>";
            }
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
            GUARDIANCAGE.HealGuardian();
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
            _loc2_ = GUARDIANCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedShiny");
            _loc2_ *= 2;
            _loc2_ *= GUARDIANCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedCount") - CREATURES._guardian._feeds.Get();
            this.EvolveClickB();
         }
      }
      
      public function EvolveClickB() : *
      {
         var _loc1_:int = 0;
         if(CREATURES._guardian._level.Get() < 6)
         {
            _loc1_ = GUARDIANCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedShiny");
            _loc1_ *= 2;
            _loc1_ *= GUARDIANCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"feedCount") - CREATURES._guardian._feeds.Get();
            if(BASE._credits.Get() < _loc1_)
            {
               POPUPS.DisplayGetShiny();
               return;
            }
            CREATURES._guardian.LevelSet(CREATURES._guardian._level.Get() + 1,_loc1_);
            BASE.Purchase("IEV",_loc1_,"store");
            GUARDIANCAGE.Hide();
            BASE.Save();
         }
      }
      
      public function InstantClick(param1:MouseEvent) : *
      {
         _bCage.FeedGuardian(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),true);
         GUARDIANCAGE.Hide(param1);
      }
      
      public function CantFeedClick(param1:MouseEvent) : *
      {
         GLOBAL.Message("Your monster is not hungry yet.");
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         GUARDIANCAGE.Hide(param1);
      }
      
      public function Resize() : void
      {
         this.x = GLOBAL._SCREENCENTER.x;
         this.y = GLOBAL._SCREENCENTER.y;
      }
   }
}

