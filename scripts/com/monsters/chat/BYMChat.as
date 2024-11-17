package com.monsters.chat
{
   import com.monsters.chat.ui.ChatBox;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.User;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class BYMChat extends Sprite
   {
      private static var _chat:CS_SmartFoxServer2X = null;
      
      public static var _userRecord:UserRecord = null;
      
      public static const WIDTH:int = 380;
      
      private static var _serverInited:Boolean = false;
      
      private static var _displayNameMap:Dictionary = new Dictionary();
      
      public const GLOBAL_CHANNEL:Channel = new Channel("World","system");
      
      private var _auth:AS_Login = null;
      
      private var _joinAttempts:int = 0;
      
      private const DELAY_INITIAL:int = 1000;
      
      private const DELAY_INCREASE:int = 500;
      
      private const DELAY_DECREASE:int = 500;
      
      private const DELAY_DECREASE_TIME:int = 1000;
      
      private var delay:int = 1000;
      
      private var initialized:Boolean = false;
      
      private var _sectorBaseName:String = null;
      
      private const MESSAGE_QUEUE_SIZE:int = 2;
      
      private var messageQueue:Array = new Array();
      
      private var sector_channel:Channel = null;
      
      private var default_chat_channel:String = "sector";
      
      private var _ignore_list:Array = null;
      
      private var chatBox:ChatBox;
      
      private var _chatHost:String;
      
      private var _chatPort:int;
      
      private var _isConnected:Boolean = false;
      
      private var _hideX:int;
      
      private var _hideY:int;
      
      private var _showX:int;
      
      private var _showY:int;
      
      public var _open:Boolean = true;
      
      private var globalChatTimer:Timer = null;
      
      private var globalChatLastSent:Date = null;
      
      private var overheat:Boolean = false;
      
      private var messageQueueTimer:Timer = null;
      
      private var messageQueueLastCheck:Date = null;
      
      private var displayedUnavailable:Boolean = false;
      
      public function BYMChat(param1:ChatBox, param2:String)
      {
         super();
         this.chatBox = param1;
         addChild(param1 as MovieClip);
         param1.addEventListener(KeyboardEvent.KEY_DOWN,this.keyboardEventHandler);
         var _loc3_:String = param2 == null || param2 == "" ? CS_SmartFoxServer2X.HOST_TEST : param2;
         var _loc4_:int = CS_SmartFoxServer2X.PORT;
         var _loc5_:Array = _loc3_.split(":");
         if(_loc5_.length > 1)
         {
            _loc3_ = _loc5_[0];
            _loc4_ = int(_loc5_[1]);
         }
         this._chatHost = _loc3_;
         this._chatPort = _loc4_;
      }
      
      public static function get serverInited() : Boolean
      {
         return _serverInited;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = GLOBAL.flagsShouldChatConnectButStayInvisible() ? false : param1;
      }
      
      public function get IsConnected() : Boolean
      {
         return this._isConnected;
      }
      
      public function initServer() : void
      {
         try
         {
            _chat = new CS_SmartFoxServer2X(this._chatHost,this._chatPort);
            _chat.addEventListener(ChatEvent.CONNECT,this.onConnect);
            _chat.addEventListener(ChatEvent.LOGIN,this.onLogin);
            _chat.addEventListener(ChatEvent.JOIN,this.onJoin);
            _chat.addEventListener(ChatEvent.LEAVE,this.onLeave);
            _chat.addEventListener(ChatEvent.SAY,this.onSay);
            _chat.addEventListener(ChatEvent.LIST,this.onList);
            _chat.addEventListener(ChatEvent.MEMBERS,this.onMembers);
            _chat.addEventListener(ChatEvent.IGNORE,this.onIgnore);
            _chat.addEventListener(ChatEvent.UPDATE_NAME,this.onUpdateName);
            _chat.addEventListener(ChatEvent.USER_ENTER,this.onUserEnter);
            _chat.addEventListener(ChatEvent.USER_EXIT,this.onUserExit);
            _serverInited = true;
            this.hide();
         }
         catch(e:*)
         {
            this.hide();
         }
      }
      
      public function init() : void
      {
         this.chatBox.init();
         this.toggleVisibleB();
         this.initialized = true;
      }
      
      private function keyboardEventHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.processInput();
         }
      }
      
      public function broadcastDisplayNameUpdate(param1:int) : void
      {
         if(this.sector_channel == null)
         {
            LOGGER.Log("err","BYMChat.broadcastDisplayNameUpdate(): No sector has been joined yet");
            return;
         }
         if(_userRecord == null)
         {
            LOGGER.Log("err","BYMChat.broadcastDisplayNameUpdate(): No user record available");
            return;
         }
         _chat.updateDisplayName(this.sector_channel,_userRecord.Name,"[" + param1 + "] " + _userRecord.Id);
      }
      
      private function clearChat() : void
      {
         this.chatBox.clearChat();
      }
      
      public function SendMessage() : void
      {
         this.processInput();
      }
      
      private function processInput() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc1_:String = this.chatBox.inputText;
         if(_loc1_.length > 0)
         {
            _loc1_ = _loc1_.replace(/\s+/g," ");
            _loc2_ = null;
            _loc3_ = null;
            _loc4_ = null;
            if(_loc1_.charAt(0) == "/")
            {
               _loc5_ = int(_loc1_.search(/\s+/));
               if(_loc5_ == -1)
               {
                  _loc2_ = _loc1_;
                  _loc1_ = "";
               }
               else
               {
                  _loc2_ = _loc1_.substring(0,_loc5_);
                  _loc1_ = _loc1_.slice(_loc5_ + 1);
                  _loc1_ = _loc1_.replace(/^\s+/,"");
               }
               switch(_loc2_)
               {
                  case "/w":
                  case "/whisper":
                  case "/t":
                  case "/tell":
                  case "/p":
                  case "/pm":
                     _loc5_ = int(_loc1_.search(/\s+/));
                     if(_loc5_ != -1)
                     {
                        _loc3_ = _loc1_.substring(0,_loc5_);
                        _loc1_ = _loc1_.slice(_loc5_ + 1);
                        _loc1_ = _loc1_.replace(/^\s+/,"");
                        this.private_chat(_loc3_,_loc1_);
                     }
                     break;
                  case "/entersector":
                     this.clearChat();
                     this.enter_sector(_loc1_,true);
                     break;
                  case "/i":
                  case "/ignore":
                     _loc3_ = _loc1_;
                     _chat.ignore(_loc3_);
                     break;
                  case "/u":
                  case "/unignore":
                     _loc3_ = _loc1_;
                     _chat.unignore(_loc3_);
                     break;
                  default:
                     this.default_chat(_loc1_);
               }
            }
            else
            {
               this.default_chat(_loc1_);
            }
         }
         this.chatBox.clearInputText();
      }
      
      public function connect() : void
      {
         _chat.connect();
      }
      
      public function login(param1:String, param2:String, param3:int) : void
      {
         _userRecord = new UserRecord(param1,param2);
         this._auth = new AS_Login(_userRecord);
         this._auth.authenticate();
         if(!this._isConnected)
         {
            if(!this.displayedUnavailable)
            {
               this.system_message("Chat is currently unavailable.");
               this.displayedUnavailable = true;
            }
         }
         else
         {
            _chat.login(this._auth);
         }
      }
      
      public function logout() : void
      {
         _chat.logout();
      }
      
      public function system_message(param1:String) : void
      {
         this.showChatMessage(null,null,param1);
      }
      
      public function default_chat(param1:String) : void
      {
         if(!this._isConnected)
         {
            LOGGER.Log("err","BYMChat.default_chat(): not connected");
            return;
         }
         switch(this.default_chat_channel)
         {
            case "sector":
            case "combat":
               this.sector_chat(param1);
               break;
            default:
               this.sector_chat(param1);
         }
      }
      
      public function global_chat(param1:String) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:* = null;
         if(!this._isConnected)
         {
            LOGGER.Log("err","BYMChat.global_chat(): not connected");
            return;
         }
         if(this.globalChatTimer == null)
         {
            _chat.say(this.GLOBAL_CHANNEL,param1);
            this.delay += this.DELAY_INCREASE;
            this.globalChatLastSent = new Date();
            this.globalChatTimer = new Timer(250);
            this.globalChatTimer.addEventListener(TimerEvent.TIMER,this.globalChatListener);
            this.globalChatTimer.start();
         }
         else if(this.messageQueue.length < this.MESSAGE_QUEUE_SIZE)
         {
            _loc2_ = false;
            for each(_loc3_ in this.messageQueue)
            {
               if(_loc3_ == param1)
               {
                  _loc2_ = true;
               }
            }
            if(!_loc2_)
            {
               this.messageQueue.push(param1);
            }
         }
         else
         {
            this.system_message("<font color=\"#FF0000\">Your comlink is overheating.</font>");
            this.overheat = true;
         }
         if(this.messageQueueTimer != null)
         {
            this.messageQueueTimer.stop();
            this.messageQueueTimer = null;
         }
      }
      
      private function globalChatListener(param1:TimerEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:Date = new Date();
         var _loc3_:Number = _loc2_.time - this.globalChatLastSent.time;
         if(_loc3_ > this.delay)
         {
            if(this.messageQueue.length > 0)
            {
               _loc4_ = this.messageQueue.shift() as String;
               _chat.say(this.GLOBAL_CHANNEL,_loc4_);
               this.globalChatLastSent = new Date();
               this.delay += this.DELAY_INCREASE;
               if(this.messageQueue.length == 0)
               {
                  if(this.messageQueueTimer != null)
                  {
                     this.messageQueueTimer.stop();
                     this.messageQueueTimer = null;
                  }
                  this.messageQueueLastCheck = new Date();
                  this.messageQueueTimer = new Timer(250);
                  this.messageQueueTimer.addEventListener(TimerEvent.TIMER,this.messageQueueListener);
                  this.messageQueueTimer.start();
                  if(this.globalChatTimer != null)
                  {
                     this.globalChatTimer.stop();
                     this.globalChatTimer = null;
                  }
               }
            }
            else if(this.globalChatTimer != null)
            {
               this.globalChatTimer.stop();
               this.globalChatTimer = null;
            }
         }
      }
      
      private function messageQueueListener(param1:TimerEvent) : void
      {
         var _loc2_:Date = new Date();
         var _loc3_:Number = _loc2_.time - this.messageQueueLastCheck.time;
         if(_loc3_ > this.DELAY_DECREASE_TIME)
         {
            this.messageQueueLastCheck = new Date();
            this.delay -= this.DELAY_DECREASE;
            if(this.delay <= this.DELAY_INITIAL)
            {
               if(this.messageQueueTimer != null)
               {
                  this.messageQueueTimer.stop();
                  this.messageQueueTimer = null;
                  if(this.overheat)
                  {
                     this.system_message("<font color=\"0x00FFFF\">Your comlink cools down.</font>");
                     this.overheat = false;
                  }
               }
            }
         }
      }
      
      public function enter_sector(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:RegExp = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(!param2)
         {
            if(this._joinAttempts >= 10)
            {
               LOGGER.Log("err","BYMChat.enter_sector: failed to connect to 10 chat rooms; giving up");
               this.hide();
               return;
            }
            _loc3_ = /(\d+)/;
            _loc4_ = param1.split(_loc3_);
            if(_loc4_.length == 0)
            {
               LOGGER.Log("err","BYMChat.enter_sector(): invalid sectorName");
               this.hide();
               return;
            }
            this._sectorBaseName = _loc4_[0];
            _loc5_ = int(_loc4_[1]);
            if(this._joinAttempts > 0)
            {
               _loc5_++;
            }
            ++this._joinAttempts;
            _loc5_ %= GLOBAL.NUM_CHAT_ROOMS;
            param1 = this._sectorBaseName + _loc5_.toString();
         }
         if(this.sector_channel != null && this.sector_channel.Name == param1)
         {
            return;
         }
         if(this._isConnected)
         {
            if(this.sector_channel != null)
            {
               _chat.leave(this.sector_channel);
            }
         }
         this.sector_channel = new Channel(param1,"system");
         if(this._isConnected)
         {
            this.joinSector();
         }
      }
      
      private function clearDisplayNameMap() : void
      {
         _displayNameMap = new Dictionary();
      }
      
      public function sector_chat(param1:String) : void
      {
         if(!this._isConnected)
         {
            LOGGER.Log("err","BYMChat.sector_chat(): not connected");
            return;
         }
         if(this.sector_channel != null)
         {
            _chat.say(this.sector_channel,param1);
         }
         else
         {
            _chat.error(ChatEvent.SAY,"Not in a sector channel.");
         }
      }
      
      public function private_chat(param1:String, param2:String) : void
      {
         if(!this._isConnected)
         {
            LOGGER.Log("err","BYMChat.private_chat(): not connected");
            return;
         }
         if(this._ignore_list != null && this._ignore_list.indexOf(param1) != -1)
         {
            return;
         }
         var _loc3_:Channel = new Channel(param1,"private");
         _chat.say(_loc3_,param2);
      }
      
      private function onConnect(param1:ChatEvent) : void
      {
         var chatEvent:ChatEvent = param1;
         try
         {
            this._isConnected = chatEvent.Success;
            if(!this._isConnected)
            {
               LOGGER.Log("err","BYMChat.login(): not connected");
               if(!this.displayedUnavailable)
               {
                  this.system_message("Chat is currently unavailable.");
                  this.displayedUnavailable = true;
               }
            }
            else if(this._auth != null)
            {
               if(_chat)
               {
                  _chat.login(this._auth);
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BYMChat.onConnect: " + e.message + "\n" + e.getStackTrace());
         }
      }
      
      private function onLogin(param1:ChatEvent) : void
      {
         if(param1.Success)
         {
            this.joinSector();
            this.displayedUnavailable = false;
            _chat.getIgnore();
         }
         else
         {
            LOGGER.Log("err","onLogin() " + param1.Success + ": \'" + param1.Get("error") + "\'");
         }
      }
      
      public function joinGlobal() : void
      {
         this.clearChat();
         _chat.join(this.GLOBAL_CHANNEL);
      }
      
      public function joinSector() : void
      {
         if(this.sector_channel != null)
         {
            this.clearChat();
            this.clearDisplayNameMap();
            _chat.join(this.sector_channel);
            this.default_chat_channel = "sector";
         }
      }
      
      private function onJoin(param1:ChatEvent) : void
      {
         var _loc2_:Channel = null;
         if(param1.Success)
         {
            _loc2_ = param1.Get("channel") as Channel;
            this.system_message("Joined channel " + _loc2_.Name + ".");
            _chat.updateDisplayName(_loc2_,_userRecord.Name,"[" + BASE.BaseLevel().level + "] " + _userRecord.Id);
         }
         else
         {
            LOGGER.Log("err","BYMChat.onJoin() " + param1.Success + ": \'" + param1.Get("error") + "\'");
            this.enter_sector(this._sectorBaseName);
         }
      }
      
      private function onLeave(param1:ChatEvent) : void
      {
         if(!param1.Success)
         {
            LOGGER.Log("err","BYMChat.onLeave() " + param1.Success + ": \'" + param1.Get("error") + "\'");
         }
      }
      
      private function onSay(param1:ChatEvent) : void
      {
         var _loc2_:Channel = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1.Success)
         {
            _loc2_ = param1.Get("channel") as Channel;
            _loc3_ = param1.Get("user") as String;
            _loc4_ = param1.Get("message") as String;
            if(this._ignore_list != null && this._ignore_list.indexOf(_loc3_) != -1)
            {
               return;
            }
            this.showChatMessage(_loc2_,_loc3_,_loc4_);
         }
         else
         {
            LOGGER.Log("err","BYMChat.onSay() " + param1.Success + ": \'" + param1.Get("error") + "\'");
         }
      }
      
      private function onList(param1:ChatEvent) : void
      {
         if(!param1.Success)
         {
            LOGGER.Log("err","BYMChat.onList() " + param1.Success + ": \'" + param1.Get("error") + "\'");
         }
      }
      
      private function onMembers(param1:ChatEvent) : void
      {
         if(!param1.Success)
         {
            LOGGER.Log("err","BYMChat.onMembers() " + param1.Success + ": \'" + param1.Get("error") + "\'");
         }
      }
      
      private function onIgnore(param1:ChatEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1.Success)
         {
            _loc2_ = param1.Get("action") as String;
            _loc3_ = param1.Get("target") as String;
            _loc4_ = this.fetchDisplayName(_loc3_);
            this._ignore_list = param1.Get("ignore_list") as Array;
            if(_loc2_ == "add")
            {
               this.system_message("\'" + _loc4_ + "\' (id:" + _loc3_ + ") is now being ignored.");
            }
            if(_loc2_ == "remove")
            {
               this.system_message("\'" + _loc4_ + "\' (id:" + _loc3_ + ") is no longer ignored.");
            }
         }
         else
         {
            LOGGER.Log("err","BYMChat.onIgnore() " + param1.Success + ": \'" + param1.Get("error") + "\'");
         }
      }
      
      private function onUpdateName(param1:ChatEvent) : void
      {
         var _loc2_:String = param1.Get("userid") as String;
         var _loc3_:String = param1.Get("displayname") as String;
         if(_loc2_ == LOGIN._playerID.toString())
         {
            return;
         }
         _displayNameMap[_loc2_] = _loc3_;
      }
      
      private function onUserEnter(param1:ChatEvent) : void
      {
         var _loc2_:User = param1.Get("user") as User;
         var _loc3_:Room = param1.Get("room") as Room;
         if(this.sector_channel == null)
         {
            LOGGER.Log("err","BYMChat.onUserEnter(): No sector has been joined yet");
            return;
         }
         if(_userRecord == null)
         {
            LOGGER.Log("err","BYMChat.onUserEnter(): No user record available");
            return;
         }
         if(_loc2_.name == _userRecord.Name)
         {
            return;
         }
         _chat.updateDisplayNameDirect(this.sector_channel,_loc2_.name,_userRecord.Name,"[" + BASE.BaseLevel().level + "] " + _userRecord.Id);
      }
      
      private function onUserExit(param1:ChatEvent) : void
      {
         var _loc2_:User = param1.Get("user") as User;
         var _loc3_:Room = param1.Get("room") as Room;
         delete _displayNameMap[_loc2_.name];
      }
      
      public function toggleVisible(... rest) : void
      {
         this._open = !this._open;
         this.toggleVisibleB();
      }
      
      public function toggleVisibleB(... rest) : void
      {
         this.position();
         this.chatBox.update();
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      public function hide() : void
      {
         this.visible = false;
      }
      
      public function fetchDisplayName(param1:String) : String
      {
         var _loc2_:String = null;
         if(param1 == _userRecord.Id)
         {
            _loc2_ = "Me";
         }
         return _displayNameMap[param1];
      }
      
      public function toggleMinimizedStat(param1:Boolean = true) : *
      {
         if(param1 == true)
         {
            GLOBAL.StatSet("chatmin",1);
         }
         else
         {
            GLOBAL.StatSet("chatmin",0);
         }
      }
      
      private function showChatMessage(param1:Channel, param2:String, param3:String) : void
      {
         var _loc4_:* = null;
         var _loc5_:String = null;
         var _loc6_:* = null;
         if(param3 == "")
         {
            return;
         }
         if(param2 == null)
         {
            _loc4_ = "<i>" + param3 + "</i>";
            _loc5_ = "System";
         }
         else
         {
            if(param2 == "Administrator")
            {
               _loc4_ = "<b><font color=\"#FF0000\">Admin: </font></b>";
               _loc6_ = "<b><font color=\"#FF0000\">Admin: </font></b>";
               _loc5_ = "Administrator";
            }
            else if(param2 == "Moderator")
            {
               _loc4_ = "<b><font color=\"#FF0000\">Mod: </font></b>";
               _loc6_ = "<b><font color=\"#FF0000\">Mod: </font></b>";
               _loc5_ = "Moderator";
            }
            else if(param1.Type == "private")
            {
               _loc4_ = "<b><font color=\"#076bbf\">";
               _loc6_ = "<b><font color=\"#076bbf\">";
               if(_userRecord.Name == param2)
               {
                  _loc4_ += "to " + this.fetchDisplayName(param2) + ": ";
                  _loc6_ += "to " + this.fetchDisplayName(param2) + ": ";
               }
               else
               {
                  _loc4_ += this.fetchDisplayName(param2) + ": ";
                  _loc6_ += this.fetchDisplayName(param2) + ": ";
               }
               _loc4_ += "</font></b>";
               _loc6_ += "</font></b>";
               _loc5_ = "Private";
            }
            else
            {
               _loc4_ = "<font color=\"#000000\">";
               _loc6_ = "<font color=\"#000000\">";
               if(_userRecord.Name == param2)
               {
                  _loc4_ += "<b>Me:</b> ";
                  _loc6_ += "<b>Me:</b> ";
               }
               else
               {
                  _loc4_ += "<b>" + this.fetchDisplayName(param2) + ":</b> ";
                  _loc6_ += "<b>" + this.fetchDisplayName(param2) + ":</b> ";
               }
               _loc4_ += "</font>";
               _loc6_ += "</font>";
               _loc5_ = "Default";
            }
            _loc4_ += param3;
         }
         this.chatBox.push(_loc4_,_loc6_,param2,_loc5_);
         if(param2 != null)
         {
            this.chatBox.UpdateAlert(1);
         }
      }
      
      public function ignoreUser(param1:String = null) : void
      {
         if(param1 != null)
         {
            _chat.ignore(param1);
         }
      }
      
      public function position() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:* = GLOBAL._ROOT.stage.stageWidth;
         var _loc2_:* = GLOBAL._ROOT.stage.stageHeight;
         var _loc3_:Rectangle = new Rectangle(0 - (_loc1_ - 760) / 2 + 10,0 - (_loc2_ - 520) / 2,_loc1_,_loc2_);
         this._hideX = _loc3_.x;
         this._showX = _loc3_.x;
         if(GLOBAL._mode == "build" || GLOBAL._mode == "view" || GLOBAL._mode == "help")
         {
            this._hideX = _loc3_.x;
            this._showX = _loc3_.x;
         }
         else if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview")
         {
            this._hideX = _loc3_.x + _loc3_.width - (this.chatBox.width + 5);
            this._showX = _loc3_.x + _loc3_.width - (this.chatBox.width + 5);
         }
         this._showY = 520 + (_loc2_ - 520) / 2 - 37;
         this._hideY = 520 + (_loc2_ - 520) / 2 - 37;
         if(this._open)
         {
            _loc4_ = this._showX;
            _loc5_ = this._showY;
         }
         else
         {
            _loc4_ = this._hideX;
            _loc5_ = this._hideY;
         }
         x = _loc4_;
         y = _loc5_;
         this.chatBox.update();
      }
      
      public function get roomNames() : Array
      {
         if(_chat != null)
         {
            return _chat.roomNames;
         }
         return [];
      }
   }
}

