package package_1
{
   public class class_1
   {
      internal static const const_2:Array = new Array([541526137,-1156127247,324306429,-1153270997],[-708446419,-645466224,196409733,-1796016675]);
      
      internal static const const_1:Array = new Array([212604270,-817267900,923329700,-1530518500,-641824938,2132386958,-30365900,1661084580,1030308540,1129301073,-186249701,101929310,1402883666,-2109395597,-448266614,2038478822,-30365900,1661084580,1966061918,-1037352500,-286458043,993660374,-295550490,-641073606,726835869,1805041171,1841571226,-1554223841,-119906613,-790542368,2060687986,-1658096474,-931387946,2099880268],[1533039932,2108917118,-1258577572,-339850042,868812107,-1968663365,1249593183,-450536400,720987801,-1514484798,1657261392,929217940,110892661,-1568885526,2050348913,1291726226,465039431,-1674223201,175981943,-1671606188,-1100554118,-601686800,1827981332,-682420788,148633480,253643134,-1889064354,692195983]);
      
      public function class_1()
      {
         super();
      }
      
      public static function method_1(param1:int, param2:int) : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         _loc3_ = "";
         _loc4_ = 0;
         _loc5_ = int(const_1[param1 - 5 ^ -395].length);
         while(_loc4_ < _loc5_)
         {
            _loc6_ = int(const_1[param1 - 5 ^ -395][_loc4_]);
            _loc4_++;
            _loc7_ = int(const_1[param1 - 5 ^ -395][_loc4_]);
            _loc8_ = 2654435769;
            _loc9_ = 84941944608;
            while(_loc9_ != 0)
            {
               _loc7_ -= (_loc6_ << 4 ^ _loc6_ >>> 5) + _loc6_ ^ _loc9_ + int(const_2[param2 + 3 ^ -584][_loc9_ >>> 11 & 3]);
               _loc9_ -= _loc8_;
               _loc6_ -= (_loc7_ << 4 ^ _loc7_ >>> 5) + _loc7_ ^ _loc9_ + int(const_2[param2 + 3 ^ -584][_loc9_ & 3]);
            }
            _loc3_ += String.fromCharCode(_loc6_) + String.fromCharCode(_loc7_);
            _loc4_++;
         }
         if(_loc3_.charCodeAt(_loc3_.length - 1) == 0)
         {
            _loc3_ = _loc3_.substring(0,_loc3_.length - 1);
         }
         return _loc3_;
      }
   }
}

