package
{
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
      
      private function getFbData() : *
      {
         var _loc2_:* = undefined;
         var _loc1_:Object = {};
         if(GLOBAL._local)
         {
            _loc1_ = this.GetFBDataKevin();
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
      
      public function json_decode(param1:String) : *
      {
         var out:Object = null;
         var string:String = param1;
         try
         {
            out = JSON.decode(string);
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
            out = JSON.encode(object);
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
      
      private function GetFBDataAlex() : Object
      {
         return JSON.decode("{\"signed_request\":\"qDwRf1ClIMdc84CmM1Oc-vvWfhXKEnL-3FCM9bJH7bo.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjM3NDUyMDAsImlzc3VlZF9hdCI6MTMyMzczODI4Nywib2F1dGhfdG9rZW4iOiJBQUFETXhMNXpXdlVCQU5maWtjbFFoOTY1WFRIOGZMZUV5QjZOcWN0WkNTbHZGdE00Q1BVT2RkSGhQaDRJR1FYMVAzd2lqb2hoWWtTTHF1bHhIclhaQ0IwUnY2WUQ4dzg4WDA3VURnQlk0dm9ZOW80OHltIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9HQiIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMTcyMzAxOTkxIn0\",\"access_token\":\"AAADMxL5zWvUBANfikclQh965XTH8fLeEyB6NqctZCSlvFtM4CPUOddHhPh4IGQX1P3wijohhYkSLqulxHrXZCB0Rv6YD8w88X07UDgBY4voY9o48ym\",\"PHPSESSID\":\"55be0d9e7146cd11318260fe54c23deb\",\"app_id\":\"225145380887285\",\"tpid\":false}");
      }
      
      private function GetFBDataBo() : Object
      {
         if(GLOBAL._localMode == 1)
         {
            return JSON.decode("{\"signed_request\":\"lPhv_kYkhrQvBX95w5_zcN2ePJRY_IS3OD9mu8hvoNw.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjU5OTE2MDAsImlzc3VlZF9hdCI6MTMyNTk4NjM0Miwib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQU9rRVRKUldEWGNpemRReFRqYlhXWkMyOVFkWkJVSVVGY21xeHBHamQxZU5wSFloRWNaQnRWbGs4SE9JUXZDNDFVTVNoMHhIQk16RkpaQmlOYXJ5d0ZBN1BrR1MzUVpEWkQiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjYxMDY1NzkyOSJ9\",\"access_token\":\"AAADLTlQ61wcBAOkETJRWDXcizdQxTjbXWZC29QdZBUIUFcmqxpGjd1eNpHYhEcZBtVlk8HOIQvC41UMSh0xHBMzFJZBiNarywFA7PkGS3QZDZD\",\"PHPSESSID\":\"1c1a05300816a733364c9f0ee81a47d6\",\"app_id\":\"223537281029895\",\"tpid\":false}");
         }
         return JSON.decode("{\"signed_request\":\"zKMmDgwgnn-Oki5Ttzp59Y_QStZrUDrzlNI8coGCHYw.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjAzNTA0MDAsImlzc3VlZF9hdCI6MTMyMDM0NDU2Miwib2F1dGhfdG9rZW4iOiJBQUFBQWMyOWZUTllCQUpqaTk2ODlTdW91MGpmdzZ0Rzd5QUdmZmFiSUtDY0dvanl6eDZ2R1R0eGRZWGJJUmZIUFBPUFg0ZmhWWkNVNnNSUG4ycnhweEloSU5jc1JOb01UNjBLaGUzbWpCN0JoRFYxWGgiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjE4MzA4MjA4NjEifQ\",\"PHPSESSID\":\"d95ce481a3ad14d28ef164211dc59c69\",\"app_id\":\"495789755606\",\"tpid\":false}");
      }
      
      private function GetFBDataEric() : Object
      {
         if(GLOBAL._localMode == 5)
         {
            return JSON.decode("{\"signed_request\":\"PGdEE74Ggn8WJnGOSiL1RVgRJiX_DnU4L-NHsrJQ4aM.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjE2NzE2MDAsImlzc3VlZF9hdCI6MTMyMTY2NDU2Mywib2F1dGhfdG9rZW4iOiJBQUFCd3ZldWh6M01CQUpvZzFwYWNNWkJmMmJCTjZxVjh3b0plRWxGYTBTZ21uR0JJS0xBcWtKWkFsRGV5TWdNcEhITmxHaFd2NW5oUDBUR0s3aG9GcXdmMTFmTVpBeGRxTnF3MG83WkJNblhTbXFOWGlGSHEiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjExMjI4MjAxNTMifQ\",\"access_token\":\"AAABwveuhz3MBAJog1pacMZBf2bBN6qV8woJeElFa0SgmnGBIKLAqkJZAlDeyMgMpHHNlGhWv5nhP0TGK7hoFqwf11fMZAxdqNqw0o7ZBMnXSmqNXiFHq\",\"PHPSESSID\":\"ad51468ae1d88c2bb39268801e4ad8e7\",\"app_id\":\"123961004380019\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 3)
         {
            return JSON.decode("{\"v_publisher\":\"vixtest-casualcollective\",\"v_country\":\"US\",\"v_app_id\":\"backyardmonsters\",\"v_username\":\"Eric Foley\",\"v_currency_singular\":\"Credit\",\"v_currency_plural\":\"Credits\",\"v_locale\":\"en-US\",\"v_user\":\"401-eric-foley\",\"v_session_key\":\"7240de11be3464d20354063d92be4d45-1319063967\",\"v_expires\":\"1319063967\",\"PHPSESSID\":\"7f8bf16cf7ba26c58e154a30bb841bec\",\"app_id\":123,\"tpid\":false}");
         }
         if(GLOBAL._localMode == 6)
         {
            return JSON.decode("{\"signed_request\":\"pEwWA65LnqAgucwicKNrdpOdAelbG_N2HrJ3QSvgWsU.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjY0MDIwMDAsImlzc3VlZF9hdCI6MTMyNjM5NzEzNiwib2F1dGhfdG9rZW4iOiJBQUFBQVQ4bVNEcmdCQUVQUW9EZUttZThiT2I3NGRaQTZDbHd0ZmN4TGVJVGkxZlIyZ21ub1VaQk1CZk14ZWVCbTFlbk9Bc09SeVZkbVFkOG00aDJRcEQzczBESnIwZ0JhcGNKT2ZhbXpYYVpCRHJOZHk4eSIsInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiMTEyMjgyMDE1MyJ9\",\"access_token\":\"AAAAAT8mSDrgBAEPQoDeKme8bOb74dZA6ClwtfcxLeITi1fR2gmnoUZBMBfMxeeBm1enOAsORyVdmQd8m4h2QpD3s0DJr0gBapcJOfamzXaZBDrNdy8y\",\"PHPSESSID\":\"88b2b354fde7d4e4d805b8b1bc66d1f8\",\"app_id\":\"342684208824\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 4)
         {
            return JSON.decode("{\"v_publisher\":\"google\",\"v_country\":\"\",\"v_app_id\":\"backyardmonsters\",\"v_username\":\"Nick Moore\",\"v_currency_singular\":\"Credit\",\"v_currency_plural\":\"Credits\",\"v_locale\":\"en-US\",\"v_user\":\"104951533135356791664\",\"v_session_key\":\"37cf704435af02d87a7507c1845479ab-1320418752\",\"v_expires\":\"1320418752\",\"PHPSESSID\":\"8b8778f4b84ca3aa6f4803e54c7d679b\",\"app_id\":123,\"tpid\":false}");
         }
         if(GLOBAL._localMode == 9)
         {
            return JSON.decode("{\"signed_request\":\"-Vn3w0-BgJY8F6vogBUdTYauJWlWsdaj3mFaX2DJb34.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjQ0NTgwMDAsImlzc3VlZF9hdCI6MTMyNDQ1MTM4MSwib2F1dGhfdG9rZW4iOiJBQUFCNDJGZUhaQlpCUUJBQzZXR05WSGZFTGpxeEdLZ0NqSElIUFYyT054V3MxeTJqY3l3UUhZbVBrbUJKSjYxNXpQMmJhS3NjMFlIZVc4UzBaQkY0WWtOWU9lbXA0MFlEOThjMlAyOXlUbGJVWkM1c1NYTmoiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjExMjI4MjAxNTMifQ\",\"access_token\":\"AAAB42FeHZBZBQBAC6WGNVHfELjqxGKgCjHIHPV2ONxWs1y2jcywQHYmPkmBJJ615zP2baKsc0YHeW8S0ZBF4YkNYOemp40YD98c2P29yTlbUZC5sSXNj\",\"PHPSESSID\":\"4ffb47ddcce7e9e1b4baa7cd60329135\",\"app_id\":\"132870576798692\",\"tpid\":false}");
         }
         if(GLOBAL._localMode > 0)
         {
            return JSON.decode("{\"signed_request\":\"E8_UOV9GNHgC83FUyEozMP1ktADGBaklXZ7kmdjGY7M.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzUzODQwMDAsImlzc3VlZF9hdCI6MTMzNTM3ODU2Nywib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQUxaQ25RRHMzWkJaQ0Nma3dFR0VkazNoZzhuNndRMkxHVlZ2bm1BOTZNOU1UYnpIcmY1WkNOUExMNXRoVVNoOTd1NnJCTktYQU9Sam1PdlpBdVhlWkNTZXNxMmZsM1pBQzdPbGZ4T2RiR2siLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjExMjI4MjAxNTMifQ\",\"access_token\":\"AAADLTlQ61wcBALZCnQDs3ZBZCCfkwEGEdk3hg8n6wQ2LGVVvnmA96M9MTbzHrf5ZCNPLL5thUSh97u6rBNKXAORjmOvZAuXeZCSesq2fl3ZAC7OlfxOdbGk\",\"PHPSESSID\":\"727e278f67f336ea71e8221f3f86517d\",\"app_id\":\"223537281029895\",\"tpid\":\"Ra9rGXLxH2IXXOF65KW996Hpmbs\"}");
         }
         return JSON.decode("{\"signed_request\":\"hkikAE2unyZCzLGotoKsr1w1EWI5CR5sBC9NgNVNmSo.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjY0MjAwMDAsImlzc3VlZF9hdCI6MTMyNjQxNDYwNCwib2F1dGhfdG9rZW4iOiJBQUFBQWMyOWZUTllCQUY3dk01M3VjRnFFWWhlYnJvYzJESWZRM2hiVlhMdmhqZW5CVzVaQXBLVWhRT0tFOWpLVzh6R1dFMHROUnRpSFJtTU1kNEJ2cU40amRKU0tqSjRYcHpySVFVekI3aFRuZzNCVVAiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjExMjI4MjAxNTMifQ\",\"access_token\":\"AAAAAc29fTNYBAF7vM53ucFqEYhebroc2DIfQ3hbVXLvhjenBW5ZApKUhQOKE9jKW8zGWE0tNRtiHRmMMd4BvqN4jdJSKjJ4XpzrIQUzB7hTng3BUP\",\"PHPSESSID\":\"a32eae6052c401484875c914ae0c57fd\",\"app_id\":\"495789755606\",\"tpid\":false}");
      }
      
      private function GetFBDataMichael() : Object
      {
         if(GLOBAL._localMode == 1)
         {
            return JSON.decode("{\"signed_request\":\"yCNxvzAuQIYfiGFYNXKsYtpEz5SsD6bjpsJVqmQvGX0.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzE2Nzk2MDAsImlzc3VlZF9hdCI6MTMzMTY3NDU1OCwib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQUJjMmUyU3I5TXRMekxWZEJKaXMyZlNCYkE0TkYwVWV1N2tnWGhUb2tZOEZIak1OcDdVQ1RBTTlZbUNaQlJDUU0yWGJkYnMxaXdHRUcwZEJaQlVtamlreU9GUFI2MXZoODJGeVpCbiIsInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiMTAwMDAzNjQ3NzczNTk0In0\",\"access_token\":\"AAADLTlQ61wcBABc2e2Sr9MtLzLVdBJis2fSBbA4NF0Ueu7kgXhTokY8FHjMNp7UCTAM9YmCZBRCQM2Xbdbs1iwGEG0dBZBUmjikyOFPR61vh82FyZBn\",\"PHPSESSID\":\"5beae8110d1e550a39bda2b24bfbd2e9\",\"app_id\":\"223537281029895\",\"tpid\":\"du_tPMK9SujXg0qghQmYDgk3OuI\"}");
         }
         if(GLOBAL._localMode == 2)
         {
            return JSON.decode("{\"kongregate_username\":\"mclasgens\",\"kongregate_user_id\":\"7471517\",\"kongregate_game_auth_token\":\"60fdc64b8e60747e4bd9f8a495a553875d901ad5cbfd6efcfc81f576645f85f2\",\"kongregate_game_id\":\"90208\",\"kongregate_host\":\"http://www.kongregate.com\",\"kongregate_game_url\":\"http://www.kongregate.com/games/CasualCollective/bm-kong\",\"kongregate_api_host\":\"http://api.kongregate.com\",\"kongregate_channel_id\":\"1334077285822\",\"kongregate_api_path\":\"http://chat.kongregate.com/flash/API_AS3_66228fdf9e966aad6697c29202db9417.swf\",\"kongregate_ansible_path\":\"chat.kongregate.com/flash/ansible_6ab3bca73452cf4e6c03ae9437093bb3.swf\",\"kongregate_preview\":\"true\",\"kongregate\":\"true\",\"PHPSESSID\":\"cc8ebe2be6284dd989a151603bb8a444\",\"app_id\":\"90208\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 6)
         {
            return JSON.decode("{\"signed_request\":\"z8mekQ_M0b7j1BoAOy-05YAlAdsNpx8EvEH_FiVs1VU.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzMwNTg0MDAsImlzc3VlZF9hdCI6MTMzMzA1MzcxNSwib2F1dGhfdG9rZW4iOiJBQUFBQVQ4bVNEcmdCQUJnRVpBSHFXRmVHN3BZU1pCd0JaQnNPWkM1a2lkZlpDdHd2bUlaQ0RaQk16ekhldGZiR0lHeEpmSDFoa0lTY0Y4dzhXQnNlQXM4YUZ5ekhNVGtaQ2NOa2w2WkNlczVqajRldjY0ZWwxUXZtRyIsInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiMTAwMDAzNjQ3NzczNTk0In0\",\"access_token\":\"AAAAAT8mSDrgBABgEZAHqWFeG7pYSZBwBZBsOZC5kidfZCtwvmIZCDZBMzzHetfbGIGxJfH1hkIScF8w8WBseAs8aFyzHMTkZCcNkl6ZCes5jj4ev64el1QvmG\",\"PHPSESSID\":\"f2a72011701839b45cc0ea822b17d459\",\"app_id\":\"342684208824\",\"tpid\":\"JjNCVhj-1aR7DKHCS6c5KkGnxC8\"}");
         }
         if(GLOBAL._localMode == 10)
         {
            return JSON.decode("{\"fb_kongregate_username\":\"mclasgens\",\"fb_kongregate_user_id\":\"7471517\",\"fb_kongregate_game_auth_token\":\"60fdc64b8e60747e4bd9f8a495a553875d901ad5cbfd6efcfc81f576645f85f2\",\"fb_kongregate_game_id\":\"90208\",\"fb_kongregate_host\":\"http://www.kongregate.com\",\"fb_kongregate_game_url\":\"http://www.kongregate.com/games/CasualCollective/bm-kong\",\"fb_kongregate_api_host\":\"http://api.kongregate.com\",\"fb_kongregate_channel_id\":\"1333141776835\",\"fb_kongregate_api_path\":\"http://chat.kongregate.com/flash/API_AS3_875a4cce8af804b49b3e68ab72c2d8ab.swf\",\"fb_kongregate_ansible_path\":\"chat.kongregate.com/flash/ansible_9f4034cf409c752878ce29f99984b38c.swf\",\"fb_kongregate_preview\":\"true\",\"fb_kongregate\":\"true\",\"apiurl\":\"http://bm-kg-web2.dev.casualcollective.com/api/\",\"baseurl\":\"http://bm-kg-web2.dev.casualcollective.com/api/bm/base/\",\"logurl\":null,\"cdnurl\":\"http://bm-kg-cdn.casualcollective.com/bmkg/\",\"gameurl\":\"http://bm-kg-cdn.casualcollective.com/bmkg/gamedev/\",\"statsurl\":\"http://bm-kg-web2.dev.casualcollective.com/recordstats.php\",\"currency\":\"Coins\",\"ccode\":\"us\",\"allianceurl\":\"http://bm-kg-web2.dev.casualcollective.com/alliance/\",\"languageversion\":\"764\",\"userid\":24679,\"jstimeout\":3,\"mapurl\":\"http://bm-kg-web2.dev.casualcollective.com/worldmapv2/\",\"infbaseurl\":\"http://bm-kg-web2.dev.casualcollective.com/api/bm/base/\"}");
         }
         if(GLOBAL._localMode == 11)
         {
            return JSON.decode("{\"fb_kongregate_username\":\"mclasgens\",\"fb_kongregate_user_id\":\"7471517\",\"fb_kongregate_game_auth_token\":\"8559b358e80e00906c65f335c4d6762ff77d1b843402925ed1a03d8655f01062\",\"fb_kongregate_game_id\":\"141461\",\"fb_kongregate_host\":\"http://www.kongregate.com\",\"fb_kongregate_game_url:http://www.kongregate.com/games/KIXEYE/bym-kong-stage\",\"fb_kongregate_api_host\":\"http://api.kongregate.com\",\"fb_kongregate_channel_id\":\"1334194854718\",\"fb_kongregate_api_path\":\"http://chat.kongregate.com/flash/API_AS3_66228fdf9e966aad6697c29202db9417.swf\",\"fb_kongregate_ansible_path\":\"chat.kongregate.com/flash/ansible_6ab3bca73452cf4e6c03ae9437093bb3.swf\",\"fb_kongregate_preview\":\"true\",\"fb_kongregate\":\"true\",\"PHPSESSID\":\"cc8ebe2be6284dd989a151603bb8a444\",\"app_id\":\"141461\",\"tpid\":false}");
         }
         return JSON.decode("{\"signed_request\":\"FoBfYvPGfrcZ6MJfNfzh2aB-4w_TIL42Umo-opZoaMw.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzMwNTQ4MDAsImlzc3VlZF9hdCI6MTMzMzA0ODc0Nywib2F1dGhfdG9rZW4iOiJBQUFBQWMyOWZUTllCQUVYYUdJWVBKNDZvWDVlaERaQ1NwR3Y3QVF3akduQmJ4WkJkM3FlVVNIeW9BT0ZaQ3VGQ3BoODR2WkN3VWhhQmFrc1F1eWVkNHRUeFpDNkdxdFFhS3ZiT1hNRUpiRkYwWkNqdFRtWEhwNCIsInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiMTAwMDAzNjQ3NzczNTk0In0\",\"access_token\":\"AAAAAc29fTNYBAEXaGIYPJ46oX5ehDZCSpGv7AQwjGnBbxZBd3qeUSHyoAOFZCuFCph84vZCwUhaBaksQuyed4tTxZC6GqtQaKvbOXMEJbFF0ZCjtTmXHp4\",\"PHPSESSID\":\"9cf8a55b83afa8479c4dd29a35da21b9\",\"app_id\":\"495789755606\",\"tpid\":\"WvDlUy1278F2nENtRLQpf3ML2BU\"}");
      }
      
      private function GetFBDataKevin() : Object
      {
         if(GLOBAL._localMode == 2)
         {
            return JSON.decode("{\"fb_kongregate_username\":\"AjaniG\",\"fb_kongregate_user_id\":\"7777613\",\"fb_kongregate_game_auth_token\":\"4ff238b68df32d4fa0966f1c9e3464a2e5deddd4e4c6be1e2c25643e31275a2e\",\"fb_kongregate_game_id\":\"113843\",\"fb_kongregate_host\":\"http://www.kongregate.com\",\"fb_kongregate_game_url\":\"http://www.kongregate.com/games/KIXEYE/backyard-monsters\",\"fb_kongregate_api_host\":\"http://api.kongregate.com\",\"fb_kongregate_channel_id\":\"1336166621895\",\"fb_kongregate_api_path\":\"http://chat.kongregate.com/flash/API_AS3_66228fdf9e966aad6697c29202db9417.swf\",\"fb_kongregate_ansible_path\":\"chat.kongregate.com/flash/ansible_6ab3bca73452cf4e6c03ae9437093bb3.swf\",\"fb_kongregate_preview\":\"false\",\"fb_kongregate\":\"true\",\"PHPSESSID\":\"a7134944c2c5e0172ca3cb8315dc2703\",\"app_id\":\"113843\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 3)
         {
            return JSON.decode("{\"v_publisher\":\"vixtest-casualcollective\",\"v_country\":\"US\",\"v_app_id\":\"backyardmonsters\",\"v_username\":\"Will McBride\",\"v_currency_singular\":\"Credit\",\"v_currency_plural\":\"Credits\",\"v_locale\":\"en-US\",\"v_user\":\"392-will-mcbride\",\"v_session_key\":\"93c8f1d06740816fcc417233a5d65264-1319060434\",\"v_expires\":\"1319060434\",\"PHPSESSID\":\"b352748332add54f4a34f59874d354bf\",\"app_id\":123,\"tpid\":false}");
         }
         if(GLOBAL._localMode == 4)
         {
            return JSON.decode("{\"v_publisher\":\"google\",\"v_country\":\"\",\"v_app_id\":\"backyardmonsters\",\"v_username\":\"kevin deng\",\"v_currency_singular\":\"Credit\",\"v_currency_plural\":\"Credits\",\"v_locale\":\"en-US\",\"v_user\":\"116733954990138407696\",\"v_session_key\":\"6c213c3140a3b4f968deaf81eb2badce-1320259440\",\"v_expires\":\"1320259440\",\"PHPSESSID\":\"fb2bd52b290933a6a6cdbb13977b343e\",\"app_id\":123,\"tpid\":false}");
         }
         if(GLOBAL._localMode == 1)
         {
            return JSON.decode("{\"signed_request\":\"5xJGebLaYc_b5bSi5tQkSrkQOnFFj-mdUqjAazrGW4I.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjE1NjM2MDAsImlzc3VlZF9hdCI6MTMyMTU1NzI5OCwib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQUxMaVJoOVNLWHNySjdFZm5tWkFJVFdwRk1DbkRlSzBWV3Znejd5Z2F5WkNvOGJaQnVYRkFnN2ZqUHFNcHFaQmxNc3RmWVhnMDRoVXlWb2hHUXUyMGxydEtEbHZ2QTJCNGhMWGNENFIiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAADLTlQ61wcBALLiRh9SKXsrJ7EfnmZAITWpFMCnDeK0VWvgz7ygayZCo8bZBuXFAg7fjPqMpqZBlMstfYXg04hUyVohGQu20lrtKDlvvA2B4hLXcD4R\",\"PHPSESSID\":\"b4f213e2f772c17b72f28730291f91d8\",\"app_id\":\"223537281029895\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 5)
         {
            return JSON.decode("{\"signed_request\":\"rz5q6vAkfz7qbL3l78SWaZEF6gmlUZDR-mnQOfW1dHU.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjI3MTIwMDAsImlzc3VlZF9hdCI6MTMyMjcwNjUwMiwib2F1dGhfdG9rZW4iOiJBQUFCd3ZldWh6M01CQUIyejhEN01EbGt1WkJUTldtaVFUa3dkTGtpMjczYmo4aXgyWkM2WkJJNlF4S2dxT2RaQ0RZMGZIOEd5aGhjaE5EdHIwd0JwcnMwNW9jaFh0YWFhRFF2ZE94YldTVUxvUXJPQjNrdlgiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAABwveuhz3MBAB2z8D7MDlkuZBTNWmiQTkwdLki273bj8ix2ZC6ZBI6QxKgqOdZCDY0fH8GyhhchNDtr0wBprs05ochXtaaaDQvdOxbWSULoQrOB3kvX\",\"PHPSESSID\":\"7a8ee868877b9307330e0a6fd7dc3529\",\"app_id\":\"123961004380019\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 6)
         {
            return JSON.decode("{\"signed_request\":\"dnQczN5qAOE3bBrwvC-XC9wucwpv8aQk_fPtV2Oaisw.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzI4MDY0MDAsImlzc3VlZF9hdCI6MTMzMjgwMTM5Nywib2F1dGhfdG9rZW4iOiJBQUFBQVQ4bVNEcmdCQU9aQ0RkUkpDMGhqZFpDMUp1UWF2MWMyTEw4dWNjc2pHbWlnRERueXdhdDBIVDV6bkNpY1pCMVhWODdJZGNnVTVocVpBVk1pcmpuTjRQbDlFT2hpYmdCUGU0dVdqZ1pEWkQiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjIwOTQwMyJ9\",\"access_token\":\"AAAAAT8mSDrgBAOZCDdRJC0hjdZC1JuQav1c2LL8uccsjGmigDDnywat0HT5znCicZB1XV87IdcgU5hqZAVMirjnN4Pl9EOhibgBPe4uWjgZDZD\",\"PHPSESSID\":\"70e6b3cc3cc5d5d58698374cf5cdcbca\",\"app_id\":\"342684208824\",\"tpid\":\"nXASv7QQGTzSFnJqvU_TwzNb0SY\"}");
         }
         if(GLOBAL._localMode == 8)
         {
            return JSON.decode("{\"signed_request\":\"ShxDHmcoeXD1-8Trm3w-rUPiiWWhyl4d4CQkNEVF6wo.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjQwMTE2MDAsImlzc3VlZF9hdCI6MTMyNDAwNTM5Nywib2F1dGhfdG9rZW4iOiJBQUFETXhMNXpXdlVCQU9oeTVtY3dDZDJXVFpDM0JjMVpCbWxuZmZaQ3BIbVdLRFM4NHYzUGhLTUJUajdmTzZMb3NuSm4xQzh0MzhaQkpkU2JaQlRnNUxtM3dDSlRNQU5wTnNBNWZxTGFaQlpDaHB6azgyNUtUUDMiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAADMxL5zWvUBAOhy5mcwCd2WTZC3Bc1ZBmlnffZCpHmWKDS84v3PhKMBTj7fO6LosnJn1C8t38ZBJdSbZBTg5Lm3wCJTMANpNsA5fqLaZBZChpzk825KTP3\",\"PHPSESSID\":\"fc9e48d0b35a872db57d787e4127f780\",\"app_id\":\"225145380887285\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 9)
         {
            return JSON.decode("{\"signed_request\":\"AxnEnbAL7nbHkxEGv46S1IHY8U3lc9nTa1p87lCkJ4M.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjQ0MjIwMDAsImlzc3VlZF9hdCI6MTMyNDQxNzk3OCwib2F1dGhfdG9rZW4iOiJBQUFCNDJGZUhaQlpCUUJBQ2dMcUg4YXJubWh4VzVDVlpBM1lkVVh5YU1QbzNMYnhnWkFaQ0NJRFUzVzUyRTVQMmhMbmI0M3BlV3pDdGI5bURkZGsxdk9HaGh4dW1FZVlNbmlVZWVYejVFb3ZYa2EwNnQ4QVpBdCIsInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiMTAwMDAyMjY5OTEzNDYzIn0\",\"access_token\":\"AAAB42FeHZBZBQBACgLqH8arnmhxW5CVZA3YdUXyaMPo3LbxgZAZCCIDU3W52E5P2hLnb43peWzCtb9mDddk1vOGhhxumEeYMniUeeXz5EovXka06t8AZAt\",\"PHPSESSID\":\"f6e0763b85c9f387a1916943d03e6325\",\"app_id\":\"132870576798692\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 10)
         {
            return JSON.decode("{\"fb_kongregate_username\":\"shi503\",\"fb_kongregate_user_id\":\"2230387\",\"fb_kongregate_game_auth_token\":\"3b883ce6e1e54c5e83509af0a7e51cfbf9406b363224c5caa6a77ad245dae24e\",\"fb_kongregate_game_id\":\"90208\",\"fb_kongregate_host\":\"http://www.kongregate.com\",\"fb_kongregate_game_url\":\"http://www.kongregate.com/games/CasualCollective/bm-kong\",\"fb_kongregate_api_host\":\"http://api.kongregate.com\",\"fb_kongregate_channel_id\":\"1333137505542\",\"fb_kongregate_api_path\":\"http://chat.kongregate.com/flash/API_AS3_875a4cce8af804b49b3e68ab72c2d8ab.swf\",\"fb_kongregate_ansible_path\":\"chat.kongregate.com/flash/ansible_9f4034cf409c752878ce29f99984b38c.swf\",\"fb_kongregate_preview\":\"true\",\"fb_kongregate\":\"true\",\"apiurl\":\"http://bm-kg-web2.dev.casualcollective.com/api/\",\"baseurl\":\"http://bm-kg-web2.dev.casualcollective.com/api/bm/base/\",\"logurl\":null,\"cdnurl\":\"http://bm-kg-cdn.casualcollective.com/bmkg/\",\"gameurl\":\"http://bm-kg-cdn.casualcollective.com/bmkg/gamedev/\",\"statsurl\":\"http://bm-kg-web2.dev.casualcollective.com/recordstats.php\",\"currency\":\"Coins\",\"ccode\":\"us\",\"allianceurl\":\"http://bm-kg-web2.dev.casualcollective.com/alliance/\",\"languageversion\":\"764\",\"userid\":24681,\"jstimeout\":3,\"mapurl\":\"http://bm-kg-web2.dev.casualcollective.com/worldmapv2/\",\"infbaseurl\":\"http://bm-kg-web2.dev.casualcollective.com/api/bm/base/\"}");
         }
         if(GLOBAL._localMode == 11)
         {
            return JSON.decode("{\"fb_kongregate_username\":\"maclogos\",\"fb_kongregate_user_id\":\"7471234\",\"fb_kongregate_game_auth_token\":\"44fffdc9538ca0e8d34bfd45d672d7036ab6c00cf5d16432cdef24ce1da7541a\",\"fb_kongregate_game_id\":\"141461\",\"fb_kongregate_host\":\"http://www.kongregate.com\",\"fb_kongregate_game_url\":\"http://www.kongregate.com/games/KIXEYE/bym-kong-stage\",\"fb_kongregate_api_host\":\"http://api.kongregate.com\",\"fb_kongregate_channel_id\":\"1334192857863\",\"fb_kongregate_api_path\":\"http://chat.kongregate.com/flash/API_AS3_66228fdf9e966aad6697c29202db9417.swf\",\"fb_kongregate_ansible_path\":\"chat.kongregate.com/flash/ansible_6ab3bca73452cf4e6c03ae9437093bb3.swf\",\"fb_kongregate_preview\":\"true\",\"fb_kongregate\":\"true\",\"PHPSESSID\":\"d655d939bcdb8e592f0c49cb0a1cd37b\",\"fb_app_id\":\"141461\",\"tpid\":false}");
         }
         return JSON.decode("{\"signed_request\":\"XMcUmtokOBufSfOxSatYxwS2NBZsFKnJbrKhW_ikGtM.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjI3OTEyMDAsImlzc3VlZF9hdCI6MTMyMjc4NTE1Nywib2F1dGhfdG9rZW4iOiJBQUFBQWMyOWZUTllCQUFOaGtRYlpBZWlLZ1VhOUYyaHZ0YUMwYjRCSjZVbmxPc1RoTlJnV2VlY0FtaVN6UmhHdll0Vm5XcnI2a01FaHV2ZE9laWNMRkJ4cE9pVEgyTTg1REdYZEx3TklpWW1VcUFEWU8iLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAAAAc29fTNYBAANhkQbZAeiKgUa9F2hvtaC0b4BJ6UnlOsThNRgWeecAmiSzRhGvYtVnWrr6kMEhuvdOeicLFBxpOiTH2M85DGXdLwNIiYmUqADYO\",\"PHPSESSID\":\"0a3287793c5da304c64d0f43cd38d6c1\",\"app_id\":\"495789755606\",\"tpid\":false}");
      }
      
      private function GetFBDataNickH() : Object
      {
         return JSON.decode("{\"signed_request\":\"vpG74p6wnNKI5u-1gItMbhdRrcsqjTPyx5A-l1ve2FM.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjU4OTQ0MDAsImlzc3VlZF9hdCI6MTMyNTg4ODA5Mywib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQU44aFpDWVpBTTJRbzFzSmdvdEhzMEdtWTljT3gxeXZkUUc0ZlpCVXJEWkFMbkRkMUhRa3pvNzJqVVpBWkNNYkN0aExxdlY4RDd0dWVNRWtZTlVQRXg2c0tHWkJURFJIZ1pEWkQiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEzNzA0OTQwIn0\",\"access_token\":\"AAADLTlQ61wcBAN8hZCYZAM2Qo1sJgotHs0GmY9cOx1yvdQG4fZBUrDZALnDd1HQkzo72jUZAZCMbCthLqvV8D7tueMEkYNUPEx6sKGZBTDRHgZDZD\",\"PHPSESSID\":\"592d15e3fdbdd93d0839a0b38cb1fc01\",\"app_id\":\"223537281029895\",\"tpid\":false}");
      }
      
      private function GetFBDataNickM() : Object
      {
         return JSON.decode("{\"signed_request\":\"MfQSMtw-rB7PQwdzp9FgADrmd2p_TQ1AEK4-JdOIwak.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjM4MzE2MDAsImlzc3VlZF9hdCI6MTMyMzgyNTY4Niwib2F1dGhfdG9rZW4iOiJBQUFCNDJGZUhaQlpCUUJBTDFBZmVkUWxXb3IwYjhEN1BydkFSaTg4SUZVVHpxc3lWVlhsRnlDYTJaQlpBSVBtMDlaQmhDZE9LNkY3cWR0b3hEUUR6Z3VqMVpDTGdPY1pDcGJRSmhaQ1dVVWlKbFc2a09xdTdsOU1pIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMDAwMDI2MjUyMzc4MjkifQ\",\"access_token\":\"AAAB42FeHZBZBQBAL1AfedQlWor0b8D7PrvARi88IFUTzqsyVVXlFyCa2ZBZAIPm09ZBhCdOK6F7qdtoxDQDzguj1ZCLgOcZCpbQJhZCWUUiJlW6kOqu7l9Mi\",\"PHPSESSID\":\"27166a10b822945c3d7337859320adea\",\"app_id\":\"132870576798692\",\"tpid\":false}");
      }
      
      private function GetFBDataOrlando() : Object
      {
         if(GLOBAL._localMode == 3)
         {
            return JSON.decode("{\"v_publisher\":\"vixtest-casualcollective\",\"v_country\":\"US\",\"v_app_id\":\"backyardmonsters\",\"v_username\":\"Will McBride\",\"v_currency_singular\":\"Credit\",\"v_currency_plural\":\"Credits\",\"v_locale\":\"en-US\",\"v_user\":\"392-will-mcbride\",\"v_session_key\":\"93c8f1d06740816fcc417233a5d65264-1319060434\",\"v_expires\":\"1319060434\",\"PHPSESSID\":\"b352748332add54f4a34f59874d354bf\",\"app_id\":123,\"tpid\":false}");
         }
         if(GLOBAL._localMode == 4)
         {
            return JSON.decode("{\"v_publisher\":\"google\",\"v_country\":\"\",\"v_app_id\":\"backyardmonsters\",\"v_username\":\"kevin deng\",\"v_currency_singular\":\"Credit\",\"v_currency_plural\":\"Credits\",\"v_locale\":\"en-US\",\"v_user\":\"116733954990138407696\",\"v_session_key\":\"6c213c3140a3b4f968deaf81eb2badce-1320259440\",\"v_expires\":\"1320259440\",\"PHPSESSID\":\"fb2bd52b290933a6a6cdbb13977b343e\",\"app_id\":123,\"tpid\":false}");
         }
         if(GLOBAL._localMode == 1)
         {
            return JSON.decode("{\"signed_request\":\"rbcN8xePve5Q7oRPxNpX2_Fni8sKLi1zLVcPZqYZZRs.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzIyODQ0MDAsImlzc3VlZF9hdCI6MTMzMjI3OTAyNSwib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQVBia1pDQ1Z4WkEyT1pCOWpNZUhrSlQ1Y1pCWURMNElDamFLQW40dnhZQlpCYWo2YTNTd1ByRjNNaDZoSEJyUzNtMnFYRHhyN2FlTjNHYUtlRGQ3RmdXWWIwcTRIWFFaRFpEIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiI1ODc3MjUwMzcifQ\",\"access_token\":\"AAADLTlQ61wcBAPbkZCCVxZA2OZB9jMeHkJT5cZBYDL4ICjaKAn4vxYBZBaj6a3SwPrF3Mh6hHBrS3m2qXDxr7aeN3GaKeDd7FgWYb0q4HXQZDZD\",\"PHPSESSID\":\"2d9fbc27e77c8007b6b2a284d7d76ef4\",\"app_id\":\"223537281029895\",\"tpid\":\"KgLqZF6AiVZKTJXldiUjQZO5Zkw\"}");
         }
         if(GLOBAL._localMode == 5)
         {
            return JSON.decode("{\"signed_request\":\"rz5q6vAkfz7qbL3l78SWaZEF6gmlUZDR-mnQOfW1dHU.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjI3MTIwMDAsImlzc3VlZF9hdCI6MTMyMjcwNjUwMiwib2F1dGhfdG9rZW4iOiJBQUFCd3ZldWh6M01CQUIyejhEN01EbGt1WkJUTldtaVFUa3dkTGtpMjczYmo4aXgyWkM2WkJJNlF4S2dxT2RaQ0RZMGZIOEd5aGhjaE5EdHIwd0JwcnMwNW9jaFh0YWFhRFF2ZE94YldTVUxvUXJPQjNrdlgiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAABwveuhz3MBAB2z8D7MDlkuZBTNWmiQTkwdLki273bj8ix2ZC6ZBI6QxKgqOdZCDY0fH8GyhhchNDtr0wBprs05ochXtaaaDQvdOxbWSULoQrOB3kvX\",\"PHPSESSID\":\"7a8ee868877b9307330e0a6fd7dc3529\",\"app_id\":\"123961004380019\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 6)
         {
            return JSON.decode("{\"signed_request\":\"g1JGQmmLkjYsKZM3AGi90HQ9_F8Ef-Pur6ZOVqdnPqU.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzM3NjQwMDAsImlzc3VlZF9hdCI6MTMzMzc1ODQyMSwib2F1dGhfdG9rZW4iOiJBQUFBQVQ4bVNEcmdCQVBURlRYTUJyRjFuWkF3YlNDUXFlRldOM0w1ZTllQ3VRSHV5b3BUb2ExYXA4bTBMY2tFa3ZrSUJuQWhmZ0YybTNISThVWkNWY2NxRUQyaDYyaXN0cU1tZXJpdEFaRFpEIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiI2NzU5MjUwNjMifQ\",\"access_token\":\"AAAAAT8mSDrgBAPTFTXMBrF1nZAwbSCQqeFWN3L5e9eCuQHuyopToa1ap8m0LckEkvkIBnAhfgF2m3HI8UZCVccqED2h62istqMmeritAZDZD\",\"PHPSESSID\":\"1cd3ebc8b44c10867f0b0916080ec5f5\",\"app_id\":\"342684208824\",\"tpid\":\"fBRI9eSHDALw0tiE1Kb81NMer60\"}");
         }
         if(GLOBAL._localMode == 8)
         {
            return JSON.decode("{\"signed_request\":\"ShxDHmcoeXD1-8Trm3w-rUPiiWWhyl4d4CQkNEVF6wo.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjQwMTE2MDAsImlzc3VlZF9hdCI6MTMyNDAwNTM5Nywib2F1dGhfdG9rZW4iOiJBQUFETXhMNXpXdlVCQU9oeTVtY3dDZDJXVFpDM0JjMVpCbWxuZmZaQ3BIbVdLRFM4NHYzUGhLTUJUajdmTzZMb3NuSm4xQzh0MzhaQkpkU2JaQlRnNUxtM3dDSlRNQU5wTnNBNWZxTGFaQlpDaHB6azgyNUtUUDMiLCJ1c2VyIjp7ImNvdW50cnkiOiJ1cyIsImxvY2FsZSI6ImVuX1VTIiwiYWdlIjp7Im1pbiI6MjF9fSwidXNlcl9pZCI6IjEwMDAwMjI2OTkxMzQ2MyJ9\",\"access_token\":\"AAADMxL5zWvUBAOhy5mcwCd2WTZC3Bc1ZBmlnffZCpHmWKDS84v3PhKMBTj7fO6LosnJn1C8t38ZBJdSbZBTg5Lm3wCJTMANpNsA5fqLaZBZChpzk825KTP3\",\"PHPSESSID\":\"fc9e48d0b35a872db57d787e4127f780\",\"app_id\":\"225145380887285\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 9)
         {
            return JSON.decode("{\"signed_request\":\"AxnEnbAL7nbHkxEGv46S1IHY8U3lc9nTa1p87lCkJ4M.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjQ0MjIwMDAsImlzc3VlZF9hdCI6MTMyNDQxNzk3OCwib2F1dGhfdG9rZW4iOiJBQUFCNDJGZUhaQlpCUUJBQ2dMcUg4YXJubWh4VzVDVlpBM1lkVVh5YU1QbzNMYnhnWkFaQ0NJRFUzVzUyRTVQMmhMbmI0M3BlV3pDdGI5bURkZGsxdk9HaGh4dW1FZVlNbmlVZWVYejVFb3ZYa2EwNnQ4QVpBdCIsInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiMTAwMDAyMjY5OTEzNDYzIn0\",\"access_token\":\"AAAB42FeHZBZBQBACgLqH8arnmhxW5CVZA3YdUXyaMPo3LbxgZAZCCIDU3W52E5P2hLnb43peWzCtb9mDddk1vOGhhxumEeYMniUeeXz5EovXka06t8AZAt\",\"PHPSESSID\":\"f6e0763b85c9f387a1916943d03e6325\",\"app_id\":\"132870576798692\",\"tpid\":false}");
         }
         if(GLOBAL._localMode == 10)
         {
            return JSON.decode("{\"kongregate_username\":\"shi503\",\"kongregate_user_id\":\"2230387\",\"kongregate_game_auth_token\":\"3b883ce6e1e54c5e83509af0a7e51cfbf9406b363224c5caa6a77ad245dae24e\",\"kongregate_game_id\":\"90208\",\"kongregate\":\"true\",\"PHPSESSID\":\"7769de1299a3aa4aa5aa13410dbf09c9\",\"app_id\":\"90208\",\"tpid\":false}");
         }
         return JSON.decode("{\"signed_request\":\"CurxQdNplHHmhhf52Ud_czXHcJ7BXYkwmwY3P40HHBM.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzIyODQ0MDAsImlzc3VlZF9hdCI6MTMzMjI3OTA1MSwib2F1dGhfdG9rZW4iOiJBQUFBQWMyOWZUTllCQU80SE9MMFZBY2VUUnA5YjRqZGJEUlNtU1pCNW5idTc5UzlVY0RjbVJHelpBQlpCSU82U0hEMG1oN2p1WkFoWU5jdmdrMEhGOFpDdThBTG1FQW1GMGhmWkI1eG8zWHZRWkRaRCIsInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiNTg3NzI1MDM3In0\",\"access_token\":\"AAAAAc29fTNYBAO4HOL0VAceTRp9b4jdbDRSmSZB5nbu79S9UcDcmRGzZABZBIO6SHD0mh7juZAhYNcvgk0HF8ZCu8ALmEAmF0hfZB5xo3XvQZDZD\",\"PHPSESSID\":\"29d3dcba5c4fac85727f72583576a99d\",\"app_id\":\"495789755606\",\"tpid\":\"ppxv5EGjs00Q2byqWm45B1Bvpng\"}");
      }
      
      private function GetFBDataRyan() : Object
      {
         if(GLOBAL._localMode == 1)
         {
            return JSON.decode("{\"signed_request\":\"hQCOq_kDNSooHGR1G6NSmHAYIY89Qk-hrk_OXKXUcxs.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzYwMTQwMDAsImlzc3VlZF9hdCI6MTMzNjAwODM5MCwib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQUd5TE1HTERwdVhKNkhIbG5xV1pCS1lWUTJ5dEFsWkJ0bHZyWkJXNmhLZXhUSUd3aUphSkY3OE5mZmFaQmpFMzZ5REsxMU9nZm1oNFdrOVZtanBwdUQwM1VuWVpDYWJobWQ4dEdTUEVVIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMDI4ODU4NTY4In0\",\"access_token\":\"AAADLTlQ61wcBAGyLMGLDpuXJ6HHlnqWZBKYVQ2ytAlZBtlvrZBW6hKexTIGwiJaJF78NffaZBjE36yDK11Ogfmh4Wk9VmjppuD03UnYZCabhmd8tGSPEU\",\"PHPSESSID\":\"324a8f4d54dc11db81dc950d6aa05ced\",\"app_id\":\"223537281029895\",\"tpid\":\"9glzT5nqYXLdFtais4RfQ7cNV1k\"}");
         }
         return JSON.decode("{\"signed_request\":\"6yfYU6wuqFulS6FW694BuArS32UwOGkWKuLhYGOy5_U.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjQ1MjY0MDAsImlzc3VlZF9hdCI6MTMyNDUyMjM3Nywib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQUJYc0RWODVKTlhhWU9qYXFSdFpBbWYzVVpBdmlheWplYkJwVlRITzlJMnhUeU0zNU9tQ0V4cGVkNkliM0FSc2FaQ2lISjBMajFZeGtTV0R2aVhSTjVVa01NdzB0OUlYYW5aQllaQVU1IiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMDI4ODU4NTY4In0\",\"access_token\":\"AAADLTlQ61wcBABXsDV85JNXaYOjaqRtZAmf3UZAviayjebBpVTHO9I2xTyM35OmCExped6Ib3ARsaZCiHJ0Lj1YxkSWDviXRN5UkMMw0t9IXanZBYZAU5\",\"PHPSESSID\":\"8a8435a597d612b038a36a80ca71d36a\",\"app_id\":\"223537281029895\",\"tpid\":false}");
      }
      
      private function GetFBDataKaty() : Object
      {
         return JSON.decode("{\"signed_request\":\"uGMkDTV4OpcF_RmrfpQFnaxefFNlGz17aOov7obye38.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzEyNDQwMDAsImlzc3VlZF9hdCI6MTMzMTI0MDI4Mywib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQUFzaUhocWF0YnV2WENEcWdmNFk1TXdoZmJjS25aQm1wQnJ1RFRUWkF6VHhMNXJDWkJmYnF3cjVWekZYcHkwdXk1Qm9NU1pBTTBKYVIzV1pDZEJBanJINjVOWUl6NmxYVzNoMmphR0tBIiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMDAwMDI1Mzg1NDEzMjQifQ\",\"access_token\":\"AAADLTlQ61wcBAAsiHhqatbuvXCDqgf4Y5MwhfbcKnZBmpBruDTTZAzTxL5rCZBfbqwr5VzFXpy0uy5BoMSZAM0JaR3WZCdBAjrH65NYIz6lXW3h2jaGKA\",\"PHPSESSID\":\"4de1d002a77cf8175dd084d7e4d85746\",\"app_id\":\"223537281029895\",\"tpid\":\"fZbg12hq5Uqk2iVunoTrLcfno94\"}");
      }
      
      private function GetFBDataSam() : Object
      {
         if(GLOBAL._localMode == 1)
         {
            return JSON.decode("{\"signed_request\":\"g9fvHDs_Cg07S_nNhrzhrPFtNhn62uLPfOaNrJMlkhw.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzI5NjEyMDAsImlzc3VlZF9hdCI6MTMzMjk1NzE4Nywib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQUxMWWFaQ0lNQXdOcUZyUVU1YkpaQ25qZVRaQndnVW5NNUpiczRMOTRsdWxlR0hoZWo5QzhWYTN1UElnbEJrVHNlejN2OVFJRTZkWkJjbEdPWkE4am5aQk5lUHJrYlhVS2ZqT3JJNjJMcSIsInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19LCJ1c2VyX2lkIjoiMTAwMDAxNjExMjUxNzUwIn0\",\"access_token\":\"AAADLTlQ61wcBALLYaZCIMAwNqFrQU5bJZCnjeTZBwgUnM5Jbs4L94luleGHhej9C8Va3uPIglBkTsez3v9QIE6dZBclGOZA8jnZBNePrkbXUKfjOrI62Lq\",\"PHPSESSID\":\"0dde8307f7713cf1ce88ec8964c9f834\",\"app_id\":\"223537281029895\",\"tpid\":\"WUyHdUMuScZHGttEUpO3SCvI444\"}");
         }
         return JSON.decode("{\"signed_request\":\"6yfYU6wuqFulS6FW694BuArS32UwOGkWKuLhYGOy5_U.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMjQ1MjY0MDAsImlzc3VlZF9hdCI6MTMyNDUyMjM3Nywib2F1dGhfdG9rZW4iOiJBQUFETFRsUTYxd2NCQUJYc0RWODVKTlhhWU9qYXFSdFpBbWYzVVpBdmlheWplYkJwVlRITzlJMnhUeU0zNU9tQ0V4cGVkNkliM0FSc2FaQ2lISjBMajFZeGtTV0R2aVhSTjVVa01NdzB0OUlYYW5aQllaQVU1IiwidXNlciI6eyJjb3VudHJ5IjoidXMiLCJsb2NhbGUiOiJlbl9VUyIsImFnZSI6eyJtaW4iOjIxfX0sInVzZXJfaWQiOiIxMDI4ODU4NTY4In0\",\"access_token\":\"AAADLTlQ61wcBABXsDV85JNXaYOjaqRtZAmf3UZAviayjebBpVTHO9I2xTyM35OmCExped6Ib3ARsaZCiHJ0Lj1YxkSWDviXRN5UkMMw0t9IXanZBYZAU5\",\"PHPSESSID\":\"8a8435a597d612b038a36a80ca71d36a\",\"app_id\":\"223537281029895\",\"tpid\":false}");
      }
      
      private function getHash(param1:String, param2:int) : *
      {
         return md5(this.getSalt() + param1 + this.getNum(param2));
      }
      
      private function getSalt() : *
      {
         return this.decodeSalt("1V87Z84V19XV71U86583YX799Y8X5X89339UZ155");
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
                  _loc2_ += "3";
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
         switch(this._status)
         {
            case 404:
               LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Not Found");
               break;
            case 401:
               LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Unauthorized");
               break;
            case 403:
               LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Forbidden");
               break;
            case 405:
               LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Method Not Allowed");
               break;
            case 406:
               LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Not Acceptable");
               break;
            case 407:
               LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Proxy Authentication Required");
               break;
            case 408:
               LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Request Timeout");
               break;
            case 500:
               LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Internal Server Error");
               break;
            case 501:
               LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Not Implemented");
               break;
            case 502:
               LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Bad Gateway");
               break;
            case 503:
               LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Service Unavailable");
               break;
            default:
               if(this._status > 400)
               {
                  LOGGER.Log("err","URLLoaderApi HTTP status " + this._status + " Other status");
                  break;
               }
         }
      }
      
      private function loadError(param1:IOErrorEvent) : *
      {
         LOGGER.Log("err","URLLoader Load Error " + this._url);
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
            h = md5(this.getSalt() + string + this.getNum(jhdata.hn));
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
               if(jdata)
               {
                  this._onComplete(jdata);
               }
               else
               {
                  print("no jdata?!" + jdata,true);
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","URLLoaderApi.fireComplete catch URL: " + _baseUrl + " RET: " + _req.data + " MSG:" + e.message);
         }
      }
   }
}

