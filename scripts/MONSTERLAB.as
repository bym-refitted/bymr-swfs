package
{
   import com.cc.utils.SecNum;
   import com.monsters.display.BuildingAssetContainer;
   import com.monsters.display.ImageCache;
   import com.monsters.effects.fire.Fire;
   import com.monsters.effects.smoke.Smoke;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MONSTERLAB extends BFOUNDATION
   {
      public static var _mcPopup:MONSTERLABPOPUP;
      
      public static var _open:Boolean = false;
      
      public static var _powerupProps:Object = {};
      
      public var _field:BitmapData;
      
      public var _fieldBMP:Bitmap;
      
      public var _frameNumber:int;
      
      public var _animBitmap:BitmapData;
      
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
      
      public var _upgradeLevel:int = 0;
      
      public var _upgradeFinishTime:SecNum;
      
      public var _streamUpgradeCache:String = "";
      
      public function MONSTERLAB()
      {
         super();
         _type = 116;
         _footprint = [new Rectangle(0,0,100,100)];
         _gridCost = [[new Rectangle(0,0,100,100),10],[new Rectangle(10,10,80,80),200]];
         this.SetProps();
      }
      
      public static function Hide(param1:MouseEvent = null) : *
      {
         if(_open)
         {
            GLOBAL.BlockerRemove();
            SOUNDS.Play("close");
            BASE.BuildingDeselect();
            _open = false;
            GLOBAL._layerWindows.removeChild(_mcPopup);
            _mcPopup = null;
         }
      }
      
      public static function GetPuttyCost(param1:String, param2:int) : int
      {
         if(_powerupProps)
         {
            if(_powerupProps[param1])
            {
               return _powerupProps[param1].costs[param2 - 1][0];
            }
         }
         return 0;
      }
      
      public static function GetTimeCost(param1:String, param2:int) : int
      {
         if(_powerupProps)
         {
            if(_powerupProps[param1])
            {
               return _powerupProps[param1].costs[param2 - 1][1];
            }
         }
         return 0;
      }
      
      public static function GetShinyCost(param1:String, param2:int) : int
      {
         var _loc3_:int = STORE.GetTimeCost(GetTimeCost(param1,param2),false);
         var _loc4_:int = Math.ceil(Math.pow(Math.sqrt(GetPuttyCost(param1,param2) / 2),0.75));
         return _loc3_ + _loc4_;
      }
      
      override public function SetProps() : *
      {
         super.SetProps();
         this.anim2Container = new BuildingAssetContainer();
         this.anim2Container.mouseChildren = false;
         this.anim2Container.mouseEnabled = false;
         this.anim3Container = new BuildingAssetContainer();
         this.anim3Container.mouseChildren = false;
         this.anim3Container.mouseEnabled = false;
         _mc.addChild(this.anim2Container);
         _mc.addChild(this.anim3Container);
         _powerupProps = {
            "C3":{
               "name":"lab_boltname",
               "order":1,
               "description":"lab_boltdesc",
               "ability":"Blink Range",
               "upgrade_description":"lab_boltdesc_u",
               "stream":["lab_boltstream","lab_boltstream_unlock","lab_boltstream_upgrade"],
               "streampic":"lab_bolt.png",
               "costs":[[800 * 60,86400],[20 * 60 * 60,86400],[30 * 60 * 60,86400]],
               "effect":[150,5 * 60,450]
            },
            "C4":{
               "name":"lab_finkname",
               "order":2,
               "description":"lab_finkdesc",
               "ability":"Extra Target(s)",
               "upgrade_description":"lab_finkdesc_u",
               "stream":["lab_finkstream","lab_finkstream_unlock","lab_finkstream_upgrade"],
               "streampic":"lab_fink4.png",
               "costs":[[96000,108000],[128000,108000],[40 * 60 * 60,108000]],
               "effect":[1,2,3]
            },
            "C5":{
               "name":"lab_eyeraname",
               "order":5,
               "description":"lab_eyeradesc",
               "ability":"Airburst Bonus",
               "upgrade_description":"lab_eyeradesc_u",
               "stream":["lab_eyerastream","lab_eyerastream_unlock","lab_eyerastream_upgrade"],
               "streampic":"lab_eyera4.png",
               "costs":[[3560000,172800],[4120000,194400],[5120000,216000]],
               "effect":[0.2,0.3,0.4]
            },
            "C7":{
               "name":"lab_banditoname",
               "order":3,
               "description":"lab_banditodesc",
               "ability":"Whirlwind",
               "upgrade_description":"lab_banditodesc_u",
               "stream":["lab_banditostream","lab_banditostream_unlock","lab_banditostream_upgrade"],
               "streampic":"lab_bandito.png",
               "costs":[[1000000,115200],[25 * 60 * 1000,115200],[2000000,115200]],
               "effect":[1,1.5,2]
            },
            "C8":{
               "name":"lab_fangname",
               "order":4,
               "description":"lab_fangdesc",
               "ability":"Venom Damage",
               "upgrade_description":"lab_fangdesc_u",
               "stream":["lab_fangstream","lab_fangstream_unlock","lab_fangstream_upgrade"],
               "streampic":"lab_fang4.png",
               "costs":[[2000000,129600],[50 * 60 * 1000,129600],[4500000,129600]],
               "effect":[0.1,0.2,0.3]
            },
            "C9":{
               "name":"lab_brainname",
               "order":6,
               "description":"lab_braindesc",
               "ability":"s Cloak Delay",
               "upgrade_description":"lab_braindesc_u",
               "stream":["lab_brainstream","lab_brainstream_unlock","lab_brainstream_upgrade"],
               "streampic":"lab_brain.png",
               "costs":[[50 * 60 * 1000,172800],[4500000,172800],[100 * 60 * 1000,172800]],
               "effect":[0,4,8]
            },
            "C11":{
               "name":"lab_projectxname",
               "order":7,
               "description":"lab_projectxdesc",
               "ability":"Acid Damage",
               "upgrade_description":"lab_projectxdesc_u",
               "stream":["lab_projxstream","lab_projxstream_unlock","lab_projxstream_upgrade"],
               "streampic":"lab_projectx.png",
               "costs":[[8000000,259200],[200 * 60 * 1000,259200],[5 * 60 * 60 * 1000,259200]],
               "effect":[1,2,3]
            },
            "C12":{
               "name":"lab_davename",
               "order":10,
               "description":"lab_davedesc",
               "ability":"Rocket Range",
               "upgrade_description":"lab_davedesc_u",
               "stream":["lab_davestream","lab_davestream_unlock","lab_davestream_upgrade"],
               "strampic":"lab_dave.png",
               "costs":[[250 * 60 * 1000,518400],[22500000,518400],[33750000,518400]],
               "effect":[140,3 * 60,220]
            },
            "C13":{
               "name":"lab_wormzername",
               "order":8,
               "description":"lab_wormzerdesc",
               "ability":"Splash Damage",
               "upgrade_description":"lab_wormzerdesc_u",
               "stream":["lab_wormstream","lab_wormstream_unlock","lab_wormstream_upgrade"],
               "streampic":"lab_wormzer.png",
               "costs":[[10000000,345600],[250 * 60 * 1000,345600],[22500000,345600]],
               "effect":[1,2,3]
            },
            "C14":{
               "name":"lab_teratornname",
               "order":9,
               "description":"lab_teratorndesc",
               "ability":"Fireball Bounces",
               "upgrade_description":"lab_teratorndesc_u",
               "stream":["lab_terastream","lab_terastream_unlock","lab_terastream_upgrade"],
               "streampic":"lab_teratorn.png",
               "costs":[[200 * 60 * 1000,432000],[5 * 60 * 60 * 1000,432000],[27000000,432000]],
               "effect":[1,2,3]
            }
         };
      }
      
      override public function Click(param1:MouseEvent = null) : *
      {
         if(Boolean(_upgrading) && (!this._upgradeFinishTime || this._upgradeFinishTime.Get() == 0))
         {
            _upgrading = null;
         }
         super.Click(param1);
      }
      
      override public function Tick() : *
      {
         super.Tick();
         if(Boolean(_upgrading) && GLOBAL.Timestamp() >= this._upgradeFinishTime.Get())
         {
            this.FinishMonsterPowerup();
         }
         if(_open)
         {
            (_mcPopup as MONSTERLABPOPUP).Tick();
         }
         if(GLOBAL._catchup && !_repairing && !_upgrading && _countdownBuild.Get() + _countdownUpgrade.Get() == 0)
         {
            CatchupRemove();
         }
      }
      
      override public function TickFast(param1:Event = null) : *
      {
         super.TickFast(param1);
         if(_upgrading && GLOBAL._render && _countdownBuild.Get() + _countdownUpgrade.Get() == 0)
         {
            if((GLOBAL._mode == "build" || GLOBAL._mode == "help" || GLOBAL._mode == "view") && this._frameNumber % 3 == 0 && CREEPS._creepCount == 0)
            {
               this.AnimFrame(true);
            }
            else if(this._frameNumber % 10 == 0)
            {
               this.AnimFrame(true);
            }
         }
         ++this._frameNumber;
      }
      
      override public function Constructed() : *
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Constructed();
         GLOBAL._bLab = this;
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            Brag = function():*
            {
               GLOBAL.CallJS("sendFeed",["monsterlab-construct",KEYS.Get("pop_labbuilt_streamtitle"),KEYS.Get("pop_labbuilt_streambody"),"build-monsterlab.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_labbuilt_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_labbuilt_body");
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function Upgrade() : *
      {
         if(_upgrading)
         {
            GLOBAL.Message(KEYS.Get("lab_err_cantupgrade"));
            return false;
         }
         return super.Upgrade();
      }
      
      override public function Recycle() : *
      {
         if(_upgrading)
         {
            GLOBAL.Message(KEYS.Get("lab_err_cantrecycle"));
         }
         else
         {
            GLOBAL._bAcademy = null;
            super.Recycle();
         }
      }
      
      override public function Clean() : void
      {
         super.Clean();
         this.anim2Container.Clear();
         this.anim3Container.Clear();
      }
      
      public function Show() : *
      {
         if(!_open)
         {
            _open = true;
            GLOBAL.BlockerAdd();
            _mcPopup = GLOBAL._layerWindows.addChild(new MONSTERLABPOPUP());
            _mcPopup.Center();
            _mcPopup.ScaleUp();
         }
      }
      
      public function CanPowerup(param1:String, param2:int) : Object
      {
         if(ACADEMY._upgrades[param1] == null)
         {
            return {
               "error":true,
               "errorString":"Not Unlocked"
            };
         }
         if(Boolean(ACADEMY._upgrades[param1]) && ACADEMY._upgrades[param1].powerup == 3)
         {
            return {
               "error":true,
               "errorString":"Fully Powered Up"
            };
         }
         if(param2 > _lvl.Get())
         {
            return {
               "error":true,
               "errorString":"Upgrade Monster Lab"
            };
         }
         if(CREATURELOCKER._lockerData[param1] == null)
         {
            return {
               "error":true,
               "errorString":"Not Unlocked"
            };
         }
         if(CREATURELOCKER._lockerData[param1].t < 2)
         {
            return {
               "error":true,
               "errorString":"Not Unlocked"
            };
         }
         if(ACADEMY._upgrades[param1].level < param2 + 1)
         {
            return {
               "error":true,
               "errorString":"Needs Training"
            };
         }
         if(!BASE.Charge(3,_powerupProps[param1].costs[param2 - 1][0],true))
         {
            return {
               "error":true,
               "errorString":KEYS.Get("acad_err_putty")
            };
         }
         return {"error":false};
      }
      
      public function StartMonsterPowerup(param1:String, param2:int) : *
      {
         if(this.CanPowerup(param1,param2).error)
         {
            return;
         }
         BASE.Charge(3,GetPuttyCost(param1,param2));
         _upgrading = param1;
         this._upgradeFinishTime = new SecNum(GLOBAL.Timestamp() + GetTimeCost(param1,param2));
         this._upgradeLevel = param2;
         BASE.Save();
         LOGGER.Stat([49,param1.substr(1),param2]);
      }
      
      public function FinishMonsterPowerup() : *
      {
         var Post:Function;
         var monsterName:String = null;
         var powerName:String = null;
         var popupMC:popup_monster = null;
         var wasUpgrading:String = _upgrading;
         this._upgradeFinishTime = new SecNum(0);
         ACADEMY._upgrades[_upgrading].powerup = this._upgradeLevel;
         if(GLOBAL._mode == "build")
         {
            GLOBAL._playerCreatureUpgrades[_upgrading].powerup = this._upgradeLevel;
         }
         LOGGER.Stat([50,_upgrading.substr(1),this._upgradeLevel]);
         if(GLOBAL._mode == "build")
         {
            Post = function():*
            {
               if(_upgradeLevel == 1)
               {
                  GLOBAL.CallJS("sendFeed",["lab-powerup",KEYS.Get(_powerupProps[_streamUpgradeCache].stream[0]),KEYS.Get(_powerupProps[_streamUpgradeCache].stream[1],{"v1":powerName}),_powerupProps[_streamUpgradeCache].streampic,0]);
               }
               else
               {
                  GLOBAL.CallJS("sendFeed",["lab-powerup",KEYS.Get(_powerupProps[_streamUpgradeCache].stream[0]),KEYS.Get(_powerupProps[_streamUpgradeCache].stream[2],{"v1":_upgradeLevel}),_powerupProps[_streamUpgradeCache].streampic,0]);
               }
               POPUPS.Next();
            };
            monsterName = KEYS.Get(CREATURELOCKER._creatures[_upgrading].name);
            powerName = KEYS.Get(_powerupProps[_upgrading].name);
            popupMC = new popup_monster();
            popupMC.tText.htmlText = "<b>" + KEYS.Get("lab_powerup_complete",{
               "v1":powerName,
               "v2":this._upgradeLevel
            }) + "</b>";
            popupMC.bAction.SetupKey("btn_warnyourfriends");
            popupMC.bAction.addEventListener(MouseEvent.CLICK,Post);
            popupMC.bAction.Highlight = true;
            popupMC.bSpeedup.visible = false;
            POPUPS.Push(popupMC,null,null,null,"" + _upgrading + "-LAB-150.png");
            this._streamUpgradeCache = _upgrading;
         }
         _upgrading = null;
         if(_open)
         {
            (_mcPopup as MONSTERLABPOPUP).Setup(wasUpgrading);
         }
         BASE.Save();
      }
      
      public function CancelMonsterPowerup(param1:MouseEvent) : *
      {
         if(_upgrading)
         {
            GLOBAL.Message(KEYS.Get("lab_confirmcancel",{
               "v1":KEYS.Get(CREATURELOCKER._creatures[_upgrading].name),
               "v2":KEYS.Get(_powerupProps[_upgrading].name)
            }),KEYS.Get("lab_confirmcancel_btn"),this.CancelMonsterPowerupB);
         }
      }
      
      public function CancelMonsterPowerupB() : *
      {
         POPUPS.Next();
         BASE.Charge(3,GetPuttyCost(_upgrading,this._upgradeLevel) * -1);
         var _loc1_:String = _upgrading;
         _upgrading = null;
         this._upgradeLevel = 0;
         this._upgradeFinishTime = new SecNum(0);
         _mcPopup.Setup(_loc1_);
         BASE.Save();
      }
      
      public function InstantMonsterPowerup(param1:String, param2:int) : *
      {
         var Post:Function;
         var powerName:String = null;
         var popupMC:popup_monster = null;
         var id:String = param1;
         var level:int = param2;
         var instantCost:int = GetShinyCost(id,level);
         if(BASE._credits.Get() < instantCost)
         {
            POPUPS.DisplayGetShiny();
            return;
         }
         ACADEMY._upgrades[id].powerup = level;
         if(GLOBAL._mode == "build")
         {
            GLOBAL._playerCreatureUpgrades[id].powerup = level;
         }
         this._upgradeLevel = level;
         LOGGER.Stat([48,id.substr(1),level]);
         if(GLOBAL._mode == "build")
         {
            Post = function():*
            {
               if(_upgradeLevel == 1)
               {
                  GLOBAL.CallJS("sendFeed",["lab-powerup",KEYS.Get(_powerupProps[_streamUpgradeCache].stream[0]),KEYS.Get(_powerupProps[_streamUpgradeCache].stream[1],{"v1":powerName}),_powerupProps[_streamUpgradeCache].streampic,0]);
               }
               else
               {
                  GLOBAL.CallJS("sendFeed",["lab-powerup",KEYS.Get(_powerupProps[_streamUpgradeCache].stream[0]),KEYS.Get(_powerupProps[_streamUpgradeCache].stream[2],{"v1":_upgradeLevel}),_powerupProps[_streamUpgradeCache].streampic,0]);
               }
               POPUPS.Next();
            };
            powerName = KEYS.Get(_powerupProps[id].name);
            popupMC = new popup_monster();
            popupMC.tText.htmlText = "<b>" + KEYS.Get("lab_powerup_complete",{
               "v1":powerName,
               "v2":level
            }) + "</b>";
            popupMC.bAction.SetupKey("btn_warnyourfriends");
            popupMC.bAction.addEventListener(MouseEvent.CLICK,Post);
            popupMC.bAction.Highlight = true;
            popupMC.bSpeedup.visible = false;
            POPUPS.Push(popupMC,null,null,null,"" + id + "-LAB-150.png");
            this._streamUpgradeCache = id;
         }
         if(_upgrading)
         {
            _upgrading = null;
         }
         BASE.Purchase("IPU",instantCost,"monsterlab");
      }
      
      override public function Render(param1:String = "") : *
      {
         var ImageCallback:Function;
         var imageDataA:Object = null;
         var imageDataB:Object = null;
         var imageLevel:int = 0;
         var i:int = 0;
         var loadImages:Array = null;
         var state:String = param1;
         if(_renderState == null || state != _renderState || _lvl.Get() != _renderLevel)
         {
            ImageCallback = function(param1:Array, param2:String):*
            {
               var _loc3_:Array = null;
               var _loc4_:String = null;
               var _loc5_:BitmapData = null;
               var _loc6_:BuildingAssetContainer = null;
               var _loc7_:DisplayObject = null;
               if(param2 == _renderState)
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
                        SOUNDS.Play(SOUNDS.DestroySoundIDForLevel(_lvl.Get()));
                        Smoke.CreatePoof(new Point(x,y + _middle),_middle,1);
                        Smoke.CreateStream(new Point(x,y + _middle));
                     }
                     if(state == "damaged" && _lastLoadedState == "")
                     {
                        SOUNDS.Play(SOUNDS.DamageSoundIDForLevel(_lvl.Get()));
                        Smoke.CreatePoof(new Point(x,y + _middle),_middle,0.5);
                     }
                  }
                  _lastLoadedState = state;
                  _mc.removeEventListener(Event.ENTER_FRAME,TickFast);
                  for each(_loc3_ in param1)
                  {
                     _loc4_ = _loc3_[0];
                     _loc5_ = _loc3_[1];
                     if(Boolean(imageDataB["shadow" + state]) && imageDataA.baseurl + imageDataB["shadow" + state][0] == _loc4_)
                     {
                        _loc6_ = _mcBase;
                        _loc6_.Clear();
                        _loc7_ = _loc6_.addChild(new Bitmap(_loc5_));
                        _loc7_.blendMode = "multiply";
                        _loc7_.x = imageDataB["shadow" + state][1].x;
                        _loc7_.y = imageDataB["shadow" + state][1].y;
                     }
                     else if(Boolean(imageDataB["top" + state]) && imageDataA.baseurl + imageDataB["top" + state][0] == _loc4_)
                     {
                        _loc6_ = topContainer;
                        _loc6_.Clear();
                        _loc6_.addChild(new Bitmap(_loc5_));
                        _loc6_.x = imageDataB["top" + state][1].x;
                        _loc6_.y = imageDataB["top" + state][1].y;
                        _mcHit.gotoAndStop("f" + imageLevel + state);
                        if(state == "destroyed")
                        {
                           _mcHit.gotoAndStop("f" + state);
                        }
                        _mcHit.x = _loc6_.x;
                        _mcHit.y = _loc6_.y;
                     }
                     else if(Boolean(imageDataB["anim" + state]) && imageDataA.baseurl + imageDataB["anim" + state][0] == _loc4_)
                     {
                        _animBMD = _loc5_;
                        _animLoaded = true;
                        _loc6_ = animContainer;
                        _loc6_.Clear();
                        _animRect = imageDataB["anim" + state][1];
                        _animFrames = imageDataB["anim" + state][2];
                        _animTick = int(Math.random() * (_animFrames - 2));
                        _animContainerBMD = new BitmapData(_animRect.width,_animRect.height,true,0xffffff);
                        _loc6_.addChild(new Bitmap(_animContainerBMD));
                        _loc6_.x = _animRect.x;
                        _loc6_.y = _animRect.y;
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
                           _mcHit.x = _loc6_.x;
                           _mcHit.y = _loc6_.y;
                        }
                     }
                     else if(Boolean(imageDataB["anim2" + state]) && imageDataA.baseurl + imageDataB["anim2" + state][0] == _loc4_)
                     {
                        _anim2BMD = _loc5_;
                        _anim2Loaded = true;
                        _loc6_ = anim2Container;
                        _loc6_.Clear();
                        _anim2Rect = imageDataB["anim2" + state][1];
                        _anim2Frames = imageDataB["anim2" + state][2];
                        _anim2Tick = int(Math.random() * (_anim2Frames - 2));
                        _anim2ContainerBMD = new BitmapData(_anim2Rect.width,_anim2Rect.height,true,0xffffff);
                        _loc6_.addChild(new Bitmap(_anim2ContainerBMD));
                        _loc6_.x = _anim2Rect.x;
                        _loc6_.y = _anim2Rect.y;
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
                           _mcHit.x = _loc6_.x;
                           _mcHit.y = _loc6_.y;
                        }
                     }
                     else if(Boolean(imageDataB["anim3" + state]) && imageDataA.baseurl + imageDataB["anim3" + state][0] == _loc4_)
                     {
                        _anim3BMD = _loc5_;
                        _anim3Loaded = true;
                        _loc6_ = anim3Container;
                        _loc6_.Clear();
                        _anim3Rect = imageDataB["anim3" + state][1];
                        _anim3Frames = imageDataB["anim3" + state][2];
                        _anim3Tick = int(Math.random() * (_anim3Frames - 2));
                        _anim3ContainerBMD = new BitmapData(_anim3Rect.width,_anim3Rect.height,true,0xffffff);
                        _loc6_.addChild(new Bitmap(_anim3ContainerBMD));
                        _loc6_.x = _anim3Rect.x;
                        _loc6_.y = _anim3Rect.y;
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
                           _mcHit.x = _loc6_.x;
                           _mcHit.y = _loc6_.y;
                        }
                     }
                     else if(imageDataB.topdestroyedfire && _oldRenderState == "damaged" && !GLOBAL._catchup && imageDataA.baseurl + imageDataB.topdestroyedfire[0] == _loc4_)
                     {
                        Fire.Add(_mc,new Bitmap(_loc5_),new Point(imageDataB.topdestroyedfire[1].x,imageDataB.topdestroyedfire[1].y));
                     }
                  }
               }
            };
            _renderLevel = _lvl.Get();
            imageDataA = GLOBAL._buildingProps[_type - 1].imageData;
            if(_lvl.Get() == 0)
            {
               imageDataB = imageDataA[1];
               imageLevel = 1;
            }
            else if(imageDataA[_lvl.Get()])
            {
               imageDataB = imageDataA[_lvl.Get()];
               imageLevel = _lvl.Get();
            }
            else
            {
               i = _lvl.Get() - 1;
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
            _oldRenderState = _renderState;
            _renderState = state;
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
               _animLoaded = false;
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
               ImageCache.GetImageGroupWithCallBack("b" + _type + "-" + imageLevel + state,loadImages,ImageCallback,true,2,state);
            }
         }
      }
      
      override public function AnimFrame(param1:Boolean = true) : *
      {
         var increment:Boolean = param1;
         try
         {
            if(!GLOBAL._catchup && Boolean(_animBMD))
            {
               _animContainerBMD.copyPixels(_animBMD,new Rectangle(_animRect.width * _animTick,0,_animRect.width,_animRect.height),new Point(0,0));
               if(increment)
               {
                  ++_animTick;
                  if(_animTick >= _animFrames)
                  {
                     _animTick = 0;
                  }
               }
            }
            if(!GLOBAL._catchup && Boolean(this._anim2BMD))
            {
               this._anim2ContainerBMD.copyPixels(this._anim2BMD,new Rectangle(this._anim2Rect.width * this._anim2Tick,0,this._anim2Rect.width,this._anim2Rect.height),new Point(0,0));
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
               this._anim3ContainerBMD.copyPixels(this._anim3BMD,new Rectangle(this._anim3Rect.width * this._anim2Tick,0,this._anim3Rect.width,this._anim3Rect.height),new Point(0,0));
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
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         if(param1.upg)
         {
            _upgrading = param1.upg;
         }
         if(param1.upt)
         {
            this._upgradeFinishTime = new SecNum(param1.upt);
         }
         if(param1.upl)
         {
            this._upgradeLevel = param1.upl;
         }
         if(_countdownBuild.Get() <= 0)
         {
            GLOBAL._bLab = this;
         }
         if(_countdownBuild.Get() + _countdownUpgrade.Get() + _repairing == 0)
         {
            CatchupRemove();
         }
      }
      
      override public function Export() : *
      {
         var _loc1_:* = super.Export();
         if(_upgrading)
         {
            _loc1_.upg = _upgrading;
         }
         if(Boolean(this._upgradeFinishTime) && this._upgradeFinishTime.Get() > 0)
         {
            _loc1_.upt = this._upgradeFinishTime.Get();
         }
         if(this._upgradeLevel)
         {
            _loc1_.upl = this._upgradeLevel;
         }
         return _loc1_;
      }
   }
}

