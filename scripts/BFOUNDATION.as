package
{
   import com.cc.utils.SecNum;
   import com.monsters.display.BuildingAssetContainer;
   import com.monsters.display.BuildingOverlay;
   import com.monsters.display.ImageCache;
   import com.monsters.effects.fire.Fire;
   import com.monsters.effects.smoke.Smoke;
   import com.monsters.pathing.PATHING;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BFOUNDATION
   {
      internal var _mcBase:*;
      
      internal var _mcFootprint:*;
      
      internal var _mcHit:*;
      
      internal var _r:*;
      
      public var _mc:MovieClip;
      
      public var _mouseClicked:Boolean = false;
      
      public var topContainer:BuildingAssetContainer;
      
      public var animContainer:BuildingAssetContainer;
      
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
      
      public var _animLoaded:Boolean = false;
      
      public var _animBMD:BitmapData;
      
      public var _animRect:Rectangle;
      
      public var _animContainerBMD:BitmapData;
      
      public var _animTick:int = 0;
      
      public var _animFrames:int = 0;
      
      public var _countdownBuild:SecNum;
      
      public var _countdownUpgrade:SecNum;
      
      public var _countdownRebuild:SecNum;
      
      public var _countdownProduce:SecNum;
      
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
         this._countdownBuild = new SecNum(0);
         this._countdownRebuild = new SecNum(0);
         this._countdownUpgrade = new SecNum(0);
         this._countdownProduce = new SecNum(0);
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
         if(BASE._isOutpost)
         {
            this._blockRecycle = true;
         }
      }
      
      public function SetProps() : *
      {
         this._buildingProps = GLOBAL._buildingProps[this._type - 1];
         this._mcFootprint = MAP._BUILDINGFOOTPRINTS.addChild(this.GetFootprintMC());
         this._mc = MAP._BUILDINGTOPS.addChild(new MovieClip());
         this.topContainer = new BuildingAssetContainer();
         this.topContainer.mouseChildren = false;
         this.topContainer.mouseEnabled = false;
         this.animContainer = new BuildingAssetContainer();
         this.animContainer.mouseChildren = false;
         this.animContainer.mouseEnabled = false;
         this._mc.addChild(this.topContainer);
         this._mc.addChild(this.animContainer);
         this._mcBase = MAP._BUILDINGBASES.addChild(new BuildingAssetContainer());
         this._mcHit = this._mc.addChild(this.GetHitMC());
         this._mcHit.gotoAndStop(1);
         this._mcHit.cacheAsBitmap = true;
         this._mcHit.alpha = 0;
         this._size = this._buildingProps.size;
         this._class = this._buildingProps.type;
         this._mcFootprint.gotoAndStop(1);
         this._attackgroup = this._buildingProps.attackgroup;
         this._mouseOffset = new Point(0,int(this._mcFootprint.height / 20) * 10);
         this._middle = this._footprint[0].height * 0.5;
         this._mc._middle = this._middle;
      }
      
      public function Bank() : *
      {
      }
      
      public function Description() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         this._buildingTitle = "<b>" + this._buildingProps.name + "</b>";
         if(this._buildingProps.costs.length > 1)
         {
            this._buildingTitle += " Level " + this._lvl.Get();
         }
         if(this._hp.Get() < this._hpMax.Get())
         {
            if(this._countdownUpgrade.Get() > 0)
            {
               this._repairDescription = "<font color=\"#FF0000\"><b>Upgrade on hold until building is repaired.</b></font>";
            }
            else
            {
               _loc1_ = 100 - Math.ceil(100 / this._hpMax.Get() * this._hp.Get());
               this._specialDescription = "<font color=\"#FF0000\"><b>Building " + _loc1_ + "% damaged!</b></font>";
            }
         }
         else
         {
            this._specialDescription = this._buildingProps.description;
            if(!(this._type == 24 || this._type == 25 || this._type == 26))
            {
               if(this._type == 20 || this._type == 21)
               {
                  this._buildingStats = "Range: " + this._range + "<br>Damage: " + this._damage + " (" + int(this._damage * (40 / this._rate)) + " DPS)<br>Splash: " + this._splash + "<br>Rate of Fire: " + int(40 / this._rate * 10) / 10;
                  if(this._type == 20)
                  {
                     this._buildingDescription = "Short range and slow firing but great at taking out groups of monsters with its explosive shells";
                  }
                  if(this._type == 21)
                  {
                     this._buildingDescription = "Long range and quick firing, great for picking off monsters from a great distance.";
                  }
                  if(this._lvl.Get() < this._buildingProps.costs.length)
                  {
                     this._upgradeDescription = "Range: " + this._buildingProps.stats[this._lvl.Get()].range + " Damage: " + this._buildingProps.stats[this._lvl.Get()].damage + " Splash: " + this._buildingProps.stats[this._lvl.Get()].splash + " Rate of fire: " + int(40 / this._buildingProps.stats[this._lvl.Get()].rate * 10) / 10;
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
            this._repairDescription = "<font color=\"#FF0000\"><b>Building Damaged in an attack</b></font><br>Repair in progress, " + Math.floor(100 / this._hpMax.Get() * this._hp.Get()) + "% complete<br>" + GLOBAL.ToTime(int((this._hpMax.Get() - this._hp.Get()) / _loc2_)) + " remaining.";
         }
         else
         {
            this._repairDescription = "<font color=\"#FF0000\"><b>Building Damaged in an attack</b></font><br>Repair this building, it does not cost resources.";
            if(this._countdownBuild.Get() > 0)
            {
               this._repairDescription += "<br>Another attack could destroy it completely!";
            }
            if(this._countdownUpgrade.Get() > 0)
            {
               this._repairDescription += "<br>Another attack could set back the upgrade!";
            }
         }
         if(this._lvl.Get() >= this._buildingProps.costs.length)
         {
            this._upgradeDescription = "Fully Upgraded";
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
      
      public function Render(param1:String = "") : *
      {
         var ImageCallback:Function;
         var imageDataA:Object = null;
         var imageDataB:Object = null;
         var imageLevel:int = 0;
         var i:int = 0;
         var loadImages:Array = null;
         var state:String = param1;
         if(this._renderState == null || state != this._renderState || this._lvl.Get() != this._renderLevel)
         {
            ImageCallback = function(param1:Array, param2:String):*
            {
               var image:Array = null;
               var key:String = null;
               var bmd:BitmapData = null;
               var container:BuildingAssetContainer = null;
               var s:* = undefined;
               var images:Array = param1;
               var imagestate:String = param2;
               if(imagestate == _renderState)
               {
                  _mcBase.Clear();
                  topContainer.Clear();
                  animContainer.Clear();
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
                     else if(Boolean(imageDataB["anim" + state]) && imageDataA.baseurl + imageDataB["anim" + state][0] == key)
                     {
                        _animBMD = bmd;
                        _animLoaded = true;
                        container = animContainer;
                        container.Clear();
                        _animRect = imageDataB["anim" + state][1];
                        _animFrames = imageDataB["anim" + state][2];
                        _animTick = int(Math.random() * (_animFrames - 2));
                        if(_type == 9 || _type == 19 || _type == 25 || _type == 54)
                        {
                           _animTick = 0;
                        }
                        _animContainerBMD = new BitmapData(_animRect.width,_animRect.height,true,0xffffff);
                        container.addChild(new Bitmap(_animContainerBMD));
                        container.x = _animRect.x;
                        container.y = _animRect.y;
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
               this._animLoaded = false;
               ImageCache.GetImageGroupWithCallBack("b" + this._type + "-" + imageLevel + state,loadImages,ImageCallback,true,2,state);
            }
         }
      }
      
      public function Tick() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(GLOBAL._catchup && this._repairing && BASE._currentTime - GLOBAL.Timestamp() > 60 * 60)
         {
            this.Repaired();
         }
         if(GLOBAL._catchup && this._hp.Get() == 0 && !this._repairing)
         {
            this.CatchupRemove();
         }
         if(this._countdownBuild.Get() + this._countdownUpgrade.Get() + this._repairing > 0)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            if(this._repairing == 1)
            {
               _loc4_ = this._lvl.Get() == 0 ? 0 : this._lvl.Get() - 1;
               _loc3_ = Math.ceil(this._hpMax.Get() / Math.min(60 * 60,this._buildingProps.repairTime[_loc4_]));
               this._hp.Add(_loc3_);
               if(this._hp.Get() >= this._hpMax.Get())
               {
                  this.Repaired();
               }
            }
            else if(this._hp.Get() == this._hpMax.Get())
            {
               if(this._countdownUpgrade.Get() > 0 && this._hasWorker && this._hasResources)
               {
                  this._countdownUpgrade.Add(-1);
                  if(!Math.max(this._countdownUpgrade.Get(),0))
                  {
                     this.Upgraded();
                  }
               }
               else if(this._countdownBuild.Get() > 0 && this._hasWorker && this._hasResources)
               {
                  this._countdownBuild.Add(-1);
                  if(!Math.max(this._countdownBuild.Get(),0))
                  {
                     this.Constructed();
                  }
               }
            }
         }
         if(!GLOBAL._catchup)
         {
            this.Update();
         }
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
               this._animContainerBMD.copyPixels(this._animBMD,new Rectangle(this._animRect.width * this._animTick,0,this._animRect.width,this._animRect.height),new Point(0,0));
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
         }
         catch(e:Error)
         {
         }
      }
      
      public function Instructions() : *
      {
         this._buildingInstructions += "<b>Place the building on the map by clicking</b>, you can drag around the map with the building selected, <b>press ESC to cancel building</b>.";
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
         var tmpBuildTime:int = 0;
         var fromStorage:Boolean = false;
         var digits:Array = null;
         var lastDigit:int = 0;
         var secondDigit:int = 0;
         var sum:int = 0;
         var e:MouseEvent = param1;
         try
         {
            this.Description();
            if(!MAP._dragged)
            {
               if(BASE.BuildBlockers(this,this._class == "decoration") == "")
               {
                  SOUNDS.Play("buildingplace");
                  GLOBAL._newBuilding = null;
                  this._mc.removeEventListener(Event.ENTER_FRAME,this.FollowMouseB);
                  MAP._GROUND.removeEventListener(MouseEvent.MOUSE_UP,this.Place);
                  this._mc.removeEventListener(MouseEvent.MOUSE_DOWN,MAP.Click);
                  if(BASE.CanBuild(this._type).error)
                  {
                     this.Cancel();
                     return false;
                  }
                  this._hasResources = false;
                  this._hasWorker = false;
                  ++BASE._buildingCount;
                  this._id = BASE._buildingCount;
                  tmpBuildTime = int(this._buildingProps.costs[0].time);
                  if(Boolean(GLOBAL._flags.split) && TUTORIAL._stage >= 202)
                  {
                     if(GLOBAL._mode == "build")
                     {
                        digits = LOGIN._digits;
                     }
                     else
                     {
                        digits = BASE._userDigits;
                     }
                     lastDigit = int(digits[LOGIN._digits.length - 1]);
                     secondDigit = int(digits[LOGIN._digits.length - 2]);
                     sum = lastDigit + secondDigit;
                     if(sum > 9)
                     {
                        sum -= 10;
                     }
                     if(sum >= 7)
                     {
                        tmpBuildTime *= 1.5;
                     }
                     else if(sum >= 4)
                     {
                        tmpBuildTime *= 1.25;
                     }
                  }
                  if(STORE._storeData.BST)
                  {
                     tmpBuildTime -= tmpBuildTime * 0.2;
                  }
                  this._countdownBuild.Set(tmpBuildTime);
                  this._hp.Set(this._buildingProps.hp[0]);
                  this._hpMax.Set(this._hp.Get());
                  this.PlaceB();
                  this.Tick();
                  this.Update();
                  this.Description();
                  fromStorage = BASE.BuildingStorageRemove(this._type);
                  if(!fromStorage)
                  {
                     BASE.Charge(1,this._buildingProps.costs[0].r1);
                     BASE.Charge(2,this._buildingProps.costs[0].r2);
                     BASE.Charge(3,this._buildingProps.costs[0].r3);
                     BASE.Charge(4,this._buildingProps.costs[0].r4);
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
                     this.Constructed();
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
            this.CatchupAdd();
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
      }
      
      public function Destroyed(param1:Boolean = true) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
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
               if(Boolean(GLOBAL._flags.split) && TUTORIAL._stage >= 202)
               {
                  if(GLOBAL._mode == "build")
                  {
                     _loc5_ = LOGIN._digits;
                  }
                  else
                  {
                     _loc5_ = BASE._userDigits;
                  }
                  _loc6_ = int(_loc5_[_loc5_.length - 1]);
                  _loc7_ = int(_loc5_[_loc5_.length - 2]);
                  _loc8_ = _loc6_ + _loc7_;
                  if(_loc8_ > 9)
                  {
                     _loc8_ -= 10;
                  }
                  if(_loc8_ >= 7)
                  {
                     _loc2_ *= 1.5;
                  }
                  else if(_loc8_ >= 4)
                  {
                     _loc2_ *= 1.25;
                  }
               }
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
         this._repairing = 0;
         this._hp.Set(this._hpMax.Get());
         this.Description();
         UI2.Update();
      }
      
      public function HasWorker() : *
      {
         this._hasWorker = true;
         if(this._countdownBuild.Get() + this._countdownUpgrade.Get() > 0)
         {
            ResourcePackages.Create(1,this,2,true);
            ResourcePackages.Create(2,this,2,true);
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
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         if(this._countdownBuild.Get() > 0)
         {
            _loc2_ = this._countdownBuild.Get();
         }
         if(this._countdownUpgrade.Get() > 0)
         {
            _loc2_ = this._countdownUpgrade.Get();
         }
         if(_loc2_ <= 5 * 60)
         {
            return 0;
         }
         _loc3_ = Math.ceil(_loc2_ * 20 / 60 / 60);
         _loc4_ = int(Math.sqrt(_loc2_ * 0.8));
         if(GLOBAL._flags.split)
         {
            _loc5_ = int(LOGIN._digits[LOGIN._digits.length - 1]);
            _loc6_ = int(LOGIN._digits[LOGIN._digits.length - 3]);
            _loc7_ = _loc5_ + _loc6_;
            if(_loc7_ >= 10)
            {
               _loc7_ -= 10;
            }
            if(_loc7_ > 3)
            {
               if(_loc7_ <= 6)
               {
                  _loc4_ = int(Math.pow(_loc2_ * 0.6,0.55));
               }
               else if(_loc7_ <= 9)
               {
                  _loc4_ = int(Math.pow(_loc2_,0.55));
               }
            }
         }
         return Math.min(_loc3_,_loc4_);
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
            return true;
         }
         POPUPS.DisplayGetShiny();
         return false;
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
         var tmpUpgradeTime:int = 0;
         var digits:Array = null;
         var lastDigit:int = 0;
         var secondDigit:int = 0;
         var sum:int = 0;
         var popupMC:* = undefined;
         if(this._countdownUpgrade.Get() == 0)
         {
            canUpgrade = BASE.CanUpgrade(this);
            if(!canUpgrade.error)
            {
               o = this.UpgradeCost();
               if(o.r1 > 0)
               {
                  BASE.Charge(1,o.r1);
               }
               if(o.r2 > 0)
               {
                  BASE.Charge(2,o.r2);
               }
               if(o.r3 > 0)
               {
                  BASE.Charge(3,o.r3);
               }
               if(o.r4 > 0)
               {
                  BASE.Charge(4,o.r4);
               }
               tmpUpgradeTime = int(this._buildingProps.costs[this._lvl.Get()].time * GLOBAL._buildTime);
               if(Boolean(GLOBAL._flags.split) && TUTORIAL._stage >= 202)
               {
                  if(GLOBAL._mode == "build")
                  {
                     digits = LOGIN._digits;
                  }
                  else
                  {
                     digits = BASE._userDigits;
                  }
                  lastDigit = int(digits[digits.length - 1]);
                  secondDigit = int(digits[digits.length - 2]);
                  sum = lastDigit + secondDigit;
                  if(sum > 9)
                  {
                     sum -= 10;
                  }
                  if(sum >= 7)
                  {
                     tmpUpgradeTime *= 1.5;
                  }
                  else if(sum >= 4)
                  {
                     tmpUpgradeTime *= 1.25;
                  }
               }
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
               if(GLOBAL._mode == "build" && (this._type == 20 || this._type == 21 || this._type == 22 || this._type == 23 || this._type == 25))
               {
                  GLOBAL._selectedBuilding = this;
                  GLOBAL.Message("<b>Caution:</b> Defensive buildings are inactive during upgrades.<br><br>Move other buildings nearby to help protect them or simply speed up the upgrade.","Speed Up",STORE.ShowB,[3,0,["SP1","SP2","SP3","SP4"]]);
               }
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
         if(this._countdownBuild.Get() + this._countdownUpgrade.Get() > 0)
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
         var _loc1_:* = undefined;
         if(this._countdownUpgrade.Get() > 0)
         {
            QUEUE.Remove("building" + this._id,false,this);
            this._countdownUpgrade.Set(0);
            _loc1_ = this.UpgradeCost();
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
      
      public function Upgraded() : *
      {
         var c:Object;
         var a:int;
         try
         {
            if(Math.max(this._countdownUpgrade.Get(),0))
            {
               LOGGER.Log("log","bdg up cnt > 0, probable hack");
               GLOBAL.ErrorMessage();
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
      
      public function Recycle() : *
      {
         if(this._countdownBuild.Get() > 0)
         {
            if(GLOBAL._mode == "build")
            {
               GLOBAL.Message(KEYS.Get("msg_stopconstructionconfirm"),KEYS.Get("msg_destroybuilding_btn"),this.RecycleB);
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
            if(BASE._isOutpost)
            {
               GLOBAL.Message("You cannot Recycle buildings in Outposts.");
            }
            else
            {
               GLOBAL.Message("You cannot Recycle this building at this time.");
            }
         }
      }
      
      public function RecycleB(param1:MouseEvent = null) : *
      {
         var _loc2_:* = undefined;
         BUILDINGOPTIONS.Hide();
         if(this._class != "decoration" && !this._blockRecycle)
         {
            if(!this._recycled)
            {
               this._recycled = true;
               _loc2_ = this.RecycleCost();
               if(_loc2_.r1)
               {
                  BASE.Fund(1,int(_loc2_.r1),false);
               }
               if(_loc2_.r2)
               {
                  BASE.Fund(2,int(_loc2_.r2),false);
               }
               if(_loc2_.r3)
               {
                  BASE.Fund(3,int(_loc2_.r3),false);
               }
               if(_loc2_.r4)
               {
                  BASE.Fund(4,int(_loc2_.r4),false);
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
            BASE.BuildingStorageAdd(this._type);
         }
         this.Clean();
         BASE.Save();
         if(GLOBAL._flags.showProgressBar == 1 && UI_PROGRESSBAR.ShouldProcess(this))
         {
            UI_PROGRESSBAR.ProcessBuildings(true);
         }
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
               _loc1_.r1 += _loc3_.r1;
               _loc1_.r2 += _loc3_.r2;
               _loc1_.r3 += _loc3_.r3;
               _loc1_.r4 += _loc3_.r4;
               _loc1_.r5 += _loc3_.r5;
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
      
      public function UpgradeCost() : *
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
               if(this._countdownBuild.Get() + this._countdownUpgrade.Get() > 0)
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
            GLOBAL.ErrorMessage();
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
            GLOBAL.ErrorMessage();
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
               if(GLOBAL._mode == "help" && this._countdownBuild.Get() + this._countdownUpgrade.Get() > 0)
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
               _loc6_ = this._lvl.Get() == 0 ? 0 : this._lvl.Get() - 1;
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
      
      public function Damage(param1:int, param2:int, param3:int, param4:int = 1, param5:Boolean = true) : void
      {
         this._hp.Add(-param1);
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
      
      public function Loot(param1:int) : *
      {
      }
      
      public function Constructed() : *
      {
         if(BASE._isOutpost)
         {
            this._blockRecycle = true;
         }
         this._countdownBuild.Set(0);
         this._constructed = true;
         if(!this._prefab)
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
         if(GLOBAL._flags.showProgressBar == 1 && UI_PROGRESSBAR.ShouldProcess(this))
         {
            UI_PROGRESSBAR.ProcessBuildings(true);
         }
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
         var _loc1_:* = new Object();
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
         if(this._repairing > 0)
         {
            _loc1_.rE = this._repairing;
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
         if(this._helpList.length > 0 && this._countdownBuild.Get() + this._countdownUpgrade.Get() > 0)
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
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
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
               if(Boolean(GLOBAL._flags.split) && TUTORIAL._stage >= 202)
               {
                  if(GLOBAL._mode == "build")
                  {
                     _loc5_ = LOGIN._digits;
                  }
                  else
                  {
                     _loc5_ = BASE._userDigits;
                  }
                  _loc6_ = int(_loc5_[_loc5_.length - 1]);
                  _loc7_ = int(_loc5_[_loc5_.length - 2]);
                  _loc8_ = _loc6_ + _loc7_;
                  if(_loc8_ > 9)
                  {
                     _loc8_ -= 10;
                  }
                  if(_loc8_ >= 7)
                  {
                     _loc3_ *= 1.5;
                  }
                  else if(_loc8_ >= 4)
                  {
                     _loc3_ *= 1.25;
                  }
               }
               this._countdownBuild.Set(_loc3_);
            }
         }
         this._countdownUpgrade.Set(int(param1.cU));
         this._countdownRebuild.Set(int(param1.cR));
         this._hpCountdownRebuild = this._countdownRebuild.Get();
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
            this._hpMax.Set(this._buildingProps.hp[this._lvl.Get() - 1]);
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
            this.CatchupRemove();
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
      }
      
      public function CatchupAdd() : void
      {
         BASE._buildingsCatchup["b" + this._id] = this;
      }
      
      public function CatchupRemove() : void
      {
         delete BASE._buildingsCatchup["b" + this._id];
      }
      
      private function GetHitMC() : MovieClip
      {
         if(this._type == 1)
         {
            return new building1hit();
         }
         if(this._type == 2)
         {
            return new building2hit();
         }
         if(this._type == 3)
         {
            return new building3hit();
         }
         if(this._type == 4)
         {
            return new building4hit();
         }
         if(this._type == 5)
         {
            return new building5hit();
         }
         if(this._type == 6)
         {
            return new building6hit();
         }
         if(this._type == 7)
         {
            return new building7hit();
         }
         if(this._type == 8)
         {
            return new building8hit();
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
            return new building13hit();
         }
         if(this._type == 14)
         {
            return new building14hit();
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
            return new building17hit();
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
            return new building20hit();
         }
         if(this._type == 21)
         {
            return new building21hit();
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
            return new building26hit();
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
         return new building1hit();
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
   }
}

