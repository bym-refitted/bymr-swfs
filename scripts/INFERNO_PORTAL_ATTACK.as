package
{
   public class INFERNO_PORTAL_ATTACK
   {
      public function INFERNO_PORTAL_ATTACK()
      {
         super();
      }
      
      public static function GetVariableCreeps() : Array
      {
         var _loc2_:int = INFERNOPORTAL.building._lvl.Get() - 1;
         var _loc3_:int = int(BASE.BaseLevel().level);
         var _loc4_:Number = (_loc3_ - 30) / 16 + 0.25;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ > 4)
         {
            _loc2_ = 4;
         }
         if(_loc3_ <= 30)
         {
            _loc4_ = _loc3_ / 60 - 0.25;
            if(_loc4_ < 0.01)
            {
               _loc4_ = 0.01;
            }
         }
         else
         {
            if(_loc4_ < 0.25)
            {
               _loc4_ = 0.25;
            }
            if(_loc4_ > 1)
            {
               _loc4_ = 1;
            }
         }
         var _loc5_:Array = [[["IC1","bounce",Math.ceil(_loc4_ * 25),400,186,0,0],["IC1","bounce",Math.ceil(_loc4_ * 25),400,186,0,0],["IC2","bounce",Math.floor(_loc4_ * 50),500,186,0,1],["IC3","bounce",Math.floor(_loc4_ * 15),5 * 60,186,0,0]],[["IC1","bounce",Math.ceil(_loc4_ * 45),400,186,0,0],["IC2","bounce",Math.ceil(_loc4_ * 60),500,186,0,0],["IC3","bounce",Math.floor(_loc4_ * 25),5 * 60,186,0,1],["IC5","bounce",Math.floor(_loc4_ * 10),500,186,0,0]],[["IC1","bounce",Math.ceil(_loc4_ * 65),400,186,0,0],["IC2","bounce",Math.ceil(_loc4_ * 60),500,186,0,1],["IC7","bounce",Math.floor(_loc4_ * 15),5 * 60,186,0,0],["IC5","bounce",Math.floor(_loc4_ * 15),400,186,0,0],["IC4","bounce",Math.ceil(_loc4_ * 10),10 * 60,186,0,0]],[["IC2","bounce",Math.ceil(_loc4_ * 65),500,186,0,1],["IC6","bounce",Math.floor(_loc4_ * 30),5 * 60,186,0,0],["IC3","bounce",Math.ceil(_loc4_ * 40),500,186,0,0],["IC5","bounce",Math.floor(_loc4_ * 20),500,186,0,0],["IC7","bounce",Math.floor(_loc4_ * 20),350,186,0,0]],[["IC2","bounce"
         ,Math.ceil(_loc4_ * 70),10 * 60,186,0,1],["IC7","bounce",Math.floor(_loc4_ * 30),5 * 60,186,0,1],["IC5","bounce",Math.ceil(_loc4_ * 20),500,186,0,0],["IC6","bounce",Math.ceil(_loc4_ * 30),5 * 60,186,0,0],["IC8","bounce",Math.floor(_loc4_ * 25),700,186,0,0]]];
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_[_loc2_].length)
         {
            if(_loc5_[_loc2_][_loc7_][2] > 0)
            {
               _loc6_.push(_loc5_[_loc2_][_loc7_]);
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      public static function SpawnAttack() : void
      {
         WMATTACK._isAI = false;
         WMATTACK.AttackB();
         WMATTACK.SpawnA(GetVariableCreeps());
      }
   }
}

