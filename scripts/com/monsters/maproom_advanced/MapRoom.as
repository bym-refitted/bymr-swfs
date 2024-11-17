package com.monsters.maproom_advanced
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import com.monsters.alliances.ALLIANCES;
   import com.monsters.effects.smoke.Smoke;
   import com.monsters.mailbox.MailBox;
   import com.monsters.mailbox.Thread;
   import com.monsters.mailbox.model.Contact;
   import com.monsters.ui.UI_BOTTOM;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.StageDisplayState;
   import flash.events.*;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class MapRoom
   {
      public static var _homePoint:Point;
      
      public static var _mc:MapRoomPopup;
      
      public static var _currentPosition:Point;
      
      public static var _open:Boolean;
      
      public static var _homeCell:MapRoomCell;
      
      private static var _saveErrors:int;
      
      private static var _bubbleSelectTarget:bubble_selecttarget;
      
      private static var _monsterSource:MapRoomCell;
      
      private static var _requestedZones:Array;
      
      private static var _mcTransferRes:PopupTransferB_CLIP;
      
      private static var _mcTransferMon:PopupMonstersB_CLIP;
      
      public static var _bubbleAcceptInvite:bubble_acceptInvite;
      
      public static var _popupRelocateMe:PopupRelocateMe;
      
      public static var _smokeBMD:BitmapData;
      
      public static var _smokeParticles:Array;
      
      public static var _frame:int;
      
      public static var _zoneWidth:int = 10;
      
      public static var _zoneHeight:int = 10;
      
      public static var _mapWidth:int = 100;
      
      public static var _mapHeight:int = 100;
      
      public static var _bookmarks:Array = [];
      
      public static var _monsterTransferInProgress:Boolean = false;
      
      public static var _resourceTransferInProgress:Boolean = false;
      
      public static var _resourceTransfer:Object = {};
      
      public static var _monsterTransfer:Object = {};
      
      public static var _bookmarkData:Object = {};
      
      private static var _zones:Object = {};
      
      public static var _showEnemyWait:Boolean = false;
      
      private static var _resourceCounter:int = 0;
      
      private static var _monstersTransferred:int = 0;
      
      private static var _allMonstersTransferred:Boolean = false;
      
      public static var _flingerInRange:Boolean = false;
      
      public static var _contacts:Array = [];
      
      public static var _worldID:int = 0;
      
      public static var _inviteBaseID:int = 0;
      
      public static var _inviteLocation:Point = new Point();
      
      public static var _viewOnly:Boolean = false;
      
      public static var _migrateThread:Thread = null;
      
      public static var _reposition:Boolean = false;
      
      public static var _empiredestroyed:Boolean = false;
      
      public static var _showAttackWait:Boolean = false;
      
      public function MapRoom()
      {
         super();
      }
      
      public static function Setup(param1:Point, param2:int = 0, param3:int = 0, param4:Boolean = false, param5:Thread = null) : void
      {
         _homePoint = param1;
         _worldID = param2;
         _inviteBaseID = param3;
         _viewOnly = param4;
         if(_viewOnly)
         {
            _inviteLocation = new Point(param1.x,param1.y);
            if(param5)
            {
               _migrateThread = param5;
            }
         }
         else
         {
            _migrateThread = param5;
         }
         _bubbleSelectTarget = new bubble_selecttarget();
         _bubbleSelectTarget.bCancel.SetupKey("btn_cancel");
         _bubbleSelectTarget.bCancel.addEventListener(MouseEvent.CLICK,TransferCancel);
         _bubbleSelectTarget.x = 270;
         _bubbleSelectTarget.y = 415;
         _saveErrors = 0;
         _showEnemyWait = false;
         _showAttackWait = false;
         _requestedZones = [];
         _contacts = [];
      }
      
      public static function Show(param1:MouseEvent = null) : void
      {
         var onTargetsSuccess:Function = null;
         var onTargetsFail:Function = null;
         var me:Contact = null;
         var system:Contact = null;
         var r:* = undefined;
         var e:MouseEvent = param1;
         onTargetsSuccess = function(param1:Object):void
         {
            var _loc3_:String = null;
            var _loc4_:Contact = null;
            for(_loc3_ in param1.targets)
            {
               _loc4_ = new Contact(_loc3_,param1.targets[_loc3_]);
               if(Boolean(param1.targets[_loc3_].friend) && param1.targets[_loc3_].mapver == 2)
               {
                  _contacts.push(_loc4_);
               }
            }
         };
         onTargetsFail = function(param1:IOErrorEvent):void
         {
         };
         if(WMATTACK._inProgress || Boolean(MONSTERBAITER._attacking))
         {
            return;
         }
         if(GLOBAL._flags.maproom2 != 1)
         {
            GLOBAL.Message(KEYS.Get("map_msg_disabled"));
            return;
         }
         if((BASE._isOutpost || GLOBAL._bMap && GLOBAL._bMap._canFunction || GLOBAL._mode != "build") && (GLOBAL._mode == "help" || !_open))
         {
            PLEASEWAIT.Show(KEYS.Get("newmap_opening"));
            if(_open)
            {
               Hide();
            }
            GLOBAL._showMapWaiting = true;
         }
         else
         {
            if(!GLOBAL._bMap)
            {
               GLOBAL.Message(KEYS.Get("map_msg_notbuilt"));
               return;
            }
            if(!GLOBAL._bMap._canFunction)
            {
               GLOBAL.Message(KEYS.Get("map_msg_damaged"));
               return;
            }
         }
         if(MapRoom._contacts.length == 0)
         {
            _contacts = [];
            me = new Contact(String(LOGIN._playerID),{
               "first_name":"Me",
               "last_name":"",
               "pic_square":LOGIN._playerPic
            },true);
            system = new Contact("0",{
               "first_name":"D.A.V.E.",
               "last_name":"",
               "pic_square":""
            },true);
            system.picClass = system_message;
            r = new URLLoaderApi();
            r.load(GLOBAL._apiURL + "player/getmessagetargets",null,onTargetsSuccess,onTargetsFail);
         }
      }
      
      public static function ShowDelayed(param1:Boolean = false) : void
      {
         if(param1 || _reposition || (BASE._isOutpost || GLOBAL._bMap && GLOBAL._bMap._canFunction || GLOBAL._mode != "build") && (GLOBAL._mode == "help" || !_open))
         {
            SOUNDS.Play("click1");
            _open = true;
            _reposition = false;
            if(_mc != null)
            {
               _mc.Cleanup();
               _mc = null;
            }
            _mc = new MapRoomPopup();
            _mc.Setup();
            BASE.Cleanup();
            GLOBAL._layerUI.addChild(_mc);
            UI2.SetupHUD();
            if(GLOBAL._currentCell)
            {
               GetCell(GLOBAL._currentCell.X,GLOBAL._currentCell.Y,true);
               _mc.JumpTo(new Point(GLOBAL._currentCell.X,GLOBAL._currentCell.Y));
               if(_showEnemyWait)
               {
                  _mc.ShowInfoEnemy(GLOBAL._currentCell,true);
                  _showEnemyWait = false;
               }
               else if(_showAttackWait)
               {
                  _mc.ShowAttack(GLOBAL._currentCell);
                  _showAttackWait = false;
               }
            }
            if(_empiredestroyed)
            {
               GLOBAL.Message(KEYS.Get("empiredestroyed_newbase"));
               _empiredestroyed = false;
            }
            if(GLOBAL._ROOT.stage.displayState == StageDisplayState.NORMAL)
            {
               if(GLOBAL._bymChat)
               {
                  GLOBAL._bymChat.show();
               }
               if(UI_BOTTOM._missions)
               {
                  UI_BOTTOM._missions.visible = true;
               }
            }
            else
            {
               if(GLOBAL._bymChat)
               {
                  GLOBAL._bymChat.hide();
               }
               if(UI_BOTTOM._missions)
               {
                  UI_BOTTOM._missions.visible = false;
               }
            }
         }
      }
      
      public static function Hide(param1:MouseEvent = null) : void
      {
         if(_open && GLOBAL._mode != "attack" && GLOBAL._mode != "wmattack")
         {
            SOUNDS.Play("close");
            if(_mc.parent)
            {
               _mc.parent.removeChild(_mc);
            }
            ClearCells();
            _mc.Cleanup();
            _mc = null;
         }
         _open = false;
      }
      
      public static function HideFromViewOnly() : void
      {
         if(_open && GLOBAL._mode != "attack" && GLOBAL._mode != "wmattack")
         {
            SOUNDS.Play("close");
            _worldID = 0;
            _inviteBaseID = 0;
            _viewOnly = false;
            GLOBAL._currentCell = null;
            Setup(GLOBAL._mapHome);
            if(_mc.parent)
            {
               _mc.parent.removeChild(_mc);
            }
            ClearCells();
            _mc.Cleanup();
            _mc = null;
         }
         _open = false;
      }
      
      public static function ClearCells() : void
      {
         _zones = {};
      }
      
      public static function JumpTo(param1:Point) : void
      {
         if(_mc.parent)
         {
            _mc.JumpTo(param1);
         }
      }
      
      public static function SetPendingInvitation() : void
      {
         _mc._popupInfoMine.PendingInvite();
      }
      
      public static function PreAcceptInvitation(param1:MovieClip) : void
      {
         if(ALLIANCES._myAlliance)
         {
            GLOBAL.Message("You must first leave your Alliance to accept this invitation.");
            return;
         }
         _popupRelocateMe = new PopupRelocateMe();
         _popupRelocateMe.Setup(null,"invite");
         GLOBAL.BlockerAdd(param1);
         param1.addChild(_popupRelocateMe);
      }
      
      public static function AcceptInvitation(param1:Boolean = false) : void
      {
         var handleAcceptSuccessful:Function;
         var handleAcceptError:Function;
         var url:String = null;
         var loadvars:Array = null;
         var SHINYCOST:SecNum = null;
         var RESOURCECOST:SecNum = null;
         var useShiny:Boolean = param1;
         if(ALLIANCES._myAlliance)
         {
            GLOBAL.Message("You must first leave your Alliance to accept this invitation.");
            return;
         }
         if(Boolean(_migrateThread) && _inviteBaseID != 0)
         {
            handleAcceptSuccessful = function(param1:Object):*
            {
               PLEASEWAIT.Hide();
               if(param1.error == 0)
               {
                  if(param1.cantMoveTill)
                  {
                     if(_open)
                     {
                        GLOBAL.Message(KEYS.Get("movebase_warning",{"v1":GLOBAL.ToTime(param1.cantMoveTill - param1.currenttime)}),KEYS.Get("btn_returnhome"),ReturnFromFailedInvite);
                     }
                     else
                     {
                        GLOBAL.Message(KEYS.Get("movebase_warning",{"v1":GLOBAL.ToTime(param1.cantMoveTill - param1.currenttime)}));
                        GLOBAL.BlockerRemove();
                     }
                  }
                  else
                  {
                     if(param1.coords && param1.coords.length == 2 && param1.coords[0] > -1 && param1.coords[1] > -1)
                     {
                        GLOBAL._mapHome = new Point(param1.coords[0],param1.coords[1]);
                        MapRoom.Setup(GLOBAL._mapHome);
                     }
                     MapRoom.BookmarksClear();
                     BASE._loadedFriendlyBaseID = 0;
                     GLOBAL._homeBaseID = 0;
                     GLOBAL._currentCell = null;
                     GLOBAL._mapOutpost = [];
                     if(_open)
                     {
                        Hide();
                     }
                     ClearCells();
                     Setup(GLOBAL._mapHome);
                     _reposition = true;
                     GLOBAL._showMapWaiting = true;
                  }
               }
               else
               {
                  GLOBAL.Message(param1.error);
               }
            };
            handleAcceptError = function(param1:IOErrorEvent):*
            {
               LOGGER.Log("err","MapRoom.AcceptInvitation HTTP");
            };
            url = GLOBAL._baseURL + "migratetofriend";
            loadvars = [["baseid",_inviteBaseID],["threadid",_migrateThread.data.threadid]];
            SHINYCOST = new SecNum(20 * 60);
            RESOURCECOST = new SecNum(10000000);
            if(_popupRelocateMe)
            {
               _popupRelocateMe.Cleanup();
               _popupRelocateMe.Hide();
               _popupRelocateMe = null;
            }
            if(useShiny)
            {
               if(GLOBAL._credits.Get() < SHINYCOST.Get())
               {
                  POPUPS.DisplayGetShiny();
                  return;
               }
               loadvars.push(["shiny",SHINYCOST.Get()]);
            }
            else
            {
               if(GLOBAL._resources.r1.Get() < RESOURCECOST.Get() || GLOBAL._resources.r2.Get() < RESOURCECOST.Get() || GLOBAL._resources.r3.Get() < RESOURCECOST.Get() || GLOBAL._resources.r4.Get() < RESOURCECOST.Get())
               {
                  GLOBAL.Message("You don’t have enough resources to relocate.");
                  return;
               }
               loadvars.push(["resources",com.adobe.serialization.json.JSON.encode({
                  "r1":RESOURCECOST.Get(),
                  "r2":RESOURCECOST.Get(),
                  "r3":RESOURCECOST.Get(),
                  "r4":RESOURCECOST.Get()
               })]);
            }
            PLEASEWAIT.Show(KEYS.Get("wait_movebase"));
            MailBox.Hide();
            if(_migrateThread.parent)
            {
               if(_migrateThread.numChildren > 0)
               {
                  _migrateThread.removeChildAt(1);
               }
               _migrateThread.parent.removeChild(_migrateThread);
            }
            new URLLoaderApi().load(url,loadvars,handleAcceptSuccessful,handleAcceptError);
         }
      }
      
      public static function ReturnFromFailedInvite() : *
      {
         Hide();
         BASE.Load();
      }
      
      public static function RejectInvitation(param1:MouseEvent = null) : void
      {
         var handleRejectSuccessful:Function;
         var handleRejectError:Function;
         var url:String = null;
         var loadvars:Array = null;
         var e:MouseEvent = param1;
         if(Boolean(_migrateThread) && _inviteBaseID != 0)
         {
            handleRejectSuccessful = function(param1:Object):void
            {
               PLEASEWAIT.Hide();
               if(param1.error == 0)
               {
                  GLOBAL._currentCell = null;
                  if(_open)
                  {
                     Hide();
                     ClearCells();
                     Setup(GLOBAL._mapHome);
                     BASE._isOutpost = 0;
                     BASE.LoadBase(null,null,GLOBAL._homeBaseID,"build");
                  }
                  else
                  {
                     MAILBOX.Show();
                  }
               }
               else
               {
                  LOGGER.Log("err","MapRoom.RejectInvitation",param1.error);
               }
            };
            handleRejectError = function(param1:IOErrorEvent):void
            {
               LOGGER.Log("err","MapRoom.RejectInvitation HTTP");
            };
            PLEASEWAIT.Show(KEYS.Get("wait_rejecting"));
            url = GLOBAL._baseURL + "rejectmigratetofriend";
            loadvars = [["baseid",_inviteBaseID],["threadid",_migrateThread.data.threadid]];
            if(_migrateThread.parent)
            {
               if(_migrateThread.numChildren > 0)
               {
                  _migrateThread.removeChildAt(1);
               }
               _migrateThread.data.Changed();
               _migrateThread.parent.removeChild(_migrateThread);
               _migrateThread = null;
               MAILBOX.Hide();
            }
            new URLLoaderApi().load(url,loadvars,handleRejectSuccessful,handleRejectError);
         }
      }
      
      public static function BookmarkDataGet(param1:String) : int
      {
         var _loc2_:int = 0;
         if(_bookmarkData[param1])
         {
            _loc2_ = int(_bookmarkData[param1]);
         }
         return _loc2_;
      }
      
      public static function BookmarkDataSet(param1:String, param2:int, param3:Boolean = true) : void
      {
         var _loc4_:Boolean = false;
         if(!_bookmarkData)
         {
            _bookmarkData = {};
         }
         if(param2 == 0 && Boolean(_bookmarkData[param1]))
         {
            delete _bookmarkData[param1];
            if(param3)
            {
               BookmarksSave();
            }
            _loc4_ = true;
         }
         else if(!_bookmarkData[param1])
         {
            _bookmarkData[param1] = param2;
            if(param3)
            {
               BookmarksSave();
            }
            _loc4_ = true;
         }
         else if(_bookmarkData[param1] != param2)
         {
            _bookmarkData[param1] = param2;
            if(param3)
            {
               BookmarksSave();
            }
            _loc4_ = true;
         }
      }
      
      public static function BookmarkDataGetStr(param1:String) : String
      {
         var _loc2_:String = "";
         if(_bookmarkData[param1])
         {
            _loc2_ = _bookmarkData[param1];
         }
         return _loc2_;
      }
      
      public static function BookmarkDataSetStr(param1:String, param2:String, param3:Boolean = true) : void
      {
         var _loc4_:Boolean = false;
         if(!_bookmarkData)
         {
            _bookmarkData = {};
         }
         if(param2.length > 0 && Boolean(_bookmarkData[param1]))
         {
            delete _bookmarkData[param1];
            if(param3)
            {
               BookmarksSave();
            }
            _loc4_ = true;
         }
         else if(!_bookmarkData[param1])
         {
            _bookmarkData[param1] = param2;
            if(param3)
            {
               BookmarksSave();
            }
            _loc4_ = true;
         }
         else if(_bookmarkData[param1] != param2)
         {
            _bookmarkData[param1] = param2;
            if(param3)
            {
               BookmarksSave();
            }
            _loc4_ = true;
         }
      }
      
      public static function BookmarksSave() : void
      {
         var handleBMSaveSuccessful:Function = null;
         var handleBMSaveError:Function = null;
         handleBMSaveSuccessful = function(param1:Object):*
         {
            if(param1.error != 0)
            {
               LOGGER.Log("err","MapRoom.BookmarksSave",param1.error);
            }
         };
         handleBMSaveError = function(param1:IOErrorEvent):*
         {
            LOGGER.Log("err","MapRoom.BookmarksSave HTTP");
         };
         var url:String = GLOBAL._apiURL + "player/savebookmarks";
         var loadvars:Array = [["bookmarks",com.adobe.serialization.json.JSON.encode(_bookmarkData)]];
         new URLLoaderApi().load(url,loadvars,handleBMSaveSuccessful,handleBMSaveError);
      }
      
      public static function BookmarksClear() : void
      {
         MapRoom._bookmarkData = {};
         MapRoom._bookmarks = [];
         MapRoom.BookmarksSave();
      }
      
      public static function AddBookmark(param1:String, param2:Boolean = true) : Object
      {
         if(param1.length == 0)
         {
            return {
               "hide":false,
               "message":KEYS.Get("newmap_bm_name")
            };
         }
         if(param1.length > 20)
         {
            return {
               "hide":false,
               "message":KEYS.Get("newmap_bm_long")
            };
         }
         if(_currentPosition.x < 0 || _currentPosition.x >= _mapWidth || _currentPosition.y < 0 || _currentPosition.y >= _mapHeight)
         {
            return {
               "hide":true,
               "message":"ERROR: Bookmark point is not on the map."
            };
         }
         if(_bookmarks.length >= 8)
         {
            return {
               "hide":true,
               "message":KEYS.Get("newmap_bm_full")
            };
         }
         var _loc4_:int = int(_bookmarks.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(_bookmarks[_loc5_].location.x == _currentPosition.x && _bookmarks[_loc5_].location.y == _currentPosition.y)
            {
               return {
                  "hide":true,
                  "message":KEYS.Get("newmap_bm_done")
               };
            }
            _loc5_++;
         }
         if(param2)
         {
            BookmarkDataSet("mbm" + _loc4_,_currentPosition.x * 10000 + _currentPosition.y,false);
            BookmarkDataSetStr("mbmn" + _loc4_,param1,false);
            BookmarkDataSet("mbms",_loc4_ + 1);
         }
         _bookmarks.push({
            "name":param1,
            "location":_currentPosition
         });
         return {
            "hide":true,
            "message":"SUCCESS"
         };
      }
      
      public static function RequestData(param1:Point, param2:Boolean = false) : void
      {
         var handleLoadSuccessful:Function;
         var handleLoadError:Function;
         var z:objZone = null;
         var loadvars:Array = null;
         var zonePoint:Point = param1;
         var force:Boolean = param2;
         var zoneID:int = zonePoint.x * 10000 + zonePoint.y;
         var url:String = GLOBAL._mapURL + "getarea";
         var t:int = getTimer();
         var getResources:int = 0;
         if(force || GLOBAL.Timestamp() > _resourceCounter + 20)
         {
            getResources = 1;
            _resourceCounter = GLOBAL.Timestamp();
            force = true;
         }
         if(_zones[zoneID])
         {
            z = _zones[zoneID];
         }
         else
         {
            z = new objZone();
            _zones[zoneID] = z;
         }
         if(force || GLOBAL.Timestamp() - z.updated > 30)
         {
            handleLoadSuccessful = function(param1:Object):void
            {
               var _loc2_:int = 0;
               var _loc3_:int = 0;
               var _loc4_:Array = null;
               var _loc5_:Object = null;
               if(!_open && !BASE._needCurrentCell)
               {
                  return;
               }
               if(param1 && !param1.error && Boolean(param1.data))
               {
                  _loc2_ = param1.x * 10000 + param1.y;
                  if(!_zones[_loc2_])
                  {
                     _zones[_loc2_] = new objZone();
                  }
                  _zones[_loc2_].data = param1.data;
                  if(param1.resources)
                  {
                     _loc3_ = 1;
                     while(_loc3_ < 5)
                     {
                        GLOBAL._resources["r" + _loc3_].Set(param1.resources["r" + _loc3_]);
                        GLOBAL._hpResources["r" + _loc3_] = param1.resources["r" + _loc3_];
                        GLOBAL._resources["r" + _loc3_ + "max"] = param1.resources["r" + _loc3_ + "max"];
                        GLOBAL._hpResources["r" + _loc3_ + "max"] = param1.resources["r" + _loc3_ + "max"];
                        _loc3_++;
                     }
                  }
                  if(param1.alliancedata)
                  {
                     _loc4_ = param1.alliancedata;
                     ALLIANCES.ProcessAlliances(_loc4_);
                  }
                  if(MapRoom._open)
                  {
                     MapRoom._mc.Update(true);
                  }
                  else if(BASE._needCurrentCell)
                  {
                     if(_zones && _zones[_loc2_] && Boolean(_zones[_loc2_].data) && Boolean(_zones[_loc2_].data[BASE._currentCellLoc.x]))
                     {
                        _loc5_ = _zones[_loc2_].data[BASE._currentCellLoc.x][BASE._currentCellLoc.y];
                        GLOBAL._currentCell = new MapRoomCell();
                        GLOBAL._currentCell.Setup(_loc5_);
                        GLOBAL._currentCell.X = BASE._currentCellLoc.x;
                        GLOBAL._currentCell.Y = BASE._currentCellLoc.y;
                        _zones = {};
                     }
                  }
               }
               else if(Boolean(param1) && !param1.data)
               {
                  LOGGER.Log("err","MapRoom.Data NO DATA");
               }
               else
               {
                  LOGGER.Log("err","MapRoom.Data",param1.error);
               }
            };
            handleLoadError = function(param1:IOErrorEvent):void
            {
               ++_saveErrors;
               if(_saveErrors >= 3)
               {
                  LOGGER.Log("err","MapRoom.RequestData HTTP");
                  GLOBAL.ErrorMessage("WorldMapRoom.RequestData HTTP");
               }
            };
            z.updated = GLOBAL.Timestamp() + int(Math.random() * 10);
            loadvars = [["x",int(zonePoint.x)],["y",int(zonePoint.y)],["width",_zoneWidth],["height",_zoneHeight],["sendresources",getResources]];
            _saveErrors = 0;
            if(_viewOnly)
            {
               loadvars.push(["worldid",_worldID]);
            }
            new URLLoaderApi().load(url,loadvars,handleLoadSuccessful,handleLoadError);
         }
      }
      
      public static function GetCell(param1:int, param2:int, param3:Boolean = false) : *
      {
         var _loc4_:Point = new Point(int(param1 / _zoneWidth) * _zoneWidth,int(param2 / _zoneHeight) * _zoneHeight);
         var _loc5_:int = _loc4_.x * 10000 + _loc4_.y;
         RequestData(_loc4_,param3);
         if(_zones && _zones[_loc5_] && Boolean(_zones[_loc5_].data) && Boolean(_zones[_loc5_].data[param1]))
         {
            return _zones[_loc5_].data[param1][param2];
         }
         return null;
      }
      
      public static function Tick() : void
      {
         if(_open && _mc && Boolean(_mc.parent))
         {
            _mc.Tick();
         }
         if(_open && (!_mc || _mc && !_mc.parent) && BASE._saveCounterA == BASE._saveCounterB)
         {
            PLEASEWAIT.Hide();
            if(_mc)
            {
               _mc.Cleanup();
               _mc = null;
            }
            _mc = new MapRoomPopup();
            _mc.Setup();
            BASE.Cleanup();
            GLOBAL._layerWindows.addChild(_mc);
         }
      }
      
      public static function Update() : void
      {
         if(_open && _mc && Boolean(_mc.parent))
         {
            _mc.Update(true);
         }
      }
      
      public static function Cleanup() : void
      {
      }
      
      public static function TransferMonstersA(param1:MapRoomCell, param2:Object) : void
      {
         var _loc4_:String = null;
         _monsterTransfer = {};
         var _loc3_:Boolean = false;
         for(_loc4_ in param2)
         {
            _monsterTransfer[_loc4_] = new SecNum(param2[_loc4_].Get());
            if(param2[_loc4_].Get() > 0)
            {
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            _monsterSource = param1;
            if(_bubbleSelectTarget.parent)
            {
               _bubbleSelectTarget.parent.removeChild(_bubbleSelectTarget);
            }
            _mc.addChild(_bubbleSelectTarget);
            _monsterTransferInProgress = true;
         }
         else
         {
            _monsterTransfer = {};
            _monsterTransferInProgress = false;
         }
      }
      
      public static function TransferMonstersB(param1:MapRoomCell) : void
      {
         if(_monsterTransferInProgress)
         {
            if(param1._mine)
            {
               if(param1._baseID == _monsterSource._baseID)
               {
                  if(_bubbleSelectTarget.parent)
                  {
                     _bubbleSelectTarget.parent.removeChild(_bubbleSelectTarget);
                  }
                  _mc.ShowMonstersA(_monsterSource,true);
                  return;
               }
               _mc.ShowMonstersB(_monsterTransfer,param1);
            }
         }
      }
      
      public static function TransferMonstersC(param1:MapRoomCell) : *
      {
         var transferSuccessful:Function;
         var transferError:Function;
         var actualTransfer:Object = null;
         var finalMonsters:Object = null;
         var finalSrcMonsters:Object = null;
         var dst:* = undefined;
         var src:String = null;
         var spaceRemaining:int = 0;
         var baseUpdateFrom:Array = null;
         var baseUpdateTo:Array = null;
         var srcMonsterData:* = undefined;
         var targetMonsterData:Object = null;
         var transferVars:Array = null;
         var cost:int = 0;
         var targetCell:MapRoomCell = param1;
         if(_monsterTransferInProgress)
         {
            if(targetCell._mine)
            {
               PLEASEWAIT.Show();
               _mc.HideMonstersB();
               if(targetCell._monsters && _monsterSource && targetCell._monsterData.space.Get() > 0)
               {
                  transferSuccessful = function(param1:Object):void
                  {
                     var _loc2_:int = 0;
                     PLEASEWAIT.Hide();
                     if(param1.error == 0)
                     {
                        if(_allMonstersTransferred)
                        {
                           GLOBAL.Message(KEYS.Get("newmap_tr_done"));
                        }
                        else
                        {
                           GLOBAL.Message(KEYS.Get("newmap_tr_space",{"v1":_monstersTransferred}));
                        }
                        _loc2_ = 1;
                        while(_loc2_ < 5)
                        {
                           for(dst in finalMonsters)
                           {
                              if(targetCell._monsters[dst])
                              {
                                 targetCell._monsters[dst].Set(finalMonsters[dst]);
                                 targetCell._hpMonsters[dst] = finalMonsters[dst];
                              }
                              else
                              {
                                 targetCell._monsters[dst] = new SecNum(finalMonsters[dst]);
                                 targetCell._hpMonsters[dst] = finalMonsters[dst];
                              }
                           }
                           if(_monsterSource)
                           {
                              for(src in finalSrcMonsters)
                              {
                                 if(finalSrcMonsters[src] > 0)
                                 {
                                    _monsterSource._monsters[src].Set(finalSrcMonsters[src]);
                                    _monsterSource._hpMonsters[src] = finalSrcMonsters[src];
                                 }
                                 else
                                 {
                                    delete _monsterSource._monsters[src];
                                    delete _monsterSource._hpMonsters[src];
                                 }
                              }
                           }
                           _loc2_++;
                        }
                     }
                     else
                     {
                        GLOBAL.Message("There was a problem with the transfer: " + param1.error);
                     }
                     _monsterTransfer = {};
                  };
                  transferError = function(param1:IOErrorEvent):void
                  {
                     PLEASEWAIT.Hide();
                     GLOBAL.Message("There was a problem with the transfer:" + param1.text);
                     _monsterTransfer = {};
                  };
                  actualTransfer = {};
                  finalMonsters = {};
                  finalSrcMonsters = {};
                  spaceRemaining = int(targetCell._monsterData.space.Get());
                  baseUpdateFrom = ["BMU"];
                  baseUpdateTo = ["BMU"];
                  if(_bubbleSelectTarget.parent)
                  {
                     _bubbleSelectTarget.parent.removeChild(_bubbleSelectTarget);
                  }
                  _monsterTransferInProgress = false;
                  for(dst in targetCell._monsters)
                  {
                     finalMonsters[dst] = targetCell._monsters[dst].Get();
                     spaceRemaining -= targetCell._monsters[dst].Get() * CREATURES.GetProperty(dst,"cStorage");
                  }
                  for(src in _monsterSource._monsters)
                  {
                     finalSrcMonsters[src] = _monsterSource._monsters[src].Get();
                  }
                  _monstersTransferred = 0;
                  _allMonstersTransferred = true;
                  for(src in _monsterTransfer)
                  {
                     cost = CREATURES.GetProperty(src,"cStorage");
                     if(spaceRemaining >= _monsterTransfer[src].Get() * cost)
                     {
                        actualTransfer[src] = _monsterTransfer[src].Get();
                        _monstersTransferred += _monsterTransfer[src].Get();
                     }
                     else
                     {
                        _allMonstersTransferred = false;
                        actualTransfer[src] = int(spaceRemaining / cost);
                        _monstersTransferred += int(spaceRemaining / cost);
                     }
                     if(targetCell._monsters[src])
                     {
                        finalMonsters[src] = targetCell._monsters[src].Get() + actualTransfer[src];
                     }
                     else
                     {
                        finalMonsters[src] = actualTransfer[src];
                     }
                     if(_monsterSource._monsters[src])
                     {
                        finalSrcMonsters[src] = _monsterSource._monsters[src].Get() - actualTransfer[src];
                     }
                     spaceRemaining -= actualTransfer[src] * cost;
                     baseUpdateFrom.push({
                        "creatureID":src,
                        "count":actualTransfer[src]
                     });
                     baseUpdateTo.push({
                        "creatureID":src,
                        "count":-actualTransfer[src]
                     });
                     if(spaceRemaining <= 0)
                     {
                        break;
                     }
                  }
                  if(!targetCell.Check())
                  {
                     LOGGER.Log("err","BASE.Save:  transfer target Cell " + targetCell.X + "," + targetCell.Y + "does not check out before doing monster transfer!  " + com.adobe.serialization.json.JSON.encode(targetCell._hpMonsterData));
                  }
                  if(!_monsterSource.Check())
                  {
                     LOGGER.Log("err","BASE.Save:  transfer source Cell " + _monsterSource.X + "," + _monsterSource.Y + "does not check out before doing monster transfer!  " + com.adobe.serialization.json.JSON.encode(_monsterSource._hpMonsterData));
                  }
                  srcMonsterData = {
                     "hcc":_monsterSource._hpMonsterData.hcc,
                     "h":_monsterSource._hpMonsterData.h,
                     "housed":finalSrcMonsters,
                     "hid":_monsterSource._hpMonsterData.hid,
                     "hstage":_monsterSource._hpMonsterData.hstage,
                     "saved":GLOBAL.Timestamp()
                  };
                  targetMonsterData = {
                     "hcc":targetCell._hpMonsterData.hcc,
                     "h":targetCell._hpMonsterData.h,
                     "housed":finalMonsters,
                     "hid":targetCell._hpMonsterData.hid,
                     "hstage":targetCell._hpMonsterData.hstage,
                     "saved":GLOBAL.Timestamp()
                  };
                  transferVars = [["frombaseid",_monsterSource._baseID],["tobaseid",targetCell._baseID],["monsters",com.adobe.serialization.json.JSON.encode([srcMonsterData,targetMonsterData])]];
                  new URLLoaderApi().load(GLOBAL._mapURL + "transferassets",transferVars,transferSuccessful,transferError);
                  return;
               }
               if(targetCell._monsterData.space.Get() == 0)
               {
                  GLOBAL.Message(KEYS.Get("newmap_tr_err1"));
               }
               PLEASEWAIT.Hide();
               return KEYS.Get("newmap_tr_err1");
            }
            GLOBAL.Message(KEYS.Get("newmap_tr_err2"));
            PLEASEWAIT.Hide();
            return KEYS.Get("newmap_tr_err2");
         }
         PLEASEWAIT.Hide();
         return KEYS.Get("newmap_tr_err3");
      }
      
      public static function TransferCancel(param1:MouseEvent = null) : void
      {
         if(_bubbleSelectTarget.parent)
         {
            _bubbleSelectTarget.parent.removeChild(_bubbleSelectTarget);
         }
         _resourceTransfer = {};
         _monsterTransfer = {};
         _resourceTransferInProgress = false;
         _monsterTransferInProgress = false;
      }
      
      public static function Resize() : void
      {
         _mc.x = 0;
         _mc.y = 0;
         ResizeHandler();
      }
      
      public static function ResizeHandler() : void
      {
         if(!_viewOnly)
         {
            Hide();
         }
         else
         {
            HideFromViewOnly();
         }
         ShowDelayed(true);
      }
      
      public static function SmokeAdd() : void
      {
         if(_smokeBMD)
         {
            return;
         }
         SmokeRemove();
         _smokeBMD = new BitmapData(100,100,true,0xffffff);
         _smokeParticles = [];
      }
      
      public static function SmokeRemove() : void
      {
         _smokeBMD = null;
      }
      
      public static function SmokeTick(param1:Event = null) : *
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:BitmapData = null;
         if(!_smokeBMD)
         {
            return;
         }
         _frame += 1;
         if(_frame == 1000)
         {
            _frame = 0;
         }
         if(_frame % 2 == 0)
         {
            if(_smokeParticles.length < 200)
            {
               _smokeParticles.push({
                  "position":new Point(2 + Math.random() * 15,90),
                  "speed":3 + Math.random(),
                  "wind":0.6 + Math.random() * 0.4
               });
            }
            _smokeBMD.fillRect(_smokeBMD.rect,0xffffff);
            _loc2_ = 0;
            while(_loc2_ < _smokeParticles.length)
            {
               _loc3_ = _smokeParticles[_loc2_];
               _loc3_.position.x += _loc3_.wind * 0.4;
               _loc3_.position.y -= _loc3_.speed * 0.2;
               if(_loc3_.speed > 0.1)
               {
                  _loc3_.speed -= 0.02;
               }
               _loc4_ = int(100 - 25 * _loc3_.speed);
               if(_loc4_ < 60)
               {
                  _loc4_ = 60;
               }
               _loc5_ = Smoke._smokeParticleBMD[_loc4_];
               _smokeBMD.copyPixels(_loc5_,_loc5_.rect,_loc3_.position,null,null,true);
               if(_loc4_ >= 95)
               {
                  _smokeParticles[_loc2_] = {
                     "position":new Point(2 + Math.random() * 15,90),
                     "speed":3 + Math.random(),
                     "wind":0.6 + Math.random() * 0.5
                  };
               }
               _loc2_++;
            }
         }
      }
   }
}

