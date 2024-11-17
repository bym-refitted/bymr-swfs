package
{
   import com.cc.utils.SecNum;
   import com.jac.mouse.MouseWheelEnabler;
   import com.monsters.ai.TRIBES;
   import com.monsters.ai.WMBASE;
   import com.monsters.alliances.ALLIANCES;
   import com.monsters.autobanking.AutoBankManager;
   import com.monsters.baseplanner.BaseTemplate;
   import com.monsters.baseplanner.BaseTemplateNode;
   import com.monsters.baseplanner.PlannerTemplate;
   import com.monsters.chat.Chat;
   import com.monsters.debug.Console;
   import com.monsters.display.BuildingOverlay;
   import com.monsters.effects.ResourceBombs;
   import com.monsters.effects.fire.Fire;
   import com.monsters.effects.particles.ParticleText;
   import com.monsters.effects.smoke.Smoke;
   import com.monsters.frontPage.FrontPageHandler;
   import com.monsters.interfaces.IHandler;
   import com.monsters.kingOfTheHill.KOTHHandler;
   import com.monsters.maproom_advanced.*;
   import com.monsters.pathing.PATHING;
   import com.monsters.radio.RADIO;
   import com.monsters.replayableEvents.ReplayableEventHandler;
   import com.monsters.replayableEvents.monsterMadness.MonsterMadness;
   import com.monsters.rewarding.RewardHandler;
   import com.monsters.siege.*;
   import com.monsters.siege.weapons.*;
   import com.monsters.subscriptions.SubscriptionHandler;
   import flash.display.*;
   import flash.events.*;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.*;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import gs.*;
   import gs.easing.*;
   
   public class BASE
   {
      public static var _baseID:Number;
      
      public static var _wmID:int;
      
      public static var _resources:Object;
      
      public static var _hpResources:Object;
      
      public static var _bankedValue:Number;
      
      public static var _bankedTime:int;
      
      public static var _shakeCountdown:int;
      
      public static var _blockSave:Boolean;
      
      public static var _attackerArray:Array;
      
      public static var _attackerNameArray:Array;
      
      public static var _deltaResources:Object;
      
      public static var _hpDeltaResources:Object;
      
      public static var _savedDeltaResources:Object;
      
      public static var _GIP:Object;
      
      public static var _processedGIP:Object;
      
      public static var _rawGIP:Object;
      
      public static var _lastProcessedGIP:Number;
      
      public static var _credits:SecNum;
      
      public static var _hpCredits:int;
      
      public static var _saveCounterA:int;
      
      public static var _saveCounterB:int;
      
      public static var _saving:Boolean;
      
      public static var _paging:Boolean;
      
      public static var _lastSaveID:int;
      
      public static var _attackID:int;
      
      public static var _lastSaved:int;
      
      public static var _lastSaveRequest:int;
      
      public static var _saveOver:int;
      
      public static var _returnHome:Boolean;
      
      public static var _saveProtect:int;
      
      public static var _saveErrors:int;
      
      public static var _pageErrors:int;
      
      public static var _loadTime:int;
      
      public static var _loading:Boolean;
      
      public static var _infernoSaveLoad:Boolean;
      
      public static var _lastProcessed:int;
      
      public static var _lastProcessedB:int;
      
      public static var _catchupTime:int;
      
      public static var _currentTime:Number;
      
      public static var _baseData:Array;
      
      public static var _upgradeData:Object;
      
      public static var _buildingCount:int;
      
      public static var _buildingData:Object;
      
      public static var _buildingsAll:Object;
      
      public static var _buildingsWalls:Object;
      
      public static var _buildingsTowers:Object;
      
      public static var _buildingsBunkers:Object;
      
      public static var _buildingsHousing:Array;
      
      public static var _buildingsMain:Object;
      
      public static var _buildingsMushrooms:Object;
      
      public static var _buildingsGifts:Object;
      
      public static var _buildingsStored:Object;
      
      public static var _rawMonsters:Object;
      
      public static var _mushroomList:Array;
      
      public static var _lastSpawnedMushroom:int;
      
      public static var _baseName:String;
      
      public static var _baseSeed:int;
      
      public static var _loadedBaseID:int;
      
      public static var _loadedFriendlyBaseID:int;
      
      public static var _loadedFBID:Number;
      
      public static var _baseLevel:int;
      
      public static var _baseValue:Number;
      
      public static var _basePoints:Number;
      
      public static var _outpostValue:Number;
      
      public static var _processing:Boolean;
      
      public static var _timer:int;
      
      public static var _size:int;
      
      public static var _angle:Number;
      
      public static var _buildingCounts:Object;
      
      public static var _buildingStatsToggle:Boolean;
      
      public static var _lastPaged:int;
      
      public static var _tempLoot:Object;
      
      public static var _tempGifts:Array;
      
      public static var _tempSentGifts:Array;
      
      public static var _tempSentInvites:Array;
      
      public static var _isProtected:int;
      
      public static var _isReinforcements:int;
      
      public static var _isSanctuary:int;
      
      public static var _isFan:int;
      
      public static var _isBookmarked:int;
      
      public static var _installsGenerated:int;
      
      public static var _ownerName:String;
      
      public static var _ownerPic:String;
      
      public static var _pendingPurchase:Array;
      
      public static var _pendingPromo:int;
      
      public static var _pendingFBPromo:int;
      
      public static var _pendingFBPromoIDs:Array;
      
      public static var _salePromoTime:int;
      
      public static var _loadBase:Array;
      
      public static var _percentDamaged:int;
      
      public static var _userID:int;
      
      public static var _allianceID:int;
      
      public static var _damagedBaseWarnTime:Number;
      
      public static var _takeoverFirstOpen:int;
      
      public static var _takeoverPreviousOwnersName:String;
      
      private static var _tmpPercent:Number;
      
      private static var _oldSiegeData:Object;
      
      public static var loadObject:Object;
      
      public static var _ideltaResources:Object = null;
      
      public static var _iresources:Object = null;
      
      public static var _autobankCounter:int = 10;
      
      public static var _allianceArmamentTime:SecNum = new SecNum(0);
      
      public static var _loadedYardType:int = 0;
      
      public static const MAIN_YARD:int = 0;
      
      public static const OUTPOST:int = 1;
      
      public static const INFERNO_YARD:int = 2;
      
      public static const INFERNO_OUTPOST:int = 3;
      
      public static var _yardType:int = MAIN_YARD;
      
      public static var _userDigits:Array = [];
      
      public static var _guardianData:Vector.<Object> = new Vector.<Object>(null);
      
      public static var _showingWhatsNew:Boolean = false;
      
      public static var _needCurrentCell:Boolean = false;
      
      public static var _currentCellLoc:Point = null;
      
      private static var _loadedSomething:Boolean = false;
      
      public static const HANDLERS:Vector.<IHandler> = Vector.<IHandler>([RewardHandler.instance,KOTHHandler.instance,SubscriptionHandler.instance]);
      
      public function BASE()
      {
         super();
         _baseID = 0;
         Setup();
         Load();
      }
      
      public static function Setup() : void
      {
         _buildingsHousing = [];
         _buildingsBunkers = {};
         _pendingPurchase = [];
         _buildingCount = 0;
         _processing = false;
         _buildingStatsToggle = false;
         _angle = 0.8;
         _lastPaged = 0;
         _blockSave = false;
         _damagedBaseWarnTime = 0;
         _saveCounterA = 0;
         _saveCounterB = 0;
         _saveOver = 0;
         _returnHome = false;
         _saveProtect = 0;
         _saving = false;
         _paging = false;
         _saveErrors = 0;
         _pageErrors = 0;
         _lastSaved = 0;
         _infernoSaveLoad = false;
         _isProtected = 0;
         _isReinforcements = 0;
         _isSanctuary = 0;
         _isFan = 0;
         _isBookmarked = 0;
         _installsGenerated = 0;
         _ideltaResources = {
            "dirty":false,
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0),
            "r1max":0,
            "r2max":0,
            "r3max":0,
            "r4max":0
         };
         _iresources = {
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0),
            "r1max":0,
            "r2max":0,
            "r3max":0,
            "r4max":0
         };
         _deltaResources = {
            "dirty":false,
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0)
         };
         _hpDeltaResources = {
            "dirty":false,
            "r1":Number(0),
            "r2":Number(0),
            "r3":Number(0),
            "r4":Number(0)
         };
         _savedDeltaResources = {
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0)
         };
         _loadBase = [];
         GLOBAL.Clear();
      }
      
      public static function Cleanup() : void
      {
         var _loc1_:BFOUNDATION = null;
         CREATURES.Clear();
         CREEPS.Clear();
         GLOBAL._ROOT.removeChild(GLOBAL._layerMap);
         GLOBAL._ROOT.removeChild(GLOBAL._layerUI);
         GLOBAL._ROOT.removeChild(GLOBAL._layerWindows);
         GLOBAL._ROOT.removeChild(GLOBAL._layerMessages);
         GLOBAL._ROOT.removeChild(GLOBAL._layerTop);
         GLOBAL._layerMap = GLOBAL._ROOT.addChild(new Sprite());
         GLOBAL._layerUI = GLOBAL._ROOT.addChild(new Sprite());
         GLOBAL._layerWindows = GLOBAL._ROOT.addChild(new Sprite());
         GLOBAL._layerMessages = GLOBAL._ROOT.addChild(new Sprite());
         GLOBAL._layerTop = GLOBAL._ROOT.addChild(new Sprite());
         GLOBAL._layerMap.mouseEnabled = false;
         GLOBAL._layerUI.mouseEnabled = false;
         GLOBAL._layerWindows.mouseEnabled = false;
         GLOBAL._layerMessages.mouseEnabled = false;
         GLOBAL._layerTop.mouseEnabled = false;
         GLOBAL._bProspectorCount = 0;
         GLOBAL._bMinerCount = 0;
         GLOBAL._bStoreCount = 0;
         GLOBAL._bResearchCount = 0;
         GLOBAL._bCreatureCount = 0;
         GLOBAL._bMapCount = 0;
         GLOBAL._bPowerCount = 0;
         GLOBAL._bTowerCount = 0;
         for each(_loc1_ in _buildingsAll)
         {
            _loc1_.Clean();
         }
         _buildingsAll = {};
         _buildingsWalls = {};
         _buildingsTowers = {};
         _buildingsMain = {};
         _buildingsMushrooms = {};
         _buildingsGifts = {};
         _buildingsStored = {};
         GLOBAL._bTownhall = null;
         GLOBAL._bAcademy = null;
         GLOBAL._bBaiter = null;
         GLOBAL._bFlinger = null;
         GLOBAL._bHatchery = null;
         GLOBAL._bHatcheryCC = null;
         GLOBAL._bHousing = null;
         GLOBAL._bJuicer = null;
         GLOBAL._bLocker = null;
         GLOBAL._bMap = null;
         GLOBAL._bStore = null;
         UI2.Hide("warning");
         UI2.Hide("scareAway");
         WMATTACK._inProgress = false;
         MONSTERBAITER._scaredAway = false;
         CUSTOMATTACKS._started = false;
         WMATTACK._queued = null;
         if(Boolean(WMATTACK._history) && Boolean(WMATTACK._history._queued))
         {
            delete WMATTACK._history.queued;
         }
         if(UI2._wildMonsterBar)
         {
            UI2.Hide("wmbar");
         }
         GRID.Cleanup();
         PATHING.Cleanup();
         _showingWhatsNew = false;
         _deltaResources = {
            "dirty":false,
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0)
         };
         _hpDeltaResources = {
            "dirty":false,
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0
         };
         _savedDeltaResources = {
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0)
         };
      }
      
      public static function LoadBase(param1:String = null, param2:Number = 0, param3:Number = 0, param4:String = "build", param5:Boolean = false, param6:int = -1) : Boolean
      {
         if(isNaN(param3))
         {
            param3 = 0;
         }
         if(isNaN(param2))
         {
            param2 = 0;
         }
         if(Boolean(GLOBAL._advancedMap) && MapRoom._open)
         {
            MapRoom.Hide();
         }
         if(MAPROOM_INFERNO._open)
         {
            MAPROOM_INFERNO.Hide();
         }
         if(MAPROOM._open)
         {
            MAPROOM.Hide();
         }
         if(!GLOBAL._advancedMap && (param4 == "attack" || param4 == "iattack") && (GLOBAL._mode != "build" && GLOBAL._mode != "ibuild"))
         {
            return false;
         }
         if(MAPROOM_DESCENT._inDescent && (param6 == MAIN_YARD || param6 == OUTPOST))
         {
            MAPROOM_DESCENT.ExitDescent();
         }
         if(!_loading)
         {
            GLOBAL._reloadonerror = param5;
            if(param3 == 0 && param2 == 0)
            {
               if(param4 != "ibuild")
               {
                  param4 = "build";
               }
            }
            if((param4 == "attack" || param4 == "wmattack") && (!GLOBAL._advancedMap && (!GLOBAL._bFlinger || !GLOBAL._bFlinger._canFunction) && !isInferno()))
            {
               LOGGER.Log("err","Impossible fling");
               GLOBAL.ErrorMessage("BASE.LoadBase impossible fling");
               return false;
            }
            _loadBase = [param1,param2,param3,param4,param6];
            if(!GLOBAL._advancedMap && (param4 == "attack" || param4 == "wmattack" || param4 == "iattack" || param4 == "iwmattack"))
            {
               PLEASEWAIT.Show(KEYS.Get("msg_preparing"));
               BASE.Save(0,false,true);
            }
            else if(!_saving)
            {
               LoadBaseB();
            }
         }
         return true;
      }
      
      public static function LoadBaseB() : void
      {
         GLOBAL.Message("LoadBaseB vars:" + JSON.encode(_loadBase));
         GLOBAL._baseURL2 = _loadBase[0];
         var _loc1_:Number = Number(_loadBase[1]);
         var _loc2_:Number = Number(_loadBase[2]);
         var _loc3_:String = _loadBase[3];
         var _loc4_:int = int(_loadBase[4]);
         _loadBase = [];
         GLOBAL.Setup(_loc3_);
         Load(GLOBAL._baseURL2,_loc1_,_loc2_,_loc4_);
      }
      
      public static function Load(param1:String = null, param2:Number = 0, param3:Number = 0, param4:int = -1) : void
      {
         var t:int;
         var tmpMode:String;
         var loadVars:Array;
         var midgameIncentive:int;
         var lastDigit:int;
         var secondLastDigit:int;
         var thirdLastDigit:int;
         var diffShowMidgameIncentive1:int;
         var diffShowMidgameIncentive2:int;
         var handleLoadSuccessful:Function = null;
         var handleLoadError:Function = null;
         var url:String = param1;
         var userid:Number = param2;
         var baseid:Number = param3;
         var yardtype:int = param4;
         handleLoadSuccessful = function(param1:Object):void
         {
            var TauntB:Function;
            var onImageLoad:Function;
            var LoadImageError:Function;
            var firstLoad:Boolean = false;
            var idstr:String = null;
            var ix:int = 0;
            var r:Object = null;
            var bd:Object = null;
            var i:String = null;
            var ir:Object = null;
            var opKey:String = null;
            var op:Object = null;
            var height:int = 0;
            var opbd:Object = null;
            var value:int = 0;
            var kx:int = 0;
            var id:String = null;
            var ooo:Object = null;
            var length:int = 0;
            var j:int = 0;
            var st:String = null;
            var attacksArr:Array = null;
            var attackCount:int = 0;
            var attackObj:Object = null;
            var found:Boolean = false;
            var listed:Object = null;
            var popupMC:popup_attackedme = null;
            var loader:Loader = null;
            var promoTimer:int = 0;
            var promoItemsArr:Array = null;
            var promoID:Array = null;
            var promoGifts:Array = null;
            var obj:Object = param1;
            if(obj.error == 0)
            {
               loadObject = obj;
               firstLoad = false;
               if(!_loadedSomething)
               {
                  if(ExternalInterface.available)
                  {
                     ExternalInterface.call("cc.recordStats","baseend");
                  }
                  firstLoad = true;
                  _loadedSomething = true;
                  GAME._firstLoadComplete = true;
               }
               if(GLOBAL._mode == "build" || GLOBAL._mode == "ibuild")
               {
                  GLOBAL._openBase = null;
               }
               MapRoom._worldID = obj.worldid;
               GLOBAL.SetFlags(obj.flags);
               QUESTS.Setup();
               GLOBAL._reloadonerror = false;
               _isProtected = int(obj["protected"]);
               _isFan = int(obj.fan);
               _isBookmarked = int(obj.bookmarked);
               _installsGenerated = int(obj.installsgenerated);
               if(obj.fan)
               {
                  QUESTS._global.bonus_fan = 1;
               }
               if(obj.bookmarked)
               {
                  QUESTS._global.bonus_bookmark = 1;
               }
               if(obj.giftsentcount)
               {
                  QUESTS._global.bonus_gifts = obj.giftsentcount;
               }
               QUESTS._global.bonus_invites = _installsGenerated;
               _lastProcessed = int(obj.savetime);
               GLOBAL.t = _lastProcessed;
               _currentTime = int(obj.currenttime);
               if(_lastProcessed < _currentTime - 172800)
               {
                  _lastProcessed = _currentTime - 172800;
               }
               if(obj.chatservers != null)
               {
                  Chat._chatServers = obj.chatservers;
               }
               else
               {
                  Chat._chatServers = new Array();
               }
               _lastSaveID = obj.id;
               _baseSeed = obj.baseseed;
               _loadedBaseID = obj.baseid;
               if(GLOBAL._mode == "build")
               {
                  _loadedFriendlyBaseID = obj.baseid;
                  _loadedYardType = _yardType;
               }
               _loadedFBID = obj.fbid;
               _userID = obj.userid;
               idstr = _userID.toString();
               _userDigits = [];
               ix = 0;
               while(ix < idstr.length)
               {
                  _userDigits.push(int(idstr.charAt(ix)));
                  ix++;
               }
               if(GLOBAL._mode == "build" && _yardType % 2 == MAIN_YARD && !isInferno())
               {
                  if(obj.alliancedata)
                  {
                     _allianceID = int(obj.alliancedata.alliance_id);
                     if(_userID == LOGIN._playerID)
                     {
                        ALLIANCES._allianceID = int(obj.alliancedata.alliance_id);
                        ALLIANCES._myAlliance = ALLIANCES.SetAlliance(obj.alliancedata);
                        ACHIEVEMENTS.Check("alliance",1);
                     }
                  }
                  else if(_userID == LOGIN._playerID && (ALLIANCES._allianceID || ALLIANCES._myAlliance))
                  {
                     ALLIANCES.Clear();
                  }
               }
               if(obj.powerups)
               {
                  POWERUPS.Setup(obj.powerups,null,true);
               }
               if(obj.attpowerups)
               {
                  POWERUPS.Setup(null,obj.attpowerups,true);
               }
               _attackID = int(obj.attackid);
               if(obj.worldsize)
               {
                  MapRoom._mapWidth = obj.worldsize[0];
                  MapRoom._mapHeight = obj.worldsize[1];
               }
               if(obj.usemap)
               {
                  if(isInferno())
                  {
                     GLOBAL._advancedMap = 0;
                  }
                  else
                  {
                     GLOBAL._advancedMap = obj.usemap;
                  }
               }
               if(GLOBAL._advancedMap)
               {
                  if(GLOBAL._mode == "build")
                  {
                     if(obj.homebaseid)
                     {
                        GLOBAL._homeBaseID = obj.homebaseid;
                     }
                     if(obj.homebase)
                     {
                        if(obj.homebase.length == 2 && obj.homebase[0] > -1 && obj.homebase[1] > -1)
                        {
                           if(obj.outposts)
                           {
                              GLOBAL._mapOutpost = [];
                              GLOBAL._mapOutpostIDs = [];
                              ix = 0;
                              while(ix < obj.outposts.length)
                              {
                                 if(obj.outposts[ix].length == 3)
                                 {
                                    GLOBAL._mapOutpost.push(new Point(obj.outposts[ix][0],obj.outposts[ix][1]));
                                    GLOBAL._mapOutpostIDs.push(obj.outposts[ix][2]);
                                 }
                                 ix++;
                              }
                           }
                           GLOBAL._mapHome = new Point(obj.homebase[0],obj.homebase[1]);
                        }
                        else
                        {
                           LOGGER.Log("err","BASE.Process Invalid home base coordinate. " + obj.homebase);
                        }
                     }
                     if(obj.empiredestroyed)
                     {
                        GLOBAL._empireDestroyed = obj.empiredestroyed;
                     }
                     else
                     {
                        GLOBAL._empireDestroyed = 0;
                     }
                  }
               }
               GLOBAL._unreadMessages = obj.unreadmessages;
               r = obj.resources;
               _resources = {};
               _resources.r1 = new SecNum(Math.floor(r.r1));
               _resources.r2 = new SecNum(Math.floor(r.r2));
               _resources.r3 = new SecNum(Math.floor(r.r3));
               _resources.r4 = new SecNum(Math.floor(r.r4));
               _resources.r1bonus = r.r1bonus;
               _resources.r2bonus = r.r2bonus;
               _resources.r3bonus = r.r3bonus;
               _resources.r4bonus = r.r4bonus;
               if(obj.iresources)
               {
                  ir = obj.iresources;
                  _iresources.r1 = new SecNum(Math.floor(ir.r1));
                  _iresources.r2 = new SecNum(Math.floor(ir.r2));
                  _iresources.r3 = new SecNum(Math.floor(ir.r3));
                  _iresources.r4 = new SecNum(Math.floor(ir.r4));
                  _iresources.r1max = int(ir.r1max);
                  _iresources.r2max = int(ir.r2max);
                  _iresources.r3max = int(ir.r3max);
                  _iresources.r4max = int(ir.r4max);
               }
               if(Boolean(obj.updates) && obj.updates.length > 0)
               {
                  UPDATES.Process(obj.updates);
               }
               else if(obj.lastupdate)
               {
                  UPDATES._lastUpdateID = Number(obj.lastupdate);
               }
               else
               {
                  UPDATES._lastUpdateID = 0;
               }
               if(obj.mushrooms.l)
               {
                  _mushroomList = obj.mushrooms.l;
               }
               if(obj.mushrooms.s)
               {
                  _lastSpawnedMushroom = int(obj.mushrooms.s);
               }
               _buildingData = obj.buildingdata;
               for each(bd in _buildingData)
               {
                  if(bd.t == 14)
                  {
                     if(_yardType % 2 == OUTPOST && (GLOBAL._currentCell && GLOBAL._currentCell._base == 3))
                     {
                        LOGGER.Log("err","Base ID " + _loadedBaseID + " outpost w TH bdg");
                        GLOBAL.ErrorMessage("BASE.Process outpost w TH");
                     }
                     break;
                  }
                  if(bd.t == 112)
                  {
                     if(_yardType % 2 == MAIN_YARD && (GLOBAL._currentCell && GLOBAL._currentCell._base != 3))
                     {
                        LOGGER.Log("err","Base ID " + _loadedBaseID + " yard w OP bdg");
                        GLOBAL.ErrorMessage("BASE.Process yard w outpost");
                     }
                     break;
                  }
               }
               _rawGIP = obj.buildingresources;
               _processedGIP = {};
               _GIP = {
                  "r1":new SecNum(0),
                  "r2":new SecNum(0),
                  "r3":new SecNum(0),
                  "r4":new SecNum(0)
               };
               if(_rawGIP)
               {
                  if(_rawGIP["b" + GLOBAL._homeBaseID])
                  {
                     delete _rawGIP["b" + GLOBAL._homeBaseID];
                  }
                  if(Boolean(_rawGIP["t"]) && (GLOBAL._mode !== GLOBAL.MODE_ATTACK || AutoBankManager.AUTOBANK_FIX))
                  {
                     _lastProcessedGIP = _rawGIP["t"];
                     delete _rawGIP["t"];
                  }
                  else
                  {
                     _lastProcessedGIP = _lastProcessed;
                  }
                  if(GLOBAL.Timestamp() - _lastProcessedGIP > 172800)
                  {
                     _lastProcessedGIP = GLOBAL.Timestamp() - 172800;
                  }
                  if(GLOBAL._mode == "build" || GLOBAL._mode == "attack")
                  {
                     for(opKey in _rawGIP)
                     {
                        op = _rawGIP[opKey];
                        if(opKey == "t")
                        {
                           _lastProcessedGIP = _rawGIP[opKey];
                        }
                        else
                        {
                           if(op is String)
                           {
                              break;
                           }
                           if(op["r1"] != undefined)
                           {
                              _processedGIP[opKey] = {
                                 "r1":new SecNum(op["r1"]),
                                 "r2":new SecNum(op["r2"]),
                                 "r3":new SecNum(op["r3"]),
                                 "r4":new SecNum(op["r4"])
                              };
                           }
                           else
                           {
                              height = int(_rawGIP[opKey]["height"]);
                              if(height)
                              {
                                 delete op["height"];
                              }
                              else
                              {
                                 height = 100;
                              }
                              _processedGIP[opKey] = {
                                 "r1":new SecNum(0),
                                 "r2":new SecNum(0),
                                 "r3":new SecNum(0),
                                 "r4":new SecNum(0)
                              };
                              for each(opbd in op)
                              {
                                 if(opbd.t >= 1 && opbd.t <= 4)
                                 {
                                    if(opbd.l)
                                    {
                                       value = int(OUTPOST_YARD_PROPS._outpostProps[opbd.t - 1].produce[opbd.l - 1]);
                                    }
                                    else
                                    {
                                       value = int(OUTPOST_YARD_PROPS._outpostProps[opbd.t - 1].produce[0]);
                                    }
                                    value = Math.max(int(value * GLOBAL._averageAltitude.Get() / height),1);
                                    _processedGIP[opKey]["r" + opbd.t].Add(value);
                                 }
                              }
                              _rawGIP[opKey] = {
                                 "r1":_processedGIP[opKey].r1.Get(),
                                 "r2":_processedGIP[opKey].r2.Get(),
                                 "r3":_processedGIP[opKey].r3.Get(),
                                 "r4":_processedGIP[opKey].r4.Get()
                              };
                           }
                           _GIP["r1"].Add(_processedGIP[opKey]["r1"].Get());
                           _GIP["r2"].Add(_processedGIP[opKey]["r2"].Get());
                           _GIP["r3"].Add(_processedGIP[opKey]["r3"].Get());
                           _GIP["r4"].Add(_processedGIP[opKey]["r4"].Get());
                        }
                     }
                     _processedGIP["t"] = _lastProcessedGIP;
                  }
               }
               _baseName = obj.basename;
               _baseValue = uint(obj.basevalue);
               _basePoints = Number(obj.points);
               if(!_outpostValue)
               {
                  _outpostValue = 0;
               }
               if(!_basePoints)
               {
                  _basePoints = 0;
               }
               _credits = new SecNum(int(obj.credits));
               GLOBAL._credits = new SecNum(int(obj.credits));
               _hpCredits = int(obj.credits);
               _tempLoot = obj.loot;
               GLOBAL.SetBuildingProps();
               _buildingsStored = {};
               for(i in obj.researchdata)
               {
                  if(obj.researchdata[i])
                  {
                     _buildingsStored[i] = new SecNum(obj.researchdata[i]);
                  }
               }
               _hpResources = {
                  "r1":_resources.r1.Get(),
                  "r2":_resources.r2.Get(),
                  "r3":_resources.r3.Get(),
                  "r4":_resources.r4.Get()
               };
               if(GLOBAL._mode == "build")
               {
                  kx = 1;
                  while(kx < 5)
                  {
                     GLOBAL._resources["r" + kx] = new SecNum(_resources["r" + kx].Get());
                     GLOBAL._hpResources["r" + kx] = _resources["r" + kx].Get();
                     kx++;
                  }
               }
               if(obj.stats.mp)
               {
                  QUESTS._global.mushroomspicked = obj.stats.mp;
               }
               if(obj.stats.mg)
               {
                  QUESTS._global.goldmushroomspicked = obj.stats.mg;
               }
               if(obj.stats.mob)
               {
                  QUESTS._global.monstersblended = obj.stats.mob;
               }
               if(obj.stats.mobg)
               {
                  QUESTS._global.monstersblendedgoo = obj.stats.mobg;
               }
               if(obj.stats.moga)
               {
                  QUESTS._global.gift_accept = obj.stats.moga;
               }
               NewPopupSystem.instance.Setup(obj.stats.popupdata);
               if(obj.stats.updateid)
               {
                  GLOBAL._whatsnewid = obj.stats.updateid;
               }
               if(obj.stats.updateid_mr2 != null)
               {
                  GLOBAL._mr2TutorialId = Math.max(GLOBAL._mr2TutorialId,obj.stats.updateid_mr2);
               }
               else
               {
                  GLOBAL._mr2TutorialId = Math.max(GLOBAL._mr2TutorialId,!!GLOBAL._advancedMap ? 1 : 0);
               }
               GLOBAL._otherStats = {"s":1};
               if(obj.stats.other)
               {
                  GLOBAL._otherStats = obj.stats.other;
               }
               if(GLOBAL.StatGet(BUILDING11.CHANGED_TO_MR2) == 1)
               {
                  LOGGER.StatB({
                     "st1":"world_map",
                     "st2":"enter"
                  },MapRoom._worldID);
                  GLOBAL.StatSet(BUILDING11.CHANGED_TO_MR2,2);
               }
               if(obj.wmid)
               {
                  _wmID = obj.wmid;
               }
               if(GLOBAL._otherStats && GLOBAL._otherStats.descentLvl && GLOBAL._mode == "build")
               {
                  if(Boolean(WMBASE._descentBases) && WMBASE._descentBases.length > 0)
                  {
                     if(MAPROOM_DESCENT.DescentLevel > 1)
                     {
                        MAPROOM_DESCENT._descentLvl = MAPROOM_DESCENT.DescentLevel;
                        GLOBAL.StatSet("descentLvl",MAPROOM_DESCENT._descentLvl);
                     }
                  }
                  else if(MAPROOM_DESCENT._descentLvl < obj.stats.other.descentLvl)
                  {
                     MAPROOM_DESCENT._descentLvl = obj.stats.other.descentLvl;
                  }
               }
               ACADEMY.Data(obj.academy);
               if(GLOBAL._mode == "build" && _yardType % 2 == MAIN_YARD)
               {
                  GLOBAL._playerCreatureUpgrades = JSON.decode("{\"C1\":{\"level\":1},\"C2\":{\"level\":1}}");
                  for(id in ACADEMY._upgrades)
                  {
                     GLOBAL._playerCreatureUpgrades[id] = {"level":ACADEMY._upgrades[id].level};
                     if(ACADEMY._upgrades[id].powerup)
                     {
                        GLOBAL._playerCreatureUpgrades[id].powerup = ACADEMY._upgrades[id].powerup;
                     }
                  }
               }
               if(GLOBAL._mode == "build" && (_yardType == MAIN_YARD || _yardType == INFERNO_YARD))
               {
                  SiegeWeapons.importWeapons(obj.siege);
               }
               else
               {
                  _oldSiegeData = obj.siege;
               }
               EFFECTS.Setup(obj.effects);
               if(Boolean(obj.monsters) && Boolean(obj.monsters.housed))
               {
                  HOUSING.Data(obj.monsters.housed);
               }
               else if(obj.monsters)
               {
                  HOUSING.Data(obj.monsters);
               }
               _rawMonsters = obj.monsters;
               TRIBES.Setup();
               if(obj.wmstatus)
               {
                  WMBASE.Data(obj.wmstatus);
               }
               else
               {
                  WMBASE.Clear();
               }
               WMATTACK.Setup(obj.aiattacks);
               if(GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview" || GLOBAL._mode == "iwmattack")
               {
                  WMBASE.Setup();
               }
               TUTORIAL.Setup();
               if(GLOBAL._mode == "build")
               {
                  TUTORIAL._stage = int(obj.tutorialstage);
                  TUTORIAL.Tick();
               }
               WORKERS.Setup();
               QUEUE.Setup();
               STORE.Data(obj.storeitems,obj.storedata,obj.inventory);
               CREATURELOCKER.Data(obj.lockerdata);
               QUESTS.Data(obj.quests);
               MONSTERBAITER.Setup(obj.monsterbaiter);
               if(obj.chatenabled != null)
               {
                  Chat._chatEnabled = obj.chatenabled;
                  if(Chat.flagsShouldChatExist())
                  {
                     Chat.initChat();
                  }
               }
               if(obj.stats.achievements)
               {
                  ACHIEVEMENTS.Data(obj.stats.achievements);
                  ACHIEVEMENTS.CheckRetroactiveAchievments();
               }
               else if(obj.quests)
               {
                  if(GLOBAL._mode == "build")
                  {
                     ACHIEVEMENTS._stats.upgrade_champ1 = QUESTS._global.upgrade_champ1;
                     ACHIEVEMENTS._stats.upgrade_champ2 = QUESTS._global.upgrade_champ2;
                     ACHIEVEMENTS._stats.upgrade_champ3 = QUESTS._global.upgrade_champ3;
                     ACHIEVEMENTS._stats.monstersblended = QUESTS._global.monstersblended;
                     ACHIEVEMENTS._stats.wm2hall = QUESTS._global.destroy_tribe2;
                     if(obj.alliancedata)
                     {
                        if(obj.alliancedata.alliance_id)
                        {
                           ACHIEVEMENTS._stats.alliance = 1;
                        }
                     }
                     ACHIEVEMENTS.Check();
                  }
               }
               _guardianData.length = 0;
               if(obj.champion)
               {
                  if(obj.champion != "\"null\"" && obj.champion != "null")
                  {
                     ooo = JSON.decode(obj.champion);
                     length = 0;
                     if(ooo.t)
                     {
                        length = 1;
                        ooo = [ooo];
                     }
                     else
                     {
                        length = int(ooo.length);
                     }
                     j = 0;
                     while(j < length)
                     {
                        try
                        {
                           if(ooo[j].t)
                           {
                              _guardianData[j] = {};
                              if(ooo[j].nm)
                              {
                                 _guardianData[j].nm = ooo[j].nm;
                              }
                              _guardianData[j].t = ooo[j].t;
                              if(ooo[j].ft)
                              {
                                 _guardianData[j].ft = ooo[j].ft;
                              }
                              if(ooo[j].fd)
                              {
                                 _guardianData[j].fd = ooo[j].fd;
                              }
                              else
                              {
                                 _guardianData[j].fd = 0;
                              }
                              if(ooo[j].l)
                              {
                                 _guardianData[j].l = new SecNum(ooo[j].l);
                              }
                              else
                              {
                                 _guardianData[j].l = new SecNum(0);
                              }
                              if(ooo[j].hp)
                              {
                                 _guardianData[j].hp = new SecNum(ooo[j].hp);
                              }
                              else
                              {
                                 _guardianData[j].hp = new SecNum(0);
                              }
                              if(ooo[j].fb)
                              {
                                 _guardianData[j].fb = new SecNum(ooo[j].fb);
                              }
                              else
                              {
                                 _guardianData[j].fb = new SecNum(0);
                              }
                              if(ooo[j].pl)
                              {
                                 _guardianData[j].pl = new SecNum(ooo[j].pl);
                              }
                              else
                              {
                                 _guardianData[j].pl = new SecNum(0);
                              }
                           }
                        }
                        catch(e:Error)
                        {
                           st = JSON.decode(obj.champion) as String;
                           _guardianData[j] = JSON.decode(st);
                        }
                        if(GLOBAL._mode == "build" && _yardType == MAIN_YARD && Boolean(_guardianData[j]))
                        {
                           GLOBAL._playerGuardianData[j] = {};
                           if(_guardianData[j].nm)
                           {
                              GLOBAL._playerGuardianData[j].nm = _guardianData[j].nm;
                           }
                           if(_guardianData[j].t)
                           {
                              GLOBAL._playerGuardianData[j].t = _guardianData[j].t;
                           }
                           if(_guardianData[j].ft)
                           {
                              GLOBAL._playerGuardianData[j].ft = _guardianData[j].ft;
                           }
                           if(_guardianData[j].fd)
                           {
                              GLOBAL._playerGuardianData[j].fd = _guardianData[j].fd;
                           }
                           else
                           {
                              GLOBAL._playerGuardianData[j].fd = 0;
                           }
                           if(_guardianData[j].l)
                           {
                              GLOBAL._playerGuardianData[j].l = new SecNum(_guardianData[j].l.Get());
                           }
                           else
                           {
                              GLOBAL._playerGuardianData[j].l = new SecNum(0);
                           }
                           if(_guardianData[j].hp)
                           {
                              GLOBAL._playerGuardianData[j].hp = new SecNum(_guardianData[j].hp.Get());
                           }
                           else
                           {
                              GLOBAL._playerGuardianData[j].hp = new SecNum(0);
                           }
                           if(_guardianData[j].fb)
                           {
                              GLOBAL._playerGuardianData[j].fb = new SecNum(_guardianData[j].fb.Get());
                           }
                           else
                           {
                              GLOBAL._playerGuardianData[j].fb = new SecNum(0);
                           }
                           if(_guardianData[j].pl)
                           {
                              GLOBAL._playerGuardianData[j].pl = new SecNum(_guardianData[j].pl.Get());
                           }
                           else
                           {
                              GLOBAL._playerGuardianData[j].pl = new SecNum(0);
                           }
                        }
                        j++;
                     }
                  }
               }
               _attackerArray = [];
               _attackerNameArray = [];
               if(obj.attacks)
               {
                  TauntB = function(param1:int, param2:int):*
                  {
                     var n:int = param1;
                     var fbid:int = param2;
                     return function(param1:MouseEvent):*
                     {
                        GLOBAL.CallJS("sendFeed",["tauntB",KEYS.Get("js_attackedmyyard"),KEYS.Get("js_tauned"),"taunt" + n + ".png",fbid]);
                        POPUPS.Next();
                     };
                  };
                  attacksArr = obj.attacks;
                  attackCount = 0;
                  for each(attackObj in attacksArr)
                  {
                     attackCount++;
                     found = false;
                     for each(listed in _attackerArray)
                     {
                        if(listed.fbid == attackObj.fbid)
                        {
                           found = true;
                           ++listed.count;
                           listed.lastTime = attackObj.starttime;
                        }
                     }
                     if(!found)
                     {
                        _attackerNameArray.push([0,attackObj.name]);
                        _attackerArray.push({
                           "fbid":attackObj.fbid,
                           "name":attackObj.name,
                           "pic":attackObj.pic_square,
                           "friend":attackObj.friend,
                           "count":1,
                           "lastTime":attackObj.starttime
                        });
                     }
                  }
                  for each(attackObj in _attackerArray)
                  {
                     popupMC = new popup_attackedme();
                     popupMC.gotoAndStop(1);
                     if(attackObj.count == 1)
                     {
                        popupMC.tA.htmlText = KEYS.Get("pop_attackedyou",{
                           "v1":attackObj.name,
                           "v2":GLOBAL.ToTime(_currentTime - int(attackObj.lastTime),true)
                        });
                     }
                     else
                     {
                        popupMC.tA.htmlText = KEYS.Get("pop_attackedyouxtimes",{
                           "v1":attackObj.name,
                           "v2":attackObj.count,
                           "v3":GLOBAL.ToTime(_currentTime - int(attackObj.lastTime),true)
                        });
                     }
                     if(attackObj.pic)
                     {
                        try
                        {
                           onImageLoad = function(param1:Event):void
                           {
                              loader.height = 50;
                              loader.width = 50;
                           };
                           LoadImageError = function(param1:IOErrorEvent):*
                           {
                           };
                           loader = new Loader();
                           loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,LoadImageError,false,0,true);
                           loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoad);
                           popupMC.mcPic.mcBG.addChild(loader);
                           loader.load(new URLRequest(attackObj.pic));
                        }
                        catch(e:Error)
                        {
                        }
                     }
                     if(attackObj.friend == 1)
                     {
                        popupMC.bShare.SetupKey("btn_talktrash");
                        popupMC.bShare.Highlight = true;
                        popupMC.bShare.addEventListener(MouseEvent.CLICK,function TauntA(param1:MouseEvent):*
                        {
                           var _loc2_:* = param1.target.parent;
                           _loc2_.gotoAndStop(2);
                           var _loc3_:int = 1;
                           while(_loc3_ < 4)
                           {
                              _loc2_["b" + _loc3_].gotoAndStop(_loc3_);
                              _loc2_["b" + _loc3_].buttonMode = true;
                              _loc2_["b" + _loc3_].addEventListener(MouseEvent.CLICK,TauntB(_loc3_,attackObj.fbid));
                              _loc3_++;
                           }
                        });
                     }
                     else
                     {
                        popupMC.bShare.visible = false;
                     }
                     POPUPS.Push(popupMC);
                  }
               }
               _ownerName = GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview" ? TRIBES.TribeForBaseID(_wmID).name : obj.name;
               _ownerPic = GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview" ? TRIBES.TribeForBaseID(_wmID).profilepic : obj.pic_square;
               if(!GLOBAL._flags.viximo && !GLOBAL._flags.kongregate)
               {
                  if(obj.promotiontimer)
                  {
                     if(obj.promotiontimer is int)
                     {
                        promoTimer = int(obj.promotiontimer);
                        GLOBAL._flags.hasPromo = 1;
                     }
                     else if(obj.promotiontimer is String && obj.promotiontimer == "purchasereceive")
                     {
                        if(obj.purchasereceive)
                        {
                           promoItemsArr = obj.purchasereceive;
                           BUY.purchaseProcess(promoItemsArr);
                           BUY.purchaseComplete(obj.promotiontimer);
                           GLOBAL._flags.hasPromo = 1;
                        }
                     }
                  }
               }
               if(!GLOBAL._flags.viximo && !GLOBAL._flags.kongregate)
               {
                  if(obj.fbpromos)
                  {
                     promoID = [];
                     promoGifts = [];
                     if(obj.fbpromos)
                     {
                        if(obj.fbpromos.ids)
                        {
                           promoID = obj.fbpromos.ids;
                        }
                        if(promoGifts)
                        {
                           promoGifts = obj.fbpromos.items;
                        }
                        if(Boolean(promoID) && Boolean(promoGifts))
                        {
                           _pendingFBPromo = 1;
                           GLOBAL._flags.hasFBPromo = 1;
                           if(promoGifts)
                           {
                              BUY.purchaseProcess(promoGifts);
                              BUY.purchaseComplete("biggulp");
                           }
                           if(promoID)
                           {
                              _pendingFBPromoIDs = promoID;
                           }
                        }
                        GLOBAL._flags.hasPromo = 1;
                     }
                  }
               }
               _tempGifts = obj.gifts;
               if(obj.sentgifts)
               {
                  _tempSentGifts = obj.sentgifts;
               }
               if(obj.sentinvites)
               {
                  _tempSentInvites = obj.sentinvites;
               }
               else
               {
                  _tempSentInvites = [];
               }
               Build();
               WMBASE.CheckQuests();
            }
            else if(GLOBAL._reloadonerror)
            {
               GLOBAL.CallJS("reloadPage");
            }
            else if(GLOBAL._local && obj.error == "Incorrect map version")
            {
               switch(GLOBAL._localMode)
               {
                  case 1:
                     if(GLOBAL._baseURL == "http://bym-fb-trunk.dev.kixeye.com/base/")
                     {
                        GLOBAL._baseURL = "http://bym-fb-trunk.dev.kixeye.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "http://bym-fb-trunk.dev.kixeye.com/base/";
                     break;
                  case 2:
                     if(GLOBAL._baseURL == "http://bym-ko-halbvip1.dc.kixeye.com/base/")
                     {
                        GLOBAL._baseURL = "http://bym-ko-halbvip1.dc.kixeye.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "http://bym-ko-halbvip1.dc.kixeye.com/base/";
                     break;
                  case 3:
                     if(GLOBAL._baseURL == "http://bmdev.vx.casualcollective.com/base/")
                     {
                        GLOBAL._baseURL = "http://bmdev.vx.casualcollective.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "http://bmdev.vx.casualcollective.com/base/";
                     break;
                  case 4:
                     if(GLOBAL._baseURL == "http://bym-vx2-vip.sjc.kixeye.com/base/")
                     {
                        GLOBAL._baseURL = "http://bym-vx2-vip.sjc.kixeye.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "http://bym-vx2-vip.sjc.kixeye.com/base/";
                     break;
                  case 5:
                     if(GLOBAL._baseURL == "http://bym-fb-inferno.dev.kixeye.com/base/")
                     {
                        GLOBAL._baseURL = "http://bym-fb-inferno.dev.kixeye.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "http://bym-fb-inferno.dev.kixeye.com/base/";
                     break;
                  case 6:
                     if(GLOBAL._baseURL == "https://bym-fb-lbns.dc.kixeye.com/base/")
                     {
                        GLOBAL._baseURL = "https://bym-fb-lbns.dc.kixeye.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "https://bym-fb-lbns.dc.kixeye.com/base/";
                     break;
                  case 7:
                     if(GLOBAL._baseURL = "http://bym-vx-web.stage.kixeye.com/base/")
                     {
                        GLOBAL._baseURL = "http://bym-vx-web.stage.kixeye.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "http://bym-vx-web.stage.kixeye.com/base/";
                     break;
                  case 8:
                     if(GLOBAL._baseURL == "http://bym-fb-alex.dev.kixeye.com/base/")
                     {
                        GLOBAL._baseURL = "http://bym-fb-alex.dev.kixeye.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "http://bym-fb-alex.dev.kixeye.com/base/";
                     break;
                  case 9:
                     if(GLOBAL._baseURL == "http://bym-fb-nmoore.dev.kixeye.com/base/")
                     {
                        GLOBAL._baseURL = "http://bym-fb-nmoore.dev.kixeye.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "http://bym-fb-nmoore.dev.kixeye.com/base/";
                     break;
                  case 10:
                     if(GLOBAL._baseURL == "http://bm-kg-web2.dev.casualcollective.com/base/")
                     {
                        GLOBAL._baseURL = "http://bm-kg-web2.dev.casualcollective.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "http://bm-kg-web2.dev.casualcollective.com/base/";
                     break;
                  case 11:
                     if(GLOBAL._baseURL == "http://bym-ko-web1.stage.com/base/")
                     {
                        GLOBAL._baseURL = "http://bym-ko-web1.stage.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "http://bym-ko-web1.stage.kixeye.com/api/bm/base/";
                     break;
                  default:
                     if(GLOBAL._baseURL == "http://bym-fb-web1.stage.kixeye.com/base/")
                     {
                        GLOBAL._baseURL = "http://bym-fb-web1.stage.kixeye.com/api/bm/base/";
                        break;
                     }
                     GLOBAL._baseURL = "http://bym-fb-web1.stage.kixeye.com/base/";
                     break;
               }
               BASE.Load();
            }
            else
            {
               GLOBAL.ErrorMessage(obj.error,GLOBAL.ERROR_ORANGE_BOX_ONLY);
               PLEASEWAIT.Hide();
            }
         };
         handleLoadError = function(param1:IOErrorEvent):void
         {
            if(GLOBAL._reloadonerror)
            {
               GLOBAL.CallJS("reloadPage");
            }
            else
            {
               LOGGER.Log("err","BASE.Load HTTP");
               PLEASEWAIT.Hide();
               GLOBAL.ErrorMessage("BASE.Load HTTP");
            }
         };
         GLOBAL._baseLoads += 1;
         t = getTimer();
         _loading = true;
         _baseID = baseid;
         _baseLevel = 0;
         _autobankCounter = 10;
         if(yardtype >= MAIN_YARD)
         {
            _yardType = yardtype;
         }
         _saveOver = 0;
         _returnHome = false;
         _saveProtect = 0;
         PLEASEWAIT.Hide();
         Cleanup();
         PLEASEWAIT.Show(KEYS.Get("msg_loading"));
         GRID.CreateGrid();
         POPUPS.Setup();
         CREEPS.Clear();
         GLOBAL.Clear();
         MAP.Clear();
         UI2.Clear();
         ResourceBombs.Clear();
         CREATURES.Clear();
         PROJECTILES.Clear();
         ATTACK.Setup();
         ResourcePackages.Clear();
         GIBLETS.Clear();
         CREATURELOCKER.Setup();
         CUSTOMATTACKS.Setup();
         UPDATES.Setup();
         BuildingOverlay.Clear();
         ParticleText.Clear();
         SPRITES.Clear();
         SPRITES.Setup();
         Fire.Clear();
         ResourceBombs.Data();
         ALLIANCES.Setup();
         GLOBAL._catchup = true;
         _mushroomList = [];
         _lastSpawnedMushroom = 0;
         _size = 400;
         tmpMode = GLOBAL._loadmode;
         if(GLOBAL._advancedMap)
         {
            if(tmpMode == "wmattack")
            {
               tmpMode = "attack";
            }
            if(tmpMode == "wmview")
            {
               tmpMode = "view";
            }
         }
         if(MAPROOM_INFERNO._open)
         {
            MAPROOM_INFERNO.Hide();
         }
         if(MAPROOM._open)
         {
            MAPROOM.Hide();
         }
         loadVars = [["userid",userid > 0 ? userid : ""],["baseid",_baseID],["type",tmpMode]];
         if(MapRoom._viewOnly && (GLOBAL._mode == "view" || GLOBAL._mode == "wmview"))
         {
            loadVars.push(["worldid",MapRoom._worldID]);
         }
         midgameIncentive = 0;
         lastDigit = int(LOGIN._digits[LOGIN._digits.length - 1]);
         secondLastDigit = int(LOGIN._digits[LOGIN._digits.length - 2]);
         thirdLastDigit = int(LOGIN._digits[LOGIN._digits.length - 3]);
         diffShowMidgameIncentive1 = (thirdLastDigit + lastDigit) % 10;
         diffShowMidgameIncentive2 = (secondLastDigit + lastDigit) % 10;
         if(diffShowMidgameIncentive1 <= 7)
         {
            midgameIncentive = 0;
         }
         else if(diffShowMidgameIncentive1 == 8)
         {
            if(diffShowMidgameIncentive2 <= 4)
            {
               midgameIncentive = 1;
            }
            else
            {
               midgameIncentive = 2;
            }
         }
         else if(diffShowMidgameIncentive1 == 9)
         {
            if(diffShowMidgameIncentive2 <= 4)
            {
               midgameIncentive = 3;
            }
            else
            {
               midgameIncentive = 4;
            }
         }
         if(GLOBAL._checkPromo == 1 && midgameIncentive != 0)
         {
            loadVars.push(["checkpromotion",1]);
         }
         if(!_loadedSomething && ExternalInterface.available)
         {
            ExternalInterface.call("cc.recordStats","basestart");
         }
         if(url)
         {
            new URLLoaderApi().load(url + "load",loadVars,handleLoadSuccessful,handleLoadError);
         }
         else if(isInferno())
         {
            new URLLoaderApi().load(GLOBAL._infBaseURL + "load",loadVars,handleLoadSuccessful,handleLoadError);
         }
         else
         {
            new URLLoaderApi().load(GLOBAL._baseURL + "load",loadVars,handleLoadSuccessful,handleLoadError);
         }
      }
      
      public static function Build() : *
      {
         var buildingobject:Object = null;
         var lm:int = 0;
         var tmpDO:DisplayObject = null;
         var t:int = 0;
         var texture:String = null;
         var m:* = undefined;
         var count:int = 0;
         var b:BFOUNDATION = null;
         var tmpType:int = 0;
         var hasTownHall:Boolean = false;
         var o:Object = null;
         var length1:int = 0;
         var length2:int = 0;
         var ijx:int = 0;
         var thl:int = 0;
         var tmpcount:int = 0;
         var hp:int = 0;
         var hpMax:int = 0;
         var i:* = undefined;
         var building:BFOUNDATION = null;
         PLEASEWAIT.Update(KEYS.Get("msg_building"));
         if(MAPROOM_INFERNO._open)
         {
            MAPROOM_INFERNO.Hide();
         }
         if(MAPROOM._open)
         {
            MAPROOM.Hide();
         }
         try
         {
            lm = 0;
            while(lm < GLOBAL._layerMap.numChildren)
            {
               tmpDO = GLOBAL._layerMap.getChildAt(lm);
               if(tmpDO.parent)
               {
                  tmpDO.parent.removeChild(tmpDO);
               }
               lm++;
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build A1: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            UI2.Setup();
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build A2: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            GLOBAL.ResizeGame(null);
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build A3: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            GLOBAL._render = false;
            PATHING.Setup();
            t = getTimer();
            texture = "grass";
            if(GLOBAL._currentCell && (_yardType % 2 == OUTPOST || GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview"))
            {
               texture = GLOBAL._currentCell._terrain;
            }
            if(BASE.isInferno())
            {
               texture = "lava";
            }
            m = new MAP(texture);
            QUEUE.Spawn(0);
            Smoke.Setup();
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build B: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         buildingobject = {};
         try
         {
            count = 0;
            tmpType = 0;
            hasTownHall = false;
            for each(o in _buildingData)
            {
               if(o)
               {
                  if(!(o.t == 53 || o.t == 54))
                  {
                     buildingobject = o;
                     if(o.t == 18)
                     {
                        o.t = 17;
                        o.l = 2;
                     }
                     b = addBuildingC(o.t);
                     if(b)
                     {
                        tmpType = b._type;
                     }
                     if(o.t == 16 && _rawMonsters && Boolean(_rawMonsters.hcc))
                     {
                        o.mq = _rawMonsters.hcc;
                     }
                     if(o.t == 13 && _rawMonsters && Boolean(_rawMonsters.h) && Boolean(_rawMonsters.hid))
                     {
                        length1 = int(_rawMonsters.hid.length);
                        length2 = int(_rawMonsters.h.length);
                        ijx = 0;
                        while(ijx < length1 && ijx < length2)
                        {
                           if(_rawMonsters.hid[ijx] == o.id)
                           {
                              if(_rawMonsters.h[ijx].length > 0)
                              {
                                 o.rIP = _rawMonsters.h[ijx][0];
                                 o.rCP = _rawMonsters.h[ijx][1];
                              }
                              else
                              {
                                 o.rIP = "";
                                 o.rCP = 0;
                              }
                              if(Boolean(_rawMonsters.hstage) && _rawMonsters.hstage.length > ijx)
                              {
                                 o.rPS = _rawMonsters.hstage[ijx];
                              }
                              if(o.id == _rawMonsters.hid[ijx] && _rawMonsters.h[ijx].length > 2)
                              {
                                 o.mq = _rawMonsters.h[ijx][2];
                              }
                              else
                              {
                                 o.mq = [];
                              }
                              o.saved = _rawMonsters.saved;
                              break;
                           }
                           ijx++;
                        }
                     }
                     if(b)
                     {
                        b.Setup(o);
                        if(b._id > _buildingCount)
                        {
                           _buildingCount = b._id;
                        }
                        if(tmpType == 14)
                        {
                           hasTownHall = true;
                        }
                        count++;
                     }
                  }
               }
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build C: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
            LOGGER.Log("err","BASE.Build building/monster processing.  ID: " + _loadedBaseID + " Outpost: " + _yardType + " BObj " + JSON.encode(buildingobject));
         }
         try
         {
            if(count == 0)
            {
               if(_yardType % 2 == OUTPOST && !BASE.isInferno())
               {
                  b = addBuildingC(112);
                  b.Setup({
                     "X":0,
                     "Y":-50,
                     "id":count++,
                     "t":112,
                     "l":1
                  });
               }
               else if(BASE.isInferno())
               {
                  b = addBuildingC(14);
                  b.Setup({
                     "X":-100,
                     "Y":0,
                     "id":count++,
                     "t":14,
                     "l":1
                  });
                  b = addBuildingC(1);
                  b.Setup({
                     "X":60,
                     "Y":0,
                     "id":count++,
                     "t":1,
                     "l":1
                  });
                  b = addBuildingC(2);
                  b.Setup({
                     "X":60,
                     "Y":70,
                     "id":count++,
                     "t":2,
                     "l":1
                  });
                  b = addBuildingC(6);
                  b.Setup({
                     "X":130,
                     "Y":0,
                     "id":count++,
                     "t":6,
                     "l":3
                  });
                  b = addBuildingC(6);
                  b.Setup({
                     "X":130,
                     "Y":80,
                     "id":count++,
                     "t":6,
                     "l":3
                  });
                  _basePoints = 0;
               }
               else
               {
                  b = addBuildingC(14);
                  b.Setup({
                     "X":-70,
                     "Y":0,
                     "id":count++,
                     "t":14,
                     "l":1
                  });
                  b = addBuildingC(1);
                  b.Setup({
                     "X":60,
                     "Y":0,
                     "id":count++,
                     "t":1,
                     "l":1
                  });
                  b._stored.Set(200);
                  b._hpStored = 200;
                  b = addBuildingC(2);
                  b.Setup({
                     "X":60,
                     "Y":70,
                     "id":count++,
                     "t":2,
                     "l":1
                  });
                  b = addBuildingC(12);
                  b.Setup({
                     "X":60,
                     "Y":-70,
                     "id":count++,
                     "t":12,
                     "l":1
                  });
                  _resources.r1.Set(1600);
                  _resources.r2.Set(1600);
                  _hpResources.r1 = 1600;
                  _hpResources.r2 = 1600;
                  _deltaResources.r1.Set(1600);
                  _deltaResources.r2.Set(1600);
                  _hpDeltaResources.r1 = 1600;
                  _hpDeltaResources.r2 = 1600;
                  _basePoints = 0;
                  _deltaResources.dirty = true;
                  _hpDeltaResources.dirty = true;
                  SOUNDS.TutorialStopMusic();
               }
            }
            else if(_yardType == MAIN_YARD && !hasTownHall)
            {
               LOGGER.Log("err","Town Hall Missing");
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build D: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            if(GLOBAL._mode == "build" && !GLOBAL._aiDesignMode)
            {
               thl = GLOBAL._bTownhall._lvl.Get();
               tmpcount = 0;
               for each(o in GLOBAL._buildingProps)
               {
                  tmpcount = 0;
                  for each(b in _buildingsAll)
                  {
                     if(b._type == o.id)
                     {
                        tmpcount += 1;
                     }
                     if(tmpcount > o.quantity[thl])
                     {
                        LOGGER.Log("log","Too many buildings of type " + b._type + " th " + thl + " count " + tmpcount);
                        BASE.BuildingDeselect();
                        b.Clean();
                        tmpcount--;
                     }
                  }
               }
            }
            for each(b in _buildingsAll)
            {
               if(GRID.FromISO(b.x,b.y).x > 1000)
               {
                  GRID.FindSpace(b);
               }
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build E: " + e.message + " | " + e.getStackTrace() + " | " + tmpType,GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            hp = 0;
            hpMax = 0;
            for(i in BASE._buildingsAll)
            {
               building = BASE._buildingsAll[i];
               if(building._class != "trap" && building._class != "wall")
               {
                  hp += building._hp.Get();
                  hpMax += building._hpMax.Get();
               }
            }
            if(_attackerNameArray.length > 0)
            {
               if(hp > hpMax * 0.8)
               {
                  ATTACK.WellDefended(false,GLOBAL.Array2StringB(_attackerNameArray));
               }
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build F: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         try
         {
            GRID.Clear();
            MAP.SortDepth(true);
            HOUSING.HousingSpace();
            MONSTERBAITER.Update();
            CalcResources();
            if(GLOBAL._mode == "wmview" || GLOBAL._mode == "wmattack")
            {
               _lastProcessed = _currentTime;
            }
            Process();
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build G: " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_OOPS_AND_ORANGE_BOX);
         }
         RADIO.Setup();
      }
      
      public static function Process() : *
      {
         var Post:Function;
         var hatqueue2:Array = null;
         var hatcount2:int = 0;
         var building:BFOUNDATION = null;
         var lootArray:Array = null;
         var lootString:String = null;
         var popupMC:popup_loot = null;
         var hatchery:BUILDING13 = null;
         PLEASEWAIT.Update(KEYS.Get("msg_processing"));
         _tmpPercent = 0;
         try
         {
            HOUSING.Cull();
            CalcResources();
            if(_tempLoot)
            {
               lootArray = [];
               if(Boolean(_tempLoot.r1) && _tempLoot.r1 > 0)
               {
                  BASE.PointsAdd(_tempLoot.r1);
                  lootArray.push([_tempLoot.r1,GLOBAL._resourceNames[0]]);
               }
               if(Boolean(_tempLoot.r2) && _tempLoot.r2 > 0)
               {
                  BASE.PointsAdd(_tempLoot.r2);
                  lootArray.push([_tempLoot.r2,GLOBAL._resourceNames[1]]);
               }
               if(Boolean(_tempLoot.r3) && _tempLoot.r3 > 0)
               {
                  BASE.PointsAdd(_tempLoot.r3);
                  lootArray.push([_tempLoot.r3,GLOBAL._resourceNames[2]]);
               }
               if(Boolean(_tempLoot.r4) && _tempLoot.r4 > 0)
               {
                  BASE.PointsAdd(_tempLoot.r4);
                  lootArray.push([_tempLoot.r4,GLOBAL._resourceNames[3]]);
               }
               if(GLOBAL._mode == "build" && lootArray.length > 0 && (BASE.isInferno() || !_tempLoot.isInferno))
               {
                  Post = function(param1:MouseEvent):*
                  {
                     GLOBAL.CallJS("sendFeed",["loot",KEYS.Get("pop_youlooted_streamtitle",{
                        "v1":lootString,
                        "v2":_tempLoot.name
                     }),KEYS.Get("pop_youlooted_streambody"),"loot.png"]);
                     POPUPS.Next();
                  };
                  lootString = GLOBAL.Array2String(lootArray);
                  popupMC = new popup_loot();
                  popupMC.tB.htmlText = "<b>" + KEYS.Get("pop_youlooted_title") + "</b>";
                  popupMC.tA.htmlText = KEYS.Get("pop_youlooted",{
                     "v1":_tempLoot.name,
                     "v2":lootString
                  });
                  popupMC.bAction.SetupKey("btn_brag");
                  popupMC.bAction.addEventListener(MouseEvent.CLICK,Post);
                  popupMC.bAction.Highlight = true;
                  POPUPS.Push(popupMC,null,null,null,"loot.png");
                  if(_tempLoot.r1)
                  {
                     LOGGER.Stat([17,1,int(_tempLoot.r1)]);
                     LOGGER.Stat([18,1,Math.floor(100 / _resources.r1max * int(_tempLoot.r1))]);
                  }
                  if(_tempLoot.r2)
                  {
                     LOGGER.Stat([17,2,int(_tempLoot.r2)]);
                     LOGGER.Stat([18,2,Math.floor(100 / _resources.r2max * int(_tempLoot.r2))]);
                  }
                  if(_tempLoot.r3)
                  {
                     LOGGER.Stat([17,3,int(_tempLoot.r3)]);
                     LOGGER.Stat([18,3,Math.floor(100 / _resources.r3max * int(_tempLoot.r3))]);
                  }
                  if(_tempLoot.r4)
                  {
                     LOGGER.Stat([17,4,int(_tempLoot.r4)]);
                     LOGGER.Stat([18,4,Math.floor(100 / _resources.r4max * int(_tempLoot.r4))]);
                  }
               }
            }
            _baseLevel = BaseLevel().level;
            _bankedValue = 0;
            GLOBAL.t = _lastProcessed;
            _lastProcessedB = _lastProcessed;
            _catchupTime = _currentTime - _lastProcessed;
            if(_yardType != INFERNO_YARD)
            {
               AutoBankManager.autobank(_currentTime - _lastProcessedGIP);
            }
            hatqueue2 = [];
            hatcount2 = 0;
            for each(building in _buildingsAll)
            {
               if(building._type == 13)
               {
                  hatchery = building as BUILDING13;
                  hatqueue2[hatcount2] = [hatchery._inProduction,hatchery._countdownProduce.Get()];
                  if(hatchery._monsterQueue)
                  {
                     hatqueue2[hatcount2].push(hatchery._monsterQueue);
                  }
                  hatcount2++;
               }
            }
            _timer = getTimer();
            HideFootprints();
            GLOBAL._ROOT.addEventListener(Event.ENTER_FRAME,ProcessB);
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("Base.Process " + e.message + " | " + e.getStackTrace(),GLOBAL.ERROR_ORANGE_BOX_ONLY);
         }
      }
      
      public static function ProcessB(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         while(getTimer() - _loc2_ < 10)
         {
            ProcessC(_currentTime + (getTimer() - _timer) / 1000);
         }
         if(_lastProcessed >= _currentTime)
         {
            _currentTime += (getTimer() - _timer) / 1000;
            GLOBAL._ROOT.removeEventListener(Event.ENTER_FRAME,ProcessB);
            GLOBAL.t = _currentTime;
            ProcessD();
         }
      }
      
      public static function ProcessC(param1:int) : void
      {
         var change:int = 0;
         var i:int = 0;
         var building:BFOUNDATION = null;
         var j:int = 0;
         var lowestBuilding:BFOUNDATION = null;
         var buildingMaxChange:int = 0;
         var f:int = 0;
         var tower:BFOUNDATION = null;
         var ratio:Number = NaN;
         var targetTime:int = param1;
         var p:int = 0;
         var itemCount:int = 0;
         if(_lastProcessed < targetTime)
         {
            GLOBAL.t = _lastProcessed;
            change = targetTime - _lastProcessed;
            if(CREEPS._creepCount > 0)
            {
               change = 1;
            }
            else
            {
               for each(building in _buildingsAll)
               {
                  buildingMaxChange = building.tickLimit;
                  if(buildingMaxChange < change)
                  {
                     change = buildingMaxChange;
                  }
                  if(buildingMaxChange <= 1)
                  {
                  }
               }
               if(CREATURES._guardian)
               {
                  change = Math.min(change,CREATURES._guardian.tickLimit);
               }
               if(change < 1)
               {
                  change = 1;
               }
               if(change > 50 * 60)
               {
                  change = 50 * 60;
               }
            }
            WMATTACK.Tick();
            if(WMATTACK._inProgress)
            {
               change = 1;
            }
            i = int(_lastProcessed / 60) - int((_lastProcessed + change) / 60);
            while(i >= 0)
            {
               STORE.ProcessPurchases();
               i--;
            }
            itemCount = 0;
            for each(building in _buildingsAll)
            {
               building.Tick(change);
               itemCount++;
            }
            j = 0;
            while(j < CREATURES._guardianList.length)
            {
               if(Boolean(CREATURES._guardianList[j]) && CREATURES._guardianList[j].Tick(change))
               {
                  MAP._BUILDINGTOPS.removeChild(CREATURES._guardianList[j]);
                  if(CREATURES._guardianList[j] == CREATURES._guardian)
                  {
                     CREATURES._guardian = null;
                  }
                  else
                  {
                     CREATURES._guardianList.splice(j,1);
                  }
               }
               j++;
            }
            if(_yardType == MAIN_YARD)
            {
               CREATURELOCKER.Tick();
               ACADEMY.Tick();
            }
            if(CREEPS._creepCount > 0)
            {
               GLOBAL._render = true;
               PATHING.Tick();
               itemCount++;
               f = 0;
               while(f < 80)
               {
                  CREEPS.Tick();
                  CREATURES.Tick();
                  for each(tower in BASE._buildingsTowers)
                  {
                     tower.TickAttack();
                  }
                  PROJECTILES.Tick();
                  FIREBALLS.Tick();
                  f++;
               }
            }
            i = 0;
            while(i < change)
            {
               EFFECTS.Tick();
               UPDATES.Check();
               if(_yardType == MAIN_YARD)
               {
                  MONSTERBAITER.Tick();
               }
               if(GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview")
               {
                  WMBASE.Tick();
               }
               i++;
            }
            _lastProcessed += change;
         }
         try
         {
            if(CREEPS._creepCount == 0)
            {
               ratio = (_lastProcessed - _lastProcessedB) / (targetTime - _lastProcessedB);
               PLEASEWAIT.Update(KEYS.Get("msg_rendering") + int(100 * ratio) + "% ");
            }
            else
            {
               if(_tmpPercent < 100)
               {
                  _tmpPercent += 0.5;
               }
               PLEASEWAIT.Update("Crunching " + int(_tmpPercent) + "%");
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BASE.ProcessC 5: " + GLOBAL._mode + " | " + _baseID + " | " + e.getStackTrace());
         }
      }
      
      public static function ProcessD() : *
      {
         var damageCount:int;
         var j:int;
         var MoreInfo711:Function;
         var Action:Function;
         var BragA:Function;
         var BragB:Function;
         var building:BFOUNDATION = null;
         var bb:int = 0;
         var helper:int = 0;
         var popupMCDamaged:popup_damaged = null;
         var RepairAll:Function = null;
         var RepairNow:Function = null;
         var handler:IHandler = null;
         var upgradeCount:int = 0;
         var helpedCount:int = 0;
         var hasBigGulp:Boolean = false;
         var fbPromoTimer:Number = NaN;
         var fbPromoPopup:MovieClip = null;
         var promptSPost:Boolean = false;
         var b:* = undefined;
         var popupMCdamaged:MovieClip = null;
         var hp:int = 0;
         var hpMax:int = 0;
         var i:* = undefined;
         var popupMCDestroyed:PopupLostMainBase = null;
         var t:int = getTimer();
         try
         {
            if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
            {
               ATTACK.Setup();
            }
            if(GLOBAL._mode == "build")
            {
               if(CREEPS._creepCount == 0)
               {
                  for each(building in _buildingsAll)
                  {
                     building.GridCost(true);
                  }
                  for each(building in _buildingsMushrooms)
                  {
                     building.GridCost();
                  }
               }
            }
            EFFECTS.Process(_catchupTime);
            if(_yardType == MAIN_YARD)
            {
               CREATURELOCKER.Tick();
            }
            if(_tempGifts)
            {
               GIFTS.Process(_tempGifts);
            }
            if(_tempSentGifts)
            {
               GIFTS.ProcessAcceptedGifts(_tempSentGifts);
            }
            if(_tempSentInvites)
            {
               GIFTS.ProcessAcceptedInvites(_tempSentInvites);
            }
            UPDATES.Catchup();
            HOUSING.Cull();
            HOUSING.Populate();
            SOUNDS.Setup();
            GLOBAL._render = true;
            GLOBAL._catchup = false;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BASE.ProcessD A: " + e.message + " | " + e.getStackTrace());
         }
         damageCount = 0;
         for each(building in _buildingsAll)
         {
            building.Update(true);
            if(building._hp.Get() < building._hpMax.Get() && building._repairing == 0)
            {
               damageCount++;
            }
            if(building._countdownBuild.Get() + building._countdownUpgrade.Get() + building._countdownFortify.Get() > 0)
            {
               upgradeCount++;
               for each(helper in building._helpList)
               {
                  if(helper == LOGIN._playerID)
                  {
                     helpedCount++;
                  }
               }
            }
         }
         if(damageCount > 0 && GLOBAL._mode == "build" && !WMATTACK._inProgress)
         {
            RepairAll = function(param1:MouseEvent = null):*
            {
               var _loc2_:* = undefined;
               popupMCDamaged.bAction.removeEventListener(MouseEvent.CLICK,RepairAll);
               popupMCDamaged.bAction2.removeEventListener(MouseEvent.CLICK,RepairNow);
               for each(_loc2_ in _buildingsAll)
               {
                  if(_loc2_._hp.Get() < _loc2_._hpMax.Get() && _loc2_._repairing == 0)
                  {
                     _loc2_.Repair();
                  }
               }
               SOUNDS.Play("repair1",0.25);
               POPUPS.Next();
            };
            RepairNow = function(param1:MouseEvent = null):*
            {
               var _loc2_:BFOUNDATION = null;
               popupMCDamaged.bAction.removeEventListener(MouseEvent.CLICK,RepairAll);
               popupMCDamaged.bAction2.removeEventListener(MouseEvent.CLICK,RepairNow);
               for each(_loc2_ in BASE._buildingsAll)
               {
                  if(_loc2_._hp.Get() < _loc2_._hpMax.Get() && _loc2_._repairing == 0)
                  {
                     _loc2_.Repair();
                  }
               }
               STORE.ShowB(3,1,["FIX"],true);
               POPUPS.Next();
            };
            popupMCDamaged = new popup_damaged();
            (popupMCDamaged.mcFrame as frame).Setup(false);
            popupMCDamaged.title.htmlText = "<b>" + KEYS.Get("pop_damaged_title") + "</b>";
            popupMCDamaged.tA.htmlText = KEYS.Get("pop_damaged",{"v1":damageCount});
            popupMCDamaged.bAction.SetupKey("pop_damaged_repairall_btn");
            popupMCDamaged.bAction.addEventListener(MouseEvent.CLICK,RepairAll);
            popupMCDamaged.bAction2.SetupKey("pop_damaged_repairnow_btn");
            popupMCDamaged.bAction2.addEventListener(MouseEvent.CLICK,RepairNow);
            popupMCDamaged.bAction2.Highlight = true;
            POPUPS.Push(popupMCDamaged,null,null,null,"duct-tape.png");
            if(damageCount > 30)
            {
               MARKETING.Show("catapult");
            }
         }
         INFERNO_EMERGENCE_EVENT.Initialize();
         if(INFERNO_DESCENT_POPUPS.isInDescent() && MAPROOM_DESCENT._descentLvl < MAPROOM_DESCENT._descentLvlMax && MAPROOM_DESCENT._descentLvl > 0)
         {
            INFERNO_DESCENT_POPUPS.ShowTauntDialog(MAPROOM_DESCENT._descentLvl);
         }
         MonsterMadness.initialize();
         FrontPageHandler.initialize();
         j = 0;
         while(j < HANDLERS.length)
         {
            handler = HANDLERS[j];
            handler.initialize(loadObject[handler.name]);
            if(j == 0)
            {
               ReplayableEventHandler.initialize(loadObject["events"]);
            }
            j++;
         }
         FrontPageHandler.setup(loadObject["frontpage"]);
         FrontPageHandler.showPopup();
         if(GLOBAL.DOES_USE_SCROLL)
         {
            MouseWheelEnabler.init(MAP.stage);
         }
         bb = 0;
         try
         {
            upgradeCount = 0;
            helpedCount = 0;
            if(!GLOBAL._flags.viximo && !GLOBAL._flags.kongregate)
            {
            }
            if(is711Valid())
            {
               if(GLOBAL._mode == "build" && _yardType == MAIN_YARD && TUTORIAL._stage > 200 && GLOBAL._sessionCount >= 5)
               {
                  if(!GLOBAL._flags.viximo && !GLOBAL._flags.kongregate && !GLOBAL._displayedPromoNew && !_showingWhatsNew)
                  {
                     hasBigGulp = Boolean(_buildingsStored["b120"]);
                     if(!hasBigGulp)
                     {
                        for each(building in _buildingsAll)
                        {
                           if(building._type == 2 * 60)
                           {
                              hasBigGulp = true;
                              break;
                           }
                        }
                     }
                     if(!hasBigGulp)
                     {
                        fbPromoTimer = GLOBAL.Timestamp() + GLOBAL.StatGet("fbpromotimer");
                        if(GLOBAL.StatGet("fbpromotimer") == 0 || GLOBAL.StatGet("fbpromotimer") > 0 && GLOBAL.Timestamp() > GLOBAL.StatGet("fbpromotimer") + GLOBAL._fbPromoTimer)
                        {
                           if(GLOBAL._countryCode == "us")
                           {
                              MoreInfo711 = function(param1:MouseEvent):void
                              {
                                 GLOBAL.gotoURL("http://on.fb.me/mTMRnd",null,true,null);
                                 POPUPS.Next();
                              };
                              fbPromoPopup = new FBPROMO_711_CLIP();
                              fbPromoPopup.bAction3.buttonMode = true;
                              fbPromoPopup.bAction3.useHandCursor = true;
                              fbPromoPopup.bAction3.mouseChildren = false;
                              fbPromoPopup.bAction3.txt.htmlText = KEYS.Get("btn_goldenbiggulp");
                              fbPromoPopup.bAction3.bg.visible = false;
                              fbPromoPopup.bAction3.addEventListener(MouseEvent.CLICK,MoreInfo711);
                              fbPromoPopup.bAction4.buttonMode = true;
                              fbPromoPopup.bAction4.useHandCursor = true;
                              fbPromoPopup.bAction4.mouseChildren = false;
                              fbPromoPopup.bAction4.txt.htmlText = KEYS.Get("btn_hatcheryoverdrives");
                              fbPromoPopup.bAction4.addEventListener(MouseEvent.CLICK,MoreInfo711);
                              fbPromoPopup.bAction4.bg.visible = false;
                              fbPromoPopup.bInfo.useHandCursor = true;
                              fbPromoPopup.bInfo.buttonMode = true;
                              fbPromoPopup.bInfo.mouseChildren = false;
                              fbPromoPopup.bInfo.addEventListener(MouseEvent.CLICK,MoreInfo711);
                              POPUPS.Push(fbPromoPopup,BUY.logFB711PromoShown,null,null,null,false);
                              GLOBAL.StatSet("fbpromotimer",GLOBAL.Timestamp());
                              GLOBAL._displayedPromoNew = true;
                           }
                        }
                     }
                  }
               }
            }
            if(GLOBAL._flags && GLOBAL._flags.fbcncpshow == 2 && GLOBAL._fbcncp > 0)
            {
               BUY.FBCNcpCheckEligibility();
            }
            if(GLOBAL._mode == "help")
            {
               if(upgradeCount > 0)
               {
                  if(upgradeCount - helpedCount == 1)
                  {
                     GLOBAL.Message(KEYS.Get("base_pleasehelp"));
                  }
                  if(upgradeCount - helpedCount > 1)
                  {
                     GLOBAL.Message(KEYS.Get("base_pleasehelpx",{"v1":upgradeCount - helpedCount}));
                  }
               }
               else
               {
                  GLOBAL.Message(KEYS.Get("base_nohelpneeded"));
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BASE.ProcessD B: " + e.message + " | " + e.getStackTrace() + " | " + bb);
            GLOBAL.ErrorMessage("BASE.ProcessD");
         }
         try
         {
            UI2.Update();
            PLEASEWAIT.Hide();
            CalcResources();
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BASE.ProcessD C: " + e.message + " | " + e.getStackTrace());
         }
         try
         {
            UI2._scrollMap = true;
            if(GLOBAL._mode == "build")
            {
               if(!WMATTACK._inProgress)
               {
                  UI2.Show("top");
                  UI2.Show("bottom");
               }
            }
            else if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
            {
               UI2.Show("top");
            }
            else if(!WMATTACK._inProgress)
            {
               UI2.Show("top");
            }
            _baseLevel = BaseLevel().level;
            _loadTime = GLOBAL.Timestamp();
            _lastSaved = GLOBAL.Timestamp();
            Save();
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BASE.ProcessD E: " + e.message + " | " + e.getStackTrace());
         }
         try
         {
            for each(building in _buildingsAll)
            {
               if(!building._repairing && building._hp.Get() > 0 && building._hp.Get() <= building._hpMax.Get() * 0.5)
               {
                  Smoke.CreateStream(new Point(building.x,building.y + building._middle));
               }
            }
         }
         catch(e:Error)
         {
         }
         QUESTS.TutorialCheck();
         QUESTS.Check();
         PATHING.ResetCosts();
         TUTORIAL.Process();
         MUSHROOMS.Setup();
         NewPopupSystem.instance.CheckAll(true);
         try
         {
            if(GLOBAL._mode == "help")
            {
               promptSPost = false;
               for each(b in _buildingsMain)
               {
                  if(b._hp.Get() < b._hpMax.Get() && b._repairing == 0)
                  {
                     promptSPost = true;
                  }
               }
               if(GLOBAL.Timestamp() - 86400 < BASE._damagedBaseWarnTime)
               {
                  promptSPost = false;
               }
               if(promptSPost)
               {
                  Action = function(param1:MouseEvent = null):void
                  {
                     GLOBAL.CallJS("sendFeed",["warn-damaged",KEYS.Get("base_damaged_streamtitle"),KEYS.Get("base_damaged_streambody",{"v1":BASE._ownerName}),"monstersatwork.png",_loadedFBID]);
                     UPDATES.Create(["DBU"]);
                     POPUPS.Next();
                  };
                  popupMCdamaged = new popup_damagedbase_onvisit();
                  popupMCdamaged.title_txt.htmlText = "<b>" + KEYS.Get("base_damaged_title") + "</b>";
                  popupMCdamaged.body_txt.htmlText = KEYS.Get("base_damaged_body",{"v1":BASE._ownerName});
                  popupMCdamaged.bAction.SetupKey("base_damaged_alert_btn");
                  popupMCdamaged.bAction.Highlight = true;
                  popupMCdamaged.bAction.addEventListener(MouseEvent.CLICK,Action);
                  POPUPS.Push(popupMCdamaged);
               }
            }
         }
         catch(e:Error)
         {
         }
         try
         {
            RebuildTH();
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BASE.RebuildTH " + e.getStackTrace);
         }
         LOGGER.Stat([29,GLOBAL._mode]);
         LOGGER.Stat([88,GLOBAL._loadmode,BASE._yardType]);
         _loading = false;
         if(_takeoverFirstOpen)
         {
            WMATTACK._history.lastAttack = GLOBAL.Timestamp() + 43200;
            WMATTACK._history.sessionsSinceLastAttack = 0;
            if(WMATTACK._history.nextAttack)
            {
               delete WMATTACK._history.nextAttack;
            }
            if(WMATTACK._history.queued)
            {
               delete WMATTACK._history.queued;
            }
            if(_takeoverFirstOpen == 1)
            {
               BragA = function():*
               {
                  GLOBAL.CallJS("sendFeed",["upgrade-mr",KEYS.Get("conqueredbase",{"v1":_takeoverPreviousOwnersName}),KEYS.Get("newmap_destroyed3"),"build-outpost.png"]);
                  POPUPS.Next();
               };
               ACHIEVEMENTS.Check("wmoutpost",1);
               POPUPS.DisplayGeneric(KEYS.Get("venividivici"),KEYS.Get("destroyedbase_takeover",{"v1":_takeoverPreviousOwnersName}),KEYS.Get("btn_brag"),"building-outpost.png",BragA);
            }
            else if(_takeoverFirstOpen == 2)
            {
               BragB = function():*
               {
                  GLOBAL.CallJS("sendFeed",["upgrade-mr",KEYS.Get("conqueredoutpost",{"v1":_takeoverPreviousOwnersName}),KEYS.Get("venividivici"),"build-outpost.png"]);
                  POPUPS.Next();
               };
               ++ACHIEVEMENTS._stats.playeroutpost;
               ACHIEVEMENTS.Check();
               POPUPS.DisplayGeneric(KEYS.Get("venividivici"),KEYS.Get("destroyedoutpost_takeover",{"v1":_takeoverPreviousOwnersName}),KEYS.Get("btn_brag"),"building-outpost.png",BragB);
            }
         }
         _takeoverFirstOpen = 0;
         if(GLOBAL._mode == "build")
         {
            if(_yardType % 2 == OUTPOST)
            {
               if(_buildingCount == 1)
               {
                  POPUPS.Push(new popup_prefab_help());
               }
            }
            else
            {
               MARKETING.Process();
               if(GLOBAL._flags.trialpayDealspot == 1 && (TUTORIAL._stage > 200 && GLOBAL._sessionCount > 10))
               {
                  UI2._top.InitDealspot();
               }
               hp = 0;
               hpMax = 0;
               for(i in BASE._buildingsAll)
               {
                  building = BASE._buildingsAll[i];
                  if(building._class != "trap" && building._class != "wall")
                  {
                     hp += building._hp.Get();
                     hpMax += building._hpMax.Get();
                  }
               }
               if(!ALLIANCES._myAlliance)
               {
                  if(GLOBAL._mode == "build" && !GLOBAL._empireDestroyedShown && GLOBAL._advancedMap && _yardType == MAIN_YARD && !WMATTACK._inProgress && (GLOBAL._mapOutpost.length == 0 || GLOBAL._empireDestroyed == 1) && hp < hpMax * 0.1)
                  {
                     GLOBAL._empireDestroyedShown = true;
                     popupMCDestroyed = new PopupLostMainBase();
                     popupMCDestroyed.Setup();
                     POPUPS.Push(popupMCDestroyed,null,null,null,"base-destroyed.png");
                  }
               }
            }
         }
         try
         {
            GLOBAL.CallJS("cc.injectFriendsSwf",null,false);
         }
         catch(e:Error)
         {
         }
         try
         {
            BTOTEM.FindMissingTotem();
         }
         catch(e:Error)
         {
         }
      }
      
      public static function ShowSiegeWeaponWhatsNew(param1:MovieClip, param2:String) : void
      {
         var ShowLab:Function;
         var popup:MovieClip = param1;
         var weaponID:String = param2;
         popup.tTitle.htmlText = "<b>" + KEYS.Get("whatsnew_title") + "</b>";
         if(isInferno() || !INFERNOPORTAL.isAboveMaxLevel() || !MAPROOM_DESCENT.DescentPassed)
         {
            popup.bAction.visible = false;
         }
         else if(GLOBAL._bSiegeLab)
         {
            ShowLab = function(param1:MouseEvent):void
            {
               BUILDINGS._buildingID = SiegeLab.ID;
               SiegeBuilding.Show("lab",weaponID);
               POPUPS.Next();
            };
            popup.bAction.SetupKey("btn_unlocknow");
            popup.bAction.addEventListener(MouseEvent.CLICK,ShowLab);
         }
         else
         {
            popup.bAction.SetupKey("btn_buildnow");
            popup.bAction.addEventListener(MouseEvent.CLICK,ShowBuildLab);
         }
      }
      
      private static function ShowBuildLab(param1:MouseEvent) : void
      {
         BUILDINGS._buildingID = SiegeLab.ID;
         BUILDINGS.Show();
         POPUPS.Next();
      }
      
      public static function Tick() : void
      {
         var savedelay:int = 0;
         var pageInterval:int = 0;
         try
         {
            savedelay = 2;
            if(GLOBAL._flags.savedelay)
            {
               savedelay = int(GLOBAL._flags.savedelay);
            }
            if(_saveCounterA != _saveCounterB)
            {
               if(GLOBAL._mode == "attack")
               {
                  if(GLOBAL.Timestamp() - _lastSaveRequest > savedelay * 2 || GLOBAL.Timestamp() - _lastSaved > 15)
                  {
                     SaveB();
                  }
               }
               else if(GLOBAL._mode == "wmattack")
               {
                  if(GLOBAL.Timestamp() - _lastSaveRequest > savedelay * 2 || GLOBAL.Timestamp() - _lastSaved > 20)
                  {
                     SaveB();
                  }
               }
               else if(GLOBAL.Timestamp() - _lastSaveRequest >= savedelay || _pendingPurchase.length > 0 || _loadBase.length > 0)
               {
                  SaveB();
               }
               if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
               {
                  UI2._top.mcSave.gotoAndStop(4);
               }
               else
               {
                  UI2._top.mcSave.gotoAndStop(2);
               }
            }
            else if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
            {
               UI2._top.mcSave.gotoAndStop(3);
            }
            else
            {
               UI2._top.mcSave.gotoAndStop(1);
            }
            if(GLOBAL.Timestamp() % 10 == 0)
            {
               CHECKER.Check();
               if(_yardType != INFERNO_YARD)
               {
                  AutoBankManager.autobank();
               }
            }
            pageInterval = int(Math.random() * 10) + 25;
            if(GLOBAL._flags.pageinterval)
            {
               pageInterval = int(GLOBAL._flags.pageinterval);
            }
            if(_lastPaged >= pageInterval && !_paging && !_saving && GLOBAL.Timestamp() - _lastSaved >= pageInterval)
            {
               if(SPECIALEVENT.active)
               {
                  _blockSave = false;
                  Save(0,false,true);
                  _lastSaved = GLOBAL.Timestamp();
               }
               else
               {
                  Page();
               }
            }
            ++_lastPaged;
            if(GLOBAL._extraHousing < GLOBAL.Timestamp() && HOUSING._housingUsed.Get() > HOUSING._housingCapacity.Get())
            {
               HOUSING.Cull(false);
               GLOBAL._extraHousing = 0;
               GLOBAL._extraHousingPower.Set(0);
               BASE.Save();
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","Base.Tick: " + e.message + " | " + e.getStackTrace());
         }
         ShakeB();
      }
      
      public static function Purchase(param1:String, param2:int, param3:String, param4:Boolean = false) : *
      {
         if(_pendingPurchase.length > 0)
         {
            GLOBAL.ErrorMessage(KEYS.Get("msg_err_purchase"),GLOBAL.ERROR_ORANGE_BOX_ONLY);
            return false;
         }
         if(param2 <= 0)
         {
            GLOBAL.ErrorMessage("BASE.Purchase zero quantity");
            LOGGER.Log("err","BASE.Purchase Id " + param1 + ", illegal quantity " + param2 + ", possible hack");
            return false;
         }
         _pendingPurchase = [param1,param2,_saveCounterA + 1,param3,param4];
         if(param3 != "store")
         {
            LOGGER.Stat([61,param1,param2]);
         }
         BASE.Save();
      }
      
      public static function Save(param1:int = 0, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(Boolean(UI2._top) && Boolean(UI2._top.mcSave))
         {
            UI2._top.mcSave.gotoAndStop(2);
            if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
            {
               UI2._top.mcSave.gotoAndStop(4);
            }
            else
            {
               UI2._top.mcSave.gotoAndStop(2);
            }
         }
         if(param1 > 0)
         {
            _saveOver = param1;
         }
         if(param2)
         {
            _returnHome = true;
         }
         _lastSaveRequest = GLOBAL.Timestamp();
         ++_saveCounterA;
         if(param3 || _pendingPurchase.length > 0)
         {
            SaveB();
         }
         if(isInferno() || param4 || GLOBAL._loadmode != GLOBAL._mode)
         {
            _infernoSaveLoad = true;
         }
      }
      
      public static function SaveB() : *
      {
         var o:*;
         var hp:int;
         var hpMax:int;
         var finishTime:int;
         var stats:Object;
         var r:Object;
         var tmpR:String;
         var creatures:Object;
         var hatcount:int;
         var hatqueue:Array;
         var hatstage:Array;
         var hatid:Array;
         var catapult:int;
         var flinger:int;
         var loadObjects:Object;
         var saveObject:Object;
         var j:int;
         var ir:Object;
         var saveOrder:Array;
         var length:int;
         var k:int;
         var loadVars:Array;
         var hard:uint;
         var so:uint;
         var tmpExport:Object = null;
         var i:String = null;
         var buildingString:String = null;
         var building:BFOUNDATION = null;
         var s:String = null;
         var mm:Object = null;
         var storageString:String = null;
         var attackResults:Array = null;
         var attackString:String = null;
         var tmpM:String = null;
         var tmpQ:String = null;
         var _bn:String = null;
         var siegeData:Object = null;
         var atackerSiegeData:Object = null;
         var tmpIR:String = null;
         var handleLoadSuccessful:Function = null;
         var handleLoadError:Function = null;
         var hatchery:BUILDING13 = null;
         var handler:IHandler = null;
         var saveData:Object = null;
         var localGIP:Object = null;
         var thisOp:Object = null;
         var harvester:BFOUNDATION = null;
         var level:int = 0;
         var value:int = 0;
         var guardObj:Array = null;
         var attackresources:Object = null;
         var lootreport:Object = null;
         var guardAttObj:Array = null;
         var i2:int = 0;
         var monsterUpdate:Array = null;
         var loot:Object = null;
         var cellContainer:CellData = null;
         var cell:MapRoomCell = null;
         var range:Number = NaN;
         var creatureID:String = null;
         var cellObject:Object = null;
         var homeCellObject:* = undefined;
         var purchaseArray:Array = null;
         handleLoadSuccessful = function(param1:Object):*
         {
            var _loc2_:int = 0;
            if(param1.error == 0)
            {
               GLOBAL.CleanAttackersDeltaResources();
               CleanDeltaResources();
               if(GLOBAL._mode != "build" && GLOBAL._mode != "ibuild")
               {
                  ATTACK.CleanLoot();
               }
               if(_returnHome && param1.over == 1)
               {
                  if(isInferno())
                  {
                     LoadBase(null,0,0,"ibuild",false,BASE.INFERNO_YARD);
                  }
                  else
                  {
                     LoadBase(null,0,0,"build",false,BASE.MAIN_YARD);
                  }
                  return;
               }
               _saveErrors = 0;
               _lastSaved = GLOBAL.Timestamp();
               _lastSaveID = param1.basesaveid;
               _credits.Set(int(param1.credits));
               _hpCredits = int(param1.credits);
               GLOBAL._credits.Set(int(param1.credits));
               if(param1.resources)
               {
                  if(_saveCounterA == _saveCounterB)
                  {
                     _loc2_ = 1;
                     while(_loc2_ < 5)
                     {
                        if(param1.resources["r" + _loc2_])
                        {
                           _resources["r" + _loc2_].Set(param1.resources["r" + _loc2_]);
                           _hpResources["r" + _loc2_] = _resources["r" + _loc2_].Get();
                           if(GLOBAL._mode == "build" || GLOBAL._mode == "ibuild")
                           {
                              GLOBAL._resources["r" + _loc2_].Set(param1.resources["r" + _loc2_]);
                              GLOBAL._hpResources["r" + _loc2_] = GLOBAL._resources["r" + _loc2_].Get();
                           }
                        }
                        _loc2_++;
                     }
                  }
                  if(GLOBAL._mode != "build" && GLOBAL._mode != "ibuild")
                  {
                     ATTACK.CleanLoot();
                     GLOBAL.CleanAttackersDeltaResources();
                  }
                  CleanDeltaResources();
               }
               _isProtected = int(param1["protected"]);
               _isFan = int(param1.fan);
               _isBookmarked = int(param1.bookmarked);
               _installsGenerated = int(param1.installsgenerated);
               if(param1.fan)
               {
                  QUESTS._global.bonus_fan = 1;
               }
               if(param1.bookmarked)
               {
                  QUESTS._global.bonus_bookmark = 1;
               }
               if(Boolean(param1.updates) && param1.updates.length > 0)
               {
                  UPDATES.Process(param1.updates);
               }
               if(_loadBase.length > 0)
               {
                  LoadBaseB();
               }
            }
            else
            {
               LOGGER.Log("err","Base.Save: " + JSON.encode(param1));
               GLOBAL.ErrorMessage("BASE.SaveB 2: " + param1.error);
            }
            _saving = false;
         };
         handleLoadError = function(param1:IOErrorEvent):void
         {
            ++_saveErrors;
            --_saveCounterB;
            _saving = false;
            if(_saveErrors >= 5)
            {
               LOGGER.Log("err","Base.Save HTTP");
               GLOBAL.ErrorMessage("BASE.Save HTTP");
            }
         };
         var t:int = getTimer();
         if(GLOBAL._halt)
         {
            return;
         }
         if(_blockSave || GLOBAL._mode == "view" || GLOBAL._mode == "help" || GLOBAL._mode == "wmview" || _loading || GLOBAL._mode == "iview" || GLOBAL._mode == "ihelp" || GLOBAL._mode == "iwmview")
         {
            _saveCounterB = _saveCounterA;
            return false;
         }
         if(_saving)
         {
            return false;
         }
         if(GLOBAL._catchup)
         {
            _saveCounterB = _saveCounterA;
            return false;
         }
         _saving = true;
         _saveCounterB = _saveCounterA;
         if(_resources.r1.Get() < 0)
         {
            LOGGER.Log("err","Negative twigs reset: " + _resources.r1.Get());
            Fund(1,_resources.r1.Get() * -1,true);
         }
         if(_resources.r2.Get() < 0)
         {
            LOGGER.Log("err","Negative pebbles reset: " + _resources.r2.Get());
            Fund(2,_resources.r2.Get() * -1,true);
         }
         if(_resources.r3.Get() < 0)
         {
            LOGGER.Log("err","Negative putty reset: " + _resources.r3.Get());
            Fund(3,_resources.r3.Get() * -1,true);
         }
         if(_resources.r4.Get() < 0)
         {
            LOGGER.Log("err","Negative goo reset: " + _resources.r4.Get());
            Fund(4,_resources.r4.Get() * -1,true);
         }
         CalcBaseValue();
         t = getTimer();
         o = {};
         hp = 0;
         hpMax = 0;
         finishTime = 0;
         if(WORKERS._workers && WORKERS._workers.length > 0 && Boolean(WORKERS._workers[0].task))
         {
            finishTime = GLOBAL.Timestamp() + WORKERS._workers[0].task._countdownBuild.Get() + WORKERS._workers[0].task._countdownUpgrade.Get() + WORKERS._workers[0].task._countdownFortify.Get();
         }
         for(i in _buildingsAll)
         {
            building = _buildingsAll[i];
            if(building._class == "trap" && building._fired || building._type == 53 && building._expireTime < GLOBAL.Timestamp())
            {
               Console.warning("Ignored Building" + building + building._type + building._expireTime);
            }
            else
            {
               if(building._class != "wall")
               {
                  if(GLOBAL._mode == "build" || GLOBAL._mode == "ibuild")
                  {
                     hp += building._hpMax.Get();
                  }
                  else
                  {
                     hp += building._hp.Get();
                  }
                  hpMax += building._hpMax.Get();
               }
               tmpExport = building.Export();
               if(tmpExport)
               {
                  o[building._id] = tmpExport;
               }
            }
         }
         _percentDamaged = 100 - 100 / hpMax * hp;
         buildingString = JSON.encode(o);
         if(GLOBAL.getDerps(o) <= 0)
         {
            LOGGER.Log("err","Empty Base object.");
            GLOBAL.ErrorMessage("BASE.SaveB(Empty Base Object)");
         }
         stats = {};
         stats.mp = int(QUESTS._global.mushroomspicked);
         stats.mg = int(QUESTS._global.goldmushroomspicked);
         stats.mob = int(QUESTS._global.monstersblended);
         stats.mobg = int(QUESTS._global.monstersblendedgoo);
         stats.moga = int(QUESTS._global.gift_accept);
         stats.updateid = GLOBAL._whatsnewid;
         stats.updateid_mr2 = GLOBAL._mr2TutorialId;
         stats.other = GLOBAL._otherStats;
         stats.achievements = ACHIEVEMENTS.Export();
         stats.popupdata = NewPopupSystem.instance.Export();
         if(BASE.isInferno() && GLOBAL._otherStats.descentLvl >= MAPROOM_DESCENT._descentLvlMax)
         {
            stats.inferno = 1;
         }
         else
         {
            stats.inferno = 0;
         }
         CalcResources();
         SaveDeltaResources();
         r = {
            "r1":_savedDeltaResources.r1.Get(),
            "r2":_savedDeltaResources.r2.Get(),
            "r3":_savedDeltaResources.r3.Get(),
            "r4":_savedDeltaResources.r4.Get(),
            "r1max":_resources.r1max,
            "r2max":_resources.r2max,
            "r3max":_resources.r3max,
            "r4max":_resources.r4max
         };
         tmpR = JSON.encode(r);
         creatures = {};
         hatcount = 0;
         hatqueue = [];
         hatstage = [];
         hatid = [];
         catapult = 0;
         flinger = 0;
         for each(building in _buildingsAll)
         {
            if(building._type == 13)
            {
               hatchery = building as BUILDING13;
               hatqueue[hatcount] = [hatchery._inProduction,hatchery._countdownProduce.Get()];
               hatstage[hatcount] = hatchery._productionStage.Get();
               hatid[hatcount] = hatchery._id;
               if(hatchery._monsterQueue)
               {
                  hatqueue[hatcount].push(hatchery._monsterQueue);
               }
               hatcount++;
            }
            if(building._type == 51)
            {
               catapult = building._lvl.Get();
            }
            if(building._type == 5)
            {
               flinger = (building as BUILDING5)._lvl.Get();
            }
         }
         for(s in HOUSING._creatures)
         {
            creatures[s] = HOUSING._creatures[s].Get();
         }
         if(!creatures.C1)
         {
            creatures.C1 = 0;
         }
         if(GLOBAL._bHatcheryCC)
         {
            mm = {
               "saved":GLOBAL.Timestamp(),
               "housed":creatures,
               "space":HOUSING._housingCapacity.Get(),
               "hcount":hatcount,
               "hcc":GLOBAL._bHatcheryCC._monsterQueue,
               "h":hatqueue,
               "hid":hatid,
               "hstage":hatstage,
               "overdrivepower":GLOBAL._hatcheryOverdrivePower.Get(),
               "overdrivetime":GLOBAL._hatcheryOverdrive,
               "finishtime":finishTime
            };
         }
         else
         {
            mm = {
               "saved":GLOBAL.Timestamp(),
               "housed":creatures,
               "space":HOUSING._housingCapacity.Get(),
               "hcount":hatcount,
               "hcc":[],
               "h":hatqueue,
               "hid":hatid,
               "hstage":hatstage,
               "overdrivepower":GLOBAL._hatcheryOverdrivePower.Get(),
               "overdrivetime":GLOBAL._hatcheryOverdrive,
               "finishtime":finishTime
            };
         }
         t = getTimer();
         o = {};
         for(i in _buildingsStored)
         {
            if(_buildingsStored[i].Get())
            {
               o[i] = _buildingsStored[i].Get();
            }
         }
         storageString = JSON.encode(o);
         attackResults = [];
         attackString = JSON.encode(attackResults);
         _mushroomList = [];
         for each(building in _buildingsMushrooms)
         {
            tmpExport = building.Export();
            _mushroomList.push([tmpExport.frame,tmpExport.X,tmpExport.Y]);
         }
         tmpM = JSON.encode({
            "l":_mushroomList,
            "s":int(_lastSpawnedMushroom)
         });
         tmpQ = JSON.encode(QUESTS._completed);
         _bn = GLOBAL._mode == "wmattack" ? TRIBES.TribeForBaseID(_wmID).name : _baseName;
         if(GLOBAL._mode == "build" && (_yardType == MAIN_YARD || _yardType == INFERNO_YARD))
         {
            siegeData = SiegeWeapons.exportWeapons();
         }
         else
         {
            atackerSiegeData = SiegeWeapons.exportWeapons();
            siegeData = _oldSiegeData;
         }
         loadObjects = {
            "baseid":_baseID,
            "lastupdate":(isNaN(UPDATES._lastUpdateID) ? 0 : UPDATES._lastUpdateID),
            "resources":tmpR,
            "academy":JSON.encode(ACADEMY.Export()),
            "stats":JSON.encode(stats),
            "mushrooms":tmpM,
            "basename":_bn,
            "baseseed":_baseSeed,
            "buildingdata":buildingString,
            "researchdata":storageString,
            "lockerdata":JSON.encode(CREATURELOCKER._lockerData),
            "quests":tmpQ,
            "basevalue":_baseValue,
            "points":_basePoints,
            "tutorialstage":TUTORIAL._stage,
            "basesaveid":_lastSaveID,
            "clienttime":GLOBAL.Timestamp(),
            "monsters":JSON.encode(mm),
            "attacks":attackString,
            "monsterbaiter":JSON.encode(MONSTERBAITER.Export()),
            "version":GLOBAL._version.Get(),
            "aiattacks":JSON.encode(WMATTACK.Export()),
            "effects":EFFECTS._effectsJSON,
            "catapult":catapult,
            "flinger":flinger,
            "empirevalue":CalcBaseValue(),
            "inventory":STORE.InventoryExport(),
            "achieved":JSON.encode(ACHIEVEMENTS.Report()),
            "siege":JSON.encode(siegeData),
            "attackersiege":JSON.encode(atackerSiegeData)
         };
         saveObject = FrontPageHandler.export();
         if(saveObject)
         {
            loadObjects["frontpage"] = JSON.encode(saveObject);
         }
         saveObject = ReplayableEventHandler.exportData();
         if(saveObject)
         {
            loadObjects["events"] = JSON.encode(saveObject);
         }
         j = 0;
         while(j < HANDLERS.length)
         {
            handler = HANDLERS[j];
            saveData = handler.exportData();
            if(saveData)
            {
               loadObjects[handler.name] = JSON.encode(saveData);
            }
            j++;
         }
         ir = {
            "r1":_ideltaResources.r1.Get(),
            "r2":_ideltaResources.r2.Get(),
            "r3":_ideltaResources.r3.Get(),
            "r4":_ideltaResources.r4.Get(),
            "r1max":_iresources.r1max,
            "r2max":_iresources.r2max,
            "r3max":_iresources.r3max,
            "r4max":_iresources.r4max
         };
         for(s in ir)
         {
            if(!ir[s])
            {
               delete ir[s];
            }
         }
         tmpIR = JSON.encode(ir);
         if(Boolean(ir.r1) || Boolean(ir.r2) || Boolean(ir.r3) || Boolean(ir.r4))
         {
            loadObjects.iresources = tmpIR;
         }
         if(GLOBAL._advancedMap)
         {
            loadObjects.monsters = JSON.encode(mm);
            localGIP = {};
            AutoBankManager.setLocalGIP(localGIP);
            if(BASE._yardType == BASE.OUTPOST)
            {
               thisOp = {
                  "r1":0,
                  "r2":0,
                  "r3":0,
                  "r4":0
               };
               for each(harvester in BASE._buildingsMain)
               {
                  if(harvester._type >= 1 && harvester._type <= 4)
                  {
                     if(harvester._hp.Get() > 0)
                     {
                        level = harvester._lvl.Get();
                        value = 0;
                        if(harvester._countdownUpgrade.Get() > 0)
                        {
                           level++;
                        }
                        value = int(harvester._buildingProps.produce[level - 1]);
                        value = Math.max(int(value * GLOBAL._averageAltitude.Get() / GLOBAL._currentCell._height),1);
                        thisOp["r" + harvester._type] += value;
                     }
                  }
               }
               if(_processedGIP["b" + _baseID])
               {
                  _GIP["r1"].Add(-_processedGIP["b" + _baseID]["r1"].Get());
                  _GIP["r2"].Add(-_processedGIP["b" + _baseID]["r2"].Get());
                  _GIP["r3"].Add(-_processedGIP["b" + _baseID]["r3"].Get());
                  _GIP["r4"].Add(-_processedGIP["b" + _baseID]["r4"].Get());
                  _processedGIP["b" + _baseID]["r1"].Set(thisOp["r1"]);
                  _processedGIP["b" + _baseID]["r2"].Set(thisOp["r2"]);
                  _processedGIP["b" + _baseID]["r3"].Set(thisOp["r3"]);
                  _processedGIP["b" + _baseID]["r4"].Set(thisOp["r4"]);
                  _rawGIP["b" + _baseID]["r1"] = thisOp["r1"];
                  _rawGIP["b" + _baseID]["r2"] = thisOp["r2"];
                  _rawGIP["b" + _baseID]["r3"] = thisOp["r3"];
                  _rawGIP["b" + _baseID]["r4"] = thisOp["r4"];
               }
               else
               {
                  _processedGIP["b" + _baseID] = {
                     "r1":new SecNum(thisOp["r1"]),
                     "r2":new SecNum(thisOp["r2"]),
                     "r3":new SecNum(thisOp["r3"]),
                     "r4":new SecNum(thisOp["r4"])
                  };
                  _rawGIP["b" + _baseID] = {
                     "r1":thisOp["r1"],
                     "r2":thisOp["r2"],
                     "r3":thisOp["r3"],
                     "r4":thisOp["r4"]
                  };
               }
               _GIP["r1"].Add(thisOp["r1"]);
               _GIP["r2"].Add(thisOp["r2"]);
               _GIP["r3"].Add(thisOp["r3"]);
               _GIP["r4"].Add(thisOp["r4"]);
               localGIP["b" + _baseID] = thisOp;
            }
            loadObjects.buildingresources = JSON.encode(localGIP);
         }
         else
         {
            loadObjects.monsters = JSON.encode(HOUSING.Export());
         }
         if(_saveOver)
         {
            loadObjects.over = _saveOver;
         }
         if(BASE._yardType != BASE.OUTPOST)
         {
            guardObj = new Array(_guardianData.length);
            j = 0;
            while(j < _guardianData.length)
            {
               if(_guardianData[j])
               {
                  guardObj[j] = new Object();
                  if(_guardianData[j].nm)
                  {
                     guardObj[j].nm = _guardianData[j].nm;
                  }
                  if(_guardianData[j].t)
                  {
                     guardObj[j].t = _guardianData[j].t;
                  }
                  if(_guardianData[j].hp)
                  {
                     guardObj[j].hp = _guardianData[j].hp.Get();
                  }
                  else
                  {
                     guardObj[j].hp = 0;
                  }
                  if(_guardianData[j].l)
                  {
                     guardObj[j].l = _guardianData[j].l.Get();
                  }
                  if(_guardianData[j].ft)
                  {
                     guardObj[j].ft = _guardianData[j].ft;
                  }
                  if(_guardianData[j].fd)
                  {
                     guardObj[j].fd = _guardianData[j].fd;
                  }
                  else
                  {
                     guardObj[j].fd = 0;
                  }
                  if(_guardianData[j].fb)
                  {
                     guardObj[j].fb = _guardianData[j].fb.Get();
                  }
                  else
                  {
                     guardObj[j].fb = 0;
                  }
                  if(_guardianData[j].pl)
                  {
                     if(_guardianData[j].pl is SecNum)
                     {
                        guardObj[j].pl = _guardianData[j].pl.Get();
                     }
                     else
                     {
                        guardObj[j].pl = _guardianData[j].pl;
                     }
                  }
                  else
                  {
                     guardObj[j].pl = 0;
                  }
               }
               j++;
            }
            if(guardObj.length)
            {
               loadObjects.champion = JSON.encode(guardObj);
            }
            else
            {
               loadObjects.champion = JSON.encode(null);
            }
         }
         t = getTimer();
         if(GLOBAL._mode != "build" && GLOBAL._mode != "ibuild")
         {
            _saveProtect = 0;
            if(BASE._yardType % 2 == MAIN_YARD)
            {
               if(hp < hpMax * 0.65)
               {
                  _saveProtect = 1;
               }
               if(hp < hpMax * 0.45)
               {
                  _saveProtect = 2;
               }
            }
            ATTACK.SaveDeltaLoot();
            GLOBAL.SaveAttackersDeltaResources();
            attackresources = {
               "r1":ATTACK._savedDeltaLoot.r1.Get() + GLOBAL._savedAttackersDeltaResources.r1.Get(),
               "r2":ATTACK._savedDeltaLoot.r2.Get() + GLOBAL._savedAttackersDeltaResources.r2.Get(),
               "r3":ATTACK._savedDeltaLoot.r3.Get() + GLOBAL._savedAttackersDeltaResources.r3.Get(),
               "r4":ATTACK._savedDeltaLoot.r4.Get() + GLOBAL._savedAttackersDeltaResources.r4.Get()
            };
            lootreport = {
               "r1":ATTACK._loot.r1.Get(),
               "r2":ATTACK._loot.r2.Get(),
               "r3":ATTACK._loot.r3.Get(),
               "r4":ATTACK._loot.r4.Get(),
               "isInferno":BASE.isInferno(),
               "name":_ownerName
            };
            t = getTimer();
            loadObjects.attackreport = ATTACK.LogRead();
            loadObjects.protect = _saveProtect;
            loadObjects.attackid = _attackID;
            loadObjects.lootreport = JSON.encode(lootreport);
            if(GLOBAL._advancedMap == 0)
            {
               loadObjects.attackcreatures = JSON.encode(AttackerCreaturesExport());
            }
            loadObjects.attackloot = JSON.encode(attackresources);
            guardAttObj = new Array(GLOBAL._playerGuardianData.length);
            i2 = 0;
            while(i2 < GLOBAL._playerGuardianData.length)
            {
               if(Boolean(GLOBAL._playerGuardianData[i2]) && GLOBAL._playerGuardianData[i2].t > 0)
               {
                  guardAttObj[i2] = new Object();
                  if(GLOBAL._playerGuardianData[i2].nm)
                  {
                     guardAttObj[i2].nm = GLOBAL._playerGuardianData[i2].nm;
                  }
                  if(GLOBAL._playerGuardianData[i2].t)
                  {
                     guardAttObj[i2].t = GLOBAL._playerGuardianData[i2].t;
                  }
                  if(GLOBAL._playerGuardianData[i2].hp)
                  {
                     guardAttObj[i2].hp = GLOBAL._playerGuardianData[i2].hp.Get();
                  }
                  if(GLOBAL._playerGuardianData[i2].l)
                  {
                     guardAttObj[i2].l = GLOBAL._playerGuardianData[i2].l.Get();
                  }
                  if(GLOBAL._playerGuardianData[i2].ft)
                  {
                     guardAttObj[i2].ft = GLOBAL._playerGuardianData[i2].ft;
                  }
                  if(GLOBAL._playerGuardianData[i2].fd)
                  {
                     guardAttObj[i2].fd = GLOBAL._playerGuardianData[i2].fd;
                  }
                  else
                  {
                     guardAttObj[i2].fd = 0;
                  }
                  if(GLOBAL._playerGuardianData[i2].fb)
                  {
                     guardAttObj[i2].fb = GLOBAL._playerGuardianData[i2].fb.Get();
                  }
                  else
                  {
                     guardAttObj[i2].fb = 0;
                  }
                  if(GLOBAL._playerGuardianData[i2].pl)
                  {
                     guardAttObj[i2].pl = GLOBAL._playerGuardianData[i2].pl.Get();
                  }
                  else
                  {
                     guardAttObj[i2].pl = 0;
                  }
               }
               i2++;
            }
            if(guardAttObj.length)
            {
               loadObjects.attackerchampion = JSON.encode(guardAttObj);
            }
            t = getTimer();
         }
         if(Boolean(GLOBAL._advancedMap) && !GLOBAL.InfernoMode(GLOBAL._loadmode))
         {
            monsterUpdate = [];
            loot = {
               "r1":ATTACK._loot.r1.Get(),
               "r2":ATTACK._loot.r2.Get(),
               "r3":ATTACK._loot.r3.Get(),
               "r4":ATTACK._loot.r4.Get()
            };
            for each(cellContainer in GLOBAL._attackerCellsInRange)
            {
               cell = cellContainer.cell;
               if(cell && cell._mine && Boolean(cell._resources))
               {
                  if(cell._flingerRange)
                  {
                     range = POWERUPS.Apply(POWERUPS.ALLIANCE_DECLAREWAR,[cell._flingerRange.Get()]);
                     if(range >= cellContainer.range)
                     {
                        for(creatureID in GLOBAL._attackerMapCreaturesStart)
                        {
                           if(Boolean(cell._monsters[creatureID]) && cell._monsters[creatureID].Get() > 0)
                           {
                              if(GLOBAL._attackerMapCreaturesStart[creatureID].Get() > GLOBAL._attackerMapCreatures[creatureID].Get())
                              {
                                 if(GLOBAL._attackerMapCreaturesStart[creatureID].Get() - GLOBAL._attackerMapCreatures[creatureID].Get() >= cell._monsters[creatureID].Get())
                                 {
                                    GLOBAL._attackerMapCreaturesStart[creatureID].Add(-cell._monsters[creatureID].Get());
                                    cell._monsterData.saved = GLOBAL.Timestamp();
                                    delete cell._monsters[creatureID];
                                    delete cell._hpMonsters[creatureID];
                                    cell._dirty = true;
                                 }
                                 else
                                 {
                                    cell._monsters[creatureID].Add(-1 * (GLOBAL._attackerMapCreaturesStart[creatureID].Get() - GLOBAL._attackerMapCreatures[creatureID].Get()));
                                    cell._hpMonsters[creatureID] -= GLOBAL._attackerMapCreaturesStart[creatureID].Get() - GLOBAL._attackerMapCreatures[creatureID].Get();
                                    cell._monsterData.saved = GLOBAL.Timestamp();
                                    GLOBAL._attackerMapCreaturesStart[creatureID].Set(GLOBAL._attackerMapCreatures[creatureID].Get());
                                    cell._dirty = true;
                                 }
                              }
                           }
                        }
                     }
                  }
                  if(cell._dirty)
                  {
                     if(cell.Check())
                     {
                        cell._monsterData["housed"] = cell._monsters;
                        cell._hpMonsterData["housed"] = cell._hpMonsters;
                        cell._monsterData.saved = GLOBAL.Timestamp();
                        cell._hpMonsterData.saved = GLOBAL.Timestamp();
                        cellObject = {
                           "baseid":cell._baseID,
                           "m":cell._hpMonsterData
                        };
                        if(cell._protected)
                        {
                           cellObject.p = 1;
                           cell._protected = 0;
                        }
                        monsterUpdate.push(cellObject);
                        cell._dirty = false;
                     }
                     else
                     {
                        LOGGER.Log("err","BASE.Save:  Dirty Cell " + cell.X + "," + cell.Y + "does not check out before doing map update!  " + JSON.encode(cell._hpResources));
                     }
                  }
               }
            }
            if(MapRoom._homeCell && MapRoom._homeCell._protected && (CREEPS._flungGuardian[0] || SiegeWeapons.didActivatWeapon))
            {
               homeCellObject = {
                  "baseid":GLOBAL._homeBaseID,
                  "m":MapRoom._homeCell._hpMonsterData,
                  "p":1
               };
               MapRoom._homeCell._protected = 0;
               monsterUpdate.push(homeCellObject);
            }
            loadObjects.monsterupdate = JSON.encode(monsterUpdate);
         }
         if(GIFTS._giftsAccepted.length > 0)
         {
            loadObjects.gifts = JSON.encode(GIFTS._giftsAccepted);
         }
         if(GIFTS._sentGiftsAccepted.length > 0)
         {
            loadObjects.sentgifts = JSON.encode(GIFTS._sentGiftsAccepted);
         }
         if(GIFTS._sentInvitesAccepted.length > 0)
         {
            loadObjects.sentinvites = JSON.encode(GIFTS._sentInvitesAccepted);
         }
         if(_pendingPurchase.length > 0)
         {
            purchaseArray = [_pendingPurchase[0],_pendingPurchase[1]];
            if(_pendingPurchase[0].substr(0,8) == "MUSHROOM")
            {
               if(_pendingPurchase[1] > 1)
               {
                  LOGGER.Log("log","HACK " + _pendingPurchase[0] + " " + _pendingPurchase[1]);
                  GLOBAL.ErrorMessage("BASE.Save Mushroom hack 1");
                  return;
               }
               ++GLOBAL._shinyShroomCount;
               if(GLOBAL._shinyShroomCount > 30)
               {
                  LOGGER.Log("log","Too many shiny shrooms in session");
                  GLOBAL.ErrorMessage("BASE.Save Mushroom hack 2");
                  return;
               }
               if(!GLOBAL._shinyShroomValid)
               {
                  LOGGER.Log("log","Shiny shroom not validated");
                  GLOBAL.ErrorMessage("BASE.Save Mushroom hack 3");
                  return;
               }
               GLOBAL._shinyShroomValid = false;
            }
            if(_pendingPurchase[4])
            {
               purchaseArray.push("inv=1");
            }
            loadObjects.purchase = JSON.encode(purchaseArray);
            _pendingPurchase = [];
         }
         loadObjects.timeplayed = int(GLOBAL._timePlayed);
         if(GLOBAL._mode == "wmattack" || GLOBAL._mode == "iwmattack")
         {
            if(GLOBAL._advancedMap == 0)
            {
               if(GLOBAL._loadmode == "iwmattack" || BASE.isInferno() && GLOBAL._mode == "wmattack")
               {
                  loadObjects.type = "iwm";
               }
               else
               {
                  loadObjects.type = "wm";
               }
               loadObjects.destroyed = WMBASE._destroyed ? 1 : 0;
            }
            else if(_percentDamaged >= 90)
            {
               loadObjects.destroyed = 1;
            }
            else
            {
               loadObjects.destroyed = 0;
            }
         }
         else if(_yardType % 2 == OUTPOST && GLOBAL._mode != "build")
         {
            if(_percentDamaged >= 90)
            {
               loadObjects.destroyed = 1;
            }
            else
            {
               loadObjects.destroyed = 0;
            }
         }
         else if(isInferno() || GLOBAL._loadmode != GLOBAL._mode)
         {
            loadObjects.type = "inferno";
         }
         loadObjects.damage = _percentDamaged;
         if(_pendingPromo)
         {
            loadObjects.purchasecomplete = 1;
            _pendingPromo = 0;
         }
         if(_pendingFBPromo)
         {
            loadObjects.fbpromos = JSON.encode(_pendingFBPromoIDs);
            _pendingFBPromo = 0;
            GLOBAL._displayedPromoNew = true;
            GLOBAL.StatSet("fbpromotimer",GLOBAL.Timestamp());
         }
         GLOBAL._timePlayed = 0;
         saveOrder = ["baseid","lastupdate","resources","academy","stats","mushrooms","basename","baseseed","buildingdata","researchdata","lockerdata","quests","basevalue","points","tutorialstage","basesaveid","clienttime","monsters","attacks","monsterbaiter","version","attackreport","over","protect","monsterupdate","attackid","aiattacks","effects","catapult","flinger","gifts","sentgifts","sentinvites","purchase","inventory","timeplayed","destroyed","damage","type","attackcreatures","attackloot","lootreport","empirevalue","champion","attackerchampion","attackersiege","purchasecomplete","achieved","fbpromos","iresources","siege","buildingresources","frontpage","events"];
         length = int(HANDLERS.length);
         k = 0;
         while(k < length)
         {
            saveOrder.push(HANDLERS[k].name);
            k++;
         }
         loadVars = [];
         hard = saveOrder.length;
         so = 0;
         while(so < hard)
         {
            if(loadObjects.hasOwnProperty(saveOrder[so]))
            {
               loadVars.push([saveOrder[so],loadObjects[saveOrder[so]]]);
            }
            so++;
         }
         if(!GLOBAL._save)
         {
            _saving = false;
            _lastSaved = GLOBAL.Timestamp();
            return;
         }
         if(isInferno() || _infernoSaveLoad && loadObjects.type == "inferno")
         {
            new URLLoaderApi().load(GLOBAL._infBaseURL + "save",loadVars,handleLoadSuccessful,handleLoadError);
         }
         else
         {
            new URLLoaderApi().load(GLOBAL._baseURL + "save",loadVars,handleLoadSuccessful,handleLoadError);
         }
      }
      
      public static function AttackerCreaturesExport() : *
      {
         var _loc2_:String = null;
         var _loc1_:Object = {};
         for(_loc2_ in GLOBAL._attackerCreatures)
         {
            _loc1_[_loc2_] = GLOBAL._attackerCreatures[_loc2_].Get();
         }
         return _loc1_;
      }
      
      public static function Page() : *
      {
         var handleLoadSuccessful:Function = null;
         var handleLoadError:Function = null;
         handleLoadSuccessful = function(param1:Object):*
         {
            var _loc2_:int = 0;
            var _loc3_:int = 0;
            var _loc4_:String = null;
            var _loc5_:Object = null;
            var _loc6_:int = 0;
            var _loc7_:Object = null;
            var _loc8_:int = 0;
            _lastPaged = int(Math.random() * 5);
            if(param1.error == 0)
            {
               _paging = false;
               GLOBAL.SetFlags(param1.flags);
               GLOBAL._unreadMessages = !!param1.unreadmessages ? int(param1.unreadmessages) : 0;
               _pageErrors = 0;
               _credits.Set(int(param1.credits));
               _hpCredits = int(param1.credits);
               GLOBAL._credits.Set(int(param1.credits));
               _isProtected = int(param1["protected"]);
               _isFan = int(param1.fan);
               _isBookmarked = int(param1.bookmarked);
               _installsGenerated = int(param1.installsgenerated);
               if((GLOBAL._mode == "build" || GLOBAL._mode == "ibuild") && param1.resources && _saveCounterA == _saveCounterB)
               {
                  if(param1.resources.r1 != _resources.r1.Get() || param1.resources.r2 != _resources.r2.Get() || param1.resources.r3 != _resources.r3.Get() || param1.resources.r4 != _resources.r4.Get())
                  {
                  }
                  _loc2_ = 1;
                  while(_loc2_ < 5)
                  {
                     if(param1.resources["r" + _loc2_])
                     {
                        _loc3_ = 0;
                        if(BASE._deltaResources && BASE._deltaResources["r" + _loc2_] && BASE._deltaResources["r" + _loc2_].Get() > 0)
                        {
                           _loc3_ = int(BASE._deltaResources["r" + _loc2_].Get());
                        }
                        _resources["r" + _loc2_].Set(param1.resources["r" + _loc2_] + _loc3_);
                        _hpResources["r" + _loc2_] = _resources["r" + _loc2_].Get();
                        GLOBAL._resources["r" + _loc2_].Set(param1.resources["r" + _loc2_] + _loc3_);
                        GLOBAL._hpResources["r" + _loc2_] = GLOBAL._resources["r" + _loc2_].Get();
                     }
                     _loc2_++;
                  }
               }
               if(param1.fan)
               {
                  QUESTS._global.bonus_fan = 1;
               }
               if(param1.bookmarked)
               {
                  QUESTS._global.bonus_bookmark = 1;
               }
               if(param1.giftsentcount)
               {
                  QUESTS._global.bonus_gifts = param1.giftsentcount;
               }
               if(Boolean(param1.updates) && param1.updates.length > 0)
               {
                  UPDATES.Process(param1.updates);
               }
               if(param1.buildingresources)
               {
                  _rawGIP = param1.buildingresources;
                  _processedGIP = {};
                  _GIP = {
                     "r1":new SecNum(0),
                     "r2":new SecNum(0),
                     "r3":new SecNum(0),
                     "r4":new SecNum(0)
                  };
                  if(_rawGIP)
                  {
                     if(_rawGIP["b" + GLOBAL._homeBaseID])
                     {
                        delete _rawGIP["b" + GLOBAL._homeBaseID];
                     }
                     if(_rawGIP["t"])
                     {
                        _lastProcessedGIP = _rawGIP["t"];
                        delete _rawGIP["t"];
                     }
                     if(GLOBAL._mode == "build" || GLOBAL._mode == "attack")
                     {
                        for(_loc4_ in _rawGIP)
                        {
                           _loc5_ = _rawGIP[_loc4_];
                           if(_loc4_ == "t")
                           {
                              _lastProcessedGIP = _rawGIP[_loc4_];
                           }
                           else
                           {
                              if(_loc5_ is String)
                              {
                                 break;
                              }
                              if(_loc5_["r1"] != undefined)
                              {
                                 _processedGIP[_loc4_] = {
                                    "r1":new SecNum(_loc5_["r1"]),
                                    "r2":new SecNum(_loc5_["r2"]),
                                    "r3":new SecNum(_loc5_["r3"]),
                                    "r4":new SecNum(_loc5_["r4"])
                                 };
                              }
                              else
                              {
                                 _loc6_ = int(_rawGIP[_loc4_]["height"]);
                                 if(_loc6_)
                                 {
                                    delete _loc5_["height"];
                                 }
                                 else
                                 {
                                    _loc6_ = 100;
                                 }
                                 _processedGIP[_loc4_] = {
                                    "r1":new SecNum(0),
                                    "r2":new SecNum(0),
                                    "r3":new SecNum(0),
                                    "r4":new SecNum(0)
                                 };
                                 for each(_loc7_ in _loc5_)
                                 {
                                    if(_loc7_.t >= 1 && _loc7_.t <= 4)
                                    {
                                       if(_loc7_.l)
                                       {
                                          _loc8_ = int(OUTPOST_YARD_PROPS._outpostProps[_loc7_.t - 1].produce[_loc7_.l - 1]);
                                       }
                                       else
                                       {
                                          _loc8_ = int(OUTPOST_YARD_PROPS._outpostProps[_loc7_.t - 1].produce[0]);
                                       }
                                       _loc8_ = Math.max(int(_loc8_ * GLOBAL._averageAltitude.Get() / _loc6_),1);
                                       _processedGIP[_loc4_]["r" + _loc7_.t].Add(_loc8_);
                                    }
                                 }
                                 _rawGIP[_loc4_] = {
                                    "r1":_processedGIP[_loc4_].r1.Get(),
                                    "r2":_processedGIP[_loc4_].r2.Get(),
                                    "r3":_processedGIP[_loc4_].r3.Get(),
                                    "r4":_processedGIP[_loc4_].r4.Get()
                                 };
                              }
                              _GIP["r1"].Add(_processedGIP[_loc4_]["r1"].Get());
                              _GIP["r2"].Add(_processedGIP[_loc4_]["r2"].Get());
                              _GIP["r3"].Add(_processedGIP[_loc4_]["r3"].Get());
                              _GIP["r4"].Add(_processedGIP[_loc4_]["r4"].Get());
                           }
                        }
                        if(!_rawGIP["t"])
                        {
                           _lastProcessedGIP = _lastProcessed;
                        }
                        if(GLOBAL.Timestamp() - _lastProcessedGIP > 86400)
                        {
                           _lastProcessedGIP = GLOBAL.Timestamp() - 86400;
                        }
                        _processedGIP["t"] = _lastProcessedGIP;
                     }
                  }
               }
               if(GLOBAL._loadmode == "build" && _yardType == MAIN_YARD)
               {
                  if(param1.alliancedata)
                  {
                     _allianceID = int(param1.alliancedata.alliance_id);
                     if(_userID == LOGIN._playerID)
                     {
                        ALLIANCES._allianceID = int(param1.alliancedata.alliance_id);
                        ALLIANCES._myAlliance = ALLIANCES.SetAlliance(param1.alliancedata);
                     }
                  }
                  else if(_userID == LOGIN._playerID && (ALLIANCES._allianceID || ALLIANCES._myAlliance))
                  {
                     ALLIANCES.Clear();
                     POWERUPS.Validate();
                  }
               }
               if(param1.powerups)
               {
                  POWERUPS.Setup(param1.powerups,null,false);
               }
               if(param1.attpowerups)
               {
                  POWERUPS.Setup(null,param1.attpowerups,false);
               }
               QUESTS.Check();
            }
            else
            {
               LOGGER.Log("err","Base.Page: " + JSON.encode(param1));
               GLOBAL.ErrorMessage("Base.Page: " + param1.error);
            }
         };
         handleLoadError = function(param1:IOErrorEvent):void
         {
            ++_pageErrors;
            _paging = false;
            Console.warning("BASE.Page ERROR",_pageErrors);
            _lastPaged = int(10 + int(Math.random() * 5));
            if(_pageErrors >= 6)
            {
               LOGGER.Log("err","Base.Page HTTP");
               GLOBAL.ErrorMessage("BASE.Page HTTP");
            }
         };
         var t:int = getTimer();
         var tmpMode:String = GLOBAL._loadmode;
         if(tmpMode == "wmattack")
         {
            tmpMode = "attack";
         }
         if(tmpMode == "wmview")
         {
            tmpMode = "view";
         }
         if(tmpMode == "iwmattack")
         {
            tmpMode = "iattack";
         }
         if(tmpMode == "iwmview")
         {
            tmpMode = "iview";
         }
         _paging = true;
         if(isInferno())
         {
            new URLLoaderApi().load(GLOBAL._infBaseURL + "updatesaved",[["baseid",BASE._loadedBaseID],["version",GLOBAL._version.Get()],["lastupdate",UPDATES._lastUpdateID],["type",tmpMode]],handleLoadSuccessful,handleLoadError);
         }
         else
         {
            new URLLoaderApi().load(GLOBAL._baseURL + "updatesaved",[["baseid",BASE._loadedBaseID],["version",GLOBAL._version.Get()],["lastupdate",UPDATES._lastUpdateID],["type",tmpMode]],handleLoadSuccessful,handleLoadError);
         }
      }
      
      public static function BuildingStorageAdd(param1:int, param2:int = 0) : *
      {
         if(!_buildingsStored["b" + param1])
         {
            _buildingsStored["b" + param1] = new SecNum(0);
         }
         _buildingsStored["b" + param1].Add(1);
         if(BTOTEM.IsTotem2(param1))
         {
            _buildingsStored["bl" + param1] = new SecNum(param2);
         }
      }
      
      public static function BuildingStorageRemove(param1:int) : int
      {
         var _loc2_:int = 0;
         if(_buildingsStored["b" + param1])
         {
            if(_buildingsStored["b" + param1].Get() >= 1)
            {
               _buildingsStored["b" + param1].Add(-1);
               _loc2_ = 1;
               if(_buildingsStored["bl" + param1])
               {
                  _loc2_ = int(_buildingsStored["bl" + param1].Get());
                  delete _buildingsStored["bl" + param1];
               }
               return _loc2_;
            }
         }
         return 0;
      }
      
      public static function BuildingStorageCount(param1:int) : int
      {
         if(_buildingsStored["b" + param1])
         {
            return _buildingsStored["b" + param1].Get();
         }
         return 0;
      }
      
      public static function CanBuild(param1:int, param2:Boolean = false) : Object
      {
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:BFOUNDATION = null;
         var _loc15_:Array = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:* = undefined;
         var _loc23_:int = 0;
         var _loc24_:Boolean = false;
         var _loc25_:Object = null;
         var _loc26_:Array = null;
         var _loc3_:Object = {};
         var _loc4_:Boolean = false;
         var _loc5_:String = "";
         var _loc6_:int = 0;
         if(GLOBAL._aiDesignMode)
         {
            return {"error":false};
         }
         for(_loc7_ in GLOBAL._buildingProps)
         {
            if(GLOBAL._buildingProps[_loc7_].id == param1)
            {
               if(GLOBAL._buildingProps[_loc7_].rewarded)
               {
                  return {"error":false};
               }
               _loc3_ = GLOBAL._buildingProps[_loc7_];
               break;
            }
         }
         if(TUTORIAL._stage < 200 && _loc3_.tutstage > TUTORIAL._stage)
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_builderr_locked");
         }
         else if(GLOBAL._mode == "build" && (_loc3_.type == "taunt" || _loc3_.type == "gift"))
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_builderr_ownyard1");
         }
         else if(GLOBAL._mode != "build" && _loc3_.type != "taunt" && _loc3_.type != "gift")
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_builderr_ownyard2");
         }
         else
         {
            _loc8_ = _loc3_.quantity;
            _loc9_ = 0;
            _loc10_ = isInferno();
            if(GLOBAL._bTownhall)
            {
               _loc9_ = GLOBAL._bTownhall._lvl.Get();
               if(Boolean(_loc3_.costs[0].re[0]) && _loc3_.costs[0].re[0][0] == INFERNOQUAKETOWER.UNDERHALL_ID)
               {
                  if(!MAPROOM_DESCENT.DescentPassed)
                  {
                     _loc4_ = true;
                     _loc5_ = KEYS.Get("inferno_building_requirement");
                     return {
                        "error":_loc4_,
                        "errorMessage":_loc5_
                     };
                  }
                  _loc9_ = GLOBAL.StatGet(BUILDING14.UNDERHALL_LEVEL);
                  _loc10_ = true;
                  if(!_loc9_)
                  {
                     _loc4_ = true;
                     _loc5_ = KEYS.Get("base_builderr_noinfstate",{"v1":_loc9_});
                     return {
                        "error":_loc4_,
                        "errorMessage":_loc5_
                     };
                  }
               }
            }
            _loc11_ = int(_loc8_[_loc9_]);
            if(_loc3_.type == "decoration")
            {
               _loc12_ = _loc11_ = int(_loc8_[0]);
            }
            else
            {
               _loc12_ = _loc11_;
               if(_loc8_.length > _loc9_)
               {
                  _loc12_ = int(_loc8_[_loc9_ + 1]);
               }
            }
            if(_loc11_ == 0)
            {
               _loc13_ = 0;
               while(_loc13_ < _loc8_.length)
               {
                  if(_loc8_[_loc13_] > 0)
                  {
                     _loc4_ = true;
                     _loc5_ = KEYS.Get(_loc10_ ? "base_builderr_uhlevelreqd" : "base_builderr_thlevelreqd",{"v1":_loc13_});
                     break;
                  }
                  _loc13_++;
               }
            }
            else if(_loc3_.type != "decoration" || _loc3_.type == "decoration" && _loc3_.quantity[0] != 0)
            {
               _loc6_ = 0;
               for each(_loc14_ in BASE._buildingsAll)
               {
                  if(_loc14_._type == param1)
                  {
                     _loc6_++;
                  }
               }
               if(_loc6_ >= _loc11_)
               {
                  _loc4_ = true;
                  if(_loc12_ > _loc11_)
                  {
                     _loc5_ = KEYS.Get(isInfernoBuilding(param1) || isInferno() ? "base_builderr_uuh" : "base_builderr_uth");
                  }
                  else
                  {
                     _loc5_ = KEYS.Get("base_builderr_onlybuildx",{"v1":_loc11_});
                  }
               }
            }
         }
         if(!_loc4_)
         {
            _loc15_ = _loc3_.costs[0].re;
            _loc16_ = 0;
            _loc13_ = 0;
            while(_loc13_ < _loc15_.length)
            {
               _loc6_ = 0;
               if(_loc15_[_loc13_][0] == INFERNOQUAKETOWER.UNDERHALL_ID)
               {
                  if(GLOBAL.StatGet(BUILDING14.UNDERHALL_LEVEL) >= _loc15_[_loc13_][2])
                  {
                     _loc6_++;
                  }
               }
               else
               {
                  for each(_loc14_ in BASE._buildingsAll)
                  {
                     if(_loc14_._type == _loc15_[_loc13_][0] && _loc14_._lvl.Get() >= _loc15_[_loc13_][2])
                     {
                        _loc6_++;
                     }
                  }
               }
               if(_loc6_ >= _loc15_[_loc13_][1])
               {
                  _loc16_++;
               }
               _loc13_++;
            }
            if(_loc16_ < _loc15_.length)
            {
               _loc4_ = true;
               _loc5_ = "Requirements not met.";
            }
         }
         if(!_loc4_ && !param2)
         {
            _loc17_ = int(_loc3_.costs[0].r1);
            _loc18_ = int(_loc3_.costs[0].r2);
            _loc19_ = int(_loc3_.costs[0].r3);
            _loc20_ = int(_loc3_.costs[0].r4);
            _loc21_ = 0;
            _loc23_ = 0;
            if(GLOBAL._mode == "build" || GLOBAL._mode == "ibuild")
            {
               _loc24_ = BASE.isInfernoBuilding(param1);
               _loc25_ = _loc24_ ? BASE._iresources : BASE._resources;
               if(_loc17_ > _loc25_.r1.Get())
               {
                  _loc22_ = 1;
                  _loc23_ = _loc17_ - _loc25_.r1.Get();
               }
               if(_loc18_ > _loc25_.r2.Get())
               {
                  _loc22_ = 2;
                  _loc23_ = _loc18_ - _loc25_.r2.Get();
               }
               if(_loc19_ > _loc25_.r3.Get())
               {
                  _loc22_ = 3;
                  _loc23_ = _loc19_ - _loc25_.r3.Get();
               }
               if(_loc20_ > _loc25_.r4.Get())
               {
                  _loc22_ = 4;
                  _loc23_ = _loc20_ - _loc25_.r4.Get();
               }
               if(_loc22_ > 0)
               {
                  _loc4_ = true;
                  _loc26_ = _loc24_ ? GLOBAL.iresourceNames : GLOBAL._resourceNames;
                  _loc5_ = "You need " + GLOBAL.FormatNumber(_loc23_) + " more " + KEYS.Get(_loc26_[_loc22_ - 1]);
               }
            }
         }
         return {
            "error":_loc4_,
            "errorMessage":_loc5_,
            "needResource":_loc22_
         };
      }
      
      public static function CanUpgrade(param1:BFOUNDATION) : Object
      {
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:BFOUNDATION = null;
         var _loc14_:Array = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Boolean = false;
         var _loc18_:Object = null;
         if(param1._class == "mushroom")
         {
            return {"error":false};
         }
         var _loc2_:Object = {};
         var _loc3_:Object = {
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":0
         };
         var _loc4_:Boolean = false;
         var _loc5_:String = "";
         var _loc6_:int = param1._lvl.Get();
         for(_loc7_ in GLOBAL._buildingProps)
         {
            if(GLOBAL._buildingProps[_loc7_].id == param1._type)
            {
               _loc2_ = GLOBAL._buildingProps[_loc7_];
               break;
            }
         }
         _loc8_ = _loc2_.costs;
         if(!GLOBAL._bTownhall)
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_uperr_th");
         }
         else if(_loc6_ >= _loc8_.length)
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_uperr_fully");
         }
         else if(param1._countdownBuild.Get())
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_uperr_stillbuilding");
         }
         else if(param1._countdownUpgrade.Get())
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_uperr_alreadyupgrading");
         }
         else if(param1._countdownFortify.Get())
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_uperr_stillfortifying");
         }
         else
         {
            _loc9_ = [];
            for each(_loc10_ in _loc8_[_loc6_].re)
            {
               _loc11_ = 0;
               if(_loc10_[0] == INFERNOQUAKETOWER.UNDERHALL_ID)
               {
                  _loc12_ = "#bi_townhall#";
                  if(GLOBAL.StatGet(BUILDING14.UNDERHALL_LEVEL) >= _loc10_[2])
                  {
                     _loc11_++;
                  }
               }
               else
               {
                  _loc12_ = GLOBAL._buildingProps[_loc10_[0] - 1].name;
                  for each(_loc13_ in BASE._buildingsAll)
                  {
                     if(_loc13_._type == _loc10_[0] && _loc13_._lvl.Get() >= _loc10_[2])
                     {
                        _loc11_++;
                     }
                  }
               }
               if(_loc11_ < _loc10_[1])
               {
                  if(_loc10_[1] == 1)
                  {
                     if(_loc10_[2] == 1)
                     {
                        _loc9_.push([0,KEYS.Get("base_uperr_bdgpart1",{"v1":KEYS.Get(_loc12_)})]);
                     }
                     else
                     {
                        _loc9_.push([0,KEYS.Get("base_uperr_bdgpart2",{
                           "v1":_loc10_[2],
                           "v2":KEYS.Get(_loc12_)
                        })]);
                     }
                  }
                  else if(_loc10_[2] == 1)
                  {
                     _loc9_.push([0,KEYS.Get("base_uperr_bdgpart3",{
                        "v1":KEYS.Get(_loc12_),
                        "v2":_loc10_[1]
                     })]);
                  }
                  else
                  {
                     _loc9_.push([0,KEYS.Get("base_uperr_bdgpart4",{
                        "v1":_loc10_[2],
                        "v2":KEYS.Get(_loc12_),
                        "v3":_loc10_[1]
                     })]);
                  }
               }
            }
            if(_loc9_.length > 0)
            {
               _loc4_ = true;
               _loc5_ = KEYS.Get("base_uperr_buildings",{"v1":GLOBAL.Array2StringB(_loc9_)});
            }
            if(_loc15_ > 0)
            {
               _loc4_ = true;
               _loc14_ = !!isInfernoBuilding ? GLOBAL.iresourceNames : GLOBAL._resourceNames;
               _loc5_ = "You need " + GLOBAL.FormatNumber(_loc16_) + " more " + KEYS.Get(_loc14_[_loc15_ - 1]);
            }
            if(!_loc4_)
            {
               if(_loc6_ < _loc8_.length)
               {
                  _loc3_ = _loc8_[_loc6_];
                  if(!_loc4_)
                  {
                     _loc16_ = 0;
                     _loc17_ = BASE.isInfernoBuilding(param1._type);
                     _loc18_ = _loc17_ ? BASE._iresources : BASE._resources;
                     if(_loc3_.r1 > _loc18_.r1.Get())
                     {
                        _loc15_ = 1;
                        _loc16_ = _loc3_.r1 - _loc18_.r1.Get();
                     }
                     if(_loc3_.r2 > _loc18_.r2.Get())
                     {
                        _loc15_ = 2;
                        _loc16_ = _loc3_.r2 - _loc18_.r2.Get();
                     }
                     if(_loc3_.r3 > _loc18_.r3.Get())
                     {
                        _loc15_ = 3;
                        _loc16_ = _loc3_.r3 - _loc18_.r3.Get();
                     }
                     if(_loc3_.r4 > _loc18_.r4.Get())
                     {
                        _loc15_ = 4;
                        _loc16_ = _loc3_.r4 - _loc18_.r4.Get();
                     }
                     if(_loc15_ > 0)
                     {
                        _loc4_ = true;
                        _loc5_ = KEYS.Get("base_uperr_resources",{
                           "v1":GLOBAL.FormatNumber(_loc16_),
                           "v2":KEYS.Get(GLOBAL._resourceNames[_loc15_ - 1])
                        });
                     }
                  }
               }
            }
         }
         return {
            "error":_loc4_,
            "errorMessage":_loc5_,
            "costs":_loc3_,
            "needResource":_loc15_
         };
      }
      
      public static function CanFortify(param1:BFOUNDATION) : Object
      {
         var _loc7_:String = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc12_:BFOUNDATION = null;
         var _loc13_:* = undefined;
         var _loc14_:int = 0;
         if(param1._class == "mushroom")
         {
            return {"error":false};
         }
         var _loc2_:Object = {};
         var _loc3_:Object = {
            "r1":0,
            "r2":0,
            "r3":0,
            "r4":0,
            "time":0
         };
         var _loc4_:Boolean = false;
         var _loc5_:String = "";
         var _loc6_:int = param1._fortification.Get();
         for(_loc7_ in GLOBAL._buildingProps)
         {
            if(GLOBAL._buildingProps[_loc7_].id == param1._type)
            {
               _loc2_ = GLOBAL._buildingProps[_loc7_];
               break;
            }
         }
         if(!_loc2_.can_fortify)
         {
            return {"error":true};
         }
         var _loc8_:* = _loc2_.fortify_costs;
         if(!GLOBAL._bTownhall)
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_forterr_th");
         }
         else if(_loc6_ >= _loc8_.length)
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_forterr_fully");
         }
         else if(param1._countdownBuild.Get())
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_forterr_stillbuilding");
         }
         else if(param1._countdownUpgrade.Get())
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_forterr_stillupgrading");
         }
         else if(param1._countdownFortify.Get())
         {
            _loc4_ = true;
            _loc5_ = KEYS.Get("base_forterr_stillfortifying");
         }
         else
         {
            _loc9_ = [];
            for each(_loc10_ in _loc8_[_loc6_].re)
            {
               _loc11_ = 0;
               for each(_loc12_ in BASE._buildingsAll)
               {
                  if(_loc12_._type == _loc10_[0] && _loc12_._lvl.Get() >= _loc10_[2])
                  {
                     _loc11_++;
                  }
               }
               if(_loc11_ < _loc10_[1])
               {
                  if(_loc10_[1] == 1)
                  {
                     if(_loc10_[2] == 1)
                     {
                        _loc9_.push([0,KEYS.Get("base_forterr_bdgpart1",{"v1":KEYS.Get(GLOBAL._buildingProps[_loc10_[0] - 1].name)})]);
                     }
                     else
                     {
                        _loc9_.push([0,KEYS.Get("base_forterr_bdgpart2",{
                           "v1":_loc10_[2],
                           "v2":KEYS.Get(GLOBAL._buildingProps[_loc10_[0] - 1].name)
                        })]);
                     }
                  }
                  else if(_loc10_[2] == 1)
                  {
                     _loc9_.push([0,KEYS.Get("base_forterr_bdgpart3",{
                        "v1":KEYS.Get(GLOBAL._buildingProps[_loc10_[0] - 1].name),
                        "v2":_loc10_[1]
                     })]);
                  }
                  else
                  {
                     _loc9_.push([0,KEYS.Get("base_forterr_bdgpart4",{
                        "v1":_loc10_[2],
                        "v2":KEYS.Get(GLOBAL._buildingProps[_loc10_[0] - 1].name),
                        "v3":_loc10_[1]
                     })]);
                  }
               }
            }
            if(_loc9_.length > 0)
            {
               _loc4_ = true;
               _loc5_ = KEYS.Get("base_forterr_buildings",{"v1":GLOBAL.Array2StringB(_loc9_)});
            }
            if(!_loc4_)
            {
               if(_loc6_ < _loc8_.length)
               {
                  _loc3_ = _loc8_[_loc6_];
                  if(!_loc4_)
                  {
                     _loc14_ = 0;
                     if(_loc3_.r1 > BASE._resources.r1.Get())
                     {
                        _loc13_ = 1;
                        _loc14_ = _loc3_.r1 - BASE._resources.r1.Get();
                     }
                     if(_loc3_.r2 > BASE._resources.r2.Get())
                     {
                        _loc13_ = 2;
                        _loc14_ = _loc3_.r2 - BASE._resources.r2.Get();
                     }
                     if(_loc3_.r3 > BASE._resources.r3.Get())
                     {
                        _loc13_ = 3;
                        _loc14_ = _loc3_.r3 - BASE._resources.r3.Get();
                     }
                     if(_loc3_.r4 > BASE._resources.r4.Get())
                     {
                        _loc13_ = 4;
                        _loc14_ = _loc3_.r4 - BASE._resources.r4.Get();
                     }
                     if(_loc13_ > 0)
                     {
                        _loc4_ = true;
                        _loc5_ = KEYS.Get("base_forterr_resources",{
                           "v1":GLOBAL.FormatNumber(_loc14_),
                           "v2":KEYS.Get(GLOBAL._resourceNames[_loc13_ - 1])
                        });
                     }
                  }
               }
            }
         }
         return {
            "error":_loc4_,
            "errorMessage":_loc5_,
            "costs":_loc3_,
            "needResource":_loc13_
         };
      }
      
      public static function is711Valid() : *
      {
         var _loc1_:Date = new Date();
         return _loc1_.getUTCFullYear() == 2011;
      }
      
      public static function addBuilding(param1:MouseEvent) : *
      {
         var _loc2_:* = param1.target.name.split("b")[1];
         return addBuildingB(_loc2_);
      }
      
      public static function addBuildingB(param1:int, param2:Boolean = false) : *
      {
         var _loc4_:Object = null;
         BuildingDeselect();
         var _loc3_:* = GLOBAL._buildingProps[param1 - 1].costs[0].time == 0;
         if(!_loc3_)
         {
            _loc3_ = QUEUE.CanDo().error == false;
         }
         if(BuildingStorageCount(param1) > 0)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            _loc4_ = CanBuild(param1,param2);
            if(!_loc4_.error)
            {
               BASE.BuildingDeselect();
               ShowFootprints();
               GLOBAL._newBuilding = addBuildingC(param1);
               if(GLOBAL._newBuilding)
               {
                  GLOBAL._newBuilding._mc.alpha = 0.5;
                  GLOBAL._newBuilding.FollowMouse();
               }
               else
               {
                  BuildingDeselect();
               }
               return GLOBAL._newBuilding;
            }
            GLOBAL.Message(_loc4_.errorMessage);
         }
         else
         {
            POPUPS.DisplayWorker(0,param1);
         }
         return false;
      }
      
      private static function ConvertToInfernoBuilding(param1:int) : int
      {
         switch(param1)
         {
            case 15:
               param1 = 128;
               break;
            case 23:
               param1 = 129;
               break;
            case 25:
               param1 = 132;
         }
         return param1;
      }
      
      public static function addBuildingC(param1:int) : BFOUNDATION
      {
         var _loc2_:BFOUNDATION = null;
         var _loc3_:Object = null;
         _loc3_ = GLOBAL._buildingProps[param1 - 1] || {};
         if(_loc3_.type == "decoration")
         {
            if(BTOTEM.IsTotem2(param1))
            {
               _loc2_ = new BTOTEM(param1);
            }
            else
            {
               _loc2_ = new BDECORATION(param1);
            }
         }
         else if(param1 == 1)
         {
            _loc2_ = new BUILDING1();
         }
         else if(param1 == 2)
         {
            _loc2_ = new BUILDING2();
         }
         else if(param1 == 3)
         {
            _loc2_ = new BUILDING3();
         }
         else if(param1 == 4)
         {
            _loc2_ = new BUILDING4();
         }
         else if(param1 == 5)
         {
            _loc2_ = new BUILDING5();
         }
         else if(param1 == 6)
         {
            _loc2_ = new BUILDING6();
         }
         else if(param1 == 7)
         {
            _loc2_ = new BUILDING7();
         }
         else if(param1 == 8)
         {
            _loc2_ = new BUILDING8();
         }
         else if(param1 == 9)
         {
            _loc2_ = new BUILDING9();
         }
         else if(param1 == 10)
         {
            _loc2_ = new BUILDING10();
         }
         else if(param1 == 11)
         {
            _loc2_ = new BUILDING11();
         }
         else if(param1 == 12)
         {
            _loc2_ = new BUILDING12();
         }
         else if(param1 == 13)
         {
            _loc2_ = new BUILDING13();
         }
         else if(param1 == 14)
         {
            _loc2_ = new BUILDING14();
         }
         else if(param1 == 15)
         {
            _loc2_ = new BUILDING15();
         }
         else if(param1 == 16)
         {
            _loc2_ = new BUILDING16();
         }
         else if(param1 == 17)
         {
            _loc2_ = new BUILDING17();
         }
         else if(param1 == 18)
         {
            _loc2_ = new BUILDING18();
         }
         else if(param1 == 19)
         {
            _loc2_ = new BUILDING19();
         }
         else if(param1 == 20)
         {
            _loc2_ = new BUILDING20();
         }
         else if(param1 == 21)
         {
            _loc2_ = new BUILDING21();
         }
         else if(param1 == 22)
         {
            _loc2_ = new BUILDING22();
         }
         else if(param1 == 23)
         {
            _loc2_ = new BUILDING23();
         }
         else if(param1 == 24)
         {
            _loc2_ = new BUILDING24();
         }
         else if(param1 == 25)
         {
            _loc2_ = new BUILDING25();
         }
         else if(param1 == 26)
         {
            _loc2_ = new BUILDING26();
         }
         else if(param1 == 27)
         {
            _loc2_ = new BUILDING27();
         }
         else if(param1 == 51)
         {
            _loc2_ = new BUILDING51();
         }
         else if(param1 == 52)
         {
            _loc2_ = new BUILDING52();
         }
         else if(param1 == 112)
         {
            _loc2_ = new BUILDING112();
         }
         else if(param1 == 113)
         {
            _loc2_ = new BUILDING113();
         }
         else if(param1 == 114)
         {
            _loc2_ = new CHAMPIONCAGE();
         }
         else if(param1 == 115)
         {
            _loc2_ = new BUILDING115();
         }
         else if(param1 == 116)
         {
            _loc2_ = new MONSTERLAB();
         }
         else if(param1 == 117)
         {
            _loc2_ = new BUILDING117();
         }
         else if(param1 == 118)
         {
            _loc2_ = new BUILDING118();
         }
         else if(param1 == 119)
         {
            _loc2_ = new CHAMPIONCHAMBER();
         }
         else if(param1 == 128)
         {
            _loc2_ = new HOUSINGBUNKER();
         }
         else if(param1 == 127)
         {
            _loc2_ = new INFERNOPORTAL();
         }
         else if(param1 == 129)
         {
            _loc2_ = new INFERNOQUAKETOWER();
         }
         else if(param1 == 130)
         {
            _loc2_ = new INFERNO_CANNON_TOWER();
         }
         else if(param1 == 132)
         {
            _loc2_ = new INFERNO_MAGMA_TOWER();
         }
         return !!_loc3_.cls ? new _loc3_.cls() : _loc2_;
      }
      
      public static function ShowFootprints() : *
      {
         var _loc1_:BFOUNDATION = null;
         var _loc2_:BFOUNDATION = null;
         for each(_loc1_ in _buildingsAll)
         {
            _loc1_._mcFootprint.visible = true;
            _loc1_.BlockClicks();
         }
         for each(_loc2_ in _buildingsMushrooms)
         {
            _loc2_._mcFootprint.visible = true;
            _loc2_.BlockClicks();
         }
      }
      
      public static function HideFootprints() : *
      {
         var _loc1_:BFOUNDATION = null;
         var _loc2_:BFOUNDATION = null;
         for each(_loc1_ in _buildingsAll)
         {
            if(GLOBAL._selectedBuilding != _loc1_)
            {
               _loc1_._mcFootprint.visible = false;
            }
            _loc1_.UnblockClicks();
         }
         for each(_loc2_ in _buildingsMushrooms)
         {
            _loc2_._mcFootprint.visible = false;
            _loc2_.UnblockClicks();
         }
      }
      
      public static function BuildingSelect(param1:BFOUNDATION, param2:Boolean = false) : *
      {
         BuildingDeselect();
         if(GLOBAL._mode == "build" || GLOBAL._mode == "ibuild")
         {
            if(UI2._showBottom || TUTORIAL._stage == 3 || TUTORIAL._stage == 4 || TUTORIAL._stage == 20 || TUTORIAL._stage == 21 || TUTORIAL._stage == 23)
            {
               GLOBAL._selectedBuilding = param1;
               if(param1._class != "mushroom")
               {
                  GLOBAL._selectedBuilding._mcFootprint.visible = true;
               }
               param1.Update();
               if(!param2)
               {
                  if(param1._type == 127 && GLOBAL.StatGet("p_id") != 1 && !MAPROOM_DESCENT.DescentPassed && !BASE.isInferno())
                  {
                     INFERNO_DESCENT_POPUPS.ShowEnticePopup();
                  }
                  else
                  {
                     BUILDINGINFO.Show(param1);
                  }
               }
            }
         }
         else if(GLOBAL._mode == "help" || GLOBAL._mode == "ihelp" || LOGIN._playerID == param1._senderid)
         {
            GLOBAL._selectedBuilding = param1;
            GLOBAL._selectedBuilding._mcFootprint.visible = true;
            param1.Update();
            if(!param2)
            {
               BUILDINGINFO.Show(param1);
            }
         }
      }
      
      public static function BuildingDeselect() : *
      {
         var _loc1_:* = undefined;
         BUILDINGINFO.Hide();
         HideFootprints();
         if(GLOBAL._newBuilding)
         {
            GLOBAL._newBuilding.Cancel();
         }
         if(GLOBAL._selectedBuilding && Boolean(GLOBAL._selectedBuilding._moving))
         {
            GLOBAL._selectedBuilding.StopMoveB();
         }
         if(GLOBAL._selectedBuilding)
         {
            _loc1_ = GLOBAL._selectedBuilding;
            GLOBAL._selectedBuilding = null;
            if(_loc1_ && Boolean(_loc1_._mc))
            {
               _loc1_.Update();
               _loc1_._mcFootprint.visible = false;
            }
            BUILDINGINFO.Hide();
         }
      }
      
      public static function Shake(param1:int) : *
      {
         _shakeCountdown = param1;
      }
      
      public static function ShakeB() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_shakeCountdown > 0)
         {
            --_shakeCountdown;
            _loc1_ = int(_shakeCountdown / 10 - Math.random() * (_shakeCountdown / 5));
            _loc2_ = int(_shakeCountdown / 10 - Math.random() * (_shakeCountdown / 5));
            MAP._GROUND.x += _loc1_;
            MAP._GROUND.y += _loc2_;
         }
      }
      
      public static function Charge(param1:int, param2:Number, param3:Boolean = false, param4:Boolean = false) : int
      {
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         param2 = Math.floor(param2);
         if(param4 && isInferno())
         {
            param4 = false;
         }
         _loc5_ = param4 ? _ideltaResources : _deltaResources;
         _loc6_ = GLOBAL._mode == "build" || GLOBAL._mode == "ibuild" ? (param4 ? _iresources : _resources) : GLOBAL._attackersResources;
         _loc7_ = GLOBAL._mode == "build" || GLOBAL._mode == "ibuild" ? _hpResources : GLOBAL._hpAttackersResources;
         if(param2 <= _loc6_["r" + param1].Get())
         {
            if(!param3)
            {
               _loc6_["r" + param1].Add(-param2);
               if(!param4)
               {
                  _loc7_["r" + param1] -= param2;
               }
               if(GLOBAL._mode == "build" || GLOBAL._mode == "ibuild")
               {
                  if(param4)
                  {
                     if(_loc5_["r" + param1])
                     {
                        _loc5_["r" + param1].Add(Math.floor(-param2));
                     }
                     else
                     {
                        _loc5_["r" + param1] = new SecNum(Math.floor(-param2));
                     }
                     _loc5_.dirty = true;
                     GLOBAL._resources["r" + param1].Add(-param2);
                     GLOBAL._hpResources["r" + param1] -= param2;
                  }
                  else
                  {
                     if(_loc5_["r" + param1])
                     {
                        _loc5_["r" + param1].Add(Math.floor(-param2));
                        _hpDeltaResources["r" + param1] += Math.floor(-param2);
                     }
                     else
                     {
                        _loc5_["r" + param1] = new SecNum(Math.floor(-param2));
                        _hpDeltaResources["r" + param1] = Math.floor(-param2);
                     }
                     _loc5_.dirty = true;
                     _hpDeltaResources.dirty = true;
                     GLOBAL._resources["r" + param1].Add(-param2);
                     GLOBAL._hpResources["r" + param1] -= param2;
                  }
               }
               else
               {
                  if(GLOBAL._attackersDeltaResources["r" + param1])
                  {
                     GLOBAL._attackersDeltaResources["r" + param1].Add(Math.floor(-param2));
                  }
                  else
                  {
                     GLOBAL._attackersDeltaResources["r" + param1] = new SecNum(Math.floor(-param2));
                  }
                  GLOBAL._attackersDeltaResources.dirty = true;
               }
               if(GLOBAL._mode == "build" || GLOBAL._mode == "ibuild")
               {
               }
               CalcResources();
            }
            return param2;
         }
         return 0;
      }
      
      public static function Fund(param1:int, param2:Number, param3:Boolean = false, param4:* = null, param5:Boolean = false, param6:Boolean = true) : *
      {
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         var _loc10_:String = null;
         var _loc11_:* = null;
         var _loc12_:Number = NaN;
         param2 = Math.floor(param2);
         if(param5 && isInferno())
         {
            param5 = false;
         }
         if(param1 < 5)
         {
            _loc7_ = param5 ? _iresources : _resources;
            _loc8_ = param5 ? _ideltaResources : _deltaResources;
            _loc9_ = param5 ? {} : _hpDeltaResources;
            _loc10_ = "r" + param1;
            _loc11_ = "r" + param1 + "max";
            _loc12_ = 0;
            if(_loc7_[_loc10_].Get() < _loc7_[_loc11_] || param3)
            {
               if(_loc7_[_loc10_].Get() + param2 < _loc7_[_loc11_] || param3)
               {
                  _loc7_[_loc10_].Add(param2);
                  if(!param5)
                  {
                     _hpResources[_loc10_] += param2;
                  }
                  if(_loc8_[_loc10_])
                  {
                     _loc8_[_loc10_].Add(param2);
                     _loc9_[_loc10_] += param2;
                  }
                  else
                  {
                     _loc8_[_loc10_] = new SecNum(param2);
                     _loc9_[_loc10_] = param2;
                  }
                  if(GLOBAL._mode == "build" || GLOBAL._mode == "ibuild")
                  {
                     GLOBAL._resources[_loc10_].Add(param2);
                     GLOBAL._hpResources[_loc10_] += param2;
                  }
                  _loc8_.dirty = true;
                  _loc9_.dirty = true;
                  _loc12_ = param2;
               }
               else
               {
                  _loc12_ = _loc7_[_loc11_] - _loc7_[_loc10_].Get();
                  _loc7_[_loc10_].Set(_loc7_[_loc11_]);
                  if(!param5)
                  {
                     _hpResources[_loc10_] = _loc7_[_loc11_];
                  }
                  if(_loc8_[_loc10_])
                  {
                     _loc8_[_loc10_].Add(Math.floor(_loc12_));
                     _loc9_[_loc10_] += Math.floor(_loc12_);
                  }
                  else
                  {
                     _loc8_[_loc10_] = new SecNum(Math.floor(_loc12_));
                     _loc9_[_loc10_] = Math.floor(_loc12_);
                  }
                  if(GLOBAL._mode == "build" || GLOBAL._mode == "ibuild")
                  {
                     GLOBAL._resources[_loc10_].Add(Math.floor(_loc12_));
                     GLOBAL._hpResources[_loc10_] += Math.floor(_loc12_);
                  }
                  _loc8_.dirty = true;
                  _loc9_.dirty = true;
               }
               _bankedValue += _loc12_;
               _bankedTime = GLOBAL.Timestamp();
               if((GLOBAL._mode == "build" || GLOBAL._mode == "ibuild") && !param5)
               {
               }
            }
            else if((GLOBAL._mode == "build" || GLOBAL._mode == "ibuild") && !param5 && !WMATTACK._inProgress && param6)
            {
               UI2._top.OverchargeShow(param1);
            }
            if(param4)
            {
               param4._stored.Add(-_loc12_);
               if(!param4._producing)
               {
                  param4.StartProduction();
               }
               param4.Update();
            }
            if(_loc12_ > 0 && (GLOBAL._mode == "build" || GLOBAL._mode == "ibuild") && param6)
            {
               Save();
            }
         }
         UI2.Update();
         return _loc12_;
      }
      
      private static function JiggleResource(param1:int, param2:Number) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(param2 == 0)
         {
            return;
         }
         _loc3_ = UI2._top.mc["mcR" + param1];
         _loc3_.x = -15;
         TweenLite.to(_loc3_,0.6,{
            "x":0,
            "ease":Elastic.easeOut
         });
         if(BASE.isInferno())
         {
            return;
         }
         _loc4_ = _loc3_.mcPoints.txt;
         if(param2 >= 0)
         {
            _loc5_ = "00FF00";
            _loc6_ = "+";
         }
         else
         {
            _loc5_ = "FF0000";
            _loc6_ = "-";
         }
         _loc4_.y = 0;
         _loc4_.x = 0;
         _loc3_.mcPoints.alpha = 1;
         _loc4_.alpha = 1;
         _loc4_.htmlText = "<font color=\"#" + _loc5_ + "\">" + _loc6_ + GLOBAL.FormatNumber(param2) + "</font>";
         TweenLite.to(_loc4_,3 + Math.random(),{
            "y":_loc4_.y - (15 + Math.random() * 10),
            "x":Math.random() * 10,
            "alpha":0
         });
      }
      
      public static function SaveDeltaResources() : *
      {
         var _loc1_:int = 0;
         if(_deltaResources.dirty)
         {
            _loc1_ = 1;
            while(_loc1_ < 5)
            {
               if(_deltaResources["r" + _loc1_])
               {
                  if(_deltaResources["r" + _loc1_].Get() != _hpDeltaResources["r" + _loc1_])
                  {
                     LOGGER.Log("log","Delta resources r" + _loc1_ + " secure " + _deltaResources["r" + _loc1_] + " unsecure " + _hpDeltaResources["r" + _loc1_]);
                     GLOBAL.ErrorMessage("BASE.SaveDeltaResources");
                  }
                  if(_savedDeltaResources["r" + _loc1_])
                  {
                     _savedDeltaResources["r" + _loc1_].Add(_deltaResources["r" + _loc1_].Get());
                  }
                  else
                  {
                     _savedDeltaResources["r" + _loc1_] = new SecNum(_deltaResources["r" + _loc1_].Get());
                  }
               }
               _loc1_++;
            }
         }
         _deltaResources = {"dirty":false};
         _hpDeltaResources = {"dirty":false};
      }
      
      public static function CleanDeltaResources() : *
      {
         _savedDeltaResources = {
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0)
         };
         _ideltaResources.r1.Set(0);
         _ideltaResources.r2.Set(0);
         _ideltaResources.r3.Set(0);
         _ideltaResources.r4.Set(0);
      }
      
      public static function BuildBlockers(param1:BFOUNDATION, param2:Boolean = false) : String
      {
         if(GRID.FootprintBlocked(param1._footprint,new Point(param1._mc.x,param1._mc.y),true,param2))
         {
            return "overlap";
         }
         return "";
      }
      
      public static function CountBuildings() : *
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         _buildingCounts = {};
         _loc1_ = 0;
         while(_loc1_ < GLOBAL._buildingProps.length)
         {
            _buildingCounts["b" + (_loc1_ + 1)] = 0;
            _loc1_++;
         }
         for(_loc2_ in _buildingsAll)
         {
            ++_buildingCounts["b" + _buildingsAll[_loc2_]._type];
         }
      }
      
      public static function LoadNext(param1:MouseEvent = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(_saving || _loading || BASE._saveCounterA != BASE._saveCounterB)
         {
            GLOBAL._nextOutpostWaiting = 1;
            return;
         }
         if(GLOBAL._advancedMap)
         {
            if(_yardType == MAIN_YARD && !GLOBAL._bMap._canFunction)
            {
               GLOBAL.Message(KEYS.Get("map_msg_damaged"));
               return;
            }
            if(Boolean(GLOBAL._mapOutpostIDs) && GLOBAL._mapOutpostIDs.length > 0)
            {
               if(GLOBAL._mode == "build" || GLOBAL._mode == "ibuild")
               {
                  if(_yardType == MAIN_YARD || _yardType == INFERNO_YARD)
                  {
                     _yardType = isInferno() ? INFERNO_OUTPOST : OUTPOST;
                     _currentCellLoc = GLOBAL._mapOutpost[0];
                     GLOBAL._currentCell = null;
                     _needCurrentCell = true;
                     MapRoom.GetCell(GLOBAL._mapOutpost[0].x,GLOBAL._mapOutpost[0].y,true);
                     PLEASEWAIT.Show(KEYS.Get("process_outpost"));
                  }
                  else
                  {
                     _loc2_ = 0;
                     _loc3_ = 0;
                     while(_loc3_ < GLOBAL._mapOutpostIDs.length)
                     {
                        if(GLOBAL._mapOutpostIDs[_loc3_] == _loadedBaseID)
                        {
                           if(_loc3_ < GLOBAL._mapOutpostIDs.length - 1)
                           {
                              _yardType = OUTPOST;
                              _currentCellLoc = GLOBAL._mapOutpost[_loc3_ + 1];
                              GLOBAL._currentCell = null;
                              _needCurrentCell = true;
                              MapRoom.GetCell(GLOBAL._mapOutpost[_loc3_ + 1].x,GLOBAL._mapOutpost[_loc3_ + 1].y,true);
                              PLEASEWAIT.Show(KEYS.Get("process_outpost"));
                              break;
                           }
                           _needCurrentCell = false;
                           GLOBAL._currentCell = null;
                           LoadBase(null,null,GLOBAL._homeBaseID,"build",false,BASE.MAIN_YARD);
                           break;
                        }
                        _loc3_++;
                     }
                  }
               }
            }
         }
      }
      
      public static function CalcResources() : void
      {
         var capacity:Number = NaN;
         var rM:String = null;
         var i:String = null;
         var building:BFOUNDATION = null;
         var bT:int = 0;
         var lvl:int = 0;
         var n:int = 0;
         var j:int = 0;
         try
         {
            if(_yardType % 2 == OUTPOST)
            {
               if(GLOBAL._mode != "build")
               {
                  return;
               }
            }
            else
            {
               _resources.r1max = 10000;
               _resources.r2max = 10000;
               _resources.r3max = 10000;
               _resources.r4max = 10000;
            }
            if(_resources.r1.Get() > 25000000 && _resources.r2.Get() > 25000000 && _resources.r3.Get() > 25000000 && _resources.r4.Get() > 25000000)
            {
               ACHIEVEMENTS.Check("stockpile",1);
            }
            _resources.r1Rate = 0;
            _resources.r2Rate = 0;
            _resources.r3Rate = 0;
            _resources.r4Rate = 0;
            for(i in _buildingsAll)
            {
               building = _buildingsAll[i];
               bT = building._type;
               if(bT >= 5)
               {
                  if(bT == 6 && building._lvl.Get() >= 1 && _yardType % 2 == MAIN_YARD)
                  {
                     _resources.r1max += GLOBAL._buildingProps[bT - 1].capacity[building._lvl.Get() - 1];
                     _resources.r2max += GLOBAL._buildingProps[bT - 1].capacity[building._lvl.Get() - 1];
                     _resources.r3max += GLOBAL._buildingProps[bT - 1].capacity[building._lvl.Get() - 1];
                     _resources.r4max += GLOBAL._buildingProps[bT - 1].capacity[building._lvl.Get() - 1];
                  }
                  continue;
               }
               lvl = building._lvl.Get();
               if(_yardType == OUTPOST && GLOBAL._currentCell)
               {
                  if(Boolean(building._countdownUpgrade) && building._countdownUpgrade.Get() > 0)
                  {
                     lvl++;
                  }
               }
               switch(bT)
               {
                  case 1:
                     if(_yardType == OUTPOST && GLOBAL._currentCell)
                     {
                        _resources.r1Rate += int(BRESOURCE.AdjustProduction(GLOBAL._currentCell,GLOBAL._buildingProps[bT - 1].produce[lvl - 1]) / GLOBAL._buildingProps[bT - 1].cycleTime[lvl - 1] * 60 * 60);
                     }
                     else
                     {
                        _resources.r1Rate += int(GLOBAL._buildingProps[bT - 1].produce[lvl - 1] / GLOBAL._buildingProps[bT - 1].cycleTime[lvl - 1] * 60 * 60);
                     }
                     break;
                  case 2:
                     if(_yardType == OUTPOST && GLOBAL._currentCell)
                     {
                        _resources.r2Rate += int(BRESOURCE.AdjustProduction(GLOBAL._currentCell,GLOBAL._buildingProps[bT - 1].produce[lvl - 1]) / GLOBAL._buildingProps[bT - 1].cycleTime[lvl - 1] * 60 * 60);
                     }
                     else
                     {
                        _resources.r2Rate += int(GLOBAL._buildingProps[bT - 1].produce[lvl - 1] / GLOBAL._buildingProps[bT - 1].cycleTime[lvl - 1] * 60 * 60);
                     }
                     break;
                  case 3:
                     if(_yardType == OUTPOST && GLOBAL._currentCell)
                     {
                        _resources.r3Rate += int(BRESOURCE.AdjustProduction(GLOBAL._currentCell,GLOBAL._buildingProps[bT - 1].produce[lvl - 1]) / GLOBAL._buildingProps[bT - 1].cycleTime[lvl - 1] * 60 * 60);
                     }
                     else
                     {
                        _resources.r3Rate += int(GLOBAL._buildingProps[bT - 1].produce[lvl - 1] / GLOBAL._buildingProps[bT - 1].cycleTime[lvl - 1] * 60 * 60);
                     }
                     break;
                  case 4:
                     if(_yardType == OUTPOST && GLOBAL._currentCell)
                     {
                        _resources.r4Rate += int(BRESOURCE.AdjustProduction(GLOBAL._currentCell,GLOBAL._buildingProps[bT - 1].produce[lvl - 1]) / GLOBAL._buildingProps[bT - 1].cycleTime[lvl - 1] * 60 * 60);
                     }
                     else
                     {
                        _resources.r4Rate += int(GLOBAL._buildingProps[bT - 1].produce[lvl - 1] / GLOBAL._buildingProps[bT - 1].cycleTime[lvl - 1] * 60 * 60);
                     }
                     break;
               }
            }
            if(GLOBAL._harvesterOverdrive >= GLOBAL.Timestamp() && GLOBAL._harvesterOverdrivePower.Get() > 0)
            {
               _resources.r1Rate *= GLOBAL._harvesterOverdrivePower.Get();
               _resources.r2Rate *= GLOBAL._harvesterOverdrivePower.Get();
               _resources.r3Rate *= GLOBAL._harvesterOverdrivePower.Get();
               _resources.r4Rate *= GLOBAL._harvesterOverdrivePower.Get();
            }
            if(_yardType % 2 == MAIN_YARD)
            {
               n = 1;
               while(n < 5)
               {
                  _resources["r" + n + "max"] *= GLOBAL._upgradePacking;
                  _resources["r" + n + "max"] = Math.floor(_resources["r" + n + "max"]);
                  if(GLOBAL._mode == "build" && _yardType % 2 == MAIN_YARD)
                  {
                     GLOBAL._yardResources["r" + n + "max"] = _resources["r" + n + "max"];
                     GLOBAL._yardResources["r" + n + "Rate"] = _resources["r" + n + "Rate"];
                  }
                  n++;
               }
            }
            if(GLOBAL._mode == "build")
            {
               j = 1;
               while(j < 5)
               {
                  if(Boolean(GLOBAL._advancedMap) && !BASE.isInferno())
                  {
                     GLOBAL._resources["r" + j + "max"] = GLOBAL._yardResources["r" + j + "max"] + GLOBAL._mapOutpost.length * GLOBAL._outpostCapacity.Get();
                     _resources["r" + j + "max"] = GLOBAL._resources["r" + j + "max"];
                  }
                  else
                  {
                     GLOBAL._resources["r" + j + "max"] = GLOBAL._yardResources["r" + j + "max"];
                  }
                  j++;
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","Base.CalcResources: " + e.message + " | " + e.getStackTrace());
         }
         UI2.Update();
      }
      
      public static function CalcBaseValue() : Number
      {
         var baseValue:Number = NaN;
         var i:* = undefined;
         var building:* = undefined;
         var buildingLvl:* = undefined;
         var costs:* = undefined;
         baseValue = 0;
         for(i in _buildingsAll)
         {
            try
            {
               building = _buildingsAll[i];
               if(building._class != "decoration" && building._class != "enemy" && building._class != "immovable" && building._class != "trap" && (isOutpost || building._countdownBuild.Get() <= 0))
               {
                  buildingLvl = building._lvl.Get();
                  if(buildingLvl <= 0)
                  {
                     buildingLvl = 1;
                  }
                  costs = GLOBAL._buildingProps[building._type - 1].costs[buildingLvl - 1];
                  baseValue += costs.time + costs.r1 + costs.r2 + costs.r3 + costs.r4;
               }
            }
            catch(e:Error)
            {
               LOGGER.Log("err","BASE.CalcBaseValue bad bdg" + _buildingsAll[i]._type + " " + _buildingsAll[i]._lvl.Get());
            }
         }
         baseValue = Math.ceil(baseValue / 10);
         if(_yardType % 2 == OUTPOST)
         {
            _outpostValue = baseValue;
         }
         if(baseValue > _baseValue && _yardType % 2 == MAIN_YARD)
         {
            _baseValue = baseValue;
         }
         return baseValue;
      }
      
      public static function PointsAdd(param1:uint) : *
      {
         _basePoints = Math.floor(_basePoints + param1);
      }
      
      public static function BaseLevel() : Object
      {
         var points:Number = NaN;
         var lvl:Object = null;
         var levels:Array = null;
         var i:int = 0;
         var mc:popup_levelup = null;
         var title:String = null;
         var body:String = null;
         var StreamPost:Function = null;
         CalcBaseValue();
         points = _basePoints + Number(_baseValue);
         lvl = {
            "level":0,
            "lower":0,
            "upper":0,
            "leveled":false
         };
         levels = [0,15 * 60,3500,5000,125 * 60,175 * 60,245 * 60,343 * 60,28812,40337,56472,79060,110684,154958,216941,303717,425204,595286,833401,1166761,1633465,2286851,3201591,4482228,0x5fc02f,8785167,12299234,17218927,24106498,33749097,47248736,66148230,92607522,129650530,181510743,254115040,355761056,498065478,697291669,976208337,1366691671,1913368339,2678715675,3750201945,5250282723,7350395812,10290554137,14406775792,20169486109,28237280553,39532192774,55345069884,77483097838,108476336973,151866871762,212613620467,297659068653];
         i = 0;
         while(i < levels.length - 1)
         {
            if(points >= levels[i])
            {
               lvl.level = i + 1;
               lvl.lower = levels[i];
               lvl.upper = levels[i + 1];
               lvl.needed = lvl.upper - points;
               lvl.points = points;
            }
            i++;
         }
         if(GLOBAL._render && lvl.level > _baseLevel && lvl.level > 1 && GLOBAL._mode == "build")
         {
            if(_baseLevel > 0)
            {
               lvl.leveled = true;
               if(TUTORIAL._stage > 200)
               {
                  StreamPost = function(param1:MouseEvent):*
                  {
                     GLOBAL.CallJS("sendFeed",["levelup" + lvl.level,KEYS.Get(title,{"v1":lvl.level}),KEYS.Get(body),"levelup/levelup" + lvl.level + ".v2.png"]);
                     POPUPS.Next();
                  };
                  mc = new popup_levelup();
                  title = "pop_levelup_streamtitle";
                  body = "pop_levelup_body";
                  if(BASE.isInferno())
                  {
                     title = "inf_pop_levelup_streamtitle";
                     body = "inf_pop_levelup_body";
                  }
                  mc.title_txt.htmlText = "<b>" + KEYS.Get("pop_levelup_title") + "</b>";
                  mc.headline_txt.htmlText = KEYS.Get("pop_levelup_headline",{"v1":lvl.level});
                  mc.body_txt.htmlText = KEYS.Get("pop_levelup_body");
                  mc.bPost.SetupKey("btn_brag");
                  mc.bPost.addEventListener(MouseEvent.CLICK,StreamPost);
                  mc.bPost.Highlight = true;
                  POPUPS.Push(mc,null,null,"levelup","levelup.v2.png");
               }
            }
            _baseLevel = lvl.level;
            LOGGER.Stat([33,_baseLevel]);
         }
         if(lvl.leveled)
         {
            BASE.Save();
            if(Chat._bymChat)
            {
               Chat._bymChat.broadcastDisplayNameUpdate(lvl.level);
            }
         }
         if(GLOBAL._mode == "build")
         {
            LOGIN._playerLevel = lvl.level;
         }
         return lvl;
      }
      
      public static function GetBuildingOverlap(param1:Number, param2:Number, param3:Number, param4:Vector.<BFOUNDATION>) : void
      {
         var _loc5_:Point = null;
         var _loc6_:* = undefined;
         var _loc7_:BFOUNDATION = null;
         var _loc8_:Point = null;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         _loc5_ = new Point(param1,param2);
         for(_loc6_ in _buildingsAll)
         {
            _loc7_ = BASE._buildingsAll[_loc6_];
            _loc8_ = new Point(_loc7_._mc.x,_loc7_._mc.y + _loc7_._middle);
            _loc9_ = Math.atan2(_loc5_.y - _loc8_.y,_loc5_.x - _loc8_.x);
            _loc10_ = EllipseEdgeDistance(_loc9_,param3,param3 * _angle);
            _loc9_ = Math.atan2(_loc8_.y - _loc5_.y,_loc8_.x - _loc5_.x);
            _loc11_ = EllipseEdgeDistance(_loc9_,_loc7_._size * 0.5,_loc7_._size * 0.5 * _angle);
            _loc12_ = _loc5_.x - _loc8_.x;
            _loc13_ = _loc5_.y - _loc8_.y;
            _loc14_ = int(Math.sqrt(_loc12_ * _loc12_ + _loc13_ * _loc13_));
            if(_loc14_ < _loc10_ + _loc11_)
            {
               param4.push(_loc7_);
            }
         }
      }
      
      public static function BuildingOverlap(param1:Point, param2:int, param3:Boolean, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false) : Boolean
      {
         var _loc7_:* = undefined;
         var _loc8_:BFOUNDATION = null;
         var _loc9_:Point = null;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         for(_loc7_ in _buildingsAll)
         {
            _loc8_ = BASE._buildingsAll[_loc7_];
            _loc9_ = new Point(_loc8_._mc.x,_loc8_._mc.y + _loc8_._middle);
            if(!(param3 && _loc8_._class == "trap" || param4 && _loc8_._hp.Get() <= 0 || param5 && _loc8_._class == "decoration" || param6 && (_loc8_._class == "immovable" || _loc8_._class == "enemy")))
            {
               _loc10_ = Math.atan2(param1.y - _loc9_.y,param1.x - _loc9_.x);
               _loc11_ = EllipseEdgeDistance(_loc10_,param2,param2 * _angle);
               _loc10_ = Math.atan2(_loc9_.y - param1.y,_loc9_.x - param1.x);
               _loc12_ = EllipseEdgeDistance(_loc10_,_loc8_._size * 0.5,_loc8_._size * 0.5 * _angle);
               _loc13_ = param1.x - _loc9_.x;
               _loc14_ = param1.y - _loc9_.y;
               _loc15_ = int(Math.sqrt(_loc13_ * _loc13_ + _loc14_ * _loc14_));
               if(_loc15_ < _loc11_ + _loc12_)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function EllipseEdgeDistance(param1:Number, param2:int, param3:int) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         _loc4_ = Math.pow(Math.pow(param2 / 2,-2) + Math.pow(Math.tan(param1),2) * Math.pow(param3 / 2,-2),-0.5);
         _loc5_ = param1 * 180 / Math.PI;
         if(_loc5_ < -90 || _loc5_ > 90)
         {
            _loc4_ *= -1;
         }
         _loc6_ = Math.tan(param1) * _loc4_;
         return Math.sqrt(_loc4_ * _loc4_ + _loc6_ * _loc6_);
      }
      
      public static function WallIntersects(param1:Point, param2:Point) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         _loc3_ = false;
         for(_loc13_ in _buildingsAll)
         {
            _loc12_ = _buildingsAll[_loc13_];
            if(!(_loc12_ == param1 || _loc12_ == param2))
            {
               _loc4_ = _loc12_._size / 2 + 8;
               _loc5_ = (param2.x - param1.x) * (param2.x - param1.x) + (param2.y - param1.y) * (param2.y - param1.y);
               _loc6_ = 2 * ((param2.x - param1.x) * (param1.x - _loc12_.x) + (param2.y - param1.y) * (param1.y - _loc12_.y));
               _loc7_ = _loc12_.x * _loc12_.x + _loc12_.y * _loc12_.y + param1.x * param1.x + param1.y * param1.y - 2 * (_loc12_.x * param1.x + _loc12_.y * param1.y) - _loc4_ * _loc4_;
               _loc8_ = _loc6_ * _loc6_ - 4 * _loc5_ * _loc7_;
               if(_loc8_ > 0)
               {
                  _loc9_ = Math.sqrt(_loc8_);
                  _loc10_ = (-_loc6_ + _loc9_) / (2 * _loc5_);
                  _loc11_ = (-_loc6_ - _loc9_) / (2 * _loc5_);
                  if((_loc10_ < 0 || _loc10_ > 1) && (_loc11_ < 0 || _loc11_ > 1))
                  {
                     if(!(_loc10_ < 0 && _loc11_ < 0 || _loc10_ > 1 && _loc11_ > 1))
                     {
                        _loc3_ = 1;
                     }
                  }
                  else
                  {
                     _loc3_ = 1;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public static function InsideCircle(param1:Point, param2:int) : *
      {
         return true;
      }
      
      public static function HideBuildingStats() : *
      {
         var _loc1_:String = null;
         var _loc2_:Object = null;
         if(_buildingStatsToggle)
         {
            _buildingStatsToggle = false;
            for(_loc1_ in _buildingsAll)
            {
               _loc2_ = _buildingsAll[_loc1_];
               _loc2_.HideInfo();
            }
         }
      }
      
      public static function applyTemplate(param1:BaseTemplate) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BaseTemplateNode = null;
         var _loc4_:Point = null;
         var _loc5_:BFOUNDATION = null;
         _loc2_ = 0;
         while(_loc2_ < param1.nodes.length)
         {
            _loc3_ = param1.nodes[_loc2_];
            _loc4_ = GRID.ToISO(_loc3_.x,_loc3_.y,0);
            _loc5_ = getBuildingFromNode(_loc3_);
            if(_loc5_)
            {
               _loc5_.moveTo(_loc4_.x,_loc4_.y);
            }
            _loc2_++;
         }
      }
      
      private static function getBuildingFromNode(param1:BaseTemplateNode) : BFOUNDATION
      {
         var _loc3_:BFOUNDATION = null;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc2_:Point = GRID.ToISO(param1.x,param1.y,0);
         if(param1.id == PlannerTemplate._DECORATION_ID)
         {
            _loc4_ = int(param1.type);
            _loc3_ = addBuildingC(_loc4_);
            _loc5_ = {
               "X":param1.x,
               "Y":param1.y,
               "t":_loc4_,
               "id":BASE._buildingCount++
            };
            _loc3_.Setup(_loc5_);
            param1.id = _loc3_._id;
            _buildingsStored["b" + _loc4_].Set(_buildingsStored["b" + _loc4_].Get() - 1);
         }
         else
         {
            _loc3_ = getBuildingByID(param1.id);
         }
         return _loc3_;
      }
      
      public static function getTemplate() : BaseTemplate
      {
         var _loc1_:BaseTemplate = null;
         var _loc2_:BFOUNDATION = null;
         var _loc3_:Point = null;
         _loc1_ = new BaseTemplate();
         _loc1_.name = _baseName;
         for each(_loc2_ in _buildingsAll)
         {
            if(!isBuildingIgnoredInYardPlanner(_loc2_))
            {
               _loc3_ = GRID.FromISO(_loc2_.x,_loc2_.y);
               _loc1_.addNode(new BaseTemplateNode(_loc3_.x,_loc3_.y,_loc2_._id,_loc2_._type));
            }
         }
         return _loc1_;
      }
      
      public static function isBuildingIgnoredInYardPlanner(param1:BFOUNDATION) : Boolean
      {
         var _loc2_:* = 0;
         _loc2_ = uint(param1._type);
         return _loc2_ == 27 || _loc2_ == 127 || param1._class == "enemy";
      }
      
      public static function getBuildingByID(param1:uint) : BFOUNDATION
      {
         var _loc2_:BFOUNDATION = null;
         for each(_loc2_ in _buildingsAll)
         {
            if(_loc2_._id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function RebuildTH() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Point = null;
         var _loc3_:BFOUNDATION = null;
         if(_yardType)
         {
            return;
         }
         CalcBaseValue();
         if(BASE._basePoints + BASE._baseValue >= 2000000)
         {
            _loc1_ = CaluclateExpectedTownHallLevel();
            if(GLOBAL._bTownhall)
            {
               if(GLOBAL._bTownhall._lvl.Get() < _loc1_)
               {
                  if(GLOBAL._bTownhall._countdownUpgrade.Get() > 0)
                  {
                     GLOBAL._bTownhall.Upgraded();
                     _loc1_ = CaluclateExpectedTownHallLevel();
                  }
                  if(GLOBAL._bTownhall._lvl.Get() < _loc1_)
                  {
                     GLOBAL._bTownhall._lvl.Set(_loc1_ - 1);
                     GLOBAL._bTownhall.Upgraded();
                  }
               }
            }
            else
            {
               _loc2_ = new Point(-800,-40);
               _loc3_ = BASE.addBuildingC(14);
               ++BASE._buildingCount;
               _loc3_.Setup({
                  "t":14,
                  "X":_loc2_.x,
                  "Y":_loc2_.y,
                  "id":BASE._buildingCount,
                  "l":_loc1_
               });
               _loc2_ = GRID.ToISO(_loc2_.x,_loc2_.y,0);
               MAP.FocusTo(_loc2_.x,_loc2_.y,2);
               GLOBAL.Message(KEYS.Get("msg_rebuildTH"));
            }
         }
      }
      
      private static function CaluclateExpectedTownHallLevel() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:BFOUNDATION = null;
         _loc1_ = 1;
         _loc2_ = 0;
         _loc3_ = 0;
         for each(_loc4_ in _buildingsTowers)
         {
            if(_loc4_._type == 20)
            {
               _loc3_++;
            }
            if(_loc4_._type == 21)
            {
               _loc2_++;
            }
         }
         if(QUESTS._global.brlvl >= 4 || QUESTS._global.b6lvl >= 2)
         {
            _loc1_ = 2;
         }
         if(QUESTS._global.brlvl >= 6 || QUESTS._global.b6lvl >= 4 || QUESTS._global.b15lvl >= 2 || _loc3_ >= 4 || _loc2_ >= 4)
         {
            _loc1_ = 3;
         }
         if(QUESTS._global.brlvl >= 8 || QUESTS._global.b6lvl >= 7 || QUESTS._global.b15lvl >= 3 || QUESTS._global.b23lvl >= 1 || QUESTS._global.b25lvl >= 1 || QUESTS._global.b19lvl > 0 || _loc3_ >= 5 || _loc2_ >= 5)
         {
            _loc1_ = 4;
         }
         if(QUESTS._global.brlvl == 10 || QUESTS._global.b6lvl >= 9 || QUESTS._global.b15lvl >= 4 || QUESTS._global.b23lvl >= 2 || QUESTS._global.b25lvl >= 2 || _loc3_ >= 6 || _loc2_ >= 6)
         {
            _loc1_ = 5;
         }
         if(QUESTS._global.b6lvl == 10 || QUESTS._global.b15lvl == 5 || QUESTS._global.b23lvl == 3 || QUESTS._global.b25lvl == 3)
         {
            _loc1_ = 6;
         }
         return _loc1_;
      }
      
      public static function isInferno() : Boolean
      {
         return BASE._yardType == BASE.INFERNO_OUTPOST || BASE._yardType == BASE.INFERNO_YARD;
      }
      
      public static function get isOutpost() : Boolean
      {
         return _yardType == OUTPOST;
      }
      
      public static function getEmpireResources(param1:int) : Number
      {
         var _loc2_:* = undefined;
         _loc2_ = 1;
         if(GLOBAL._harvesterOverdrive >= GLOBAL.Timestamp() && GLOBAL._harvesterOverdrivePower.Get() > 0)
         {
            _loc2_ = GLOBAL._harvesterOverdrivePower.Get();
         }
         return _GIP["r" + param1].Get() * 360 * _loc2_;
      }
      
      public static function HasRequirements(param1:Object) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         for each(_loc2_ in param1.re)
         {
            _loc3_ = 0;
            if(_loc2_[0] == INFERNOQUAKETOWER.UNDERHALL_ID)
            {
               if(GLOBAL.StatGet(BUILDING14.UNDERHALL_LEVEL) >= _loc2_[2] && MAPROOM_DESCENT.DescentPassed)
               {
                  _loc3_ = 1;
               }
            }
            else
            {
               for each(_loc4_ in _buildingsAll)
               {
                  if(_loc4_._type == _loc2_[0] && _loc4_._lvl.Get() >= _loc2_[2])
                  {
                     _loc3_++;
                  }
               }
            }
            if(_loc3_ < _loc2_[1])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function isInfernoBuilding(param1:uint) : Boolean
      {
         return (param1 == INFERNOQUAKETOWER.TYPE || param1 == INFERNO_MAGMA_TOWER.ID || param1 == SiegeFactory.ID || param1 == SiegeLab.ID) && !BASE.isInferno();
      }
      
      public static function hasNumBuildings(param1:int, param2:int = 0, param3:Boolean = false) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:BFOUNDATION = null;
         _loc4_ = param1;
         _loc5_ = param2;
         _loc6_ = 0;
         for each(_loc7_ in _buildingsAll)
         {
            if(_loc7_._type == _loc4_ && _loc7_._lvl.Get() >= _loc5_)
            {
               _loc6_++;
               if(param3)
               {
                  break;
               }
            }
         }
         return _loc6_;
      }
      
      public static function findBuilding(param1:int) : BFOUNDATION
      {
         var _loc2_:int = 0;
         var _loc3_:BFOUNDATION = null;
         var _loc4_:BFOUNDATION = null;
         _loc2_ = param1;
         for each(_loc4_ in _buildingsAll)
         {
            if(_loc4_._type == _loc2_)
            {
               _loc3_ = _loc4_;
               break;
            }
         }
         return _loc3_;
      }
      
      public static function isInfernoCreep(param1:String) : Boolean
      {
         return param1.substring(0,1) == "I";
      }
      
      public static function FindClosestHousingToPoint(param1:int, param2:int, param3:BFOUNDATION = null, param4:Boolean = true, param5:Boolean = true) : BFOUNDATION
      {
         var _loc6_:Array = null;
         var _loc7_:BFOUNDATION = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         _loc6_ = [];
         for each(_loc7_ in BASE._buildingsHousing)
         {
            if(_loc7_ != param3)
            {
               if(!(param4 == true && _loc7_._countdownBuild.Get() > 0))
               {
                  if(!(param5 == true && _loc7_._hp.Get() <= 0))
                  {
                     _loc8_ = _loc7_.x - param1;
                     _loc9_ = _loc7_.y - param2;
                     _loc10_ = int(Math.sqrt(_loc8_ * _loc8_ + _loc9_ * _loc9_));
                     _loc6_.push({
                        "house":_loc7_,
                        "dist":_loc10_
                     });
                  }
               }
            }
         }
         if(_loc6_.length == 0)
         {
            return null;
         }
         _loc6_.sortOn(["dist"],Array.NUMERIC);
         return _loc6_[0].house;
      }
   }
}

