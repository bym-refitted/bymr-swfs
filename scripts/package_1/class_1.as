package package_1
{
   public class class_1
   {
      internal static const const_2:Array = new Array([199217264,-905525604,2031984452,-1908485902],[1983190645,-686072446,-313218243,-1939623298]);
      
      internal static const const_1:Array = new Array([-1578839998,-1725973097,-2108796692,599317058,1721043016,-1586936389,1658816471,-1464154313,-309265677,-1054883743,1149517837,1402990781,2059123213,-544876720,1863721555,-1663149787,1658816471,-1464154313,-1316305478,732885884,-1125359777,690850759,-287239123,-978894541,604077887,1649144880,-2094614800,1776465642,-1789963325,-1810730499,-375002413,-1678822647,-1311722257,-239069400],[-365454277,941065841,1189708194,1683578231,-1358280019,1623013618,-27548909,-1171030630,1152886879,1071799728,1968945840,677389007,1794218972,-126634467,1729212487,1297951242,443008782,2127494542,-842730539,-1202943280,-205381761,1117193085,1532197788,-52271790,-1312444164,1345896759,-81202534,280251786]);
      
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
         _loc5_ = int(const_1[param1 - 5 ^ 443].length);
         while(_loc4_ < _loc5_)
         {
            _loc6_ = int(const_1[param1 - 5 ^ 443][_loc4_]);
            _loc4_++;
            _loc7_ = int(const_1[param1 - 5 ^ 443][_loc4_]);
            _loc8_ = 2654435769;
            _loc9_ = 84941944608;
            while(_loc9_ != 0)
            {
               _loc7_ -= (_loc6_ << 4 ^ _loc6_ >>> 5) + _loc6_ ^ _loc9_ + int(const_2[param2 + 3 ^ 21][_loc9_ >>> 11 & 3]);
               _loc9_ -= _loc8_;
               _loc6_ -= (_loc7_ << 4 ^ _loc7_ >>> 5) + _loc7_ ^ _loc9_ + int(const_2[param2 + 3 ^ 21][_loc9_ & 3]);
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

