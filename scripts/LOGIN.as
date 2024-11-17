package
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import com.monsters.maproom_advanced.MapRoom;
   import flash.events.*;
   import flash.external.ExternalInterface;
   import flash.net.*;
   import package_1.class_1;
   
   public class LOGIN
   {
      public static var _playerID:int;
      
      public static var _playerName:String;
      
      public static var _playerLastName:String;
      
      public static var _playerPic:String;
      
      public static var _timePlayed:int;
      
      public static var _playerLevel:int;
      
      public static var _digits:Array;
      
      public static var _sumdigit:int;
      
      public function LOGIN()
      {
         super();
      }
      
      public static function Login() : *
      {
         var handleLoadSuccessful:Function;
         var handleLoadError:Function;
         PLEASEWAIT.Show("Logging In...");
         if(GLOBAL._local)
         {
            handleLoadSuccessful = function(param1:Object):*
            {
               if(param1.error == 0)
               {
                  Process(param1);
               }
               else
               {
                  GLOBAL.ErrorMessage(param1.error);
               }
            };
            handleLoadError = function(param1:IOErrorEvent):void
            {
               GLOBAL.WaitHide();
               GLOBAL.ErrorMessage("");
            };
            new URLLoaderApi().load(GLOBAL._apiURL + "player/getinfo",[["version",GLOBAL._version]],handleLoadSuccessful);
         }
         else
         {
            ExternalInterface.addCallback("loginsuccessful",function(param1:String):*
            {
               var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
               GLOBAL.WaitHide();
               if(_loc2_.error == 0)
               {
                  if(checkHash(param1))
                  {
                     Process(_loc2_);
                  }
                  else
                  {
                     LOGGER.Log("err","JSLogin",true);
                     GLOBAL.ErrorMessage();
                  }
               }
               else
               {
                  GLOBAL.ErrorMessage(_loc2_.error);
               }
            });
            GLOBAL.CallJS("cc.initApplication",[GLOBAL._version,"loginsuccessful"]);
         }
      }
      
      public static function Process(param1:Object) : *
      {
         if(param1.version != GLOBAL._version)
         {
            GLOBAL.ErrorMessage(KEYS.Get("We have updated the game. Please reload."));
         }
         else
         {
            _playerID = param1.userid;
            _playerName = param1.username;
            _playerLastName = param1.last_name;
            _playerPic = param1.pic_square;
            _timePlayed = param1.timeplayed;
            GLOBAL._friendCount = param1.friendcount;
            GLOBAL._sessionCount = param1.sessioncount;
            GLOBAL._addTime = param1.addtime;
            GLOBAL._mapVersion = param1.mapversion;
            GLOBAL._mailVersion = param1.mailversion;
            GLOBAL._soundVersion = param1.soundversion;
            GLOBAL._languageVersion = param1.languageversion;
            if(param1.bookmarks)
            {
               MapRoom._bookmarkData = param1.bookmarks;
            }
            else
            {
               MapRoom._bookmarkData = {};
            }
            if(!param1.languageversion)
            {
               GLOBAL._languageVersion = 8;
            }
            if(param1.sendgift == 1)
            {
               GLOBAL._canGift = true;
            }
            if(param1.sendinvite == 1)
            {
               GLOBAL._canInvite = true;
            }
            BASE._isFan = int(param1.isfan);
            KEYS._storageURL = GLOBAL._storageURL;
            KEYS._logFunction = LOGGER.Log;
            KEYS._languageVersion = GLOBAL._languageVersion;
            KEYS._language = param1.language;
            POPUPS.Setup();
            Digits(_playerID);
            KEYS.Setup(Done);
         }
      }
      
      public static function Digits(param1:int) : *
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc2_:String = param1.toString();
         _digits = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _digits.push(int(_loc2_.charAt(_loc3_)));
            _loc3_++;
         }
         _sumdigit = 0;
         if(_digits.length >= 3)
         {
            _loc4_ = int(_digits[_digits.length - 1] + _digits[_digits.length - 2] + _digits[_digits.length - 3]);
            _loc5_ = _loc4_.toString();
            _sumdigit = int(_loc5_.substr(_loc5_.length - 1,1));
         }
      }
      
      public static function Done() : *
      {
         var _loc1_:int = 0;
         GLOBAL.Setup();
         if(GLOBAL._openBase && GLOBAL._openBase.url && (Boolean(GLOBAL._openBase.userid) || Boolean(GLOBAL._openBase.baseid)) && GLOBAL._openBase.userid != LOGIN._playerID)
         {
            BASE._isOutpost = 0;
            if(!GLOBAL._openBase.userid)
            {
               GLOBAL._openBase.userid = 0;
            }
            if(!GLOBAL._openBase.baseid)
            {
               GLOBAL._openBase.baseid = 0;
            }
            GLOBAL._currentCell = null;
            GLOBAL._mode = "help";
            _loc1_ = 1;
            while(_loc1_ < 5)
            {
               GLOBAL._resources["r" + _loc1_] = new SecNum(0);
               GLOBAL._hpResources["r" + _loc1_] = 0;
               _loc1_++;
            }
            BASE.Load(GLOBAL._openBase.url,GLOBAL._openBase.userid,GLOBAL._openBase.baseid);
         }
         else
         {
            BASE.Load();
         }
      }
      
      public static function checkHash(param1:String) : *
      {
         var _loc2_:Array = param1.split(",\"h\":");
         param1 = _loc2_[0] + "}";
         var _loc3_:String = "{\"h\":" + _loc2_[1];
         var _loc4_:String = param1;
         var _loc5_:* = com.adobe.serialization.json.JSON.decode(param1);
         var _loc6_:* = com.adobe.serialization.json.JSON.decode(_loc3_);
         var _loc7_:String = MD5.hash(getSalt() + _loc4_ + getNum(_loc6_.hn));
         if(_loc7_ !== _loc6_.h)
         {
            return false;
         }
         return true;
      }
      
      public static function getNum(param1:int) : *
      {
         return param1 * (param1 % 11);
      }
      
      public static function getSalt() : *
      {
         return decodeSalt(class_1.method_1(479,-851));
      }
      
      public static function decodeSalt(param1:String) : String
      {
         var _loc4_:String = null;
         var _loc2_:* = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1.substring(_loc3_,_loc3_ + 1);
            switch(_loc4_)
            {
               case "a":
                  _loc2_ += "Z";
                  break;
               case "b":
                  _loc2_ += "Y";
                  break;
               case "c":
                  _loc2_ += "X";
                  break;
               case "d":
                  _loc2_ += "W";
                  break;
               case "e":
                  _loc2_ += "V";
                  break;
               case "f":
                  _loc2_ += "U";
                  break;
               case "g":
                  _loc2_ += "T";
                  break;
               case "h":
                  _loc2_ += "S";
                  break;
               case "i":
                  _loc2_ += "R";
                  break;
               case "j":
                  _loc2_ += "Q";
                  break;
               case "k":
                  _loc2_ += "P";
                  break;
               case "l":
                  _loc2_ += "O";
                  break;
               case "m":
                  _loc2_ += "N";
                  break;
               case "n":
                  _loc2_ += "M";
                  break;
               case "o":
                  _loc2_ += "L";
                  break;
               case "p":
                  _loc2_ += "K";
                  break;
               case "q":
                  _loc2_ += "J";
                  break;
               case "r":
                  _loc2_ += "I";
                  break;
               case "s":
                  _loc2_ += "H";
                  break;
               case "t":
                  _loc2_ += "G";
                  break;
               case "u":
                  _loc2_ += "F";
                  break;
               case "v":
                  _loc2_ += "E";
                  break;
               case "w":
                  _loc2_ += "D";
                  break;
               case "x":
                  _loc2_ += "C";
                  break;
               case "y":
                  _loc2_ += "B";
                  break;
               case "z":
                  _loc2_ += "A";
                  break;
               case "A":
                  _loc2_ += "z";
                  break;
               case "B":
                  _loc2_ += "y";
                  break;
               case "C":
                  _loc2_ += "x";
                  break;
               case "D":
                  _loc2_ += "w";
                  break;
               case "E":
                  _loc2_ += "v";
                  break;
               case "F":
                  _loc2_ += "u";
                  break;
               case "G":
                  _loc2_ += "t";
                  break;
               case "H":
                  _loc2_ += "s";
                  break;
               case "I":
                  _loc2_ += "r";
                  break;
               case "J":
                  _loc2_ += "q";
                  break;
               case "K":
                  _loc2_ += "p";
                  break;
               case "L":
                  _loc2_ += "o";
                  break;
               case "M":
                  _loc2_ += "n";
                  break;
               case "N":
                  _loc2_ += "m";
                  break;
               case "O":
                  _loc2_ += "l";
                  break;
               case "P":
                  _loc2_ += "k";
                  break;
               case "Q":
                  _loc2_ += "j";
                  break;
               case "R":
                  _loc2_ += "i";
                  break;
               case "S":
                  _loc2_ += "h";
                  break;
               case "T":
                  _loc2_ += "g";
                  break;
               case "U":
                  _loc2_ += "f";
                  break;
               case "V":
                  _loc2_ += "e";
                  break;
               case "W":
                  _loc2_ += "d";
                  break;
               case "X":
                  _loc2_ += "c";
                  break;
               case "Y":
                  _loc2_ += "b";
                  break;
               case "Z":
                  _loc2_ += "a";
                  break;
               case "0":
                  _loc2_ += "9";
                  break;
               case "1":
                  _loc2_ += "8";
                  break;
               case "2":
                  _loc2_ += "7";
                  break;
               case "3":
                  _loc2_ += "6";
                  break;
               case "4":
                  _loc2_ += "5";
                  break;
               case "5":
                  _loc2_ += "4";
                  break;
               case "6":
                  _loc2_ += "5";
                  break;
               case "7":
                  _loc2_ += "2";
                  break;
               case "8":
                  _loc2_ += "1";
                  break;
               case "9":
                  _loc2_ += "0";
                  break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

