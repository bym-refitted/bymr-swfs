package
{
   import com.cc.utils.SecNum;
   import com.monsters.display.BuildingAssetContainer;
   import com.monsters.display.BuildingOverlay;
   import com.monsters.display.ImageCache;
   import com.monsters.effects.fire.Fire;
   import com.monsters.effects.smoke.Smoke;
   import com.monsters.events.BuildingEvent;
   import com.monsters.pathing.PATHING;
   import com.monsters.utils.MovieClipUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BFOUNDATION
   {
      public static const TICK_LIMIT:int = 2 * 24 * 60 * 60;
      
      internal var _mcBase:*;
      
      internal var _mcFootprint:*;
      
      internal var _mcHit:*;
      
      internal var _r:*;
      
      public var _mc:MovieClip;
      
      public var _mouseClicked:Boolean = false;
      
      public var topContainer:BuildingAssetContainer;
      
      public var animContainer:BuildingAssetContainer;
      
      public var _fortBackContainer:BuildingAssetContainer;
      
      public var _fortFrontContainer:BuildingAssetContainer;
      
      public var _spriteAlert:Sprite;
      
      public var _mcAlert:DisplayObject;
      
      public var _middle:int;
      
      public var _position:Point;
      
      public var _oldPosition:Point;
      
      public var _stopMoveCount:int;
      
      public var _moving:Boolean;
      
      public var _mouseOffset:Point;
      
      public var _footprint:Array;
      
      public var _blockers:Array;
      
      public var _gridCost:Array;
      
      public var _clickTimer:int;
      
      public var _prefab:int = 0;
      
      public var _buildInstant:Boolean = false;
      
      public var _buildInstantCost:SecNum;
      
      public var _fortification:SecNum;
      
      public const _nullPoint:Point = new Point(0,0);
      
      public var _animLoaded:Boolean = false;
      
      public var _animBMD:BitmapData;
      
      public var _animRect:Rectangle;
      
      public var _animContainerBMD:BitmapData;
      
      public var _animTick:int = 0;
      
      public var _animFrames:int = 0;
      
      public var anim2Container:BuildingAssetContainer;
      
      public var _anim2BMD:BitmapData;
      
      public var _anim2ContainerBMD:BitmapData;
      
      public var _anim2Rect:Rectangle;
      
      public var _anim2Frames:int = 0;
      
      public var _anim2Tick:int = 0;
      
      public var _anim2Loaded:Boolean = false;
      
      public var anim3Container:BuildingAssetContainer;
      
      public var _anim3BMD:BitmapData;
      
      public var _anim3ContainerBMD:BitmapData;
      
      public var _anim3Rect:Rectangle;
      
      public var _anim3Frames:int = 0;
      
      public var _anim3Tick:int = 0;
      
      public var _anim3Loaded:Boolean = false;
      
      public var _animRandomStart:Boolean = true;
      
      public var _countdownBuild:SecNum;
      
      public var _countdownUpgrade:SecNum;
      
      public var _countdownRebuild:SecNum;
      
      public var _countdownProduce:SecNum;
      
      public var _countdownFortify:SecNum;
      
      public var _stored:SecNum;
      
      public var _lvl:SecNum;
      
      public var _threadid:int;
      
      public var _subject:String;
      
      public var _senderid:int;
      
      public var _senderName:String;
      
      public var _senderPic:String;
      
      public var _hpCountdownRebuild:int;
      
      public var _hpCountdownProduce:int;
      
      public var _hpStored:int;
      
      public var _hpLvl:int;
      
      public var _repairing:int;
      
      public var _repairTime:int;
      
      public var _productionStage:SecNum;
      
      public var _looted:Boolean = false;
      
      public var _hasWorker:Boolean;
      
      public var _hasResources:Boolean;
      
      public var _counter:Number;
      
      public var _type:int;
      
      public var _attackgroup:int;
      
      public var _class:String;
      
      public var _id:int;
      
      public var _size:int;
      
      public var _hp:SecNum;
      
      public var _hpMax:SecNum;
      
      public var _energy:int;
      
      public var _fired:Boolean;
      
      public var _creatures:Array;
      
      public var _buildingTitle:String;
      
      public var _buildingInstructions:String;
      
      public var _buildingStats:String;
      
      public var _buildingDescription:String;
      
      public var _upgradeDescription:String;
      
      public var _recycleDescription:String;
      
      public var _specialDescription:String;
      
      public var _repairDescription:String;
      
      public var _blockRecycle:Boolean;
      
      public var _upgradeCosts:String;
      
      public var _recycleCosts:String;
      
      public var _buildingProps:Object;
      
      public var _resource:Number;
      
      public var _range:int;
      
      public var _damage:int;
      
      public var _rate:int;
      
      public var _splash:int;
      
      public var _speed:int;
      
      public var _producing:int;
      
      public var _constructed:Boolean;
      
      public var _placing:Boolean;
      
      public var _oldY:int;
      
      public var _upgrading:String;
      
      public var _shadow:*;
      
      public var _origin:Point;
      
      public var _shake:int;
      
      public var _picking:Boolean;
      
      public var _monsterQueue:Array;
      
      public var _inProduction:String;
      
      public var _taken:SecNum;
      
      public var _spoutPoint:Point;
      
      public var _spoutHeight:int;
      
      public var _progressMC:*;
      
      public var _canFunction:Boolean;
      
      public var _helpList:Array;
      
      public var _destroyed:Boolean = false;
      
      public var _renderState:String = null;
      
      public var _oldRenderState:String = null;
      
      public var _lastLoadedState:String = null;
      
      public var _renderLevel:int = 0;
      
      public var _renderFortLevel:int = 0;
      
      public var _treat:int;
      
      public var _expireTime:int = 0;
      
      protected var imageData:Object;
      
      private var _lastBarIndex:int = -1;
      
      public var _overlayOffset:Point = new Point(0,0);
      
      public var _recycled:Boolean = false;
      
      public function BFOUNDATION()
      {
         super();
         this._hp = new SecNum(0);
         this._hpMax = new SecNum(0);
         this._energy = 0;
         this._buildingTitle = "";
         this._buildingDescription = "";
         this._buildingInstructions = "";
         this._upgradeDescription = "";
         this._buildingStats = "";
         this._creatures = [];
         this._helpList = [];
         this._fortification = new SecNum(0);
         this._countdownBuild = new SecNum(0);
         this._countdownRebuild = new SecNum(0);
         this._countdownUpgrade = new SecNum(0);
         this._countdownProduce = new SecNum(0);
         this._countdownFortify = new SecNum(0);
         this._stored = new SecNum(0);
         this._lvl = new SecNum(0);
         this._hpCountdownRebuild = 0;
         this._hpCountdownProduce = 0;
         this._hpStored = 0;
         this._hpLvl = 0;
         this._inProduction = "";
         this._productionStage = new SecNum(0);
         this._constructed = false;
         this._placing = true;
         this._repairing = 0;
         this._mouseOffset = new Point(0,0);
         this._oldY = 0;
         if(BASE._yardType == BASE.OUTPOST || BASE._yardType == BASE.INFERNO_OUTPOST)
         {
            this._blockRecycle = true;
         }
      }
      
      public function SetProps() : *
      {
         try
         {
            this._buildingProps = GLOBAL._buildingProps[this._type - 1];
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  buildingprops | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps buildingprops");
            return;
         }
         try
         {
            this._mcFootprint = MAP._BUILDINGFOOTPRINTS.addChild(this.GetFootprintMC());
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  mcfootprint 1 | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps mcfootprint1");
            return;
         }
         try
         {
            this._mc = MAP._BUILDINGTOPS.addChild(new MovieClip());
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  mc | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps:  mc");
            return;
         }
         try
         {
            this.topContainer = new BuildingAssetContainer();
            this.topContainer.mouseChildren = false;
            this.topContainer.mouseEnabled = false;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  topContainer | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps:  topContainer");
            return;
         }
         try
         {
            this.animContainer = new BuildingAssetContainer();
            this.animContainer.mouseChildren = false;
            this.animContainer.mouseEnabled = false;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  animContainer | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps:  animContainer");
            return;
         }
         try
         {
            this._fortFrontContainer = new BuildingAssetContainer();
            this._fortFrontContainer.mouseChildren = false;
            this._fortFrontContainer.mouseEnabled = false;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  _fortFrontContainer | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps:  _fortFrontContainer");
            return;
         }
         try
         {
            this._fortBackContainer = new BuildingAssetContainer();
            this._fortBackContainer.mouseChildren = false;
            this._fortBackContainer.mouseEnabled = false;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  _fortBackContainer | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps:  _fortBackContainer");
            return;
         }
         try
         {
            this._mc.addChild(this._fortBackContainer);
            this._mc.addChild(this.topContainer);
            this._mc.addChild(this.animContainer);
            this._mc.addChild(this._fortFrontContainer);
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  mc.addChildren | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps:  mc.addChildren");
            return;
         }
         try
         {
            this._mcBase = MAP._BUILDINGBASES.addChild(new BuildingAssetContainer());
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  mcBase | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps:  mcBase");
            return;
         }
         try
         {
            this._mcHit = this._mc.addChild(this.GetHitMC());
            this._mcHit.gotoAndStop(1);
            this._mcHit.cacheAsBitmap = true;
            this._mcHit.alpha = 0;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  mcHit | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps:  mcHit");
            return;
         }
         try
         {
            this._size = this._buildingProps.size;
            this._class = this._buildingProps.type;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  size/class | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps:  size/class");
            return;
         }
         try
         {
            this._mcFootprint.gotoAndStop(1);
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  mcFootprint 2 | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps:  mcFootprint 2");
            return;
         }
         try
         {
            this._attackgroup = this._buildingProps.attackgroup;
            this._mouseOffset = new Point(0,int(this._mcFootprint.height / 20) * 10);
            this._middle = this._footprint[0].height * 0.5;
            this._mc._middle = this._middle;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.SetProps:  end stuff | " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.SetProps:  end");
            return;
         }
         this.anim2Container = new BuildingAssetContainer();
         this.anim2Container.mouseChildren = false;
         this.anim2Container.mouseEnabled = false;
         this.anim3Container = new BuildingAssetContainer();
         this.anim3Container.mouseChildren = false;
         this.anim3Container.mouseEnabled = false;
         this._mc.addChild(this.anim2Container);
         this._mc.addChild(this.anim3Container);
      }
      
      public function Bank() : *
      {
      }
      
      public function Description() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         if(this._buildingProps.names != null && this._buildingProps.names.length >= this._lvl.Get())
         {
            this._buildingTitle = "<b>" + this._buildingProps.names[this._lvl.Get() - 1] + "</b>";
         }
         else
         {
            this._buildingTitle = "<b>" + this._buildingProps.name + "</b>";
            if(this._buildingProps.costs.length > 1)
            {
               this._buildingTitle += " " + KEYS.Get("bdg_level",{"v1":this._lvl.Get()});
            }
         }
         if(this._hp.Get() < this._hpMax.Get())
         {
            if(this._countdownUpgrade.Get() > 0)
            {
               this._repairDescription = "<font color=\"#FF0000\"><b>" + KEYS.Get("repaironhold_upgrade") + "</b></font>";
            }
            else if(this._countdownFortify.Get() > 0)
            {
               this._repairDescription = "<font color=\"#FF0000\"><b>" + KEYS.Get("repaironhold_fortify") + "</b></font>";
            }
            else
            {
               _loc1_ = 100 - Math.ceil(100 / this._hpMax.Get() * this._hp.Get());
               this._specialDescription = "<font color=\"#FF0000\"><b>" + KEYS.Get("building_percentdamaged",{"v1":_loc1_}) + "</b></font>";
            }
         }
         else
         {
            if(this._buildingProps.descriptions != null && this._buildingProps.descriptions.length >= this._lvl.Get())
            {
               this._specialDescription = this._buildingProps.descriptions[this._lvl.Get() - 1];
            }
            else
            {
               this._specialDescription = this._buildingProps.description;
            }
            if(!(this._type == 24 || this._type == 25 || this._type == 26))
            {
               if(this._type == 20 || this._type == 21)
               {
                  this._buildingStats = KEYS.Get("building_stats_dps",{
                     "v1":this._range,
                     "v2":this._damage,
                     "v3":int(this._damage * (40 / this._rate)),
                     "v4":this._splash,
                     "v5":int(40 / this._rate * 10) / 10
                  });
                  if(this._type == 20)
                  {
                     this._buildingDescription = KEYS.Get("building_cannon_desc");
                  }
                  if(this._type == 21)
                  {
                     this._buildingDescription = KEYS.Get("building_sniper_desc");
                  }
                  if(this._lvl.Get() < this._buildingProps.costs.length)
                  {
                     this._upgradeDescription = KEYS.Get("building_stats",{
                        "v1":this._buildingProps.stats[this._lvl.Get()].range,
                        "v2":this._buildingProps.stats[this._lvl.Get()].damage,
                        "v3":this._buildingProps.stats[this._lvl.Get()].splash,
                        "v4":int(40 / this._buildingProps.stats[this._lvl.Get()].rate * 10) / 10
                     });
                  }
               }
            }
         }
         this._recycleDescription = "";
         if(this._repairing == 1)
         {
            _loc2_ = 0;
            if(this._lvl.Get() == 0)
            {
               _loc2_ = int(this._buildingProps.repairTime[0]);
            }
            else
            {
               _loc2_ = int(this._buildingProps.repairTime[this._lvl.Get() - 1]);
            }
            _loc2_ = Math.min(60 * 60,_loc2_);
            _loc2_ = Math.ceil(this._hpMax.Get() / _loc2_);
            this._repairDescription = "<font color=\"#FF0000\"><b>" + KEYS.Get("building_damagedinattack") + "</b></font><br>" + KEYS.Get("building_repairinprogress",{
               "v1":Math.floor(100 / this._hpMax.Get() * this._hp.Get()),
               "v2":GLOBAL.ToTime(int((this._hpMax.Get() - this._hp.Get()) / _loc2_))
            });
         }
         else
         {
            this._repairDescription = "<font color=\"#FF0000\"><b>" + KEYS.Get("building_damagedinattack") + "</b></font><br>" + KEYS.Get("building_repairfree");
            if(this._countdownBuild.Get() > 0)
            {
               this._repairDescription += "<br>" + KEYS.Get("building_attackdestroy");
            }
            if(this._countdownUpgrade.Get() > 0)
            {
               this._repairDescription += "<br>" + KEYS.Get("building_attacksetback");
            }
         }
         if(this._lvl.Get() >= this._buildingProps.costs.length)
         {
            this._upgradeDescription = KEYS.Get("bdg_fullyupgraded");
            this._upgradeCosts = "";
         }
         else
         {
            this._upgradeCosts = "";
            _loc3_ = this._buildingProps.costs[this._lvl.Get()];
            if(_loc3_.r1 > 0)
            {
               if(_loc3_.r1 > BASE._resources.r1.Get())
               {
                  this._upgradeCosts += "<font color=\"#FF0000\">";
               }
               this._upgradeCosts += GLOBAL.FormatNumber(_loc3_.r1) + " " + GLOBAL._resourceNames[0] + "</font> - ";
            }
            if(_loc3_.r2 > 0)
            {
               if(_loc3_.r2 > BASE._resources.r2.Get())
               {
                  this._upgradeCosts += "<font color=\"#FF0000\">";
               }
               this._upgradeCosts += GLOBAL.FormatNumber(_loc3_.r2) + " " + GLOBAL._resourceNames[1] + "</font> - ";
            }
            if(_loc3_.r3 > 0)
            {
               if(_loc3_.r3 > BASE._resources.r3.Get())
               {
                  this._upgradeCosts += "<font color=\"#FF0000\">";
               }
               this._upgradeCosts += GLOBAL.FormatNumber(_loc3_.r3) + " " + GLOBAL._resourceNames[2] + "</font> - ";
            }
            if(_loc3_.r4 > 0)
            {
               if(_loc3_.r4 > BASE._resources.r4.Get())
               {
                  this._upgradeCosts += "<font color=\"#FF0000\">";
               }
               this._upgradeCosts += GLOBAL.FormatNumber(_loc3_.r4) + " " + GLOBAL._resourceNames[3] + "</font> - ";
            }
            this._upgradeCosts += GLOBAL.ToTime(_loc3_.time);
            this._upgradeDescription = "";
         }
      }
      
      public function RenderClear() : void
      {
         this._renderState = null;
         this._mcBase.Clear();
         this.topContainer.Clear();
         this.animContainer.Clear();
         this.anim2Container.Clear();
         this.anim3Container.Clear();
      }
      
      public function Render(param1:String = "") : *
      {
         var ImageCallback:Function;
         var FortImageCallback:Function;
         var imageDataA:Object = null;
         var imageDataB:Object = null;
         var imageLevel:int = 0;
         var fortImageDataA:Object = null;
         var fortImageDataB:Object = null;
         var fortImageLevel:int = 0;
         var i:int = 0;
         var loadImages:Array = null;
         var j:int = 0;
         var loadFortImages:Array = null;
         var state:String = param1;
         if(this._renderState == null || state != this._renderState || this._lvl.Get() != this._renderLevel)
         {
            ImageCallback = function(param1:Array, param2:String):*
            {
               var rect:Rectangle = null;
               var image:Array = null;
               var key:String = null;
               var bmd:BitmapData = null;
               var container:BuildingAssetContainer = null;
               var s:DisplayObject = null;
               var images:Array = param1;
               var imagestate:String = param2;
               if(imagestate == _renderState)
               {
                  _mcBase.Clear();
                  topContainer.Clear();
                  animContainer.Clear();
                  anim2Container.Clear();
                  anim3Container.Clear();
                  if(_lastLoadedState != null)
                  {
                     if(state == "destroyed" && _lastLoadedState == "damaged")
                     {
                        if(_type == 14)
                        {
                           SOUNDS.Play("destroytownhall");
                           if(_type != 17 && _type != 18)
                           {
                              Smoke.CreatePoof(new Point(x,y + _middle),_middle,1);
                           }
                        }
                        else
                        {
                           SOUNDS.Play(SOUNDS.DestroySoundIDForLevel(_lvl.Get()));
                           if(_type != 17 && _type != 18)
                           {
                              Smoke.CreatePoof(new Point(x,y + _middle),_middle,1);
                           }
                        }
                        if(_class != "wall" && _class != "trap" && _type != 15)
                        {
                           Smoke.CreateStream(new Point(x,y + _middle));
                        }
                     }
                     if(state == "damaged" && _lastLoadedState == "")
                     {
                        SOUNDS.Play(SOUNDS.DamageSoundIDForLevel(_lvl.Get()));
                        if(_type != 17 && _type != 18)
                        {
                           Smoke.CreatePoof(new Point(x,y + _middle),_middle,0.5);
                        }
                     }
                  }
                  _lastLoadedState = state;
                  _mc.removeEventListener(Event.ENTER_FRAME,TickFast);
                  for each(image in images)
                  {
                     key = image[0];
                     bmd = image[1];
                     if(Boolean(imageDataB["shadow" + state]) && imageDataA.baseurl + imageDataB["shadow" + state][0] == key)
                     {
                        container = _mcBase;
                        container.Clear();
                        s = container.addChild(new Bitmap(bmd));
                        s.blendMode = "multiply";
                        s.x = imageDataB["shadow" + state][1].x;
                        s.y = imageDataB["shadow" + state][1].y;
                     }
                     else if(Boolean(imageDataB["top" + state]) && imageDataA.baseurl + imageDataB["top" + state][0] == key)
                     {
                        container = topContainer;
                        container.Clear();
                        container.addChild(new Bitmap(bmd));
                        container.x = imageDataB["top" + state][1].x;
                        container.y = imageDataB["top" + state][1].y;
                        try
                        {
                           if(MovieClipUtils.validateFrameLabel(_mcHit as MovieClip,"f" + imageLevel + state))
                           {
                              _mcHit.gotoAndStop("f" + imageLevel + state);
                           }
                        }
                        catch(e:Error)
                        {
                        }
                        if(state == "destroyed" && _type != 14)
                        {
                           if(MovieClipUtils.validateFrameLabel(_mcHit as MovieClip,"f" + state))
                           {
                              _mcHit.gotoAndStop("f" + state);
                           }
                           else
                           {
                              print("BFOUNDATION.ImageCallback building has no hit 1 " + _type + " frame f" + state);
                           }
                        }
                        _mcHit.x = container.x;
                        _mcHit.y = container.y;
                     }
                     else if(Boolean(imageDataB["anim" + state]) && imageDataA.baseurl + imageDataB["anim" + state][0] == key)
                     {
                        _animBMD = bmd;
                        _animLoaded = true;
                        container = animContainer;
                        container.Clear();
                        rect = imageDataB["anim" + state][1];
                        _animRect = new Rectangle(0,0,rect.width,rect.height);
                        _animFrames = imageDataB["anim" + state][2];
                        if(_animRandomStart)
                        {
                           _animTick = int(Math.random() * (_animFrames - 2));
                        }
                        else
                        {
                           _animTick = 0;
                        }
                        if(_type == 9 || _type == 19 || _type == 25 || _type == 54)
                        {
                           _animTick = 0;
                        }
                        _animContainerBMD = new BitmapData(rect.width,rect.height,true,0xffffff);
                        container.addChild(new Bitmap(_animContainerBMD));
                        container.x = rect.x;
                        container.y = rect.y;
                        AnimFrame(false);
                        _mc.addEventListener(Event.ENTER_FRAME,TickFast);
                        if(!imageDataB["top" + state])
                        {
                           try
                           {
                              _mcHit.gotoAndStop("f" + imageLevel + state);
                           }
                           catch(e:Error)
                           {
                           }
                           if(state == "destroyed" && _type != 14)
                           {
                              _mcHit.gotoAndStop("f" + state);
                           }
                           _mcHit.x = container.x;
                           _mcHit.y = container.y;
                        }
                     }
                     else if(Boolean(imageDataB["anim2" + state]) && imageDataA.baseurl + imageDataB["anim2" + state][0] == key)
                     {
                        _anim2BMD = bmd;
                        _anim2Loaded = true;
                        container = anim2Container;
                        container.Clear();
                        rect = imageDataB["anim2" + state][1];
                        _anim2Rect = new Rectangle(0,0,rect.width,rect.height);
                        _anim2Frames = imageDataB["anim2" + state][2];
                        if(_animRandomStart)
                        {
                           _anim2Tick = int(Math.random() * (_anim2Frames - 2));
                        }
                        else
                        {
                           _anim2Tick = 0;
                        }
                        _anim2ContainerBMD = new BitmapData(rect.width,rect.height,true,0xffffff);
                        container.addChild(new Bitmap(_anim2ContainerBMD));
                        container.x = rect.x;
                        container.y = rect.y;
                        if(_animLoaded && _anim2Loaded && _anim3Loaded)
                        {
                           AnimFrame(false);
                           _mc.addEventListener(Event.ENTER_FRAME,TickFast);
                        }
                        if(!imageDataB["top" + state])
                        {
                           _mcHit.gotoAndStop("f" + imageLevel + state);
                           if(state == "destroyed")
                           {
                              _mcHit.gotoAndStop("f" + state);
                           }
                           _mcHit.x = container.x;
                           _mcHit.y = container.y;
                        }
                     }
                     else if(Boolean(imageDataB["anim3" + state]) && imageDataA.baseurl + imageDataB["anim3" + state][0] == key)
                     {
                        _anim3BMD = bmd;
                        _anim3Loaded = true;
                        container = anim3Container;
                        container.Clear();
                        rect = imageDataB["anim3" + state][1];
                        _anim3Rect = new Rectangle(0,0,rect.width,rect.height);
                        _anim3Frames = imageDataB["anim3" + state][2];
                        if(_animRandomStart)
                        {
                           _anim3Tick = int(Math.random() * (_anim3Frames - 2));
                        }
                        else
                        {
                           _anim3Tick = 0;
                        }
                        _anim3ContainerBMD = new BitmapData(rect.width,rect.height,true,0xffffff);
                        container.addChild(new Bitmap(_anim3ContainerBMD));
                        container.x = rect.x;
                        container.y = rect.y;
                        if(_animLoaded && _anim2Loaded && _anim3Loaded)
                        {
                           AnimFrame(false);
                           _mc.addEventListener(Event.ENTER_FRAME,TickFast);
                        }
                        if(!imageDataB["top" + state])
                        {
                           _mcHit.gotoAndStop("f" + imageLevel + state);
                           if(state == "destroyed")
                           {
                              _mcHit.gotoAndStop("f" + state);
                           }
                           _mcHit.x = container.x;
                           _mcHit.y = container.y;
                        }
                     }
                     else if(Boolean(imageDataB["anim" + state]) && imageDataA.baseurl + imageDataB["anim" + state][0] == key)
                     {
                        _animBMD = bmd;
                        _animLoaded = true;
                        container = animContainer;
                        container.Clear();
                        rect = imageDataB["anim" + state][1];
                        _animRect = new Rectangle(0,0,rect.width,rect.height);
                        _animFrames = imageDataB["anim" + state][2];
                        if(_animRandomStart)
                        {
                           _animTick = int(Math.random() * (_animFrames - 2));
                        }
                        else
                        {
                           _animTick = 0;
                        }
                        if(_type == 9 || _type == 19 || _type == 25 || _type == 54)
                        {
                           _animTick = 0;
                        }
                        _animContainerBMD = new BitmapData(rect.width,rect.height,true,0xffffff);
                        container.addChild(new Bitmap(_animContainerBMD));
                        container.x = rect.x;
                        container.y = rect.y;
                        AnimFrame(false);
                        _mc.addEventListener(Event.ENTER_FRAME,TickFast);
                        if(!imageDataB["top" + state])
                        {
                           try
                           {
                              _mcHit.gotoAndStop("f" + imageLevel + state);
                           }
                           catch(e:Error)
                           {
                           }
                           if(state == "destroyed" && _type != 14)
                           {
                              _mcHit.gotoAndStop("f" + state);
                           }
                           _mcHit.x = container.x;
                           _mcHit.y = container.y;
                        }
                     }
                     else if(imageDataB.topdestroyedfire && _oldRenderState == "damaged" && !GLOBAL._catchup && imageDataA.baseurl + imageDataB.topdestroyedfire[0] == key)
                     {
                        Fire.Add(_mc,new Bitmap(bmd),new Point(imageDataB.topdestroyedfire[1].x,imageDataB.topdestroyedfire[1].y));
                     }
                  }
               }
               AnimFrame();
            };
            this._renderLevel = this._lvl.Get();
            imageDataA = GLOBAL._buildingProps[this._type - 1].imageData;
            if(this._lvl.Get() == 0)
            {
               imageDataB = imageDataA[1];
               imageLevel = 1;
            }
            else if(imageDataA[this._lvl.Get()])
            {
               imageDataB = imageDataA[this._lvl.Get()];
               imageLevel = this._lvl.Get();
            }
            else
            {
               i = this._lvl.Get() - 1;
               while(i > 0)
               {
                  if(imageDataA[i])
                  {
                     imageDataB = imageDataA[i];
                     imageLevel = i;
                     break;
                  }
                  i--;
               }
            }
            this._oldRenderState = this._renderState;
            this._renderState = state;
            if(imageDataB)
            {
               loadImages = [];
               if(!imageDataB["top" + state])
               {
                  state = "";
               }
               if(imageDataB["top" + state])
               {
                  loadImages.push(imageDataA.baseurl + imageDataB["top" + state][0]);
               }
               if(imageDataB["shadow" + state])
               {
                  loadImages.push(imageDataA.baseurl + imageDataB["shadow" + state][0]);
               }
               if(imageDataB["anim" + state])
               {
                  loadImages.push(imageDataA.baseurl + imageDataB["anim" + state][0]);
               }
               if(imageDataB["anim2" + state])
               {
                  loadImages.push(imageDataA.baseurl + imageDataB["anim2" + state][0]);
               }
               if(imageDataB["anim3" + state])
               {
                  loadImages.push(imageDataA.baseurl + imageDataB["anim3" + state][0]);
               }
               this._animLoaded = false;
               if(state == "damaged" || state == "destroyed")
               {
                  this._anim2Loaded = true;
                  this._anim3Loaded = true;
               }
               else
               {
                  this._anim2Loaded = false;
                  this._anim3Loaded = false;
               }
               ImageCache.GetImageGroupWithCallBack(BASE._yardType + "b" + this._type + "-" + imageLevel + state,loadImages,ImageCallback,true,2,state);
            }
         }
         if(this._fortification.Get() != this._renderFortLevel)
         {
            if(this._fortification.Get() > 4)
            {
               LOGGER.Log("err","Illegal fortification level " + this._fortification.Get());
               throw new Error("ILLEGAL FORTIFICATION LEVEL " + this._fortification.Get());
            }
            this._renderFortLevel = this._fortification.Get();
            fortImageDataA = GLOBAL._buildingProps[this._type - 1].fortImgData;
            if(fortImageDataA[this._fortification.Get()])
            {
               fortImageDataB = fortImageDataA[this._fortification.Get()];
               fortImageLevel = this._fortification.Get();
            }
            else
            {
               j = this._fortification.Get() - 1;
               while(i > 0)
               {
                  if(fortImageDataA[j])
                  {
                     fortImageDataB = fortImageDataA[j];
                     imageLevel = j;
                     break;
                  }
                  i--;
               }
            }
            if(fortImageDataB)
            {
               FortImageCallback = function(param1:Array, param2:String):*
               {
                  var _loc3_:Array = null;
                  var _loc4_:String = null;
                  var _loc5_:BitmapData = null;
                  var _loc6_:BuildingAssetContainer = null;
                  if(param2 == "fort" + _renderFortLevel)
                  {
                     _fortFrontContainer.Clear();
                     _fortBackContainer.Clear();
                     for each(_loc3_ in param1)
                     {
                        _loc4_ = _loc3_[0];
                        _loc5_ = _loc3_[1];
                        if(Boolean(fortImageDataB["front"]) && fortImageDataA.baseurl + fortImageDataB["front"][0] == _loc4_)
                        {
                           _loc6_ = _fortFrontContainer;
                           _loc6_.Clear();
                           _loc6_.addChild(new Bitmap(_loc5_));
                           _loc6_.x = fortImageDataB["front"][1].x;
                           _loc6_.y = fortImageDataB["front"][1].y;
                        }
                        else if(Boolean(fortImageDataB["back"]) && fortImageDataA.baseurl + fortImageDataB["back"][0] == _loc4_)
                        {
                           _loc6_ = _fortBackContainer;
                           _loc6_.Clear();
                           _loc6_.addChild(new Bitmap(_loc5_));
                           _loc6_.x = fortImageDataB["back"][1].x;
                           _loc6_.y = fortImageDataB["back"][1].y;
                        }
                     }
                  }
               };
               loadFortImages = [];
               if(fortImageDataB["front"])
               {
                  loadFortImages.push(fortImageDataA.baseurl + fortImageDataB["front"][0]);
               }
               if(fortImageDataB["back"])
               {
                  loadFortImages.push(fortImageDataA.baseurl + fortImageDataB["back"][0]);
               }
               ImageCache.GetImageGroupWithCallBack("fort" + this._type + "-" + fortImageLevel,loadFortImages,FortImageCallback,true,2,"fort" + this._renderFortLevel);
            }
         }
      }
      
      public function get tickLimit() : int
      {
         if(this._hp.Get() == 0 && !this._repairing)
         {
            return TICK_LIMIT;
         }
         var _loc1_:int = TICK_LIMIT;
         if(this._countdownBuild.Get() > 0)
         {
            _loc1_ = Math.min(_loc1_,this._countdownBuild.Get());
         }
         if(this._countdownUpgrade.Get() > 0)
         {
            _loc1_ = Math.min(_loc1_,this._countdownUpgrade.Get());
         }
         if(this._countdownFortify.Get() > 0)
         {
            _loc1_ = Math.min(_loc1_,this._countdownFortify.Get());
         }
         return _loc1_;
      }
      
      public function Tick(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._countdownBuild.Get() + this._countdownUpgrade.Get() + this._countdownFortify.Get() + this._repairing > 0)
         {
            _loc2_ = 0;
            _loc3_ = 0;
            if(this._repairing == 1)
            {
               _loc5_ = this._lvl.Get() == 0 ? 0 : int(this._lvl.Get() - 1);
               _loc4_ = Math.ceil(this._hpMax.Get() / Math.min(60 * 60,this._buildingProps.repairTime[_loc5_]));
               this._hp.Add(_loc4_ * param1);
               if(this._hp.Get() >= this._hpMax.Get())
               {
                  this.Repaired();
               }
            }
            else if(this._hp.Get() == this._hpMax.Get())
            {
               if(this._countdownUpgrade.Get() > 0 && this._hasWorker && this._hasResources)
               {
                  this._countdownUpgrade.Add(-param1);
                  if(!Math.max(this._countdownUpgrade.Get(),0))
                  {
                     this.Upgraded();
                  }
               }
               else if(this._countdownBuild.Get() > 0 && this._hasWorker && this._hasResources)
               {
                  this._countdownBuild.Add(-param1);
                  if(!Math.max(this._countdownBuild.Get(),0))
                  {
                     this.Constructed();
                  }
               }
               else if(this._countdownFortify.Get() > 0 && this._hasWorker && this._hasResources)
               {
                  this._countdownFortify.Add(-param1);
                  if(!Math.max(this._countdownFortify.Get(),0))
                  {
                     this.Fortified();
                  }
               }
            }
         }
         this.Update();
      }
      
      public function TickFast(param1:Event = null) : *
      {
      }
      
      public function TickAttack() : *
      {
      }
      
      public function AnimFrame(param1:Boolean = true) : *
      {
         var increment:Boolean = param1;
         try
         {
            if(!GLOBAL._catchup && Boolean(this._animBMD))
            {
               this._animRect.x = this._animRect.width * this._animTick;
               this._animContainerBMD.copyPixels(this._animBMD,this._animRect,this._nullPoint);
               if(increment)
               {
                  if(this._class == "resource")
                  {
                     if(GLOBAL._harvesterOverdrive >= GLOBAL.Timestamp() && GLOBAL._harvesterOverdrivePower.Get() > 0)
                     {
                        this._animTick += GLOBAL._harvesterOverdrivePower.Get();
                     }
                     else
                     {
                        ++this._animTick;
                     }
                  }
                  else
                  {
                     ++this._animTick;
                  }
                  if(this._animTick >= this._animFrames)
                  {
                     this._animTick = 0;
                  }
               }
            }
            if(!GLOBAL._catchup && Boolean(this._anim2BMD))
            {
               this._anim2Rect.x = this._anim2Rect.width * this._anim2Tick;
               this._anim2ContainerBMD.copyPixels(this._anim2BMD,this._anim2Rect,this._nullPoint);
               if(increment)
               {
                  ++this._anim2Tick;
                  if(this._anim2Tick >= this._anim2Frames)
                  {
                     this._anim2Tick = 0;
                  }
               }
            }
            if(!GLOBAL._catchup && Boolean(this._anim3BMD))
            {
               this._anim3Rect.x = this._anim3Rect.width * this._anim3Tick;
               this._anim3ContainerBMD.copyPixels(this._anim3BMD,this._anim3Rect,this._nullPoint);
               if(increment)
               {
                  ++this._anim3Tick;
                  if(this._anim3Tick >= this._anim3Frames)
                  {
                     this._anim3Tick = 0;
                  }
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function Instructions() : *
      {
         this._buildingInstructions += KEYS.Get("building_instructions");
      }
      
      public function FollowMouse() : *
      {
         this._mc.addEventListener(Event.ENTER_FRAME,this.FollowMouseB);
         MAP._GROUND.addEventListener(MouseEvent.MOUSE_UP,this.Place);
         this._mc.addEventListener(MouseEvent.MOUSE_DOWN,MAP.Click);
         this.Render("");
      }
      
      public function FollowMouseB(param1:Event = null) : *
      {
         var _loc2_:* = BASE.BuildBlockers(this,this._class == "decoration");
         this._mc.x = int((MAP._GROUND.mouseX - this._mouseOffset.x) / 10) * 10;
         this._mc.y = int((MAP._GROUND.mouseY - this._mouseOffset.y) / 5) * 5;
         this._mcBase.x = this._mc.x;
         this._mcBase.y = this._mc.y;
         if(this._mcFootprint)
         {
            this._mcFootprint.x = this._mc.x;
            this._mcFootprint.y = this._mc.y;
            if(_loc2_ != "")
            {
               this._mcFootprint.gotoAndStop(2);
            }
            else
            {
               this._mcFootprint.gotoAndStop(1);
            }
         }
         MAP.SortDepth(false,true);
      }
      
      public function Cancel() : *
      {
         GLOBAL._newBuilding = null;
         this._mc.removeEventListener(Event.ENTER_FRAME,this.FollowMouseB);
         MAP._GROUND.removeEventListener(MouseEvent.MOUSE_UP,this.Place);
         this._mc.removeEventListener(MouseEvent.MOUSE_DOWN,MAP.Click);
         if(this._mcBase.parent)
         {
            MAP._BUILDINGBASES.removeChild(this._mcBase);
         }
         if(this._mc.parent)
         {
            MAP._BUILDINGTOPS.removeChild(this._mc);
         }
         if(this._mcFootprint.parent)
         {
            MAP._BUILDINGFOOTPRINTS.removeChild(this._mcFootprint);
         }
         BASE.BuildingDeselect();
      }
      
      public function Place(param1:MouseEvent = null) : *
      {
         var BragBiggulp:Function;
         var BragTotem:Function;
         var tmpBuildTime:int = 0;
         var fromStorage:int = 0;
         var isInfernoBuilding:Boolean = false;
         var mc:MovieClip = null;
         var totemImgUrl:String = null;
         var e:MouseEvent = param1;
         try
         {
            this.Description();
            if(!MAP._dragged)
            {
               if(BASE.BuildBlockers(this,this._class == "decoration") == "")
               {
                  if(BASE.isInferno())
                  {
                     SOUNDS.Play("inf_buildingplace");
                  }
                  else
                  {
                     SOUNDS.Play("buildingplace");
                  }
                  GLOBAL._newBuilding = null;
                  this._mc.alpha = 1;
                  this._mc.removeEventListener(Event.ENTER_FRAME,this.FollowMouseB);
                  MAP._GROUND.removeEventListener(MouseEvent.MOUSE_UP,this.Place);
                  this._mc.removeEventListener(MouseEvent.MOUSE_DOWN,MAP.Click);
                  if(BASE.CanBuild(this._type,this._buildInstant).error)
                  {
                     this.Cancel();
                     return false;
                  }
                  if(this._buildInstant)
                  {
                     if(!this._buildInstantCost)
                     {
                        this.Cancel();
                        return false;
                     }
                     if(BASE._credits.Get() < this._buildInstantCost.Get())
                     {
                        this.Cancel();
                        POPUPS.DisplayGetShiny();
                        return false;
                     }
                  }
                  this._hasResources = false;
                  this._hasWorker = false;
                  ++BASE._buildingCount;
                  this._id = BASE._buildingCount;
                  tmpBuildTime = int(this._buildingProps.costs[0].time);
                  if(STORE._storeData.BST)
                  {
                     tmpBuildTime -= tmpBuildTime * 0.2;
                  }
                  this._countdownBuild.Set(tmpBuildTime);
                  this._hp.Set(this._buildingProps.hp[0]);
                  this._hpMax.Set(this._hp.Get());
                  this.PlaceB();
                  this._mc.removeChild(this._mcHit);
                  this._mc.addChild(this._mcHit);
                  this.Tick(1);
                  this.Update();
                  this.Description();
                  fromStorage = BASE.BuildingStorageRemove(this._type);
                  if(!fromStorage)
                  {
                     if(!this._buildInstant)
                     {
                        isInfernoBuilding = BASE.isInfernoBuilding(this._type);
                        BASE.Charge(1,this._buildingProps.costs[0].r1,false,isInfernoBuilding);
                        BASE.Charge(2,this._buildingProps.costs[0].r2,false,isInfernoBuilding);
                        BASE.Charge(3,this._buildingProps.costs[0].r3,false,isInfernoBuilding);
                        BASE.Charge(4,this._buildingProps.costs[0].r4,false,isInfernoBuilding);
                        if(STORE._storeItems["BUILDING" + this._type])
                        {
                           BASE.Purchase("BUILDING" + this._type,1,"building");
                        }
                        if(this._buildingProps.costs[0].time != 0 && BASE.BuildingStorageCount(this._type) == 0)
                        {
                           QUEUE.Add("building" + this._id,this);
                        }
                     }
                     else
                     {
                        BASE.Purchase("IB",this._buildInstantCost.Get(),"building");
                        LOGGER.Stat([71,this._buildInstantCost.Get(),this._type]);
                        this.Constructed();
                     }
                  }
                  else
                  {
                     this.Constructed();
                     if(this._type == 2 * 60)
                     {
                        LOGGER.Stat([75,"placedgoldenbiggulp"]);
                     }
                     if(GLOBAL._mode == "build" && BASE._yardType == BASE.MAIN_YARD)
                     {
                        BragBiggulp = function():*
                        {
                           GLOBAL.CallJS("sendFeed",["biggulp-construct",KEYS.Get("pop_biggulpbuilt_streamtitle"),KEYS.Get("pop_biggulpbuilt_streambody"),"dave_711promo.png"]);
                           POPUPS.Next();
                        };
                        BragTotem = function(param1:int):*
                        {
                           var totemType:int = param1;
                           return function(param1:MouseEvent = null):*
                           {
                              loop0:
                              switch(totemType)
                              {
                                 case 121:
                                    GLOBAL.CallJS("sendFeed",["wmitotem-construct",KEYS.Get("wmi_wave1streamtitle"),KEYS.Get("wmi_wave1streamdesc"),"wmitotemfeed1.1.png"]);
                                    break;
                                 case 122:
                                    GLOBAL.CallJS("sendFeed",["wmitotem-construct",KEYS.Get("wmi_wave10streamtitle"),KEYS.Get("wmi_wave10streamdesc"),"wmitotemfeed2.png"]);
                                    break;
                                 case 123:
                                    GLOBAL.CallJS("sendFeed",["wmitotem-construct",KEYS.Get("wmi_wave20streamtitle"),KEYS.Get("wmi_wave20streamdesc"),"wmitotemfeed3.png"]);
                                    break;
                                 case 124:
                                    GLOBAL.CallJS("sendFeed",["wmitotem-construct",KEYS.Get("wmi_wave30streamtitle"),KEYS.Get("wmi_wave30streamdesc"),"wmitotemfeed4.png"]);
                                    break;
                                 case 125:
                                    GLOBAL.CallJS("sendFeed",["wmitotem-construct",KEYS.Get("wmi_wave31streamtitle"),KEYS.Get("wmi_wave31streamdesc"),"wmitotemfeed5.png"]);
                                    break;
                                 case 126:
                                    GLOBAL.CallJS("sendFeed",["wmitotem-construct",KEYS.Get("wmi_wave32streamtitle"),KEYS.Get("wmi_wave32streamdesc"),"wmitotemfeed6.png"]);
                                    break;
                                 case 131:
                                    switch(_lvl.Get())
                                    {
                                       case 1:
                                          GLOBAL.CallJS("sendFeed",["wmi2totem-construct",KEYS.Get("wmi2_wave1streamtitle"),KEYS.Get("wmi2_wave1streamdesc"),"wmitotemfeed2_1.png"]);
                                          break loop0;
                                       case 2:
                                          GLOBAL.CallJS("sendFeed",["wmi2totem-construct",KEYS.Get("wmi2_wave10streamtitle"),KEYS.Get("wmi2_wave10streamdesc"),"wmitotemfeed2_2.png"]);
                                          break loop0;
                                       case 3:
                                          GLOBAL.CallJS("sendFeed",["wmi2totem-construct",KEYS.Get("wmi2_wave20streamtitle"),KEYS.Get("wmi2_wave20streamdesc"),"wmitotemfeed2_3.png"]);
                                          break loop0;
                                       case 4:
                                          GLOBAL.CallJS("sendFeed",["wmi2totem-construct",KEYS.Get("wmi2_wave30streamtitle"),KEYS.Get("wmi2_wave30streamdesc"),"wmitotemfeed2_4.png"]);
                                          break loop0;
                                       case 5:
                                          GLOBAL.CallJS("sendFeed",["wmi2totem-construct",KEYS.Get("wmi2_wave31streamtitle"),KEYS.Get("wmi2_wave31streamdesc"),"wmitotemfeed2_5.png"]);
                                          break loop0;
                                       case 6:
                                          GLOBAL.CallJS("sendFeed",["wmi2totem-construct",KEYS.Get("wmi2_wave32streamtitle"),KEYS.Get("wmi2_wave32streamdesc"),"wmitotemfeed2_6.png"]);
                                    }
                              }
                              POPUPS.Next();
                           };
                        };
                        if(BASE.is711Valid())
                        {
                           if(this._type == 2 * 60)
                           {
                              mc = new popup_biggulp();
                              mc.tA.htmlText = "<b>" + KEYS.Get("pop_biggulpbuilt_title") + "</b>";
                              mc.tB.htmlText = KEYS.Get("pop_biggulpbuilt_body");
                              mc.bPost.SetupKey("btn_brag");
                              mc.bPost.addEventListener(MouseEvent.CLICK,BragBiggulp);
                              mc.bPost.Highlight = true;
                              POPUPS.Push(mc,null,null,null,"building-biggulp.png");
                           }
                        }
                        if(BTOTEM.IsTotem(this._type))
                        {
                           mc = new popup_biggulp();
                           mc.tA.htmlText = "<b>" + KEYS.Get("wmi_totemwon") + "</b>";
                           mc.tB.htmlText = "";
                           mc.bPost.SetupKey("btn_brag");
                           mc.bPost.addEventListener(MouseEvent.CLICK,BragTotem(this._type));
                           mc.bPost.Highlight = true;
                           totemImgUrl = "";
                           switch(this._type)
                           {
                              case 121:
                                 totemImgUrl = "building-wmitotem1.png";
                                 break;
                              case 122:
                                 totemImgUrl = "building-wmitotem2.png";
                                 break;
                              case 123:
                                 totemImgUrl = "building-wmitotem3.png";
                                 break;
                              case 124:
                                 totemImgUrl = "building-wmitotem4.png";
                                 break;
                              case 125:
                                 totemImgUrl = "building-wmitotem5.png";
                                 break;
                              case 126:
                                 totemImgUrl = "building-wmitotem6.png";
                                 break;
                              default:
                                 totemImgUrl = "building-wmitotem6.png";
                           }
                           POPUPS.Push(mc,null,null,null,totemImgUrl);
                        }
                        else if(BTOTEM.IsTotem2(this._type))
                        {
                           mc = new popup_biggulp();
                           mc.tA.htmlText = "<b>" + KEYS.Get("wmi2_totemwon") + "</b>";
                           mc.tB.htmlText = "";
                           mc.bPost.SetupKey("btn_brag");
                           mc.bPost.addEventListener(MouseEvent.CLICK,BragTotem(this._type));
                           mc.bPost.Highlight = true;
                           totemImgUrl = "";
                           switch(this._lvl.Get())
                           {
                              case 1:
                                 totemImgUrl = "building-wmi2totem1.png";
                                 break;
                              case 2:
                                 totemImgUrl = "building-wmi2totem2.png";
                                 break;
                              case 3:
                                 totemImgUrl = "building-wmi2totem3.png";
                                 break;
                              case 4:
                                 totemImgUrl = "building-wmi2totem4.png";
                                 break;
                              case 5:
                                 totemImgUrl = "building-wmi2totem5.png";
                                 break;
                              case 6:
                                 totemImgUrl = "building-wmi2totem6.png";
                                 break;
                              default:
                                 totemImgUrl = "building-wmi2totem6.png";
                           }
                           POPUPS.Push(mc,null,null,null,totemImgUrl);
                        }
                     }
                  }
                  if(BASE._pendingPurchase.length == 0)
                  {
                     BASE.Save();
                  }
                  UPDATES.Create(["BP",this._type,this.Export()]);
                  LOGGER.Stat([5,this._type]);
               }
               else
               {
                  this.Cancel();
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","Foundation.Place: " + e.message + " | " + e.getStackTrace());
         }
      }
      
      public function SetGiftingProps(param1:int, param2:String, param3:int, param4:String, param5:String) : void
      {
         this._threadid = param1;
         this._subject = param2;
         this._senderid = param3;
         this._senderName = param4;
         this._senderPic = param5;
         UPDATES.Create(["BT",this._id,this._threadid,this._subject,this._senderid,this._senderName,this._senderPic]);
      }
      
      public function PlaceB() : *
      {
         this._position = new Point(this._mc.x,this._mc.y);
         this._mc.mouseEnabled = false;
         this._mcBase.mouseEnabled = false;
         this._mcBase.x = this._mc.x;
         this._mcBase.y = this._mc.y;
         this._mc.alpha = 1;
         this._mcFootprint.x = this._mc.x;
         this._mcFootprint.y = this._mc.y;
         if(GLOBAL._mode != "attack" && GLOBAL._mode != "wmattack" || this._senderid == LOGIN._playerID)
         {
            this._mcHit.mouseEnabled = true;
            this._mcHit.buttonMode = true;
            this._mcHit.addEventListener(MouseEvent.MOUSE_DOWN,this.Mousedown);
            this._mcHit.addEventListener(MouseEvent.MOUSE_UP,this.Mouseup);
            this._mcHit.addEventListener(MouseEvent.MOUSE_OVER,this.Over);
            this._mcHit.addEventListener(MouseEvent.MOUSE_OUT,this.Out);
         }
         else
         {
            this._mc.mouseEnabled = false;
            this._mc.mouseChildren = false;
            this._mcHit.mouseEnabled = false;
            this._mcHit.mouseChildren = false;
            this._mcHit.buttonMode = false;
         }
         if(!(this._destroyed && GLOBAL._mode != "build"))
         {
            this.GridCost(true);
         }
         if(this._type == 7)
         {
            BASE._buildingsMushrooms["m" + this._id] = this;
         }
         else
         {
            BASE._buildingsAll["b" + this._id] = this;
            if(this._class == "wall")
            {
               BASE._buildingsWalls["b" + this._id] = this;
            }
            else if(this._class == "trap")
            {
               BASE._buildingsTowers["b" + this._id] = this;
            }
            else if(this._class == "tower")
            {
               BASE._buildingsTowers["b" + this._id] = this;
               BASE._buildingsMain["b" + this._id] = this;
               if(MONSTERBUNKER.isBunkerBuilding(this._type))
               {
                  BASE._buildingsBunkers["b" + this._id] = this;
               }
            }
            else if(this._class == "gift" || this._class == "taunt")
            {
               BASE._buildingsGifts["b" + this._id] = this;
            }
            else if(this._class != "cage")
            {
               BASE._buildingsMain["b" + this._id] = this;
            }
         }
         if(!GLOBAL._catchup)
         {
            BASE.HideFootprints();
         }
         if(this._class != "mushroom")
         {
            BuildingOverlay.Setup(this);
         }
         this.Description();
         this.Update();
         this._placing = false;
         if(this._class != "wall" && this._class != "trap")
         {
            BUILDINGS._buildingID = 0;
         }
         GLOBAL.eventDispatcher.dispatchEvent(new BuildingEvent(BuildingEvent.PLACED_FOR_CONSTRUCTION,this));
      }
      
      public function Destroyed(param1:Boolean = true) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!this._destroyed)
         {
            this._destroyed = true;
            ATTACK.Damage(this._mc.x,this._mc.y,this._buildingProps.hp[this._lvl.Get() - 1]);
            if(this._repairing == 1)
            {
               this._repairing = 0;
               QUEUE.Remove("building" + this._id,true,this);
               ATTACK.Log("b" + this._id,"<font color=\"#FF0000\">" + KEYS.Get("attack_log_downed_repaircancel",{
                  "v1":this._lvl.Get(),
                  "v2":KEYS.Get(this._buildingProps.name)
               }) + "</font>");
            }
            else if(this._countdownBuild.Get() > 0)
            {
               ATTACK.Damage(this._mc.x,this._mc.y,this._buildingProps.hp[this._lvl.Get()]);
               ATTACK.Log("b" + this._id,"<font color=\"#FF0000\">" + KEYS.Get("attack_log_downed_buildcancel",{
                  "v1":this._lvl.Get(),
                  "v2":KEYS.Get(this._buildingProps.name)
               }) + "</font>");
            }
            else if(this._countdownUpgrade.Get())
            {
               ATTACK.Damage(this._mc.x,this._mc.y,this._buildingProps.hp[this._lvl.Get()]);
               _loc2_ = int(this._buildingProps.costs[this._lvl.Get()].time * GLOBAL._buildTime);
               _loc3_ = (_loc2_ - this._countdownUpgrade.Get()) * 0.5;
               if(_loc3_ > 28800)
               {
                  _loc3_ = 0x7080;
               }
               _loc4_ = this._countdownUpgrade.Get() + _loc3_;
               if(_loc4_ < 0)
               {
                  _loc4_ = 0;
               }
               ATTACK.Log("b" + this._id,"<font color=\"#FF0000\">" + KEYS.Get("attack_log_downed_upgradecancel",{
                  "v1":this._lvl.Get(),
                  "v2":KEYS.Get(this._buildingProps.name),
                  "v3":this._lvl.Get() + 1
               }) + "</font>");
               this._countdownUpgrade.Set(_loc4_);
            }
            else
            {
               ATTACK.Log("b" + this._id,"<font color=\"#FF0000\">" + KEYS.Get("attack_log_downed",{
                  "v1":this._lvl.Get(),
                  "v2":KEYS.Get(this._buildingProps.name)
               }) + "</font>");
            }
            this.Update(true);
            this.GridCost(false);
            PATHING.ResetCosts();
            BASE.Save();
         }
      }
      
      public function Repair() : *
      {
         this._repairing = 1;
         this._destroyed = false;
         this.Update();
         BASE.Save();
      }
      
      public function Repaired() : *
      {
         if(!GLOBAL._catchup && this._hp.Get() < this._hpMax.Get())
         {
            LOGGER.Log("log","Building repair hack");
            GLOBAL.ErrorMessage("Building repair hack");
            return;
         }
         this._repairing = 0;
         this._hp.Set(this._hpMax.Get());
         if(this._type == 15 || this._type == 128)
         {
            if(BASE._buildingsHousing.indexOf(this) < 0)
            {
               HOUSING.AddHouse(this);
            }
            HOUSING.HousingSpace();
         }
         this.Description();
         UI2.Update();
      }
      
      public function HasWorker() : *
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         this._hasWorker = true;
         if(this._countdownBuild.Get() + this._countdownUpgrade.Get() + this._countdownFortify.Get() > 0)
         {
            _loc1_ = BASE.isInfernoBuilding(this._type) || BASE.isInferno() ? 5 : 1;
            _loc2_ = 1;
            while(_loc2_ < 5)
            {
               _loc3_ = uint(this._buildingProps.costs[this._lvl.Get()]["r" + _loc2_]);
               if(_loc3_)
               {
                  ResourcePackages.Create(_loc1_,this,_loc3_,true);
               }
               _loc1_++;
               _loc2_++;
            }
         }
      }
      
      public function Over(param1:MouseEvent) : *
      {
      }
      
      public function Out(param1:MouseEvent) : *
      {
      }
      
      public function FinishNowCost() : int
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         if(this._countdownBuild.Get() > 0)
         {
            _loc2_ = this._countdownBuild.Get();
         }
         if(this._countdownUpgrade.Get() > 0)
         {
            _loc2_ = this._countdownUpgrade.Get();
         }
         if(this._countdownFortify.Get() > 0)
         {
            _loc2_ = this._countdownFortify.Get();
         }
         if(_loc2_ <= 5 * 60)
         {
            return 0;
         }
         _loc3_ = Math.ceil(_loc2_ * 20 / 60 / 60);
         _loc4_ = int(Math.sqrt(_loc2_ * 0.8));
         return Math.min(_loc3_,_loc4_);
      }
      
      public function InstantBuildCost() : int
      {
         var _loc1_:Object = GLOBAL._buildingProps[this._type - 1].costs[0];
         var _loc2_:int = int(_loc1_.time);
         if(_loc2_ <= 5 * 60)
         {
            _loc2_ = 0;
         }
         var _loc3_:int = _loc1_.r1 + _loc1_.r2 + _loc1_.r3;
         var _loc4_:int = Math.ceil(Math.pow(Math.sqrt(_loc3_ / 2),0.75));
         var _loc5_:int = STORE.GetTimeCost(_loc2_);
         var _loc6_:int = _loc4_ + _loc5_;
         _loc6_ = int(_loc6_ * 0.95);
         if(_loc6_ <= 5)
         {
            _loc6_ = 5;
         }
         return _loc6_;
      }
      
      public function InstantFortifyCost() : int
      {
         if(this._buildingProps.fortify_costs.length <= this._fortification.Get())
         {
            return 0;
         }
         var _loc1_:Object = this._buildingProps.fortify_costs[this._fortification.Get()];
         var _loc2_:int = int(_loc1_.time);
         if(_loc2_ <= 5 * 60)
         {
            _loc2_ = 0;
         }
         var _loc3_:int = _loc1_.r1 + _loc1_.r2 + _loc1_.r3;
         var _loc4_:int = Math.ceil(Math.pow(Math.sqrt(_loc3_ / 2),0.75));
         var _loc5_:int = STORE.GetTimeCost(_loc2_);
         var _loc6_:int = _loc4_ + _loc5_;
         return int(_loc6_ * 0.95);
      }
      
      public function InstantUpgradeCost() : int
      {
         if(this._buildingProps.costs.length <= this._lvl.Get())
         {
            return 0;
         }
         var _loc1_:Object = this._buildingProps.costs[this._lvl.Get()];
         var _loc2_:int = int(_loc1_.time);
         if(_loc2_ <= 5 * 60)
         {
            _loc2_ = 0;
         }
         var _loc3_:int = _loc1_.r1 + _loc1_.r2 + _loc1_.r3;
         var _loc4_:int = Math.ceil(Math.pow(Math.sqrt(_loc3_ / 2),0.75));
         var _loc5_:int = STORE.GetTimeCost(_loc2_);
         var _loc6_:int = _loc4_ + _loc5_;
         return int(_loc6_ * 0.95);
      }
      
      public function DoInstantUpgrade() : Boolean
      {
         var _loc1_:int = this.InstantUpgradeCost();
         if(BASE._credits.Get() >= _loc1_)
         {
            this.Upgraded();
            BASE.Purchase("IU",_loc1_,"upgrade");
            LOGGER.Stat([72,_loc1_,this._type,this._lvl.Get()]);
            return true;
         }
         POPUPS.DisplayGetShiny();
         return false;
      }
      
      public function DoInstantFortify() : Boolean
      {
         var _loc1_:int = this.InstantFortifyCost();
         if(BASE._credits.Get() >= _loc1_)
         {
            this.Fortified();
            BASE.Purchase("IF",_loc1_,"fortify");
            return true;
         }
         POPUPS.DisplayGetShiny();
         return false;
      }
      
      public function Fortify() : *
      {
         var _loc1_:Object = null;
         if(!QUEUE.CanDo().error)
         {
            _loc1_ = BASE.CanFortify(this);
            if(!_loc1_.error)
            {
               if(int(this._buildingProps.fortify_costs[this._fortification.Get()].time * GLOBAL._buildTime) > 60 * 60)
               {
                  UPDATES.Create(["BF",this._id]);
               }
               this.FortifyB();
               BASE.Save();
               return true;
            }
            if(GLOBAL._mode == "build")
            {
               GLOBAL.Message(_loc1_.errorMessage);
            }
         }
         else if(GLOBAL._mode == "build")
         {
            POPUPS.DisplayWorker(3,this);
         }
         return false;
      }
      
      public function FortifyB() : *
      {
         var _loc1_:Object = null;
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         if(this._countdownFortify.Get() == 0)
         {
            _loc1_ = BASE.CanFortify(this);
            if(!_loc1_.error)
            {
               _loc2_ = this.FortifyCost();
               if(_loc2_.r1 > 0)
               {
                  BASE.Charge(1,_loc2_.r1);
               }
               if(_loc2_.r2 > 0)
               {
                  BASE.Charge(2,_loc2_.r2);
               }
               if(_loc2_.r3 > 0)
               {
                  BASE.Charge(3,_loc2_.r3);
               }
               if(_loc2_.r4 > 0)
               {
                  BASE.Charge(4,_loc2_.r4);
               }
               _loc3_ = int(this._buildingProps.fortify_costs[this._fortification.Get()].time * GLOBAL._buildTime);
               this._countdownFortify.Set(_loc3_);
               this._hasResources = false;
               this._hasWorker = false;
               if(GLOBAL._catchup)
               {
                  this._hasResources = true;
                  this._hasWorker = true;
               }
               QUEUE.Add("building" + this._id,this);
               LOGGER.Stat([64,this._type,this._fortification.Get() + 1]);
               this._helpList = [];
               this.Update();
               if(GLOBAL._mode == "build" && this._class == "tower")
               {
                  GLOBAL._selectedBuilding = this;
                  GLOBAL.Message(KEYS.Get("msg_inactivefortify"),KEYS.Get("btn_speedup"),STORE.SpeedUp,["SP4"]);
               }
            }
            else if(GLOBAL._mode == "build")
            {
               GLOBAL.Message(_loc1_.errorMessage);
            }
         }
      }
      
      public function FortifyCancel() : *
      {
         GLOBAL.Message(KEYS.Get("msg_fortifycancelconfirm"),KEYS.Get("msg_stopfortifying_btn"),this.FortifyCancelB);
      }
      
      public function FortifyCancelB(param1:MouseEvent = null) : *
      {
         UPDATES.Create(["BFC",this._id]);
         this.FortifyCancelC();
      }
      
      public function FortifyCancelC() : *
      {
         var _loc1_:Object = null;
         if(this._countdownFortify.Get() > 0)
         {
            QUEUE.Remove("building" + this._id,false,this);
            this._countdownFortify.Set(0);
            _loc1_ = this.FortifyCost();
            if(_loc1_.r1 > 0)
            {
               BASE.Fund(1,int(_loc1_.r1));
            }
            if(_loc1_.r2 > 0)
            {
               BASE.Fund(2,int(_loc1_.r2));
            }
            if(_loc1_.r3 > 0)
            {
               BASE.Fund(3,int(_loc1_.r3));
            }
            if(_loc1_.r4 > 0)
            {
               BASE.Fund(4,int(_loc1_.r4));
            }
            BASE.Save();
         }
      }
      
      public function Upgrade() : *
      {
         var _loc1_:Object = null;
         if(!QUEUE.CanDo().error)
         {
            _loc1_ = BASE.CanUpgrade(this);
            if(!_loc1_.error)
            {
               if(int(this._buildingProps.costs[this._lvl.Get()].time * GLOBAL._buildTime) > 60 * 60)
               {
                  UPDATES.Create(["BU",this._id]);
               }
               this.UpgradeB();
               BASE.Save();
               return true;
            }
            if(GLOBAL._mode == "build")
            {
               GLOBAL.Message(_loc1_.errorMessage);
            }
         }
         else if(GLOBAL._mode == "build")
         {
            POPUPS.DisplayWorker(1,this);
         }
         return false;
      }
      
      public function UpgradeB() : *
      {
         var GetFriends:Function;
         var canUpgrade:Object = null;
         var o:* = undefined;
         var isInfernoBuilding:Boolean = false;
         var tmpUpgradeTime:int = 0;
         var popupMC:* = undefined;
         if(this._countdownUpgrade.Get() == 0)
         {
            canUpgrade = BASE.CanUpgrade(this);
            if(!canUpgrade.error)
            {
               o = this.UpgradeCost();
               isInfernoBuilding = BASE.isInfernoBuilding(this._type);
               if(o.r1 > 0)
               {
                  BASE.Charge(1,o.r1,false,isInfernoBuilding);
               }
               if(o.r2 > 0)
               {
                  BASE.Charge(2,o.r2,false,isInfernoBuilding);
               }
               if(o.r3 > 0)
               {
                  BASE.Charge(3,o.r3,false,isInfernoBuilding);
               }
               if(o.r4 > 0)
               {
                  BASE.Charge(4,o.r4,false,isInfernoBuilding);
               }
               tmpUpgradeTime = int(this._buildingProps.costs[this._lvl.Get()].time * GLOBAL._buildTime);
               this._countdownUpgrade.Set(tmpUpgradeTime);
               if(this._type != 14 && this._countdownUpgrade.Get() > 7200 && TUTORIAL._stage > 200)
               {
                  if(!GLOBAL._promptedInvite && BASE._credits.Get() < 40 && GLOBAL._canInvite && GLOBAL._friendCount == 0)
                  {
                     GetFriends = function():*
                     {
                        GLOBAL.CallJS("cc.showFeedDialog",["invite","callbackgift"]);
                     };
                     GLOBAL._promptedInvite = true;
                     popupMC = new popup_helpme();
                     popupMC.tB.text = KEYS.Get("pop_helpme");
                     popupMC.bAction.SetupKey("btn_invitefriends");
                     popupMC.bAction.addEventListener(MouseEvent.CLICK,GetFriends);
                     POPUPS.Push(popupMC);
                  }
               }
               this._hasResources = false;
               this._hasWorker = false;
               if(GLOBAL._catchup)
               {
                  this._hasResources = true;
                  this._hasWorker = true;
               }
               QUEUE.Add("building" + this._id,this);
               LOGGER.Stat([7,this._type,this._lvl.Get() + 1]);
               this._helpList = [];
               this.Update();
               if(GLOBAL._mode == "build" && this._class == "tower")
               {
                  GLOBAL._selectedBuilding = this;
                  GLOBAL.Message(KEYS.Get("msg_inactiveupgrade"),KEYS.Get("btn_speedup"),STORE.SpeedUp,["SP4"]);
               }
               GLOBAL.eventDispatcher.dispatchEvent(new BuildingEvent(BuildingEvent.UPGRADED,this));
            }
            else if(GLOBAL._mode == "build")
            {
               GLOBAL.Message(canUpgrade.errorMessage);
            }
         }
      }
      
      public function Help() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(this._countdownBuild.Get() + this._countdownUpgrade.Get() + this._countdownFortify.Get() > 0)
         {
            if(this._helpList.length > 4)
            {
               GLOBAL.Message(KEYS.Get("base_5alreadyhelped"));
               return false;
            }
            for each(_loc1_ in this._helpList)
            {
               if(_loc1_ == LOGIN._playerID)
               {
                  GLOBAL.Message(KEYS.Get("base_alreadyhelped"));
                  return false;
               }
            }
            UPDATES.Create(["BH",this._id,LOGIN._playerID]);
            this._helpList.push(LOGIN._playerID);
            _loc2_ = this.HelpB();
            if(this._countdownBuild.Get() > 0)
            {
               GLOBAL.Message(KEYS.Get("base_thankbuild",{
                  "v1":GLOBAL.ToTime(_loc2_,false,false),
                  "v2":KEYS.Get(this._buildingProps.name)
               }));
               LOGGER.Stat([14,this._type,0,0,_loc2_]);
               _loc3_ = "build";
            }
            if(this._countdownUpgrade.Get() > 0)
            {
               GLOBAL.Message(KEYS.Get("base_thankupgrade",{
                  "v1":GLOBAL.ToTime(_loc2_,false,false),
                  "v2":KEYS.Get(this._buildingProps.name)
               }));
               LOGGER.Stat([15,this._type,this._lvl.Get() + 1,0,_loc2_]);
               _loc3_ = "upgrade";
            }
            if(this._countdownFortify.Get() > 0)
            {
               GLOBAL.Message(KEYS.Get("base_thankfortify",{
                  "v1":GLOBAL.ToTime(_loc2_,false,false),
                  "v2":KEYS.Get(this._buildingProps.name)
               }));
               LOGGER.Stat([66,this._type,this._fortification.Get() + 1,0,_loc2_]);
               _loc3_ = "fortify";
            }
         }
      }
      
      public function HelpB() : int
      {
         var _loc1_:int = 0;
         if(this._countdownBuild.Get() > 0)
         {
            _loc1_ = int(this._countdownBuild.Get() * 0.05);
            this._countdownBuild.Add(0 - int(this._countdownBuild.Get() * 0.05));
         }
         else if(this._countdownUpgrade.Get() > 0)
         {
            _loc1_ = int(this._countdownUpgrade.Get() * 0.05);
            this._countdownUpgrade.Add(0 - int(this._countdownUpgrade.Get() * 0.05));
         }
         else if(this._countdownFortify.Get() > 0)
         {
            _loc1_ = int(this._countdownFortify.Get() * 0.05);
            this._countdownFortify.Add(0 - int(this._countdownFortify.Get() * 0.05));
         }
         BASE.Save();
         return _loc1_;
      }
      
      public function UpgradeCancel() : *
      {
         GLOBAL.Message(KEYS.Get("msg_upgradecancelconfirm"),KEYS.Get("msg_stopupgrading_btn"),this.UpgradeCancelB);
      }
      
      public function UpgradeCancelB(param1:MouseEvent = null) : *
      {
         UPDATES.Create(["BUC",this._id]);
         this.UpgradeCancelC();
      }
      
      public function UpgradeCancelC() : *
      {
         var _loc1_:Object = null;
         var _loc2_:Boolean = false;
         if(this._countdownUpgrade.Get() > 0)
         {
            QUEUE.Remove("building" + this._id,false,this);
            this._countdownUpgrade.Set(0);
            _loc1_ = this.UpgradeCost();
            _loc2_ = BASE.isInfernoBuilding(this._type);
            if(_loc1_.r1)
            {
               BASE.Fund(1,int(_loc1_.r1),false,null,_loc2_);
            }
            if(_loc1_.r2)
            {
               BASE.Fund(2,int(_loc1_.r2),false,null,_loc2_);
            }
            if(_loc1_.r3)
            {
               BASE.Fund(3,int(_loc1_.r3),false,null,_loc2_);
            }
            if(_loc1_.r4)
            {
               BASE.Fund(4,int(_loc1_.r4),false,null,_loc2_);
            }
            BASE.Save();
         }
      }
      
      public function Upgraded() : *
      {
         var c:Object;
         var a:int;
         try
         {
            if(Math.max(this._countdownUpgrade.Get(),0))
            {
               LOGGER.Log("log","bdg up cnt > 0, probable hack");
               GLOBAL.ErrorMessage("BFOUNDATION upgrade hack");
               return;
            }
            this._countdownUpgrade.Set(0);
            this._lvl.Add(1);
            ++this._hpLvl;
            this._hpMax.Set(this._buildingProps.hp[this._lvl.Get() - 1]);
            this._hp.Set(this._hpMax.Get());
         }
         catch(e:Error)
         {
            LOGGER.Log("err","Foundation.Upgraded: " + e.message + " | " + e.getStackTrace());
         }
         QUESTS.Check("blvl",this._lvl.Get());
         if(this._type < 5)
         {
            QUESTS.Check("brlvl",this._lvl.Get());
         }
         QUESTS.Check("b" + this._type + "lvl",this._lvl.Get());
         BASE.CalcResources();
         c = this._buildingProps.costs[this._lvl.Get() - 2];
         a = Math.floor((int(c.time) + int(c.r1) + int(c.r2) + int(c.r3) + int(c.r4)) / 3);
         BASE.PointsAdd(a);
         this.Description();
         QUEUE.Remove("building" + this._id,true,this);
         LOGGER.Stat([8,this._type,this._lvl.Get()]);
      }
      
      public function Downgrade_TOTEM_DEBUG() : *
      {
         if(this._type != BTOTEM.BTOTEM_BUILDING_TYPE)
         {
            return;
         }
         if(this._lvl.Get() <= 1)
         {
            return;
         }
         try
         {
            this._countdownUpgrade.Set(0);
            this._lvl.Add(-1);
            --this._hpLvl;
            this._hpMax.Set(this._buildingProps.hp[this._lvl.Get() - 1]);
            this._hp.Set(this._hpMax.Get());
         }
         catch(e:Error)
         {
            LOGGER.Log("err","Foundation.Downgrade_TOTEM_DEBUG: " + e.message + " | " + e.getStackTrace());
         }
      }
      
      public function Fortified() : *
      {
         var c:Object;
         var a:int;
         try
         {
            if(Math.max(this._countdownFortify.Get(),0))
            {
               LOGGER.Log("log","bdg fort cnt > 0, probable hack");
               GLOBAL.ErrorMessage("BFOUNDATION fortify hack");
               return;
            }
            this._countdownFortify.Set(0);
            this._fortification.Add(1);
         }
         catch(e:Error)
         {
            LOGGER.Log("err","Foundation.Fortified: " + e.message + " | " + e.getStackTrace());
         }
         BASE.CalcResources();
         c = this._buildingProps.fortify_costs[this._fortification.Get() - 1];
         a = Math.floor((int(c.time) + int(c.r1) + int(c.r2) + int(c.r3) + int(c.r4)) / 3);
         BASE.PointsAdd(a);
         this.Description();
         QUEUE.Remove("building" + this._id,true,this);
         LOGGER.Stat([65,this._type,this._fortification.Get()]);
      }
      
      public function Recycle() : *
      {
         if(this._countdownBuild.Get() > 0)
         {
            if(GLOBAL._mode == "build")
            {
               if(BASE._yardType == BASE.OUTPOST || BASE._yardType == BASE.INFERNO_OUTPOST)
               {
                  GLOBAL.Message(KEYS.Get("msg_stopconstructionoutpostbuilding"));
               }
               else
               {
                  GLOBAL.Message(KEYS.Get("msg_stopconstructionconfirm"),KEYS.Get("msg_destroybuilding_btn"),this.RecycleB);
               }
            }
         }
         else if(this._class == "taunt" || this._class == "gift")
         {
            if(GLOBAL._mode == "build")
            {
               GLOBAL.Message(KEYS.Get("msg_recycleconfirm"),KEYS.Get("msg_recyclebuilding_btn"),this.RecycleC);
            }
         }
         else if(this._class == "decoration")
         {
            if(GLOBAL._mode == "build")
            {
               GLOBAL.Message(KEYS.Get("ui_placeinstorage"),KEYS.Get("btn_addstorage"),this.RecycleB);
            }
         }
         else if(!this._blockRecycle)
         {
            if(GLOBAL._mode == "build")
            {
               GLOBAL.Message(KEYS.Get("msg_recycleconfirm"),KEYS.Get("msg_recyclebuilding_btn"),this.RecycleB);
            }
         }
         else if(GLOBAL._mode == "build")
         {
            if(BASE._yardType == BASE.OUTPOST || BASE._yardType == BASE.INFERNO_OUTPOST)
            {
               GLOBAL.Message(KEYS.Get("msg_recycleoutpostbuilding"));
            }
            else
            {
               GLOBAL.Message(KEYS.Get("msg_recycleunavailable"));
            }
         }
         GLOBAL.eventDispatcher.dispatchEvent(new BuildingEvent(BuildingEvent.ATTEMPT_RECYCLE,this));
      }
      
      public function RecycleB(param1:MouseEvent = null) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Boolean = false;
         BUILDINGOPTIONS.Hide();
         if(this._class != "decoration" && !this._blockRecycle)
         {
            if(!this._recycled)
            {
               this._recycled = true;
               _loc2_ = this.RecycleCost();
               _loc3_ = BASE.isInfernoBuilding(this._type);
               if(_loc2_.r1)
               {
                  BASE.Fund(1,int(_loc2_.r1),false,null,_loc3_);
               }
               if(_loc2_.r2)
               {
                  BASE.Fund(2,int(_loc2_.r2),false,null,_loc3_);
               }
               if(_loc2_.r3)
               {
                  BASE.Fund(3,int(_loc2_.r3),false,null,_loc3_);
               }
               if(_loc2_.r4)
               {
                  BASE.Fund(4,int(_loc2_.r4),false,null,_loc3_);
               }
               this.RecycleC();
               LOGGER.Stat([40,this._type,this._lvl.Get()]);
            }
         }
         else if(!this._blockRecycle)
         {
            this.RecycleC();
         }
      }
      
      public function RecycleC() : *
      {
         this.GridCost(false);
         try
         {
            MAP._BUILDINGBASES.removeChild(this._mcBase);
         }
         catch(e:Error)
         {
         }
         try
         {
            MAP._BUILDINGFOOTPRINTS.removeChild(this._mcFootprint);
         }
         catch(e:Error)
         {
         }
         try
         {
            MAP._BUILDINGTOPS.removeChild(this._mc);
         }
         catch(e:Error)
         {
         }
         GRID.Clear();
         MAP.SortDepth();
         QUEUE.Remove("building" + this._id,false,this);
         BASE.BuildingDeselect();
         if(this._class == "decoration")
         {
            BASE.BuildingStorageAdd(this._type,this._lvl.Get());
         }
         this.Clean();
         BASE.Save();
         return true;
      }
      
      public function GridCost(param1:Boolean = true) : *
      {
         var _loc2_:Rectangle = null;
         if(this._footprint)
         {
            for each(_loc2_ in this._footprint)
            {
               GRID.Block(new Rectangle(_loc2_.x + this._mc.x,_loc2_.y + this._mc.y,_loc2_.width,_loc2_.height),param1);
            }
         }
      }
      
      public function RecycleCost() : *
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc1_:* = {
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "r5":0
         };
         if(GLOBAL._buildingProps[this._type - 1].rewarded)
         {
            return _loc1_;
         }
         if(this._lvl.Get() == 0)
         {
            _loc1_.r1 += this._buildingProps.costs[0].r1;
            _loc1_.r2 += this._buildingProps.costs[0].r2;
            _loc1_.r3 += this._buildingProps.costs[0].r3;
            _loc1_.r4 += this._buildingProps.costs[0].r4;
            _loc1_.r5 += this._buildingProps.costs[0].r5;
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < this._lvl.Get())
            {
               _loc3_ = this._buildingProps.costs[_loc2_];
               if(_loc3_)
               {
                  _loc1_.r1 += _loc3_.r1;
                  _loc1_.r2 += _loc3_.r2;
                  _loc1_.r3 += _loc3_.r3;
                  _loc1_.r4 += _loc3_.r4;
                  _loc1_.r5 += _loc3_.r5;
               }
               _loc2_++;
            }
            _loc1_.r1 = int(_loc1_.r1 * 0.5);
            _loc1_.r2 = int(_loc1_.r2 * 0.5);
            _loc1_.r3 = int(_loc1_.r3 * 0.5);
            _loc1_.r4 = int(_loc1_.r4 * 0.5);
            _loc1_.r5 = int(_loc1_.r5 * 0.5);
         }
         return _loc1_;
      }
      
      public function UpgradeCost() : Object
      {
         var _loc1_:* = undefined;
         var _loc2_:Object = null;
         if(this._buildingProps.costs.length > this._lvl.Get())
         {
            _loc1_ = {
               "time":"0",
               "r1":this._buildingProps.costs[this._lvl.Get()].r1,
               "r2":this._buildingProps.costs[this._lvl.Get()].r2,
               "r3":this._buildingProps.costs[this._lvl.Get()].r3,
               "r4":this._buildingProps.costs[this._lvl.Get()].r4,
               "r1over":false,
               "r2over":false,
               "r3over":false,
               "r4over":false
            };
            _loc2_ = this._buildingProps.costs[this._lvl.Get()];
            if(BASE._resources.r1.Get() < _loc2_.r1)
            {
               _loc1_.r1over = true;
            }
            if(BASE._resources.r2.Get() < _loc2_.r2)
            {
               _loc1_.r2over = true;
            }
            if(BASE._resources.r3.Get() < _loc2_.r3)
            {
               _loc1_.r3over = true;
            }
            if(BASE._resources.r4.Get() < _loc2_.r4)
            {
               _loc1_.r4over = true;
            }
            _loc1_.time = _loc2_.time;
            return _loc1_;
         }
         return {};
      }
      
      public function FortifyCost() : Object
      {
         var _loc1_:* = undefined;
         var _loc2_:Object = null;
         if(this._buildingProps.can_fortify != true)
         {
            return {};
         }
         if(this._buildingProps.fortify_costs.length > this._fortification.Get())
         {
            _loc1_ = {
               "time":"0",
               "r1":this._buildingProps.fortify_costs[this._fortification.Get()].r1,
               "r2":this._buildingProps.fortify_costs[this._fortification.Get()].r2,
               "r3":this._buildingProps.fortify_costs[this._fortification.Get()].r3,
               "r4":this._buildingProps.fortify_costs[this._fortification.Get()].r4,
               "r1over":false,
               "r2over":false,
               "r3over":false,
               "r4over":false
            };
            _loc2_ = this._buildingProps.fortify_costs[this._fortification.Get()];
            if(BASE._resources.r1.Get() < _loc2_.r1)
            {
               _loc1_.r1over = true;
            }
            if(BASE._resources.r2.Get() < _loc2_.r2)
            {
               _loc1_.r2over = true;
            }
            if(BASE._resources.r3.Get() < _loc2_.r3)
            {
               _loc1_.r3over = true;
            }
            if(BASE._resources.r4.Get() < _loc2_.r4)
            {
               _loc1_.r4over = true;
            }
            _loc1_.time = _loc2_.time;
            return _loc1_;
         }
         return {};
      }
      
      internal function Mousedown(param1:MouseEvent) : *
      {
         if(!this._placing)
         {
            MAP.Click();
            this._mouseClicked = true;
            if(GLOBAL._mode == "build" && UI2._showBottom)
            {
               this._clickTimer = 0;
            }
         }
      }
      
      internal function Mouseup(param1:MouseEvent) : *
      {
         if(this._mouseClicked)
         {
            this._mouseClicked = false;
            if(!MAP._dragged)
            {
               if(this._countdownBuild.Get() + this._countdownUpgrade.Get() + this._countdownFortify.Get() > 0)
               {
               }
               this.Click();
            }
         }
      }
      
      public function StartMove() : *
      {
         try
         {
            BASE._blockSave = true;
            BASE.BuildingSelect(this,true);
            this.GridCost(false);
            this._moving = true;
            this._stopMoveCount = 0;
            this._mc.mouseEnabled = false;
            if(!PLANNER._open)
            {
               this._mc.addEventListener(Event.ENTER_FRAME,this.FollowMouseB);
               MAP._GROUND.addEventListener(MouseEvent.MOUSE_UP,this.StopMove);
               this._mcHit.mouseEnabled = false;
               BASE.ShowFootprints();
            }
            this._oldPosition = new Point(this._mc.x,this._mc.y);
            this._mouseOffset = new Point(MAP._GROUND.mouseX - this._mc.x,MAP._GROUND.mouseY - this._mc.y);
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.StartMove: " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.StartMove");
         }
      }
      
      public function StopMove(param1:MouseEvent) : *
      {
         if(this._mouseClicked)
         {
            this._mouseClicked = false;
            if(!MAP._dragged)
            {
               MAP._GROUND.removeEventListener(MouseEvent.MOUSE_UP,this.StopMove);
               this._mc.mouseEnabled = true;
               this.StopMoveB();
            }
         }
         this._mouseClicked = true;
      }
      
      public function StopMoveB() : *
      {
         try
         {
            if(this._moving)
            {
               this._moving = false;
               if(BASE.BuildBlockers(this,this._class == "decoration") != "")
               {
                  this._mc.x = this._oldPosition.x;
                  this._mc.y = this._oldPosition.y;
                  this._mcBase.x = this._mc.x;
                  this._mcBase.y = this._mc.y;
                  this._mcFootprint.x = this._mc.x;
                  this._mcFootprint.y = this._mc.y;
                  SOUNDS.Play("error1");
               }
               else
               {
                  SOUNDS.Play("buildingplace");
               }
               this._position = new Point(this._mc.x,this._mc.y);
               this._mc.mouseEnabled = false;
               this._mcHit.mouseEnabled = true;
               this._mc.removeEventListener(Event.ENTER_FRAME,this.FollowMouseB);
               this.GridCost(true);
               PATHING.ResetCosts();
               this._mcFootprint.gotoAndStop(1);
               MAP.SortDepth(false,true);
               BASE.BuildingDeselect();
               BASE.HideFootprints();
               BASE._blockSave = false;
               BASE.Save();
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BFOUNDATION.StartMove: " + e.getStackTrace());
            GLOBAL.ErrorMessage("BFOUNDATION.StartMove 2");
         }
      }
      
      public function Click(param1:MouseEvent = null) : *
      {
         if(Boolean(GLOBAL._openBase) || TUTORIAL._stage >= 2 && TUTORIAL._stage != 90)
         {
            this.Description();
            if(!MAP._dragged)
            {
               if(GLOBAL._mode == "build")
               {
                  BASE.BuildingSelect(this);
               }
               if(GLOBAL._mode == "help" && this._countdownBuild.Get() + this._countdownUpgrade.Get() + this._countdownFortify.Get() > 0)
               {
                  BASE.BuildingSelect(this);
               }
               if(this._class == "taunt" || this._class == "gift")
               {
                  BASE.BuildingSelect(this);
               }
            }
         }
      }
      
      public function Update(param1:Boolean = false) : *
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(GLOBAL._render || param1)
         {
            _loc4_ = [];
            if(this._repairing == 1)
            {
               _loc5_ = 0;
               _loc6_ = this._lvl.Get() == 0 ? 0 : int(this._lvl.Get() - 1);
               _loc5_ = Math.ceil(this._hpMax.Get() / Math.min(60 * 60,this._buildingProps.repairTime[_loc6_]));
               this._repairTime = int(this._hpMax.Get() - this._hp.Get()) / _loc5_;
               QUEUE.Update("building" + this._id,KEYS.Get("ui_worker_stacktitle_repairing"),GLOBAL.ToTime(this._repairTime,true));
            }
            else if(this._countdownBuild.Get() > 0)
            {
               QUEUE.Update("building" + this._id,KEYS.Get("ui_worker_stacktitle_building"),GLOBAL.ToTime(this._countdownBuild.Get(),true));
            }
            else if(this._countdownUpgrade.Get() > 0)
            {
               QUEUE.Update("building" + this._id,KEYS.Get("ui_worker_stacktitle_upgrading"),GLOBAL.ToTime(this._countdownUpgrade.Get(),true));
            }
            else if(this._countdownFortify.Get() > 0)
            {
               QUEUE.Update("building" + this._id,KEYS.Get("ui_worker_stacktitle_fortifying"),GLOBAL.ToTime(this._countdownFortify.Get(),true));
            }
            if(this._class != "mushroom")
            {
               BuildingOverlay.Update(this,param1);
            }
            if(this._hp.Get() <= 0)
            {
               this.Render("destroyed");
            }
            else if(this._hp.Get() < this._hpMax.Get() * 0.5)
            {
               this.Render("damaged");
            }
            else
            {
               this.Render("");
            }
         }
      }
      
      public function Damage(param1:int, param2:int, param3:int, param4:int = 1, param5:Boolean = true, param6:SecNum = null) : void
      {
         var _loc7_:int = param1;
         if(this._fortification.Get() > 0)
         {
            _loc7_ *= 100 - (this._fortification.Get() * 10 + 10);
            _loc7_ = _loc7_ / 100;
         }
         this._hp.Add(-_loc7_);
         if(this._hp.Get() <= 0)
         {
            this._hp.Set(0);
            if(!this._destroyed)
            {
               this.Destroyed(param5);
            }
         }
         else if(this._class != "wall")
         {
            ATTACK.Log("b" + this._id,"<font color=\"#990000\">" + KEYS.Get("attack_log_%damaged",{
               "v1":this._lvl.Get(),
               "v2":KEYS.Get(this._buildingProps.name),
               "v3":100 - int(100 / this._hpMax.Get() * this._hp.Get())
            }) + "</font>");
         }
         this.Update();
         BASE.Save();
      }
      
      public function Loot(param1:int) : void
      {
      }
      
      public function Constructed() : *
      {
         if(BASE._yardType == BASE.OUTPOST || BASE._yardType == BASE.INFERNO_OUTPOST)
         {
            this._blockRecycle = true;
         }
         this._countdownBuild.Set(0);
         this._constructed = true;
         if(!this._prefab && !BTOTEM.IsTotem2(this._type))
         {
            this._lvl.Set(1);
            this._hpLvl = 1;
         }
         else
         {
            this._prefab = 0;
         }
         BASE.CalcResources();
         QUESTS.Check("blvl",this._lvl.Get());
         QUESTS.Check("b" + this._type + "lvl",this._lvl.Get());
         if(this._type < 5)
         {
            QUESTS.Check("brlvl",this._lvl.Get());
         }
         var _loc1_:Object = this._buildingProps.costs[0];
         var _loc2_:int = Math.floor(_loc1_.time / 2 + (int(_loc1_.r1) + int(_loc1_.r2) + int(_loc1_.r3) + int(_loc1_.r4)) / 10);
         if(this._type == 14)
         {
            _loc2_ += 100;
         }
         BASE.PointsAdd(_loc2_);
         this.Description();
         QUEUE.Remove("building" + this._id,true,this);
         LOGGER.Stat([6,this._type]);
         this.Update();
      }
      
      public function BlockClicks() : *
      {
         this._mcHit.mouseEnabled = false;
         this._mcHit.buttonMode = false;
         this._mc.alpha = 0.5;
      }
      
      public function UnblockClicks() : *
      {
         this._mcHit.mouseEnabled = true;
         this._mcHit.buttonMode = true;
         this._mc.alpha = 1;
      }
      
      public function Export() : *
      {
         var _loc1_:Object = new Object();
         var _loc2_:Point = GRID.FromISO(this._mc.x,this._mc.y);
         _loc1_.X = _loc2_.x;
         _loc1_.Y = _loc2_.y;
         _loc1_.id = this._id;
         _loc1_.t = this._type;
         if(this._lvl.Get() != 1)
         {
            _loc1_.l = this._lvl.Get();
         }
         if(this._countdownBuild.Get() > 0)
         {
            _loc1_.cB = this._countdownBuild.Get();
            if(this._prefab)
            {
               _loc1_.prefab = this._prefab;
            }
         }
         if(this._countdownUpgrade.Get() > 0)
         {
            _loc1_.cU = this._countdownUpgrade.Get();
         }
         if(this._countdownRebuild.Get() > 0)
         {
            _loc1_.cR = this._countdownRebuild.Get();
         }
         if(this._countdownFortify.Get() > 0)
         {
            _loc1_.cF = this._countdownFortify.Get();
         }
         if(this._repairing > 0)
         {
            _loc1_.rE = this._repairing;
         }
         if(this._fortification.Get() > 0)
         {
            _loc1_.fort = this._fortification.Get();
         }
         if(this._threadid)
         {
            _loc1_.ti = this._threadid;
         }
         if(this._senderid)
         {
            _loc1_.sid = this._senderid;
         }
         if(this._senderName)
         {
            _loc1_.snm = this._senderName;
         }
         if(this._senderPic)
         {
            _loc1_.spc = this._senderPic;
         }
         if(this._subject)
         {
            _loc1_.sbj = this._subject;
         }
         if(this._productionStage.Get() > 0)
         {
            _loc1_.rPS = this._productionStage.Get();
         }
         if(this._countdownProduce.Get() > 0)
         {
            _loc1_.rCP = this._countdownProduce.Get();
         }
         if(this._inProduction != "")
         {
            _loc1_.rIP = this._inProduction;
         }
         if(this._hp.Get() < this._hpMax.Get())
         {
            _loc1_.hp = int(this._hp.Get());
         }
         if(this._helpList.length > 0 && this._countdownBuild.Get() + this._countdownUpgrade.Get() + this._countdownFortify.Get() > 0)
         {
            _loc1_.hl = this._helpList;
         }
         return _loc1_;
      }
      
      public function Setup(param1:Object) : *
      {
         var _loc2_:Point = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this._type = param1.t;
         this._id = param1.id;
         _loc2_ = GRID.ToISO(param1.X,param1.Y,0);
         if(this._type == 112)
         {
            param1.l = 1;
         }
         if(param1.l)
         {
            this._lvl.Set(int(param1.l));
         }
         else
         {
            this._lvl.Set(1);
         }
         this._mc.x = _loc2_.x;
         this._mc.y = _loc2_.y;
         ++BASE._buildingCount;
         this._countdownBuild.Set(int(param1.cB));
         if(param1.prefab)
         {
            this._prefab = param1.prefab;
            this._lvl.Set(param1.prefab);
            if(this._countdownBuild.Get() == 0)
            {
               _loc3_ = 0;
               _loc4_ = 0;
               while(_loc4_ < param1.prefab)
               {
                  _loc3_ += GLOBAL._buildingProps[this._type - 1].costs[_loc4_].time;
                  _loc4_++;
               }
               this._countdownBuild.Set(_loc3_);
            }
         }
         this._countdownUpgrade.Set(int(param1.cU));
         this._countdownRebuild.Set(int(param1.cR));
         this._hpCountdownRebuild = this._countdownRebuild.Get();
         if(param1.cF)
         {
            this._countdownFortify.Set(int(param1.cF));
         }
         else
         {
            this._countdownFortify.Set(0);
         }
         if(param1.fort)
         {
            this._fortification.Set(param1.fort);
         }
         else
         {
            this._fortification.Set(0);
         }
         this._repairing = int(param1.rE);
         if(this._repairing > 0)
         {
            this._repairing = 1;
         }
         this._productionStage.Set(int(param1.rPS));
         this._countdownProduce.Set(int(param1.rCP));
         this._hpCountdownProduce = this._countdownProduce.Get();
         if(Boolean(param1.rIP) && param1.rIP != "")
         {
            this._inProduction = param1.rIP;
         }
         if(this._inProduction == "C100")
         {
            this._inProduction = "C12";
         }
         if(param1.hl)
         {
            this._helpList = param1.hl;
         }
         if(param1.ti)
         {
            this._threadid = param1.ti;
         }
         if(param1.sid)
         {
            this._senderid = param1.sid;
         }
         if(param1.snm)
         {
            this._senderName = param1.snm;
         }
         if(param1.spc)
         {
            this._senderPic = param1.spc;
         }
         if(param1.sbj)
         {
            this._subject = param1.sbj;
         }
         if(this._countdownBuild.Get() > 0 && !this._prefab)
         {
            this._lvl.Set(0);
         }
         this._hpLvl = this._lvl.Get();
         if(this._lvl.Get() == 0)
         {
            this._hpMax.Set(this._buildingProps.hp[0]);
         }
         else
         {
            _loc4_ = this._lvl.Get();
            _loc5_ = int(this._buildingProps.hp[_loc4_ - 1]);
            this._hpMax.Set(_loc5_);
         }
         if(param1.hp == null)
         {
            this._hp.Set(this._hpMax.Get());
         }
         else
         {
            this._hp.Set(int(param1.hp));
            if(this._hp.Get() > this._hpMax.Get())
            {
               this._hp.Set(this._hpMax.Get());
            }
         }
         if(this._hp.Get() == 0)
         {
            this._destroyed = true;
         }
         this.Description();
         this._constructed = this._countdownBuild.Get() == 0;
         if(this._lvl.Get() == 0 && this._constructed)
         {
            this._lvl.Set(1);
         }
         if(this._type == 17)
         {
            this._gridCost[1][1] = 100 + this._lvl.Get() * 25;
         }
         this.PlaceB();
         if(this._countdownBuild.Get() > 0)
         {
            if(this._prefab)
            {
               this._hasResources = true;
               this._hasWorker = true;
            }
            else if(QUEUE.Add("building" + this._id,this))
            {
               this._hasResources = true;
            }
            else
            {
               this.RecycleC();
            }
         }
         else if(this._countdownUpgrade.Get() > 0)
         {
            if(QUEUE.Add("building" + this._id,this))
            {
               this._hasResources = true;
            }
            else
            {
               this.UpgradeCancelB();
            }
         }
         else if(this._countdownFortify.Get() > 0)
         {
            if(QUEUE.Add("building" + this._id,this))
            {
               this._hasResources = true;
            }
            else
            {
               this.FortifyCancelB();
            }
         }
         else
         {
            QUESTS.Check("blvl",this._lvl.Get());
            QUESTS.Check("b" + this._type + "lvl",this._lvl.Get());
            if(this._class == "resource")
            {
               QUESTS.Check("brlvl",this._lvl.Get());
            }
         }
      }
      
      public function Clean() : void
      {
         if(this._type == 7)
         {
            delete BASE._buildingsMushrooms["m" + this._id];
         }
         else
         {
            delete BASE._buildingsAll["b" + this._id];
            delete BASE._buildingsWalls["b" + this._id];
            delete BASE._buildingsTowers["b" + this._id];
            delete BASE._buildingsMain["b" + this._id];
            delete BASE._buildingsGifts["b" + this._id];
         }
         this._mc.removeEventListener(Event.ENTER_FRAME,this.FollowMouseB);
         MAP._GROUND.removeEventListener(MouseEvent.MOUSE_UP,this.Place);
         this._mc.removeEventListener(MouseEvent.MOUSE_DOWN,MAP.Click);
         if(this._mcHit)
         {
            if(this._mcHit.parent)
            {
               this._mcHit.parent.removeChild(this._mcHit);
            }
         }
         if(this._mcFootprint)
         {
            if(this._mcFootprint.parent)
            {
               MAP._BUILDINGFOOTPRINTS.removeChild(this._mcFootprint);
            }
         }
         if(this._mcBase.parent)
         {
            MAP._BUILDINGBASES.removeChild(this._mcBase);
         }
         if(this._mc.parent)
         {
            MAP._BUILDINGTOPS.removeChild(this._mc);
         }
         this.topContainer.Clear();
         this.animContainer.Clear();
         this._fortFrontContainer.Clear();
         this._fortBackContainer.Clear();
         this.anim2Container.Clear();
         this.anim3Container.Clear();
      }
      
      private function GetHitMC() : MovieClip
      {
         var _loc1_:Object = GLOBAL._buildingProps[this._type - 1] || {};
         var _loc2_:Boolean = BASE.isInferno();
         if(this._type == 1)
         {
            return _loc2_ ? new boneCrusherHit() : new building1hit();
         }
         if(this._type == 2)
         {
            return _loc2_ ? new coalProducerHit() : new building2hit();
         }
         if(this._type == 3)
         {
            return _loc2_ ? new sulpherProducerHit() : new building3hit();
         }
         if(this._type == 4)
         {
            return _loc2_ ? new magmaProducerHit() : new building4hit();
         }
         if(this._type == 5)
         {
            return new building5hit();
         }
         if(this._type == 6)
         {
            return _loc2_ ? new siloHit() : new building6hit();
         }
         if(this._type == 7)
         {
            return new building7hit();
         }
         if(this._type == 8)
         {
            return _loc2_ ? new monsterLockerHit() : new building8hit();
         }
         if(this._type == 9)
         {
            return new building9hit();
         }
         if(this._type == 10)
         {
            return new building10hit();
         }
         if(this._type == 11)
         {
            return new building11hit();
         }
         if(this._type == 12)
         {
            return new building12hit();
         }
         if(this._type == 13)
         {
            return _loc2_ ? new hatcheryHit() : new building13hit();
         }
         if(this._type == 14)
         {
            return _loc2_ ? new townHallHit() : new building14hit();
         }
         if(this._type == 15)
         {
            return new building15hit();
         }
         if(this._type == 16)
         {
            return new building16hit();
         }
         if(this._type == 17)
         {
            return _loc2_ ? new wallHit() : new building17hit();
         }
         if(this._type == 18)
         {
            return new building18hit();
         }
         if(this._type == 19)
         {
            return new building19hit();
         }
         if(this._type == 20)
         {
            return _loc2_ ? new cannonTowerHit() : new building20hit();
         }
         if(this._type == 21)
         {
            return _loc2_ ? new sniperTowerHit() : new building21hit();
         }
         if(this._type == 22)
         {
            return new building22hit();
         }
         if(this._type == 23)
         {
            return new building23hit();
         }
         if(this._type == 24)
         {
            return new building24hit();
         }
         if(this._type == 25)
         {
            return new building25hit();
         }
         if(this._type == 26)
         {
            return _loc2_ ? new infernoAcademyHit() : new building26hit();
         }
         if(this._type == 27)
         {
            return new building27hit();
         }
         if(this._type == 51)
         {
            return new building51hit();
         }
         if(this._type == 53)
         {
            return new building53hit();
         }
         if(this._type == 54)
         {
            return new building54hit();
         }
         if(this._type == 55)
         {
            return new building55hit();
         }
         if(this._type >= 28 && this._type <= 50)
         {
            return new buildingflaghit();
         }
         if(this._type == 56)
         {
            return new building56hit();
         }
         if(this._type == 57)
         {
            return new building57hit();
         }
         if(this._type >= 60 && this._type <= 62)
         {
            return new buildinggnomehit();
         }
         if(this._type == 63)
         {
            return new building63hit();
         }
         if(this._type == 64)
         {
            return new building64hit();
         }
         if(this._type == 65)
         {
            return new building65hit();
         }
         if(this._type == 66)
         {
            return new building66hit();
         }
         if(this._type == 68)
         {
            return new building68hit();
         }
         if(this._type == 71)
         {
            return new building71hit();
         }
         if(this._type == 72)
         {
            return new building72hit();
         }
         if(this._type == 73)
         {
            return new building73hit();
         }
         if(this._type >= 74 && this._type <= 85 || this._type == 107)
         {
            return new buildingheadhit();
         }
         if(this._type == 86)
         {
            return new building86hit();
         }
         if(this._type == 87)
         {
            return new building87hit();
         }
         if(this._type == 88)
         {
            return new building88hit();
         }
         if(this._type == 89)
         {
            return new building89hit();
         }
         if(this._type == 90)
         {
            return new building90hit();
         }
         if(this._type >= 91 && this._type <= 95)
         {
            return new buildingflowershit();
         }
         if(this._type == 96)
         {
            return new building96hit();
         }
         if(this._type == 97)
         {
            return new building97hit();
         }
         if(this._type == 98)
         {
            return new building98hit();
         }
         if(this._type == 99)
         {
            return new building99hit();
         }
         if(this._type == 100)
         {
            return new building100hit();
         }
         if(this._type == 101)
         {
            return new building101hit();
         }
         if(this._type == 102)
         {
            return new building102hit();
         }
         if(this._type == 103)
         {
            return new building103hit();
         }
         if(this._type == 104)
         {
            return new building104hit();
         }
         if(this._type == 105)
         {
            return new building105hit();
         }
         if(this._type == 106)
         {
            return new building106hit();
         }
         if(this._type >= 108 && this._type <= 109)
         {
            return new buildingcubehit();
         }
         if(this._type == 106)
         {
            return new building106hit();
         }
         if(this._type == 110)
         {
            return new building110hit();
         }
         if(this._type == 111)
         {
            return new building111hit();
         }
         if(this._type == 112)
         {
            return new building112hit();
         }
         if(this._type == 113)
         {
            return new building113hit();
         }
         if(this._type == 114)
         {
            return new building114hit();
         }
         if(this._type == 115)
         {
            return new building115hit();
         }
         if(this._type == 116)
         {
            return new building116hit();
         }
         if(this._type == 117)
         {
            return new building117hit();
         }
         if(this._type == 118)
         {
            return new building118hit();
         }
         if(this._type == 119)
         {
            return new building119hit();
         }
         if(this._type == 2 * 60)
         {
            return new building120hit();
         }
         if(this._type == 121)
         {
            return new building121hit();
         }
         if(this._type == 122)
         {
            return new building122hit();
         }
         if(this._type == 123)
         {
            return new building123hit();
         }
         if(this._type == 124)
         {
            return new building124hit();
         }
         if(this._type == 125)
         {
            return new building125hit();
         }
         if(this._type == 126)
         {
            return new building126hit();
         }
         if(this._type == 127)
         {
            return new infernoPortalHit();
         }
         if(this._type == 128)
         {
            return new housingBunkerHit();
         }
         if(this._type == 129)
         {
            return new quakeTowerHit();
         }
         if(this._type == 130)
         {
            return new cannonTowerHit();
         }
         if(this._type == 131)
         {
            return new building131hit();
         }
         if(this._type == 132)
         {
            return new magmaTowerHit();
         }
         if(this._type == 135)
         {
            return new building135hit();
         }
         return !!_loc1_.hitCls ? new _loc1_.hitCls() : new building1hit();
      }
      
      private function GetFootprintMC() : MovieClip
      {
         if(this._footprint[0].width == 20)
         {
            return new buildingFootprint20x20();
         }
         if(this._footprint[0].width == 30)
         {
            return new buildingFootprint30x30();
         }
         if(this._footprint[0].width == 40)
         {
            return new buildingFootprint40x40();
         }
         if(this._footprint[0].width == 70)
         {
            return new buildingFootprint70x70();
         }
         if(this._footprint[0].width == 80)
         {
            return new buildingFootprint80x80();
         }
         if(this._footprint[0].width == 90)
         {
            return new buildingFootprint90x90();
         }
         if(this._footprint[0].width == 100)
         {
            return new buildingFootprint100x100();
         }
         if(this._footprint[0].width == 130)
         {
            return new buildingFootprint130x130();
         }
         if(this._footprint[0].width == 160)
         {
            return new buildingFootprint160x160();
         }
         if(this._footprint[0].width == 190)
         {
            return new buildingFootprint190x160();
         }
         return new MovieClip();
      }
      
      public function highlight(param1:uint) : void
      {
         var _loc2_:Array = null;
         if(this._mc)
         {
            _loc2_ = new Array();
            _loc2_ = _loc2_.concat([2,0,0,0,0]);
            _loc2_ = _loc2_.concat([0,2,0,0,0]);
            _loc2_ = _loc2_.concat([0,0,3,0,0]);
            _loc2_ = _loc2_.concat([0,0,0,1,0]);
            this._mc.filters = [new ColorMatrixFilter(_loc2_)];
         }
      }
      
      public function disableHighlight() : void
      {
         if(this._mc)
         {
            this._mc.filters = [];
         }
      }
      
      public function get x() : int
      {
         return this._mc.x;
      }
      
      public function get y() : int
      {
         return this._mc.y;
      }
      
      public function set x(param1:int) : *
      {
         this._mc.x = param1;
      }
      
      public function set y(param1:int) : *
      {
         this._mc.y = param1;
      }
      
      public function moveTo(param1:int, param2:int) : void
      {
         this.GridCost(false);
         this.x = param1;
         this.y = param2;
         this._mcBase.x = param1;
         this._mcBase.y = param2;
         this._mcFootprint.x = param1;
         this._mcFootprint.y = param2;
         this.StartMove();
         this.StopMove(null);
         BASE.Save();
      }
      
      public function get name() : String
      {
         return KEYS.Get(this._buildingProps.name);
      }
      
      public function get isUpgrading() : Boolean
      {
         return this._countdownUpgrade.Get() > 0;
      }
      
      public function get isBuilding() : Boolean
      {
         return this._countdownBuild.Get() > 0;
      }
      
      protected function RelocateHousedCreatures() : *
      {
         var _loc4_:* = undefined;
         var _loc1_:BFOUNDATION = BASE.FindClosestHousingToPoint(this.x,this.y,this);
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:uint = this._creatures.length;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._creatures[_loc3_];
            if(_loc4_._behaviour != CreepBase.k_sBHVR_JUICE)
            {
               _loc1_._creatures.push(_loc4_);
               _loc4_._house = _loc1_;
               _loc4_._targetCenter = GRID.FromISO(_loc1_.x,_loc1_.y);
               _loc4_.ModeHousing();
            }
            _loc3_++;
         }
         this._creatures.length = 0;
      }
      
      protected function UpdateHousedCreatureTargets() : *
      {
         var _loc3_:* = undefined;
         var _loc1_:uint = this._creatures.length;
         var _loc2_:Number = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._creatures[_loc2_];
            if(!(_loc3_._behaviour == CreepBase.k_sBHVR_JUICE || _loc3_._behaviour == CreepBase.k_sBHVR_BUNKER))
            {
               _loc3_._targetCenter = GRID.FromISO(this.x,this.y);
               _loc3_.ModeHousing();
            }
            _loc2_++;
         }
      }
   }
}

