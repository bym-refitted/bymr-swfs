package com.monsters.alliances
{
   import com.monsters.maproom_advanced.MapRoom;
   import com.monsters.maproom_advanced.MapRoomCell;
   import flash.events.*;
   
   public class ALLIANCES
   {
      public static var _worldID:int;
      
      public static var _playerID:int;
      
      public static var _allianceID:int;
      
      public static var _alliances:Object;
      
      public static var _myAlliance:AllyInfo;
      
      public static var _open:Boolean;
      
      public static var _allyMembers:Array = [];
      
      public static var _friendlyMembers:Array = [];
      
      public static var _hostileMembers:Array = [];
      
      public static var _dataExpireLength:int = 50 * 60;
      
      public static var _dataExpireMarker:Number = 0;
      
      public static var canFetchAllianceData:Boolean = false;
      
      public function ALLIANCES()
      {
         super();
      }
      
      public static function Setup(param1:int = 0) : void
      {
         _alliances = new Object();
         if(param1 > 0)
         {
            if(GLOBAL._mode == "build")
            {
               _allianceID = param1;
               ACHIEVEMENTS.Check("alliance",1,true);
            }
         }
      }
      
      public static function Clear() : void
      {
         if(_alliances)
         {
            _alliances = null;
         }
         _alliances = new Object();
         if(_myAlliance)
         {
            _myAlliance = null;
         }
      }
      
      public static function GetAllianceInfo(param1:int, param2:MapRoomCell = null, param3:Boolean = false) : void
      {
         var onAllianceInfoSuccessEx:Function = null;
         var onAllianceInfoFail:Function = null;
         var aid:int = param1;
         var targetcell:MapRoomCell = param2;
         var force:Boolean = param3;
         onAllianceInfoSuccessEx = function(param1:Object, param2:MapRoomCell = null, param3:Boolean = false):void
         {
            var _loc4_:Object = null;
            var _loc5_:AllyInfo = null;
            var _loc6_:Object = null;
            if(param1.error == 0)
            {
               if(_alliances[param1.alliances[0].alliance_id])
               {
                  if(param2)
                  {
                     param2._alliance = _alliances[param1.alliances[0].alliance_id];
                     if(param3)
                     {
                        _loc6_ = MapRoom.GetCell(param2.X,param2.Y);
                        param2.Update();
                     }
                  }
               }
               _loc4_ = param1.alliances[0];
               _loc5_ = new AllyInfo(_loc4_);
               _alliances[_loc4_.alliance_id] = _loc5_;
               if(param2)
               {
                  param2._alliance = _loc5_;
                  if(param3)
                  {
                     _loc6_ = MapRoom.GetCell(param2.X,param2.Y);
                     param2.Update();
                  }
               }
            }
         };
         var onAllianceInfoSuccess:Function = function(param1:Object):void
         {
            var _loc2_:Object = null;
            var _loc3_:AllyInfo = null;
            if(param1.error == 0)
            {
               if(_alliances[param1.alliance_id])
               {
                  return;
               }
               _loc2_ = param1.alliances;
               _loc3_ = new AllyInfo(_loc2_);
               _alliances[_loc2_.alliance_id] = _loc3_;
            }
         };
         onAllianceInfoFail = function(param1:IOErrorEvent):void
         {
         };
         var r:URLLoaderApi = new URLLoaderApi();
         var alliancevars:Array = [["alliance_ids",aid]];
         r.load(GLOBAL._allianceURL + "getalliances",alliancevars,EventCallbackEx(onAllianceInfoSuccessEx,[targetcell,force]),onAllianceInfoFail);
      }
      
      public static function SetCellAlliance(param1:*, param2:Boolean = false) : AllyInfo
      {
         var _loc3_:AllyInfo = null;
         var _loc4_:int = 0;
         if(Boolean(param1._allianceID) && param1._allianceID != 0)
         {
            _loc4_ = int(param1._allianceID);
            if(_alliances[_loc4_])
            {
               _loc3_ = _alliances[_loc4_];
               param1._alliance = _loc3_;
            }
            else if(canFetchAllianceData)
            {
               GetAllianceInfo(_loc4_,param1,param2);
               return null;
            }
            if(_allianceID && _allianceID != 0 && Boolean(_loc3_))
            {
               _loc3_.Relations(_allianceID);
            }
            return _loc3_;
         }
         return null;
      }
      
      public static function SetAlliance(param1:Object) : AllyInfo
      {
         var _loc2_:AllyInfo = null;
         var _loc3_:int = int(param1.alliance_id);
         if(_alliances[param1.alliance_id])
         {
            _loc2_ = _alliances[_loc3_];
         }
         else
         {
            _loc2_ = new AllyInfo(param1);
         }
         if(_allianceID && _allianceID != 0 && _loc2_ && !_loc2_.relationship)
         {
            _loc2_.Relations(_allianceID);
         }
         return _loc2_;
      }
      
      public static function ProcessAlliances(param1:Array) : void
      {
         var _loc3_:Object = null;
         var _loc4_:AllyInfo = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = new AllyInfo(_loc3_);
            _alliances[_loc3_.alliance_id] = _loc4_;
            _loc2_++;
         }
      }
      
      public static function AllianceInvite(param1:*) : void
      {
         var r:URLLoaderApi;
         var alliancevars:Array;
         var onAllianceInviteSuccess:Function = null;
         var onAllianceInviteFail:Function = null;
         var _cell:* = param1;
         onAllianceInviteSuccess = function(param1:Object):void
         {
            PLEASEWAIT.Hide();
            if(param1.response == "success")
            {
               GLOBAL.Message(KEYS.Get("msg_allianceinvitesent"));
               return;
            }
            if(param1.error)
            {
               GLOBAL.Message(KEYS.Get("msg_err_processinginvite_long") + " - " + param1.error + ": " + param1.error_code);
            }
            else
            {
               GLOBAL.Message(KEYS.Get("msg_err_processinginvite_short"));
            }
         };
         onAllianceInviteFail = function(param1:IOErrorEvent):void
         {
            GLOBAL.Message(KEYS.Get("msg_err_sendinginvite"));
         };
         if(_cell._base < 2)
         {
            GLOBAL.Message(KEYS.Get("msg_cannotinvite",{"v1":_cell._name}));
            return;
         }
         if(!_myAlliance)
         {
            GLOBAL.Message(KEYS.Get("msg_notinalliance"));
            return;
         }
         r = new URLLoaderApi();
         alliancevars = [["user_id",_cell._userID]];
         r.load(GLOBAL._allianceURL + "inviteuserclient",alliancevars,onAllianceInviteSuccess,onAllianceInviteFail);
      }
      
      public static function ShowAlliances(param1:MouseEvent = null) : void
      {
         ShowAlliancesDialogue();
      }
      
      public static function ShowAlliancesDialogue(param1:String = null) : void
      {
         if(param1 == null)
         {
            param1 = "search";
         }
         if(!ALLIANCES._open)
         {
            ALLIANCES._open = true;
            if(!GLOBAL._local)
            {
               POPUPS.AddBG();
            }
            GLOBAL.CallJS("alliances.showAlliancesDialog",[{
               "type":param1,
               "callback":"alliancesupdate"
            }]);
         }
      }
      
      public static function AlliancesCallback(param1:String) : void
      {
         if(ALLIANCES._open)
         {
            if(!GLOBAL._local)
            {
               POPUPS.RemoveBG();
            }
            ALLIANCES._open = false;
         }
         if(GLOBAL._halt)
         {
            GLOBAL.CallJS("reloadPage");
         }
         else if(MapRoom._open)
         {
            MapRoom.ResizeHandler();
         }
      }
      
      public static function AlliancesServerUpdate(param1:String) : void
      {
         if(ALLIANCES._open)
         {
            if(!GLOBAL._local)
            {
               POPUPS.RemoveBG();
            }
            ALLIANCES._open = false;
         }
         if(BASE._userID == LOGIN._playerID)
         {
            BASE.Page();
         }
         else
         {
            BASE.Page();
         }
      }
      
      public static function AlliancesViewLeader(param1:String) : void
      {
      }
      
      private static function EventCallbackEx(param1:Function, param2:Array) : Function
      {
         var method:Function = param1;
         var args:Array = param2;
         return function(param1:Object):void
         {
            method.apply(null,[param1].concat(args));
         };
      }
   }
}

