package package_1
{
   public class class_1
   {
      internal static const const_2:Array = new Array([1708201199,-1903842141,-1535566911,448128248],[-1771559799,1907976983,1105606320,2108252266],[700714040,-42738420,-977691782,-1260146977]);
      
      internal static const const_1:Array = new Array([-908814681,1506008151,1223697593,-1470707843,-2024107611,1736559861,292724236,1993691939,-1614622491,477638797,-1853900707,-146040009,-1574008418,1649654008,-1196301523,-2079449006,551894819,-535588528,371833253,-742457039,-941612726,-1910991374,-1894768819,871035158,-2022598456,-1192537908,-733981089,-1649855078,1484808026,2000032255,-1117477501,-319919101],[-261579051,466746907,-320344280,-2044898693,22150640,2020600701,109067060,635725889,393943454,-1182126,-424485470,-762182882,14008563,-751602877,-492084323,254815647,109067060,635725889,1734623054,-712437841,114316077,1526998587,291681893,1176848973,1732117414,298231975,664791943,980310101,-1241817732,-710218419,2055140831,-142128815,1514587335,-1976853054],[-2132055982,-201852765,-135692915,-1398067997,-806084400,-1687665815,372250702,-1730086416,-577957806,-1763943626,1128497978,-2128318619,-1120781500,2103355019,868062952,683855611,1580121870,1216600568,-2145525232,-412294085,1104329534
      ,1410757316,881394595,1488865889,1757162400,-2029886342]);
      
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
         _loc5_ = int(const_1[param1 - 5 ^ -78].length);
         while(_loc4_ < _loc5_)
         {
            _loc6_ = int(const_1[param1 - 5 ^ -78][_loc4_]);
            _loc4_++;
            _loc7_ = int(const_1[param1 - 5 ^ -78][_loc4_]);
            _loc8_ = 2654435769;
            _loc9_ = 84941944608;
            while(_loc9_ != 0)
            {
               _loc7_ -= (_loc6_ << 4 ^ _loc6_ >>> 5) + _loc6_ ^ _loc9_ + int(const_2[param2 + 3 ^ -848][_loc9_ >>> 11 & 3]);
               _loc9_ -= _loc8_;
               _loc6_ -= (_loc7_ << 4 ^ _loc7_ >>> 5) + _loc7_ ^ _loc9_ + int(const_2[param2 + 3 ^ -848][_loc9_ & 3]);
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

