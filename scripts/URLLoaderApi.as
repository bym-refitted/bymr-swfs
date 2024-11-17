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
            _loc1_ = this.GetFBDataNickH();
            GLOBAL._appid = _loc1_.app_id;
            GLOBAL._tpid = _loc1_.tpid;
         }
         else
         {
            _loc1_ = GLOBAL._fbdata;
         }
         for(_loc2_ in _loc1_)
         {
            if(_loc2_.substr(0,3) != "fb_" && _loc2_ != "fbid" && _loc2_ != "session" && _loc2_ != "signed_request" && _loc2_.substr(0,2) != "v_")
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
      
      private function GetFBDataAlex() : Object
      {
         return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"qDwRf1ClIMdc84CmM1Oc-vvWfhXKEnL-3FCM9bJH7bo.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjM3NDUyMDAsImlzc3VlZF9hdCI6MTMyMzczODI4Nywib2F1dGhfdG9rZW4iOiJBQUFETXhMNXpXdlVCQU5maWtjbFFoOTY1WFRIOGZMZUV5QjZOcWN0WkNTbHZGdE00Q1BVT2RkSGhQaDRJR1FYMVAzd2lqb2hoWWtTTHF1bHhIclhaQ0IwUnY2WUQ4dzg4WDA3VURnQlk0dm9ZOW80OHltIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9HQiIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMTcyMzAxOTkxIn0\",\"access_token\":\"AAADMxL5zWvUBANfikclQh965XTH8fLeEyB6NqctZCSlvFtM4CPUOddHhPh4IGQX1P3wijohhYkSLqulxHrXZCB0Rv6YD8w88X07UDgBY4voY9o48ym\",\"PHPSESSID\":\"55be0d9e7146cd11318260fe54c23deb\",\"app_id\":\"225145380887285\",\"tpid\":false}");
      }
      
      private function GetFBDataBo() : Object
      {
         return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"zKMmDgwgnn-Oki5Ttzp59Y_QStZrUDrzlNI8coGCHYw.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjAzNTA0MDAsImlzc3VlZF9hdCI6MTMyMDM0NDU2Miwib2F1dGhfdG9rZW4iOiJBQUFBQWMyOWZUTllCQUpqaTk2ODlTdW91MGpmdzZ0Rzd5QUdmZmFiSUtDY0dvanl6eDZ2R1R0eGRZWGJJUmZIUFBPUFg0ZmhWWkNVNnNSUG4ycnhweEloSU5jc1JOb01UNjBLaGUzbWpCN0JoRFYxWGgiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjE4MzA4MjA4NjEifQ\",\"PHPSESSID\":\"d95ce481a3ad14d28ef164211dc59c69\",\"app_id\":\"495789755606\",\"tpid\":false}");
      }
      
      private function GetFBDataEric() : Object
      {
         if(GLOBAL._localMode == 5)
         {
            return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"PGdEE74Ggn8WJnGOSiL1RVgRJiX_DnU4L-NHsrJQ4aM.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjE2NzE2MDAsImlzc3VlZF9hdCI6MTMyMTY2NDU2Mywib2F1dGhfdG9rZW4iOiJBQUFCd3ZldWh6M01CQUpvZzFwYWNNWkJmMmJCTjZxVjh3b0plRWxGYTBTZ21uR0JJS0xBcWtKWkFsRGV5TWdNcEhITmxHaFd2NW5oUDBUR0s3aG9GcXdmMTFmTVpBeGRxTnF3MG83WkJNblhTbXFOWGlGSHEiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjExMjI4MjAxNTMifQ\",\"access_token\":\"AAABwveuhz3MBAJog1pacMZBf2bBN6qV8woJeElFa0SgmnGBIKLAqkJZAlDeyMgMpHHNlGhWv5nhP0TGK7hoFqwf11fMZAxdqNqw0o7ZBMnXSmqNXiFHq\",\"PHPSESSID\":\"ad51468ae1d88c2bb39268801e4ad8e7\",\"app_id\":\"123961004380019\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 3)
         {
            return com.adobe.serialization.json.JSON.decode("{\"v_publisher\":\"vixtest-casualcollective\",\"v_country\":\"US\",\"v_app_id\":\"backyardmonsters\",\"v_username\":\"Eric Foley\",\"v_currency_singular\":\"Credit\",\"v_currency_plural\":\"Credits\",\"v_locale\":\"en-US\",\"v_user\":\"401-eric-foley\",\"v_session_key\":\"7240de11be3464d20354063d92be4d45-1319063967\",\"v_expires\":\"1319063967\",\"PHPSESSID\":\"7f8bf16cf7ba26c58e154a30bb841bec\",\"app_id\":123,\"tpid\":false}");
         }
         if(GLOBAL._localMode == 4)
         {
            return com.adobe.serialization.json.JSON.decode("{\"v_publisher\":\"google\",\"v_country\":\"\",\"v_app_id\":\"backyardmonsters\",\"v_username\":\"Nick Moore\",\"v_currency_singular\":\"Credit\",\"v_currency_plural\":\"Credits\",\"v_locale\":\"en-US\",\"v_user\":\"104951533135356791664\",\"v_session_key\":\"37cf704435af02d87a7507c1845479ab-1320418752\",\"v_expires\":\"1320418752\",\"PHPSESSID\":\"8b8778f4b84ca3aa6f4803e54c7d679b\",\"app_id\":123,\"tpid\":false}");
         }
         if(GLOBAL._localMode > 0)
         {
            return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"4OUhOsA-EbJ8t7TF0UH-hIY-SsWK1vyPvrySjrF_uBE.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMTcyNDM2MDAsImlzc3VlZF9hdCI6MTMxNzIzNjg1NCwib2F1dGhfdG9rZW4iOiIyMjM1MzcyODEwMjk4OTV8Mi5BUUNNWnpTUkNRdWI1WUNvLjM2MDAuMTMxNzI0MzYwMC4xLTExMjI4MjAxNTN8ZTZtN2o1eHpXb1Zqd3poZUJBNzgwOXZUcUkwIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMTIyODIwMTUzIn0\",\"PHPSESSID\":\"88b2b354fde7d4e4d805b8b1bc66d1f8\",\"app_id\":\"223537281029895\",\"tpid\":false}");
         }
         return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"PYag8sMNkcUZkNrYQV3CuuUFPQfI6KQNsf-w1NW2QbA.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMTc0MzQ0MDAsImlzc3VlZF9hdCI6MTMxNzQyODIxMiwib2F1dGhfdG9rZW4iOiJBQUFBQWMyOWZUTllCQUNZTElNUkpveVl2T0ROSU5UWUFZQ2JEV205ckJWam1aQmhGTG94djBBMUVNaElYbmhrQWRJQm9wUWZLeW1aQ3A5WkNsYWdhc3BUSXJPdXdaQWhaQUdVdVpDVFRaQ1pDcW10WkJrR25CZ2pkUSIsInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiMTEyMjgyMDE1MyJ9\",\"PHPSESSID\":\"88b2b354fde7d4e4d805b8b1bc66d1f8\",\"app_id\":\"495789755606\",\"tpid\":false}");
      }
      
      private function GetFBDataKevin() : Object
      {
         if(GLOBAL._localMode == 3)
         {
            return com.adobe.serialization.json.JSON.decode("{\"v_publisher\":\"vixtest-casualcollective\",\"v_country\":\"US\",\"v_app_id\":\"backyardmonsters\",\"v_username\":\"Will McBride\",\"v_currency_singular\":\"Credit\",\"v_currency_plural\":\"Credits\",\"v_locale\":\"en-US\",\"v_user\":\"392-will-mcbride\",\"v_session_key\":\"93c8f1d06740816fcc417233a5d65264-1319060434\",\"v_expires\":\"1319060434\",\"PHPSESSID\":\"b352748332add54f4a34f59874d354bf\",\"app_id\":123,\"tpid\":false}");
         }
         if(GLOBAL._localMode == 4)
         {
            return com.adobe.serialization.json.JSON.decode("{\"v_publisher\":\"google\",\"v_country\":\"\",\"v_app_id\":\"backyardmonsters\",\"v_username\":\"kevin deng\",\"v_currency_singular\":\"Credit\",\"v_currency_plural\":\"Credits\",\"v_locale\":\"en-US\",\"v_user\":\"116733954990138407696\",\"v_session_key\":\"6c213c3140a3b4f968deaf81eb2badce-1320259440\",\"v_expires\":\"1320259440\",\"PHPSESSID\":\"fb2bd52b290933a6a6cdbb13977b343e\",\"app_id\":123,\"tpid\":false}");
         }
         if(GLOBAL._localMode == 1)
         {
            return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"5xJGebLaYc_b5bSi5tQkSrkQOnFFj-mdUqjAazrGW4I.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjE1NjM2MDAsImlzc3VlZF9hdCI6MTMyMTU1NzI5OCwib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQUxMaVJoOVNLWHNySjdFZm5tWkFJVFdwRk1DbkRlSzBWV3Znejd5Z2F5WkNvOGJaQnVYRkFnN2ZqUHFNcHFaQmxNc3RmWVhnMDRoVXlWb2hHUXUyMGxydEtEbHZ2QTJCNGhMWGNENFIiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAADLTlQ61wcBALLiRh9SKXsrJ7EfnmZAITWpFMCnDeK0VWvgz7ygayZCo8bZBuXFAg7fjPqMpqZBlMstfYXg04hUyVohGQu20lrtKDlvvA2B4hLXcD4R\",\"PHPSESSID\":\"b4f213e2f772c17b72f28730291f91d8\",\"app_id\":\"223537281029895\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 5)
         {
            return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"rz5q6vAkfz7qbL3l78SWaZEF6gmlUZDR-mnQOfW1dHU.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjI3MTIwMDAsImlzc3VlZF9hdCI6MTMyMjcwNjUwMiwib2F1dGhfdG9rZW4iOiJBQUFCd3ZldWh6M01CQUIyejhEN01EbGt1WkJUTldtaVFUa3dkTGtpMjczYmo4aXgyWkM2WkJJNlF4S2dxT2RaQ0RZMGZIOEd5aGhjaE5EdHIwd0JwcnMwNW9jaFh0YWFhRFF2ZE94YldTVUxvUXJPQjNrdlgiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAABwveuhz3MBAB2z8D7MDlkuZBTNWmiQTkwdLki273bj8ix2ZC6ZBI6QxKgqOdZCDY0fH8GyhhchNDtr0wBprs05ochXtaaaDQvdOxbWSULoQrOB3kvX\",\"PHPSESSID\":\"7a8ee868877b9307330e0a6fd7dc3529\",\"app_id\":\"123961004380019\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 6)
         {
            return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"rz5q6vAkfz7qbL3l78SWaZEF6gmlUZDR-mnQOfW1dHU.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjI3MTIwMDAsImlzc3VlZF9hdCI6MTMyMjcwNjUwMiwib2F1dGhfdG9rZW4iOiJBQUFCd3ZldWh6M01CQUIyejhEN01EbGt1WkJUTldtaVFUa3dkTGtpMjczYmo4aXgyWkM2WkJJNlF4S2dxT2RaQ0RZMGZIOEd5aGhjaE5EdHIwd0JwcnMwNW9jaFh0YWFhRFF2ZE94YldTVUxvUXJPQjNrdlgiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAABwveuhz3MBAB2z8D7MDlkuZBTNWmiQTkwdLki273bj8ix2ZC6ZBI6QxKgqOdZCDY0fH8GyhhchNDtr0wBprs05ochXtaaaDQvdOxbWSULoQrOB3kvX\",\"PHPSESSID\":\"7a8ee868877b9307330e0a6fd7dc3529\",\"app_id\":\"123961004380019\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 8)
         {
            return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"ShxDHmcoeXD1-8Trm3w-rUPiiWWhyl4d4CQkNEVF6wo.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjQwMTE2MDAsImlzc3VlZF9hdCI6MTMyNDAwNTM5Nywib2F1dGhfdG9rZW4iOiJBQUFETXhMNXpXdlVCQU9oeTVtY3dDZDJXVFpDM0JjMVpCbWxuZmZaQ3BIbVdLRFM4NHYzUGhLTUJUajdmTzZMb3NuSm4xQzh0MzhaQkpkU2JaQlRnNUxtM3dDSlRNQU5wTnNBNWZxTGFaQlpDaHB6azgyNUtUUDMiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAADMxL5zWvUBAOhy5mcwCd2WTZC3Bc1ZBmlnffZCpHmWKDS84v3PhKMBTj7fO6LosnJn1C8t38ZBJdSbZBTg5Lm3wCJTMANpNsA5fqLaZBZChpzk825KTP3\",\"PHPSESSID\":\"fc9e48d0b35a872db57d787e4127f780\",\"app_id\":\"225145380887285\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 9)
         {
            return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"6os4hpTv2GVTXADjQmPu4b3wbtGrUkihC16fEc3cjpU.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjM5MjUyMDAsImlzc3VlZF9hdCI6MTMyMzkxODE2MSwib2F1dGhfdG9rZW4iOiJBQUFCNDJGZUhaQlpCUUJBQ3NnQ2RUeFdFVThPeTVHSnVOek80WkNhTDBxRkw3OGRUM0NBWkF5TUtObUxhTVpDY2NQZG05YnZjWFpDeUNKRFdTRUJpelZCOGtrM3pna00xcXVnNnlNeWZ1ek5mSVpBdkdWeEdCZmQiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAAB42FeHZBZBQBACsgCdTxWEU8Oy5GJuNzO4ZCaL0qFL78dT3CAZAyMKNmLaMZCccPdm9bvcXZCyCJDWSEBizVB8kk3zgkM1qug6yMyfuzNfIZAvGVxGBfd\",\"PHPSESSID\":\"f6e0763b85c9f387a1916943d03e6325\",\"app_id\":\"132870576798692\",\"tpid\":false}");
         }
         return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"XMcUmtokOBufSfOxSatYxwS2NBZsFKnJbrKhW_ikGtM.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjI3OTEyMDAsImlzc3VlZF9hdCI6MTMyMjc4NTE1Nywib2F1dGhfdG9rZW4iOiJBQUFBQWMyOWZUTllCQUFOaGtRYlpBZWlLZ1VhOUYyaHZ0YUMwYjRCSjZVbmxPc1RoTlJnV2VlY0FtaVN6UmhHdll0Vm5XcnI2a01FaHV2ZE9laWNMRkJ4cE9pVEgyTTg1REdYZEx3TklpWW1VcUFEWU8iLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAAAAc29fTNYBAANhkQbZAeiKgUa9F2hvtaC0b4BJ6UnlOsThNRgWeecAmiSzRhGvYtVnWrr6kMEhuvdOeicLFBxpOiTH2M85DGXdLwNIiYmUqADYO\",\"PHPSESSID\":\"0a3287793c5da304c64d0f43cd38d6c1\",\"app_id\":\"495789755606\",\"tpid\":false}");
      }
      
      private function GetFBDataNickH() : Object
      {
         switch(GLOBAL._localMode)
         {
            case 0:
               return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"h5n6ZM5SrPL3sxgSsEiLZvQxUqw3Dr6V_-rPTNOg2qk.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjQwMTg4MDAsImlzc3VlZF9hdCI6MTMyNDAxNDIwNSwib2F1dGhfdG9rZW4iOiJBQUFBQWMyOWZUTllCQUNEak9oUzhVYzdiV3dHY0FmWkNKZjBlUk1yaXBQM0xhQ05oTlpDU2RZbDcwQUlSa2FmUThXcGZFeWlPd2p2Q3ZrNElaQ0tXaG5HQklWNGY2OWtwamFicFRNcFBnWkRaRCIsInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiMTM3MDQ5NDAifQ\",\"access_token\":\"AAAAAc29fTNYBACDjOhS8Uc7bWwGcAfZCJf0eRMripP3LaCNhNZCSdYl70AIRkafQ8WpfEyiOwjvCvk4IZCKWhnGBIV4f69kpjabpTMpPgZDZD\",\"PHPSESSID\":\"1f42465981c6af9a2426ad2ae7d23254\",\"app_id\":\"495789755606\",\"tpid\":false}");
            case 5:
               return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"GBpiWegGJ_sDTvBoE7ri5DUj0OgRebx9l86scWSgy-Q.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjI4NjY4MDAsImlzc3VlZF9hdCI6MTMyMjg2MjAxMSwib2F1dGhfdG9rZW4iOiJBQUFCd3ZldWh6M01CQUZhQmllQ2QzS0VlbUo0eUhvSFpDQnF1NHZkSUVSWkM5TzM5ZTd0Y3Qyb3pxWEJISTVvTzVIOW9GWTdYZ2U3QUJSRFVZWWpKbk04bFhmNFVtbmREdThCMXpwWUFaRFpEIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMzcwNDk0MCJ9\",\"access_token\":\"AAABwveuhz3MBAFaBieCd3KEemJ4yHoHZCBqu4vdIERZC9O39e7tct2ozqXBHI5oO5H9oFY7Xge7ABRDUYYjJnM8lXf4UmndDu8B1zpYAZDZD\",\"PHPSESSID\":\"ec7584357fa3035c31343e7bb1b46287\",\"app_id\":\"123961004380019\",\"tpid\":false}");
            case 8:
               return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"9GUiECeHUhMBhHZDP7Z3nTaXGZeDUgDY66xqlctuyhE.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjQwMTUyMDAsImlzc3VlZF9hdCI6MTMyNDAxMTAyNiwib2F1dGhfdG9rZW4iOiJBQUFETXhMNXpXdlVCQVBBQ0JpRHZFT1FjY2J4eUxRWkFaQ0JWQmhHVWRjSEVtczVLeDlEa0ZERWNEejJ4bkdEcWNPU3hDNjB2bXNnTG80cHNxNjVtT1lnZHJMeFRtSlRVU1c3SWEwOEFaRFpEIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMzcwNDk0MCJ9\",\"access_token\":\"AAADMxL5zWvUBAPACBiDvEOQccbxyLQZAZCBVBhGUdcHEms5Kx9DkFDEcDz2xnGDqcOSxC60vmsgLo4psq65mOYgdrLxTmJTUSW7Ia08AZDZD\",\"PHPSESSID\":\"06cb33ad51338bcded873024f098440c\",\"app_id\":\"225145380887285\",\"tpid\":false}");
            case 9:
               return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"4PnAh79w0tCKxGEGjkITgM8U6YrMjalYhdZBQA1ES4w.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjQyODE2MDAsImlzc3VlZF9hdCI6MTMyNDI3NTE4Miwib2F1dGhfdG9rZW4iOiJBQUFCNDJGZUhaQlpCUUJBSFpCdVlDTEgzc0FwdVBkaWNPbUNRWkM0WVpBSHNFUmY0RFZHUmExMEZ0NHc1S3dWUjdrRkk4ZWpuWXVRYlpCak9HWVMzUlpBNUtQd0RXa0xrb1dtTjhMQWFTeTc5Z1pEWkQiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEzNzA0OTQwIn0\",\"access_token\":\"AAAB42FeHZBZBQBAHZBuYCLH3sApuPdicOmCQZC4YZAHsERf4DVGRa10Ft4w5KwVR7kFI8ejnYuQbZBjOGYS3RZA5KPwDWkLkoWmN8LAaSy79gZDZD\",\"PHPSESSID\":\"f5d24c342d3c268bf758b2d60244f61b\",\"app_id\":\"132870576798692\",\"tpid\":false}");
            default:
               return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"FcJ8jZlhjitrV0-qZw5yY9s4JCzFXT6rlUtZmaB9QFM.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjMyMTI0MDAsImlzc3VlZF9hdCI6MTMyMzIwNjc0Niwib2F1dGhfdG9rZW4iOiJBQUFBQWMyOWZUTllCQUlvZGtwZlpDQnVoejJCWHZKR3Job1FRclUzNzlxS2l0RkVCdFJvMVlQazcyaVlJU3BKT1FBWkJKRDdaQWtWMGk1clZ4Q1pDckh1d1NrWkIyckZzSGd6TGZuMXRDQndaRFpEIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMzcwNDk0MCJ9\",\"access_token\":\"AAAAAc29fTNYBAIodkpfZCBuhz2BXvJGrhoQQrU379qKitFEBtRo1YPk72iYISpJOQAZBJD7ZAkV0i5rVxCZCrHuwSkZB2rFsHgzLfn1tCBwZDZD\",\"PHPSESSID\":\"1f42465981c6af9a2426ad2ae7d23254\",\"app_id\":\"495789755606\",\"tpid\":false}");
         }
      }
      
      private function GetFBDataNickM() : Object
      {
         return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"MfQSMtw-rB7PQwdzp9FgADrmd2p_TQ1AEK4-JdOIwak.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjM4MzE2MDAsImlzc3VlZF9hdCI6MTMyMzgyNTY4Niwib2F1dGhfdG9rZW4iOiJBQUFCNDJGZUhaQlpCUUJBTDFBZmVkUWxXb3IwYjhEN1BydkFSaTg4SUZVVHpxc3lWVlhsRnlDYTJaQlpBSVBtMDlaQmhDZE9LNkY3cWR0b3hEUUR6Z3VqMVpDTGdPY1pDcGJRSmhaQ1dVVWlKbFc2a09xdTdsOU1pIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMDAwMDI2MjUyMzc4MjkifQ\",\"access_token\":\"AAAB42FeHZBZBQBAL1AfedQlWor0b8D7PrvARi88IFUTzqsyVVXlFyCa2ZBZAIPm09ZBhCdOK6F7qdtoxDQDzguj1ZCLgOcZCpbQJhZCWUUiJlW6kOqu7l9Mi\",\"PHPSESSID\":\"27166a10b822945c3d7337859320adea\",\"app_id\":\"132870576798692\",\"tpid\":false}");
      }
      
      private function GetFBDataOrlando() : Object
      {
         if(GLOBAL._localMode == 5)
         {
            return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"k45nJKLATFg1x4ZKHeo6aYNFt6y4IYGW1KPpXafYWnY.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjI3OTEyMDAsImlzc3VlZF9hdCI6MTMyMjc4NjYwMCwib2F1dGhfdG9rZW4iOiJBQUFCd3ZldWh6M01CQUYyd0QxNlNqbnpwa2xzRjVYZ2hTZGxkRzh3ZlhuTkdHcFpCdksxUHZFRlpBWkN4aDRieDNHaUNqV2tUbkZ1a2tkQnpybFdOUzVPMmRiUk1iT2NzaVNSbGN2cnJ3WkRaRCIsInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiNTg3NzI1MDM3In0\",\"access_token\":\"AAABwveuhz3MBAF2wD16SjnzpklsF5XghSdldG8wfXnNGGpZBvK1PvEFZAZCxh4bx3GiCjWkTnFukkdBzrlWNS5O2dbRMbOcsiSRlcvrrwZDZD\",\"PHPSESSID\":\"85919de42685177b1b15d477b6b751d5\",\"app_id\":\"123961004380019\",\"tpid\":false}");
         }
         return com.adobe.serialization.json.JSON.decode("{\"signed_request\":\"ailJIxRwcOwy0TyAm1i3fj6sqyS9wDfTMN1hxsL4Drg.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMTk1MDQ0MDAsImlzc3VlZF9hdCI6MTMxOTQ5OTQ2NCwib2F1dGhfdG9rZW4iOiJBQUFBQWMyOWZUTllCQU1qdXdlcURCWkF3aHU0TlBSbGpmRHQ1VmI1TDJCbnhLMEFUelRBWkNjMXBOOVR6VVRST1QzNTYzRlFjWGJPbWs5UjlyMUV0Z3JrSVZxT1gwMEwxenJoTmtHcmdaRFpEIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiI1ODc3MjUwMzcifQ\",\"PHPSESSID\":\"cb990ef3b07bc6eb645c577c837eef98\",\"app_id\":\"495789755606\",\"tpid\":false}");
      }
      
      private function getHash(param1:String, param2:int) : *
      {
         return MD5.hash(this.getSalt() + param1 + this.getNum(param2));
      }
      
      private function getSalt() : *
      {
         return this.decodeSalt("TU1S0wu1T2S045ttu1WQB5VQ1B10Qsg1I");
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
                  if(jhdata.h)
                  {
                     GLOBAL.ErrorMessage("URLLoaderAPI hash mismatch");
                  }
                  else
                  {
                     GLOBAL.ErrorMessage("URLLoaderAPI no hash received: " + this._req.data);
                  }
               }
            }
            else if(Boolean(this._onComplete))
            {
               this._onComplete(jdata);
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","URLLoaderApi.fireComplete catch URL: " + _baseUrl + " RET: " + _req.data + " MSG:" + e.message);
         }
      }
   }
}

