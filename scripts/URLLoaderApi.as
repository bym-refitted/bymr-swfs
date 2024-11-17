package
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import package_1.class_1;
   
   public class URLLoaderApi
   {
      public static var _data:String = "";
      
      public var _URL:String;
      
      private var _status:int;
      
      private var _url:String;
      
      private var _req:URLLoader;
      
      private var _onComplete:Function;
      
      private var _onError:Function;
      
      private var _baseUrl:String;
      
      public function URLLoaderApi()
      {
         super();
      }
      
      public function json_decode(param1:String) : *
      {
         var out:Object = null;
         var string:String = param1;
         try
         {
            out = com.adobe.serialization.json.JSON.decode(string);
            return out;
         }
         catch(error:Error)
         {
            return {};
         }
      }
      
      public function json_encode(param1:Object) : *
      {
         var out:String = null;
         var object:Object = param1;
         try
         {
            out = com.adobe.serialization.json.JSON.encode(object);
            return out;
         }
         catch(error:Error)
         {
            return false;
         }
      }
      
      public function load(param1:String, param2:Array = null, param3:Function = null, param4:Function = null, param5:Boolean = true) : *
      {
         var _loc11_:Object = null;
         var _loc12_:String = null;
         var _loc13_:* = undefined;
         var _loc14_:int = 0;
         var _loc15_:Array = null;
         this._onComplete = param3;
         this._onError = param4;
         this._baseUrl = param1;
         if(param5)
         {
            _loc11_ = this.getFbData();
            _loc12_ = "";
            for(_loc13_ in _loc11_)
            {
               _loc12_ += "&" + _loc13_ + "=" + _loc11_[_loc13_];
            }
            _loc12_ = _loc12_.substr(1);
            param1 = param1 + "?ts=" + GLOBAL.Timestamp() + "&" + _loc12_;
         }
         this._url = param1;
         var _loc6_:URLRequest = new URLRequest(param1);
         var _loc7_:String = "";
         var _loc8_:URLVariables = new URLVariables();
         if(param2 != null && param2.length > 0)
         {
            _loc14_ = 0;
            while(_loc14_ < param2.length)
            {
               _loc15_ = param2[_loc14_];
               _loc8_[_loc15_[0]] = _loc15_[1];
               _loc7_ += _loc15_[1];
               _data += param2[_loc14_][0] + "=" + param2[_loc14_][1] + "&";
               _loc14_++;
            }
         }
         var _loc9_:int = int(Math.random() * 9999999);
         _loc8_.hn = _loc9_;
         var _loc10_:String = this.getHash(_loc7_,_loc9_);
         _loc8_.h = _loc10_;
         _loc6_.data = _loc8_;
         _loc6_.method = URLRequestMethod.POST;
         this._req = new URLLoader(_loc6_);
         this._req.addEventListener(Event.COMPLETE,this.fireComplete);
         this._req.addEventListener(IOErrorEvent.IO_ERROR,this.loadError);
         this._req.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.setStatus);
      }
      
      private function getFbData() : *
      {
         var _loc2_:* = undefined;
         var _loc1_:Object = {};
         if(GLOBAL._local)
         {
            _loc1_ = com.adobe.serialization.json.JSON.decode("{\"fb_sig_request_method\":\"GET\",\"fb_sig_in_canvas\":\"1\",\"fb_sig_locale\":\"en_US\",\"fb_sig_in_new_facebook\":\"1\",\"fb_sig_time\":\"1311202643.6126\",\"fb_sig_added\":\"1\",\"fb_sig_profile_update_time\":\"1308185854\",\"fb_sig_expires\":\"1311206400\",\"fb_sig_user\":\"1122820153\",\"fb_sig_session_key\":\"2.AQCs-ZpZFse1yJSf.3600.1311206400.1-1122820153\",\"fb_sig_ext_perms\":\"email\",\"fb_sig_preload_fql_timestamp\":\"1311202643.6126\",\"fb_sig_country\":\"us\",\"fb_sig_api_key\":\"c11ea2880d6b94be2fd187e9f274acea\",\"fb_sig_app_id\":\"191772264192545\",\"fb_sig\":\"7b0a75e6d8fce2297c2469a29edcc212\",\"PHPSESSID\":\"c11ea2880d6b94be2fd187e9f274acea1122820153\",\"app_id\":\"191772264192545\",\"tpid\":\"P_kb65UzVLyvpQONAARv0PtXm9g\"}");
            GLOBAL._appid = _loc1_.app_id;
            GLOBAL._tpid = _loc1_.tpid;
         }
         else
         {
            _loc1_ = GLOBAL._fbdata;
         }
         for(_loc2_ in _loc1_)
         {
            if(_loc2_.substr(0,3) != "fb_" && _loc2_ != "fbid" && _loc2_ != "session" && _loc2_ != "signed_request")
            {
               delete _loc1_[_loc2_];
            }
            if(_loc2_ == "fb_friends")
            {
               delete _loc1_[_loc2_];
            }
         }
         return _loc1_;
      }
      
      private function getHash(param1:String, param2:int) : *
      {
         return MD5.hash(this.getSalt() + param1 + this.getNum(param2));
      }
      
      private function getSalt() : *
      {
         return this.decodeSalt(class_1.method_1(-56,-340));
      }
      
      private function decodeSalt(param1:String) : String
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
      
      private function getNum(param1:int) : *
      {
         return param1 * (param1 % 11);
      }
      
      private function setStatus(param1:HTTPStatusEvent) : *
      {
         this._status = param1.status;
      }
      
      private function loadError(param1:IOErrorEvent) : *
      {
         LOGGER.Log("err",this._url);
         if(this._onError === null)
         {
            return true;
         }
         this._onError(param1);
      }
      
      public function Clear() : void
      {
         this._req.removeEventListener(Event.COMPLETE,this.fireComplete);
         this._req.removeEventListener(IOErrorEvent.IO_ERROR,this.loadError);
         this._req.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.setStatus);
         this._req = null;
      }
      
      private function fireComplete(param1:Event) : *
      {
         var data:String = null;
         var data1:Array = null;
         var hdata:String = null;
         var string:String = null;
         var jdata:* = undefined;
         var jhdata:* = undefined;
         var h:String = null;
         var event:Event = param1;
         if(this._onComplete === null)
         {
            return true;
         }
         try
         {
            data = this._req.data;
            data1 = data.split(",\"h\":");
            hdata = "{\"h\":" + data1.pop();
            data = data1.join(",\"h\":") + "}";
            string = data;
            jdata = this.json_decode(data);
            jhdata = this.json_decode(hdata);
            h = MD5.hash(this.getSalt() + string + this.getNum(jhdata.hn));
            if(h !== jhdata.h)
            {
               if(GLOBAL._reloadonerror)
               {
                  GLOBAL.CallJS("reloadPage");
               }
               else
               {
                  if(!jhdata.h)
                  {
                  }
                  LOGGER.Log("err",this._url + " -- " + string + " -- " + this._status + " --");
                  GLOBAL.ErrorMessage();
               }
            }
            else if(Boolean(this._onComplete))
            {
               this._onComplete(jdata);
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","URLLoaderApi.fireComplete catch URL: " + _baseUrl + " RET: " + _req.data);
         }
      }
   }
}

