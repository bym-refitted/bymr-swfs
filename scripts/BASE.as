package
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import com.monsters.ai.TRIBES;
   import com.monsters.ai.WMBASE;
   import com.monsters.display.BuildingOverlay;
   import com.monsters.effects.ResourceBombs;
   import com.monsters.effects.fire.Fire;
   import com.monsters.effects.particles.ParticleDamage;
   import com.monsters.effects.smoke.Smoke;
   import com.monsters.maproom_advanced.MapRoom;
   import com.monsters.maproom_advanced.MapRoomCell;
   import com.monsters.maproom_advanced.PopupLostMainBase;
   import com.monsters.pathing.PATHING;
   import com.monsters.radio.RADIO;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.*;
   import flash.utils.getTimer;
   import gs.*;
   import gs.easing.*;
   
   public class BASE
   {
      public static var _baseID:int;
      
      public static var _wmID:int;
      
      public static var _resources:Object;
      
      public static var _hpResources:Object;
      
      public static var _bankedValue:int;
      
      public static var _bankedTime:int;
      
      public static var _shakeCountdown:int;
      
      public static var _blockSave:Boolean;
      
      public static var _attackerArray:Array;
      
      public static var _attackerNameArray:Array;
      
      public static var _deltaResources:Object;
      
      public static var _hpDeltaResources:Object;
      
      public static var _savedDeltaResources:Object;
      
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
      
      public static var _buildingsMain:Object;
      
      public static var _buildingsCatchup:Object;
      
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
      
      public static var _loadedFBID:int;
      
      public static var _baseLevel:int;
      
      public static var _baseValue:uint;
      
      public static var _basePoints:Number;
      
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
      
      public static var _isSanctuary:int;
      
      public static var _isFan:int;
      
      public static var _isBookmarked:int;
      
      public static var _installsGenerated:int;
      
      public static var _ownerName:String;
      
      public static var _ownerPic:String;
      
      public static var _pendingPurchase:Array;
      
      public static var _pendingPromo:int;
      
      public static var _salePromoTime:int;
      
      public static var _loadBase:Array;
      
      public static var _percentDamaged:int;
      
      public static var _userID:int;
      
      public static var _damagedBaseWarnTime:Number;
      
      public static var _takeoverFirstOpen:int;
      
      public static var _takeoverPreviousOwnersName:String;
      
      private static var _tmpPercent:Number;
      
      public static var _loadedOutpost:int = 0;
      
      public static var _isOutpost:int = 0;
      
      public static var _userDigits:Array = [];
      
      public static var _guardianData:Object = null;
      
      private static var _loadedSomething:Boolean = false;
      
      public function BASE()
      {
         super();
         _baseID = 0;
         Setup();
         Load();
      }
      
      public static function Setup() : *
      {
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
         _isProtected = 0;
         _isSanctuary = 0;
         _isFan = 0;
         _isBookmarked = 0;
         _installsGenerated = 0;
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
         _loadBase = [];
         GLOBAL.Clear();
      }
      
      public static function Cleanup() : *
      {
         var _loc1_:BFOUNDATION = null;
         CREATURES.Clear();
         CREEPS.Clear();
         GLOBAL._ROOT.removeChild(GLOBAL._layerMap);
         GLOBAL._ROOT.removeChild(GLOBAL._layerUI);
         GLOBAL._ROOT.removeChild(GLOBAL._layerWindows);
         GLOBAL._ROOT.removeChild(GLOBAL._layerMessages);
         GLOBAL._ROOT.removeChild(GLOBAL._layerTop);
         GLOBAL._layerMap = GLOBAL._ROOT.addChild(new MovieClip());
         GLOBAL._layerUI = GLOBAL._ROOT.addChild(new MovieClip());
         GLOBAL._layerWindows = GLOBAL._ROOT.addChild(new MovieClip());
         GLOBAL._layerMessages = GLOBAL._ROOT.addChild(new MovieClip());
         GLOBAL._layerTop = GLOBAL._ROOT.addChild(new MovieClip());
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
         _buildingsCatchup = {};
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
      
      public static function LoadBase(param1:String = null, param2:int = 0, param3:int = 0, param4:String = "build", param5:Boolean = false) : *
      {
         if(Boolean(GLOBAL._advancedMap) && MapRoom._open)
         {
            MapRoom.Hide();
         }
         if(!GLOBAL._advancedMap && param4 == "attack" && GLOBAL._mode != "build")
         {
            return;
         }
         if(!_loading)
         {
            GLOBAL._reloadonerror = param5;
            if(param3 == 0 && param2 == 0)
            {
               param4 = "build";
            }
            if((param4 == "attack" || param4 == "wmattack") && (!GLOBAL._advancedMap && (!GLOBAL._bFlinger || !GLOBAL._bFlinger._canFunction)))
            {
               LOGGER.Log("err","Impossible fling");
               GLOBAL.ErrorMessage();
               return false;
            }
            _loadBase = [param1,param2,param3,param4];
            if(!GLOBAL._advancedMap && (param4 == "attack" || param4 == "wmattack"))
            {
               PLEASEWAIT.Show(KEYS.Get("msg_preparing"));
               BASE.Save(0,false,true);
            }
            else if(!_saving)
            {
               if(param4 == "attack" || param4 == "wmattack")
               {
               }
               LoadBaseB();
            }
         }
      }
      
      public static function LoadBaseB() : *
      {
         GLOBAL.Message("LoadBaseB vars:" + com.adobe.serialization.json.JSON.encode(_loadBase));
         GLOBAL._baseURL2 = _loadBase[0];
         var _loc1_:int = int(_loadBase[1]);
         var _loc2_:int = int(_loadBase[2]);
         var _loc3_:String = _loadBase[3];
         _loadBase = [];
         GLOBAL.Setup(_loc3_);
         Load(GLOBAL._baseURL2,_loc1_,_loc2_);
      }
      
      public static function Load(param1:String = null, param2:int = 0, param3:int = 0) : *
      {
         var t:*;
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
         var userid:int = param2;
         var baseid:int = param3;
         handleLoadSuccessful = function(param1:Object):*
         {
            var TauntB:Function;
            var onImageLoad:Function;
            var LoadImageError:Function;
            var idstr:String = null;
            var ix:int = 0;
            var r:Object = null;
            var bd:Object = null;
            var i:String = null;
            var kx:int = 0;
            var id:String = null;
            var ooo:Object = null;
            var st:String = null;
            var attacksArr:Array = null;
            var attackCount:int = 0;
            var attackObj:Object = null;
            var found:Boolean = false;
            var listed:Object = null;
            var popupMC:popup_attackedme = null;
            var loader:Loader = null;
            var d:int = 0;
            var txt:* = undefined;
            var popupMClike:popup_like = null;
            var promoTimer:int = 0;
            var promoItemsArr:Array = null;
            var obj:Object = param1;
            if(obj.error == 0)
            {
               if(!_loadedSomething)
               {
                  ExternalInterface.call("cc.recordStats","baseend");
                  _loadedSomething = true;
               }
               if(GLOBAL._mode == "build")
               {
                  GLOBAL._openBase = null;
               }
               GLOBAL.SetFlags(obj.flags);
               QUESTS.Setup();
               GLOBAL._reloadonerror = false;
               _isProtected = int(obj.name_1);
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
                  GLOBAL._chatServers = obj.chatservers;
               }
               else
               {
                  GLOBAL._chatServers = new Array();
               }
               if(obj.chatenabled != null)
               {
                  GLOBAL._chatEnabled = obj.chatenabled;
                  if(GLOBAL.flagsShouldChatExist())
                  {
                     GLOBAL.initChat();
                  }
               }
               else
               {
                  GLOBAL._chatEnabled = 0;
               }
               _lastSaveID = obj.id;
               _baseSeed = obj.baseseed;
               _loadedBaseID = obj.baseid;
               if(GLOBAL._mode == "build")
               {
                  _loadedFriendlyBaseID = obj.baseid;
                  _loadedOutpost = _isOutpost;
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
               _attackID = int(obj.attackid);
               if(obj.worldsize)
               {
                  MapRoom._mapWidth = obj.worldsize[0];
                  MapRoom._mapHeight = obj.worldsize[1];
               }
               if(obj.usemap)
               {
                  GLOBAL._advancedMap = obj.usemap;
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
                           GLOBAL._mapHome = new Point(obj.homebase[0],obj.homebase[1]);
                           if(obj.outposts)
                           {
                              GLOBAL._mapOutpost = [];
                              ix = 0;
                              while(ix < obj.outposts.length)
                              {
                                 if(obj.outposts[ix].length == 2)
                                 {
                                    GLOBAL._mapOutpost.push(new Point(obj.outposts[ix][0],obj.outposts[ix][1]));
                                 }
                                 ix++;
                              }
                           }
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
               _resources.r1 = new SecNum(int(r.r1));
               _resources.r2 = new SecNum(int(r.r2));
               _resources.r3 = new SecNum(int(r.r3));
               _resources.r4 = new SecNum(int(r.r4));
               if(Boolean(obj.updates) && obj.updates.length > 0)
               {
                  UPDATES.Process(obj.updates);
               }
               else
               {
                  UPDATES._lastUpdateID = int(obj.lastupdate);
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
                     if(Boolean(_isOutpost) && (GLOBAL._currentCell && GLOBAL._currentCell._base == 3))
                     {
                        LOGGER.Log("err","Base ID " + _loadedBaseID + " outpost w TH bdg");
                        GLOBAL.ErrorMessage();
                     }
                     break;
                  }
                  if(bd.t == 112)
                  {
                     if(!_isOutpost && (GLOBAL._currentCell && GLOBAL._currentCell._base != 3))
                     {
                        LOGGER.Log("err","Base ID " + _loadedBaseID + " yard w OP bdg");
                        GLOBAL.ErrorMessage();
                     }
                     break;
                  }
               }
               _baseName = obj.basename;
               _baseValue = uint(obj.basevalue);
               _basePoints = Number(obj.points);
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
               if(obj.stats.updateid)
               {
                  GLOBAL._whatsnewid = obj.stats.updateid;
               }
               GLOBAL._otherStats = {"s":1};
               if(obj.stats.other)
               {
                  GLOBAL._otherStats = obj.stats.other;
               }
               if(obj.wmid)
               {
                  _wmID = obj.wmid;
               }
               ACADEMY.Data(obj.academy);
               if(GLOBAL._mode == "build" && !_isOutpost)
               {
                  GLOBAL._playerCreatureUpgrades = com.adobe.serialization.json.JSON.decode("{\"C1\":{\"level\":1},\"C2\":{\"level\":1}}");
                  for(id in ACADEMY._upgrades)
                  {
                     GLOBAL._playerCreatureUpgrades[id] = {"level":ACADEMY._upgrades[id].level};
                     if(ACADEMY._upgrades[id].powerup)
                     {
                        GLOBAL._playerCreatureUpgrades[id].powerup = ACADEMY._upgrades[id].powerup;
                     }
                  }
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
               WMBASE.Data(obj.wmstatus);
               WMATTACK.Setup(obj.aiattacks);
               if(GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview")
               {
                  WMBASE.Setup();
               }
               TUTORIAL.Setup();
               if(GLOBAL._mode == "build")
               {
                  TUTORIAL._stage = int(obj.tutorialstage);
               }
               WORKERS.Setup();
               QUEUE.Setup();
               STORE.Data(obj.storeitems,obj.storedata,obj.inventory);
               CREATURELOCKER.Data(obj.lockerdata);
               QUESTS.Data(obj.quests);
               MAPROOM.Setup();
               MONSTERBAITER.Setup(obj.monsterbaiter);
               _guardianData = null;
               if(obj.champion)
               {
                  if(obj.champion != "\"null\"" && obj.champion != "null")
                  {
                     ooo = com.adobe.serialization.json.JSON.decode(obj.champion);
                     try
                     {
                        if(ooo.t)
                        {
                           _guardianData = {};
                           if(ooo.nm)
                           {
                              _guardianData.nm = ooo.nm;
                           }
                           _guardianData.t = ooo.t;
                           if(ooo.ft)
                           {
                              _guardianData.ft = ooo.ft;
                           }
                           if(ooo.fd)
                           {
                              _guardianData.fd = ooo.fd;
                           }
                           else
                           {
                              _guardianData.fd = 0;
                           }
                           if(ooo.l)
                           {
                              _guardianData.l = new SecNum(ooo.l);
                           }
                           else
                           {
                              _guardianData.l = new SecNum(0);
                           }
                           if(ooo.hp)
                           {
                              _guardianData.hp = new SecNum(ooo.hp);
                           }
                           else
                           {
                              _guardianData.hp = new SecNum(0);
                           }
                        }
                     }
                     catch(e:Error)
                     {
                        st = com.adobe.serialization.json.JSON.decode(obj.champion);
                        _guardianData = com.adobe.serialization.json.JSON.decode(st);
                     }
                     if(GLOBAL._mode == "build" && !_isOutpost && Boolean(_guardianData))
                     {
                        GLOBAL._playerGuardianData = {};
                        if(_guardianData.nm)
                        {
                           GLOBAL._playerGuardianData.nm = _guardianData.nm;
                        }
                        if(_guardianData.t)
                        {
                           GLOBAL._playerGuardianData.t = _guardianData.t;
                        }
                        if(_guardianData.ft)
                        {
                           GLOBAL._playerGuardianData.ft = _guardianData.ft;
                        }
                        if(_guardianData.fn)
                        {
                           GLOBAL._playerGuardianData.fn = _guardianData.fn;
                        }
                        else
                        {
                           GLOBAL._playerGuardianData.fn = 0;
                        }
                        if(_guardianData.l)
                        {
                           GLOBAL._playerGuardianData.l = new SecNum(_guardianData.l.Get());
                        }
                        else
                        {
                           GLOBAL._playerGuardianData.l = new SecNum(0);
                        }
                        if(_guardianData.hp)
                        {
                           GLOBAL._playerGuardianData.hp = new SecNum(_guardianData.hp.Get());
                        }
                        else
                        {
                           GLOBAL._playerGuardianData.hp = new SecNum(0);
                        }
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
                        GLOBAL.CallJS("sendFeed",["tauntB","YOU attacked my yard!?! Remember, revenge is a dish best served cold..."," ","taunt" + n + ".png",fbid]);
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
               try
               {
                  if(GLOBAL._mode == "build" && Boolean(GLOBAL._flags.fanfriendbookmarkquests))
                  {
                     if(BASE._isFan < 1)
                     {
                        if(GLOBAL._sessionCount == 20 || GLOBAL._sessionCount == 50 || GLOBAL._sessionCount == 100 || GLOBAL._sessionCount == 200 || GLOBAL._sessionCount == 500 || GLOBAL._sessionCount == 1000)
                        {
                           d = int((_currentTime - GLOBAL._addTime) / 86400);
                           txt = KEYS.Get("pop_nthvisit",{
                              "v1":GLOBAL.FormatNumber(GLOBAL._sessionCount),
                              "v2":d
                           });
                           if(d == 0)
                           {
                              txt += "<b>" + KEYS.Get("pop_firstday") + "</b>";
                           }
                           else if(int(GLOBAL._sessionCount / d) >= 5)
                           {
                              txt += "<b>" + KEYS.Get("pop_averagevisits",{"v1":int(GLOBAL._sessionCount / d)}) + "</b>";
                           }
                           txt += "<br><br>" + KEYS.Get("pop_likeus");
                           popupMClike = new popup_like();
                           popupMClike.tA.htmlText = txt;
                           POPUPS.Push(popupMClike,null,null,"","like.png");
                        }
                     }
                     else if(TUTORIAL._stage > 200 && GLOBAL.StatGet("popuprate") < 2 && GLOBAL._sessionCount < 1000)
                     {
                        GLOBAL.StatSet("popuprate",2);
                        POPUPS.DisplayRate();
                     }
                  }
               }
               catch(e:Error)
               {
                  LOGGER.Log("err","popup_like/rate " + e.getStackTrace());
               }
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
               _tempGifts = obj.gifts;
               if(obj.sentgifts)
               {
                  _tempSentGifts = obj.sentgifts;
               }
               else
               {
                  _tempSentGifts = [];
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
               if(GLOBAL._baseURL == "http://bmdev.fb.casualcollective.com/base/")
               {
                  GLOBAL._baseURL = "http://bmdev.fb.casualcollective.com/api/bm/base/";
               }
               else
               {
                  GLOBAL._baseURL = "http://bmdev.fb.casualcollective.com/base/";
               }
               BASE.Load();
            }
            else
            {
               GLOBAL.ErrorMessage(obj.error);
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
               GLOBAL.ErrorMessage("");
            }
         };
         GLOBAL.Message("Load userid:" + userid + " baseid:" + baseid + " force URL:" + url);
         GLOBAL._baseLoads += 1;
         t = getTimer();
         _loading = true;
         _baseID = baseid;
         _baseLevel = 0;
         _saveOver = 0;
         _returnHome = false;
         _saveProtect = 0;
         PLEASEWAIT.Hide();
         Cleanup();
         PLEASEWAIT.Show(KEYS.Get("msg_loading"));
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
         ParticleDamage.Clear();
         SPRITES.Clear();
         SPRITES.Setup();
         Fire.Clear();
         ResourceBombs.Data();
         GLOBAL._catchup = true;
         _mushroomList = [];
         _lastSpawnedMushroom = 0;
         _size = 400;
         tmpMode = GLOBAL._mode;
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
         if(!_loadedSomething)
         {
            ExternalInterface.call("cc.recordStats","basestart");
         }
         if(url)
         {
            new URLLoaderApi().load(url + "load",loadVars,handleLoadSuccessful,handleLoadError);
         }
         else
         {
            new URLLoaderApi().load(GLOBAL._baseURL + "load",loadVars,handleLoadSuccessful,handleLoadError);
         }
      }
      
      public static function Build() : *
      {
         var lm:int = 0;
         var tmpDO:DisplayObject = null;
         var t:* = undefined;
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
         var maxProcess:int = 0;
         PLEASEWAIT.Update(KEYS.Get("msg_building"));
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
            GLOBAL.ErrorMessage("BASE.Build A1: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
         }
         try
         {
            UI2.Setup();
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build A2: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
         }
         try
         {
            UI2.ResizeHandler();
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build A3: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
         }
         try
         {
            GLOBAL._render = false;
            PATHING.Setup();
            GRID.CreateGrid();
            t = getTimer();
            texture = "grass";
            if(Boolean(GLOBAL._currentCell) && (_isOutpost || GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview"))
            {
               texture = GLOBAL._currentCell._terrain;
            }
            m = new MAP(texture);
            QUEUE.Spawn(0);
            Smoke.Setup();
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build B: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
         }
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
                     if(o.t == 18)
                     {
                        o.t = 17;
                        o.l = 2;
                     }
                     b = addBuildingC(o.t);
                     tmpType = b._type;
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
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build C: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
            LOGGER.Log("err","BASE.Build building/monster processing.  ID: " + _loadedBaseID + " Outpost: " + _isOutpost);
         }
         try
         {
            if(count == 0)
            {
               if(_isOutpost)
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
               }
            }
            else if(!_isOutpost && !hasTownHall)
            {
               LOGGER.Log("err","Town Hall Missing");
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build D: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
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
                        LOGGER.Log("log","Too many buildings of type " + b._type);
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
            GLOBAL.ErrorMessage("BASE.Build E: " + e.message + " | " + e.getStackTrace() + " | " + tmpType);
            GLOBAL.ErrorMessage();
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
            GLOBAL.ErrorMessage("BASE.Build F: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
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
            else
            {
               maxProcess = 162 * 60 * 60;
               if(Boolean(GLOBAL._bTownhall) && GLOBAL._bTownhall._lvl.Get() == 7)
               {
                  maxProcess = 8 * 24 * 60 * 60;
               }
               if(_lastProcessed < _currentTime - maxProcess)
               {
                  _lastProcessed = _currentTime - maxProcess;
               }
            }
            Process();
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("BASE.Build G: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage();
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
               if(GLOBAL._mode == "build" && lootArray.length > 0)
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
                     LOGGER.Stat([18,1,Math.ceil(100 / _resources.r1max * int(_tempLoot.r1))]);
                  }
                  if(_tempLoot.r2)
                  {
                     LOGGER.Stat([17,2,int(_tempLoot.r2)]);
                     LOGGER.Stat([18,2,Math.ceil(100 / _resources.r2max * int(_tempLoot.r2))]);
                  }
                  if(_tempLoot.r3)
                  {
                     LOGGER.Stat([17,3,int(_tempLoot.r3)]);
                     LOGGER.Stat([18,3,Math.ceil(100 / _resources.r3max * int(_tempLoot.r3))]);
                  }
                  if(_tempLoot.r4)
                  {
                     LOGGER.Stat([17,4,int(_tempLoot.r4)]);
                     LOGGER.Stat([18,4,Math.ceil(100 / _resources.r4max * int(_tempLoot.r4))]);
                  }
               }
            }
            _baseLevel = BaseLevel().level;
            _bankedValue = 0;
            GLOBAL.t = _lastProcessed;
            _lastProcessedB = _lastProcessed;
            _catchupTime = _currentTime - _lastProcessed;
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
            GLOBAL.ErrorMessage("Base.Process " + e.message + " | " + e.getStackTrace());
         }
      }
      
      public static function ProcessB(param1:Event) : *
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:int = _lastProcessed + 10 * 60;
         if(CREEPS._creepCount > 0)
         {
            _loc2_ = _lastProcessed + 1;
         }
         if(_loc2_ > _currentTime)
         {
            _loc2_ = _currentTime;
         }
         _loc2_ = ProcessC(_loc2_);
         if(_loc2_ >= _currentTime)
         {
            GLOBAL._ROOT.removeEventListener(Event.ENTER_FRAME,ProcessB);
            _loc3_ = (getTimer() - _timer) / 1000;
            _currentTime += int(_loc3_);
            _loc4_ = 0;
            while(_loc4_ < int(_loc3_))
            {
               ProcessC(_loc2_);
               _loc4_++;
            }
            GLOBAL.t = _currentTime;
            ProcessD();
         }
      }
      
      public static function ProcessC(param1:int) : int
      {
         var building:BFOUNDATION = null;
         var s:String = null;
         var f:int = 0;
         var tower:BFOUNDATION = null;
         var targetTime:int = param1;
         var p:int = 0;
         var itemCount:int = 0;
         var t:* = getTimer();
         var time:int = _lastProcessed;
         while(time < targetTime)
         {
            try
            {
               GLOBAL.t = time;
               if(p == 60)
               {
                  STORE.ProcessPurchases();
                  p = 0;
               }
               else
               {
                  p++;
               }
            }
            catch(e:Error)
            {
               LOGGER.Log("err","BASE.ProcessC 1: " + GLOBAL._mode + " | " + _baseID + " | " + e.getStackTrace());
            }
            try
            {
               itemCount = 0;
               s = "";
               for each(building in _buildingsCatchup)
               {
                  s += building._type + ", ";
                  building.Tick();
                  itemCount++;
               }
               if(!_isOutpost)
               {
                  CREATURELOCKER.Tick();
                  ACADEMY.Tick();
               }
               WMATTACK.Tick();
               if(CREATURES._guardian)
               {
                  if(CREATURES._guardian.Tick())
                  {
                     MAP._BUILDINGTOPS.removeChild(CREATURES._guardian);
                     CREATURES._guardian.Clear();
                     CREATURES._guardian = null;
                  }
               }
            }
            catch(e:Error)
            {
               LOGGER.Log("err","BASE.ProcessC 2: " + GLOBAL._mode + " | " + _baseID + " | " + e.getStackTrace());
               GLOBAL.ErrorMessage();
            }
            try
            {
               if(CREEPS._creepCount > 0)
               {
                  GLOBAL._render = true;
                  PATHING.Tick();
                  itemCount++;
                  if(targetTime - time > 1)
                  {
                     _lastProcessed = time;
                     return _lastProcessed;
                  }
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
            }
            catch(e:Error)
            {
               LOGGER.Log("err","BASE.ProcessC 3: " + GLOBAL._mode + " | " + _baseID + " | " + e.getStackTrace());
            }
            try
            {
               EFFECTS.Tick();
               UPDATES.Check();
               if(!_isOutpost)
               {
                  MONSTERBAITER.Tick();
               }
            }
            catch(e:Error)
            {
               LOGGER.Log("err","BASE.ProcessC 4: " + GLOBAL._mode + " | " + _baseID + " | " + e.getStackTrace());
            }
            try
            {
               if(GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview")
               {
                  WMBASE.Tick();
               }
            }
            catch(e:Error)
            {
               LOGGER.Log("err","BASE.ProcessC 5: " + GLOBAL._mode + " | " + _baseID + " | " + e.getStackTrace());
            }
            time++;
         }
         try
         {
            if(CREEPS._creepCount == 0)
            {
               p = int(100 / (_currentTime - _lastProcessedB) * (_lastProcessed - _lastProcessedB));
               PLEASEWAIT.Update(KEYS.Get("msg_rendering") + p + "% ");
            }
            else
            {
               if(_tmpPercent < 100)
               {
                  _tmpPercent += 0.5;
               }
               PLEASEWAIT.Update("Crunching " + int(_tmpPercent) + "%");
            }
            _lastProcessed = targetTime;
            if(itemCount == 0)
            {
               _lastProcessed = _currentTime;
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BASE.ProcessC 5: " + GLOBAL._mode + " | " + _baseID + " | " + e.getStackTrace());
         }
         return targetTime;
      }
      
      public static function ProcessD() : *
      {
         var WhatsNewAction26:Function;
         var WhatsNewAction28:Function;
         var WhatsNewAction29:Function;
         var WhatsNewAction30:Function;
         var WhatsNewAction31:Function;
         var WhatsNewAction32:Function;
         var popupWhatsNewDisplayed:Function;
         var RepairAll:Function;
         var Action:Function;
         var BragA:Function;
         var BragB:Function;
         var building:BFOUNDATION = null;
         var bb:int = 0;
         var upgradeCount:int = 0;
         var helpedCount:int = 0;
         var damageCount:int = 0;
         var popupWhatsNew:MovieClip = null;
         var display:Boolean = false;
         var newWhatsnewid:int = 0;
         var helper:int = 0;
         var popupMCDamaged:popup_damaged = null;
         var popupMCmushroom:* = undefined;
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
            if(!_isOutpost)
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
         bb = 0;
         try
         {
            upgradeCount = 0;
            helpedCount = 0;
            if(!GLOBAL._flags.viximo)
            {
               if(!GLOBAL._displayedWhatsNew && !BASE._isOutpost && GLOBAL._mode == "build" && TUTORIAL._stage > 200 && GLOBAL._sessionCount >= 5)
               {
                  GLOBAL._displayedWhatsNew = true;
                  display = false;
                  newWhatsnewid = GLOBAL._whatsnewid;
                  if(GLOBAL._whatsnewid < 1026)
                  {
                     WhatsNewAction26 = function(param1:MouseEvent):*
                     {
                        BUILDINGS._buildingID = 114;
                        BUILDINGS.Show();
                        BUILDINGS._mc.SwitchB(3,1,0);
                        POPUPS.Next();
                     };
                     popupWhatsNew = new popup_whatsnew26();
                     newWhatsnewid = 1026;
                     display = true;
                     popupWhatsNew.bAction.Setup("Build Now");
                     popupWhatsNew.bAction.addEventListener(MouseEvent.CLICK,WhatsNewAction26);
                  }
                  else if(GLOBAL._whatsnewid < 1028)
                  {
                     WhatsNewAction28 = function(param1:MouseEvent):*
                     {
                        STORE.ShowB(4,1,["BLK2","BLK3","BLK4","BLK5"]);
                        POPUPS.Next();
                     };
                     popupWhatsNew = new popup_whatsnew28();
                     newWhatsnewid = 1028;
                     display = true;
                     popupWhatsNew.bAction.Setup("Upgrade Walls");
                     popupWhatsNew.bAction.addEventListener(MouseEvent.CLICK,WhatsNewAction28);
                  }
                  else if(GLOBAL._whatsnewid < 1029)
                  {
                     WhatsNewAction29 = function(param1:MouseEvent):*
                     {
                        BUILDINGS._buildingID = 117;
                        BUILDINGS.Show();
                        BUILDINGS._mc.SwitchB(3,1,0);
                        POPUPS.Next();
                     };
                     popupWhatsNew = new popup_whatsnew29();
                     newWhatsnewid = 1029;
                     display = true;
                     popupWhatsNew.bAction.Setup("Build Now");
                     popupWhatsNew.bAction.addEventListener(MouseEvent.CLICK,WhatsNewAction29);
                  }
                  else if(GLOBAL._whatsnewid < 1030)
                  {
                     WhatsNewAction30 = function(param1:MouseEvent):*
                     {
                        STORE.ShowB(4,1,["PRO1","PRO2","PRO3"]);
                        POPUPS.Next();
                     };
                     popupWhatsNew = new popup_whatsnew30();
                     newWhatsnewid = 1030;
                     display = true;
                     popupWhatsNew.bAction.Setup("Buy Now");
                     popupWhatsNew.bAction.addEventListener(MouseEvent.CLICK,WhatsNewAction30);
                  }
                  else if(GLOBAL._whatsnewid < 1031)
                  {
                     WhatsNewAction31 = function(param1:MouseEvent):*
                     {
                        STORE.ShowB(4,1,["MOD","MDOD","MSOD"]);
                        POPUPS.Next();
                     };
                     popupWhatsNew = new popup_whatsnew31();
                     newWhatsnewid = 1031;
                     display = true;
                     popupWhatsNew.bAction.Setup("Buy Now");
                     popupWhatsNew.bAction.addEventListener(MouseEvent.CLICK,WhatsNewAction31);
                  }
                  else if(GLOBAL._whatsnewid < 1032)
                  {
                     WhatsNewAction32 = function(param1:MouseEvent):*
                     {
                        BUILDINGS._buildingID = 118;
                        BUILDINGS.Show();
                        BUILDINGS._mc.SwitchB(3,1,0);
                        POPUPS.Next();
                     };
                     popupWhatsNew = new popup_whatsnew32();
                     newWhatsnewid = 1032;
                     display = true;
                     popupWhatsNew.bAction.Setup("Build Now");
                     popupWhatsNew.bAction.addEventListener(MouseEvent.CLICK,WhatsNewAction32);
                  }
                  if(display)
                  {
                     popupWhatsNewDisplayed = function():*
                     {
                        GLOBAL._whatsnewid = newWhatsnewid;
                     };
                     LOGGER.Stat([23]);
                     POPUPS.Push(popupWhatsNew,popupWhatsNewDisplayed,null,"","",true);
                  }
               }
            }
            damageCount = 0;
            for each(building in _buildingsAll)
            {
               building.Update(true);
               if(building._hp.Get() < building._hpMax.Get() && building._repairing == 0)
               {
                  damageCount++;
               }
               if(building._countdownBuild.Get() + building._countdownUpgrade.Get() > 0)
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
               popupMCDamaged = new popup_damaged();
               (popupMCDamaged.mcFrame as frame2).Setup(false);
               popupMCDamaged.title.htmlText = "<b>" + KEYS.Get("pop_damaged_title") + "</b>";
               popupMCDamaged.tA.htmlText = KEYS.Get("pop_damaged",{"v1":damageCount});
               popupMCDamaged.bAction.SetupKey("pop_damaged_repairall_btn");
               popupMCDamaged.bAction.addEventListener(MouseEvent.CLICK,RepairAll);
               popupMCDamaged.bAction.Highlight = true;
               POPUPS.Push(popupMCDamaged,null,null,null,"duct-tape.png");
               if(damageCount > 30)
               {
                  MARKETING.Show("catapult");
               }
            }
            if(!BASE._isOutpost && GLOBAL._mode == "build" && GLOBAL._sessionCount >= 2 && GLOBAL._sessionCount <= 20 && TUTORIAL._stage >= 200)
            {
               if(_mushroomList.length >= 10)
               {
                  LOGGER.Stat([39]);
                  popupMCmushroom = new popup_mushroomshiny();
                  popupMCmushroom.tTitle.htmlText = "<b>Did you know?</b>";
                  popupMCmushroom.tMessage.htmlText = "Your workers can pick the mushrooms<br>growing in your yard? <b>Some mushrooms uncover FREE Shiny!</b>";
                  POPUPS.Push(popupMCmushroom,null,null,null,"goldmushroom.png");
               }
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
            GLOBAL.ErrorMessage("");
         }
         try
         {
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
                  popupMCdamaged.body_txt.text = KEYS.Get("base_damaged_body",{"v1":BASE._ownerName});
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
                  GLOBAL.CallJS("sendFeed",["upgrade-mr","#fname# conquered a " + _takeoverPreviousOwnersName + " base!","In war, there are no unwounded monsters.","build-outpost.png"]);
                  POPUPS.Next();
               };
               POPUPS.DisplayGeneric("Veni, Vidi, Vici!","You destroyed a " + _takeoverPreviousOwnersName + " base. Take over their yard and expand your empire.","Brag to your friends","building-outpost.png",BragA);
            }
            else if(_takeoverFirstOpen == 2)
            {
               BragB = function():*
               {
                  GLOBAL.CallJS("sendFeed",["upgrade-mr","#fname# conquered " + _takeoverPreviousOwnersName + "\'s Outpost!","Veni, Vidi, Vici!","build-outpost.png"]);
                  POPUPS.Next();
               };
               POPUPS.DisplayGeneric("Veni, Vidi, Vici!","You destroyed " + _takeoverPreviousOwnersName + "\'s Outpost. Take over their yard and expand your empire.","Brag to your friends","building-outpost.png",BragB);
            }
         }
         _takeoverFirstOpen = 0;
         if(GLOBAL._mode == "build")
         {
            if(_isOutpost)
            {
               if(_buildingCount == 1)
               {
                  POPUPS.Push(new popup_prefab_help());
               }
            }
            else
            {
               MARKETING.Process();
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
               if(GLOBAL._mode == "build" && !GLOBAL._empireDestroyedShown && GLOBAL._advancedMap && !BASE._isOutpost && !WMATTACK._inProgress && (GLOBAL._mapOutpost.length == 0 || GLOBAL._empireDestroyed == 1) && hp < hpMax * 0.1)
               {
                  GLOBAL._empireDestroyedShown = true;
                  popupMCDestroyed = new PopupLostMainBase();
                  popupMCDestroyed.Setup();
                  POPUPS.Push(popupMCDestroyed,null,null,null,"base-destroyed.png");
               }
            }
         }
         if(GLOBAL._flags.showProgressBar == 1)
         {
            try
            {
               UI_PROGRESSBAR.ProcessBuildings(false);
            }
            catch(e:Error)
            {
               LOGGER.Log("err","PROCESS BASES " + e.getStackTrace);
            }
         }
      }
      
      public static function Tick() : *
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
               UI2._top.mcSave.gotoAndStop(2);
            }
            else
            {
               UI2._top.mcSave.gotoAndStop(1);
            }
            if(GLOBAL.Timestamp() % 10 == 0)
            {
               CHECKER.Check();
            }
            pageInterval = 25;
            if(GLOBAL._flags.pageinterval)
            {
               pageInterval = int(GLOBAL._flags.pageinterval);
            }
            if(_lastPaged >= pageInterval && !_paging && !_saving && GLOBAL.Timestamp() - _lastSaved >= pageInterval)
            {
               Page();
            }
            ++_lastPaged;
            if(GLOBAL._flags.showProgressBar == 1)
            {
               if(GLOBAL._mode == "build")
               {
                  UI_PROGRESSBAR.Update();
               }
            }
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
      }
      
      public static function Purchase(param1:String, param2:int, param3:String, param4:Boolean = false) : *
      {
         if(_pendingPurchase.length > 0)
         {
            GLOBAL.ErrorMessage(KEYS.Get("msg_err_purchase"));
            return false;
         }
         if(param2 <= 0)
         {
            GLOBAL.ErrorMessage();
            LOGGER.Log("err","BASE.Purchase Id " + param1 + ", illegal quantity " + param2 + ", possible hack");
            return false;
         }
         _pendingPurchase = [param1,param2,_saveCounterA + 1,param3,param4];
         BASE.Save();
      }
      
      public static function Save(param1:int = 0, param2:Boolean = false, param3:Boolean = false) : *
      {
         if(Boolean(UI2._top) && Boolean(UI2._top.mcSave))
         {
            UI2._top.mcSave.gotoAndStop(2);
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
      }
      
      public static function SaveB() : *
      {
         var saveOrder:Array;
         var loadVars:Array;
         var so:int;
         var tmpExport:Object = null;
         var handleLoadSuccessful:Function = null;
         var handleLoadError:Function = null;
         var o:* = undefined;
         var hp:int = 0;
         var hpMax:int = 0;
         var finishTime:int = 0;
         var i:* = undefined;
         var buildingString:String = null;
         var stats:Object = null;
         var r:Object = null;
         var tmpR:String = null;
         var creatures:Object = null;
         var hatcount:int = 0;
         var hatqueue:Array = null;
         var hatstage:Array = null;
         var hatid:Array = null;
         var catapult:int = 0;
         var flinger:int = 0;
         var building:BFOUNDATION = null;
         var s:String = null;
         var mm:Object = null;
         var storageString:String = null;
         var attackResults:Array = null;
         var attackString:String = null;
         var tmpM:String = null;
         var tmpQ:String = null;
         var _bn:String = null;
         var loadObjects:Object = null;
         var hatchery:BUILDING13 = null;
         var guardObj:Object = null;
         var attackresources:Object = null;
         var lootreport:Object = null;
         var guardAttObj:Object = null;
         var monsterUpdate:Array = null;
         var loot:Object = null;
         var cellContainer:Object = null;
         var cell:MapRoomCell = null;
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
               if(GLOBAL._mode != "build")
               {
                  ATTACK.CleanLoot();
               }
               if(_returnHome && param1.over == 1)
               {
                  LoadBase(null,0,0,"build");
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
                           _hpResources["r" + _loc2_] = param1.resources["r" + _loc2_];
                           if(GLOBAL._mode == "build")
                           {
                              GLOBAL._resources["r" + _loc2_].Set(param1.resources["r" + _loc2_]);
                              GLOBAL._hpResources["r" + _loc2_] = param1.resources["r" + _loc2_];
                           }
                        }
                        _loc2_++;
                     }
                  }
                  if(GLOBAL._mode != "build")
                  {
                     ATTACK.CleanLoot();
                     GLOBAL.CleanAttackersDeltaResources();
                  }
                  CleanDeltaResources();
               }
               _isProtected = int(param1.name_1);
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
               LOGGER.Log("err","Base.Save: " + com.adobe.serialization.json.JSON.encode(param1));
               GLOBAL.ErrorMessage();
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
               GLOBAL.ErrorMessage("");
            }
         };
         var t:int = getTimer();
         if(GLOBAL._halt)
         {
            return;
         }
         if(_blockSave || GLOBAL._mode == "view" || GLOBAL._mode == "help" || GLOBAL._mode == "wmview" || _loading)
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
            LOGGER.Log("err","Negative twigs reset");
            Fund(1,_resources.r1.Get() * -1,true);
         }
         if(_resources.r2.Get() < 0)
         {
            LOGGER.Log("err","Negative pebbles reset");
            Fund(2,_resources.r2.Get() * -1,true);
         }
         if(_resources.r3.Get() < 0)
         {
            LOGGER.Log("err","Negative putty reset");
            Fund(3,_resources.r3.Get() * -1,true);
         }
         if(_resources.r4.Get() < 0)
         {
            LOGGER.Log("err","Negative goo reset");
            Fund(4,_resources.r4.Get() * -1,true);
         }
         CalcBaseValue();
         try
         {
            t = getTimer();
            o = {};
            hp = 0;
            hpMax = 0;
            finishTime = 0;
            if(WORKERS._workers && WORKERS._workers.length > 0 && Boolean(WORKERS._workers[0].task))
            {
               finishTime = GLOBAL.Timestamp() + WORKERS._workers[0].task._countdownBuild.Get() + WORKERS._workers[0].task._countdownUpgrade.Get();
            }
            for(i in _buildingsAll)
            {
               building = _buildingsAll[i];
               if(!(building._class == "trap" && building._fired || building._type == 53 && building._expireTime < GLOBAL.Timestamp()))
               {
                  if(building._class != "wall")
                  {
                     if(GLOBAL._mode == "build")
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
            buildingString = com.adobe.serialization.json.JSON.encode(o);
            stats = {};
            stats.mp = int(QUESTS._global.mushroomspicked);
            stats.mg = int(QUESTS._global.goldmushroomspicked);
            stats.mob = int(QUESTS._global.monstersblended);
            stats.mobg = int(QUESTS._global.monstersblendedgoo);
            stats.moga = int(QUESTS._global.gift_accept);
            stats.updateid = GLOBAL._whatsnewid;
            stats.other = GLOBAL._otherStats;
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
            tmpR = com.adobe.serialization.json.JSON.encode(r);
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
                  flinger = building._lvl.Get();
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
            storageString = com.adobe.serialization.json.JSON.encode(o);
            attackResults = [];
            attackString = com.adobe.serialization.json.JSON.encode(attackResults);
            _mushroomList = [];
            for each(building in _buildingsMushrooms)
            {
               tmpExport = building.Export();
               _mushroomList.push([tmpExport.frame,tmpExport.X,tmpExport.Y]);
            }
            tmpM = com.adobe.serialization.json.JSON.encode({
               "l":_mushroomList,
               "s":int(_lastSpawnedMushroom)
            });
            tmpQ = com.adobe.serialization.json.JSON.encode(QUESTS._completed);
            _bn = GLOBAL._mode == "wmattack" ? TRIBES.TribeForBaseID(_wmID).name : _baseName;
            loadObjects = {
               "baseid":_baseID,
               "lastupdate":UPDATES._lastUpdateID,
               "resources":tmpR,
               "academy":com.adobe.serialization.json.JSON.encode(ACADEMY.Export()),
               "stats":com.adobe.serialization.json.JSON.encode(stats),
               "mushrooms":tmpM,
               "basename":_bn,
               "baseseed":_baseSeed,
               "buildingdata":buildingString,
               "researchdata":storageString,
               "lockerdata":com.adobe.serialization.json.JSON.encode(CREATURELOCKER._lockerData),
               "quests":tmpQ,
               "basevalue":_baseValue,
               "points":_basePoints,
               "tutorialstage":TUTORIAL._stage,
               "basesaveid":_lastSaveID,
               "clienttime":GLOBAL.Timestamp(),
               "monsters":com.adobe.serialization.json.JSON.encode(mm),
               "attacks":attackString,
               "monsterbaiter":com.adobe.serialization.json.JSON.encode(MONSTERBAITER.Export()),
               "version":GLOBAL._version,
               "aiattacks":com.adobe.serialization.json.JSON.encode(WMATTACK.Export()),
               "effects":EFFECTS._effectsJSON,
               "catapult":catapult,
               "flinger":flinger,
               "empirevalue":CalcBaseValue(),
               "inventory":STORE.InventoryExport()
            };
            if(GLOBAL._advancedMap)
            {
               loadObjects.monsters = com.adobe.serialization.json.JSON.encode(mm);
            }
            else
            {
               loadObjects.monsters = com.adobe.serialization.json.JSON.encode(HOUSING.Export());
            }
            if(_guardianData)
            {
               guardObj = {};
               if(_guardianData.nm)
               {
                  guardObj.nm = _guardianData.nm;
               }
               if(_guardianData.t)
               {
                  guardObj.t = _guardianData.t;
               }
               if(_guardianData.hp)
               {
                  guardObj.hp = _guardianData.hp.Get();
               }
               else
               {
                  guardObj.hp = 0;
               }
               if(_guardianData.l)
               {
                  guardObj.l = _guardianData.l.Get();
               }
               if(_guardianData.ft)
               {
                  guardObj.ft = _guardianData.ft;
               }
               if(_guardianData.fd)
               {
                  guardObj.fd = _guardianData.fd;
               }
               else
               {
                  guardObj.fd = 0;
               }
               loadObjects.champion = com.adobe.serialization.json.JSON.encode(guardObj);
            }
            else
            {
               loadObjects.champion = com.adobe.serialization.json.JSON.encode(null);
            }
            t = getTimer();
            if(GLOBAL._mode != "build")
            {
               _saveProtect = 0;
               if(!BASE._isOutpost)
               {
                  if(hp < hpMax * 0.5)
                  {
                     _saveProtect = 1;
                  }
                  if(hp < hpMax * 0.25)
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
                  "r4":ATTACK._savedDeltaLoot.r4.Get()
               };
               lootreport = {
                  "r1":ATTACK._loot.r1.Get(),
                  "r2":ATTACK._loot.r2.Get(),
                  "r3":ATTACK._loot.r3.Get(),
                  "r4":ATTACK._loot.r4.Get(),
                  "name":_ownerName
               };
               t = getTimer();
               loadObjects.attackreport = ATTACK.LogRead();
               loadObjects.protect = _saveProtect;
               loadObjects.attackid = _attackID;
               loadObjects.lootreport = com.adobe.serialization.json.JSON.encode(lootreport);
               if(GLOBAL._advancedMap == 0)
               {
                  loadObjects.attackcreatures = com.adobe.serialization.json.JSON.encode(AttackerCreaturesExport());
               }
               loadObjects.attackloot = com.adobe.serialization.json.JSON.encode(attackresources);
               if(Boolean(GLOBAL._playerGuardianData) && GLOBAL._playerGuardianData.t > 0)
               {
                  guardAttObj = {};
                  if(GLOBAL._playerGuardianData.nm)
                  {
                     guardAttObj.nm = GLOBAL._playerGuardianData.nm;
                  }
                  if(GLOBAL._playerGuardianData.t)
                  {
                     guardAttObj.t = GLOBAL._playerGuardianData.t;
                  }
                  if(GLOBAL._playerGuardianData.hp)
                  {
                     guardAttObj.hp = GLOBAL._playerGuardianData.hp.Get();
                  }
                  if(GLOBAL._playerGuardianData.l)
                  {
                     guardAttObj.l = GLOBAL._playerGuardianData.l.Get();
                  }
                  if(GLOBAL._playerGuardianData.ft)
                  {
                     guardAttObj.ft = GLOBAL._playerGuardianData.ft;
                  }
                  if(GLOBAL._playerGuardianData.fd)
                  {
                     guardAttObj.fd = GLOBAL._playerGuardianData.fd;
                  }
                  else
                  {
                     guardAttObj.fd = 0;
                  }
                  loadObjects.attackerchampion = com.adobe.serialization.json.JSON.encode(guardAttObj);
               }
               t = getTimer();
            }
            if(GLOBAL._advancedMap)
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
                  cell = cellContainer["cell"];
                  if(cell && cell._mine && Boolean(cell._resources))
                  {
                     if(Boolean(cell._flinger) && cell._flinger.Get() >= cellContainer["range"])
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
                           LOGGER.Log("err","BASE.Save:  Dirty Cell " + cell.X + "," + cell.Y + "does not check out before doing map update!  " + com.adobe.serialization.json.JSON.encode(cell._hpResources));
                        }
                     }
                  }
               }
               if(MapRoom._homeCell && MapRoom._homeCell._protected && CREEPS._flungGuardian)
               {
                  homeCellObject = {
                     "baseid":GLOBAL._homeBaseID,
                     "m":MapRoom._homeCell._hpMonsterData,
                     "p":1
                  };
                  MapRoom._homeCell._protected = 0;
                  monsterUpdate.push(homeCellObject);
               }
               loadObjects.monsterupdate = com.adobe.serialization.json.JSON.encode(monsterUpdate);
            }
            if(GIFTS._giftsAccepted.length > 0)
            {
               loadObjects.gifts = com.adobe.serialization.json.JSON.encode(GIFTS._giftsAccepted);
            }
            if(GIFTS._sentGiftsAccepted.length > 0)
            {
               loadObjects.sentgifts = com.adobe.serialization.json.JSON.encode(GIFTS._sentGiftsAccepted);
            }
            if(GIFTS._sentInvitesAccepted.length > 0)
            {
               loadObjects.sentinvites = com.adobe.serialization.json.JSON.encode(GIFTS._sentInvitesAccepted);
            }
            if(_pendingPurchase.length > 0)
            {
               purchaseArray = [_pendingPurchase[0],_pendingPurchase[1]];
               if(_pendingPurchase[0].substr(0,8) == "MUSHROOM")
               {
                  if(_pendingPurchase[1] > 1)
                  {
                     LOGGER.Log("log","HACK " + _pendingPurchase[0] + " " + _pendingPurchase[1]);
                     GLOBAL.ErrorMessage();
                     return;
                  }
                  ++GLOBAL._shinyShroomCount;
                  if(GLOBAL._shinyShroomCount > 30)
                  {
                     LOGGER.Log("log","Too many shiny shrooms in session");
                     GLOBAL.ErrorMessage();
                     return;
                  }
                  if(!GLOBAL._shinyShroomValid)
                  {
                     LOGGER.Log("log","Shiny shroom not validated");
                     GLOBAL.ErrorMessage();
                     return;
                  }
                  GLOBAL._shinyShroomValid = false;
               }
               if(_pendingPurchase[4])
               {
                  purchaseArray.push("inv=1");
               }
               loadObjects.purchase = com.adobe.serialization.json.JSON.encode(purchaseArray);
               _pendingPurchase = [];
            }
            loadObjects.timeplayed = int(GLOBAL._timePlayed);
            if(GLOBAL._mode == "wmattack")
            {
               if(GLOBAL._advancedMap == 0)
               {
                  loadObjects.type = "wm";
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
            else if(Boolean(_isOutpost) && GLOBAL._mode != "build")
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
            loadObjects.damage = _percentDamaged;
            if(_pendingPromo)
            {
               loadObjects.purchasecomplete = 1;
               _pendingPromo = 0;
            }
            GLOBAL._timePlayed = 0;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BASE.SaveB " + e.errorID + " | " + e.getStackTrace);
            GLOBAL.ErrorMessage();
         }
         saveOrder = ["baseid","lastupdate","resources","academy","stats","mushrooms","basename","baseseed","buildingdata","researchdata","lockerdata","quests","basevalue","points","tutorialstage","basesaveid","clienttime","monsters","attacks","monsterbaiter","version","attackreport","over","protect","monsterupdate","attackid","aiattacks","effects","catapult","flinger","gifts","sentgifts","sentinvites","purchase","inventory","timeplayed","destroyed","damage","type","attackcreatures","attackloot","lootreport","empirevalue","champion","attackerchampion","purchasecomplete"];
         loadVars = [];
         so = 0;
         while(so < saveOrder.length)
         {
            if(loadObjects.hasOwnProperty(saveOrder[so]))
            {
               loadVars.push([saveOrder[so],loadObjects[saveOrder[so]]]);
            }
            so += 1;
         }
         if(!GLOBAL._save)
         {
            _saving = false;
            _lastSaved = GLOBAL.Timestamp();
            return;
         }
         new URLLoaderApi().load(GLOBAL._baseURL + "save",loadVars,handleLoadSuccessful,handleLoadError);
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
               _isProtected = int(param1.name_1);
               _isFan = int(param1.fan);
               _isBookmarked = int(param1.bookmarked);
               _installsGenerated = int(param1.installsgenerated);
               if(GLOBAL._mode == "build" && param1.resources && _saveCounterA == _saveCounterB)
               {
                  if(param1.resources.r1 != _resources.r1.Get() || param1.resources.r2 != _resources.r2.Get() || param1.resources.r3 != _resources.r3.Get() || param1.resources.r4 != _resources.r4.Get())
                  {
                  }
                  _loc2_ = 1;
                  while(_loc2_ < 5)
                  {
                     if(param1.resources["r" + _loc2_])
                     {
                        _resources["r" + _loc2_].Set(param1.resources["r" + _loc2_]);
                        _hpResources["r" + _loc2_] = param1.resources["r" + _loc2_];
                        GLOBAL._resources["r" + _loc2_].Set(param1.resources["r" + _loc2_]);
                        GLOBAL._hpResources["r" + _loc2_] = param1.resources["r" + _loc2_];
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
               QUESTS.Check();
            }
            else
            {
               LOGGER.Log("err","Base.Page: " + com.adobe.serialization.json.JSON.encode(param1));
               GLOBAL.ErrorMessage("");
            }
         };
         handleLoadError = function(param1:IOErrorEvent):void
         {
            ++_pageErrors;
            _paging = false;
            _lastPaged = int(10 + int(Math.random() * 5));
            if(_pageErrors >= 6)
            {
               LOGGER.Log("err","Base.Page HTTP");
               GLOBAL.ErrorMessage("");
            }
         };
         var t:int = getTimer();
         var tmpMode:String = GLOBAL._mode;
         if(tmpMode == "wmattack")
         {
            tmpMode = "attack";
         }
         if(tmpMode == "wmview")
         {
            tmpMode = "view";
         }
         _paging = true;
         new URLLoaderApi().load(GLOBAL._baseURL + "updatesaved",[["baseid",BASE._loadedBaseID],["version",GLOBAL._version],["lastupdate",UPDATES._lastUpdateID],["type",tmpMode]],handleLoadSuccessful,handleLoadError);
      }
      
      public static function BuildingStorageAdd(param1:int) : *
      {
         if(!_buildingsStored["b" + param1])
         {
            _buildingsStored["b" + param1] = new SecNum(0);
         }
         _buildingsStored["b" + param1].Add(1);
      }
      
      public static function BuildingStorageRemove(param1:int) : Boolean
      {
         if(_buildingsStored["b" + param1])
         {
            if(_buildingsStored["b" + param1].Get() >= 1)
            {
               _buildingsStored["b" + param1].Add(-1);
               return true;
            }
         }
         return false;
      }
      
      public static function BuildingStorageCount(param1:int) : int
      {
         if(_buildingsStored["b" + param1])
         {
            return _buildingsStored["b" + param1].Get();
         }
         return 0;
      }
      
      public static function CanBuild(param1:int) : Object
      {
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:BFOUNDATION = null;
         var _loc13_:Array = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:* = undefined;
         var _loc21_:int = 0;
         var _loc2_:Object = {};
         var _loc3_:Boolean = false;
         var _loc4_:String = "";
         var _loc5_:int = 0;
         if(GLOBAL._aiDesignMode)
         {
            return {"error":false};
         }
         for(_loc6_ in GLOBAL._buildingProps)
         {
            if(GLOBAL._buildingProps[_loc6_].id == param1)
            {
               _loc2_ = GLOBAL._buildingProps[_loc6_];
               break;
            }
         }
         if(TUTORIAL._stage < 200 && _loc2_.tutstage > TUTORIAL._stage)
         {
            _loc3_ = true;
            _loc4_ = KEYS.Get("base_builderr_locked");
         }
         else if(GLOBAL._mode == "build" && (_loc2_.type == "taunt" || _loc2_.type == "gift"))
         {
            _loc3_ = true;
            _loc4_ = KEYS.Get("base_builderr_ownyard1");
         }
         else if(GLOBAL._mode != "build" && _loc2_.type != "taunt" && _loc2_.type != "gift")
         {
            _loc3_ = true;
            _loc4_ = KEYS.Get("base_builderr_ownyard2");
         }
         else
         {
            _loc7_ = _loc2_.quantity;
            _loc8_ = 0;
            if(GLOBAL._bTownhall)
            {
               _loc8_ = GLOBAL._bTownhall._lvl.Get();
            }
            _loc9_ = int(_loc7_[_loc8_]);
            if(_loc2_.type == "decoration")
            {
               _loc10_ = _loc9_ = int(_loc7_[0]);
            }
            else
            {
               _loc10_ = _loc9_;
               if(_loc7_.length > _loc8_)
               {
                  _loc10_ = int(_loc7_[_loc8_ + 1]);
               }
            }
            if(_loc9_ == 0)
            {
               _loc11_ = 0;
               while(_loc11_ < _loc7_.length)
               {
                  if(_loc7_[_loc11_] > 0)
                  {
                     _loc3_ = true;
                     _loc4_ = KEYS.Get("base_builderr_thlevelreqd",{"v1":_loc11_});
                     break;
                  }
                  _loc11_++;
               }
            }
            else if(_loc2_.type != "decoration" || _loc2_.type == "decoration" && _loc2_.quantity[0] != 0)
            {
               _loc5_ = 0;
               for each(_loc12_ in BASE._buildingsAll)
               {
                  if(_loc12_._type == param1)
                  {
                     _loc5_++;
                  }
               }
               if(_loc5_ >= _loc9_)
               {
                  _loc3_ = true;
                  if(_loc10_ > _loc9_)
                  {
                     _loc4_ = KEYS.Get("base_builderr_uth");
                  }
                  else
                  {
                     _loc4_ = KEYS.Get("base_builderr_onlybuildx",{"v1":_loc9_});
                  }
               }
            }
         }
         if(!_loc3_)
         {
            _loc13_ = _loc2_.costs[0].re;
            _loc14_ = 0;
            _loc11_ = 0;
            while(_loc11_ < _loc13_.length)
            {
               _loc5_ = 0;
               for each(_loc12_ in BASE._buildingsAll)
               {
                  if(_loc12_._type == _loc13_[_loc11_][0] && _loc12_._lvl.Get() >= _loc13_[_loc11_][2])
                  {
                     _loc5_++;
                  }
               }
               if(_loc5_ >= _loc13_[_loc11_][1])
               {
                  _loc14_++;
               }
               _loc11_++;
            }
            if(_loc14_ < _loc13_.length)
            {
               _loc3_ = true;
               _loc4_ = "Requirements not met.";
            }
         }
         if(!_loc3_)
         {
            _loc15_ = int(_loc2_.costs[0].r1);
            _loc16_ = int(_loc2_.costs[0].r2);
            _loc17_ = int(_loc2_.costs[0].r3);
            _loc18_ = int(_loc2_.costs[0].r4);
            _loc19_ = 0;
            _loc21_ = 0;
            if(GLOBAL._mode == "build")
            {
               if(_loc15_ > BASE._resources.r1.Get())
               {
                  _loc20_ = 1;
                  _loc21_ = _loc15_ - BASE._resources.r1.Get();
               }
               if(_loc16_ > BASE._resources.r2.Get())
               {
                  _loc20_ = 2;
                  _loc21_ = _loc16_ - BASE._resources.r2.Get();
               }
               if(_loc17_ > BASE._resources.r3.Get())
               {
                  _loc20_ = 3;
                  _loc21_ = _loc17_ - BASE._resources.r3.Get();
               }
               if(_loc18_ > BASE._resources.r4.Get())
               {
                  _loc20_ = 4;
                  _loc21_ = _loc18_ - BASE._resources.r4.Get();
               }
               if(_loc20_ > 0)
               {
                  _loc3_ = true;
                  _loc4_ = "You need " + GLOBAL.FormatNumber(_loc21_) + " more " + KEYS.Get(GLOBAL._resourceNames[_loc20_ - 1]);
               }
            }
         }
         return {
            "error":_loc3_,
            "errorMessage":_loc4_,
            "needResource":_loc20_
         };
      }
      
      public static function CanUpgrade(param1:BFOUNDATION) : Object
      {
         var _loc7_:String = null;
         var _loc8_:* = undefined;
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
                        _loc9_.push([0,KEYS.Get("base_uperr_bdgpart1",{"v1":KEYS.Get(GLOBAL._buildingProps[_loc10_[0] - 1].name)})]);
                     }
                     else
                     {
                        _loc9_.push([0,KEYS.Get("base_uperr_bdgpart2",{
                           "v1":_loc10_[2],
                           "v2":KEYS.Get(GLOBAL._buildingProps[_loc10_[0] - 1].name)
                        })]);
                     }
                  }
                  else if(_loc10_[2] == 1)
                  {
                     _loc9_.push([0,KEYS.Get("base_uperr_bdgpart3",{
                        "v1":KEYS.Get(GLOBAL._buildingProps[_loc10_[0] - 1].name),
                        "v2":_loc10_[1]
                     })]);
                  }
                  else
                  {
                     _loc9_.push([0,KEYS.Get("base_uperr_bdgpart4",{
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
               _loc5_ = KEYS.Get("base_uperr_buildings",{"v1":GLOBAL.Array2StringB(_loc9_)});
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
                        _loc5_ = KEYS.Get("base_uperr_resources",{
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
      
      public static function addBuilding(param1:MouseEvent) : *
      {
         var _loc2_:* = param1.target.name.split("b")[1];
         return addBuildingB(_loc2_);
      }
      
      public static function addBuildingB(param1:int) : *
      {
         var _loc3_:Object = null;
         BuildingDeselect();
         var _loc2_:* = GLOBAL._buildingProps[param1 - 1].costs[0].time == 0;
         if(!_loc2_)
         {
            _loc2_ = QUEUE.CanDo().error == false;
         }
         if(BuildingStorageCount(param1) > 0)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc3_ = CanBuild(param1);
            if(!_loc3_.error)
            {
               BASE.BuildingDeselect();
               ShowFootprints();
               GLOBAL._newBuilding = addBuildingC(param1);
               GLOBAL._newBuilding.FollowMouse();
               return GLOBAL._newBuilding;
            }
            GLOBAL.Message(_loc3_.errorMessage);
         }
         else
         {
            POPUPS.DisplayWorker(0,param1);
         }
         return false;
      }
      
      public static function addBuildingC(param1:int) : BFOUNDATION
      {
         var _loc2_:BFOUNDATION = null;
         if(GLOBAL._buildingProps[param1 - 1].type == "decoration")
         {
            _loc2_ = new BDECORATION(param1);
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
            _loc2_ = new GUARDIANCAGE();
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
         return _loc2_;
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
         if(GLOBAL._mode == "build")
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
                  BUILDINGINFO.Show(param1);
               }
            }
         }
         else if(GLOBAL._mode == "help" || LOGIN._playerID == param1._senderid)
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
      
      public static function Charge(param1:int, param2:int, param3:Boolean = false) : int
      {
         if(param3)
         {
         }
         var _loc4_:Object = GLOBAL._mode == "build" ? _resources : GLOBAL._attackersResources;
         var _loc5_:Object = GLOBAL._mode == "build" ? _hpResources : GLOBAL._hpAttackersResources;
         if(param2 <= _loc4_["r" + param1].Get())
         {
            if(!param3)
            {
               _loc4_["r" + param1].Add(-param2);
               _loc5_["r" + param1] -= param2;
               if(GLOBAL._mode == "build")
               {
                  if(_deltaResources["r" + param1])
                  {
                     _deltaResources["r" + param1].Add(int(-param2));
                     _hpDeltaResources["r" + param1] += int(-param2);
                  }
                  else
                  {
                     _deltaResources["r" + param1] = new SecNum(int(-param2));
                     _hpDeltaResources["r" + param1] = int(-param2);
                  }
                  _deltaResources.dirty = true;
                  _hpDeltaResources.dirty = true;
                  GLOBAL._resources["r" + param1].Add(-param2);
                  GLOBAL._hpResources["r" + param1] -= param2;
               }
               else
               {
                  if(GLOBAL._attackersDeltaResources["r" + param1])
                  {
                     GLOBAL._attackersDeltaResources["r" + param1].Add(int(-param2));
                  }
                  else
                  {
                     GLOBAL._attackersDeltaResources["r" + param1] = new SecNum(int(-param2));
                  }
                  GLOBAL._attackersDeltaResources.dirty = true;
               }
               if(GLOBAL._mode == "build")
               {
               }
               CalcResources();
            }
            return param2;
         }
         return 0;
      }
      
      public static function Fund(param1:int, param2:int, param3:Boolean = false, param4:* = null) : *
      {
         var _loc5_:String = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         if(param1 < 5)
         {
            _loc5_ = "r" + param1;
            _loc6_ = "r" + param1 + "max";
            _loc7_ = 0;
            if(_resources[_loc5_].Get() < _resources[_loc6_] || param3)
            {
               if(_resources[_loc5_].Get() + param2 < _resources[_loc6_] || param3)
               {
                  _resources[_loc5_].Add(int(param2));
                  _hpResources[_loc5_] += int(param2);
                  if(_deltaResources[_loc5_])
                  {
                     _deltaResources[_loc5_].Add(int(param2));
                     _hpDeltaResources[_loc5_] += int(param2);
                  }
                  else
                  {
                     _deltaResources[_loc5_] = new SecNum(int(param2));
                     _hpDeltaResources[_loc5_] = int(param2);
                  }
                  if(GLOBAL._mode == "build")
                  {
                     GLOBAL._resources[_loc5_].Add(int(param2));
                     GLOBAL._hpResources[_loc5_] += int(param2);
                  }
                  _deltaResources.dirty = true;
                  _hpDeltaResources.dirty = true;
                  _loc7_ = param2;
               }
               else
               {
                  _loc7_ = _resources[_loc6_] - _resources[_loc5_].Get();
                  _resources[_loc5_].Set(_resources[_loc6_]);
                  _hpResources[_loc5_] = _resources[_loc6_];
                  if(_deltaResources[_loc5_])
                  {
                     _deltaResources[_loc5_].Add(int(_loc7_));
                     _hpDeltaResources[_loc5_] += int(_loc7_);
                  }
                  else
                  {
                     _deltaResources[_loc5_] = new SecNum(int(_loc7_));
                     _hpDeltaResources[_loc5_] = int(_loc7_);
                  }
                  if(GLOBAL._mode == "build")
                  {
                     GLOBAL._resources[_loc5_].Add(int(_loc7_));
                     GLOBAL._hpResources[_loc5_] += int(_loc7_);
                  }
                  _deltaResources.dirty = true;
                  _hpDeltaResources.dirty = true;
               }
               _bankedValue += _loc7_;
               _bankedTime = GLOBAL.Timestamp();
               if(GLOBAL._mode == "build")
               {
                  UI2._top.mc["mcR" + param1].x = -15;
                  TweenLite.to(UI2._top.mc["mcR" + param1],0.6,{
                     "x":0,
                     "ease":Elastic.easeOut
                  });
               }
            }
            else if(GLOBAL._mode == "build")
            {
               UI2._top.OverchargeShow(param1);
            }
            if(param4)
            {
               param4._stored.Add(-_loc7_);
               if(!param4._producing)
               {
                  param4.StartProduction();
               }
               param4.Update();
            }
            if(_loc7_ > 0 && GLOBAL._mode == "build")
            {
               Save();
            }
         }
         UI2.Update();
         return _loc7_;
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
                     GLOBAL.ErrorMessage();
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
         var _loc2_:String = null;
         _buildingCounts = {};
         var _loc1_:int = 0;
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
      
      public static function CalcResources() : *
      {
         var capacity:int = 0;
         var rM:String = null;
         var i:* = undefined;
         var building:BFOUNDATION = null;
         var bT:int = 0;
         var n:int = 0;
         var j:int = 0;
         try
         {
            if(_isOutpost)
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
            _resources.r1Rate = 0;
            _resources.r2Rate = 0;
            _resources.r3Rate = 0;
            _resources.r4Rate = 0;
            for(i in _buildingsAll)
            {
               building = _buildingsAll[i];
               bT = building._type;
               if(bT < 5)
               {
                  if(bT == 1)
                  {
                     if(Boolean(_isOutpost) && Boolean(GLOBAL._currentCell))
                     {
                        _resources.r1Rate += int(BRESOURCE.AdjustProduction(GLOBAL._currentCell,GLOBAL._buildingProps[bT - 1].produce[building._lvl.Get() - 1]) / GLOBAL._buildingProps[bT - 1].cycleTime[building._lvl.Get() - 1] * 60 * 60);
                     }
                     else
                     {
                        _resources.r1Rate += int(GLOBAL._buildingProps[bT - 1].produce[building._lvl.Get() - 1] / GLOBAL._buildingProps[bT - 1].cycleTime[building._lvl.Get() - 1] * 60 * 60);
                     }
                  }
                  else if(bT == 2)
                  {
                     if(Boolean(_isOutpost) && Boolean(GLOBAL._currentCell))
                     {
                        _resources.r2Rate += int(BRESOURCE.AdjustProduction(GLOBAL._currentCell,GLOBAL._buildingProps[bT - 1].produce[building._lvl.Get() - 1]) / GLOBAL._buildingProps[bT - 1].cycleTime[building._lvl.Get() - 1] * 60 * 60);
                     }
                     else
                     {
                        _resources.r2Rate += int(GLOBAL._buildingProps[bT - 1].produce[building._lvl.Get() - 1] / GLOBAL._buildingProps[bT - 1].cycleTime[building._lvl.Get() - 1] * 60 * 60);
                     }
                  }
                  else if(bT == 3)
                  {
                     if(Boolean(_isOutpost) && Boolean(GLOBAL._currentCell))
                     {
                        _resources.r3Rate += int(BRESOURCE.AdjustProduction(GLOBAL._currentCell,GLOBAL._buildingProps[bT - 1].produce[building._lvl.Get() - 1]) / GLOBAL._buildingProps[bT - 1].cycleTime[building._lvl.Get() - 1] * 60 * 60);
                     }
                     else
                     {
                        _resources.r3Rate += int(GLOBAL._buildingProps[bT - 1].produce[building._lvl.Get() - 1] / GLOBAL._buildingProps[bT - 1].cycleTime[building._lvl.Get() - 1] * 60 * 60);
                     }
                  }
                  else if(bT == 4)
                  {
                     if(Boolean(_isOutpost) && Boolean(GLOBAL._currentCell))
                     {
                        _resources.r4Rate += int(BRESOURCE.AdjustProduction(GLOBAL._currentCell,GLOBAL._buildingProps[bT - 1].produce[building._lvl.Get() - 1]) / GLOBAL._buildingProps[bT - 1].cycleTime[building._lvl.Get() - 1] * 60 * 60);
                     }
                     else
                     {
                        _resources.r4Rate += int(GLOBAL._buildingProps[bT - 1].produce[building._lvl.Get() - 1] / GLOBAL._buildingProps[bT - 1].cycleTime[building._lvl.Get() - 1] * 60 * 60);
                     }
                  }
               }
               else if(bT == 6 && building._lvl.Get() >= 1 && !_isOutpost)
               {
                  _resources.r1max += GLOBAL._buildingProps[bT - 1].capacity[building._lvl.Get() - 1];
                  _resources.r2max += GLOBAL._buildingProps[bT - 1].capacity[building._lvl.Get() - 1];
                  _resources.r3max += GLOBAL._buildingProps[bT - 1].capacity[building._lvl.Get() - 1];
                  _resources.r4max += GLOBAL._buildingProps[bT - 1].capacity[building._lvl.Get() - 1];
               }
            }
            if(GLOBAL._harvesterOverdrive >= GLOBAL.Timestamp() && GLOBAL._harvesterOverdrivePower.Get() > 0)
            {
               _resources.r1Rate *= GLOBAL._harvesterOverdrivePower.Get();
               _resources.r2Rate *= GLOBAL._harvesterOverdrivePower.Get();
               _resources.r3Rate *= GLOBAL._harvesterOverdrivePower.Get();
               _resources.r4Rate *= GLOBAL._harvesterOverdrivePower.Get();
            }
            if(!_isOutpost)
            {
               n = 1;
               while(n < 5)
               {
                  _resources["r" + n + "max"] *= GLOBAL._upgradePacking;
                  _resources["r" + n + "max"] = Math.ceil(_resources["r" + n + "max"]);
                  if(GLOBAL._mode == "build" && !_isOutpost)
                  {
                     GLOBAL._yardResources["r" + n + "max"] = _resources["r" + n + "max"];
                  }
                  n++;
               }
            }
            if(GLOBAL._mode == "build")
            {
               j = 1;
               while(j < 5)
               {
                  if(GLOBAL._advancedMap)
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
      
      public static function CalcBaseValue() : uint
      {
         var i:* = undefined;
         var building:* = undefined;
         var buildingLvl:* = undefined;
         var costs:* = undefined;
         var baseValue:uint = 0;
         for(i in _buildingsAll)
         {
            try
            {
               building = _buildingsAll[i];
               if(building._class != "decoration" && building._class != "enemy" && building._class != "immovable" && building._class != "trap" && building._countdownBuild.Get() <= 0)
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
         if(baseValue > _baseValue && !_isOutpost)
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
         var points:Number;
         var levels:Array;
         var i:int;
         var StreamPost:Function;
         var lvl:Object = null;
         var mc:popup_levelup = null;
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
                     GLOBAL.CallJS("sendFeed",["levelup" + lvl.level,KEYS.Get("pop_levelup_streamtitle",{"v1":lvl.level}),"","levelup/levelup" + lvl.level + ".png"]);
                     POPUPS.Next();
                  };
                  mc = new popup_levelup();
                  mc.title_txt.htmlText = "<b>" + KEYS.Get("pop_levelup_title") + "</b>";
                  mc.headline_txt.htmlText = KEYS.Get("pop_levelup_headline",{"v1":lvl.level});
                  mc.body_txt.htmlText = KEYS.Get("pop_levelup_body");
                  mc.bPost.SetupKey("btn_brag");
                  mc.bPost.addEventListener(MouseEvent.CLICK,StreamPost);
                  mc.bPost.Highlight = true;
                  POPUPS.Push(mc,null,null,"levelup","levelup.png");
               }
            }
            _baseLevel = lvl.level;
            LOGGER.Stat([33,_baseLevel]);
         }
         if(lvl.leveled)
         {
            BASE.Save();
            if(GLOBAL._bymChat)
            {
               GLOBAL._bymChat.broadcastDisplayNameUpdate(lvl.level);
            }
         }
         if(GLOBAL._mode == "build")
         {
            LOGIN._playerLevel = lvl.level;
         }
         return lvl;
      }
      
      public static function BuildingOverlap(param1:Point, param2:int, param3:Boolean, param4:Boolean = false, param5:Boolean = false) : Boolean
      {
         var _loc6_:* = undefined;
         var _loc7_:BFOUNDATION = null;
         var _loc8_:Point = null;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         for(_loc6_ in _buildingsAll)
         {
            _loc7_ = BASE._buildingsAll[_loc6_];
            _loc8_ = new Point(_loc7_._mc.x,_loc7_._mc.y + _loc7_._middle);
            if(!(param3 && _loc7_._class == "trap" || param4 && _loc7_._hp.Get() <= 0 || param5 && _loc7_._class == "decoration"))
            {
               _loc9_ = Math.atan2(param1.y - _loc8_.y,param1.x - _loc8_.x);
               _loc10_ = EllipseEdgeDistance(_loc9_,param2,param2 * _angle);
               _loc9_ = Math.atan2(_loc8_.y - param1.y,_loc8_.x - param1.x);
               _loc11_ = EllipseEdgeDistance(_loc9_,_loc7_._size * 0.5,_loc7_._size * 0.5 * _angle);
               _loc12_ = param1.x - _loc8_.x;
               _loc13_ = param1.y - _loc8_.y;
               _loc14_ = int(Math.sqrt(_loc12_ * _loc12_ + _loc13_ * _loc13_));
               if(_loc14_ < _loc10_ + _loc11_)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function EllipseEdgeDistance(param1:Number, param2:int, param3:int) : *
      {
         var _loc4_:* = Math.pow(Math.pow(param2 / 2,-2) + Math.pow(Math.tan(param1),2) * Math.pow(param3 / 2,-2),-0.5);
         var _loc5_:* = param1 * 180 / Math.PI;
         if(_loc5_ < -90 || _loc5_ > 90)
         {
            _loc4_ *= -1;
         }
         var _loc6_:* = Math.tan(param1) * _loc4_;
         return Math.sqrt(_loc4_ * _loc4_ + _loc6_ * _loc6_);
      }
      
      public static function WallIntersects(param1:Point, param2:Point) : *
      {
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
         var _loc3_:* = false;
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
      
      public static function RebuildTH() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Point = null;
         var _loc3_:BFOUNDATION = null;
         if(_isOutpost)
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
               GLOBAL.Message("<b>We found your missing Town Hall!</b><br><br>It\'s polished it up and ready to move back into your Yard. Don\'t leave it out in the cold, it will be prone to Attack!");
            }
         }
      }
      
      private static function CaluclateExpectedTownHallLevel() : int
      {
         var _loc4_:BFOUNDATION = null;
         var _loc1_:int = 1;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
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
   }
}

