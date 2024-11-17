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
   import com.monsters.maproom_advanced.MapRoomCell;
   import com.monsters.pathing.PATHING;
   import com.monsters.ui.UI_BOTTOM;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
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
      
      public static var _yardProps:Array;
      
      public static var _outpostProps:Array;
      
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
      
      public static var _currentCell:MapRoomCell;
      
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
      
      public static var _credits:SecNum;
      
      public static var _local:Boolean = false;
      
      public static var _save:Boolean = true;
      
      public static var _testKongregate:Boolean = false;
      
      public static var _localMode:int = 0;
      
      public static var _version:SecNum = new SecNum(118);
      
      public static var _aiDesignMode:Boolean = false;
      
      public static var _chatroomNumber:Number = 0;
      
      public static const NUM_CHAT_ROOMS:int = 5 * 60;
      
      public static var _chatInited:Boolean = false;
      
      public static var _chatEnabled:Boolean = true;
      
      public static var _validName:Boolean = true;
      
      public static var _checkPromo:int = 1;
      
      public static var _giveTips:int = 1;
      
      public static var _fluidWidthEnabled:Boolean = true;
      
      public static var _SCREENINIT:Rectangle = new Rectangle(0,0,760,750);
      
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
      
      public static var _playerGuardianData:Object = null;
      
      public static var _myMapRoom:int = 0;
      
      public static var _empireDestroyed:int = 0;
      
      public static var _empireDestroyedShown:Boolean = false;
      
      public static var _attackerMapCreatures:Object = {};
      
      public static var _attackerMapResources:Object = {};
      
      public static var _attackerCellsInRange:Array = [];
      
      public static var _attackerMapCreaturesStart:Object = {};
      
      public static var _attackerMapResourcesStart:Object = {};
      
      public static var _showMapWaiting:* = false;
      
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
      
      public static var _afktimer:SecNum = new SecNum(0);
      
      public static var _oldMousePoint:Point = new Point(0,0);
      
      public static var _otherStats:Object = {};
      
      public static var _baseLoads:int = 0;
      
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
         _yardProps = [{
            "id":1,
            "group":1,
            "order":1,
            "type":"resource",
            "name":"#b_twigsnapper#",
            "size":100,
            "cycle":30,
            "attackgroup":1,
            "tutstage":0,
            "sale":0,
            "description":"twigsnapper_desc",
            "costs":[{
               "r1":0,
               "r2":750,
               "r3":0,
               "r4":0,
               "time":15,
               "re":[[14,1,1]]
            },{
               "r1":0,
               "r2":1575,
               "r3":0,
               "r4":0,
               "time":5 * 60,
               "re":[[14,1,1]]
            },{
               "r1":0,
               "r2":55 * 60,
               "r3":0,
               "r4":0,
               "time":20 * 60,
               "re":[[14,1,1]]
            },{
               "r1":0,
               "r2":6950,
               "r3":0,
               "r4":0,
               "time":60 * 60,
               "re":[[14,1,2]]
            },{
               "r1":0,
               "r2":14500,
               "r3":0,
               "r4":0,
               "time":2 * 60 * 60,
               "re":[[14,1,2]]
            },{
               "r1":0,
               "r2":0x7788,
               "r3":0,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,3]]
            },{
               "r1":0,
               "r2":64300,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,3]]
            },{
               "r1":0,
               "r2":135000,
               "r3":0,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":0,
               "r2":283600,
               "r3":0,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":0,
               "r2":10 * 60 * 1000,
               "r3":0,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[14,1,5]]
            }],
            "imageData":{
               "baseurl":"buildings/twigsnapper.v2/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-4,10,23,33),34],
                  "top":["top.1.png",new Point(-30,-19)],
                  "shadow":["shadow.1.jpg",new Point(-23,29)],
                  "topdamaged":["top.1.damaged.png",new Point(-30,-19)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-28,28)],
                  "topdestroyed":["top.destroyed.png",new Point(-34,2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-31,20)]
               },
               "3":{
                  "anim":["anim.3.png",new Rectangle(0,6,23,30),34],
                  "top":["top.3.png",new Point(-32,-40)],
                  "shadow":["shadow.3.jpg",new Point(-38,11)],
                  "topdamaged":["top.3.damaged.png",new Point(-33,-37)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-27,25)],
                  "topdestroyed":["top.destroyed.png",new Point(-34,2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-31,20)]
               },
               "6":{
                  "anim":["anim.6.png",new Rectangle(-1,1,34,34),34],
                  "top":["top.6.png",new Point(-34,-42)],
                  "shadow":["shadow.6.jpg",new Point(-25,26)],
                  "topdamaged":["top.6.damaged.png",new Point(-35,-42)],
                  "shadowdamaged":["shadow.6.damaged.jpg",new Point(-28,25)],
                  "topdestroyed":["top.destroyed.png",new Point(-34,2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-31,20)]
               },
               "10":{
                  "anim":["anim.10.png",new Rectangle(-2,3,35,33),34],
                  "top":["top.10.png",new Point(-34,-54)],
                  "shadow":["shadow.10.jpg",new Point(-26,26)],
                  "topdamaged":["top.10.damaged.png",new Point(-35,-41)],
                  "shadowdamaged":["shadow.10.damaged.jpg",new Point(-28,22)],
                  "topdestroyed":["top.destroyed.png",new Point(-34,2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-31,20)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"1.1.jpg"},
               "3":{"img":"1.3.jpg"},
               "6":{"img":"1.6.jpg"},
               "10":{"img":"1.10.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"1.1.png"},
               "3":{"img":"1.3.png"},
               "6":{"img":"1.6.png"},
               "10":{"img":"1.10.png"}
            },
            "quantity":[0,1,2,4,5,6,6,6,6,6],
            "produce":[2,4,7,11,16,22,29,37,46,56],
            "cycleTime":[10,10,10,10,10,10,10,10,10,10],
            "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
            "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
            "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
         },{
            "id":2,
            "group":1,
            "order":2,
            "type":"resource",
            "name":"#b_pebbleshiner#",
            "size":100,
            "cycle":30,
            "attackgroup":1,
            "tutstage":0,
            "sale":0,
            "description":"pebbleshiner_desc",
            "costs":[{
               "r1":750,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":15,
               "re":[[14,1,1]]
            },{
               "r1":1575,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":5 * 60,
               "re":[[14,1,1]]
            },{
               "r1":55 * 60,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":20 * 60,
               "re":[[14,1,1]]
            },{
               "r1":6950,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":60 * 60,
               "re":[[14,1,2]]
            },{
               "r1":14500,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":2 * 60 * 60,
               "re":[[14,1,2]]
            },{
               "r1":0x7788,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,3]]
            },{
               "r1":64300,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,3]]
            },{
               "r1":135000,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":283600,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":10 * 60 * 1000,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[14,1,5]]
            }],
            "imageData":{
               "baseurl":"buildings/pebbleshiner.v2/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-21,8,42,24),26],
                  "top":["top.1.png",new Point(-34,-12)],
                  "shadow":["shadow.1.jpg",new Point(-33,27)],
                  "topdamaged":["top.1.damaged.png",new Point(-34,-6)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-31,27)],
                  "topdestroyed":["top.destroyed.png",new Point(-35,-2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-33,22)]
               },
               "3":{
                  "anim":["anim.3.png",new Rectangle(-29,3,58,31),26],
                  "top":["top.3.png",new Point(-34,-27)],
                  "shadow":["shadow.3.jpg",new Point(-33,27)],
                  "topdamaged":["top.3.damaged.png",new Point(-33,-26)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-31,22)],
                  "topdestroyed":["top.destroyed.png",new Point(-35,-2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-32,22)]
               },
               "6":{
                  "anim":["anim.6.png",new Rectangle(-29,-5,58,41),26],
                  "top":["top.6.png",new Point(-34,-34)],
                  "shadow":["shadow.6.jpg",new Point(-34,20)],
                  "topdamaged":["top.6.damaged.png",new Point(-45,-32)],
                  "shadowdamaged":["shadow.6.damaged.jpg",new Point(-34,20)],
                  "topdestroyed":["top.destroyed.png",new Point(-35,-2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-33,22)]
               },
               "10":{
                  "anim":["anim.10.png",new Rectangle(-29,-37,62,72),24],
                  "top":["top.10.png",new Point(-34,-32)],
                  "shadow":["shadow.10.jpg",new Point(-34,22)],
                  "topdamaged":["top.10.damaged.png",new Point(-34,-36)],
                  "shadowdamaged":["shadow.10.damaged.jpg",new Point(-34,15)],
                  "topdestroyed":["top.destroyed.png",new Point(-35,-2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-33,22)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"2.1.jpg"},
               "3":{"img":"2.3.jpg"},
               "6":{"img":"2.6.jpg"},
               "10":{"img":"2.10.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"2.1.png"},
               "3":{"img":"2.3.png"},
               "6":{"img":"2.6.png"},
               "10":{"img":"2.10.png"}
            },
            "quantity":[0,1,2,4,5,6,6,6,6,6],
            "produce":[2,4,7,11,16,22,29,37,46,56],
            "cycleTime":[10,10,10,10,10,10,10,10,10,10],
            "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
            "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
            "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
         },{
            "id":3,
            "group":1,
            "order":3,
            "type":"resource",
            "name":"#b_puttysquisher#",
            "size":100,
            "cycle":30,
            "attackgroup":1,
            "tutstage":80,
            "sale":0,
            "description":"puttysquisher_desc",
            "costs":[{
               "r1":525,
               "r2":224,
               "r3":0,
               "r4":0,
               "time":20,
               "re":[[14,1,1]]
            },{
               "r1":1102,
               "r2":470,
               "r3":0,
               "r4":0,
               "time":5 * 60,
               "re":[[14,1,1]]
            },{
               "r1":2315,
               "r2":992,
               "r3":0,
               "r4":0,
               "time":20 * 60,
               "re":[[14,1,1]]
            },{
               "r1":4862,
               "r2":2086,
               "r3":0,
               "r4":0,
               "time":60 * 60,
               "re":[[14,1,2]]
            },{
               "r1":10210,
               "r2":4375,
               "r3":0,
               "r4":0,
               "time":2 * 60 * 60,
               "re":[[14,1,2]]
            },{
               "r1":21441,
               "r2":9190,
               "r3":0,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,3]]
            },{
               "r1":45027,
               "r2":19298,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,3]]
            },{
               "r1":94557,
               "r2":40524,
               "r3":0,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":198570,
               "r2":85102,
               "r3":0,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":416997,
               "r2":178716,
               "r3":0,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[14,1,5]]
            }],
            "imageData":{
               "baseurl":"buildings/puttysquisher.v2/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-10,8,28,18),26],
                  "top":["top.1.png",new Point(-26,5)],
                  "shadow":["shadow.1.jpg",new Point(-21,29)],
                  "topdamaged":["top.1.damaged.png",new Point(-29,4)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-28,28)],
                  "topdestroyed":["top.destroyed.png",new Point(-39,5)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-36,21)]
               },
               "3":{
                  "anim":["anim.3.png",new Rectangle(-10,-7,29,20),26],
                  "top":["top.3.png",new Point(-28,-20)],
                  "shadow":["shadow.3.jpg",new Point(-33,18)],
                  "topdamaged":["top.3.damaged.png",new Point(-38,-20)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-37,26)],
                  "topdestroyed":["top.destroyed.png",new Point(-39,5)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-36,21)]
               },
               "6":{
                  "anim":["anim.6.png",new Rectangle(-10,-6,29,19),26],
                  "top":["top.6.png",new Point(-30,-43)],
                  "shadow":["shadow.6.jpg",new Point(-28,23)],
                  "topdamaged":["top.6.damaged.png",new Point(-28,-38)],
                  "shadowdamaged":["shadow.6.damaged.jpg",new Point(-29,25)],
                  "topdestroyed":["top.destroyed.png",new Point(-39,5)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-36,21)]
               },
               "10":{
                  "anim":["anim.10.png",new Rectangle(-10,-39,44,52),25],
                  "top":["top.10.png",new Point(-31,-42)],
                  "shadow":["shadow.10.jpg",new Point(-31,22)],
                  "topdamaged":["top.10.damaged.png",new Point(-40,-40)],
                  "shadowdamaged":["shadow.10.damaged.jpg",new Point(-38,24)],
                  "topdestroyed":["top.destroyed.png",new Point(-39,5)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-36,21)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"3.1.jpg"},
               "3":{"img":"3.3.v2.jpg"},
               "6":{"img":"3.6.v2.jpg"},
               "10":{"img":"3.10.v2.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"3.1.png"},
               "3":{"img":"3.3.png"},
               "6":{"img":"3.6.png"},
               "10":{"img":"3.10.png"}
            },
            "quantity":[0,1,2,4,5,6,6,6,6,6],
            "produce":[2,4,7,11,16,22,29,37,46,56],
            "cycleTime":[10,10,10,10,10,10,10,10,10,10],
            "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
            "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
            "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
         },{
            "id":4,
            "group":1,
            "order":4,
            "type":"resource",
            "name":"#b_goofactory#",
            "size":100,
            "cycle":30,
            "attackgroup":1,
            "tutstage":80,
            "sale":0,
            "description":"goofactory_desc",
            "costs":[{
               "r1":247,
               "r2":577,
               "r3":0,
               "r4":0,
               "time":20,
               "re":[[14,1,1]]
            },{
               "r1":520,
               "r2":1212,
               "r3":0,
               "r4":0,
               "time":5 * 60,
               "re":[[14,1,1]]
            },{
               "r1":1090,
               "r2":2546,
               "r3":0,
               "r4":0,
               "time":20 * 60,
               "re":[[14,1,1]]
            },{
               "r1":2290,
               "r2":5348,
               "r3":0,
               "r4":0,
               "time":60 * 60,
               "re":[[14,1,2]]
            },{
               "r1":4810,
               "r2":11231,
               "r3":0,
               "r4":0,
               "time":2 * 60 * 60,
               "re":[[14,1,2]]
            },{
               "r1":10108,
               "r2":23585,
               "r3":0,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,3]]
            },{
               "r1":21227,
               "r2":49529,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,3]]
            },{
               "r1":743 * 60,
               "r2":104012,
               "r3":0,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":26 * 60 * 60,
               "r2":218427,
               "r3":0,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":196584,
               "r2":458696,
               "r3":0,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[14,1,5]]
            }],
            "imageData":{
               "baseurl":"buildings/goofactory.v2/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(3,14,22,40),26],
                  "top":["top.1.png",new Point(-26,-33)],
                  "shadow":["shadow.1.jpg",new Point(-25,29)],
                  "topdamaged":["top.1.damaged.png",new Point(-32,-15)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-30,27)],
                  "topdestroyed":["top.destroyed.png",new Point(-31,0)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-35,24)]
               },
               "3":{
                  "anim":["anim.3.png",new Rectangle(4,12,25,45),26],
                  "top":["top.3.png",new Point(-27,-33)],
                  "shadow":["shadow.3.jpg",new Point(-31,21)],
                  "topdamaged":["top.3.damaged.png",new Point(-28,-31)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-31,20)],
                  "topdestroyed":["top.destroyed.png",new Point(-31,0)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-35,24)]
               },
               "6":{
                  "anim":["anim.6.png",new Rectangle(-21,12,51,48),26],
                  "top":["top.6.png",new Point(-33,-33)],
                  "shadow":["shadow.6.jpg",new Point(-26,27)],
                  "topdamaged":["top.6.damaged.png",new Point(-37,-29)],
                  "shadowdamaged":["shadow.6.damaged.jpg",new Point(-36,25)],
                  "topdestroyed":["top.destroyed.png",new Point(-31,0)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-35,24)]
               },
               "10":{
                  "anim":["anim.10.png",new Rectangle(-21,11,51,47),26],
                  "top":["top.10.png",new Point(-40,-48)],
                  "shadow":["shadow.10.jpg",new Point(-35,28)],
                  "topdamaged":["top.10.damaged.png",new Point(-45,-42)],
                  "shadowdamaged":["shadow.10.damaged.jpg",new Point(-37,25)],
                  "topdestroyed":["top.destroyed.png",new Point(-31,0)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-35,24)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"4.1.jpg"},
               "3":{"img":"4.3.jpg"},
               "6":{"img":"4.6.jpg"},
               "10":{"img":"4.10.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"4.1.png"},
               "3":{"img":"4.3.png"},
               "6":{"img":"4.6.png"},
               "10":{"img":"4.10.png"}
            },
            "quantity":[0,1,2,4,5,6,6,6,6,6],
            "produce":[2,4,7,11,16,22,29,37,46,56],
            "cycleTime":[10,10,10,10,10,10,10,10,10,10],
            "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
            "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
            "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
         },{
            "id":5,
            "group":2,
            "order":9,
            "type":"special",
            "name":"#b_flinger#",
            "size":190,
            "attackgroup":1,
            "tutstage":60,
            "sale":0,
            "description":"flinger_desc",
            "costs":[{
               "r1":1000,
               "r2":1000,
               "r3":500,
               "r4":0,
               "time":15 * 60,
               "re":[[14,1,1]]
            },{
               "r1":64300,
               "r2":64300,
               "r3":32150,
               "r4":0,
               "time":3 * 60 * 60,
               "re":[[14,1,3],[11,1,1]]
            },{
               "r1":283600,
               "r2":283600,
               "r3":141800,
               "r4":0,
               "time":9 * 60 * 60,
               "re":[[14,1,4],[11,1,1]]
            },{
               "r1":1247840,
               "r2":1247840,
               "r3":623920,
               "r4":0,
               "time":27 * 60 * 60,
               "re":[[14,1,4],[11,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/flinger/",
               "1":{
                  "top":["top.1.png",new Point(-46,-43)],
                  "shadow":["shadow.1.jpg",new Point(-50,20)],
                  "topdamaged":["top.1.damaged.png",new Point(-63,-36)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-63,23)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
               },
               "2":{
                  "top":["top.2.png",new Point(-45,-40)],
                  "shadow":["shadow.2.jpg",new Point(-48,19)],
                  "topdamaged":["top.2.damaged.png",new Point(-63,-18)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-63,26)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
               },
               "3":{
                  "top":["top.3.png",new Point(-47,-45)],
                  "shadow":["shadow.3.jpg",new Point(-44,20)],
                  "topdamaged":["top.3.damaged.png",new Point(-75,-37)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-73,23)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
               },
               "4":{
                  "top":["top.4.png",new Point(-45,-66)],
                  "shadow":["shadow.4.jpg",new Point(-47,22)],
                  "topdamaged":["top.4.damaged.png",new Point(-76,-53)],
                  "shadowdamaged":["shadow.4.damaged.jpg",new Point(-76,23)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"5.1.jpg"},
               "2":{"img":"5.2.jpg"},
               "3":{"img":"5.3.jpg"},
               "4":{"img":"5.4.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"5.1.png"},
               "2":{"img":"5.2.png"},
               "3":{"img":"5.3.png"},
               "4":{"img":"5.4.png"}
            },
            "quantity":[0,1,1,1,1,1,1,1,1,1],
            "capacity":[500,1000,1750,2250,50 * 60,0xfa0],
            "hp":[0xfa0,0x1f40,16000,28000],
            "repairTime":[100,5 * 60,10 * 60,15 * 60]
         },{
            "id":6,
            "group":1,
            "order":5,
            "type":"special",
            "name":"#b_storagesilo#",
            "size":2 * 60,
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"storagesilo_desc",
            "costs":[{
               "r1":3010,
               "r2":1855,
               "r3":0,
               "r4":0,
               "time":20 * 60,
               "re":[[14,1,1],[1,1,1],[2,1,1],[3,1,1],[4,1,1]]
            },{
               "r1":7421,
               "r2":3710,
               "r3":0,
               "r4":0,
               "time":30 * 60,
               "re":[[14,1,2]]
            },{
               "r1":14843,
               "r2":7421,
               "r3":0,
               "r4":0,
               "time":45 * 60,
               "re":[[14,1,2]]
            },{
               "r1":29687,
               "r2":14843,
               "r3":0,
               "r4":0,
               "time":4050,
               "re":[[14,1,3]]
            },{
               "r1":59375,
               "r2":29687,
               "r3":0,
               "r4":0,
               "time":6075,
               "re":[[14,1,3]]
            },{
               "r1":118750,
               "r2":59375,
               "r3":0,
               "r4":0,
               "time":9112,
               "re":[[14,1,3]]
            },{
               "r1":237500,
               "r2":118750,
               "r3":0,
               "r4":0,
               "time":13668,
               "re":[[14,1,4]]
            },{
               "r1":475000,
               "r2":237500,
               "r3":0,
               "r4":0,
               "time":20503,
               "re":[[14,1,4]]
            },{
               "r1":950000,
               "r2":475000,
               "r3":0,
               "r4":0,
               "time":30754,
               "re":[[14,1,5]]
            },{
               "r1":1900000,
               "r2":950000,
               "r3":0,
               "r4":0,
               "time":46132,
               "re":[[14,1,6]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":59375,
               "r2":29687,
               "r3":0,
               "r4":0,
               "time":60750,
               "re":[[14,1,5]]
            },{
               "r1":118750,
               "r2":59375,
               "r3":0,
               "r4":0,
               "time":91120,
               "re":[[14,1,6]]
            },{
               "r1":637500,
               "r2":518750,
               "r3":0,
               "r4":0,
               "time":136680,
               "re":[[14,1,7]]
            },{
               "r1":1475000,
               "r2":1237500,
               "r3":0,
               "r4":0,
               "time":205030,
               "re":[[14,1,8]]
            }],
            "imageData":{
               "baseurl":"buildings/storagesilo/",
               "1":{
                  "anim":["anim.3.png",new Rectangle(-37,-52,74,121),26],
                  "top":["top.3.png",new Point(-37,-52)],
                  "shadow":["shadow.3.jpg",new Point(-37,25)],
                  "topdamaged":["top.3.damaged.png",new Point(-37,-50)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-36,33)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-51,23)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-45,29)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"6.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"6.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,28)],
                  "back":["fort70_B1.png",new Point(-71,-4)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,26)],
                  "back":["fort70_B2.png",new Point(-65,-7)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-73,17)],
                  "back":["fort70_B3.png",new Point(-69,-5)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-3)],
                  "back":["fort70_B4.png",new Point(-62,-31)]
               }
            },
            "quantity":[0,1,2,3,4,5,5,5,5,6],
            "capacity":[125 * 60,250 * 60,500 * 60,60 * 1000,2 * 60 * 1000,4 * 60 * 1000,8 * 60 * 1000,16 * 60 * 1000,32 * 60 * 1000,64 * 60 * 1000],
            "hp":[750,1400,2550,4750,8800,16250,500 * 60,55600,105000,190000],
            "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
         },{
            "id":7,
            "group":999,
            "order":1,
            "type":"mushroom",
            "name":"#b_mushroom#",
            "size":10,
            "attackgroup":0,
            "tutstage":0,
            "sale":0,
            "description":"flag_desc",
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"7.png"}
            },
            "quantity":[0],
            "hp":[10],
            "repairTime":[10]
         },{
            "id":8,
            "group":2,
            "order":3,
            "type":"special",
            "name":"#b_monsterlocker#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"monsterlocker_desc",
            "costs":[{
               "r1":30 * 60,
               "r2":2300,
               "r3":0,
               "r4":0,
               "time":10 * 60,
               "re":[[14,1,2]]
            },{
               "r1":0x7080,
               "r2":18400,
               "r3":0,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,3]]
            },{
               "r1":32 * 60 * 60,
               "r2":147200,
               "r3":0,
               "r4":0,
               "time":20 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":128 * 60 * 60,
               "r2":588800,
               "r3":0,
               "r4":0,
               "time":36 * 60 * 60,
               "re":[[14,1,5]]
            }],
            "imageData":{
               "baseurl":"buildings/monsterlocker/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-42,-44,36,41),21],
                  "top":["top.1.png",new Point(-31,-29)],
                  "shadow":["shadow.1.jpg",new Point(-27,37)],
                  "topdamaged":["top.1.damaged.png",new Point(-38,-23)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-52,26)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-53,-41)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-52,25)]
               },
               "2":{
                  "anim":["anim.2.png",new Rectangle(-46,-93,61,69),20],
                  "top":["top.2.png",new Point(-51,-64)],
                  "shadow":["shadow.2.jpg",new Point(-40,18)],
                  "topdamaged":["top.2.damaged.png",new Point(-57,-47)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-52,26)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-53,-41)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-52,25)]
               },
               "3":{
                  "anim":["anim.3.png",new Rectangle(-48,-90,87,89),20],
                  "top":["top.3.png",new Point(-53,-79)],
                  "shadow":["shadow.3.jpg",new Point(-55,23)],
                  "topdamaged":["top.3.damaged.png",new Point(-54,-69)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-56,31)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-53,-41)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-52,25)]
               },
               "4":{
                  "anim":["anim.4.png",new Rectangle(-50,-91,92,89),21],
                  "top":["top.4.png",new Point(-54,-98)],
                  "shadow":["shadow.4.jpg",new Point(-54,30)],
                  "topdamaged":["top.4.damaged.png",new Point(-69,-78)],
                  "shadowdamaged":["shadow.4.damaged.jpg",new Point(-59,30)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-53,-41)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-52,25)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"8.1.jpg"},
               "2":{"img":"8.2.jpg"},
               "3":{"img":"8.3.jpg"},
               "4":{"img":"8.4.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"8.1.png"},
               "2":{"img":"8.2.png"},
               "3":{"img":"8.3.png"},
               "4":{"img":"8.4.png"}
            },
            "quantity":[0,0,1,1,1,1,1,1,1,1],
            "hp":[0xfa0,16000,32000,64000],
            "repairTime":[8 * 60,32 * 60,0xf00,256 * 60]
         },{
            "id":9,
            "group":2,
            "order":14,
            "type":"special",
            "name":"#b_monsterjuicer#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"monsterjuicer_desc",
            "costs":[{
               "r1":1000000,
               "r2":1000000,
               "r3":1000000,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,3],[15,1,1]]
            },{
               "r1":250000,
               "r2":250000,
               "r3":0,
               "r4":0,
               "time":6 * 60 * 60,
               "re":[[14,1,3],[15,1,1]]
            },{
               "r1":500000,
               "r2":500000,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,3],[15,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/monsterjuiceloosener/",
               "1":{
                  "anim":["anim.2.png",new Rectangle(-30,-17,60,39),51],
                  "top":["top.2.png",new Point(-44,-8)],
                  "shadow":["shadow.2.jpg",new Point(-44,16)],
                  "topdamaged":["top.2.damaged.png",new Point(-59,-8)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-59,21)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-55,0)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-49,17)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"9.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"9.png"}
            },
            "quantity":[0,0,0,1,1,1,1,1,1,1],
            "hp":[16000,32000,64000],
            "repairTime":[8 * 60,32 * 60,128 * 60]
         },{
            "id":10,
            "group":2,
            "order":13,
            "type":"special",
            "name":"#b_yardplanner#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"yardplanner_desc",
            "costs":[{
               "r1":250000,
               "r2":250000,
               "r3":0,
               "r4":0,
               "r5":0,
               "time":12 * 60 * 60,
               "re":[[14,1,3]]
            }],
            "imageData":{
               "baseurl":"buildings/yardplanner/",
               "1":{
                  "top":["top.1.png",new Point(-45,-29)],
                  "shadow":["shadow.1.jpg",new Point(-57,16)],
                  "topdamaged":["top.1.damaged.png",new Point(-58,-27)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-46,23)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-52,6)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-50,32)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"10.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"10.png"}
            },
            "quantity":[0,0,0,1,1,1,1,1,1,1],
            "hp":[16000],
            "repairTime":[0xf00]
         },{
            "id":11,
            "group":2,
            "order":11,
            "type":"special",
            "name":"#b_maproom#",
            "size":2 * 60,
            "attackgroup":1,
            "tutstage":80,
            "sale":0,
            "description":"maproom_desc",
            "costs":[{
               "r1":2000,
               "r2":2000,
               "r3":0,
               "r4":0,
               "time":15 * 60,
               "re":[[14,1,1]]
            },{
               "r1":1000000,
               "r2":1000000,
               "r3":0,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[14,1,6]]
            }],
            "imageData":{
               "baseurl":"buildings/maproom/",
               "1":{
                  "top":["top.1.png",new Point(-58,-67)],
                  "shadow":["shadow.1.jpg",new Point(-68,15)],
                  "topdamaged":["top.1.damaged.png",new Point(-73,-44)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-67,23)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-70,0)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-67,27)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"11.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"11.png"}
            },
            "quantity":[0,1,1,1,1,1,1,1,1,1],
            "hp":[5000,10000],
            "repairTime":[5 * 60,10 * 60]
         },{
            "id":12,
            "group":2,
            "order":2,
            "type":"special",
            "name":"#b_generalstore#",
            "size":80,
            "attackgroup":2,
            "tutstage":0,
            "sale":0,
            "description":"generalstore_desc",
            "costs":[{
               "r1":18 * 60,
               "r2":12 * 60,
               "r3":0,
               "r4":0,
               "time":10,
               "re":[[14,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/generalstore/",
               "1":{
                  "top":["top.1.png",new Point(-40,-37)],
                  "shadow":["shadow.1.jpg",new Point(-44,13)],
                  "topdamaged":["top.1.damaged.png",new Point(-44,-49)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-44,15)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-49,-28)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-48,13)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"12.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"12.png"}
            },
            "quantity":[0,1,1,1,1,1,1,1,1,1],
            "hp":[0xfa0],
            "repairTime":[10]
         },{
            "id":13,
            "group":2,
            "order":7,
            "type":"special",
            "name":"#b_hatchery#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":140,
            "sale":0,
            "description":"hatchery_desc",
            "costs":[{
               "r1":2000,
               "r2":2000,
               "r3":0,
               "r4":0,
               "time":15 * 60,
               "re":[[14,1,1],[15,1,1]]
            },{
               "r1":21227,
               "r2":49529,
               "r3":0,
               "r4":0,
               "time":60 * 60,
               "re":[[14,1,3],[8,1,1]]
            },{
               "r1":26 * 60 * 60,
               "r2":218427,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,4]]
            }],
            "imageData":{
               "baseurl":"buildings/hatchery/",
               "1":{
                  "anim":["anim.2.png",new Rectangle(-53,-104,103,80),31],
                  "top":["top.2.png",new Point(-50,-52)],
                  "shadow":["shadow.2.jpg",new Point(-31,32)],
                  "topdamaged":["top.2.damaged.png",new Point(-78,-92)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-48,36)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-58,0)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-58,32)]
               },
               "2":{
                  "anim":["anim.3.png",new Rectangle(-40,-123,105,124),31],
                  "top":["top.3.png",new Point(-51,-62)],
                  "shadow":["shadow.3.jpg",new Point(-48,26)],
                  "topdamaged":["top.3.damaged.png",new Point(-53,-113)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-45,32)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-58,0)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-58,32)]
               },
               "3":{
                  "anim":["anim.4.png",new Rectangle(-12,-112,113,105),31],
                  "top":["top.4.png",new Point(-50,-114)],
                  "shadow":["shadow.4.jpg",new Point(-44,25)],
                  "topdamaged":["top.4.damaged.png",new Point(-60,-117)],
                  "shadowdamaged":["shadow.4.damaged.jpg",new Point(-52,23)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-58,0)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-58,32)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"13.1.jpg"},
               "2":{"img":"13.2.jpg"},
               "3":{"img":"13.3.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"13.1.png"},
               "2":{"img":"13.2.png"},
               "3":{"img":"13.3.png"}
            },
            "quantity":[0,1,2,3,4,5,5,5,5,5],
            "hp":[0xfa0,16000,32000],
            "repairTime":[60,150,5 * 60]
         },{
            "id":14,
            "group":2,
            "order":1,
            "type":"special",
            "name":"#b_townhall#",
            "size":190,
            "attackgroup":1,
            "tutstage":0,
            "sale":0,
            "description":"townhall_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":10,
               "re":[]
            },{
               "r1":7000,
               "r2":7000,
               "r3":0,
               "r4":0,
               "time":10 * 60,
               "re":[[14,1,1]]
            },{
               "r1":700 * 60,
               "r2":700 * 60,
               "r3":0,
               "r4":0,
               "time":4 * 60 * 60,
               "re":[[14,1,2]]
            },{
               "r1":4 * 60 * 1000,
               "r2":4 * 60 * 1000,
               "r3":0,
               "r4":0,
               "time":16 * 60 * 60,
               "re":[[14,1,3]]
            },{
               "r1":1400000,
               "r2":1400000,
               "r3":0,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":7560000,
               "r2":7560000,
               "r3":0,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":11340000,
               "r2":11340000,
               "r3":0,
               "r4":0,
               "time":6 * 24 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":14420000,
               "r2":14420000,
               "r3":0,
               "r4":0,
               "time":8 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":18680000,
               "r2":18680000,
               "r3":0,
               "r4":0,
               "time":12 * 24 * 60 * 60,
               "re":[[14,1,8]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":500000,
               "r2":100000,
               "r3":50000,
               "r4":0,
               "time":4 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":1000000,
               "r2":1000000,
               "r3":500000,
               "r4":0,
               "time":16 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":5000000,
               "r2":5000000,
               "r3":2000000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":10000000,
               "r2":10000000,
               "r3":5000000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[14,1,8]]
            }],
            "imageData":{
               "baseurl":"buildings/townhall/",
               "1":{
                  "top":["top.1.png",new Point(-45,-52)],
                  "shadow":["shadow.1.jpg",new Point(-55,37)],
                  "topdamaged":["top.1.damaged.png",new Point(-50,-50)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-55,38)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-57,17)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-54,37)],
                  "topdestroyedfire":["top.1.destroyed.fire.png",new Point(-57,17)]
               },
               "2":{
                  "top":["top.2.png",new Point(-48,-62)],
                  "shadow":["shadow.2.jpg",new Point(-55,36)],
                  "topdamaged":["top.2.damaged.png",new Point(-49,-59)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-65,32)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-61,6)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-59,28)],
                  "topdestroyedfire":["top.2.destroyed.fire.png",new Point(-61,6)]
               },
               "3":{
                  "top":["top.3.png",new Point(-65,-67)],
                  "shadow":["shadow.3.jpg",new Point(-70,28)],
                  "topdamaged":["top.3.damaged.png",new Point(-69,-68)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-74,29)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-70,-8)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-70,30)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-70,-8)]
               },
               "4":{
                  "top":["top.4.png",new Point(-66,-72)],
                  "shadow":["shadow.4.jpg",new Point(-88,20)],
                  "topdamaged":["top.4.damaged.png",new Point(-66,-72)],
                  "shadowdamaged":["shadow.4.damaged.jpg",new Point(-77,25)],
                  "topdestroyed":["top.4.destroyed.png",new Point(-92,-18)],
                  "shadowdestroyed":["shadow.4.destroyed.jpg",new Point(-91,25)],
                  "topdestroyedfire":["top.4.destroyed.fire.png",new Point(-92,-18)]
               },
               "5":{
                  "top":["top.5.png",new Point(-67,-75)],
                  "shadow":["shadow.5.jpg",new Point(-67,33)],
                  "topdamaged":["top.5.damaged.png",new Point(-70,-69)],
                  "shadowdamaged":["shadow.5.damaged.jpg",new Point(-17,20)],
                  "topdestroyed":["top.5.destroyed.png",new Point(-89,-16)],
                  "shadowdestroyed":["shadow.5.destroyed.jpg",new Point(-88,30)],
                  "topdestroyedfire":["top.5.destroyed.fire.png",new Point(-89,-16)]
               },
               "6":{
                  "top":["top.6.png",new Point(-72,-82)],
                  "shadow":["shadow.6.jpg",new Point(-84,26)],
                  "topdamaged":["top.6.damaged.png",new Point(-72,-67)],
                  "shadowdamaged":["shadow.6.damaged.jpg",new Point(-85,25)],
                  "topdestroyed":["top.6.destroyed.png",new Point(-92,-8)],
                  "shadowdestroyed":["shadow.6.destroyed.jpg",new Point(-90,25)],
                  "topdestroyedfire":["top.6.destroyed.fire.png",new Point(-92,-8)]
               },
               "7":{
                  "top":["top.7.png",new Point(-81,-88)],
                  "shadow":["shadow.7.jpg",new Point(-121,-3)],
                  "topdamaged":["top.7.damaged.png",new Point(-81,-89)],
                  "shadowdamaged":["shadow.7.damaged.jpg",new Point(-103,3)],
                  "topdestroyed":["top.7.destroyed.png",new Point(-84,-13)],
                  "shadowdestroyed":["shadow.7.destroyed.jpg",new Point(-102,8)]
               },
               "8":{
                  "top":["top.8.png",new Point(-80,-87)],
                  "shadow":["shadow.8.jpg",new Point(-94,8)],
                  "topdamaged":["top.8.damaged.png",new Point(-86,-91)],
                  "shadowdamaged":["shadow.8.damaged.jpg",new Point(-86,13)],
                  "topdestroyed":["top.8.destroyed.png",new Point(-84,-13)],
                  "shadowdestroyed":["shadow.8.destroyed.jpg",new Point(-102,8)]
               },
               "9":{
                  "top":["top.9.png",new Point(-77,-97)],
                  "shadow":["shadow.9.jpg",new Point(-76,24)],
                  "topdamaged":["top.9.damaged.png",new Point(-86,-71)],
                  "shadowdamaged":["shadow.9.damaged.jpg",new Point(-88,23)],
                  "topdestroyed":["top.9.destroyed.png",new Point(-80,-54)],
                  "shadowdestroyed":["shadow.9.destroyed.jpg",new Point(-81,23)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"14.1.jpg"},
               "2":{"img":"14.2.jpg"},
               "3":{"img":"14.3.jpg"},
               "4":{"img":"14.4.jpg"},
               "5":{"img":"14.5.jpg"},
               "6":{"img":"14.6.jpg"},
               "7":{"img":"14.7.jpg"},
               "8":{"img":"14.8.jpg"},
               "9":{"img":"14.9.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"14.1.png"},
               "2":{"img":"14.2.png"},
               "3":{"img":"14.3.png"},
               "4":{"img":"14.4.png"},
               "5":{"img":"14.5.png"},
               "6":{"img":"14.6.png"},
               "7":{"img":"14.7.png"},
               "8":{"img":"14.8.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort130_F1.png",new Point(-127,46)],
                  "back":["fort130_B1.png",new Point(-122,-10)]
               },
               "2":{
                  "front":["fort130_F2.png",new Point(-124,48)],
                  "back":["fort130_B2.png",new Point(-120,-15)]
               },
               "3":{
                  "front":["fort130_F3.png",new Point(-124,32)],
                  "back":["fort130_B3.png",new Point(-110,-11)]
               },
               "4":{
                  "front":["fort130_F4.png",new Point(-124,15)],
                  "back":["fort130_B4.png",new Point(-116,-49)]
               }
            },
            "quantity":[1,1,1,1,1,1,1,1,1,1],
            "hp":[0xfa0,8800,20000,700 * 60,94000,200000,5 * 60 * 1000,400000,500000],
            "repairTime":[8 * 60,32 * 60,0xf00,128 * 60,256 * 60,512 * 60,18 * 60 * 60,24 * 60 * 60,2 * 24 * 60 * 60]
         },{
            "id":15,
            "group":2,
            "order":6,
            "type":"special",
            "name":"#b_housing#",
            "size":200,
            "attackgroup":2,
            "tutstage":50,
            "sale":0,
            "description":"housing_desc",
            "costs":[{
               "r1":36 * 60,
               "r2":36 * 60,
               "r3":0,
               "r4":0,
               "time":5 * 60,
               "re":[[14,1,1]]
            },{
               "r1":144 * 60,
               "r2":144 * 60,
               "r3":0,
               "r4":0,
               "time":75 * 60,
               "re":[[14,1,3],[8,1,1]]
            },{
               "r1":576 * 60,
               "r2":576 * 60,
               "r3":0,
               "r4":0,
               "time":3 * 60 * 60,
               "re":[[14,1,4],[8,1,1]]
            },{
               "r1":138240,
               "r2":138240,
               "r3":0,
               "r4":0,
               "time":0x7080,
               "re":[[14,1,5],[8,1,1]]
            },{
               "r1":552960,
               "r2":552960,
               "r3":0,
               "r4":0,
               "time":20 * 60 * 60,
               "re":[[14,1,6],[8,1,1]]
            },{
               "r1":2211840,
               "r2":2211840,
               "r3":0,
               "r4":0,
               "time":40 * 60 * 60,
               "re":[[14,1,6],[8,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/monsterhousing/",
               "1":{
                  "top":["top.3.v2.png",new Point(-109,11)],
                  "shadow":["shadow.3.v2.jpg",new Point(-112,23)],
                  "topdamaged":["top.3.damaged.v2.png",new Point(-107,12)],
                  "shadowdamaged":["shadow.3.damaged.v2.jpg",new Point(-110,25)],
                  "topdestroyed":["top.3.destroyed.v2.png",new Point(-108,21)],
                  "shadowdestroyed":["shadow.3.destroyed.v2.jpg",new Point(-109,25)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"15.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"15.png"}
            },
            "quantity":[0,1,1,2,2,3,3,3,4,4],
            "capacity":[200,260,320,380,450,9 * 60],
            "hp":[0xfa0,14000,25000,43000,75000,130000],
            "repairTime":[100,200,5 * 60,400,500,10 * 60]
         },{
            "id":16,
            "group":2,
            "order":8,
            "type":"special",
            "name":"#b_hcc#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"hcc_desc",
            "costs":[{
               "r1":4000000,
               "r2":4000000,
               "r3":4000000,
               "r4":0,
               "time":25 * 60 * 60,
               "re":[[14,1,3],[13,3,2]]
            }],
            "imageData":{
               "baseurl":"buildings/hatcherycontrolcenter/",
               "1":{
                  "top":["top.1.png",new Point(-40,-58)],
                  "shadow":["shadow.1.jpg",new Point(-51,20)],
                  "topdamaged":["top.1.damaged.png",new Point(-51,-59)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-50,25)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-53,-7)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-57,24)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"16.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"16.png"}
            },
            "quantity":[0,0,0,1,1,1,1,1,1,1],
            "hp":[64000],
            "repairTime":[5 * 60]
         },{
            "id":17,
            "group":3,
            "order":7,
            "type":"wall",
            "name":"#b_woodenblock#",
            "size":50,
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"woodenblock_desc",
            "costs":[{
               "r1":1000,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[14,1,2]]
            },{
               "r1":0,
               "r2":10000,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[14,1,3]]
            },{
               "r1":100000,
               "r2":100000,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[14,1,4]]
            },{
               "r1":200000,
               "r2":200000,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[14,1,5]]
            },{
               "r1":400000,
               "r2":400000,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[14,1,6]]
            }],
            "imageData":{
               "baseurl":"buildings/walls/",
               "1":{
                  "top":["top.1.png",new Point(-21,-21)],
                  "shadow":["shadow.jpg",new Point(-28,-7)],
                  "topdamaged":["top.1.damaged.png",new Point(-21,-21)],
                  "shadowdamaged":["shadow.jpg",new Point(-28,-7)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-21,-5)],
                  "shadowdestroyed":["shadow.jpg",new Point(-28,-7)]
               },
               "2":{
                  "top":["top.2.png",new Point(-20,-20)],
                  "shadow":["shadow.jpg",new Point(-28,-7)],
                  "topdamaged":["top.2.damaged.png",new Point(-21,-20)],
                  "shadowdamaged":["shadow.jpg",new Point(-28,-7)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-19,0)],
                  "shadowdestroyed":["shadow.jpg",new Point(-28,-7)]
               },
               "3":{
                  "top":["top.3.png",new Point(-21,-21)],
                  "shadow":["shadow.jpg",new Point(-28,-7)],
                  "topdamaged":["top.3.damaged.png",new Point(-22,-21)],
                  "shadowdamaged":["shadow.jpg",new Point(-28,-7)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-21,-3)],
                  "shadowdestroyed":["shadow.jpg",new Point(-28,-7)]
               },
               "4":{
                  "top":["top.4.v2.png",new Point(-20,-22)],
                  "shadow":["shadow.jpg",new Point(-28,-7)],
                  "topdamaged":["top.4.damaged.v2.png",new Point(-20,-22)],
                  "shadowdamaged":["shadow.jpg",new Point(-28,-7)],
                  "topdestroyed":["top.4.destroyed.png",new Point(-20,-2)],
                  "shadowdestroyed":["shadow.jpg",new Point(-28,-7)]
               },
               "5":{
                  "top":["top.5.png",new Point(-20,-22)],
                  "shadow":["shadow.jpg",new Point(-28,-7)],
                  "topdamaged":["top.5.damaged.png",new Point(-20,-19)],
                  "shadowdamaged":["shadow.jpg",new Point(-28,-7)],
                  "topdestroyed":["top.5.destroyed.png",new Point(-20,-3)],
                  "shadowdestroyed":["shadow.jpg",new Point(-28,-7)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"17.1.jpg"},
               "2":{"img":"17.2.v2.jpg"},
               "3":{"img":"17.3.v2.jpg"},
               "4":{"img":"17.4.jpg"},
               "5":{"img":"17.5.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"17.1.png"},
               "2":{"img":"17.2.png"},
               "3":{"img":"17.3.png"},
               "4":{"img":"17.4.png"},
               "4":{"img":"17.5.png"}
            },
            "quantity":[0,0,30,60,2 * 60,200,220,280,5 * 60,340],
            "hp":[1000,2300,5750,5 * 60 * 60,450 * 60],
            "repairTime":[5,5,5,5,5]
         },{
            "id":18,
            "group":3,
            "order":7,
            "type":"wall",
            "name":"#b_stoneblock#",
            "size":50,
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"stoneblock_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":2000,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[14,1,3]]
            }],
            "imageData":{
               "baseurl":"buildings/walls/stone/",
               "1":{
                  "top":["top.1.png",new Point(-16,-21)],
                  "shadow":["shadow.1.jpg",new Point(-19,-1)],
                  "topdamaged":["top.1.damaged.png",new Point(-17,-19)],
                  "shadowdamaged":["shadow.1.jpg",new Point(-19,-1)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-16,0)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-14,5)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"18.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"18.png"}
            },
            "quantity":[0,0,10,20,40,60,70,90,90,90],
            "hp":[60 * 60],
            "repairTime":[20]
         },{
            "id":19,
            "group":2,
            "order":12,
            "type":"special",
            "name":"#b_wildmonsterbaiter#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"wildmonsterbaiter_desc",
            "costs":[{
               "r1":25000,
               "r2":25000,
               "r3":250 * 60,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,4],[8,1,1]]
            },{
               "r1":1000000,
               "r2":1000000,
               "r3":500000,
               "r4":0,
               "time":10 * 60 * 60,
               "re":[[14,1,4],[8,1,2]]
            },{
               "r1":2000000,
               "r2":2000000,
               "r3":1000000,
               "r4":0,
               "time":20 * 60 * 60,
               "re":[[14,1,4],[8,1,3]]
            },{
               "r1":4000000,
               "r2":4000000,
               "r3":2000000,
               "r4":0,
               "time":40 * 60 * 60,
               "re":[[14,1,5],[8,1,4]]
            },{
               "r1":100 * 60 * 1000,
               "r2":100 * 60 * 1000,
               "r3":4000000,
               "r4":0,
               "time":80 * 60 * 60,
               "re":[[14,1,6],[8,1,4]]
            },{
               "r1":10000000,
               "r2":10000000,
               "r3":100 * 60 * 1000,
               "r4":0,
               "time":160 * 60 * 60,
               "re":[[14,1,7],[8,1,4]]
            },{
               "r1":16000000,
               "r2":16000000,
               "r3":10000000,
               "r4":0,
               "time":320 * 60 * 60,
               "re":[[14,1,8],[8,1,4]]
            }],
            "imageData":{
               "baseurl":"buildings/monsterbaiter/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-33,-23,67,77),41],
                  "top":["top.1.png",new Point(-37,-6)],
                  "shadow":["shadow.1.jpg",new Point(-9,16)],
                  "topdamaged":["top.1.damaged.png",new Point(-37,-14)],
                  "shadowdamaged":["shadow.1.jpg",new Point(-9,16)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-37,10)],
                  "shadowdestroyed":["shadow.1.jpg",new Point(-9,16)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"19.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"19.png"}
            },
            "quantity":[0,0,0,0,1,1,1,1,1,1],
            "produce":[2,2,2,2,2,2,2],
            "capacity":[10 * 60,15 * 60,20 * 60,25 * 60,35 * 60,3200,80 * 60],
            "hp":[1000,25 * 60,2250,3375,5000,125 * 60,200 * 60],
            "repairTime":[2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60]
         },{
            "id":20,
            "group":3,
            "order":2,
            "type":"tower",
            "name":"#b_cannontower#",
            "size":64,
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"cannontower_desc",
            "stats":[{
               "range":160,
               "damage":20,
               "rate":40,
               "speed":5,
               "splash":30
            },{
               "range":170,
               "damage":40,
               "rate":40,
               "speed":6,
               "splash":35
            },{
               "range":3 * 60,
               "damage":60,
               "rate":40,
               "speed":7,
               "splash":40
            },{
               "range":190,
               "damage":80,
               "rate":40,
               "speed":8,
               "splash":45
            },{
               "range":200,
               "damage":100,
               "rate":40,
               "speed":8,
               "splash":50
            },{
               "range":210,
               "damage":2 * 60,
               "rate":40,
               "speed":8,
               "splash":55
            },{
               "range":220,
               "damage":140,
               "rate":40,
               "speed":8,
               "splash":60
            },{
               "range":230,
               "damage":160,
               "rate":40,
               "speed":8,
               "splash":65
            },{
               "range":4 * 60,
               "damage":3 * 60,
               "rate":40,
               "speed":8,
               "splash":70
            },{
               "range":250,
               "damage":200,
               "rate":40,
               "speed":8,
               "splash":75
            }],
            "costs":[{
               "r1":2000,
               "r2":25 * 60,
               "r3":500,
               "r4":0,
               "time":30,
               "re":[[14,1,1]]
            },{
               "r1":10000,
               "r2":125 * 60,
               "r3":2500,
               "r4":0,
               "time":15 * 60,
               "re":[[14,1,2]]
            },{
               "r1":50000,
               "r2":625 * 60,
               "r3":12500,
               "r4":0,
               "time":45 * 60,
               "re":[[14,1,3]]
            },{
               "r1":250000,
               "r2":187500,
               "r3":62500,
               "r4":0,
               "time":135 * 60,
               "re":[[14,1,4]]
            },{
               "r1":1250000,
               "r2":937500,
               "r3":312500,
               "r4":0,
               "time":405 * 60,
               "re":[[14,1,4]]
            },{
               "r1":6250000,
               "r2":4687500,
               "r3":1562500,
               "r4":0,
               "time":72900,
               "re":[[14,1,5]]
            },{
               "r1":9375000,
               "r2":7000000,
               "r3":1562500,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":14000000,
               "r2":175 * 60 * 1000,
               "r3":1562500,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":0x1406f40,
               "r2":15800000,
               "r3":1562500,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[14,1,8]]
            },{
               "r1":31600000,
               "r2":395 * 60 * 1000,
               "r3":1562500,
               "r4":0,
               "time":132 * 60 * 60,
               "re":[[14,1,8]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":50000,
               "r2":625 * 60,
               "r3":12500,
               "r4":0,
               "time":135 * 60,
               "re":[[14,1,5]]
            },{
               "r1":250000,
               "r2":187500,
               "r3":62500,
               "r4":0,
               "time":405 * 60,
               "re":[[14,1,6]]
            },{
               "r1":1250000,
               "r2":937500,
               "r3":312500,
               "r4":0,
               "time":72900,
               "re":[[14,1,7]]
            },{
               "r1":6250000,
               "r2":4687500,
               "r3":1562500,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,8]]
            }],
            "imageData":{
               "baseurl":"buildings/cannontower/",
               "1":{
                  "top":["top.3.png",new Point(-33,-25)],
                  "shadow":["shadow.3.jpg",new Point(-38,20)],
                  "topdamaged":["top.3.damaged.png",new Point(-48,-25)],
                  "shadowdamaged":["shadow.3.jpg",new Point(-47,20)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-46,8)],
                  "shadowdestroyed":["shadow.3.jpg",new Point(-43,22)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-46,8)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"20.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"20.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,2,3,4,5,6,6,6,6,6],
            "hp":[100 * 60,150 * 60,210 * 60,294 * 60,441 * 60,34400,750 * 60,58000,75500,98200],
            "repairTime":[6 * 60,12 * 60,24 * 60,48 * 60,96 * 60,192 * 60,23000,46000,18 * 60 * 60,24 * 60 * 60]
         },{
            "id":21,
            "group":3,
            "order":1,
            "type":"tower",
            "name":"#b_snipertower#",
            "size":64,
            "attackgroup":3,
            "tutstage":28,
            "sale":0,
            "description":"snipertower_desc",
            "stats":[{
               "range":5 * 60,
               "damage":100,
               "rate":80,
               "speed":10,
               "splash":0
            },{
               "range":308,
               "damage":210,
               "rate":80,
               "speed":10,
               "splash":0
            },{
               "range":316,
               "damage":320,
               "rate":80,
               "speed":10,
               "splash":0
            },{
               "range":324,
               "damage":430,
               "rate":80,
               "speed":12,
               "splash":0
            },{
               "range":332,
               "damage":9 * 60,
               "rate":80,
               "speed":15,
               "splash":0
            },{
               "range":340,
               "damage":650,
               "rate":80,
               "speed":17,
               "splash":0
            },{
               "range":348,
               "damage":760,
               "rate":80,
               "speed":18,
               "splash":0
            },{
               "range":356,
               "damage":870,
               "rate":80,
               "speed":19,
               "splash":0
            },{
               "range":364,
               "damage":980,
               "rate":80,
               "speed":20,
               "splash":0
            },{
               "range":372,
               "damage":1100,
               "rate":80,
               "speed":20,
               "splash":0
            }],
            "costs":[{
               "r1":25 * 60,
               "r2":2000,
               "r3":500,
               "r4":0,
               "time":30,
               "re":[[14,1,1]]
            },{
               "r1":125 * 60,
               "r2":10000,
               "r3":2500,
               "r4":0,
               "time":15 * 60,
               "re":[[14,1,2]]
            },{
               "r1":625 * 60,
               "r2":50000,
               "r3":12500,
               "r4":0,
               "time":45 * 60,
               "re":[[14,1,3]]
            },{
               "r1":187500,
               "r2":250000,
               "r3":62500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":937500,
               "r2":1250000,
               "r3":312500,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":4687500,
               "r2":6250000,
               "r3":1562500,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":7031250,
               "r2":9375000,
               "r3":2343750,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":10547000,
               "r2":14062000,
               "r3":3515000,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[14,1,8]]
            },{
               "r1":15820000,
               "r2":21095000,
               "r3":5275000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[14,1,8]]
            },{
               "r1":32730000,
               "r2":31650000,
               "r3":7900000,
               "r4":0,
               "time":132 * 60 * 60,
               "re":[[14,1,8]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":625 * 60,
               "r2":50000,
               "r3":12500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":187500,
               "r2":250000,
               "r3":62500,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":937500,
               "r2":1250000,
               "r3":312500,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":4687500,
               "r2":6250000,
               "r3":1562500,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,8]]
            }],
            "imageData":{
               "baseurl":"buildings/snipertower/",
               "1":{
                  "anim":["anim.3.png",new Rectangle(-27,-50,55,47),30],
                  "top":["top.3.png",new Point(-40,-30)],
                  "shadow":["shadow.3.jpg",new Point(-43,12)],
                  "animdamaged":["anim.3.damaged.png",new Rectangle(-28,-49,55,46),30],
                  "topdamaged":["top.3.damaged.png",new Point(-39,-25)],
                  "shadowdamaged":["shadow.3.jpg",new Point(-39,15)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-45,-13)],
                  "shadowdestroyed":["shadow.3.jpg",new Point(-45,-4)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-45,-13)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"21.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"21.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,2,3,4,5,6,6,6,6,6],
            "hp":[100 * 60,150 * 60,210 * 60,294 * 60,441 * 60,34400,750 * 60,58000,75500,98200],
            "repairTime":[6 * 60,12 * 60,24 * 60,48 * 60,96 * 60,192 * 60,23000,46000,18 * 60 * 60,24 * 60 * 60]
         },{
            "id":22,
            "group":3,
            "order":5,
            "type":"tower",
            "name":"#b_monsterbunker#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"monsterbunker_desc",
            "stats":[{"range":5 * 60},{"range":350},{"range":400},{"range":450}],
            "costs":[{
               "r1":250000,
               "r2":187500,
               "r3":62500,
               "r4":0,
               "time":6 * 60 * 60,
               "re":[[14,1,3],[15,1,1]]
            },{
               "r1":1000000,
               "r2":1000000,
               "r3":500000,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,4],[15,1,2]]
            },{
               "r1":2000000,
               "r2":2000000,
               "r3":1000000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,5],[15,1,3]]
            },{
               "r1":4000000,
               "r2":4000000,
               "r3":2000000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,9],[15,1,3]]
            }],
            "imageData":{
               "baseurl":"buildings/bunker/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-46,-15,90,83),15],
                  "shadow":["shadow.1.jpg",new Point(-66,10)],
                  "topdamaged":["top.1.damaged.png",new Point(-45,-8)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-66,5)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-50,4)],
                  "shadowdamaged":["shadow.1.destroyed.jpg",new Point(-61,14)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"22.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"22.png"}
            },
            "quantity":[0,0,0,1,1,2,2,3,4,4],
            "capacity":[380,450,9 * 60,640],
            "hp":[10000,24500,52000,75000],
            "repairTime":[2 * 60,4 * 60,8 * 60,16 * 60]
         },{
            "id":23,
            "group":3,
            "order":4,
            "type":"tower",
            "name":"#b_lasertower#",
            "tutstage":200,
            "sale":0,
            "description":"lasertower_desc",
            "stats":[{
               "range":160,
               "damage":2 * 60,
               "rate":80,
               "speed":0,
               "splash":40
            },{
               "range":162,
               "damage":150,
               "rate":80,
               "speed":0,
               "splash":40
            },{
               "range":164,
               "damage":3 * 60,
               "rate":80,
               "speed":0,
               "splash":40
            },{
               "range":168,
               "damage":200,
               "rate":80,
               "speed":0,
               "splash":40
            },{
               "range":170,
               "damage":220,
               "rate":80,
               "speed":0,
               "splash":40
            },{
               "range":175,
               "damage":4 * 60,
               "rate":80,
               "speed":0,
               "splash":40
            }],
            "costs":[{
               "r1":500000,
               "r2":250000,
               "r3":100000,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":1000000,
               "r2":500000,
               "r3":200000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":2000000,
               "r2":1000000,
               "r3":400000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":4000000,
               "r2":2000000,
               "r3":800000,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":8000000,
               "r2":4000000,
               "r3":1600000,
               "r4":0,
               "time":108 * 60 * 60,
               "re":[[14,1,8]]
            },{
               "r1":16000000,
               "r2":8000000,
               "r3":3200000,
               "r4":0,
               "time":9 * 24 * 60 * 60,
               "re":[[14,1,9]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":500000,
               "r2":250000,
               "r3":100000,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":1000000,
               "r2":500000,
               "r3":200000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":2000000,
               "r2":1000000,
               "r3":400000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":4000000,
               "r2":2000000,
               "r3":800000,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[14,1,8]]
            }],
            "imageData":{
               "baseurl":"buildings/lasertower/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-13,-50,29,32),54],
                  "top":["top.1.png",new Point(-33,-29)],
                  "shadow":["shadow.1.jpg",new Point(-36,15)],
                  "animdamaged":["anim.1.damaged.png",new Rectangle(-22,-46,52,44),54],
                  "topdamaged":["top.1.damaged.png",new Point(-40,-28)],
                  "shadowdamaged":["shadow.1.jpg",new Point(-37,-17)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-39,-3)],
                  "shadowdestroyed":["shadow.1.jpg",new Point(-37,14)],
                  "topdestroyedfire":["top.1.destroyed.fire.png",new Point(-39,-3)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"23.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"23.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,0,0,0,1,2,3,3,3,3],
            "hp":[150 * 60,210 * 60,294 * 60,441 * 60,34400,42200],
            "repairTime":[24 * 60,48 * 60,96 * 60,192 * 60,23000,46000]
         },{
            "id":24,
            "group":3,
            "order":6,
            "type":"trap",
            "name":"#b_boobytrap#",
            "size":50,
            "attackgroup":4,
            "tutstage":200,
            "sale":0,
            "description":"boobytrap_desc",
            "costs":[{
               "r1":1000,
               "r2":1000,
               "r3":1000,
               "r4":0,
               "time":5,
               "re":[[14,1,2]]
            }],
            "imageData":{
               "baseurl":"buildings/boobytrap/",
               "1":{
                  "top":["top.1.png",new Point(-15,1)],
                  "shadow":["shadow.1.jpg",new Point(-13,3)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-15,2)],
                  "shadowdestroyed":["shadow.1.jpg",new Point(-13,3)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"24.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"24.png"}
            },
            "quantity":[0,0,8,15,20,28,35,42,50,60],
            "damage":[1000],
            "hp":[10],
            "repairTime":[1]
         },{
            "id":25,
            "group":3,
            "order":3,
            "type":"tower",
            "name":"#b_teslatower#",
            "tutstage":200,
            "sale":0,
            "description":"teslatower_desc",
            "stats":[{
               "range":250,
               "damage":100,
               "rate":10,
               "speed":10,
               "splash":0
            },{
               "range":270,
               "damage":2 * 60,
               "rate":15,
               "speed":10,
               "splash":0
            },{
               "range":5 * 60,
               "damage":140,
               "rate":20,
               "speed":10,
               "splash":0
            },{
               "range":320,
               "damage":160,
               "rate":25,
               "speed":10,
               "splash":0
            },{
               "range":340,
               "damage":3 * 60,
               "rate":25,
               "speed":10,
               "splash":0
            },{
               "range":6 * 60,
               "damage":200,
               "rate":30,
               "speed":10,
               "splash":0
            }],
            "costs":[{
               "r1":187500,
               "r2":250000,
               "r3":62500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":750000,
               "r2":1000000,
               "r3":250000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":625 * 60 * 60,
               "r2":50 * 60 * 1000,
               "r3":750000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":5250000,
               "r2":5000000,
               "r3":1250000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":200 * 60 * 1000,
               "r2":10000000,
               "r3":2000000,
               "r4":0,
               "time":6 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":5 * 60 * 60 * 1000,
               "r2":250 * 60 * 1000,
               "r3":5000000,
               "r4":0,
               "time":8 * 24 * 60 * 60,
               "re":[[14,1,9]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":187500,
               "r2":250000,
               "r3":62500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":750000,
               "r2":1000000,
               "r3":250000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":625 * 60 * 60,
               "r2":50 * 60 * 1000,
               "r3":750000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":5250000,
               "r2":5000000,
               "r3":1250000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[14,1,8]]
            }],
            "imageData":{
               "baseurl":"buildings/lightningtower/",
               "1":{
                  "anim":["anim.3.png",new Rectangle(-25,-15,27,53),55],
                  "top":["top.3.png",new Point(-33,-57)],
                  "shadow":["shadow.3.jpg",new Point(-38,18)],
                  "animdamaged":["anim.3.damaged.png",new Rectangle(-26,-19,30,57),55],
                  "topdamaged":["top.3.damaged.png",new Point(-46,-58)],
                  "shadowdamaged":["shadow.3.jpg",new Point(-44,21)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-46,6)],
                  "shadowdestroyed":["shadow.3.jpg",new Point(-44,17)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-46,6)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"25.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"25.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,0,0,0,1,2,3,3,3,3],
            "hp":[250 * 60,22000,500 * 60,800 * 60,60 * 1000,20 * 60 * 60],
            "repairTime":[32 * 60,0xf00,128 * 60,9260,200 * 60,5 * 60 * 60]
         },{
            "id":26,
            "group":2,
            "order":5,
            "type":"special",
            "name":"#b_monsteracademy#",
            "tutstage":200,
            "sale":0,
            "description":"monsteracademy_desc",
            "costs":[{
               "r1":100000,
               "r2":100000,
               "r3":0,
               "r4":0,
               "time":3 * 60 * 60,
               "re":[[14,1,3],[8,1,2]]
            },{
               "r1":250000,
               "r2":250000,
               "r3":0,
               "r4":0,
               "time":6 * 60 * 60,
               "re":[[14,1,4],[8,1,3]]
            },{
               "r1":400000,
               "r2":400000,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,5],[8,1,3]]
            },{
               "r1":10 * 60 * 1000,
               "r2":10 * 60 * 1000,
               "r3":0,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,6],[8,1,4]]
            },{
               "r1":250 * 60 * 60,
               "r2":250 * 60 * 60,
               "r3":0,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,7],[8,1,4]]
            }],
            "imageData":{
               "baseurl":"buildings/academy/",
               "1":{
                  "anim":["anim.1.v2.png",new Rectangle(-22,-13,48,26),21],
                  "top":["top.1.png",new Point(-42,-12)],
                  "shadow":["shadow.1.jpg",new Point(-47,27)],
                  "topdamaged":["top.1.damaged.png",new Point(-50,-12)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-47,20)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-50,11)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-48,26)]
               },
               "2":{
                  "anim":["anim.2.png",new Rectangle(-22,-11,47,24),21],
                  "top":["top.2.png",new Point(-43,-14)],
                  "shadow":["shadow.2.jpg",new Point(-48,27)],
                  "topdamaged":["top.2.damaged.png",new Point(-46,-15)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-35,27)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-50,11)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-48,26)]
               },
               "3":{
                  "anim":["anim.3.png",new Rectangle(-24,-17,48,24),21],
                  "top":["top.3.png",new Point(-53,-18)],
                  "shadow":["shadow.3.jpg",new Point(-53,27)],
                  "topdamaged":["top.3.damaged.png",new Point(-53,-17)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-57,26)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-50,11)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-48,26)]
               },
               "4":{
                  "anim":["anim.3.png",new Rectangle(-24,-36,48,24),21],
                  "top":["top.4.png",new Point(-53,-37)],
                  "shadow":["shadow.4.jpg",new Point(-53,27)],
                  "topdamaged":["top.4.damaged.png",new Point(-71,-35)],
                  "shadowdamaged":["shadow.4.damaged.jpg",new Point(-69,22)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-50,11)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-48,26)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"26.1.jpg"},
               "2":{"img":"26.2.jpg"},
               "3":{"img":"26.3.jpg"},
               "4":{"img":"26.4.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"26.1.png"},
               "2":{"img":"26.2.png"},
               "3":{"img":"26.3.png"},
               "4":{"img":"26.4.png"}
            },
            "quantity":[0,0,0,1,1,2,2,2,2,2],
            "hp":[100 * 60,10000,14000,20000,500 * 60],
            "repairTime":[3800,128 * 60,10640,260 * 60,380 * 60]
         },{
            "id":27,
            "group":999,
            "order":0,
            "type":"enemy",
            "name":"#b_trojanhorse#",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"trojanhorse_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[14,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/trojanhorse/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-92,-23,39,31),2],
                  "top":["top.1.png",new Point(-91,-65)],
                  "shadow":["shadow.1.jpg",new Point(-72,11)]
               }
            },
            "quantity":[1],
            "damage":[1],
            "hp":[1],
            "repairTime":[1]
         },{
            "id":28,
            "group":4,
            "subgroup":3,
            "order":5,
            "type":"decoration",
            "name":"#b_americanflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-usa.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":29,
            "group":4,
            "subgroup":3,
            "order":6,
            "type":"decoration",
            "name":"#b_britishflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-britain.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":30,
            "group":4,
            "subgroup":3,
            "order":7,
            "type":"decoration",
            "name":"#b_australianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-australia.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":31,
            "group":4,
            "subgroup":3,
            "order":8,
            "type":"decoration",
            "name":"#b_brazilianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-brazil.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":32,
            "group":4,
            "subgroup":3,
            "order":25,
            "type":"decoration",
            "name":"#b_europeanflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "r4":0,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-europe.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":33,
            "group":4,
            "subgroup":3,
            "order":9,
            "type":"decoration",
            "name":"#b_frenchflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-france.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":34,
            "group":4,
            "subgroup":3,
            "order":10,
            "type":"decoration",
            "name":"#b_indonesianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-indonesian.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":35,
            "group":4,
            "subgroup":3,
            "order":11,
            "type":"decoration",
            "name":"#b_italianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-italy.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":36,
            "group":4,
            "subgroup":3,
            "order":12,
            "type":"decoration",
            "name":"#b_malaysianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-malaysia.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":37,
            "group":4,
            "subgroup":3,
            "order":13,
            "type":"decoration",
            "name":"#b_dutchflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-dutch.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":38,
            "group":4,
            "subgroup":3,
            "order":14,
            "type":"decoration",
            "name":"#b_newzealandflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-newzealand.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":39,
            "group":4,
            "subgroup":3,
            "order":15,
            "type":"decoration",
            "name":"#b_norwegianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-norway.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":40,
            "group":4,
            "subgroup":3,
            "order":16,
            "type":"decoration",
            "name":"#b_polishflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-poland.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":41,
            "group":4,
            "subgroup":3,
            "order":17,
            "type":"decoration",
            "name":"#b_swedishflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-sweden.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":42,
            "group":4,
            "subgroup":3,
            "order":18,
            "type":"decoration",
            "name":"#b_turkishflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-turkey.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":43,
            "group":4,
            "subgroup":3,
            "order":19,
            "type":"decoration",
            "name":"#b_canadianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-canadian.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":44,
            "group":4,
            "subgroup":3,
            "order":20,
            "type":"decoration",
            "name":"#b_danishflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-denmark.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":45,
            "group":4,
            "subgroup":3,
            "order":21,
            "type":"decoration",
            "name":"#b_germanflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-germany.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":46,
            "group":4,
            "subgroup":3,
            "order":22,
            "type":"decoration",
            "name":"#b_filipinoflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-philippines.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":47,
            "group":4,
            "subgroup":3,
            "order":23,
            "type":"decoration",
            "name":"#b_singaporeanflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-singapore.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":48,
            "group":4,
            "subgroup":3,
            "order":24,
            "type":"decoration",
            "name":"#b_austrianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-austria.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":49,
            "group":4,
            "subgroup":3,
            "order":-1,
            "type":"decoration",
            "name":"#b_pirateflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":1,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":250,
               "r4":0,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-pirate.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":50,
            "group":4,
            "subgroup":3,
            "order":0,
            "type":"decoration",
            "name":"#b_peaceflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":1,
            "description":"flag_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":250,
               "r4":0,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-peace.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":51,
            "group":2,
            "order":10,
            "type":"special",
            "name":"#b_catapult#",
            "size":190,
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"catapult_desc",
            "block":false,
            "costs":[{
               "r1":75000,
               "r2":75000,
               "r3":75000,
               "r4":0,
               "time":90 * 60,
               "re":[[14,1,3],[5,1,1]]
            },{
               "r1":128600,
               "r2":128600,
               "r3":128600,
               "r4":0,
               "time":3 * 60 * 60,
               "re":[[14,1,4],[5,1,1]]
            },{
               "r1":257200,
               "r2":257200,
               "r3":257200,
               "r4":0,
               "time":6 * 60 * 60,
               "re":[[14,1,5],[5,1,1]]
            },{
               "r1":514400,
               "r2":514400,
               "r3":514400,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,6],[5,1,1],[11,1,2]]
            }],
            "imageData":{
               "baseurl":"buildings/catapult/",
               "1":{
                  "top":["top.1.png",new Point(-43,12)],
                  "shadow":["shadow.1.jpg",new Point(-42,28)],
                  "topdamaged":["top.1.damaged.png",new Point(-40,12)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-39,28)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-48,9)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-47,23)]
               },
               "2":{
                  "top":["top.2.png",new Point(-44,-21)],
                  "shadow":["shadow.2.jpg",new Point(-49,19)],
                  "topdamaged":["top.2.damaged.png",new Point(-43,-16)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-41,29)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-48,9)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-47,23)]
               },
               "3":{
                  "top":["top.3.png",new Point(-43,-29)],
                  "shadow":["shadow.3.jpg",new Point(-39,27)],
                  "topdamaged":["top.3.damaged.png",new Point(-51,-29)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-51,30)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-48,9)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-47,23)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"51.1.jpg"},
               "2":{"img":"51.2.jpg"},
               "3":{"img":"51.3.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"51.1.png"},
               "2":{"img":"51.2.png"},
               "3":{"img":"51.3.png"}
            },
            "quantity":[0,0,0,1,1,1,1,1,1,1],
            "hp":[0xfa0,0x1f40,16000,32000],
            "repairTime":[2 * 60,4 * 60,8 * 60,16 * 60]
         },{
            "id":52,
            "group":999,
            "subgroup":5,
            "order":1,
            "type":"taunt",
            "name":"Simple Sign",
            "lifespan":2 * 24 * 60 * 60,
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"Leave a little note for a friend.",
            "block":true,
            "costs":[{
               "r1":100000,
               "r2":100000,
               "r3":100000,
               "r4":100000,
               "r5":0,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-pirate.png",new Rectangle(1,-25,24,30),21],
                  "top":["flagpole.png",new Point(-5,-33)],
                  "shadow":["shadow.jpg",new Point(-3,15)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":53,
            "group":999,
            "order":1,
            "type":"immovable",
            "name":"hwn_pumpkin",
            "size":10,
            "attackgroup":0,
            "tutstage":0,
            "sale":0,
            "description":"Temporary pumpkin for picking",
            "block":true,
            "quantity":[0],
            "hp":[10],
            "repairTime":[10],
            "imageData":{
               "baseurl":"buildings/decorations/pumpkins/",
               "1":{
                  "anim":["anim.png",new Rectangle(-18,-15,37,36),30],
                  "shadow":["shadow.jpg",new Point(-22,-1)]
               }
            }
         },{
            "id":54,
            "group":999,
            "order":1,
            "type":"immovable",
            "name":"hwn_massivepumpkin",
            "size":10,
            "attackgroup":0,
            "tutstage":0,
            "sale":0,
            "description":"Massive Pumpkin for the \"Event\"",
            "block":true,
            "quantity":[0],
            "hp":[10],
            "repairTime":[10],
            "imageData":{
               "baseurl":"buildings/decorations/pumpkins/",
               "1":{
                  "top":["large-top-6.png",new Point(-169,-60)],
                  "shadow":["large-shadow-6.jpg",new Point(-168,5)],
                  "anim":["large-anim-6.png",new Rectangle(-119,-113,189,155),45]
               }
            }
         },{
            "id":55,
            "group":4,
            "subgroup":1,
            "order":1,
            "type":"decoration",
            "name":"bdg_acorn",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_acorn_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/acorn/",
               "1":{
                  "top":["top.png",new Point(-10,-9)],
                  "shadow":["shadow.jpg",new Point(-9,8)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":56,
            "group":4,
            "subgroup":1,
            "order":11,
            "type":"decoration",
            "name":"bdg_beehive",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_beehive_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/beehive/",
               "1":{
                  "top":["top.png",new Point(-18,-15)],
                  "shadow":["shadow.jpg",new Point(-14,6)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":57,
            "group":4,
            "subgroup":2,
            "order":2,
            "type":"decoration",
            "name":"bdg_birdhous",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_birdhous_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/birdhouse/",
               "1":{
                  "top":["top.png",new Point(-16,-46)],
                  "shadow":["shadow.jpg",new Point(-2,17)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":58,
            "group":4,
            "subgroup":2,
            "order":3,
            "type":"decoration",
            "name":"bdg_tent",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_tent_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/campingtent/",
               "1":{
                  "top":["top.png",new Point(-30,-12)],
                  "shadow":["shadow.jpg",new Point(-29,6)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":59,
            "group":4,
            "subgroup":1,
            "order":5,
            "type":"decoration",
            "name":"bdg_jax",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_jax_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/childrensjax/",
               "1":{
                  "top":["top.png",new Point(-11,-11)],
                  "shadow":["shadow.jpg",new Point(-7,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":60,
            "group":4,
            "subgroup":2,
            "order":12,
            "type":"decoration",
            "name":"bdg_redgnome",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_gnome_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/gnomes/",
               "1":{
                  "top":["top-red.png",new Point(-10,-31)],
                  "shadow":["shadow.jpg",new Point(-13,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":61,
            "group":4,
            "subgroup":2,
            "order":10,
            "type":"decoration",
            "name":"bdg_bluegnome",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_gnome_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/gnomes/",
               "1":{
                  "top":["top-blue.png",new Point(-10,-31)],
                  "shadow":["shadow.jpg",new Point(-13,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":62,
            "group":4,
            "subgroup":2,
            "order":11,
            "type":"decoration",
            "name":"bdg_greengnome",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_gnome_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/gnomes/",
               "1":{
                  "top":["top-green.png",new Point(-10,-31)],
                  "shadow":["shadow.jpg",new Point(-13,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":63,
            "group":4,
            "subgroup":2,
            "order":5,
            "type":"decoration",
            "name":"bdg_hammock",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_hammock_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/hammock/",
               "1":{
                  "top":["top.png",new Point(-25,-8)],
                  "shadow":["shadow.jpg",new Point(-26,6)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":64,
            "group":4,
            "subgroup":2,
            "order":6,
            "type":"decoration",
            "name":"bdg_lawnchair",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_lawnchair_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/lawnchair/",
               "1":{
                  "top":["top.png",new Point(-24,-14)],
                  "shadow":["shadow.jpg",new Point(-25,4)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":65,
            "group":4,
            "subgroup":2,
            "order":4,
            "type":"decoration",
            "name":"bdg_outhouse",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_outhouse_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/outhouse/",
               "1":{
                  "top":["top.png",new Point(-16,-19)],
                  "shadow":["shadow.jpg",new Point(-11,10)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":66,
            "group":4,
            "subgroup":1,
            "order":2,
            "type":"decoration",
            "name":"bdg_pinecone",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_pinecone_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/pinecone/",
               "1":{
                  "top":["top.png",new Point(-13,-10)],
                  "shadow":["shadow.jpg",new Point(-23,3)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":67,
            "group":4,
            "subgroup":1,
            "order":4,
            "type":"decoration",
            "name":"bdg_rock",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_rock_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/rock/",
               "1":{
                  "top":["top.png",new Point(-15,0)],
                  "shadow":["shadow.jpg",new Point(-15,9)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":68,
            "group":4,
            "subgroup":2,
            "order":15,
            "type":"decoration",
            "name":"bdg_scaleelectric",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_scaleelectric_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/scaleelectriccartoyset/",
               "1":{
                  "top":["top.png",new Point(-48,0)],
                  "shadow":["shadow.jpg",new Point(-57,8)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":69,
            "group":4,
            "subgroup":1,
            "order":12,
            "type":"decoration",
            "name":"bdg_scarecrow",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/scarecrow/",
               "1":{
                  "top":["top.png",new Point(-25,-43)],
                  "shadow":["shadow.jpg",new Point(-20,8)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":70,
            "group":4,
            "subgroup":2,
            "order":1,
            "type":"decoration",
            "name":"bdg_sundial",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_sundial_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/sundial/",
               "1":{
                  "top":["top.png",new Point(-23,-6)],
                  "shadow":["shadow.jpg",new Point(-23,8)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":71,
            "group":4,
            "subgroup":2,
            "order":7,
            "type":"decoration",
            "name":"bdg_tikitorch",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_tikitorch_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/tikitorch/",
               "1":{
                  "anim":["anim.png",new Rectangle(-11,-71,16,36),25],
                  "top":["top.png",new Point(-8,-38)],
                  "shadow":["shadow.jpg",new Point(-6,3)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":72,
            "group":4,
            "subgroup":1,
            "order":3,
            "type":"decoration",
            "name":"bdg_walnut",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_walnut_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/walnut/",
               "1":{
                  "top":["top.png",new Point(-12,-2)],
                  "shadow":["shadow.jpg",new Point(-23,3)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":73,
            "group":4,
            "subgroup":0,
            "order":15,
            "type":"decoration",
            "name":"bdg_tombstone",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_tombstone_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/graveyardtombstone/",
               "1":{
                  "top":["top.png",new Point(-22,-13)],
                  "shadow":["shadow.jpg",new Point(-20,9)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":74,
            "group":4,
            "subgroup":0,
            "order":3,
            "type":"decoration",
            "name":"bdg_pokeyhead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_pokeyhead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-pokey.png",new Point(-6,-28)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":75,
            "group":4,
            "subgroup":0,
            "order":4,
            "type":"decoration",
            "name":"bdg_octohead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_octohead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-octo.png",new Point(-6,-23)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":76,
            "group":4,
            "subgroup":0,
            "order":5,
            "type":"decoration",
            "name":"bdg_bolthead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_bolthead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-bolt.png",new Point(-10,-23)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":77,
            "group":4,
            "subgroup":0,
            "order":6,
            "type":"decoration",
            "name":"bdg_banditohead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_banditohead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-bandito.png",new Point(-5,-26)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":78,
            "group":4,
            "subgroup":0,
            "order":7,
            "type":"decoration",
            "name":"bdg_brainhead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_brainhead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-brain.png",new Point(-9,-28)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":79,
            "group":4,
            "subgroup":0,
            "order":8,
            "type":"decoration",
            "name":"bdg_crabhead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_crabhead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-crabatron.png",new Point(-10,-29)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":80,
            "group":4,
            "subgroup":0,
            "order":14,
            "type":"decoration",
            "name":"bdg_davehead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_davehead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-dave.png",new Point(-14,-30)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":81,
            "group":4,
            "subgroup":0,
            "order":9,
            "type":"decoration",
            "name":"bdg_eyerahead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_eyerahead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-eyera.png",new Point(-4,-23)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":82,
            "group":4,
            "subgroup":0,
            "order":10,
            "type":"decoration",
            "name":"bdg_fanghead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_fanghead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-fang.png",new Point(-10,-30)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":83,
            "group":4,
            "subgroup":0,
            "order":11,
            "type":"decoration",
            "name":"bdg_finkhead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_finkhead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-fink.png",new Point(-11,-29)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":84,
            "group":4,
            "subgroup":0,
            "order":12,
            "type":"decoration",
            "name":"bdg_ichihead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_ichihead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-ichi.png",new Point(-6,-29)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":85,
            "group":4,
            "subgroup":0,
            "order":13,
            "type":"decoration",
            "name":"bdg_projectxhead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_projectxhead_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-projectx.png",new Point(-19,-24)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":86,
            "group":4,
            "subgroup":1,
            "order":13,
            "type":"decoration",
            "name":"bdg_blackberrybush",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_blackberrybush_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/blackberrybush/",
               "1":{"top":["top.png",new Point(-25,-13)]}
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":87,
            "group":4,
            "subgroup":1,
            "order":16,
            "type":"decoration",
            "name":"bdg_bonsaitree",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_bonsaitree_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/bonsaitree/",
               "1":{
                  "top":["top.png",new Point(-41,-36)],
                  "shadow":["shadow.jpg",new Point(-22,15)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":88,
            "group":4,
            "subgroup":1,
            "order":14,
            "type":"decoration",
            "name":"bdg_cactus",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_cactus_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/cactus/",
               "1":{
                  "top":["top.png",new Point(-14,-30)],
                  "shadow":["shadow.jpg",new Point(-12,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":89,
            "group":4,
            "subgroup":1,
            "order":15,
            "type":"decoration",
            "name":"bdg_flytrap",
            "size":70,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_flytrap_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flytrap/",
               "1":{
                  "top":["top.png",new Point(-33,-5)],
                  "shadow":["shadow.jpg",new Point(-38,20)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":90,
            "group":4,
            "subgroup":1,
            "order":12,
            "type":"decoration",
            "name":"bdg_thorns",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_thorns_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/thorns/",
               "1":{
                  "top":["top.png",new Point(-23,-18)],
                  "shadow":["shadow.jpg",new Point(-25,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":91,
            "group":4,
            "subgroup":1,
            "order":5,
            "type":"decoration",
            "name":"bdg_pinkflowers",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_pinkflowers_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flowers/",
               "1":{
                  "top":["top-pink.png",new Point(-18,-21)],
                  "shadow":["shadow.jpg",new Point(-10,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":92,
            "group":4,
            "subgroup":1,
            "order":6,
            "type":"decoration",
            "name":"bdg_purpleflowers",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_purpleflowers_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flowers/",
               "1":{
                  "top":["top-purple.png",new Point(-18,-21)],
                  "shadow":["shadow.jpg",new Point(-10,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":93,
            "group":4,
            "subgroup":1,
            "order":9,
            "type":"decoration",
            "name":"bdg_redflowers",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_redflowers_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flowers/",
               "1":{
                  "top":["top-red.png",new Point(-18,-21)],
                  "shadow":["shadow.jpg",new Point(-10,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":94,
            "group":4,
            "subgroup":1,
            "order":7,
            "type":"decoration",
            "name":"bdg_whiteflowers",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_whiteflowers_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flowers/",
               "1":{
                  "top":["top-white.png",new Point(-18,-21)],
                  "shadow":["shadow.jpg",new Point(-10,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":95,
            "group":4,
            "subgroup":1,
            "order":8,
            "type":"decoration",
            "name":"bdg_yellowflowers",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_yellowflowers_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flowers/",
               "1":{
                  "top":["top-yellow.png",new Point(-18,-21)],
                  "shadow":["shadow.jpg",new Point(-10,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":96,
            "group":4,
            "subgroup":4,
            "order":5,
            "type":"decoration",
            "name":"bdg_baseballstatue",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_baseballstatue_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-baseball/",
               "1":{
                  "top":["top.png",new Point(-20,-36)],
                  "shadow":["shadow.jpg",new Point(-21,10)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":97,
            "group":4,
            "subgroup":4,
            "order":6,
            "type":"decoration",
            "name":"bdg_footballstatue",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_footballstatue_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-football/",
               "1":{
                  "top":["top.png",new Point(-19,-39)],
                  "shadow":["shadow.jpg",new Point(-17,10)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":98,
            "group":4,
            "subgroup":4,
            "order":7,
            "type":"decoration",
            "name":"bdg_soccerstatue",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_soccerstatue_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-soccer/",
               "1":{
                  "top":["top.png",new Point(-23,-36)],
                  "shadow":["shadow.jpg",new Point(-15,12)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":99,
            "group":4,
            "subgroup":4,
            "order":8,
            "type":"decoration",
            "name":"bdg_libertystatue",
            "size":70,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_libertystatue_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-liberty/",
               "1":{
                  "top":["top.png",new Point(-37,-118)],
                  "shadow":["shadow.jpg",new Point(-31,20)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":100,
            "group":4,
            "subgroup":4,
            "order":9,
            "type":"decoration",
            "name":"bdg_eiffelstatue",
            "size":70,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_eiffelstatue_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-eiffeltower/",
               "1":{
                  "top":["top.png",new Point(-60,-121)],
                  "shadow":["shadow.jpg",new Point(-60,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":101,
            "group":4,
            "subgroup":4,
            "order":10,
            "type":"decoration",
            "name":"bdg_bigben",
            "size":70,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_bigben_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-bigben/",
               "1":{
                  "top":["top.png",new Point(-32,-104)],
                  "shadow":["shadow.jpg",new Point(-32,19)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":102,
            "group":4,
            "subgroup":2,
            "order":13,
            "type":"decoration",
            "name":"bdg_pool",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_pool_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/pool/",
               "1":{
                  "top":["top.png",new Point(-65,8)],
                  "shadow":["shadow.jpg",new Point(-65,15)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":103,
            "group":4,
            "subgroup":2,
            "order":14,
            "type":"decoration",
            "name":"bdg_pond",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_pond_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/pond/",
               "1":{"top":["top.png",new Point(-40,14)]}
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":104,
            "group":4,
            "subgroup":2,
            "order":16,
            "type":"decoration",
            "name":"bdg_zengarden",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_zengarden_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/zengarden/",
               "1":{
                  "top":["top.png",new Point(-72,-5)],
                  "shadow":["shadow.jpg",new Point(-72,16)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":105,
            "group":4,
            "subgroup":2,
            "order":17,
            "type":"decoration",
            "name":"bdg_fountain",
            "size":70,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_fountain_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/fountain/",
               "1":{
                  "anim":["anim.png",new Rectangle(-47,-51,89,114),42],
                  "shadow":["shadow.jpg",new Point(-41,16)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":106,
            "group":4,
            "subgroup":2,
            "order":18,
            "type":"decoration",
            "name":"bdg_teagarden",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_teargarden_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/japaneseteagarden/",
               "1":{
                  "top":["top.png",new Point(-62,-38)],
                  "shadow":["shadow.jpg",new Point(-57,12)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":107,
            "group":4,
            "subgroup":0,
            "order":1,
            "type":"decoration",
            "name":"bdg_monsterskull",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_monsterskull_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-skull.png",new Point(-7,-39)],
                  "shadow":["shadow.jpg",new Point(-1,-7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":108,
            "group":4,
            "subgroup":2,
            "order":8,
            "type":"decoration",
            "name":"bdg_rubikunsolved",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_rubikunsolved_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/rubikscube/",
               "1":{
                  "top":["top-unsolved.png",new Point(-20,-23)],
                  "shadow":["shadow.jpg",new Point(-22,-5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":109,
            "group":4,
            "subgroup":2,
            "order":9,
            "type":"decoration",
            "name":"bdg_rubiksolved",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_rubiksolved_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/rubikscube/",
               "1":{
                  "top":["top-solved.png",new Point(-20,-23)],
                  "shadow":["shadow.jpg",new Point(-22,-5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":110,
            "group":4,
            "subgroup":4,
            "order":11,
            "type":"decoration",
            "name":"bdg_halloween",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_halloween_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":1000,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/pumpkins/",
               "1":{
                  "top":["attended-large-top.png",new Point(-24,-32)],
                  "shadow":["attended-large-shadow.jpg",new Point(-25,1)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":111,
            "group":4,
            "subgroup":4,
            "order":12,
            "type":"decoration",
            "name":"bdg_halloween_small",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_halloween_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":0,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/pumpkins/",
               "1":{
                  "top":["attended-small-top.png",new Point(-10,-4)],
                  "shadow":["attended-small-shadow.jpg",new Point(-12,2)]
               }
            },
            "quantity":[6],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":112,
            "group":2,
            "order":1,
            "type":"special",
            "name":"#b_outpost#",
            "size":190,
            "attackgroup":1,
            "tutstage":0,
            "sale":0,
            "description":"outpost_desc",
            "block":true,
            "quantity":[0]
         },{
            "id":113,
            "group":2,
            "order":15,
            "type":"special",
            "name":"#b_radio#",
            "size":80,
            "attackgroup":1,
            "tutstage":0,
            "sale":0,
            "description":"radio_build_desc",
            "isNew":true,
            "block":false,
            "costs":[{
               "r1":2000,
               "r2":2000,
               "r3":2000,
               "r4":0,
               "time":5 * 60,
               "re":[[14,1,2]]
            }],
            "imageData":{
               "baseurl":"buildings/radiotower/",
               "1":{
                  "top":["top.1.png",new Point(-40,-80)],
                  "topdamaged":["top.1.damaged.png",new Point(-40,-83)],
                  "topdestroyed":["top.destroyed.png",new Point(-41,11)],
                  "shadow":["shadow.1.jpg",new Point(-44,7)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-44,7)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-41,19)]
               }
            },
            "quantity":[1,1,1,1,1,1,1,1,1,1],
            "hp":[3400],
            "repairTime":[4 * 60]
         },{
            "id":114,
            "group":3,
            "order":6,
            "type":"cage",
            "name":"#b_monstercage#",
            "size":200,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"monstercage_desc",
            "costs":[{
               "r1":500000,
               "r2":500000,
               "r3":250000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,4]]
            }],
            "imageData":{
               "baseurl":"buildings/monstercage/",
               "1":{
                  "top":["top.1.png",new Point(-128,-13)],
                  "topopen":["top.1.v2.png",new Point(-129,-13)],
                  "shadow":["shadow.1.jpg",new Point(-132,10)],
                  "shadowopen":["shadow.1.jpg",new Point(-132,10)]
               }
            },
            "quantity":[0,0,0,0,1,1,1,1,1,1],
            "hp":[10000],
            "repairTime":[18 * 60]
         },{
            "id":115,
            "group":3,
            "order":5,
            "type":"tower",
            "name":"#b_flaktower#",
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"flaktower_desc",
            "stats":[{
               "range":5 * 60,
               "damage":200,
               "rate":60,
               "speed":20,
               "splash":3 * 60
            },{
               "range":320,
               "damage":250,
               "rate":60,
               "speed":24,
               "splash":185
            },{
               "range":340,
               "damage":250,
               "rate":60,
               "speed":28,
               "splash":190
            },{
               "range":6 * 60,
               "damage":250,
               "rate":60,
               "speed":32,
               "splash":195
            },{
               "range":380,
               "damage":5 * 60,
               "rate":60,
               "speed":36,
               "splash":200
            },{
               "range":400,
               "damage":350,
               "rate":60,
               "speed":40,
               "splash":215
            }],
            "costs":[{
               "r1":215000,
               "r2":280000,
               "r3":62500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,4]]
            },{
               "r1":850000,
               "r2":20 * 60 * 1000,
               "r3":250000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":2750000,
               "r2":3400000,
               "r3":750000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":5750000,
               "r2":5200000,
               "r3":1250000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":13500000,
               "r2":11000000,
               "r3":2000000,
               "r4":0,
               "time":6 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":16000000,
               "r2":14000000,
               "r3":4000000,
               "r4":0,
               "time":8 * 24 * 60 * 60,
               "re":[[14,1,9]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":215000,
               "r2":280000,
               "r3":62500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":850000,
               "r2":20 * 60 * 1000,
               "r3":250000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":2750000,
               "r2":3400000,
               "r3":750000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":5750000,
               "r2":5200000,
               "r3":1250000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[14,1,8]]
            }],
            "imageData":{
               "baseurl":"buildings/flaktower/",
               "1":{
                  "anim":["anim.3.png",new Rectangle(-32,-23,62,52),32],
                  "top":["top.3.png",new Point(-39,6)],
                  "shadow":["shadow.3.jpg",new Point(-43,14)],
                  "animdamaged":["anim.3.damaged.png",new Rectangle(-29,-17,62,53),32],
                  "topdamaged":["top.3.damaged.png",new Point(-39,5)],
                  "shadowdamaged":["shadow.3.jpg",new Point(-40,24)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-36,13)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-33,26)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-45,-13)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"115.jpg"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,0,0,0,1,2,2,2,2,2],
            "hp":[250 * 60,22000,500 * 60,800 * 60,60 * 1000,20 * 60 * 60],
            "repairTime":[32 * 60,0xf00,128 * 60,9260,200 * 60,5 * 60 * 60]
         },{
            "id":116,
            "group":2,
            "order":12,
            "type":"special",
            "name":"#b_monsterlab#",
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"monsterlab_desc",
            "costs":[{
               "r1":100000,
               "r2":100000,
               "r3":0,
               "r4":0,
               "time":3 * 60 * 60,
               "re":[[14,1,5],[8,1,3],[26,1,2]]
            },{
               "r1":5 * 60 * 1000,
               "r2":5 * 60 * 1000,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,6],[8,1,4],[26,1,3]]
            },{
               "r1":10 * 60 * 1000,
               "r2":10 * 60 * 1000,
               "r3":0,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,7],[8,1,4],[26,1,4]]
            }],
            "imageData":{
               "baseurl":"buildings/monsterlab/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-28,-30,54,48),32],
                  "anim2":["anim.2.png",new Rectangle(-66,26,33,31),5],
                  "anim3":["anim.3.png",new Rectangle(32,26,33,31),5],
                  "top":["top.1.v2.png",new Point(-74,-96)],
                  "shadow":["shadow.1.jpg",new Point(-73,-6)],
                  "topdamaged":["top.1.damaged.png",new Point(-73,-80)],
                  "shadowdamaged":["shadow.1.jpg",new Point(-72,-6)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-80,-10)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-77,2)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"116.jpg"}
            },
            "quantity":[0,0,0,0,1,1,1,1,1,1],
            "hp":[150 * 60,16000,400 * 60,32000],
            "repairTime":[3800,128 * 60,10640,260 * 60]
         },{
            "id":117,
            "group":3,
            "order":10,
            "type":"trap",
            "name":"#b_heavytrap#",
            "size":90,
            "attackgroup":4,
            "tutstage":200,
            "sale":0,
            "description":"heavytrap_desc",
            "costs":[{
               "r1":50000,
               "r2":50000,
               "r3":50000,
               "r4":0,
               "time":5,
               "re":[[14,1,4]]
            }],
            "imageData":{
               "baseurl":"buildings/heavytrap/",
               "1":{
                  "top":["top.1.png",new Point(-16,-5)],
                  "shadow":["shadow.1.jpg",new Point(-18,1)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-16,5)],
                  "shadowdestroyed":["shadow.1.jpg",new Point(-18,1)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"117.jpg"}
            },
            "quantity":[0,0,0,0,4,6,8,10,12,15],
            "damage":[10000],
            "hp":[10],
            "repairTime":[1]
         },{
            "id":118,
            "group":3,
            "order":5,
            "type":"tower",
            "name":"#b_railguntower#",
            "size":64,
            "attackgroup":3,
            "tutstage":28,
            "sale":0,
            "description":"railguntower_desc",
            "stats":[{
               "range":5 * 60,
               "damage":400,
               "rate":160,
               "speed":20,
               "splash":0
            },{
               "range":315,
               "damage":10 * 60,
               "rate":160,
               "speed":20,
               "splash":0
            },{
               "range":330,
               "damage":15 * 60,
               "rate":160,
               "speed":20,
               "splash":0
            },{
               "range":345,
               "damage":20 * 60,
               "rate":160,
               "speed":20,
               "splash":0
            },{
               "range":6 * 60,
               "damage":1600,
               "rate":160,
               "speed":20,
               "splash":0
            },{
               "range":380,
               "damage":2000,
               "rate":160,
               "speed":20,
               "splash":0
            }],
            "costs":[{
               "r1":2000000,
               "r2":40 * 60 * 1000,
               "r3":1600000,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":60 * 60 * 1000,
               "r2":50 * 24 * 60 * 60,
               "r3":800 * 60 * 60,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":75 * 24 * 60 * 60,
               "r2":90 * 24 * 60 * 60,
               "r3":60 * 24 * 60 * 60,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":135 * 24 * 60 * 60,
               "r2":162 * 24 * 60 * 60,
               "r3":108 * 24 * 60 * 60,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":16995200,
               "r2":18194240,
               "r3":16796160,
               "r4":0,
               "time":6 * 24 * 60 * 60,
               "re":[[14,1,8]]
            },{
               "r1":337 * 60 * 1000,
               "r2":24202000,
               "r3":19000000,
               "r4":0,
               "time":8 * 24 * 60 * 60,
               "re":[[14,1,9]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":2000000,
               "r2":40 * 60 * 1000,
               "r3":1600000,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[14,1,5]]
            },{
               "r1":2600000,
               "r2":3320000,
               "r3":1880000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,6]]
            },{
               "r1":4480000,
               "r2":4776000,
               "r3":2184000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[14,1,7]]
            },{
               "r1":9664000,
               "r2":9996800,
               "r3":4331200,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[14,1,8]]
            }],
            "imageData":{
               "baseurl":"buildings/railguntower/",
               "1":{
                  "anim":["anim.3.loaded.png",new Rectangle(-49,-9,96,56),32],
                  "top":["top.3.png",new Point(-39,7)],
                  "shadow":["shadow.3.jpg",new Point(-40,20)],
                  "animdamaged":["anim.3.damaged.png",new Rectangle(-49,-9,97,56),32],
                  "topdamaged":["top.3.damaged.png",new Point(-39,7)],
                  "shadowdamaged":["shadow.3.jpg",new Point(-40,20)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-34,-5)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-36,23)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-45,-13)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"118.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"118.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,0,0,0,0,2,2,2,2,2],
            "hp":[294 * 60,34400,750 * 60,58000,75500,25 * 60 * 60],
            "repairTime":[48 * 60,96 * 60,192 * 60,23000,46000,69000]
         },{
            "id":119,
            "group":3,
            "order":10,
            "type":"special",
            "name":"#b_championchamber#",
            "size":64,
            "attackgroup":3,
            "tutstage":28,
            "sale":0,
            "description":"championchamber_desc",
            "costs":[{
               "r1":500000,
               "r2":500000,
               "r3":250000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[14,1,4],[114,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/champchamber/",
               "1":{
                  "top":["top.3.png",new Point(-66,-62)],
                  "shadow":["shadow.3.jpg",new Point(-66,10)],
                  "topdamaged":["top.3.damaged.png",new Point(-66,-54)],
                  "shadowdamaged":["shadow.3.jpg",new Point(-66,4)],
                  "topdestroyed":["top.3.png",new Point(-73,-32)],
                  "shadowdestroyed":["shadow.3.jpg",new Point(-67,14)]
               }
            },
            "quantity":[0,0,0,0,1,1,1,1,1,1],
            "hp":[16000],
            "repairTime":[60 * 60]
         }];
         _outpostProps = [{
            "id":1,
            "group":1,
            "order":1,
            "type":"resource",
            "name":"#b_twigsnapper#",
            "size":100,
            "cycle":30,
            "attackgroup":1,
            "tutstage":0,
            "sale":0,
            "description":"twigsnapper_desc",
            "costs":[{
               "r1":0,
               "r2":750,
               "r3":0,
               "r4":0,
               "time":15,
               "re":[[112,1,1]]
            },{
               "r1":0,
               "r2":1575,
               "r3":0,
               "r4":0,
               "time":5 * 60,
               "re":[[112,1,1]]
            },{
               "r1":0,
               "r2":55 * 60,
               "r3":0,
               "r4":0,
               "time":20 * 60,
               "re":[[112,1,1]]
            },{
               "r1":0,
               "r2":6950,
               "r3":0,
               "r4":0,
               "time":60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":0,
               "r2":14500,
               "r3":0,
               "r4":0,
               "time":2 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":0,
               "r2":0x7788,
               "r3":0,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":0,
               "r2":64300,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":0,
               "r2":135000,
               "r3":0,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":0,
               "r2":283600,
               "r3":0,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":0,
               "r2":10 * 60 * 1000,
               "r3":0,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/twigsnapper.v2/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-4,10,23,33),34],
                  "top":["top.1.png",new Point(-30,-19)],
                  "shadow":["shadow.1.jpg",new Point(-23,29)],
                  "topdamaged":["top.1.damaged.png",new Point(-30,-19)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-28,28)],
                  "topdestroyed":["top.destroyed.png",new Point(-34,2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-31,20)]
               },
               "3":{
                  "anim":["anim.3.png",new Rectangle(0,6,23,30),34],
                  "top":["top.3.png",new Point(-32,-40)],
                  "shadow":["shadow.3.jpg",new Point(-38,11)],
                  "topdamaged":["top.3.damaged.png",new Point(-33,-37)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-27,25)],
                  "topdestroyed":["top.destroyed.png",new Point(-34,2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-31,20)]
               },
               "6":{
                  "anim":["anim.6.png",new Rectangle(-1,1,34,34),34],
                  "top":["top.6.png",new Point(-34,-42)],
                  "shadow":["shadow.6.jpg",new Point(-25,26)],
                  "topdamaged":["top.6.damaged.png",new Point(-35,-42)],
                  "shadowdamaged":["shadow.6.damaged.jpg",new Point(-28,25)],
                  "topdestroyed":["top.destroyed.png",new Point(-34,2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-31,20)]
               },
               "10":{
                  "anim":["anim.10.png",new Rectangle(-2,3,35,33),34],
                  "top":["top.10.png",new Point(-34,-54)],
                  "shadow":["shadow.10.jpg",new Point(-26,26)],
                  "topdamaged":["top.10.damaged.png",new Point(-35,-41)],
                  "shadowdamaged":["shadow.10.damaged.jpg",new Point(-28,22)],
                  "topdestroyed":["top.destroyed.png",new Point(-34,2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-31,20)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"1.1.jpg"},
               "3":{"img":"1.3.jpg"},
               "6":{"img":"1.6.jpg"},
               "10":{"img":"1.10.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"1.1.png"},
               "3":{"img":"1.3.png"},
               "6":{"img":"1.6.png"},
               "10":{"img":"1.10.png"}
            },
            "quantity":[0,4],
            "produce":[2,4,7,11,16,22,29,37,46,56],
            "cycleTime":[10,10,10,10,10,10,10,10,10,10],
            "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
            "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
            "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
         },{
            "id":2,
            "group":1,
            "order":2,
            "type":"resource",
            "name":"#b_pebbleshiner#",
            "size":100,
            "cycle":30,
            "attackgroup":1,
            "tutstage":0,
            "sale":0,
            "description":"pebbleshiner_desc",
            "costs":[{
               "r1":750,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":15,
               "re":[[112,1,1]]
            },{
               "r1":1575,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":5 * 60,
               "re":[[112,1,1]]
            },{
               "r1":55 * 60,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":20 * 60,
               "re":[[112,1,1]]
            },{
               "r1":6950,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":14500,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":2 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":0x7788,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":64300,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":135000,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":283600,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":10 * 60 * 1000,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/pebbleshiner.v2/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-21,8,42,24),26],
                  "top":["top.1.png",new Point(-34,-12)],
                  "shadow":["shadow.1.jpg",new Point(-33,27)],
                  "topdamaged":["top.1.damaged.png",new Point(-34,-6)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-31,27)],
                  "topdestroyed":["top.destroyed.png",new Point(-35,-2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-33,22)]
               },
               "3":{
                  "anim":["anim.3.png",new Rectangle(-29,3,58,31),26],
                  "top":["top.3.png",new Point(-34,-27)],
                  "shadow":["shadow.3.jpg",new Point(-33,27)],
                  "topdamaged":["top.3.damaged.png",new Point(-33,-26)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-31,22)],
                  "topdestroyed":["top.destroyed.png",new Point(-35,-2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-32,22)]
               },
               "6":{
                  "anim":["anim.6.png",new Rectangle(-29,-5,58,41),26],
                  "top":["top.6.png",new Point(-34,-34)],
                  "shadow":["shadow.6.jpg",new Point(-34,20)],
                  "topdamaged":["top.6.damaged.png",new Point(-45,-32)],
                  "shadowdamaged":["shadow.6.damaged.jpg",new Point(-34,20)],
                  "topdestroyed":["top.destroyed.png",new Point(-35,-2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-33,22)]
               },
               "10":{
                  "anim":["anim.10.png",new Rectangle(-29,-37,62,72),24],
                  "top":["top.10.png",new Point(-34,-32)],
                  "shadow":["shadow.10.jpg",new Point(-34,22)],
                  "topdamaged":["top.10.damaged.png",new Point(-34,-36)],
                  "shadowdamaged":["shadow.10.damaged.jpg",new Point(-34,15)],
                  "topdestroyed":["top.destroyed.png",new Point(-35,-2)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-33,22)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"2.1.jpg"},
               "3":{"img":"2.3.jpg"},
               "6":{"img":"2.6.jpg"},
               "10":{"img":"2.10.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"2.1.png"},
               "3":{"img":"2.3.png"},
               "6":{"img":"2.6.png"},
               "10":{"img":"2.10.png"}
            },
            "quantity":[0,4],
            "produce":[2,4,7,11,16,22,29,37,46,56],
            "cycleTime":[10,10,10,10,10,10,10,10,10,10],
            "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
            "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
            "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
         },{
            "id":3,
            "group":1,
            "order":3,
            "type":"resource",
            "name":"#b_puttysquisher#",
            "size":100,
            "cycle":30,
            "attackgroup":1,
            "tutstage":80,
            "sale":0,
            "description":"puttysquisher_desc",
            "costs":[{
               "r1":525,
               "r2":224,
               "r3":0,
               "r4":0,
               "time":20,
               "re":[[112,1,1]]
            },{
               "r1":1102,
               "r2":470,
               "r3":0,
               "r4":0,
               "time":5 * 60,
               "re":[[112,1,1]]
            },{
               "r1":2315,
               "r2":992,
               "r3":0,
               "r4":0,
               "time":20 * 60,
               "re":[[112,1,1]]
            },{
               "r1":4862,
               "r2":2086,
               "r3":0,
               "r4":0,
               "time":60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":10210,
               "r2":4375,
               "r3":0,
               "r4":0,
               "time":2 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":21441,
               "r2":9190,
               "r3":0,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":45027,
               "r2":19298,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":94557,
               "r2":40524,
               "r3":0,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":198570,
               "r2":85102,
               "r3":0,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":416997,
               "r2":178716,
               "r3":0,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/puttysquisher.v2/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-10,8,28,18),26],
                  "top":["top.1.png",new Point(-26,5)],
                  "shadow":["shadow.1.jpg",new Point(-21,29)],
                  "topdamaged":["top.1.damaged.png",new Point(-29,4)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-28,28)],
                  "topdestroyed":["top.destroyed.png",new Point(-39,5)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-36,21)]
               },
               "3":{
                  "anim":["anim.3.png",new Rectangle(-10,-7,29,20),26],
                  "top":["top.3.png",new Point(-28,-20)],
                  "shadow":["shadow.3.jpg",new Point(-33,18)],
                  "topdamaged":["top.3.damaged.png",new Point(-38,-20)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-37,26)],
                  "topdestroyed":["top.destroyed.png",new Point(-39,5)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-36,21)]
               },
               "6":{
                  "anim":["anim.6.png",new Rectangle(-10,-6,29,19),26],
                  "top":["top.6.png",new Point(-30,-43)],
                  "shadow":["shadow.6.jpg",new Point(-28,23)],
                  "topdamaged":["top.6.damaged.png",new Point(-28,-38)],
                  "shadowdamaged":["shadow.6.damaged.jpg",new Point(-29,25)],
                  "topdestroyed":["top.destroyed.png",new Point(-39,5)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-36,21)]
               },
               "10":{
                  "anim":["anim.10.png",new Rectangle(-10,-39,44,52),25],
                  "top":["top.10.png",new Point(-31,-42)],
                  "shadow":["shadow.10.jpg",new Point(-31,22)],
                  "topdamaged":["top.10.damaged.png",new Point(-40,-40)],
                  "shadowdamaged":["shadow.10.damaged.jpg",new Point(-38,24)],
                  "topdestroyed":["top.destroyed.png",new Point(-39,5)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-36,21)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"3.1.jpg"},
               "3":{"img":"3.3.v2.jpg"},
               "6":{"img":"3.6.v2.jpg"},
               "10":{"img":"3.10.v2.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"3.1.png"},
               "3":{"img":"3.3.png"},
               "6":{"img":"3.6.png"},
               "10":{"img":"3.10.png"}
            },
            "quantity":[0,4],
            "produce":[2,4,7,11,16,22,29,37,46,56],
            "cycleTime":[10,10,10,10,10,10,10,10,10,10],
            "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
            "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
            "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
         },{
            "id":4,
            "group":1,
            "order":4,
            "type":"resource",
            "name":"#b_goofactory#",
            "size":100,
            "cycle":30,
            "attackgroup":1,
            "tutstage":80,
            "sale":0,
            "description":"goofactory_desc",
            "costs":[{
               "r1":247,
               "r2":577,
               "r3":0,
               "r4":0,
               "time":20,
               "re":[[112,1,1]]
            },{
               "r1":520,
               "r2":1212,
               "r3":0,
               "r4":0,
               "time":5 * 60,
               "re":[[112,1,1]]
            },{
               "r1":1090,
               "r2":2546,
               "r3":0,
               "r4":0,
               "time":20 * 60,
               "re":[[112,1,1]]
            },{
               "r1":2290,
               "r2":5348,
               "r3":0,
               "r4":0,
               "time":60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":4810,
               "r2":11231,
               "r3":0,
               "r4":0,
               "time":2 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":10108,
               "r2":23585,
               "r3":0,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":21227,
               "r2":49529,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":743 * 60,
               "r2":104012,
               "r3":0,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":26 * 60 * 60,
               "r2":218427,
               "r3":0,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":196584,
               "r2":458696,
               "r3":0,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/goofactory.v2/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(3,14,22,40),26],
                  "top":["top.1.png",new Point(-26,-33)],
                  "shadow":["shadow.1.jpg",new Point(-25,29)],
                  "topdamaged":["top.1.damaged.png",new Point(-32,-15)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-30,27)],
                  "topdestroyed":["top.destroyed.png",new Point(-31,0)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-35,24)]
               },
               "3":{
                  "anim":["anim.3.png",new Rectangle(4,12,25,45),26],
                  "top":["top.3.png",new Point(-27,-33)],
                  "shadow":["shadow.3.jpg",new Point(-31,21)],
                  "topdamaged":["top.3.damaged.png",new Point(-28,-31)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-31,20)],
                  "topdestroyed":["top.destroyed.png",new Point(-31,0)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-35,24)]
               },
               "6":{
                  "anim":["anim.6.png",new Rectangle(-21,12,51,48),26],
                  "top":["top.6.png",new Point(-33,-33)],
                  "shadow":["shadow.6.jpg",new Point(-26,27)],
                  "topdamaged":["top.6.damaged.png",new Point(-37,-29)],
                  "shadowdamaged":["shadow.6.damaged.jpg",new Point(-36,25)],
                  "topdestroyed":["top.destroyed.png",new Point(-31,0)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-35,24)]
               },
               "10":{
                  "anim":["anim.10.png",new Rectangle(-21,11,51,47),26],
                  "top":["top.10.png",new Point(-40,-48)],
                  "shadow":["shadow.10.jpg",new Point(-35,28)],
                  "topdamaged":["top.10.damaged.png",new Point(-45,-42)],
                  "shadowdamaged":["shadow.10.damaged.jpg",new Point(-37,25)],
                  "topdestroyed":["top.destroyed.png",new Point(-31,0)],
                  "shadowdestroyed":["shadow.destroyed.jpg",new Point(-35,24)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"4.1.jpg"},
               "3":{"img":"4.3.jpg"},
               "6":{"img":"4.6.jpg"},
               "10":{"img":"4.10.jpg"}
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"4.1.png"},
               "3":{"img":"4.3.png"},
               "6":{"img":"4.6.png"},
               "10":{"img":"4.10.png"}
            },
            "quantity":[0,4],
            "produce":[2,4,7,11,16,22,29,37,46,56],
            "cycleTime":[10,10,10,10,10,10,10,10,10,10],
            "capacity":[12 * 60,36 * 60,5670,13365,486 * 60,60142,118918,227584,424414,775018],
            "hp":[500,950,30 * 60,3400,6500,200 * 60,400 * 60,750 * 60,85000,165000],
            "repairTime":[30,60,2 * 60,4 * 60,8 * 60,16 * 60,32 * 60,0xf00,128 * 60,256 * 60]
         },{
            "id":5,
            "group":2,
            "order":9,
            "type":"special",
            "name":"#b_flinger#",
            "size":190,
            "attackgroup":1,
            "tutstage":60,
            "sale":0,
            "description":"flinger_desc",
            "costs":[{
               "r1":10000,
               "r2":10000,
               "r3":5000,
               "r4":0,
               "time":15 * 60,
               "re":[[112,1,1]]
            },{
               "r1":64300,
               "r2":64300,
               "r3":32150,
               "r4":0,
               "time":3 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":283600,
               "r2":283600,
               "r3":141800,
               "r4":0,
               "time":9 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":1247840,
               "r2":1247840,
               "r3":623920,
               "r4":0,
               "time":27 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/flinger/",
               "1":{
                  "top":["top.1.png",new Point(-46,-43)],
                  "shadow":["shadow.1.jpg",new Point(-50,20)],
                  "topdamaged":["top.1.damaged.png",new Point(-63,-36)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-63,23)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
               },
               "2":{
                  "top":["top.2.png",new Point(-45,-40)],
                  "shadow":["shadow.2.jpg",new Point(-48,19)],
                  "topdamaged":["top.2.damaged.png",new Point(-63,-18)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-63,26)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
               },
               "3":{
                  "top":["top.3.png",new Point(-47,-45)],
                  "shadow":["shadow.3.jpg",new Point(-44,20)],
                  "topdamaged":["top.3.damaged.png",new Point(-75,-37)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-73,23)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
               },
               "4":{
                  "top":["top.4.png",new Point(-45,-66)],
                  "shadow":["shadow.4.jpg",new Point(-47,22)],
                  "topdamaged":["top.4.damaged.png",new Point(-76,-53)],
                  "shadowdamaged":["shadow.4.damaged.jpg",new Point(-76,23)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-75,-3)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-70,24)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"5.1.jpg"},
               "2":{"img":"5.2.jpg"},
               "3":{"img":"5.3.jpg"},
               "4":{"img":"5.4.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"5.1.png"},
               "2":{"img":"5.2.png"},
               "3":{"img":"5.3.png"},
               "4":{"img":"5.4.png"}
            },
            "quantity":[0,1,1,1,1,1,1,1],
            "capacity":[500,1000,1750,2250,50 * 60,0xfa0],
            "hp":[0xfa0,0x1f40,16000,28000],
            "repairTime":[100,5 * 60,10 * 60,15 * 60]
         },{
            "id":6,
            "group":1,
            "order":5,
            "type":"special",
            "name":"#b_storagesilo#",
            "size":2 * 60,
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"storagesilo_desc",
            "block":true,
            "quantity":[0,0]
         },{
            "id":7,
            "group":999,
            "order":1,
            "type":"mushroom",
            "name":"#b_mushroom#",
            "size":10,
            "attackgroup":0,
            "tutstage":0,
            "sale":0,
            "description":"flag_desc",
            "quantity":[0],
            "hp":[10],
            "repairTime":[10]
         },{
            "id":8,
            "group":2,
            "order":3,
            "type":"special",
            "name":"#b_monsterlocker#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"monsterlocker_desc",
            "block":true,
            "quantity":[0,0]
         },{
            "id":9,
            "group":2,
            "order":14,
            "type":"special",
            "name":"#b_monsterjuicer#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"monsterjuicer_desc",
            "costs":[{
               "r1":1000000,
               "r2":1000000,
               "r3":1000000,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1],[15,1,1]]
            },{
               "r1":250000,
               "r2":250000,
               "r3":0,
               "r4":0,
               "time":6 * 60 * 60,
               "re":[[112,1,1],[15,1,1]]
            },{
               "r1":500000,
               "r2":500000,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1],[15,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/monsterjuiceloosener/",
               "1":{
                  "anim":["anim.2.png",new Rectangle(-30,-17,60,39),51],
                  "top":["top.2.png",new Point(-44,-8)],
                  "shadow":["shadow.2.jpg",new Point(-44,16)],
                  "topdamaged":["top.2.damaged.png",new Point(-59,-8)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-59,21)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-55,0)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-49,17)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"9.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"9.png"}
            },
            "quantity":[0,1],
            "hp":[16000,32000,64000],
            "repairTime":[8 * 60,32 * 60,128 * 60]
         },{
            "id":10,
            "group":2,
            "order":13,
            "type":"special",
            "name":"#b_yardplanner#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"yardplanner_desc",
            "costs":[{
               "r1":125000,
               "r2":125000,
               "r3":0,
               "r4":0,
               "r5":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/yardplanner/",
               "1":{
                  "top":["top.1.png",new Point(-45,-29)],
                  "shadow":["shadow.1.jpg",new Point(-57,16)],
                  "topdamaged":["top.1.damaged.png",new Point(-58,-27)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-46,23)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-52,6)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-50,32)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"10.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"10.png"}
            },
            "quantity":[0,1,1,1,1,1,1,1],
            "hp":[16000],
            "repairTime":[0xf00]
         },{
            "id":11,
            "group":2,
            "order":11,
            "type":"special",
            "name":"#b_maproom#",
            "size":2 * 60,
            "attackgroup":1,
            "tutstage":80,
            "sale":0,
            "description":"maproom_desc",
            "block":true,
            "quantity":[0,0]
         },{
            "id":12,
            "group":2,
            "order":2,
            "type":"special",
            "name":"#b_generalstore#",
            "size":80,
            "attackgroup":2,
            "tutstage":0,
            "sale":0,
            "description":"generalstore_desc",
            "block":true,
            "quantity":[0,0]
         },{
            "id":13,
            "group":2,
            "order":7,
            "type":"special",
            "name":"#b_hatchery#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":140,
            "sale":0,
            "description":"hatchery_desc",
            "costs":[{
               "r1":2000,
               "r2":2000,
               "r3":0,
               "r4":0,
               "time":15 * 60,
               "re":[[112,1,1],[15,1,1]]
            },{
               "r1":21227,
               "r2":49529,
               "r3":0,
               "r4":0,
               "time":60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":26 * 60 * 60,
               "r2":218427,
               "r3":0,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/hatchery/",
               "1":{
                  "anim":["anim.2.png",new Rectangle(-53,-104,103,80),31],
                  "top":["top.2.png",new Point(-50,-52)],
                  "shadow":["shadow.2.jpg",new Point(-31,32)],
                  "topdamaged":["top.2.damaged.png",new Point(-78,-92)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-48,36)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-58,0)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-58,32)]
               },
               "2":{
                  "anim":["anim.3.png",new Rectangle(-40,-123,105,124),31],
                  "top":["top.3.png",new Point(-51,-62)],
                  "shadow":["shadow.3.jpg",new Point(-48,26)],
                  "topdamaged":["top.3.damaged.png",new Point(-53,-113)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-45,32)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-58,0)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-58,32)]
               },
               "3":{
                  "anim":["anim.4.png",new Rectangle(-12,-112,113,105),31],
                  "top":["top.4.png",new Point(-50,-114)],
                  "shadow":["shadow.4.jpg",new Point(-44,25)],
                  "topdamaged":["top.4.damaged.png",new Point(-60,-117)],
                  "shadowdamaged":["shadow.4.damaged.jpg",new Point(-52,23)],
                  "topdestroyed":["top.4.destroyed.png",new Point(-58,0)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-58,32)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"13.1.jpg"},
               "2":{"img":"13.2.jpg"},
               "3":{"img":"13.3.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"13.1.png"},
               "2":{"img":"13.2.png"},
               "3":{"img":"13.3.png"}
            },
            "quantity":[0,2],
            "hp":[0xfa0,16000,32000],
            "repairTime":[60,150,5 * 60]
         },{
            "id":14,
            "group":2,
            "order":1,
            "type":"special",
            "name":"#b_townhall#",
            "size":190,
            "attackgroup":1,
            "tutstage":0,
            "sale":0,
            "description":"townhall_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":10,
               "re":[]
            },{
               "r1":7000,
               "r2":7000,
               "r3":0,
               "r4":0,
               "time":10 * 60,
               "re":[[112,1,1]]
            },{
               "r1":700 * 60,
               "r2":700 * 60,
               "r3":0,
               "r4":0,
               "time":4 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":4 * 60 * 1000,
               "r2":4 * 60 * 1000,
               "r3":0,
               "r4":0,
               "time":16 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":1400000,
               "r2":1400000,
               "r3":0,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":7560000,
               "r2":7560000,
               "r3":0,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":11340000,
               "r2":11340000,
               "r3":0,
               "r4":0,
               "time":6 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/townhall/",
               "1":{
                  "top":["top.1.png",new Point(-45,-52)],
                  "shadow":["shadow.1.jpg",new Point(-55,37)],
                  "topdamaged":["top.1.damaged.png",new Point(-50,-50)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-55,38)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-57,17)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-54,37)],
                  "topdestroyedfire":["top.1.destroyed.fire.png",new Point(-57,17)]
               },
               "2":{
                  "top":["top.2.png",new Point(-48,-62)],
                  "shadow":["shadow.2.jpg",new Point(-55,36)],
                  "topdamaged":["top.2.damaged.png",new Point(-49,-59)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-65,32)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-61,6)],
                  "shadowdestroyed":["shadow.2.destroyed.jpg",new Point(-59,28)],
                  "topdestroyedfire":["top.2.destroyed.fire.png",new Point(-61,6)]
               },
               "3":{
                  "top":["top.3.png",new Point(-65,-67)],
                  "shadow":["shadow.3.jpg",new Point(-70,28)],
                  "topdamaged":["top.3.damaged.png",new Point(-69,-68)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-74,29)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-70,-8)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-70,30)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-70,-8)]
               },
               "4":{
                  "top":["top.4.png",new Point(-66,-72)],
                  "shadow":["shadow.4.jpg",new Point(-88,20)],
                  "topdamaged":["top.4.damaged.png",new Point(-66,-72)],
                  "shadowdamaged":["shadow.4.damaged.jpg",new Point(-77,25)],
                  "topdestroyed":["top.4.destroyed.png",new Point(-92,-18)],
                  "shadowdestroyed":["shadow.4.destroyed.jpg",new Point(-91,25)],
                  "topdestroyedfire":["top.4.destroyed.fire.png",new Point(-92,-18)]
               },
               "5":{
                  "top":["top.5.png",new Point(-67,-75)],
                  "shadow":["shadow.5.jpg",new Point(-67,33)],
                  "topdamaged":["top.5.damaged.png",new Point(-70,-69)],
                  "shadowdamaged":["shadow.5.damaged.jpg",new Point(-17,20)],
                  "topdestroyed":["top.5.destroyed.png",new Point(-89,-16)],
                  "shadowdestroyed":["shadow.5.destroyed.jpg",new Point(-88,30)],
                  "topdestroyedfire":["top.5.destroyed.fire.png",new Point(-89,-16)]
               },
               "6":{
                  "top":["top.6.png",new Point(-72,-82)],
                  "shadow":["shadow.6.jpg",new Point(-84,26)],
                  "topdamaged":["top.6.damaged.png",new Point(-72,-67)],
                  "shadowdamaged":["shadow.6.damaged.jpg",new Point(-85,25)],
                  "topdestroyed":["top.6.destroyed.png",new Point(-92,-8)],
                  "shadowdestroyed":["shadow.6.destroyed.jpg",new Point(-90,25)],
                  "topdestroyedfire":["top.6.destroyed.fire.png",new Point(-92,-8)]
               },
               "7":{
                  "top":["top.7.png",new Point(-81,-88)],
                  "shadow":["shadow.7.jpg",new Point(-121,-3)],
                  "topdamaged":["top.7.damaged.png",new Point(-81,-89)],
                  "shadowdamaged":["shadow.7.damaged.jpg",new Point(-103,3)],
                  "topdestroyed":["top.7.destroyed.png",new Point(-84,-13)],
                  "shadowdestroyed":["shadow.7.destroyed.jpg",new Point(-102,8)]
               },
               "8":{
                  "top":["top.8.png",new Point(-80,-87)],
                  "shadow":["shadow.8.jpg",new Point(-94,8)],
                  "topdamaged":["top.8.damaged.png",new Point(-86,-91)],
                  "shadowdamaged":["shadow.8.damaged.jpg",new Point(-86,13)],
                  "topdestroyed":["top.8.destroyed.png",new Point(-84,-13)],
                  "shadowdestroyed":["shadow.8.destroyed.jpg",new Point(-102,8)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"14.1.jpg"},
               "2":{"img":"14.2.jpg"},
               "3":{"img":"14.3.jpg"},
               "4":{"img":"14.4.jpg"},
               "5":{"img":"14.5.jpg"},
               "6":{"img":"14.6.jpg"},
               "7":{"img":"14.7.jpg"},
               "8":{"img":"14.8.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"14.1.png"},
               "2":{"img":"14.2.png"},
               "3":{"img":"14.3.png"},
               "4":{"img":"14.4.png"},
               "5":{"img":"14.5.png"},
               "6":{"img":"14.6.png"},
               "7":{"img":"14.7.png"},
               "8":{"img":"14.8.png"}
            },
            "quantity":[1,1,1,1,1,1,1,1,1],
            "hp":[0xfa0,8800,20000,700 * 60,94000,200000,5 * 60 * 1000,400000],
            "repairTime":[8 * 60,32 * 60,0xf00,128 * 60,256 * 60,512 * 60,18 * 60 * 60,24 * 60 * 60]
         },{
            "id":15,
            "group":2,
            "order":6,
            "type":"special",
            "name":"#b_housing#",
            "size":200,
            "attackgroup":2,
            "tutstage":50,
            "sale":0,
            "description":"housing_desc",
            "costs":[{
               "r1":36 * 60,
               "r2":36 * 60,
               "r3":0,
               "r4":0,
               "time":5 * 60,
               "re":[[112,1,1]]
            },{
               "r1":144 * 60,
               "r2":144 * 60,
               "r3":0,
               "r4":0,
               "time":75 * 60,
               "re":[[112,1,1]]
            },{
               "r1":576 * 60,
               "r2":576 * 60,
               "r3":0,
               "r4":0,
               "time":3 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":138240,
               "r2":138240,
               "r3":0,
               "r4":0,
               "time":0x7080,
               "re":[[112,1,1]]
            },{
               "r1":552960,
               "r2":552960,
               "r3":0,
               "r4":0,
               "time":20 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":2211840,
               "r2":2211840,
               "r3":0,
               "r4":0,
               "time":40 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/monsterhousing/",
               "1":{
                  "top":["top.3.v2.png",new Point(-109,11)],
                  "shadow":["shadow.3.v2.jpg",new Point(-112,23)],
                  "topdamaged":["top.3.damaged.v2.png",new Point(-107,12)],
                  "shadowdamaged":["shadow.3.damaged.v2.jpg",new Point(-110,25)],
                  "topdestroyed":["top.3.destroyed.v2.png",new Point(-108,21)],
                  "shadowdestroyed":["shadow.3.destroyed.v2.jpg",new Point(-109,25)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"15.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"15.png"}
            },
            "quantity":[0,1],
            "capacity":[200,260,320,380,450,9 * 60],
            "hp":[0xfa0,14000,25000,43000,75000,130000],
            "repairTime":[100,200,5 * 60,400,500,10 * 60]
         },{
            "id":16,
            "group":2,
            "order":8,
            "type":"special",
            "name":"#b_hcc#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"hcc_desc",
            "costs":[{
               "r1":500000,
               "r2":500000,
               "r3":500000,
               "r4":0,
               "time":25 * 60 * 60,
               "re":[[112,1,1],[13,2,1]]
            }],
            "imageData":{
               "baseurl":"buildings/hatcherycontrolcenter/",
               "1":{
                  "top":["top.1.png",new Point(-40,-58)],
                  "shadow":["shadow.1.jpg",new Point(-51,20)],
                  "topdamaged":["top.1.damaged.png",new Point(-51,-59)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-50,25)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-53,-7)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-57,24)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"16.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"16.png"}
            },
            "quantity":[0,1],
            "hp":[64000],
            "repairTime":[5 * 60]
         },{
            "id":17,
            "group":3,
            "order":7,
            "type":"wall",
            "name":"#b_woodenblock#",
            "size":50,
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"woodenblock_desc",
            "costs":[{
               "r1":1000,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[112,1,1]]
            },{
               "r1":0,
               "r2":10000,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[112,1,1]]
            },{
               "r1":100000,
               "r2":100000,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[112,1,1]]
            },{
               "r1":200000,
               "r2":200000,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[112,1,1]]
            },{
               "r1":400000,
               "r2":400000,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/walls/",
               "1":{
                  "top":["top.1.png",new Point(-21,-21)],
                  "shadow":["shadow.jpg",new Point(-28,-7)],
                  "topdamaged":["top.1.damaged.png",new Point(-21,-21)],
                  "shadowdamaged":["shadow.jpg",new Point(-28,-7)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-21,-5)],
                  "shadowdestroyed":["shadow.jpg",new Point(-28,-7)]
               },
               "2":{
                  "top":["top.2.png",new Point(-20,-20)],
                  "shadow":["shadow.jpg",new Point(-28,-7)],
                  "topdamaged":["top.2.damaged.png",new Point(-21,-20)],
                  "shadowdamaged":["shadow.jpg",new Point(-28,-7)],
                  "topdestroyed":["top.2.destroyed.png",new Point(-19,0)],
                  "shadowdestroyed":["shadow.jpg",new Point(-28,-7)]
               },
               "3":{
                  "top":["top.3.png",new Point(-21,-21)],
                  "shadow":["shadow.jpg",new Point(-28,-7)],
                  "topdamaged":["top.3.damaged.png",new Point(-22,-21)],
                  "shadowdamaged":["shadow.jpg",new Point(-28,-7)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-21,-3)],
                  "shadowdestroyed":["shadow.jpg",new Point(-28,-7)]
               },
               "4":{
                  "top":["top.4.v2.png",new Point(-20,-22)],
                  "shadow":["shadow.jpg",new Point(-28,-7)],
                  "topdamaged":["top.4.damaged.v2.png",new Point(-20,-22)],
                  "shadowdamaged":["shadow.jpg",new Point(-28,-7)],
                  "topdestroyed":["top.4.destroyed.png",new Point(-20,-2)],
                  "shadowdestroyed":["shadow.jpg",new Point(-28,-7)]
               },
               "5":{
                  "top":["top.5.png",new Point(-20,-22)],
                  "shadow":["shadow.jpg",new Point(-28,-7)],
                  "topdamaged":["top.5.damaged.png",new Point(-20,-19)],
                  "shadowdamaged":["shadow.jpg",new Point(-28,-7)],
                  "topdestroyed":["top.5.destroyed.png",new Point(-20,-3)],
                  "shadowdestroyed":["shadow.jpg",new Point(-28,-7)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"17.1.jpg"},
               "2":{"img":"17.2.v2.jpg"},
               "3":{"img":"17.3.v2.jpg"},
               "4":{"img":"17.4.jpg"},
               "5":{"img":"17.5.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"17.1.png"},
               "2":{"img":"17.2.png"},
               "3":{"img":"17.3.png"},
               "4":{"img":"17.4.png"},
               "5":{"img":"17.5.png"}
            },
            "quantity":[0,100],
            "hp":[1000,2300,5750,5 * 60 * 60,450 * 60],
            "repairTime":[5,5,5,5,5]
         },{
            "id":18,
            "group":3,
            "order":7,
            "type":"wall",
            "name":"#b_stoneblock#",
            "size":50,
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"stoneblock_desc",
            "block":true,
            "quantity":[0,0]
         },{
            "id":19,
            "group":2,
            "order":12,
            "type":"special",
            "name":"#b_wildmonsterbaiter#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"wildmonsterbaiter_desc",
            "block":true,
            "quantity":[0,0]
         },{
            "id":20,
            "group":3,
            "order":2,
            "type":"tower",
            "name":"#b_cannontower#",
            "size":64,
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"cannontower_desc",
            "stats":[{
               "range":160,
               "damage":20,
               "rate":40,
               "speed":5,
               "splash":30
            },{
               "range":170,
               "damage":40,
               "rate":40,
               "speed":6,
               "splash":35
            },{
               "range":3 * 60,
               "damage":60,
               "rate":40,
               "speed":7,
               "splash":40
            },{
               "range":190,
               "damage":80,
               "rate":40,
               "speed":8,
               "splash":45
            },{
               "range":200,
               "damage":100,
               "rate":40,
               "speed":8,
               "splash":50
            },{
               "range":210,
               "damage":2 * 60,
               "rate":40,
               "speed":8,
               "splash":55
            },{
               "range":220,
               "damage":140,
               "rate":40,
               "speed":8,
               "splash":60
            },{
               "range":230,
               "damage":160,
               "rate":40,
               "speed":8,
               "splash":65
            },{
               "range":4 * 60,
               "damage":3 * 60,
               "rate":40,
               "speed":8,
               "splash":70
            },{
               "range":250,
               "damage":200,
               "rate":40,
               "speed":8,
               "splash":75
            }],
            "costs":[{
               "r1":2000,
               "r2":25 * 60,
               "r3":500,
               "r4":0,
               "time":30,
               "re":[[112,1,1]]
            },{
               "r1":10000,
               "r2":125 * 60,
               "r3":2500,
               "r4":0,
               "time":15 * 60,
               "re":[[112,1,1]]
            },{
               "r1":50000,
               "r2":625 * 60,
               "r3":12500,
               "r4":0,
               "time":45 * 60,
               "re":[[112,1,1]]
            },{
               "r1":250000,
               "r2":187500,
               "r3":62500,
               "r4":0,
               "time":135 * 60,
               "re":[[112,1,1]]
            },{
               "r1":1250000,
               "r2":937500,
               "r3":312500,
               "r4":0,
               "time":405 * 60,
               "re":[[112,1,1]]
            },{
               "r1":6250000,
               "r2":4687500,
               "r3":1562500,
               "r4":0,
               "time":72900,
               "re":[[112,1,1]]
            },{
               "r1":9375000,
               "r2":7000000,
               "r3":1562500,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":14000000,
               "r2":175 * 60 * 1000,
               "r3":1562500,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":0x1406f40,
               "r2":15800000,
               "r3":1562500,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":31600000,
               "r2":395 * 60 * 1000,
               "r3":1562500,
               "r4":0,
               "time":132 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":50000,
               "r2":625 * 60,
               "r3":12500,
               "r4":0,
               "time":135 * 60,
               "re":[[112,1,1]]
            },{
               "r1":250000,
               "r2":187500,
               "r3":62500,
               "r4":0,
               "time":405 * 60,
               "re":[[112,1,1]]
            },{
               "r1":1250000,
               "r2":937500,
               "r3":312500,
               "r4":0,
               "time":72900,
               "re":[[112,1,1]]
            },{
               "r1":6250000,
               "r2":4687500,
               "r3":1562500,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/cannontower/",
               "1":{
                  "top":["top.3.png",new Point(-33,-25)],
                  "shadow":["shadow.3.jpg",new Point(-38,20)],
                  "topdamaged":["top.3.damaged.png",new Point(-48,-25)],
                  "shadowdamaged":["shadow.3.jpg",new Point(-47,20)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-46,8)],
                  "shadowdestroyed":["shadow.3.jpg",new Point(-43,22)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-46,8)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"20.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"20.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,4],
            "hp":[100 * 60,150 * 60,210 * 60,294 * 60,441 * 60,34400,750 * 60,58000,75500,98200],
            "repairTime":[6 * 60,12 * 60,24 * 60,48 * 60,96 * 60,192 * 60,23000,46000,18 * 60 * 60,24 * 60 * 60]
         },{
            "id":21,
            "group":3,
            "order":1,
            "type":"tower",
            "name":"#b_snipertower#",
            "size":64,
            "attackgroup":3,
            "tutstage":28,
            "sale":0,
            "description":"snipertower_desc",
            "stats":[{
               "range":5 * 60,
               "damage":100,
               "rate":80,
               "speed":10,
               "splash":0
            },{
               "range":308,
               "damage":210,
               "rate":80,
               "speed":10,
               "splash":0
            },{
               "range":316,
               "damage":320,
               "rate":80,
               "speed":10,
               "splash":0
            },{
               "range":324,
               "damage":430,
               "rate":80,
               "speed":12,
               "splash":0
            },{
               "range":332,
               "damage":9 * 60,
               "rate":80,
               "speed":15,
               "splash":0
            },{
               "range":340,
               "damage":650,
               "rate":80,
               "speed":17,
               "splash":0
            },{
               "range":348,
               "damage":760,
               "rate":80,
               "speed":18,
               "splash":0
            },{
               "range":356,
               "damage":870,
               "rate":80,
               "speed":19,
               "splash":0
            },{
               "range":364,
               "damage":980,
               "rate":80,
               "speed":20,
               "splash":0
            },{
               "range":372,
               "damage":1100,
               "rate":80,
               "speed":20,
               "splash":0
            }],
            "costs":[{
               "r1":25 * 60,
               "r2":2000,
               "r3":500,
               "r4":0,
               "time":30,
               "re":[[112,1,1]]
            },{
               "r1":125 * 60,
               "r2":10000,
               "r3":2500,
               "r4":0,
               "time":15 * 60,
               "re":[[112,1,1]]
            },{
               "r1":625 * 60,
               "r2":50000,
               "r3":12500,
               "r4":0,
               "time":45 * 60,
               "re":[[112,1,1]]
            },{
               "r1":187500,
               "r2":250000,
               "r3":62500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":937500,
               "r2":1250000,
               "r3":312500,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":4687500,
               "r2":6250000,
               "r3":1562500,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":7031250,
               "r2":9375000,
               "r3":2343750,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":10547000,
               "r2":14062000,
               "r3":3515000,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":15820000,
               "r2":21095000,
               "r3":5275000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":32730000,
               "r2":31650000,
               "r3":7900000,
               "r4":0,
               "time":132 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":625 * 60,
               "r2":50000,
               "r3":12500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":187500,
               "r2":250000,
               "r3":62500,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":937500,
               "r2":1250000,
               "r3":312500,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":4687500,
               "r2":6250000,
               "r3":1562500,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/snipertower/",
               "1":{
                  "anim":["anim.3.png",new Rectangle(-27,-50,55,47),30],
                  "top":["top.3.png",new Point(-40,-30)],
                  "shadow":["shadow.3.jpg",new Point(-43,12)],
                  "animdamaged":["anim.3.damaged.png",new Rectangle(-28,-49,55,46),30],
                  "topdamaged":["top.3.damaged.png",new Point(-39,-25)],
                  "shadowdamaged":["shadow.3.jpg",new Point(-39,15)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-45,-13)],
                  "shadowdestroyed":["shadow.3.jpg",new Point(-45,-4)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-45,-13)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"21.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"21.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,4],
            "hp":[100 * 60,150 * 60,210 * 60,294 * 60,441 * 60,34400,750 * 60,58000,75500,98200],
            "repairTime":[6 * 60,12 * 60,24 * 60,48 * 60,96 * 60,192 * 60,23000,46000,18 * 60 * 60,24 * 60 * 60]
         },{
            "id":22,
            "isNew":true,
            "group":3,
            "order":5,
            "type":"tower",
            "name":"#b_monsterbunker#",
            "size":2 * 60,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"monsterbunker_desc",
            "stats":[{"range":5 * 60},{"range":350},{"range":400}],
            "costs":[{
               "r1":250000,
               "r2":187500,
               "r3":62500,
               "r4":0,
               "time":6 * 60 * 60,
               "re":[[112,1,1],[15,1,1]]
            },{
               "r1":1000000,
               "r2":1000000,
               "r3":500000,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1],[15,1,1]]
            },{
               "r1":2000000,
               "r2":2000000,
               "r3":1000000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1],[15,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/bunker/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-46,-15,90,83),15],
                  "shadow":["shadow.1.jpg",new Point(-66,10)],
                  "topdamaged":["top.1.damaged.png",new Point(-45,-8)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-66,5)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-50,4)],
                  "shadowdamaged":["shadow.1.destroyed.jpg",new Point(-61,14)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"22.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"22.png"}
            },
            "quantity":[0,2],
            "capacity":[380,450,9 * 60],
            "hp":[10000,24500,52000],
            "repairTime":[2 * 60,4 * 60,8 * 60]
         },{
            "id":23,
            "group":3,
            "order":4,
            "type":"tower",
            "name":"#b_lasertower#",
            "tutstage":200,
            "sale":0,
            "description":"lasertower_desc",
            "stats":[{
               "range":160,
               "damage":2 * 60,
               "rate":80,
               "speed":0,
               "splash":40
            },{
               "range":162,
               "damage":150,
               "rate":80,
               "speed":0,
               "splash":40
            },{
               "range":164,
               "damage":3 * 60,
               "rate":80,
               "speed":0,
               "splash":40
            },{
               "range":168,
               "damage":200,
               "rate":80,
               "speed":0,
               "splash":40
            },{
               "range":170,
               "damage":220,
               "rate":80,
               "speed":0,
               "splash":40
            }],
            "costs":[{
               "r1":500000,
               "r2":250000,
               "r3":100000,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":1000000,
               "r2":500000,
               "r3":200000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":2000000,
               "r2":1000000,
               "r3":400000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":4000000,
               "r2":2000000,
               "r3":800000,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":8000000,
               "r2":4000000,
               "r3":1600000,
               "r4":0,
               "time":108 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":500000,
               "r2":250000,
               "r3":100000,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":1000000,
               "r2":500000,
               "r3":200000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":2000000,
               "r2":1000000,
               "r3":400000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":4000000,
               "r2":2000000,
               "r3":800000,
               "r4":0,
               "time":3 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/lasertower/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-13,-50,29,32),54],
                  "top":["top.1.png",new Point(-33,-29)],
                  "shadow":["shadow.1.jpg",new Point(-36,15)],
                  "animdamaged":["anim.1.damaged.png",new Rectangle(-22,-46,52,44),54],
                  "topdamaged":["top.1.damaged.png",new Point(-40,-28)],
                  "shadowdamaged":["shadow.1.jpg",new Point(-37,-17)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-39,-3)],
                  "shadowdestroyed":["shadow.1.jpg",new Point(-37,14)],
                  "topdestroyedfire":["top.1.destroyed.fire.png",new Point(-39,-3)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"23.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"23.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,2],
            "hp":[150 * 60,210 * 60,294 * 60,441 * 60,34400],
            "repairTime":[24 * 60,48 * 60,96 * 60,192 * 60,23000]
         },{
            "id":24,
            "group":3,
            "order":6,
            "type":"trap",
            "name":"#b_boobytrap#",
            "size":50,
            "attackgroup":4,
            "tutstage":200,
            "sale":0,
            "description":"boobytrap_desc",
            "costs":[{
               "r1":1000,
               "r2":1000,
               "r3":1000,
               "r4":0,
               "time":5,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/boobytrap/",
               "1":{
                  "top":["top.1.png",new Point(-15,1)],
                  "shadow":["shadow.1.jpg",new Point(-13,3)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-15,2)],
                  "shadowdestroyed":["shadow.1.jpg",new Point(-13,3)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"24.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"24.png"}
            },
            "quantity":[0,25],
            "damage":[1000],
            "hp":[10],
            "repairTime":[1]
         },{
            "id":25,
            "group":3,
            "order":3,
            "type":"tower",
            "name":"#b_teslatower#",
            "tutstage":200,
            "sale":0,
            "description":"teslatower_desc",
            "stats":[{
               "range":250,
               "damage":100,
               "rate":10,
               "speed":10,
               "splash":0
            },{
               "range":270,
               "damage":2 * 60,
               "rate":15,
               "speed":10,
               "splash":0
            },{
               "range":5 * 60,
               "damage":140,
               "rate":20,
               "speed":10,
               "splash":0
            },{
               "range":320,
               "damage":160,
               "rate":25,
               "speed":10,
               "splash":0
            },{
               "range":340,
               "damage":3 * 60,
               "rate":25,
               "speed":10,
               "splash":0
            }],
            "costs":[{
               "r1":187500,
               "r2":250000,
               "r3":62500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":750000,
               "r2":1000000,
               "r3":250000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":625 * 60 * 60,
               "r2":50 * 60 * 1000,
               "r3":750000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":5250000,
               "r2":5000000,
               "r3":1250000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":200 * 60 * 1000,
               "r2":10000000,
               "r3":2000000,
               "r4":0,
               "time":6 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":187500,
               "r2":250000,
               "r3":62500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":750000,
               "r2":1000000,
               "r3":250000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":625 * 60 * 60,
               "r2":50 * 60 * 1000,
               "r3":750000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":5250000,
               "r2":5000000,
               "r3":1250000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/lightningtower/",
               "1":{
                  "anim":["anim.3.png",new Rectangle(-25,-15,27,53),55],
                  "top":["top.3.png",new Point(-33,-57)],
                  "shadow":["shadow.3.jpg",new Point(-38,18)],
                  "animdamaged":["anim.3.damaged.png",new Rectangle(-26,-19,30,57),55],
                  "topdamaged":["top.3.damaged.png",new Point(-46,-58)],
                  "shadowdamaged":["shadow.3.jpg",new Point(-44,21)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-46,6)],
                  "shadowdestroyed":["shadow.3.jpg",new Point(-44,17)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-46,6)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"25.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"25.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,2],
            "hp":[250 * 60,22000,500 * 60,800 * 60,60 * 1000],
            "repairTime":[32 * 60,0xf00,128 * 60,9260,200 * 60]
         },{
            "id":26,
            "group":2,
            "order":5,
            "type":"special",
            "name":"#b_monsteracademy#",
            "tutstage":200,
            "sale":0,
            "description":"monsteracademy_desc",
            "block":true,
            "quantity":[0,0,0,0,1,2,2,2,2]
         },{
            "id":27,
            "group":999,
            "order":0,
            "type":"enemy",
            "name":"#b_trojanhorse#",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"trojanhorse_desc",
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":5,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/trojanhorse/",
               "1":{
                  "anim":["anim.1.png",new Rectangle(-92,-23,39,31),2],
                  "top":["top.1.png",new Point(-91,-65)],
                  "shadow":["shadow.1.jpg",new Point(-72,11)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"27.jpg"}
            },
            "quantity":[1],
            "damage":[1],
            "hp":[1],
            "repairTime":[1]
         },{
            "id":28,
            "group":4,
            "subgroup":3,
            "order":5,
            "type":"decoration",
            "name":"#b_americanflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-usa.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":29,
            "group":4,
            "subgroup":3,
            "order":6,
            "type":"decoration",
            "name":"#b_britishflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-britain.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":30,
            "group":4,
            "subgroup":3,
            "order":7,
            "type":"decoration",
            "name":"#b_australianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-australia.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":31,
            "group":4,
            "subgroup":3,
            "order":8,
            "type":"decoration",
            "name":"#b_brazilianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-brazil.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":32,
            "group":4,
            "subgroup":3,
            "order":25,
            "type":"decoration",
            "name":"#b_europeanflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "r4":0,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-europe.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":33,
            "group":4,
            "subgroup":3,
            "order":9,
            "type":"decoration",
            "name":"#b_frenchflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-france.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":34,
            "group":4,
            "subgroup":3,
            "order":10,
            "type":"decoration",
            "name":"#b_indonesianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-indonesian.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":35,
            "group":4,
            "subgroup":3,
            "order":11,
            "type":"decoration",
            "name":"#b_italianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-italy.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":36,
            "group":4,
            "subgroup":3,
            "order":12,
            "type":"decoration",
            "name":"#b_malaysianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-malaysia.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":37,
            "group":4,
            "subgroup":3,
            "order":13,
            "type":"decoration",
            "name":"#b_dutchflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-dutch.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":38,
            "group":4,
            "subgroup":3,
            "order":14,
            "type":"decoration",
            "name":"#b_newzealandflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-newzealand.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":39,
            "group":4,
            "subgroup":3,
            "order":15,
            "type":"decoration",
            "name":"#b_norwegianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-norway.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":40,
            "group":4,
            "subgroup":3,
            "order":16,
            "type":"decoration",
            "name":"#b_polishflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-poland.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":41,
            "group":4,
            "subgroup":3,
            "order":17,
            "type":"decoration",
            "name":"#b_swedishflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-sweden.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":42,
            "group":4,
            "subgroup":3,
            "order":18,
            "type":"decoration",
            "name":"#b_turkishflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-turkey.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":43,
            "group":4,
            "subgroup":3,
            "order":19,
            "type":"decoration",
            "name":"#b_canadianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-canadian.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":44,
            "group":4,
            "subgroup":3,
            "order":20,
            "type":"decoration",
            "name":"#b_danishflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-denmark.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":45,
            "group":4,
            "subgroup":3,
            "order":21,
            "type":"decoration",
            "name":"#b_germanflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-germany.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":46,
            "group":4,
            "subgroup":3,
            "order":22,
            "type":"decoration",
            "name":"#b_filipinoflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-philippines.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":47,
            "group":4,
            "subgroup":3,
            "order":23,
            "type":"decoration",
            "name":"#b_singaporeanflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-singapore.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":48,
            "group":4,
            "subgroup":3,
            "order":24,
            "type":"decoration",
            "name":"#b_austrianflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-austria.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":49,
            "group":4,
            "subgroup":3,
            "order":-1,
            "type":"decoration",
            "name":"#b_pirateflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":1,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":250,
               "r4":0,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-pirate.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":50,
            "group":4,
            "subgroup":3,
            "order":0,
            "type":"decoration",
            "name":"#b_peaceflag#",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":1,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":250,
               "r4":0,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-peace.png",new Rectangle(1,-35,24,30),21],
                  "top":["flagpole.png",new Point(-5,-43)],
                  "shadow":["shadow.jpg",new Point(-3,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":51,
            "group":2,
            "order":10,
            "type":"special",
            "name":"#b_catapult#",
            "size":190,
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"catapult_desc",
            "costs":[{
               "r1":75000,
               "r2":75000,
               "r3":75000,
               "r4":0,
               "time":3 * 60 * 60,
               "re":[[112,1,1],[5,1,1]]
            },{
               "r1":128600,
               "r2":128600,
               "r3":128600,
               "r4":0,
               "time":6 * 60 * 60,
               "re":[[112,1,1],[5,1,1]]
            },{
               "r1":257200,
               "r2":257200,
               "r3":257200,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1],[5,1,1]]
            },{
               "r1":514400,
               "r2":514400,
               "r3":514400,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1],[5,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/catapult/",
               "1":{
                  "top":["top.1.png",new Point(-43,12)],
                  "shadow":["shadow.1.jpg",new Point(-42,28)],
                  "topdamaged":["top.1.damaged.png",new Point(-40,12)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-39,28)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-48,9)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-47,23)]
               },
               "2":{
                  "top":["top.2.png",new Point(-44,-21)],
                  "shadow":["shadow.2.jpg",new Point(-49,19)],
                  "topdamaged":["top.2.damaged.png",new Point(-43,-16)],
                  "shadowdamaged":["shadow.2.damaged.jpg",new Point(-41,29)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-48,9)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-47,23)]
               },
               "3":{
                  "top":["top.3.png",new Point(-43,-29)],
                  "shadow":["shadow.3.jpg",new Point(-39,27)],
                  "topdamaged":["top.3.damaged.png",new Point(-51,-29)],
                  "shadowdamaged":["shadow.3.damaged.jpg",new Point(-51,30)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-48,9)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-47,23)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"51.1.jpg"},
               "2":{"img":"51.2.jpg"},
               "3":{"img":"51.3.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"51.1.png"},
               "2":{"img":"51.2.png"},
               "3":{"img":"51.3.png"}
            },
            "quantity":[0,1],
            "hp":[0xfa0,0x1f40,16000,32000],
            "repairTime":[2 * 60,4 * 60,8 * 60,16 * 60]
         },{
            "id":52,
            "group":999,
            "subgroup":5,
            "order":1,
            "type":"taunt",
            "name":"Simple Sign",
            "lifespan":2 * 24 * 60 * 60,
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"Leave a little note for a friend.",
            "block":true,
            "costs":[{
               "r1":100000,
               "r2":100000,
               "r3":100000,
               "r4":100000,
               "r5":0,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flags/",
               "1":{
                  "anim":["flag-pirate.png",new Rectangle(1,-25,24,30),21],
                  "top":["flagpole.png",new Point(-5,-33)],
                  "shadow":["shadow.jpg",new Point(-3,15)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":53,
            "group":999,
            "order":1,
            "type":"immovable",
            "name":"hwn_pumpkin",
            "size":10,
            "attackgroup":0,
            "tutstage":0,
            "sale":0,
            "description":"Temporary pumpkin for picking",
            "block":true,
            "quantity":[0],
            "hp":[10],
            "repairTime":[10],
            "imageData":{
               "baseurl":"buildings/decorations/pumpkins/",
               "1":{
                  "anim":["anim.png",new Rectangle(-18,-15,37,36),30],
                  "shadow":["shadow.jpg",new Point(-22,-1)]
               }
            }
         },{
            "id":54,
            "group":999,
            "order":1,
            "type":"immovable",
            "name":"hwn_massivepumpkin",
            "size":10,
            "attackgroup":0,
            "tutstage":0,
            "sale":0,
            "description":"Massive Pumpkin for the \"Event\"",
            "block":true,
            "quantity":[0],
            "hp":[10],
            "repairTime":[10],
            "imageData":{
               "baseurl":"buildings/decorations/pumpkins/",
               "1":{
                  "top":["large-top-6.png",new Point(-169,-60)],
                  "shadow":["large-shadow-6.jpg",new Point(-168,5)],
                  "anim":["large-anim-6.png",new Rectangle(-119,-113,189,155),45]
               }
            }
         },{
            "id":55,
            "group":4,
            "subgroup":1,
            "order":1,
            "type":"decoration",
            "name":"bdg_acorn",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_acorn_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/acorn/",
               "1":{
                  "top":["top.png",new Point(-10,-9)],
                  "shadow":["shadow.jpg",new Point(-9,8)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":56,
            "group":4,
            "subgroup":1,
            "order":11,
            "type":"decoration",
            "name":"bdg_beehive",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_beehive_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/beehive/",
               "1":{
                  "top":["top.png",new Point(-18,-15)],
                  "shadow":["shadow.jpg",new Point(-14,6)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":57,
            "group":4,
            "subgroup":2,
            "order":2,
            "type":"decoration",
            "name":"bdg_birdhous",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_birdhous_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/birdhouse/",
               "1":{
                  "top":["top.png",new Point(-16,-46)],
                  "shadow":["shadow.jpg",new Point(-2,17)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":58,
            "group":4,
            "subgroup":2,
            "order":3,
            "type":"decoration",
            "name":"bdg_tent",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_tent_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/campingtent/",
               "1":{
                  "top":["top.png",new Point(-30,-12)],
                  "shadow":["shadow.jpg",new Point(-29,6)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":59,
            "group":4,
            "subgroup":1,
            "order":5,
            "type":"decoration",
            "name":"bdg_jax",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_jax_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/childrensjax/",
               "1":{
                  "top":["top.png",new Point(-11,-11)],
                  "shadow":["shadow.jpg",new Point(-7,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":60,
            "group":4,
            "subgroup":2,
            "order":12,
            "type":"decoration",
            "name":"bdg_redgnome",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_gnome_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/gnomes/",
               "1":{
                  "top":["top-red.png",new Point(-10,-31)],
                  "shadow":["shadow.jpg",new Point(-13,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":61,
            "group":4,
            "subgroup":2,
            "order":10,
            "type":"decoration",
            "name":"bdg_bluegnome",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_gnome_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/gnomes/",
               "1":{
                  "top":["top-blue.png",new Point(-10,-31)],
                  "shadow":["shadow.jpg",new Point(-13,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":62,
            "group":4,
            "subgroup":2,
            "order":11,
            "type":"decoration",
            "name":"bdg_greengnome",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_gnome_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/gnomes/",
               "1":{
                  "top":["top-green.png",new Point(-10,-31)],
                  "shadow":["shadow.jpg",new Point(-13,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":63,
            "group":4,
            "subgroup":2,
            "order":5,
            "type":"decoration",
            "name":"bdg_hammock",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_hammock_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/hammock/",
               "1":{
                  "top":["top.png",new Point(-25,-8)],
                  "shadow":["shadow.jpg",new Point(-26,6)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":64,
            "group":4,
            "subgroup":2,
            "order":6,
            "type":"decoration",
            "name":"bdg_lawnchair",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_lawnchair_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/lawnchair/",
               "1":{
                  "top":["top.png",new Point(-24,-14)],
                  "shadow":["shadow.jpg",new Point(-25,4)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":65,
            "group":4,
            "subgroup":2,
            "order":4,
            "type":"decoration",
            "name":"bdg_outhouse",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_outhouse_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/outhouse/",
               "1":{
                  "top":["top.png",new Point(-16,-19)],
                  "shadow":["shadow.jpg",new Point(-11,10)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":66,
            "group":4,
            "subgroup":1,
            "order":2,
            "type":"decoration",
            "name":"bdg_pinecone",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_pinecone_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/pinecone/",
               "1":{
                  "top":["top.png",new Point(-13,-10)],
                  "shadow":["shadow.jpg",new Point(-23,3)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":67,
            "group":4,
            "subgroup":1,
            "order":4,
            "type":"decoration",
            "name":"bdg_rock",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_rock_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/rock/",
               "1":{
                  "top":["top.png",new Point(-15,0)],
                  "shadow":["shadow.jpg",new Point(-15,9)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":68,
            "group":4,
            "subgroup":2,
            "order":15,
            "type":"decoration",
            "name":"bdg_scaleelectric",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_scaleelectric_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/scaleelectriccartoyset/",
               "1":{
                  "top":["top.png",new Point(-48,0)],
                  "shadow":["shadow.jpg",new Point(-57,8)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":69,
            "group":4,
            "subgroup":1,
            "order":12,
            "type":"decoration",
            "name":"bdg_scarecrow",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"flag_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/scarecrow/",
               "1":{
                  "top":["top.png",new Point(-25,-43)],
                  "shadow":["shadow.jpg",new Point(-20,8)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":70,
            "group":4,
            "subgroup":2,
            "order":1,
            "type":"decoration",
            "name":"bdg_sundial",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_sundial_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/sundial/",
               "1":{
                  "top":["top.png",new Point(-23,-6)],
                  "shadow":["shadow.jpg",new Point(-23,8)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":71,
            "group":4,
            "subgroup":2,
            "order":7,
            "type":"decoration",
            "name":"bdg_tikitorch",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_tikitorch_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/tikitorch/",
               "1":{
                  "anim":["anim.png",new Rectangle(-11,-71,16,36),25],
                  "top":["top.png",new Point(-8,-38)],
                  "shadow":["shadow.jpg",new Point(-6,3)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":72,
            "group":4,
            "subgroup":1,
            "order":3,
            "type":"decoration",
            "name":"bdg_walnut",
            "size":30,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_walnut_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/walnut/",
               "1":{
                  "top":["top.png",new Point(-12,-2)],
                  "shadow":["shadow.jpg",new Point(-23,3)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":73,
            "group":4,
            "subgroup":0,
            "order":15,
            "type":"decoration",
            "name":"bdg_tombstone",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_tombstone_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/graveyardtombstone/",
               "1":{
                  "top":["top.png",new Point(-22,-13)],
                  "shadow":["shadow.jpg",new Point(-20,9)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":74,
            "group":4,
            "subgroup":0,
            "order":3,
            "type":"decoration",
            "name":"bdg_pokeyhead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_pokeyhead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-pokey.png",new Point(-6,-28)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":75,
            "group":4,
            "subgroup":0,
            "order":4,
            "type":"decoration",
            "name":"bdg_octohead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_octohead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-octo.png",new Point(-6,-23)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":76,
            "group":4,
            "subgroup":0,
            "order":5,
            "type":"decoration",
            "name":"bdg_bolthead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_bolthead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-bolt.png",new Point(-10,-23)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":77,
            "group":4,
            "subgroup":0,
            "order":6,
            "type":"decoration",
            "name":"bdg_banditohead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_banditohead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-bandito.png",new Point(-5,-26)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":78,
            "group":4,
            "subgroup":0,
            "order":7,
            "type":"decoration",
            "name":"bdg_brainhead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_brainhead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-brain.png",new Point(-9,-28)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":79,
            "group":4,
            "subgroup":0,
            "order":8,
            "type":"decoration",
            "name":"bdg_crabhead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_crabhead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-crabatron.png",new Point(-10,-29)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":80,
            "group":4,
            "subgroup":0,
            "order":14,
            "type":"decoration",
            "name":"bdg_davehead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_davehead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-dave.png",new Point(-14,-30)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":81,
            "group":4,
            "subgroup":0,
            "order":9,
            "type":"decoration",
            "name":"bdg_eyerahead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_eyerahead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-eyera.png",new Point(-4,-23)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":82,
            "group":4,
            "subgroup":0,
            "order":10,
            "type":"decoration",
            "name":"bdg_fanghead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_fanghead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-fang.png",new Point(-10,-30)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":83,
            "group":4,
            "subgroup":0,
            "order":11,
            "type":"decoration",
            "name":"bdg_finkhead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_finkhead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-fink.png",new Point(-11,-29)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":84,
            "group":4,
            "subgroup":0,
            "order":12,
            "type":"decoration",
            "name":"bdg_ichihead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_ichihead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-ichi.png",new Point(-6,-29)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":85,
            "group":4,
            "subgroup":0,
            "order":13,
            "type":"decoration",
            "name":"bdg_projectxhead",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_projectxhead_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-projectx.png",new Point(-19,-24)],
                  "shadow":["shadow.jpg",new Point(-1,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":86,
            "group":4,
            "subgroup":1,
            "order":13,
            "type":"decoration",
            "name":"bdg_blackberrybush",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_blackberrybush_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/blackberrybush/",
               "1":{"top":["top.png",new Point(-25,-13)]}
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":87,
            "group":4,
            "subgroup":1,
            "order":16,
            "type":"decoration",
            "name":"bdg_bonsaitree",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_bonsaitree_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/bonsaitree/",
               "1":{
                  "top":["top.png",new Point(-41,-36)],
                  "shadow":["shadow.jpg",new Point(-22,15)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":88,
            "group":4,
            "subgroup":1,
            "order":14,
            "type":"decoration",
            "name":"bdg_cactus",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_cactus_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/cactus/",
               "1":{
                  "top":["top.png",new Point(-14,-30)],
                  "shadow":["shadow.jpg",new Point(-12,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":89,
            "group":4,
            "subgroup":1,
            "order":15,
            "type":"decoration",
            "name":"bdg_flytrap",
            "size":70,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_flytrap_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flytrap/",
               "1":{
                  "top":["top.png",new Point(-33,-5)],
                  "shadow":["shadow.jpg",new Point(-38,20)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":90,
            "group":4,
            "subgroup":1,
            "order":12,
            "type":"decoration",
            "name":"bdg_thorns",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_thorns_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/thorns/",
               "1":{
                  "top":["top.png",new Point(-23,-18)],
                  "shadow":["shadow.jpg",new Point(-25,7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":91,
            "group":4,
            "subgroup":1,
            "order":5,
            "type":"decoration",
            "name":"bdg_pinkflowers",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_pinkflowers_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flowers/",
               "1":{
                  "top":["top-pink.png",new Point(-18,-21)],
                  "shadow":["shadow.jpg",new Point(-10,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":92,
            "group":4,
            "subgroup":1,
            "order":6,
            "type":"decoration",
            "name":"bdg_purpleflowers",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_purpleflowers_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flowers/",
               "1":{
                  "top":["top-purple.png",new Point(-18,-21)],
                  "shadow":["shadow.jpg",new Point(-10,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":93,
            "group":4,
            "subgroup":1,
            "order":9,
            "type":"decoration",
            "name":"bdg_redflowers",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_redflowers_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flowers/",
               "1":{
                  "top":["top-red.png",new Point(-18,-21)],
                  "shadow":["shadow.jpg",new Point(-10,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":94,
            "group":4,
            "subgroup":1,
            "order":7,
            "type":"decoration",
            "name":"bdg_whiteflowers",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_whiteflowers_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flowers/",
               "1":{
                  "top":["top-white.png",new Point(-18,-21)],
                  "shadow":["shadow.jpg",new Point(-10,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":95,
            "group":4,
            "subgroup":1,
            "order":8,
            "type":"decoration",
            "name":"bdg_yellowflowers",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_yellowflowers_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/flowers/",
               "1":{
                  "top":["top-yellow.png",new Point(-18,-21)],
                  "shadow":["shadow.jpg",new Point(-10,2)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":96,
            "group":4,
            "subgroup":4,
            "order":5,
            "type":"decoration",
            "name":"bdg_baseballstatue",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_baseballstatue_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-baseball/",
               "1":{
                  "top":["top.png",new Point(-20,-36)],
                  "shadow":["shadow.jpg",new Point(-21,10)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":97,
            "group":4,
            "subgroup":4,
            "order":6,
            "type":"decoration",
            "name":"bdg_footballstatue",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_footballstatue_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-football/",
               "1":{
                  "top":["top.png",new Point(-19,-39)],
                  "shadow":["shadow.jpg",new Point(-17,10)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":98,
            "group":4,
            "subgroup":4,
            "order":7,
            "type":"decoration",
            "name":"bdg_soccerstatue",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_soccerstatue_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-soccer/",
               "1":{
                  "top":["top.png",new Point(-23,-36)],
                  "shadow":["shadow.jpg",new Point(-15,12)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":99,
            "group":4,
            "subgroup":4,
            "order":8,
            "type":"decoration",
            "name":"bdg_libertystatue",
            "size":70,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_libertystatue_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-liberty/",
               "1":{
                  "top":["top.png",new Point(-37,-118)],
                  "shadow":["shadow.jpg",new Point(-31,20)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":100,
            "group":4,
            "subgroup":4,
            "order":9,
            "type":"decoration",
            "name":"bdg_eiffelstatue",
            "size":70,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_eiffelstatue_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-eiffeltower/",
               "1":{
                  "top":["top.png",new Point(-60,-121)],
                  "shadow":["shadow.jpg",new Point(-60,5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":101,
            "group":4,
            "subgroup":4,
            "order":10,
            "type":"decoration",
            "name":"bdg_bigben",
            "size":70,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_bigben_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/statue-bigben/",
               "1":{
                  "top":["top.png",new Point(-32,-104)],
                  "shadow":["shadow.jpg",new Point(-32,19)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":102,
            "group":4,
            "subgroup":2,
            "order":13,
            "type":"decoration",
            "name":"bdg_pool",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_pool_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/pool/",
               "1":{
                  "top":["top.png",new Point(-65,8)],
                  "shadow":["shadow.jpg",new Point(-65,15)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":103,
            "group":4,
            "subgroup":2,
            "order":14,
            "type":"decoration",
            "name":"bdg_pond",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_pond_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/pond/",
               "1":{"top":["top.png",new Point(-40,14)]}
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":104,
            "group":4,
            "subgroup":2,
            "order":16,
            "type":"decoration",
            "name":"bdg_zengarden",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_zengarden_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/zengarden/",
               "1":{
                  "top":["top.png",new Point(-72,-5)],
                  "shadow":["shadow.jpg",new Point(-72,16)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":105,
            "group":4,
            "subgroup":2,
            "order":17,
            "type":"decoration",
            "name":"bdg_fountain",
            "size":70,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_fountain_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/fountain/",
               "1":{
                  "anim":["anim.png",new Rectangle(-47,-51,89,114),42],
                  "shadow":["shadow.jpg",new Point(-41,16)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":106,
            "group":4,
            "subgroup":2,
            "order":18,
            "type":"decoration",
            "name":"bdg_teagarden",
            "size":100,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_teargarden_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/japaneseteagarden/",
               "1":{
                  "top":["top.png",new Point(-62,-38)],
                  "shadow":["shadow.jpg",new Point(-57,12)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":107,
            "group":4,
            "subgroup":0,
            "order":1,
            "type":"decoration",
            "name":"bdg_monsterskull",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_monsterskull_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/headsonsticks/",
               "1":{
                  "top":["top-skull.png",new Point(-7,-39)],
                  "shadow":["shadow.jpg",new Point(-1,-7)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":108,
            "group":4,
            "subgroup":2,
            "order":8,
            "type":"decoration",
            "name":"bdg_rubikunsolved",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_rubikunsolved_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/rubikscube/",
               "1":{
                  "top":["top-unsolved.png",new Point(-20,-23)],
                  "shadow":["shadow.jpg",new Point(-22,-5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":109,
            "group":4,
            "subgroup":2,
            "order":9,
            "type":"decoration",
            "name":"bdg_rubiksolved",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_rubiksolved_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":150,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/rubikscube/",
               "1":{
                  "top":["top-solved.png",new Point(-20,-23)],
                  "shadow":["shadow.jpg",new Point(-22,-5)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":110,
            "group":4,
            "subgroup":4,
            "order":11,
            "type":"decoration",
            "name":"bdg_halloween",
            "size":40,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_halloween_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":1000,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/pumpkins/",
               "1":{
                  "top":["attended-large-top.png",new Point(-24,-32)],
                  "shadow":["attended-large-shadow.jpg",new Point(-25,1)]
               }
            },
            "quantity":[0],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":111,
            "group":4,
            "subgroup":4,
            "order":12,
            "type":"decoration",
            "name":"bdg_halloween_small",
            "size":20,
            "attackgroup":999,
            "tutstage":200,
            "sale":0,
            "description":"bdg_halloween_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "r5":0,
               "time":0,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/decorations/pumpkins/",
               "1":{
                  "top":["attended-small-top.png",new Point(-10,-4)],
                  "shadow":["attended-small-shadow.jpg",new Point(-12,2)]
               }
            },
            "quantity":[6],
            "hp":[100],
            "repairTime":[1]
         },{
            "id":112,
            "group":2,
            "order":1,
            "type":"special",
            "name":"b_outpost",
            "size":190,
            "attackgroup":1,
            "tutstage":0,
            "sale":0,
            "description":"outpost_desc",
            "block":true,
            "costs":[{
               "r1":0,
               "r2":0,
               "r3":0,
               "r4":0,
               "time":10,
               "re":[]
            }],
            "imageData":{
               "baseurl":"buildings/outpost/",
               "1":{
                  "top":["top.1.png",new Point(-63,-72)],
                  "shadow":["shadow.1.jpg",new Point(-77,22)],
                  "topdamaged":["top.1.damaged.png",new Point(-63,-66)],
                  "shadowdamaged":["shadow.1.damaged.jpg",new Point(-90,14)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-96,1)],
                  "shadowdestroyed":["shadow.1.destroyed.jpg",new Point(-95,20)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"112.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"112.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort130_F1.png",new Point(-127,46)],
                  "back":["fort130_B1.png",new Point(-122,-10)]
               },
               "2":{
                  "front":["fort130_F2.png",new Point(-124,48)],
                  "back":["fort130_B2.png",new Point(-120,-15)]
               },
               "3":{
                  "front":["fort130_F3.png",new Point(-124,32)],
                  "back":["fort130_B3.png",new Point(-110,-11)]
               },
               "4":{
                  "front":["fort130_F4.png",new Point(-124,15)],
                  "back":["fort130_B4.png",new Point(-116,-49)]
               }
            },
            "can_fortify":true,
            "fortify_costs":[{
               "r1":250000,
               "r2":50000,
               "r3":25000,
               "r4":0,
               "time":4 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":500000,
               "r2":500000,
               "r3":500000,
               "r4":0,
               "time":16 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":2500000,
               "r2":2500000,
               "r3":1000000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":5000000,
               "r2":5000000,
               "r3":2500000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "quantity":[1,1,1,1,1,1,1,1,1],
            "hp":[200000],
            "repairTime":[60 * 60]
         },{
            "id":113,
            "group":2,
            "order":15,
            "type":"special",
            "name":"#b_radio#",
            "size":80,
            "attackgroup":1,
            "tutstage":0,
            "sale":0,
            "description":"radio_build_desc",
            "block":true,
            "quantity":[0]
         },{
            "id":114,
            "group":3,
            "order":6,
            "type":"tower",
            "name":"#b_monstercage#",
            "size":200,
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"monstercage_desc",
            "block":true,
            "quantity":[0]
         },{
            "id":115,
            "group":3,
            "order":5,
            "type":"tower",
            "name":"#b_flaktower#",
            "attackgroup":2,
            "tutstage":200,
            "sale":0,
            "description":"flaktower_desc",
            "stats":[{
               "range":5 * 60,
               "damage":200,
               "rate":60,
               "speed":20,
               "splash":3 * 60
            },{
               "range":320,
               "damage":250,
               "rate":60,
               "speed":24,
               "splash":185
            },{
               "range":340,
               "damage":250,
               "rate":60,
               "speed":28,
               "splash":190
            },{
               "range":6 * 60,
               "damage":250,
               "rate":60,
               "speed":32,
               "splash":195
            },{
               "range":380,
               "damage":5 * 60,
               "rate":60,
               "speed":36,
               "splash":200
            }],
            "costs":[{
               "r1":215000,
               "r2":280000,
               "r3":62500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":850000,
               "r2":20 * 60 * 1000,
               "r3":250000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":2750000,
               "r2":3400000,
               "r3":750000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":5750000,
               "r2":5200000,
               "r3":1250000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":13500000,
               "r2":11000000,
               "r3":2000000,
               "r4":0,
               "time":6 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":215000,
               "r2":280000,
               "r3":62500,
               "r4":0,
               "time":5 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":850000,
               "r2":20 * 60 * 1000,
               "r3":250000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":2750000,
               "r2":3400000,
               "r3":750000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":5750000,
               "r2":5200000,
               "r3":1250000,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/flaktower/",
               "1":{
                  "anim":["anim.3.png",new Rectangle(-32,-23,62,52),32],
                  "top":["top.3.png",new Point(-39,6)],
                  "shadow":["shadow.3.jpg",new Point(-43,14)],
                  "animdamaged":["anim.3.damaged.png",new Rectangle(-29,-17,62,53),32],
                  "topdamaged":["top.3.damaged.png",new Point(-39,5)],
                  "shadowdamaged":["shadow.3.jpg",new Point(-40,24)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-36,13)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-33,26)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-45,-13)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"115.jpg"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,2],
            "hp":[250 * 60,22000,500 * 60,800 * 60,60 * 1000],
            "repairTime":[32 * 60,0xf00,128 * 60,9260,200 * 60]
         },{
            "id":116,
            "group":2,
            "order":12,
            "type":"special",
            "name":"#b_monsterlab#",
            "attackgroup":1,
            "tutstage":200,
            "sale":0,
            "description":"monsterlab_desc",
            "block":true,
            "quantity":[0]
         },{
            "id":117,
            "group":3,
            "order":10,
            "type":"trap",
            "name":"#b_heavytrap#",
            "size":90,
            "attackgroup":4,
            "tutstage":200,
            "sale":0,
            "description":"heavytrap_desc",
            "costs":[{
               "r1":50000,
               "r2":50000,
               "r3":50000,
               "r4":0,
               "time":5,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/heavytrap/",
               "1":{
                  "top":["top.1.png",new Point(-16,-5)],
                  "shadow":["shadow.1.jpg",new Point(-18,1)],
                  "topdestroyed":["top.1.destroyed.png",new Point(-16,5)],
                  "shadowdestroyed":["shadow.1.jpg",new Point(-18,1)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"117.jpg"}
            },
            "quantity":[0,5],
            "damage":[10000],
            "hp":[10],
            "repairTime":[1]
         },{
            "id":118,
            "group":3,
            "order":5,
            "type":"tower",
            "name":"#b_railguntower#",
            "size":64,
            "attackgroup":3,
            "tutstage":28,
            "sale":0,
            "description":"railguntower_desc",
            "stats":[{
               "range":5 * 60,
               "damage":400,
               "rate":160,
               "speed":20,
               "splash":0
            },{
               "range":315,
               "damage":10 * 60,
               "rate":160,
               "speed":20,
               "splash":0
            },{
               "range":330,
               "damage":15 * 60,
               "rate":160,
               "speed":20,
               "splash":0
            },{
               "range":345,
               "damage":20 * 60,
               "rate":160,
               "speed":20,
               "splash":0
            },{
               "range":6 * 60,
               "damage":1600,
               "rate":160,
               "speed":20,
               "splash":0
            }],
            "costs":[{
               "r1":1600000,
               "r2":32 * 60 * 1000,
               "r3":1280000,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":800 * 60 * 60,
               "r2":40 * 24 * 60 * 60,
               "r3":640 * 60 * 60,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":60 * 24 * 60 * 60,
               "r2":72 * 24 * 60 * 60,
               "r3":48 * 24 * 60 * 60,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":108 * 24 * 60 * 60,
               "r2":11197440,
               "r3":7464960,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":16796160,
               "r2":20115392,
               "r3":13436928,
               "r4":0,
               "time":6 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "can_fortify":true,
            "fortify_costs":[{
               "r1":2000000,
               "r2":40 * 60 * 1000,
               "r3":1600000,
               "r4":0,
               "time":12 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":2600000,
               "r2":3320000,
               "r3":1880000,
               "r4":0,
               "time":24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":4480000,
               "r2":4776000,
               "r3":2184000,
               "r4":0,
               "time":2 * 24 * 60 * 60,
               "re":[[112,1,1]]
            },{
               "r1":9664000,
               "r2":9996800,
               "r3":4331200,
               "r4":0,
               "time":4 * 24 * 60 * 60,
               "re":[[112,1,1]]
            }],
            "imageData":{
               "baseurl":"buildings/railguntower/",
               "1":{
                  "anim":["anim.3.loaded.png",new Rectangle(-49,-9,96,56),32],
                  "top":["top.3.png",new Point(-39,7)],
                  "shadow":["shadow.3.jpg",new Point(-40,20)],
                  "animdamaged":["anim.3.damaged.png",new Rectangle(-49,-9,97,56),32],
                  "topdamaged":["top.3.damaged.png",new Point(-39,7)],
                  "shadowdamaged":["shadow.3.jpg",new Point(-40,20)],
                  "topdestroyed":["top.3.destroyed.png",new Point(-34,-5)],
                  "shadowdestroyed":["shadow.3.destroyed.jpg",new Point(-36,23)],
                  "topdestroyedfire":["top.3.destroyed.fire.png",new Point(-45,-13)]
               }
            },
            "upgradeImgData":{
               "baseurl":"buildingbuttons/",
               "1":{"img":"118.jpg"}
            },
            "thumbImgData":{
               "baseurl":"buildingthumbs/",
               "1":{"img":"118.png"}
            },
            "fortImgData":{
               "baseurl":"buildings/fortifications/",
               "1":{
                  "front":["fort70_F1.png",new Point(-73,21)],
                  "back":["fort70_B1.png",new Point(-70,-10)]
               },
               "2":{
                  "front":["fort70_F2.png",new Point(-69,22)],
                  "back":["fort70_B2.png",new Point(-65,-12)]
               },
               "3":{
                  "front":["fort70_F3.png",new Point(-72,10)],
                  "back":["fort70_B3.png",new Point(-68,-12)]
               },
               "4":{
                  "front":["fort70_F4.png",new Point(-70,-11)],
                  "back":["fort70_B4.png",new Point(-61,-36)]
               }
            },
            "quantity":[0,1],
            "hp":[294 * 60,34400,750 * 60,58000,75500],
            "repairTime":[48 * 60,96 * 60,192 * 60,23000,46000]
         },{
            "id":119,
            "group":3,
            "order":10,
            "type":"special",
            "name":"#b_championchamber#",
            "size":64,
            "attackgroup":3,
            "tutstage":28,
            "sale":0,
            "description":"championchamber_desc",
            "block":true,
            "quantity":[0]
         }];
         if(BASE._isOutpost)
         {
            _buildingProps = _outpostProps;
         }
         else
         {
            _buildingProps = _yardProps;
         }
      }
      
      public static function Setup(param1:String = "build") : *
      {
         var _loc2_:String = null;
         _mode = param1;
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
            "r3":new SecNum(0)
         };
         _attackersDeltaResources = {"dirty":false};
         _attackerMonsterOverdrive = new SecNum(0);
         if(_mode != "build")
         {
            HOUSING.Cull();
            _attackerCreatures = HOUSING._creatures;
            _attackerCreatureUpgrades = _playerCreatureUpgrades;
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
            ATTACK._countdown = 300;
            if(Boolean(GLOBAL._advancedMap) && Boolean(POWERUPS.CheckPowers(POWERUPS.ALLIANCE_DECLAREWAR,"NORMAL")))
            {
               ATTACK._countdown = 420;
            }
            if(Boolean(_advancedMap) && (_mode == "attack" || _mode == "wmattack"))
            {
               _attackerMapCreaturesStart = {};
               for(_loc2_ in _attackerMapCreatures)
               {
                  _attackerMapCreaturesStart[_loc2_] = new SecNum(_attackerMapCreatures[_loc2_].Get());
               }
               _attackersCatapult = _attackerMapResources.catapult.Get();
               _attackersFlinger = !!POWERUPS.CheckPowers(POWERUPS.ALLIANCE_DECLAREWAR,"OFFENSE") ? int(_attackerMapResources.flinger.Get() - 2) : int(_attackerMapResources.flinger.Get());
            }
         }
         if(_mode == "help")
         {
            _myMapRoom = 0;
            if(_bMap)
            {
               _myMapRoom = _bMap._lvl.Get();
            }
         }
         switch(_mode)
         {
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
         _resourceNames = ["#r_twigs#","#r_pebbles#","#r_putty#","#r_goo#","#r_shiny#","#r_time#"];
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
         PLEASEWAIT.Show();
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
            _showMapWaiting = false;
            PLEASEWAIT.Hide();
            MapRoom.ShowDelayed();
         }
         if(BASE._needCurrentCell && Boolean(GLOBAL._currentCell))
         {
            PLEASEWAIT.Hide();
            BASE._needCurrentCell = false;
            BASE._isOutpost = GLOBAL._currentCell._base == 3 ? 1 : 0;
            BASE.LoadBase(null,null,GLOBAL._currentCell._baseID,"build");
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
         if(GLOBAL._advancedMap)
         {
            BASE._needCurrentCell = false;
            MapRoom.Setup(_mapHome,MapRoom._worldID,MapRoom._inviteBaseID,MapRoom._viewOnly);
            MapRoom.Show();
         }
         else
         {
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
            while(_loc1_ < 4)
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
         if(Boolean(_flags.split2) && _flags.splituserid2 < LOGIN._playerID)
         {
            if(GetABTestHash("speedup") >= 13)
            {
               _showStreamlinedSpeedUps = true;
            }
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
         _SCREEN = new Rectangle(0 - (_loc1_ - _SCREENINIT.width) / 2,0 - (_loc2_ - (_SCREENINIT.height + 0)) / 2,_loc1_,_loc2_);
         _SCREENCENTER = new Point(_SCREEN.x + _SCREEN.width / 2,_SCREEN.y + _SCREEN.height / 2);
         _SCREENHUD = new Point(_SCREEN.x,_SCREEN.y + _SCREEN.height - 208);
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
      
      private static function UpdateAFKTimer() : *
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
      
      public static function GetABTestHash(param1:String) : int
      {
         var _loc2_:String = LOGIN._playerID.toString();
         var _loc3_:String = MD5.hash(param1 + _loc2_);
         var _loc4_:String = _loc3_.substr(_loc3_.length - 1,1);
         switch(_loc4_)
         {
            case "a":
               return 10;
            case "b":
               return 11;
            case "c":
               return 12;
            case "d":
               return 13;
            case "e":
               return 14;
            case "f":
               return 15;
            default:
               return int(_loc4_);
         }
      }
   }
}

