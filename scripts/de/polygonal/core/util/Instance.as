package de.polygonal.core.util
{
   import flash.Boot;
   
   public class Instance
   {
      public function Instance()
      {
      }
      
      public static function create(param1:Class, param2:Array = undefined) : Object
      {
         if(param2 == null)
         {
            return new param1();
         }
         switch(int(param2.length))
         {
            case 0:
               §§push(new param1());
               break;
            case 1:
               §§push(new param1(param2[0]));
               break;
            case 2:
               §§push(new param1(param2[0],param2[1]));
               break;
            case 3:
               §§push(new param1(param2[0],param2[1],param2[2]));
               break;
            case 4:
               §§push(new param1(param2[0],param2[1],param2[2],param2[3]));
               break;
            case 5:
               §§push(new param1(param2[0],param2[1],param2[2],param2[3],param2[4]));
               break;
            case 6:
               §§push(new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]));
               break;
            case 7:
               §§push(new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]));
               break;
            case 8:
               §§push(new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]));
               break;
            case 9:
               §§push(new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]));
               break;
            case 10:
               §§push(new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]));
               break;
            case 11:
               §§push(new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10]));
               break;
            case 12:
               §§push(new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11]));
               break;
            case 13:
               §§push(new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12]));
               break;
            case 14:
               §§push(new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12],param2[13]));
               break;
            default:
               Boot.lastError = new Error();
               throw "too many arguments";
         }
         return §§pop();
      }
      
      public static function createEmpty(param1:Class) : Object
      {
         var _loc3_:* = null as Object;
         var _loc4_:* = null;
         try
         {
            Boot.skip_constructor = true;
            _loc3_ = new param1();
            Boot.skip_constructor = false;
            return _loc3_;
         }
         catch(_loc_e_:*)
         {
            Boot.skip_constructor = false;
            Boot.lastError = new Error();
            throw _loc4_;
         }
      }
   }
}

