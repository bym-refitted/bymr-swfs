package
{
   import com.cc.utils.SecNum;
   import com.computus.model.Timekeeper;
   import com.gskinner.utils.Rndm;
   import com.monsters.ai.WMBASE;
   import com.monsters.chat.Chat;
   import com.monsters.configs.BYMConfig;
   import com.monsters.debug.Console;
   import com.monsters.display.ImageCache;
   import com.monsters.effects.fire.Fire;
   import com.monsters.effects.smoke.Smoke;
   import com.monsters.maproom_advanced.CellData;
   import com.monsters.maproom_advanced.MapRoom;
   import com.monsters.pathing.PATHING;
   import com.monsters.player.Player;
   import com.monsters.siege.SiegeFactory;
   import com.monsters.siege.SiegeLab;
   import com.monsters.siege.SiegeWeapons;
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
      
      public static var _aiDesignMode:Boolean;
      
      public static var _mapVersion:int;
      
      public static var _mailVersion:int;
      
      public static var _soundVersion:int;
      
      public static var _languageVersion:int;
      
      public static var _halt:Boolean;
      
      public static var _frameNumber:int;
      
      public static var _friendCount:int;
      
      public static var _sessionCount:int;
      
      public static var _addTime:int;
      
      public static var _proTip:PROTIP_CLIP;
      
      public static var _ROOT:MovieClip;
      
      public static var _layerMap:Sprite;
      
      public static var _layerUI:Sprite;
      
      public static var _layerWindows:Sprite;
      
      public static var _layerMessages:Sprite;
      
      public static var _layerProjectiles:Sprite;
      
      public static var _layerTop:Sprite;
      
      public static var _SCREEN:Rectangle;
      
      public static var _SCREENCENTER:Point;
      
      public static var _SCREENHUD:Point;
      
      public static var _SCREENHUDLEFT:Point;
      
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
      
      public static var _appid:String;
      
      public static var _tpid:String;
      
      public static var _currencyURL:String;
      
      public static var _monetized:int;
      
      public static var _fbdata:Object;
      
      public static var _selectedBuilding:BFOUNDATION;
      
      public static var _newBuilding:BFOUNDATION;
      
      public static var _render:Boolean;
      
      public static var _mode:String;
      
      public static var _loadmode:String;
      
      public static var _mapWidth:int;
      
      public static var _mapHeight:int;
      
      public static var _resourceNames:Array;
      
      public static var _bTownhall:BFOUNDATION;
      
      public static var _bRadio:BFOUNDATION;
      
      public static var _bStore:BFOUNDATION;
      
      public static var _bMap:BFOUNDATION;
      
      public static var _bLocker:BFOUNDATION;
      
      public static var _bAcademy:BFOUNDATION;
      
      public static var _bHousing:BFOUNDATION;
      
      public static var _bHatchery:BFOUNDATION;
      
      public static var _bFlinger:BUILDING5;
      
      public static var _bCatapult:BFOUNDATION;
      
      public static var _bHatcheryCC:BUILDING16;
      
      public static var _bJuicer:BUILDING9;
      
      public static var _bBaiter:BFOUNDATION;
      
      public static var _bYardPlanner:BFOUNDATION;
      
      public static var _bSiegeLab:SiegeLab;
      
      public static var _bSiegeFactory:SiegeFactory;
      
      public static var _bChamber:BFOUNDATION;
      
      public static var _bLab:BFOUNDATION;
      
      public static var _bCage:CHAMPIONCAGE;
      
      public static var _bTower:BFOUNDATION;
      
      public static var _bTowerCount:int;
      
      public static var _catchup:Boolean;
      
      public static var _researchTime:Number;
      
      public static var _buildTime:Number;
      
      public static var _upgradePacking:Number;
      
      public static var _hatcheryOverdrive:int;
      
      public static var _harvesterOverdrive:int;
      
      public static var _extraHousing:int;
      
      public static var _lockerOverdrive:int;
      
      public static var _designSlots:int;
      
      public static var _creepCount:int;
      
      public static var _timekeeper:Timekeeper;
      
      public static var _buildingProps:Array;
      
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
      
      public static var _homeBaseID:Number;
      
      public static var lastTime:Number;
      
      public static var _flags:Object;
      
      public static var _unreadMessages:int;
      
      public static var _outpostCapacity:SecNum;
      
      public static var _displayedPromoNew:Boolean;
      
      public static var _fbcncp:int;
      
      public static var _credits:SecNum;
      
      private static var _player:Player;
      
      private static var _attackingPlayer:Player;
      
      public static var _local:Boolean = false;
      
      public static var _save:Boolean = true;
      
      public static var _localMode:int = BYMConfig.k_sLOCAL_MODE_TRUNK;
      
      public static var _version:SecNum = new SecNum(128);
      
      public static const DOES_USE_SCROLL:Boolean = false;
      
      public static var _checkPromo:int = 1;
      
      public static var _giveTips:int = 1;
      
      public static var _fluidWidthEnabled:Boolean = true;
      
      public static var _SCREENINIT:Rectangle = new Rectangle(0,0,760,670);
      
      public static var _countryCode:String = "us";
      
      public static var _shinyShroomCount:int = 0;
      
      private static var _shinyShrooms:Array = [];
      
      public static var _shinyShroomValid:Boolean = false;
      
      public static var _allianceConquestTime:SecNum = new SecNum(0);
      
      public static var _openBase:Object = null;
      
      public static const _degtorad:Number = 0.0174532925;
      
      public static const _radtodeg:Number = 57.2957795;
      
      public static const MODE_ATTACK:String = "attack";
      
      public static var iresourceNames:Array = ["#r_bone#","#r_coal#","#r_sulfur#","#r_magma#","#r_shiny#","#r_time#"];
      
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
      
      public static var _playerGuardianData:Vector.<Object> = new Vector.<Object>(null);
      
      public static var _playerCatapultLevel:SecNum = new SecNum(0);
      
      public static var _empireDestroyed:int = 0;
      
      public static var _empireDestroyedShown:Boolean = false;
      
      public static var _attackerMapCreatures:Object = {};
      
      public static var _attackerMapResources:Object = {};
      
      public static var _attackerCellsInRange:Vector.<CellData> = new Vector.<CellData>(0,true);
      
      public static var _attackerMapCreaturesStart:Object = {};
      
      public static var _showMapWaiting:int = 0;
      
      public static var _nextOutpostWaiting:int = 0;
      
      public static var _toggleYardWaiting:int = 0;
      
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
      
      public static var _canInvite:Boolean = false;
      
      public static var _canGift:Boolean = false;
      
      public static var _whatsnewid:int = 0;
      
      public static var _lastWhatsNew:int = 1048;
      
      public static var _mr2TutorialId:int = 0;
      
      public static var _afktimer:SecNum = new SecNum(0);
      
      public static var _oldMousePoint:Point = new Point(0,0);
      
      public static var _otherStats:Object = {};
      
      public static var _baseLoads:int = 0;
      
      public static var _averageAltitude:SecNum = new SecNum(125);
      
      public static const _fbPromoTimer:Number = 604800;
      
      public static const ERROR_OOPS_ONLY:int = 0;
      
      public static const ERROR_OOPS_AND_ORANGE_BOX:int = 1;
      
      public static const ERROR_ORANGE_BOX_ONLY:int = 2;
      
      public static const TIME_ELAPSED_THRESHHOLD:Number = 5 * 60 * 1000;
      
      public static var eventDispatcher:EventDispatcher = new EventDispatcher();
      
      public static var debugLogJSCalls:Boolean = false;
      
      public static var m_mapRoomFunctional:Boolean = true;
      
      public static var _showStreamlinedSpeedUps:Boolean = false;
      
      public static var _magnification:Number = 1;
      
      private static var _blockerList:Array = [];
      
      private static const _MAGNIFICATION_BOUNDS:Point = new Point(0.6,2.75);
      
      public function GLOBAL()
      {
         super();
      }
      
      public static function get player() : Player
      {
         return _player;
      }
      
      public static function set player(param1:Player) : void
      {
         _player = param1;
      }
      
      public static function get attackingPlayer() : Player
      {
         return _player;
      }
      
      public static function set attackingPlayer(param1:Player) : void
      {
         _player = param1;
      }
      
      public static function SetBuildingProps() : void
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
      
      public static function Setup(param1:String = "build") : void
      {
         var _loc3_:String = null;
         if(param1 != "build")
         {
            attackingPlayer = player;
         }
         player = new Player();
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
                  _attackersFlinger = _attackerMapResources.flinger.Get();
               }
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
         BASE.Setup();
      }
      
      public static function getResourceFrame(param1:String, param2:Boolean = false) : String
      {
         if(param2 || BASE.isInferno())
         {
            switch(param1)
            {
               case "r1":
                  return "bone";
               case "r2":
                  return "coal";
               case "r3":
                  return "sulfur";
               case "r4":
                  return "magma";
               case "shiny":
                  return "shiny2";
               case "time":
                  return "time2";
            }
         }
         else
         {
            switch(param1)
            {
               case "r1":
                  return "twig";
               case "r2":
                  return "pebble";
               case "r3":
                  return "putty";
               case "r4":
                  return "goo";
               case "shiny":
                  return "shiny";
               case "time":
                  return "time";
            }
         }
         return "unknown";
      }
      
      public static function getResourceName(param1:String, param2:Boolean = false) : String
      {
         var _loc3_:Array = param2 ? iresourceNames : _resourceNames;
         switch(param1)
         {
            case "r1":
               return KEYS.Get(_loc3_[0]);
            case "r2":
               return KEYS.Get(_loc3_[1]);
            case "r3":
               return KEYS.Get(_loc3_[2]);
            case "r4":
               return KEYS.Get(_loc3_[3]);
            case "shiny":
               return KEYS.Get(_loc3_[4]);
            case "time":
               return KEYS.Get(_loc3_[5]);
            default:
               return "???";
         }
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
         _bSiegeLab = null;
         _bSiegeFactory = null;
         _bCage = null;
      }
      
      public static function WaitShow(param1:String = "") : void
      {
         PLEASEWAIT.Show(KEYS.Get("wait_processing"));
      }
      
      public static function WaitHide() : void
      {
         PLEASEWAIT.Hide();
      }
      
      public static function goFullScreen(param1:MouseEvent = null) : void
      {
         if(_ROOT.stage.displayState == StageDisplayState.NORMAL)
         {
            _ROOT.stage.displayState = StageDisplayState.FULL_SCREEN;
            if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
            {
               UI2._top.mcZoom.gotoAndStop(6);
            }
            else
            {
               UI2._top.mcZoom.gotoAndStop(3);
            }
            MAP._GROUND.scaleY = 1;
            MAP._GROUND.scaleX = 1;
         }
         else
         {
            if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
            {
               UI2._top.mcZoom.gotoAndStop(4);
            }
            else
            {
               UI2._top.mcZoom.gotoAndStop(1);
            }
            _ROOT.stage.displayState = StageDisplayState.NORMAL;
            ThrowStackTrace("goFullScreen");
         }
         _zoomed = false;
         magnification = 1;
      }
      
      public static function Zoom(param1:MouseEvent = null) : void
      {
         if(_ROOT.stage.displayState != StageDisplayState.FULL_SCREEN)
         {
            BASE.BuildingDeselect();
            MAP.FocusTo(0,0,0.4);
            if(_zoomed)
            {
               _zoomed = false;
               if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
               {
                  UI2._top.mcZoom.gotoAndStop(4);
               }
               else
               {
                  UI2._top.mcZoom.gotoAndStop(1);
               }
               TweenLite.to(MAP._GROUND,0.1,{
                  "scaleX":1,
                  "scaleY":1,
                  "ease":Cubic.easeInOut,
                  "overwrite":false
               });
            }
            else
            {
               _zoomed = true;
               if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
               {
                  UI2._top.mcZoom.gotoAndStop(5);
               }
               else
               {
                  UI2._top.mcZoom.gotoAndStop(2);
               }
               TweenLite.to(MAP._GROUND,0.4,{
                  "scaleX":0.5,
                  "scaleY":0.5,
                  "ease":Cubic.easeInOut,
                  "overwrite":false
               });
            }
         }
      }
      
      public static function Tick() : void
      {
         var _loc1_:Object = null;
         var _loc2_:BFOUNDATION = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!_halt && !GLOBAL._catchup)
         {
            t += 1;
            if(MapRoom._open)
            {
               MapRoom.Tick();
               LOGGER.Tick();
               MAILBOX.Tick();
               AFK();
            }
            else
            {
               ++_timePlayed;
               _loc1_ = BASE._buildingsAll;
               _loc3_ = 0;
               _loc4_ = 0;
               for each(_loc2_ in _loc1_)
               {
                  if(_loc2_._class == "resource")
                  {
                     _loc3_ = _loc2_._stored.Get();
                     _loc4_ = _loc2_._countdownProduce.Get();
                  }
                  _loc2_.Tick(1);
                  if(_loc2_._class == "resource")
                  {
                     if(_loc4_ > 1 && _loc3_ != _loc2_._stored.Get())
                     {
                        LOGGER.Log("log","BRESOURCE.StoredB " + _loc3_ + " - " + _loc2_._stored.Get());
                        GLOBAL.ErrorMessage("BRESOURCE.StoredB");
                        return;
                     }
                  }
               }
               UPDATES.Check();
               CREATURELOCKER.Tick();
               HATCHERY.Tick();
               HATCHERYCC.Tick();
               STORE.ProcessPurchases();
               BASE.Tick();
               HOUSING.Update();
               ACADEMY.Tick();
               if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
               {
                  ATTACK.Tick();
               }
               QUEUE.Tick();
               UI2.Update();
               LOGGER.Tick();
               MAILBOX.Tick();
               AFK();
               MONSTERBAITER.Tick();
               MONSTERBUNKER.Tick();
               if(_mode == "wmattack" || _mode == "wmview")
               {
                  WMBASE.Tick();
               }
            }
            if(_toggleYardWaiting && BASE._saveCounterA == BASE._saveCounterB && !BASE._saving)
            {
               _toggleYardWaiting = 0;
               _nextOutpostWaiting = 0;
               _showMapWaiting = 0;
               GLOBAL._advancedMap = 0;
               if(MAPROOM_INFERNO._open)
               {
                  MAPROOM_INFERNO.Hide();
               }
               if(MAPROOM._open)
               {
                  MAPROOM.Hide();
               }
               if(BASE.isInferno())
               {
                  BASE.LoadBase(null,0,0,"build",false,BASE.MAIN_YARD);
               }
               else
               {
                  BASE.LoadBase(GLOBAL._infBaseURL,0,0,"ibuild",false,BASE.INFERNO_YARD);
               }
            }
            else if(_nextOutpostWaiting && BASE._saveCounterA == BASE._saveCounterB && !BASE._saving)
            {
               _nextOutpostWaiting = 0;
               _showMapWaiting = 0;
               BASE.LoadNext();
            }
            else if(_showMapWaiting && BASE._saveCounterA == BASE._saveCounterB && !BASE._saving && !BASE._loading)
            {
               _loc5_ = _showMapWaiting;
               _showMapWaiting = 0;
               PLEASEWAIT.Hide();
               MapRoom.ShowDelayed();
            }
            if(BASE._needCurrentCell && GLOBAL._currentCell)
            {
               PLEASEWAIT.Hide();
               BASE._needCurrentCell = false;
               _loc6_ = GLOBAL._currentCell._base == 3 ? BASE.OUTPOST : BASE.MAIN_YARD;
               BASE.LoadBase(null,0,GLOBAL._currentCell._baseID,"build",false,_loc6_);
            }
         }
      }
      
      public static function TickFast(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:BFOUNDATION = null;
         if(!_halt)
         {
            if(BYMConfig.instance.RENDERER_ON)
            {
               _ROOT.stage.invalidate();
            }
            _loc2_ = getTimer();
            SOUNDS.Tick();
            if(_render)
            {
               _loc3_ = getTimer();
               _loc4_ = _loc3_ - lastTime;
               if(_loc4_ > TIME_ELAPSED_THRESHHOLD && !_aiDesignMode)
               {
                  LOGGER.Log("err","TimeHax");
                  ErrorMessage("Time Threshold Exceeded");
               }
               if(lastTime)
               {
                  _loopsBanked -= _loops;
                  if(_loopsBanked < 0)
                  {
                     _loopsBanked = 0;
                  }
                  _loopsBanked += 0.08 * (_loc3_ - lastTime);
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
               lastTime = _loc3_;
               _loc5_ = getTimer();
               if(!MapRoom._open)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loops)
                  {
                     _render = false;
                     if(_loc7_ == _loops - 1)
                     {
                        _render = true;
                     }
                     if(CREEPS._creepCount > 0 || Boolean(SiegeWeapons.activeWeapon))
                     {
                        CREEPS.Tick();
                        for each(_loc8_ in BASE._buildingsTowers)
                        {
                           _loc8_.TickAttack();
                        }
                     }
                     CREATURES.Tick();
                     _loc6_ = 0;
                     while(_loc6_ < CREATURES._guardianList.length)
                     {
                        if(Boolean(CREATURES._guardianList[_loc6_]) && CREATURES._guardianList[_loc6_].Tick(1))
                        {
                           MAP._BUILDINGTOPS.removeChild(CREATURES._guardianList[_loc6_]);
                           CREATURES._guardianList[_loc6_].clearRasterData();
                           if(CREATURES._guardianList[_loc6_] == CREATURES._guardian)
                           {
                              CREATURES._guardian = null;
                           }
                           else
                           {
                              CREATURES._guardianList.splice(_loc6_,1);
                           }
                           _loc6_--;
                        }
                        _loc6_++;
                     }
                     PROJECTILES.Tick();
                     FIREBALLS.Tick();
                     _loc7_++;
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
                  _player.tick();
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
               if(_frameNumber % 3 == 0 && !BYMConfig.instance.RENDERER_ON)
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
      
      public static function LogFPS() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_flags.logfps)
         {
            _FPSarray.sortOn("fps",Array.NUMERIC);
            _loc1_ = int(_FPSarray[0].fps);
            _loc2_ = int(_FPSarray[_FPSarray.length - 1].fps);
            _loc3_ = int(_FPSarray[_FPSarray.length * 0.5].fps);
            LOGGER.Log("fr" + GLOBAL._mode.substr(0,1),GLOBAL.dd(_loc1_) + "," + GLOBAL.dd(_loc2_) + "," + GLOBAL.dd(_loc3_));
         }
      }
      
      public static function Timestamp() : int
      {
         return t;
      }
      
      public static function ShowMap(param1:MouseEvent = null) : void
      {
         if(!BASE._loading)
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
      }
      
      public static function isMapOpen() : Boolean
      {
         return MAPROOM_INFERNO._open || MapRoom._open || MAPROOM._open;
      }
      
      public static function OpenMap(param1:String) : void
      {
         var _loc2_:Object = JSON.decode(param1);
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
      
      public static function ToTime(param1:int, param2:Boolean = false, param3:Boolean = true, param4:Boolean = true, param5:Boolean = false) : String
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
      
      public static function ToTimeVague(param1:int) : String
      {
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc2_:Number = param1;
         var _loc3_:Number = Math.ceil(_loc2_ / 86400);
         if(_loc3_ > 1)
         {
            _loc4_ = _loc3_ + " " + KEYS.Get("global_days");
         }
         else
         {
            _loc5_ = Math.ceil(_loc2_ / 3600);
            if(_loc5_ > 1)
            {
               _loc4_ = _loc5_ + " " + KEYS.Get("global_hours");
            }
            else
            {
               _loc4_ = "&lt; 1 " + KEYS.Get("global_hour");
            }
         }
         return _loc4_;
      }
      
      public static function dd(param1:int) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return param1.toString();
      }
      
      public static function ErrorMessage(param1:String = "", param2:int = 0) : Function
      {
         var em:ERRORMESSAGE;
         var err:String = param1;
         var errortype:int = param2;
         print(err + "@ " + Console.getSource(3));
         em = new ERRORMESSAGE();
         em.Show(err,errortype);
         return function(param1:MouseEvent = null):void
         {
         };
      }
      
      public static function Message(param1:String, param2:String = null, param3:Function = null, param4:Array = null, param5:String = null, param6:Function = null, param7:Array = null, param8:int = 1) : void
      {
         var _loc9_:MESSAGE = new MESSAGE();
         _loc9_.Show(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public static function Confirm(param1:String, param2:String = null, param3:Function = null, param4:Array = null, param5:int = 1) : void
      {
         var _loc6_:MESSAGE = new MESSAGE();
         _loc6_.Show(param1,param2,param3,param4,param5.toString());
      }
      
      public static function FormatNumber(param1:Number) : String
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
      
      public static function DoubleDigit(param1:int) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return param1.toString();
      }
      
      public static function NextCreepID() : int
      {
         ++_creepCount;
         return _creepCount;
      }
      
      public static function DataCheck(param1:String) : Boolean
      {
         var _loc3_:Object = null;
         var _loc2_:String = param1;
         _loc3_ = JSON.decode(_loc2_);
         var _loc4_:String = _loc3_.h;
         var _loc5_:int = int(_loc3_.hid);
         _loc2_ = _loc2_.split(",\"h\":\"" + _loc4_ + "\"").join("");
         _loc2_ = _loc2_.split(",\"hid\":" + _loc5_).join("");
         var _loc6_:String = md5("ilevbioghv890347ho3nrkljebv" + _loc2_ + _loc5_ * (_loc5_ % 11));
         if(_loc6_ == _loc4_)
         {
            return true;
         }
         GLOBAL.ErrorMessage("Hash in Fail");
         return false;
      }
      
      public static function Check() : String
      {
         var tmpArray:Array = null;
         var Push:Function = function(param1:int):void
         {
            var _loc3_:int = 0;
            var _loc4_:Array = null;
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
                  _loc4_ = _loc2_.costs;
                  _loc3_ = 0;
                  while(_loc3_ < _loc4_.length)
                  {
                     tmpArray.push(_loc4_[_loc3_].r1);
                     tmpArray.push(_loc4_[_loc3_].r2);
                     tmpArray.push(_loc4_[_loc3_].r3);
                     tmpArray.push(_loc4_[_loc3_].r4);
                     tmpArray.push(_loc4_[_loc3_].r5);
                     tmpArray.push(_loc4_[_loc3_].time);
                     tmpArray.push(_loc4_[_loc3_].re);
                     _loc3_++;
                  }
               }
               if(_loc2_.fortify_costs)
               {
                  _loc5_ = _loc2_.fortify_costs;
                  _loc3_ = 0;
                  while(_loc3_ < _loc5_.length)
                  {
                     tmpArray.push(_loc5_[_loc3_].r1);
                     tmpArray.push(_loc5_[_loc3_].r2);
                     tmpArray.push(_loc5_[_loc3_].r3);
                     tmpArray.push(_loc5_[_loc3_].r4);
                     tmpArray.push(_loc5_[_loc3_].r5);
                     tmpArray.push(_loc5_[_loc3_].time);
                     tmpArray.push(_loc5_[_loc3_].re);
                     _loc3_++;
                  }
               }
            }
         };
         tmpArray = [];
         var i:int = 0;
         while(i < _buildingProps.length)
         {
            Push(i);
            i++;
         }
         return md5(JSON.encode(tmpArray));
      }
      
      public static function Brag(param1:String, param2:String, param3:String, param4:String) : void
      {
         GLOBAL.CallJS("sendFeed",[param1,KEYS.Get(param2),KEYS.Get(param3),param4]);
      }
      
      public static function CallJS(param1:String, param2:Array = null, param3:Boolean = true) : void
      {
         if(debugLogJSCalls)
         {
            print("CallJS> func: " + param1 + " \n     args: " + JSON.encode(param2) + " \n     exitFS: " + param3);
         }
         if(param3)
         {
            ThrowStackTrace("CallJS dropping out of full screen");
         }
         if(GLOBAL._local)
         {
            return;
         }
         if(param3 && _ROOT.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            GLOBAL._ROOT.stage.displayState = StageDisplayState.NORMAL;
         }
         if(ExternalInterface.available)
         {
            if(param2 == null)
            {
               ExternalInterface.call("callFunc",param1);
            }
            else
            {
               ExternalInterface.call("callFunc",param1,param2);
            }
         }
      }
      
      public static function CallJSWithClient(param1:String, param2:String = "", param3:Array = null, param4:Boolean = true) : void
      {
         if(debugLogJSCalls)
         {
            print("CallJS> func: " + param1 + " \n     args: " + JSON.encode(param3) + " \n     exitFS: " + param4);
         }
         if(param4)
         {
            ThrowStackTrace("CallJS dropping out of full screen");
         }
         if(GLOBAL._local)
         {
            return;
         }
         if(param4 && _ROOT.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            GLOBAL._ROOT.stage.displayState = StageDisplayState.NORMAL;
         }
         if(ExternalInterface.available)
         {
            if(param3 == null)
            {
               ExternalInterface.call("clientCallWithCallback",param1,param2);
            }
            else
            {
               ExternalInterface.call("clientCallWithCallback",param1,param2,param3);
            }
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
      
      public static function AFK() : void
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
      
      public static function BlockerAdd(param1:Sprite = null) : void
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
      
      public static function BlockerRemove() : void
      {
         var _loc1_:DisplayObject = null;
         if(_blockerList)
         {
            _loc1_ = _blockerList.pop();
            if(_loc1_)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
         }
      }
      
      public static function SaveAttackersDeltaResources() : void
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
      
      public static function CleanAttackersDeltaResources() : void
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
      
      public static function ResizeGame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_fluidWidthEnabled && GAME._firstLoadComplete)
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
         var _loc1_:int = GLOBAL._ROOT.stage.stageWidth;
         var _loc2_:int = GLOBAL.GetGameHeight();
         var _loc4_:int = UI2._wildMonsterBar != null ? 40 : 0;
         if(!_SCREEN || !_SCREEN.x || !_SCREEN.y || !_SCREEN.width || !_SCREEN.height)
         {
            _SCREEN = new Rectangle(0 - (_loc1_ - _SCREENINIT.width) / 2,0 - (_loc2_ - (_SCREENINIT.height + _loc4_)) / 2,_loc1_,_loc2_);
         }
         else
         {
            _SCREEN.x = 0 - (_loc1_ - _SCREENINIT.width) / 2;
            _SCREEN.y = 0 - (_loc2_ - (_SCREENINIT.height + _loc4_)) / 2;
            _SCREEN.width = _loc1_;
            _SCREEN.height = _loc2_;
         }
         _SCREENCENTER = new Point(_SCREEN.x + _SCREEN.width / 2,_SCREEN.y + _SCREEN.height / 2);
         if(Boolean(GLOBAL._flags) && Boolean(GLOBAL._flags.viximo))
         {
            _SCREENHUD = new Point(_SCREEN.x,_SCREEN.y + _SCREEN.height - 0);
            _SCREENHUDLEFT = new Point(_SCREEN.x,_SCREEN.y + _SCREEN.height - 0);
         }
         else
         {
            _SCREENHUD = new Point(_SCREEN.x,_SCREEN.y + _SCREEN.height - 208);
            _SCREENHUDLEFT = new Point(_SCREEN.x,_SCREEN.y + _SCREEN.height - 208);
         }
         if(UI_BOTTOM && UI_BOTTOM._missions && !UI_BOTTOM._missions._open)
         {
            _SCREENHUD = new Point(_SCREEN.x,_SCREEN.y + _SCREEN.height - 30 - 0);
         }
         if(Chat._chatInited && Chat._bymChat && !Chat._bymChat._open)
         {
            _SCREENHUDLEFT = new Point(_SCREEN.x,_SCREEN.y + _SCREEN.height - 30 - 0);
         }
      }
      
      public static function ResizeLayer(param1:Sprite) : void
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc2_:int = param1.numChildren;
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
            else if(_loc3_ is popup_bg2)
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
         var _loc4_:DisplayObjectContainer = param1.parent;
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
      
      public static function ThrowStackTrace(param1:String) : void
      {
      }
      
      public static function gotoURL(param1:String, param2:URLVariables = null, param3:Boolean = true, param4:Array = null) : void
      {
         var _loc5_:String = null;
         var _loc6_:URLVariables = new URLVariables();
         var _loc7_:URLRequest = new URLRequest(param1);
         var _loc8_:String = "_blank";
         if(param1)
         {
            _loc5_ = param1;
            if(param2)
            {
               _loc7_.data = param2;
            }
            if(param3)
            {
               _loc8_ = "_blank";
            }
            else
            {
               _loc8_ = "_parent";
            }
            navigateToURL(_loc7_,_loc8_);
            if(param4)
            {
               LOGGER.Stat(param4);
            }
            return;
         }
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
      
      public static function UpdateAFKTimer() : void
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
         var _loc4_:String = md5(param1 + _loc3_);
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
      
      public static function GetBuildingTownHallLevel(param1:Object) : int
      {
         if(GLOBAL._bTownhall)
         {
            if(Boolean(param1.costs[0].re) && Boolean(param1.costs[0].re[0]))
            {
               return param1.costs[0].re[0][0] == INFERNOQUAKETOWER.UNDERHALL_ID ? (MAPROOM_DESCENT.DescentPassed ? StatGet(BUILDING14.UNDERHALL_LEVEL) : (!!param1.rewarded ? 9 : 0)) : int(_bTownhall._lvl.Get());
            }
            return _bTownhall._lvl.Get();
         }
         return 0;
      }
      
      public static function getDerps(param1:Object) : int
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function get magnification() : Number
      {
         return _magnification;
      }
      
      public static function set magnification(param1:Number) : void
      {
         if(param1 == _magnification)
         {
            return;
         }
         print("zoom " + param1);
         param1 = Math.max(_MAGNIFICATION_BOUNDS.x,param1);
         param1 = Math.min(_MAGNIFICATION_BOUNDS.y,param1);
         TweenLite.to(GLOBAL,0.25,{
            "_magnification":param1,
            "onUpdate":onMagnificationUpdate
         });
      }
      
      private static function onMagnificationUpdate() : void
      {
         print(_magnification);
         MAP._GROUND.scaleX = MAP._GROUND.scaleY = _magnification;
         MAP.Focus(0,0);
         RefreshScreen();
         UI_BOTTOM.Resize();
      }
      
      public static function getPlayerGuardianIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < GLOBAL._playerGuardianData.length)
         {
            if(GLOBAL._playerGuardianData[_loc2_].t == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public static function isAtHome() : Boolean
      {
         return _mode == "build" && BASE._yardType == BASE.MAIN_YARD;
      }
      
      public static function isAtHomeOrInOutpost() : Boolean
      {
         return _mode == "build" && (BASE._yardType == BASE.MAIN_YARD || BASE._yardType == BASE.OUTPOST);
      }
      
      public static function isNoob() : Boolean
      {
         return TUTORIAL._stage <= 200 && _sessionCount < 5;
      }
      
      public static function handleLoadError(param1:IOErrorEvent) : void
      {
         IEventDispatcher(param1.target).removeEventListener(IOErrorEvent.IO_ERROR,GLOBAL.handleLoadError);
         var _loc2_:String = "Error loading: " + param1.text;
         LOGGER.Log("log",_loc2_);
         Console.warning(_loc2_,true);
      }
   }
}

