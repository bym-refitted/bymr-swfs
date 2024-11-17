package com.monsters.chat
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.core.SFSEvent;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.User;
   import com.smartfoxserver.v2.entities.data.SFSArray;
   import com.smartfoxserver.v2.entities.data.SFSObject;
   import com.smartfoxserver.v2.logging.LoggerEvent;
   import com.smartfoxserver.v2.requests.AdminMessageRequest;
   import com.smartfoxserver.v2.requests.ExtensionRequest;
   import com.smartfoxserver.v2.requests.JoinRoomRequest;
   import com.smartfoxserver.v2.requests.LeaveRoomRequest;
   import com.smartfoxserver.v2.requests.LoginRequest;
   import com.smartfoxserver.v2.requests.MessageRecipientMode;
   import com.smartfoxserver.v2.requests.PrivateMessageRequest;
   import com.smartfoxserver.v2.requests.PublicMessageRequest;
   import com.smartfoxserver.v2.util.ClientDisconnectionReason;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class CS_SmartFoxServer2X extends EventDispatcher implements IChatSystem
   {
      public static const HOST_LIVE:String = "message4.dc.kixeye.com";
      
      public static const HOST_TEST:String = "message3.dc.kixeye.com";
      
      public static const PORT:int = 9933;
      
      public static const ZONE:String = "Backyard Monsters";
      
      private static const EXT_REQ_STRING:String = "backyardmonsters";
      
      private var m_user:UserRecord = null;
      
      private var m_login:AS_Login = null;
      
      private var sfs:SmartFox;
      
      private var roomMap:Dictionary;
      
      private var host:String = null;
      
      private var port:int = -1;
      
      private var zone:String = null;
      
      private var _isLoggedIn:Boolean = false;
      
      private var _isLoggingOut:Boolean = false;
      
      private var join_channel:Channel = null;
      
      private var keepAliveTimer:Timer;
      
      private var keepAliveInterval:int = 120000;
      
      public function CS_SmartFoxServer2X(param1:String = "message3.dc.kixeye.com", param2:int = 9933, param3:String = "Backyard Monsters")
      {
         super();
         this.host = param1;
         this.port = param2;
         this.zone = param3;
         this.sfs = new SmartFox(true);
         this.sfs.debug = false;
         this.sfs.addEventListener(LoggerEvent.DEBUG,this.onErrorLogged);
         this.sfs.addEventListener(LoggerEvent.ERROR,this.onErrorLogged);
         this.sfs.addEventListener(LoggerEvent.INFO,this.onErrorLogged);
         this.sfs.addEventListener(LoggerEvent.WARNING,this.onErrorLogged);
         this.sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE,this.onExtensionResponse);
         this.sfs.addEventListener(SFSEvent.ADMIN_MESSAGE,this.onAdminMessage);
         this.sfs.addEventListener(SFSEvent.MODERATOR_MESSAGE,this.onModeratorMessage);
         this.sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS,this.onConfigLoadSuccess);
         this.sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE,this.onConfigLoadFailure);
         this.sfs.addEventListener(SFSEvent.CONNECTION,this.onConnection);
         this.sfs.addEventListener(SFSEvent.CONNECTION_LOST,this.onConnectionLost);
         this.sfs.addEventListener(SFSEvent.CONNECTION_RESUME,this.onConnectionResume);
         this.sfs.addEventListener(SFSEvent.CONNECTION_RETRY,this.onConnectionRetry);
         this.sfs.addEventListener(SFSEvent.LOGIN_ERROR,this.onLoginError);
         this.sfs.addEventListener(SFSEvent.LOGIN,this.onLogin);
         this.sfs.addEventListener(SFSEvent.LOGOUT,this.onLogout);
         this.sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR,this.onRoomJoinError);
         this.sfs.addEventListener(SFSEvent.ROOM_JOIN,this.onRoomJoin);
         this.sfs.addEventListener(SFSEvent.PUBLIC_MESSAGE,this.onPublicMessage);
         this.sfs.addEventListener(SFSEvent.PRIVATE_MESSAGE,this.onPrivateMessage);
         this.sfs.addEventListener(SFSEvent.USER_ENTER_ROOM,this.onUserEnterRoom);
         this.sfs.addEventListener(SFSEvent.USER_EXIT_ROOM,this.onUserExitRoom);
         this.connect();
      }
      
      public function connect() : Boolean
      {
         var success:Boolean = false;
         if(!this.sfs.isConnected)
         {
            try
            {
               this.sfs.connect(this.host,this.port);
               success = true;
            }
            catch(e:*)
            {
            }
         }
         return success;
      }
      
      private function onErrorLogged(param1:LoggerEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["user"] = "Logger";
         _loc3_["channel"] = new Channel("World","system");
         _loc3_["message"] = param1.params.message;
         dispatchEvent(new ChatEvent(ChatEvent.SAY,false,_loc3_));
      }
      
      private function onExtensionResponse(param1:SFSEvent) : void
      {
         var _loc2_:String = param1.params.cmd;
         var _loc3_:SFSObject = param1.params.params as SFSObject;
         var _loc4_:String = _loc3_.getUtfString("command");
         switch(_loc4_)
         {
            case "room_add":
               this.roomResponse(param1,"add");
               break;
            case "room_remove":
               this.roomResponse(param1,"remove");
               break;
            case "room":
               this.roomResponse(param1);
               break;
            case "ignore":
               this.ignoreResponse(param1);
               break;
            case "updatename":
               this.updateName(param1);
         }
      }
      
      private function updateName(param1:SFSEvent, param2:String = null) : void
      {
         var _loc3_:SFSObject = param1.params.params as SFSObject;
         var _loc4_:Boolean = _loc3_.getBool("success");
         var _loc5_:String = _loc3_.getUtfString("command");
         var _loc6_:String = null;
         if(param2 != null)
         {
            _loc6_ = param2;
         }
         else
         {
            _loc6_ = _loc3_.getUtfString("action");
         }
         switch(_loc6_)
         {
            case "updatedirect":
            case "update":
               var _loc7_:Dictionary = new Dictionary();
               _loc7_["userid"] = _loc3_.getUtfString("userid");
               _loc7_["displayname"] = _loc3_.getUtfString("displayname");
               dispatchEvent(new ChatEvent(ChatEvent.UPDATE_NAME,_loc4_,_loc7_));
               return;
            default:
               LOGGER.Log("err","updateName() - unknown action: " + _loc6_);
               return;
         }
      }
      
      private function roomResponse(param1:SFSEvent, param2:String = null) : void
      {
         var _loc3_:SFSObject = param1.params.params as SFSObject;
         var _loc4_:String = _loc3_.getUtfString("command");
         var _loc5_:String = null;
         if(param2 != null)
         {
            _loc5_ = param2;
         }
         else
         {
            _loc5_ = _loc3_.getUtfString("action");
         }
         var _loc6_:String = null;
         switch(_loc5_)
         {
            case "add":
               _loc6_ = _loc3_.getUtfString("response");
               this.roomMap[_loc6_] = this.sfs.getRoomByName(_loc6_);
               if(_loc6_ == this.join_channel.Name)
               {
                  this.join(this.join_channel);
               }
               break;
            case "remove":
               _loc6_ = _loc3_.getUtfString("response");
               delete this.roomMap[_loc6_];
         }
      }
      
      private function ignoreResponse(param1:SFSEvent) : void
      {
         var _loc2_:SFSObject = param1.params.params as SFSObject;
         var _loc3_:String = _loc2_.getUtfString("command");
         var _loc4_:String = _loc2_.getUtfString("action");
         var _loc5_:Boolean = _loc2_.getBool("success");
         var _loc6_:SFSArray = _loc2_.getSFSArray("response") as SFSArray;
         var _loc7_:Dictionary = new Dictionary();
         _loc7_["command"] = _loc3_;
         _loc7_["action"] = _loc4_;
         _loc7_["ignore_list"] = _loc6_ != null ? _loc6_.toArray() : null;
         if(_loc4_ == "add" || _loc4_ == "remove")
         {
            _loc7_["target"] = _loc2_.getUtfString("target");
         }
         dispatchEvent(new ChatEvent(ChatEvent.IGNORE,_loc5_,_loc7_));
      }
      
      private function onAdminMessage(param1:SFSEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["user"] = "Administrator";
         _loc3_["channel"] = new Channel(this.m_user.Name,"private");
         _loc3_["message"] = param1.params.message;
         dispatchEvent(new ChatEvent(ChatEvent.SAY,true,_loc3_));
      }
      
      private function onModeratorMessage(param1:SFSEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["user"] = "Moderator";
         _loc3_["channel"] = new Channel(this.m_user.Name,"private");
         _loc3_["message"] = param1.params.message;
         dispatchEvent(new ChatEvent(ChatEvent.SAY,true,_loc3_));
      }
      
      private function onConfigLoadSuccess(param1:SFSEvent) : void
      {
      }
      
      private function onConfigLoadFailure(param1:SFSEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         dispatchEvent(new ChatEvent(ChatEvent.CONNECT,false,_loc3_));
      }
      
      private function onConnection(param1:SFSEvent) : void
      {
         var _loc2_:Boolean = Boolean(param1.params.success);
         var _loc3_:Dictionary = new Dictionary();
         dispatchEvent(new ChatEvent(ChatEvent.CONNECT,_loc2_,_loc3_));
      }
      
      private function onConnectionLost(param1:SFSEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         switch(param1.params.reason)
         {
            case ClientDisconnectionReason.MANUAL:
               _loc3_["reason"] = "client disconnect";
               break;
            case ClientDisconnectionReason.IDLE:
               _loc3_["reason"] = "idle timeout";
               break;
            case ClientDisconnectionReason.KICK:
               _loc3_["reason"] = "kicked";
               break;
            case ClientDisconnectionReason.BAN:
               _loc3_["reason"] = "banned";
               break;
            default:
               _loc3_["reason"] = "unknown: " + param1.params.reason;
         }
         dispatchEvent(new ChatEvent(ChatEvent.CONNECT,false,_loc3_));
         if(this._isLoggingOut)
         {
            this._isLoggedIn = false;
            this.stopKeepAlive();
         }
      }
      
      private function onConnectionResume(param1:SFSEvent) : void
      {
      }
      
      private function onConnectionRetry(param1:SFSEvent) : void
      {
      }
      
      public function login(param1:IAuthenticationSystem) : void
      {
         var _password:String;
         var _params:SFSObject;
         var loginRequest:LoginRequest;
         var auth:IAuthenticationSystem = param1;
         var loginAuth:AS_Login = auth as AS_Login;
         this.m_login = loginAuth;
         this.m_user = loginAuth.User;
         _password = loginAuth.Password;
         _params = loginAuth.Params;
         loginRequest = new LoginRequest(this.m_user.Name,_password,this.zone,_params);
         try
         {
            this.sfs.send(loginRequest);
            this._isLoggingOut = false;
         }
         catch(e:*)
         {
         }
      }
      
      private function onLogin(param1:SFSEvent) : void
      {
         var _loc3_:Room = null;
         var _loc4_:Boolean = false;
         var _loc5_:Dictionary = null;
         this.roomMap = new Dictionary();
         var _loc2_:Array = this.sfs.roomManager.getRoomList();
         for each(var _loc8_ in _loc2_)
         {
            _loc3_ = _loc8_;
            _loc8_;
            this.roomMap[_loc3_.name] = _loc3_;
         }
         _loc4_ = true;
         _loc5_ = new Dictionary();
         dispatchEvent(new ChatEvent(ChatEvent.LOGIN,_loc4_,_loc5_));
         this._isLoggedIn = true;
         this.initKeepAlive();
      }
      
      private function onLoginError(param1:SFSEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         dispatchEvent(new ChatEvent(ChatEvent.LOGIN,false,_loc3_));
         this._isLoggedIn = false;
         false;
      }
      
      public function logout() : void
      {
         this._isLoggedIn = false;
         false;
         this.sfs.disconnect();
         this.stopKeepAlive();
      }
      
      private function onLogout(param1:SFSEvent) : void
      {
         var event:SFSEvent = param1;
         this._isLoggedIn = false;
         try
         {
            this.sfs.disconnect();
         }
         catch(e:*)
         {
         }
         if(this._isLoggingOut)
         {
            this.stopKeepAlive();
            this._isLoggingOut = false;
         }
      }
      
      public function join(param1:Channel, param2:String = null, param3:Boolean = true) : void
      {
         var doNotLeaveRoom:int = 0;
         var joinRoomRequest:JoinRoomRequest = null;
         var params:SFSObject = null;
         var extensionRequest:ExtensionRequest = null;
         var channel:Channel = param1;
         var password:String = param2;
         var autocreate:Boolean = param3;
         this.join_channel = channel;
         if(Boolean(this.roomMap) && this.join_channel.Name in this.roomMap)
         {
            doNotLeaveRoom = -1;
            joinRoomRequest = new JoinRoomRequest(this.join_channel.Name,"",doNotLeaveRoom,false);
            try
            {
               this.sfs.send(joinRoomRequest);
            }
            catch(e:*)
            {
            }
         }
         else if(autocreate)
         {
            params = new SFSObject();
            params.putUtfString("command","create_room");
            params.putUtfString("name",this.join_channel.Name);
            extensionRequest = new ExtensionRequest(EXT_REQ_STRING,params);
            try
            {
               this.sfs.send(extensionRequest);
            }
            catch(e:*)
            {
            }
         }
      }
      
      public function updateDisplayName(param1:Channel, param2:String, param3:String) : void
      {
         var extensionRequest:ExtensionRequest;
         var channel:Channel = param1;
         var userId:String = param2;
         var displayName:String = param3;
         var params:SFSObject = new SFSObject();
         params.putUtfString("command","updatename");
         params.putUtfString("action","update");
         params.putUtfString("roomname",channel.Name);
         params.putUtfString("userid",userId);
         params.putUtfString("displayname",displayName);
         extensionRequest = new ExtensionRequest(EXT_REQ_STRING,params);
         try
         {
            this.sfs.send(extensionRequest);
         }
         catch(e:*)
         {
            LOGGER.Log("err","Exception in updateDisplayName.sfs.send(extensionRequest): " + e);
         }
      }
      
      public function updateDisplayNameDirect(param1:Channel, param2:String, param3:String, param4:String) : void
      {
         var extensionRequest:ExtensionRequest;
         var channel:Channel = param1;
         var recipientId:String = param2;
         var userId:String = param3;
         var displayName:String = param4;
         var params:SFSObject = new SFSObject();
         params.putUtfString("command","updatename");
         params.putUtfString("action","updatedirect");
         params.putUtfString("roomname",channel.Name);
         params.putUtfString("userid",userId);
         params.putUtfString("displayname",displayName);
         params.putUtfString("recipientid",recipientId);
         extensionRequest = new ExtensionRequest(EXT_REQ_STRING,params);
         try
         {
            this.sfs.send(extensionRequest);
         }
         catch(e:*)
         {
            LOGGER.Log("err","Exception in updateDisplayName.sfs.send(extensionRequest): " + e);
         }
      }
      
      private function onRoomJoin(param1:SFSEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["channel"] = this.join_channel;
         dispatchEvent(new ChatEvent(ChatEvent.JOIN,true,_loc3_));
      }
      
      private function onRoomJoinError(param1:SFSEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["channel"] = this.join_channel;
         dispatchEvent(new ChatEvent(ChatEvent.JOIN,false,_loc3_));
      }
      
      private function onRoomAdd(param1:SFSEvent) : void
      {
         this.roomMap[param1.params.room.name] = param1.params.room;
         if(param1.params.room.name == this.join_channel.Name)
         {
            this.join(this.join_channel);
         }
      }
      
      private function onRoomRemove(param1:SFSEvent) : void
      {
         delete this.roomMap[param1.params.room.name];
      }
      
      private function onRoomCreationError(param1:SFSEvent) : void
      {
      }
      
      public function leave(param1:Channel, param2:Boolean = true) : void
      {
         var leaveRoomRequest:LeaveRoomRequest;
         var success:Boolean;
         var params:Dictionary;
         var channel:Channel = param1;
         var autocleanup:Boolean = param2;
         if(this.roomMap == null)
         {
            return;
         }
         if(!(channel.Name in this.roomMap))
         {
            return;
         }
         leaveRoomRequest = new LeaveRoomRequest(this.roomMap[channel.Name]);
         success = true;
         try
         {
            this.sfs.send(leaveRoomRequest);
         }
         catch(e:*)
         {
            success = false;
            false;
         }
         params = new Dictionary();
         params["channel"] = channel;
         dispatchEvent(new ChatEvent(ChatEvent.LEAVE,success,params));
      }
      
      public function extension(param1:String, param2:Dictionary) : void
      {
         var extensionRequest:ExtensionRequest;
         var cmd:String = param1;
         var params:Dictionary = param2;
         var sfsParams:SFSObject = new SFSObject();
         switch(cmd)
         {
            case "add":
               sfsParams.putInt("n1",params["n1"] as int);
               sfsParams.putInt("n2",params["n2"] as int);
         }
         extensionRequest = new ExtensionRequest(cmd,sfsParams);
         try
         {
            this.sfs.send(extensionRequest);
         }
         catch(e:*)
         {
         }
      }
      
      public function adminMessage(param1:String) : void
      {
         var _loc2_:MessageRecipientMode = new MessageRecipientMode(MessageRecipientMode.TO_ZONE,null);
         var _loc3_:AdminMessageRequest = new AdminMessageRequest(param1,_loc2_,null);
         this.sfs.send(_loc3_);
      }
      
      public function say(param1:Channel, param2:String) : void
      {
         var channelName:String;
         var params:SFSObject = null;
         var receiver:User = null;
         var privMesgRequest:PrivateMessageRequest = null;
         var pubMesgRequest:PublicMessageRequest = null;
         var channel:Channel = param1;
         var chatMessage:String = param2;
         chatMessage = chatMessage.replace(/&/g,"&amp;");
         chatMessage = chatMessage.replace(/</g,"&lt;");
         chatMessage = chatMessage.replace(/>/g,"&gt;");
         chatMessage = chatMessage.replace(/\n/g,"");
         chatMessage = chatMessage.replace(/\r/g,"");
         chatMessage = chatMessage.replace(/&#10;/g,"");
         chatMessage = chatMessage.replace(/&#13;/g,"");
         chatMessage = chatMessage.replace(/^\s+$/,"");
         if(chatMessage == "")
         {
            return;
         }
         channelName = channel.Name;
         if(channel.Type == "private")
         {
            params = new SFSObject();
            params.putUtfString("sender",this.m_user.Name);
            params.putUtfString("receiver",channelName);
            receiver = this.sfs.userManager.getUserByName(channelName);
            if(receiver != null)
            {
               privMesgRequest = new PrivateMessageRequest(chatMessage,receiver.id,params);
               try
               {
                  this.sfs.send(privMesgRequest);
               }
               catch(e:*)
               {
               }
            }
            else
            {
               this.error(null,"no user found: \'" + channelName + "\'");
            }
         }
         if(channel.Type == "system")
         {
            if(this.roomMap == null)
            {
            }
            if(!(channel.Name in this.roomMap))
            {
               return;
            }
            pubMesgRequest = new PublicMessageRequest(chatMessage,null,this.roomMap[channelName]);
            try
            {
               this.sfs.send(pubMesgRequest);
            }
            catch(e:*)
            {
            }
         }
      }
      
      private function onPrivateMessage(param1:SFSEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         var _loc4_:SFSObject = param1.params.data;
         _loc3_["user"] = param1.params.sender.name;
         _loc3_["channel"] = new Channel(_loc4_.getUtfString("receiver"),"private");
         _loc3_["message"] = param1.params.message;
         dispatchEvent(new ChatEvent(ChatEvent.SAY,true,_loc3_));
      }
      
      private function onPublicMessage(param1:SFSEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["user"] = param1.params.sender.name;
         _loc3_["channel"] = new Channel(param1.params.room.name,"system");
         _loc3_["message"] = param1.params.message;
         dispatchEvent(new ChatEvent(ChatEvent.SAY,true,_loc3_));
      }
      
      private function onUserEnterRoom(param1:SFSEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["user"] = param1.params.user;
         _loc3_["room"] = param1.params.room;
         dispatchEvent(new ChatEvent(ChatEvent.USER_ENTER,true,_loc3_));
      }
      
      private function onUserExitRoom(param1:SFSEvent) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["user"] = param1.params.user;
         _loc3_["room"] = param1.params.room;
         dispatchEvent(new ChatEvent(ChatEvent.USER_EXIT,true,_loc3_));
      }
      
      public function list(param1:String = null) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["list"] = new Array();
         dispatchEvent(new ChatEvent(ChatEvent.LIST,true,_loc3_));
      }
      
      public function members(param1:Channel) : void
      {
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["members"] = new Array();
         dispatchEvent(new ChatEvent(ChatEvent.MEMBERS,true,_loc3_));
      }
      
      public function getIgnore() : void
      {
         var _loc1_:SFSObject = new SFSObject();
         _loc1_.putUtfString("command","ignore");
         _loc1_.putUtfString("action","list");
         var _loc2_:ExtensionRequest = new ExtensionRequest(EXT_REQ_STRING,_loc1_);
         this.sfs.send(_loc2_);
      }
      
      public function ignore(param1:String) : void
      {
         var _loc2_:SFSObject = new SFSObject();
         _loc2_.putUtfString("command","ignore");
         _loc2_.putUtfString("action","add");
         _loc2_.putUtfString("target",param1);
         var _loc3_:ExtensionRequest = new ExtensionRequest(EXT_REQ_STRING,_loc2_);
         this.sfs.send(_loc3_);
      }
      
      public function unignore(param1:String) : void
      {
         var _loc2_:SFSObject = new SFSObject();
         _loc2_.putUtfString("command","ignore");
         _loc2_.putUtfString("action","remove");
         _loc2_.putUtfString("target",param1);
         var _loc3_:ExtensionRequest = new ExtensionRequest(EXT_REQ_STRING,_loc2_);
         this.sfs.send(_loc3_);
      }
      
      public function error(param1:String, param2:String) : void
      {
         var _loc4_:Dictionary = new Dictionary();
         _loc4_["error"] = param2;
         dispatchEvent(new ChatEvent(ChatEvent.SAY,false,_loc4_));
      }
      
      private function initKeepAlive() : void
      {
         if(this.keepAliveTimer != null)
         {
            this.stopKeepAlive();
         }
         this.keepAliveTimer = new Timer(this.keepAliveInterval);
         this.keepAliveTimer.addEventListener(TimerEvent.TIMER,this.keepAliveListener);
         this.keepAliveTimer.start();
      }
      
      private function stopKeepAlive() : void
      {
         if(this.keepAliveTimer != null)
         {
            this.keepAliveTimer.removeEventListener(TimerEvent.TIMER,this.keepAliveListener);
            this.keepAliveTimer.stop();
            this.keepAliveTimer = null;
            null;
         }
      }
      
      private function keepAliveListener(param1:TimerEvent) : void
      {
         var extensionRequest:ExtensionRequest;
         var event:TimerEvent = param1;
         var params:SFSObject = new SFSObject();
         params.putUtfString("command","keepalive");
         extensionRequest = new ExtensionRequest(EXT_REQ_STRING,params);
         try
         {
            this.sfs.send(extensionRequest);
         }
         catch(e:*)
         {
         }
         if(!this.sfs.isConnected && this._isLoggedIn && !this._isLoggingOut)
         {
            if(!this.connect())
            {
               this._isLoggedIn = false;
               this.stopKeepAlive();
            }
         }
         if(this._isLoggingOut || !this._isLoggedIn)
         {
            this.stopKeepAlive();
         }
      }
      
      public function get roomNames() : Array
      {
         var _loc2_:Room = null;
         var _loc1_:Array = [];
         for each(var _loc5_ in this.roomMap)
         {
            _loc2_ = _loc5_;
            _loc5_;
            _loc1_.push(_loc2_.name);
         }
         return _loc1_;
      }
      
      public function get numUsers() : int
      {
         return this.sfs.userManager.userCount;
      }
   }
}

