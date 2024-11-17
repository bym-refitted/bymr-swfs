package
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import com.computus.model.Timekeeper;
   import com.gskinner.utils.Rndm;
   import com.monsters.ai.WMBASE;
   import com.monsters.chat.BYMChat;
   import com.monsters.chat.ui.ChatBox;
   import com.monsters.display.ImageCache;
   import com.monsters.effects.fire.Fire;
   import com.monsters.effects.smoke.Smoke;
   import com.monsters.maproom_advanced.MapRoom;
   import com.monsters.pathing.PATHING;
   import com.monsters.ui.UI_BOTTOM;
   import flash.display.*;
   import flash.events.*;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.*;
   import flash.utils.*;
   import gs.TweenLite;
   import gs.easing.Cubic;
   
   public class GLOBAL
   {
      public static var _softversion:int;
      
      public static var _mapVersion:int;
      
      public static var _mailVersion:int;
      
      public static var _soundVersion:int;
      
      public static var _languageVersion:int;
      
      public static var _halt:Boolean;
      
      public static var _frameNumber:int;
      
      public static var _friendCount:int;
      
      public static var _sessionCount:int;
      
      public static var _addTime:int;
      
      public static var _bymChat:BYMChat;
      
      public static var _proTip:PROTIP_CLIP;
      
      public static var _ROOT:MovieClip;
      
      public static var _BASESELECT:MovieClip;
      
      public static var _MAP:MovieClip;
      
      public static var _UI:MovieClip;
      
      public static var _hashes:Object;
      
      public static var _layerMap:*;
      
      public static var _layerUI:*;
      
      public static var _layerWindows:*;
      
      public static var _layerMessages:*;
      
      public static var _layerProjectiles:*;
      
      public static var _layerTop:*;
      
      public static var _layerTicker:Sprite;
      
      public static var _layerArr:Array;
      
      public static var _SCREEN:Rectangle;
      
      public static var _SCREENCENTER:Point;
      
      public static var _SCREENHUD:Point;
      
      public static var t:int;
      
      public static var _baseURL:String;
      
      public static var _baseURL2:String;
      
      public static var _infBaseURL:String;
      
      public static var _apiURL:String;
      
      public static var _gameURL:String;
      
      public static var _storageURL:String;
      
      public static var _allianceURL:String;
      
      public static var _soundPathURL:String;
      
      public static var _mapURL:String;
      
      public static var _statsURL:String;
      
      public static var _chatServer:String;
      
      public static var _appid:String;
      
      public static var _tpid:String;
      
      public static var _monetized:int;
      
      public static var _fbdata:Object;
      
      public static var _degtorad:*;
      
      public static var _radtodeg:*;
      
      public static var _selectedBuilding:*;
      
      public static var _newBuilding:*;
      
      public static var _DROPZONE:*;
      
      public static var _render:*;
      
      public static var _matter:*;
      
      public static var _matterMax:*;
      
      public static var _myCreatures:*;
      
      public static var _myBaseID:*;
      
      public static var _creatureParts:Array;
      
      public static var _running:*;
      
      public static var _mode:String;
      
      public static var _loadmode:String;
      
      public static var _mapWidth:int;
      
      public static var _mapHeight:int;
      
      public static var _pleaseWait:*;
      
      public static var _resourceNames:Array;
      
      public static var _bProspectorCount:int;
      
      public static var _bMinerCount:int;
      
      public static var _bStoreCount:int;
      
      public static var _bResearchCount:int;
      
      public static var _bCreatureCount:int;
      
      public static var _bMapCount:int;
      
      public static var _bPowerCount:int;
      
      public static var _bProspector:*;
      
      public static var _bMassivePumpkin:BFOUNDATION;
      
      public static var _bTownhall:BFOUNDATION;
      
      public static var _bRadio:BFOUNDATION;
      
      public static var _bStore:BFOUNDATION;
      
      public static var _bResearch:BFOUNDATION;
      
      public static var _bDesign:BFOUNDATION;
      
      public static var _bMap:BFOUNDATION;
      
      public static var _bLocker:BFOUNDATION;
      
      public static var _bAcademy:BFOUNDATION;
      
      public static var _bHousing:BFOUNDATION;
      
      public static var _bHatchery:*;
      
      public static var _bFlinger:*;
      
      public static var _bCatapult:*;
      
      public static var _bHatcheryCC:*;
      
      public static var _bJuicer:*;
      
      public static var _bBaiter:*;
      
      public static var _bYardPlanner:*;
      
      public static var _bChamber:BFOUNDATION;
      
      public static var _bLab:BFOUNDATION;
      
      public static var _bCage:CHAMPIONCAGE;
      
      public static var _bTower:*;
      
      public static var _bTowerCount:int;
      
      public static var _mineCount:int;
      
      public static var _catchup:Boolean;
      
      public static var _researchTime:Number;
      
      public static var _buildTime:Number;
      
      public static var _autoRebuild:Boolean;
      
      public static var _upgradePacking:Number;
      
      public static var _hatcheryOverdrive:int;
      
      public static var _harvesterOverdrive:int;
      
      public static var _extraHousing:int;
      
      public static var _lockerOverdrive:int;
      
      public static var _designSlots:int;
      
      public static var _creepCount:int;
      
      public static var _fullScreen:Boolean;
      
      public static var _timekeeper:Timekeeper;
      
      public static var _buildingProps:Array;
      
      public static var _infernoYardProps:Array;
      
      public static var _infernoOutpostProps:Array;
      
      public static var _fps:int;
      
      public static var _mapHome:Point;
      
      public static var _attackerCreatures:Object;
      
      public static var _attackerCreatureUpgrades:Object;
      
      public static var _playerCreatureUpgrades:Object;
      
      public static var _attackersResources:Object;
      
      public static var _hpAttackersResources:Object;
      
      public static var _attackersCredits:SecNum;
      
      public static var _attackersFlinger:int;
      
      public static var _attackersCatapult:int;
      
      public static var _currentCell:*;
      
      public static var _savedAttackersDeltaResources:Object;
      
      public static var _attackersDeltaResources:Object;
      
      public static var _homeBaseID:int;
      
      public static var lastTime:Number;
      
      public static var _flags:Object;
      
      public static var _unreadMessages:int;
      
      public static var _globalticks:int;
      
      public static var _averageAltitude:SecNum;
      
      public static var _outpostCapacity:SecNum;
      
      public static var _displayedWhatsNew:Boolean;
      
      public static var _displayedPromoNew:Boolean;
      
      public static var _credits:SecNum;
      
      public static var _local:Boolean = false;
      
      public static var _save:Boolean = true;
      
      public static var _testKongregate:Boolean = false;
      
      public static var _localMode:int = 0;
      
      public static var _version:SecNum = new SecNum(123);
      
      public static var _aiDesignMode:Boolean = false;
      
      public static var _chatroomNumber:Number = 0;
      
      public static const NUM_CHAT_ROOMS:int = 5 * 60;
      
      public static var _chatInited:Boolean = false;
      
      public static var _chatEnabled:Boolean = true;
      
      public static var _validName:Boolean = true;
      
      public static var _checkPromo:int = 1;
      
      public static var _giveTips:int = 1;
      
      public static var _fluidWidthEnabled:Boolean = true;
      
      public static var _SCREENINIT:Rectangle = new Rectangle(0,0,760,670);
      
      public static var _countryCode:String = "us";
      
      public static var _shinyShroomCount:int = 0;
      
      private static var _shinyShrooms:Array = [];
      
      public static var _shinyShroomValid:Boolean = false;
      
      public static var _allianceConquestTime:SecNum = new SecNum(0);
      
      public static var _allianceDeclareWarTime:SecNum = new SecNum(0);
      
      public static var _openBase:Object = null;
      
      public static var _chatServers:Array = null;
      
      public static var _chatBlackList:Array = null;
      
      public static var _chatWhiteList:Array = null;
      
      public static var _countryCodeBlackList:Array = null;
      
      public static var _newMapFirstOpen:Boolean = false;
      
      public static var iresourceNames:Array = ["#r_bone#","#r_coal#","#r_sulfur#","#r_magma#","#r_shiny#","#r_time#"];
      
      public static var _muted:Boolean = false;
      
      public static var _newThings:Boolean = false;
      
      public static var _reloadonerror:Boolean = false;
      
      public static var _hatcheryOverdrivePower:SecNum = new SecNum(0);
      
      public static var _harvesterOverdrivePower:SecNum = new SecNum(0);
      
      public static var _extraHousingPower:SecNum = new SecNum(0);
      
      public static var _towerOverdrive:SecNum = new SecNum(0);
      
      public static var _monsterOverdrive:SecNum = new SecNum(0);
      
      public static var _attackerMonsterOverdrive:SecNum = new SecNum(0);
      
      public static var _playerMonsterOverdrive:SecNum = new SecNum(0);
      
      public static var _monsterDefenseOverdrive:SecNum = new SecNum(0);
      
      public static var _attackerMonsterDefenseOverdrive:SecNum = new SecNum(0);
      
      public static var _playerMonsterDefenseOverdrive:SecNum = new SecNum(0);
      
      public static var _monsterSpeedOverdrive:SecNum = new SecNum(0);
      
      public static var _attackerMonsterSpeedOverdrive:SecNum = new SecNum(0);
      
      public static var _playerMonsterSpeedOverdrive:SecNum = new SecNum(0);
      
      public static var _FPSframecount:int = 0;
      
      public static var _FPStimestamp:int = 0;
      
      public static var _FPSarray:Array = [];
      
      public static var _mapOutpost:Array = [];
      
      public static var _mapOutpostIDs:Array = [];
      
      public static var _advancedMap:int = 0;
      
      public static var _wmCreaturePowerups:Array = new Array();
      
      public static var _wmCreatureLevels:Array = new Array();
      
      public static var _playerGuardianData:Object = null;
      
      public static var _myMapRoom:int = 0;
      
      public static var _empireDestroyed:int = 0;
      
      public static var _empireDestroyedShown:Boolean = false;
      
      public static var _attackerMapCreatures:Object = {};
      
      public static var _attackerMapResources:Object = {};
      
      public static var _attackerCellsInRange:Array = [];
      
      public static var _attackerMapCreaturesStart:Object = {};
      
      public static var _attackerMapResourcesStart:Object = {};
      
      public static var _showMapWaiting:int = 0;
      
      public static var _resources:Object = {};
      
      public static var _hpResources:Object = {};
      
      public static var _yardResources:Object = {};
      
      public static var _loops:int = 10;
      
      public static var _maxLoops:int = 800;
      
      public static var _loopsBanked:int = 0;
      
      public static var _zoomed:Boolean = false;
      
      public static var _timePlayed:int = 0;
      
      public static var _promptedInvite:Boolean = false;
      
      public static var _promptedAFK:Boolean = false;
      
      public static var _pointedInvite:Boolean = false;
      
      public static var _pointedGift:Boolean = false;
      
      public static var _canInvite:Boolean = false;
      
      public static var _canGift:Boolean = false;
      
      public static var _whatsnewid:int = 0;
      
      public static var _lastWhatsNew:int = 1048;
      
      public static var _afktimer:SecNum = new SecNum(0);
      
      public static var _oldMousePoint:Point = new Point(0,0);
      
      public static var _otherStats:Object = {};
      
      public static var _baseLoads:int = 0;
      
      public static var _fbPromoTimer:Number = 604800;
      
      public static var _inInferno:int = 0;
      
      public static const ERROR_OOPS_ONLY:int = 0;
      
      public static const ERROR_OOPS_AND_ORANGE_BOX:int = 1;
      
      public static const ERROR_ORANGE_BOX_ONLY:int = 2;
      
      public static var _showStreamlinedSpeedUps:Boolean = false;
      
      private static var _blockerList:Array = [];
      
      public function GLOBAL()
      {
         super();
      }
      
      public static function SetBuildingProps() : *
      {
         switch(BASE._yardType)
         {
            case BASE.INFERNO_YARD:
               _buildingProps = INFERNOYARDPROPS._infernoYardProps;
               break;
            case BASE.OUTPOST:
               _buildingProps = OUTPOST_YARD_PROPS._outpostProps;
               break;
            default:
               _buildingProps = YARD_PROPS._yardProps;
         }
         if(Boolean(GLOBAL._flags.viximo) || Boolean(GLOBAL._flags.kongregate))
         {
            YARD_PROPS._yardProps[112].block = true;
            OUTPOST_YARD_PROPS._outpostProps[112].block = true;
         }
      }
      
      public static function Setup(param1:String = "build") : *
      {
         var _loc3_:String = null;
         _loadmode = param1;
         var _loc2_:String = param1;
         if(_loc2_ == "build" || _loc2_ == "view" || _loc2_ == "attack" || _loc2_ == "help" || _loc2_ == "wmview" || _loc2_ == "wmattack")
         {
            _mode = param1;
         }
         else if(param1 == "ibuild" || param1 == "iview" || param1 == "iattack" || param1 == "ihelp" || param1 == "iwmview" || param1 == "iwmattack")
         {
            switch(param1)
            {
               case "ibuild":
                  _loc2_ = "build";
                  break;
               case "iview":
                  _loc2_ = "view";
                  break;
               case "iattack":
                  _loc2_ = "attack";
                  break;
               case "ihelp":
                  _loc2_ = "help";
                  break;
               case "iwmview":
                  _loc2_ = "wmview";
                  break;
               case "iwmattack":
                  _loc2_ = "wmattack";
            }
            _mode = _loc2_;
         }
         _fps = 40;
         _FPSframecount = 0;
         _FPSarray = [];
         _FPStimestamp = 0;
         ImageCache.prependImagePath = GLOBAL._storageURL;
         if(!_timekeeper)
         {
            _timekeeper = new Timekeeper();
         }
         _timekeeper.startTicking();
         _halt = false;
         _mapWidth = 800;
         _mapHeight = 800;
         _globalticks = 0;
         _zoomed = false;
         _averageAltitude = new SecNum(125);
         _outpostCapacity = new SecNum(2000000);
         _attackersCatapult = 0;
         _attackersFlinger = 0;
         _savedAttackersDeltaResources = {
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0)
         };
         _attackersDeltaResources = {"dirty":false};
         _attackerMonsterOverdrive = new SecNum(0);
         if(_mode != "build")
         {
            _attackerCreatures = HOUSING._creatures;
            _attackerCreatureUpgrades = _playerCreatureUpgrades;
            HOUSING.Cull();
            _attackersResources = GLOBAL._resources;
            _hpAttackersResources = GLOBAL._hpResources;
            _attackerMonsterOverdrive = new SecNum(GLOBAL._playerMonsterOverdrive.Get());
            _attackerMonsterDefenseOverdrive = new SecNum(GLOBAL._playerMonsterDefenseOverdrive.Get());
            _attackerMonsterSpeedOverdrive = new SecNum(GLOBAL._playerMonsterSpeedOverdrive.Get());
            if(BASE._credits)
            {
               _attackersCredits = new SecNum(BASE._credits.Get());
            }
            else
            {
               _attackersCredits = new SecNum(0);
            }
            if(GLOBAL._bFlinger != null)
            {
               _attackersFlinger = GLOBAL._bFlinger._lvl.Get();
            }
            if(GLOBAL._bCatapult != null)
            {
               _attackersCatapult = GLOBAL._bCatapult._lvl.Get();
            }
            if(BASE.isInferno() && GLOBAL._bHousing != null)
            {
               _attackersFlinger = GLOBAL._bHousing._lvl.Get();
            }
            ATTACK._countdown = 300;
            if(Boolean(GLOBAL._advancedMap) && Boolean(POWERUPS.CheckPowers(POWERUPS.ALLIANCE_DECLAREWAR,"NORMAL")))
            {
               ATTACK._countdown = 420;
            }
            if(_mode == _loadmode)
            {
               if(Boolean(_advancedMap) && (_mode == "attack" || _mode == "wmattack"))
               {
                  _attackerMapCreaturesStart = {};
                  for(_loc3_ in _attackerMapCreatures)
                  {
                     _attackerMapCreaturesStart[_loc3_] = new SecNum(_attackerMapCreatures[_loc3_].Get());
                  }
                  _attackersCatapult = _attackerMapResources.catapult.Get();
                  _attackersFlinger = !!POWERUPS.CheckPowers(POWERUPS.ALLIANCE_DECLAREWAR,"OFFENSE") ? int(_attackerMapResources.flinger.Get() - 2) : int(_attackerMapResources.flinger.Get());
               }
            }
         }
         if(_mode == "help" || _mode == "ihelp")
         {
            _myMapRoom = 0;
            if(_bMap)
            {
               _myMapRoom = _bMap._lvl.Get();
            }
         }
         switch(_loadmode)
         {
            case "iattack":
            case "iwmattack":
               SOUNDS.PlayMusic("musiciattack");
               break;
            case "ibuild":
            case "ihelp":
            case "iview":
               SOUNDS.PlayMusic("musicibuild");
               break;
            case "attack":
            case "wmattack":
               SOUNDS.PlayMusic("musicattack");
               break;
            case "build":
            case "help":
            case "view":
            default:
               SOUNDS.PlayMusic("musicbuild");
         }
         _degtorad = 0.0174532925;
         _radtodeg = 57.2957795;
         _render = false;
         _creepCount = 0;
         _timePlayed = 0;
         if(_loadmode == _mode)
         {
            _resourceNames = ["#r_twigs#","#r_pebbles#","#r_putty#","#r_goo#","#r_shiny#","#r_time#"];
         }
         else
         {
            _resourceNames = iresourceNames;
         }
         _creatureParts = [{
            "part":"torso",
            "costs":[0,7200,14400,21600],
            "matter":[10,20,30,40]
         },{
            "part":"head",
            "costs":[0,7200,14400,21600],
            "matter":[10,20,30,40]
         },{
            "part":"arm",
            "costs":[0,7200,14400,21600],
            "matter":[10,20,30,40]
         },{
            "part":"leg",
            "costs":[0,7200,14400,21600],
            "matter":[10,20,30,40]
         }];
         BASE.Setup();
      }
      
      public static function Clear() : void
      {
         _bBaiter = null;
         _bFlinger = null;
         _bCatapult = null;
         _bHatchery = null;
         _bHatcheryCC = null;
         _bHousing = null;
         _bJuicer = null;
         _bLocker = null;
         _bTower = null;
         _bMap = null;
         _bStore = null;
         _bTownhall = null;
         _bRadio = null;
      }
      
      public static function WaitShow(param1:String = "") : *
      {
         PLEASEWAIT.Show(KEYS.Get("wait_processing"));
      }
      
      public static function WaitHide() : *
      {
         PLEASEWAIT.Hide();
      }
      
      public static function goFullScreen(param1:MouseEvent = null) : *
      {
         if(_ROOT.stage.displayState == StageDisplayState.NORMAL)
         {
            _ROOT.stage.displayState = StageDisplayState.FULL_SCREEN;
            UI2._top.mcZoom.gotoAndStop(3);
         }
         else
         {
            UI2._top.mcZoom.gotoAndStop(1);
            _ROOT.stage.displayState = StageDisplayState.NORMAL;
            ThrowStackTrace("goFullScreen");
         }
         _zoomed = false;
         MAP._GROUND.scaleY = 1;
         MAP._GROUND.scaleX = 1;
         MAP.Focus(0,0);
         RefreshScreen();
         UI_BOTTOM.Resize();
      }
      
      public static function Zoom(param1:MouseEvent = null) : *
      {
         if(_ROOT.stage.displayState != StageDisplayState.FULL_SCREEN)
         {
            BASE.BuildingDeselect();
            MAP.FocusTo(0,0,0.4);
            if(_zoomed)
            {
               _zoomed = false;
               UI2._top.mcZoom.gotoAndStop(1);
               TweenLite.to(MAP._GROUND,0.4,{
                  "scaleX":1,
                  "scaleY":1,
                  "ease":Cubic.easeInOut,
                  "overwrite":false
               });
            }
            else
            {
               _zoomed = true;
               UI2._top.mcZoom.gotoAndStop(2);
               TweenLite.to(MAP._GROUND,0.4,{
                  "scaleX":0.5,
                  "scaleY":0.5,
                  "ease":Cubic.easeInOut,
                  "overwrite":false
               });
            }
         }
      }
      
      public static function Tick() : *
      {
         var buildingsAll:Object = null;
         var b:BFOUNDATION = null;
         var tmpStored:int = 0;
         var tmpCountdown:int = 0;
         var whichmap:int = 0;
         var isOutpost:int = 0;
         if(!_halt && !GLOBAL._catchup)
         {
            t += 1;
            if(MapRoom._open)
            {
               try
               {
                  MapRoom.Tick();
                  LOGGER.Tick();
                  MAILBOX.Tick();
                  AFK();
               }
               catch(e:Error)
               {
                  LOGGER.Log("err","Global.Tick A: " + e.message + " | " + e.getStackTrace());
               }
            }
            else
            {
               ++_timePlayed;
               ++_globalticks;
               try
               {
                  buildingsAll = BASE._buildingsAll;
                  tmpStored = 0;
                  tmpCountdown = 0;
                  for each(b in buildingsAll)
                  {
                     if(b._class == "resource")
                     {
                        tmpStored = b._stored.Get();
                        tmpCountdown = b._countdownProduce.Get();
                     }
                     b.Tick();
                     if(b._class == "resource")
                     {
                        if(tmpCountdown > 1 && tmpStored != b._stored.Get())
                        {
                           LOGGER.Log("log","BRESOURCE.StoredB " + tmpStored + " - " + b._stored.Get());
                           GLOBAL.ErrorMessage("BRESOURCE.StoredB");
                           return;
                        }
                     }
                  }
               }
               catch(e:Error)
               {
                  LOGGER.Log("err","Global.Tick B: " + e.message + " | " + e.getStackTrace());
               }
               try
               {
                  UPDATES.Check();
                  CREATURELOCKER.Tick();
                  HATCHERY.Tick();
                  HATCHERYCC.Tick();
               }
               catch(e:Error)
               {
                  LOGGER.Log("err","Global.Tick C: " + e.message + " | " + e.getStackTrace());
               }
               try
               {
                  STORE.ProcessPurchases();
                  BASE.Tick();
                  HOUSING.Update();
                  ACADEMY.Tick();
               }
               catch(e:Error)
               {
                  LOGGER.Log("err","Global.Tick D: " + e.message + " | " + e.getStackTrace());
               }
               try
               {
                  if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
                  {
                     ATTACK.Tick();
                  }
               }
               catch(e:Error)
               {
                  LOGGER.Log("err","Global.Tick E: " + e.message + " | " + e.getStackTrace());
               }
               try
               {
                  QUEUE.Tick();
               }
               catch(e:Error)
               {
                  LOGGER.Log("err","Global.Tick F: " + e.message + " | " + e.getStackTrace());
               }
               try
               {
                  UI2.Update();
               }
               catch(e:Error)
               {
                  LOGGER.Log("err","Global.Tick G: " + e.message + " | " + e.getStackTrace());
               }
               try
               {
                  LOGGER.Tick();
                  MAILBOX.Tick();
               }
               catch(e:Error)
               {
                  LOGGER.Log("err","Global.Tick H: " + e.message + " | " + e.getStackTrace());
               }
               try
               {
                  AFK();
                  MONSTERBAITER.Tick();
                  MONSTERBUNKER.Tick();
                  if(_mode == "wmattack" || _mode == "wmview")
                  {
                     WMBASE.Tick();
                  }
               }
               catch(e:Error)
               {
                  LOGGER.Log("err","Global.Tick I: " + e.message + " | " + e.getStackTrace());
               }
            }
         }
         if(_showMapWaiting && BASE._saveCounterA == BASE._saveCounterB && !BASE._saving)
         {
            whichmap = _showMapWaiting;
            _showMapWaiting = 0;
            PLEASEWAIT.Hide();
            MapRoom.ShowDelayed();
         }
         if(BASE._needCurrentCell && GLOBAL._currentCell)
         {
            PLEASEWAIT.Hide();
            BASE._needCurrentCell = false;
            isOutpost = GLOBAL._currentCell._base == 3 ? BASE.OUTPOST : BASE.MAIN_YARD;
            BASE.LoadBase(null,null,GLOBAL._currentCell._baseID,"build",false,isOutpost);
         }
      }
      
      public static function TickFast(param1:Event) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:BFOUNDATION = null;
         if(!_halt)
         {
            _loc2_ = getTimer();
            SOUNDS.Tick();
            if(_render)
            {
               if(lastTime)
               {
                  _loopsBanked -= _loops;
                  if(_loopsBanked < 0)
                  {
                     _loopsBanked = 0;
                  }
                  _loopsBanked += 0.08 * (new Date().getTime() - lastTime);
                  _loops = _loopsBanked;
                  if(_loops > _maxLoops)
                  {
                     _loops = _maxLoops;
                  }
               }
               else
               {
                  _loops = 2;
               }
               lastTime = new Date().getTime();
               _loc3_ = getTimer();
               if(!MapRoom._open)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loops)
                  {
                     _render = false;
                     if(_loc4_ == _loops - 1)
                     {
                        _render = true;
                     }
                     if(CREEPS._creepCount > 0)
                     {
                        CREEPS.Tick();
                        for each(_loc5_ in BASE._buildingsTowers)
                        {
                           _loc5_.TickAttack();
                        }
                     }
                     CREATURES.Tick();
                     if(CREATURES._guardian)
                     {
                        if(CREATURES._guardian.Tick())
                        {
                           MAP._BUILDINGTOPS.removeChild(CREATURES._guardian);
                           CREATURES._guardian.Clear();
                           CREATURES._guardian = null;
                        }
                     }
                     PROJECTILES.Tick();
                     FIREBALLS.Tick();
                     _loc4_++;
                  }
               }
               ++_frameNumber;
               _loc2_ = getTimer();
               if(!MapRoom._open)
               {
                  WORKERS.Tick();
                  EFFECTS.Tick();
                  WMATTACK.Tick();
                  MAPROOM.Tick();
                  TUTORIAL.Tick();
                  PATHING.Tick();
                  Smoke.Tick();
                  Fire.Tick();
                  BASE.ShakeB();
               }
               if(_flags.logfps)
               {
                  if(_FPSframecount == 2400)
                  {
                     LogFPS();
                  }
                  else if(_FPSframecount > 80 && _FPSframecount % 40 == 0)
                  {
                     _fps = int(1000 / ((_loc2_ - _FPStimestamp) / 40));
                     if(_FPStimestamp > 0)
                     {
                        _FPSarray.push({"fps":_fps});
                     }
                     _FPStimestamp = _loc2_;
                  }
               }
               else if(_FPSframecount % 40 == 0)
               {
                  _fps = int(1000 / ((_loc2_ - _FPStimestamp) / 40));
                  _FPStimestamp = _loc2_;
               }
               _FPSframecount += 1;
               if(_frameNumber % 3 == 0)
               {
                  MAP.SortDepth();
               }
            }
            else
            {
               _loops = 4;
            }
         }
         else
         {
            lastTime = 0;
            _loops = 4;
         }
      }
      
      public static function LogFPS() : *
      {
         var min:int = 0;
         var max:int = 0;
         var average:int = 0;
         try
         {
            if(_flags.logfps)
            {
               _FPSarray.sortOn("fps",Array.NUMERIC);
               min = int(_FPSarray[0].fps);
               max = int(_FPSarray[_FPSarray.length - 1].fps);
               average = int(_FPSarray[_FPSarray.length * 0.5].fps);
               LOGGER.Log("fr" + GLOBAL._mode.substr(0,1),GLOBAL.dd(min).toString() + "," + GLOBAL.dd(max).toString() + "," + GLOBAL.dd(average).toString());
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public static function Timestamp() : *
      {
         return t;
      }
      
      public static function ShowMap(param1:MouseEvent = null) : *
      {
         if(BASE._yardType >= BASE.INFERNO_YARD)
         {
            BASE._needCurrentCell = false;
            MAPROOM_INFERNO.Setup();
            MAPROOM_INFERNO.Show();
         }
         else if(GLOBAL._advancedMap)
         {
            BASE._needCurrentCell = false;
            MapRoom.Setup(_mapHome,MapRoom._worldID,MapRoom._inviteBaseID,MapRoom._viewOnly);
            MapRoom.Show();
         }
         else
         {
            MAPROOM.Setup();
            MAPROOM.Show();
         }
      }
      
      public static function OpenMap(param1:String) : void
      {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
         if(_loc2_.status)
         {
            if(_loc2_.status == "open")
            {
               GLOBAL.ShowMap();
            }
            else
            {
               GLOBAL.ErrorMessage(_loc2_.error_message,ERROR_ORANGE_BOX_ONLY);
            }
         }
         else
         {
            LOGGER.Log("err","OpenMap " + param1);
         }
      }
      
      public static function ToTime(param1:int, param2:Boolean = false, param3:Boolean = true, param4:Boolean = true, param5:Boolean = false) : *
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 >= 24 * 60 * 60)
         {
            _loc6_ = Math.floor(param1 / 86400);
            param1 -= _loc6_ * 86400;
         }
         if(param1 >= 60 * 60)
         {
            _loc7_ = Math.floor(param1 / 3600);
            param1 -= _loc7_ * 3600;
         }
         if(param1 >= 60)
         {
            _loc8_ = Math.floor(param1 / 60);
            param1 -= _loc8_ * 60;
         }
         _loc9_ = param1;
         var _loc10_:* = "";
         if(param2)
         {
            if(_loc6_)
            {
               _loc10_ = _loc6_ + KEYS.Get("global_days_short") + " ";
            }
            if(Boolean(_loc7_) || Boolean(_loc6_) || param5)
            {
               _loc10_ += DoubleDigit(_loc7_) + KEYS.Get("global_hours_short") + " ";
            }
            if(Boolean(_loc8_) || Boolean(_loc7_) || Boolean(_loc6_) || param5)
            {
               _loc10_ += DoubleDigit(_loc8_) + KEYS.Get("global_minutes_short") + " ";
            }
            if(param3 || _loc6_ + _loc7_ + _loc8_ == 0 || param5)
            {
               _loc10_ += DoubleDigit(_loc9_) + KEYS.Get("global_seconds_short");
            }
         }
         else
         {
            if(_loc6_)
            {
               if(_loc6_ > 1)
               {
                  _loc10_ += _loc6_ + KEYS.Get("global_days") + " ";
               }
               else
               {
                  _loc10_ += _loc6_ + KEYS.Get("global_day") + " ";
               }
            }
            if(Boolean(_loc7_) || Boolean(_loc6_) || param5)
            {
               if(_loc7_ > 1)
               {
                  _loc10_ += _loc7_ + KEYS.Get("global_hours") + " ";
               }
               else
               {
                  _loc10_ += _loc7_ + KEYS.Get("global_hour") + " ";
               }
            }
            if(Boolean(_loc8_) || Boolean(_loc7_) || Boolean(_loc6_) || param5)
            {
               if(_loc8_ > 1)
               {
                  _loc10_ += _loc8_ + KEYS.Get("global_minutes") + " ";
               }
               else
               {
                  _loc10_ += _loc8_ + KEYS.Get("global_minute") + " ";
               }
            }
            if(_loc8_ > 0 || _loc7_ > 0 || _loc6_ == 0 || param5)
            {
               if(_loc9_ > 0 && (param3 || _loc6_ + _loc7_ + _loc8_ == 0))
               {
                  _loc10_ += dd(_loc9_) + KEYS.Get("global_seconds_short");
               }
            }
         }
         return _loc10_;
      }
      
      public static function dd(param1:*) : *
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return param1;
      }
      
      public static function ErrorMessage(param1:String = "", param2:int = 0) : *
      {
         var err:String = param1;
         var errortype:int = param2;
         var em:* = new ERRORMESSAGE();
         em.Show(err,errortype);
         return function(param1:MouseEvent = null):*
         {
         };
      }
      
      public static function Message(param1:String, param2:String = null, param3:Function = null, param4:Array = null, param5:String = null, param6:Function = null, param7:Array = null, param8:int = 1) : *
      {
         var _loc9_:* = new MESSAGE();
         _loc9_.Show(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public static function Confirm(param1:String, param2:String = null, param3:Function = null, param4:Array = null, param5:int = 1) : *
      {
         var _loc6_:* = new MESSAGE();
         _loc6_.Show(param1,param2,param3,param4,param5);
      }
      
      public static function FormatNumber(param1:Number) : *
      {
         var _loc4_:Number = NaN;
         param1 = Math.floor(param1);
         var _loc2_:String = param1.toString();
         var _loc3_:Array = new Array();
         var _loc5_:int = _loc2_.length;
         while(_loc5_ > 0)
         {
            _loc4_ = Math.max(_loc5_ - 3,0);
            _loc3_.unshift(_loc2_.slice(_loc4_,_loc5_));
            _loc5_ = _loc4_;
         }
         return _loc3_.join(",");
      }
      
      public static function DoubleDigit(param1:int) : *
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return param1.toString();
      }
      
      public static function NextCreepID() : *
      {
         ++_creepCount;
         return _creepCount;
      }
      
      public static function DataCheck(param1:*) : *
      {
         var h:String;
         var hid:int;
         var hash:String;
         var o:Object = null;
         var str:* = param1;
         var s:String = str;
         try
         {
            o = com.adobe.serialization.json.JSON.decode(s);
         }
         catch(e:Error)
         {
            o = {"error":"json error: " + e};
         }
         h = o.h;
         hid = int(o.hid);
         s = s.split(",\"h\":\"" + h + "\"").join("");
         s = s.split(",\"hid\":" + hid).join("");
         hash = MD5.hash("ilevbioghv890347ho3nrkljebv" + s + hid * (hid % 11));
         if(hash == h)
         {
            return true;
         }
         GLOBAL.ErrorMessage("Hash in Fail");
      }
      
      public static function Check() : *
      {
         var tmpArray:Array = null;
         var Push:Function = function(param1:int):*
         {
            var _loc3_:Array = null;
            var _loc4_:int = 0;
            var _loc5_:Array = null;
            var _loc2_:Object = _buildingProps[param1];
            if(_loc2_.group != 999)
            {
               tmpArray.push([_loc2_.id,_loc2_.type,_loc2_.size,_loc2_.cycle,_loc2_.attackgroup,_loc2_.quantity,_loc2_.produce,_loc2_.cycleTime,_loc2_.hp,_loc2_.repairTime]);
               if(_loc2_.capacity)
               {
                  tmpArray.push(_loc2_.capacity);
               }
               if(_loc2_.costs)
               {
                  _loc3_ = _loc2_.costs;
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.length)
                  {
                     tmpArray.push(_loc3_[_loc4_].r1);
                     tmpArray.push(_loc3_[_loc4_].r2);
                     tmpArray.push(_loc3_[_loc4_].r3);
                     tmpArray.push(_loc3_[_loc4_].r4);
                     tmpArray.push(_loc3_[_loc4_].r5);
                     tmpArray.push(_loc3_[_loc4_].time);
                     tmpArray.push(_loc3_[_loc4_].re);
                     _loc4_++;
                  }
               }
               if(_loc2_.fortify_costs)
               {
                  _loc5_ = _loc2_.fortify_costs;
                  _loc4_ = 0;
                  while(_loc4_ < _loc5_.length)
                  {
                     tmpArray.push(_loc5_[_loc4_].r1);
                     tmpArray.push(_loc5_[_loc4_].r2);
                     tmpArray.push(_loc5_[_loc4_].r3);
                     tmpArray.push(_loc5_[_loc4_].r4);
                     tmpArray.push(_loc5_[_loc4_].r5);
                     tmpArray.push(_loc5_[_loc4_].time);
                     tmpArray.push(_loc5_[_loc4_].re);
                     _loc4_++;
                  }
               }
            }
         };
         tmpArray = [];
         var i:* = 0;
         while(i < _buildingProps.length)
         {
            Push(i);
            i++;
         }
         return MD5.hash(com.adobe.serialization.json.JSON.encode(tmpArray));
      }
      
      public static function CallJS(param1:String, param2:Array = null, param3:Boolean = true) : *
      {
         var func:String = param1;
         var args:Array = param2;
         var exitFullScreen:Boolean = param3;
         if(exitFullScreen)
         {
            ThrowStackTrace("CallJS dropping out of full screen");
         }
         if(GLOBAL._local)
         {
            return;
         }
         try
         {
            if(exitFullScreen && _ROOT.stage.displayState == StageDisplayState.FULL_SCREEN)
            {
               GLOBAL._ROOT.stage.displayState = StageDisplayState.NORMAL;
            }
            if(args == null)
            {
               ExternalInterface.call("callFunc",func);
            }
            else
            {
               ExternalInterface.call("callFunc",func,args);
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","CallJS C " + func + " - " + com.adobe.serialization.json.JSON.encode(args));
         }
      }
      
      public static function Array2String(param1:Array) : String
      {
         var _loc2_:* = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += GLOBAL.FormatNumber(param1[_loc3_][0]) + " " + param1[_loc3_][1];
            if(_loc3_ < param1.length - 2)
            {
               _loc2_ += ", ";
            }
            if(_loc3_ == param1.length - 2)
            {
               _loc2_ += " and ";
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function Array2StringB(param1:Array) : String
      {
         var _loc2_:* = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += param1[_loc3_][1];
            if(_loc3_ < param1.length - 2)
            {
               _loc2_ += ", ";
            }
            if(_loc3_ == param1.length - 2)
            {
               _loc2_ += " and ";
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function GetGameHeight() : int
      {
         return _ROOT.stage.stageHeight;
      }
      
      public static function AFK() : *
      {
         if(!_catchup)
         {
            if(Math.abs(_ROOT.mouseX - _oldMousePoint.x) > 50 || _afktimer.Get() == 0)
            {
               _oldMousePoint = new Point(_ROOT.mouseX,_ROOT.mouseY);
               UpdateAFKTimer();
            }
            if(Timestamp() - _afktimer.Get() == 360 && !MapRoom._open)
            {
               POPUPS.AFK();
            }
            else if(Timestamp() - _afktimer.Get() > 600)
            {
               POPUPS.Timeout();
            }
         }
      }
      
      public static function StatGet(param1:String) : int
      {
         var _loc2_:int = 0;
         if(_otherStats[param1])
         {
            _loc2_ = int(_otherStats[param1]);
         }
         return _loc2_;
      }
      
      public static function StatSet(param1:String, param2:int, param3:Boolean = true) : void
      {
         var _loc4_:Boolean = false;
         if(!_otherStats)
         {
            _otherStats = {};
         }
         if(param2 == 0 && Boolean(_otherStats[param1]))
         {
            delete _otherStats[param1];
            if(param3)
            {
               BASE.Save();
            }
            _loc4_ = true;
         }
         else if(!_otherStats[param1])
         {
            _otherStats[param1] = param2;
            if(param3)
            {
               BASE.Save();
            }
            _loc4_ = true;
         }
         else if(_otherStats[param1] != param2)
         {
            _otherStats[param1] = param2;
            if(param3)
            {
               BASE.Save();
            }
            _loc4_ = true;
         }
      }
      
      public static function StatGetStr(param1:String) : String
      {
         var _loc2_:String = "";
         if(_otherStats[param1])
         {
            _loc2_ = _otherStats[param1];
         }
         return _loc2_;
      }
      
      public static function StatSetStr(param1:String, param2:String, param3:Boolean = true) : void
      {
         var _loc4_:Boolean = false;
         if(!_otherStats)
         {
            _otherStats = {};
         }
         if(param2.length > 0 && Boolean(_otherStats[param1]))
         {
            delete _otherStats[param1];
            if(param3)
            {
               BASE.Save();
            }
            _loc4_ = true;
         }
         else if(!_otherStats[param1])
         {
            _otherStats[param1] = param2;
            if(param3)
            {
               BASE.Save();
            }
            _loc4_ = true;
         }
         else if(_otherStats[param1] != param2)
         {
            _otherStats[param1] = param2;
            if(param3)
            {
               BASE.Save();
            }
            _loc4_ = true;
         }
      }
      
      public static function BlockerAdd(param1:MovieClip = null) : *
      {
         var _loc2_:DisplayObject = null;
         RefreshScreen();
         if(!param1)
         {
            param1 = GLOBAL._layerWindows;
         }
         _loc2_ = param1.addChild(new popup_bg());
         _loc2_.width = GLOBAL._ROOT.stage.stageWidth;
         _loc2_.height = GLOBAL._ROOT.stage.stageHeight;
         _loc2_.x = GLOBAL._SCREEN.x;
         _loc2_.y = GLOBAL._SCREEN.y;
         _blockerList.push(_loc2_);
      }
      
      public static function BlockerRemove() : *
      {
         var lastBlocker:DisplayObject = null;
         try
         {
            lastBlocker = _blockerList.pop();
            lastBlocker.parent.removeChild(lastBlocker);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function SaveAttackersDeltaResources() : *
      {
         var _loc1_:int = 0;
         if(_attackersDeltaResources.dirty)
         {
            _loc1_ = 1;
            while(_loc1_ < 5)
            {
               if(_attackersDeltaResources["r" + _loc1_])
               {
                  if(_savedAttackersDeltaResources["r" + _loc1_])
                  {
                     _savedAttackersDeltaResources["r" + _loc1_].Add(_attackersDeltaResources["r" + _loc1_].Get());
                  }
                  else
                  {
                     _savedAttackersDeltaResources["r" + _loc1_] = new SecNum(_attackersDeltaResources["r" + _loc1_].Get());
                  }
               }
               _loc1_++;
            }
         }
         _attackersDeltaResources = {"dirty":false};
      }
      
      public static function CleanAttackersDeltaResources() : *
      {
         _savedAttackersDeltaResources = {
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0),
            "dirty":false
         };
      }
      
      public static function SetFlags(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _flags = param1;
         if(!_flags.viximo && !_flags.kongregate)
         {
            _loc2_ = int(LOGIN._digits[LOGIN._digits.length - 1]);
            _loc3_ = int(LOGIN._digits[LOGIN._digits.length - 2]);
            _loc4_ = int(LOGIN._digits[LOGIN._digits.length - 3]);
            _flags.midgameIncentive = 0;
         }
         if(LOGIN._sumdigit != 0)
         {
            _flags.plinko = 0;
         }
         _flags.showProgressBar = 0;
      }
      
      public static function initChat() : void
      {
         if(_chatInited)
         {
            if(_bymChat != null)
            {
               _bymChat.show();
            }
            if(_bymChat.IsConnected)
            {
               return;
            }
         }
         if(_chatServers == null || _chatServers.length == 0)
         {
            return;
         }
         if(!flagsShouldChatExist())
         {
            if(_bymChat != null)
            {
               _bymChat.logout();
               _bymChat.hide();
               _bymChat = null;
               _chatInited = false;
            }
            return;
         }
         _chatroomNumber = 0;
         if(!_local)
         {
            _chatroomNumber = LOGIN._playerID % (_flags != null && Boolean(_flags.numchatrooms) ? _flags.numchatrooms : 5 * 60);
         }
         if(!GLOBAL._chatEnabled || _chatServers.length == 0)
         {
            if(_bymChat != null)
            {
               _bymChat.logout();
               _bymChat.hide();
               _bymChat = null;
               _chatInited = false;
            }
            return;
         }
         _chatServer = _chatServers[_chatroomNumber % _chatServers.length];
         if(_bymChat == null)
         {
            _bymChat = new BYMChat(new ChatBox(),_chatServer);
            _chatInited = true;
            if(flagsShouldChatConnectButStayInvisible())
            {
               _bymChat.hide();
            }
            _layerUI.addChild(_bymChat);
         }
         _bymChat.init();
         if(!chatUserIsInABTest())
         {
            _bymChat.disableChat();
            _bymChat.showUnavailableInYourArea();
            return;
         }
         if(TUTORIAL._stage >= TUTORIAL._endstage && flagsShouldChatExist())
         {
            if(GLOBAL._chatEnabled && !_bymChat.IsConnected && _bymChat._open)
            {
               GLOBAL.connectAndLogin();
            }
         }
         else
         {
            _bymChat.disableChat();
         }
      }
      
      public static function connectAndLogin() : void
      {
         var _loc1_:String = null;
         if(!_chatInited)
         {
            return;
         }
         if(!_validName)
         {
            return;
         }
         if(_bymChat == null || BYMChat.serverInited || _bymChat.IsConnected || _bymChat.IsJoined)
         {
            return;
         }
         if(!_bymChat._open)
         {
            return;
         }
         if(_bymChat.IsConnected)
         {
            return;
         }
         if(_bymChat)
         {
            _loc1_ = getFirstNameLastInitial();
            if(_loc1_ == null || _loc1_.length == 0)
            {
               _validName = false;
               _bymChat.showInvalidName();
               return;
            }
            _bymChat.initServer();
            GLOBAL._bymChat.login(_loc1_,LOGIN._playerID.toString(),BASE.BaseLevel().level);
            _bymChat.show();
            _bymChat.enter_sector("BYM-" + KEYS._language + "-" + _chatroomNumber.toString());
         }
      }
      
      private static function getFirstNameLastInitial() : String
      {
         var _loc1_:String = LOGIN._playerName;
         if(_loc1_ != null && _loc1_.length > 0)
         {
            _loc1_ = _loc1_.replace(/ /,"_");
            var _loc2_:String = LOGIN._playerLastName;
            if(_loc2_ != null && _loc2_.length > 0)
            {
               _loc2_ = _loc2_.substr(0,1);
               if(_loc2_.length == 1)
               {
                  _loc2_ = _loc2_.toUpperCase();
                  if(_loc2_ != null && _loc2_.length == 1)
                  {
                     _loc2_ = _loc2_.replace(/ /,"_");
                  }
               }
               if(_loc2_ == null || _loc2_.length != 1)
               {
                  return null;
               }
            }
            return _loc1_ + _loc2_;
         }
         return null;
      }
      
      public static function setChatPosition(param1:DisplayObjectContainer = null, param2:Number = NaN, param3:Number = NaN) : void
      {
         if(_bymChat != null)
         {
            if(!isNaN(param2))
            {
               _bymChat.x = param2;
            }
            if(!isNaN(param3))
            {
               _bymChat.y = param3;
            }
            if(param1 != null)
            {
               param1.addChild(GLOBAL._bymChat);
            }
            _bymChat.position();
            _bymChat.show();
         }
      }
      
      public static function chatUserIsInABTest() : Boolean
      {
         if(_flags)
         {
            if(_flags.hasOwnProperty("chatwhitelist"))
            {
               _chatWhiteList = String(_flags.chatwhitelist).split(",");
            }
            if(_flags.hasOwnProperty("chatblacklist"))
            {
               _chatBlackList = String(_flags.chatblacklist).split(",");
            }
            if(_flags.hasOwnProperty("countrycodeblacklist"))
            {
               _countryCodeBlackList = String(_flags.countrycodeblacklist).split(",");
            }
         }
         if(_chatWhiteList != null && _chatWhiteList.indexOf(LOGIN._playerID.toString()) != -1)
         {
            return true;
         }
         if(_chatBlackList != null && _chatBlackList.indexOf(LOGIN._playerID.toString()) != -1)
         {
            return false;
         }
         if(_countryCodeBlackList != null && _countryCodeBlackList.indexOf(_countryCode) != -1)
         {
            return false;
         }
         if(!_chatEnabled)
         {
            return false;
         }
         return true;
      }
      
      public static function ResizeGame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_fluidWidthEnabled)
         {
            RefreshScreen();
            UI2.ResizeHandler(param1);
            _loc2_ = 0;
            ResizeLayer(GLOBAL._layerUI);
            ResizeLayer(GLOBAL._layerWindows);
            ResizeLayer(GLOBAL._layerMessages);
            ResizeLayer(GLOBAL._layerTop);
            if(TUTORIAL._stage < TUTORIAL._endstage)
            {
               TUTORIAL.Resize();
            }
         }
         else
         {
            UI2.ResizeHandler(param1);
         }
      }
      
      public static function RefreshScreen() : void
      {
         var _loc1_:* = GLOBAL._ROOT.stage.stageWidth;
         var _loc2_:* = GLOBAL.GetGameHeight();
         var _loc4_:int = UI2._wildMonsterBar != null ? 40 : 0;
         _SCREEN = new Rectangle(0 - (_loc1_ - _SCREENINIT.width) / 2,0 - (_loc2_ - (_SCREENINIT.height + _loc4_)) / 2,_loc1_,_loc2_);
         _SCREENCENTER = new Point(_SCREEN.x + _SCREEN.width / 2,_SCREEN.y + _SCREEN.height / 2);
         if(Boolean(GLOBAL._flags) && (Boolean(GLOBAL._flags.viximo) || Boolean(GLOBAL._flags.kongregate)))
         {
            _SCREENHUD = new Point(_SCREEN.x,_SCREEN.y + _SCREEN.height - 0);
         }
         else
         {
            _SCREENHUD = new Point(_SCREEN.x,_SCREEN.y + _SCREEN.height - 208);
         }
         if(UI_BOTTOM && UI_BOTTOM._missions && !UI_BOTTOM._missions._open)
         {
            _SCREENHUD = new Point(_SCREEN.x,_SCREEN.y + _SCREEN.height - 30 - 0);
         }
      }
      
      public static function ResizeLayer(param1:MovieClip) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc2_:* = param1.numChildren;
         while(_loc2_--)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            if(_loc3_.hasOwnProperty("Resize"))
            {
               _loc3_.Resize();
            }
            else if(_loc3_ is popup_bg)
            {
               _loc3_.width = _SCREEN.width;
               _loc3_.height = _SCREEN.height;
               _loc3_.x = _SCREEN.x;
               _loc3_.y = _SCREEN.y;
               _loc4_ = 0;
               while(_loc4_ < _blockerList.length)
               {
                  _blockerList[_loc4_].width = _SCREEN.width;
                  _blockerList[_loc4_].height = _SCREEN.height;
                  _blockerList[_loc4_].x = _SCREEN.x;
                  _blockerList[_loc4_].y = _SCREEN.y;
                  _loc4_++;
               }
            }
         }
      }
      
      public static function DistanceFromRoot(param1:MovieClip) : Point
      {
         var _loc2_:int = param1.x;
         var _loc3_:int = param1.y;
         var _loc4_:* = param1.parent;
         while(_loc4_.parent)
         {
            _loc2_ += _loc4_.x;
            _loc3_ += _loc4_.y;
            if(_loc4_.parent == GLOBAL._ROOT.stage)
            {
               break;
            }
            _loc4_ = _loc4_.parent;
         }
         return new Point(_loc2_,_loc3_);
      }
      
      public static function ThrowStackTrace(param1:String) : *
      {
      }
      
      public static function gotoURL(param1:String, param2:URLVariables = null, param3:Boolean = true, param4:Array = null) : void
      {
         var targetURL:String = null;
         var url:String = param1;
         var urlVars:URLVariables = param2;
         var inNewWindow:Boolean = param3;
         var logData:Array = param4;
         var targetVars:URLVariables = new URLVariables();
         var request:URLRequest = new URLRequest(url);
         var windowScope:String = "_blank";
         if(url)
         {
            targetURL = url;
            if(urlVars)
            {
               request.data = urlVars;
            }
            if(inNewWindow)
            {
               windowScope = "_blank";
            }
            else
            {
               windowScope = "_parent";
            }
            try
            {
               navigateToURL(request,windowScope);
            }
            catch(e:Error)
            {
            }
            if(logData)
            {
               LOGGER.Stat(logData);
            }
            return;
         }
      }
      
      public static function flagsShouldChatDisplay() : Boolean
      {
         if(_flags == null)
         {
            return false;
         }
         if(!_flags.hasOwnProperty("chat"))
         {
            return false;
         }
         if(_flags.chat != 2)
         {
            return false;
         }
         if(MapRoom._open && GLOBAL._ROOT.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            return false;
         }
         return true;
      }
      
      public static function flagsShouldChatExist() : Boolean
      {
         if(_flags == null)
         {
            return false;
         }
         if(!_flags.hasOwnProperty("chat"))
         {
            return false;
         }
         if(_flags.chat <= 0)
         {
            return false;
         }
         if(!chatUserIsInABTest())
         {
            return false;
         }
         return true;
      }
      
      public static function flagsShouldChatConnectButStayInvisible() : Boolean
      {
         return false;
      }
      
      public static function ValidateMushroomPick(param1:BFOUNDATION) : void
      {
         var _loc2_:Rndm = new Rndm(int(param1.x * param1.y));
         if(int(_loc2_.random() * 16) >> 2)
         {
            LOGGER.Log("log","Invalid shinyshroom");
            GLOBAL.ErrorMessage("GLOBAL mushroom hack 1");
            _shinyShroomValid = false;
            return;
         }
         var _loc3_:int = int(_shinyShrooms.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1.x == _shinyShrooms[_loc4_].x && param1.y == _shinyShrooms[_loc4_].y)
            {
               LOGGER.Log("log","Shinyshroom multi-pick");
               GLOBAL.ErrorMessage("GLOBAL mushroom hack 2");
               _shinyShroomValid = false;
               return;
            }
            _loc4_++;
         }
         if(BASE._buildingsMushrooms["m" + param1._id])
         {
            LOGGER.Log("log","Shinyshroom not recycled");
            GLOBAL.ErrorMessage("GLOBAL mushroom hack 3");
            _shinyShroomValid = false;
            return;
         }
         _shinyShrooms.push({
            "x":param1.x,
            "y":param1.y
         });
         _shinyShroomValid = true;
      }
      
      public static function QuickDistance(param1:Point, param2:Point) : Number
      {
         var _loc3_:Number = param1.x - param2.x;
         var _loc4_:Number = param1.y - param2.y;
         return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
      }
      
      public static function QuickDistanceSquared(param1:Point, param2:Point) : Number
      {
         var _loc3_:Number = param1.x - param2.x;
         var _loc4_:Number = param1.y - param2.y;
         return _loc3_ * _loc3_ + _loc4_ * _loc4_;
      }
      
      public static function UpdateAFKTimer() : *
      {
         _afktimer.Set(Timestamp());
      }
      
      public static function DisplayObjectPath(param1:DisplayObject) : String
      {
         var _loc2_:String = "";
         do
         {
            if(param1.name)
            {
               _loc2_ = param1.name + (_loc2_ == "" ? "" : "." + _loc2_);
            }
         }
         while(param1 = param1.parent, param1);
         
         return _loc2_;
      }
      
      public static function GetABTestHash(param1:String, param2:int = 1) : int
      {
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc3_:String = LOGIN._playerID.toString();
         var _loc4_:String = MD5.hash(param1 + _loc3_);
         var _loc5_:int = param2;
         var _loc6_:int = 0;
         while(_loc5_ > 0)
         {
            _loc7_ = _loc4_.substr(_loc4_.length - 1,1);
            _loc8_ = 0;
            _loc6_ *= 16;
            switch(_loc7_)
            {
               case "a":
                  _loc8_ = 10;
               case "b":
                  _loc8_ = 11;
               case "c":
                  _loc8_ = 12;
               case "d":
                  _loc8_ = 13;
               case "e":
                  _loc8_ = 14;
               case "f":
                  _loc8_ = 15;
                  break;
            }
            _loc8_ = int(_loc7_);
            _loc6_ += _loc8_;
            _loc5_--;
         }
         return _loc6_;
      }
      
      public static function InfernoMode(param1:String = null) : Boolean
      {
         var _loc2_:String = _loadmode;
         if(param1)
         {
            _loc2_ = param1;
         }
         var _loc3_:Boolean = false;
         switch(_loc2_)
         {
            case "ibuild":
            case "iattack":
            case "iview":
            case "ihelp":
            case "iwmattack":
            case "iwmview":
               _loc3_ = true;
               break;
            case "build":
            case "attack":
            case "view":
            case "help":
            case "wmattack":
            case "wmview":
            default:
               _loc3_ = false;
         }
         return _loc3_;
      }
   }
}

