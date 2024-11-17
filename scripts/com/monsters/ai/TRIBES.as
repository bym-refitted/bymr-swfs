package com.monsters.ai
{
   public class TRIBES
   {
      public static var _tribes:Object;
      
      private static var _assoc:Object;
      
      public static const L_IDS:Array = [1,2,3,4,5,6,7,8,9,10,41,42];
      
      public static const K_IDS:Array = [11,12,13,14,15,16,17,18,19,20,43,44];
      
      public static const A_IDS:Array = [21,22,23,24,25,26,27,28,29,30,45,46];
      
      public static const D_IDS:Array = [31,32,33,34,35,36,37,38,39,40,47,48];
      
      public function TRIBES()
      {
         super();
      }
      
      public static function Setup() : void
      {
         _tribes = {};
         _assoc = {
            "l":L_IDS,
            "k":K_IDS,
            "a":A_IDS,
            "d":D_IDS
         };
         _tribes.l = {
            "id":1,
            "name":KEYS.Get("ai_legion_name"),
            "process":PROCESS3,
            "type":WMATTACK.TYPE_TOWERS,
            "taunt":KEYS.Get("ai_legion_taunt"),
            "splash":"popups/tribe_legionnaire.v2.png",
            "description":KEYS.Get("ai_legion_description"),
            "succ":KEYS.Get("ai_legion_succ"),
            "succ_stream":KEYS.Get("ai_legion_succstream"),
            "fail":KEYS.Get("ai_legion_fail"),
            "profilepic":"monsters/tribe_legionnaire_50.v2.jpg",
            "streampostpic":"tribe-legionnaire.v2.png"
         };
         _tribes.k = {
            "id":2,
            "name":KEYS.Get("ai_kozu_name"),
            "process":PROCESS4,
            "type":WMATTACK.TYPE_SWARM,
            "taunt":KEYS.Get("ai_kozu_taunt"),
            "splash":"popups/tribe_kozu.v2.png",
            "description":KEYS.Get("ai_kozu_description"),
            "succ":KEYS.Get("ai_kozu_succ"),
            "succ_stream":KEYS.Get("ai_kozu_succstream"),
            "fail":KEYS.Get("ai_kozu_fail"),
            "profilepic":"monsters/tribe_kozu_50.v2.jpg",
            "streampostpic":"tribe-kozu.v2.png"
         };
         _tribes.a = {
            "id":3,
            "name":KEYS.Get("ai_abunakki_name"),
            "process":PROCESS5,
            "type":WMATTACK.TYPE_KAMIKAZE,
            "taunt":KEYS.Get("ai_abunakki_taunt"),
            "splash":"popups/tribe_abunakki.v2.png",
            "description":KEYS.Get("ai_abunakki_description"),
            "succ":KEYS.Get("ai_abunakki_succ"),
            "succ_stream":KEYS.Get("ai_abunakki_succstream"),
            "fail":KEYS.Get("ai_abunakki_fail"),
            "profilepic":"monsters/tribe_abunakki_50.v2.jpg",
            "streampostpic":"tribe-abunakki.v2.png",
            "behaviour":"juice"
         };
         _tribes.d = {
            "id":4,
            "name":KEYS.Get("ai_dread_name"),
            "process":PROCESS7,
            "type":WMATTACK.TYPE_NERD,
            "taunt":KEYS.Get("ai_dread_taunt"),
            "splash":"popups/tribe_dreadnaut.v2.png",
            "description":KEYS.Get("ai_dread_description"),
            "succ":KEYS.Get("ai_dread_succ"),
            "succ_stream":KEYS.Get("ai_dread_succstream"),
            "fail":KEYS.Get("ai_dread_fail"),
            "profilepic":"monsters/tribe_dreadnaut_50.v2.jpg",
            "streampostpic":"tribe-dreadnaut.v2.png"
         };
      }
      
      public static function TribeForName(param1:int) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in _tribes)
         {
            if(_loc2_.nid == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function TribeForID(param1:int) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in _tribes)
         {
            if(_loc2_.nid == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function TribeForBaseID(param1:int) : Object
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         for(_loc2_ in _assoc)
         {
            _loc3_ = 0;
            while(_loc3_ < _assoc[_loc2_].length)
            {
               if(param1 == _assoc[_loc2_][_loc3_])
               {
                  return _tribes[_loc2_];
               }
               _loc3_++;
            }
         }
         return null;
      }
   }
}

