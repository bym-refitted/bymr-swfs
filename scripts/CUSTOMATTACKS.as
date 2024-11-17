package
{
   import com.cc.utils.SecNum;
   import flash.geom.Point;
   
   public class CUSTOMATTACKS
   {
      public static var _history:Object;
      
      public static var _inProgress:Boolean;
      
      public static var _started:Boolean;
      
      public static var _lastClick:int = 0;
      
      public static var _isAI:Boolean = false;
      
      public static var _attacks:Array = [0x1f40,18800,43240,97290,214038,460182,966382,1981082,3962164,7726221,14679819,27157666,48883798,85546647,145429299,189058089,245775516,319508170,415360622,539968808,701959450,912547286,1186311471,1542204913,2004866386,2606326302,3388224193,4404691451,5726098886,7443928552,9677107118,12580239253,16354311030,21260604338,27638785640,35930421332,46709547731,60722412051];
      
      public function CUSTOMATTACKS()
      {
         super();
      }
      
      public static function Setup() : void
      {
         _started = false;
      }
      
      public static function TrojanHorse() : void
      {
         var _loc1_:Point = null;
         var _loc2_:BFOUNDATION = null;
         if(!BUILDING27._exists)
         {
            _loc1_ = GRID.ToISO(-70,-800,0);
            _loc2_ = BASE.addBuildingC(27);
            ++BASE._buildingCount;
            _loc2_.Setup({
               "t":27,
               "X":-70,
               "Y":-800,
               "id":BASE._buildingCount
            });
            MAP.FocusTo(_loc1_.x,_loc1_.y,2);
            BASE.Save(0,false,true);
         }
      }
      
      public static function CustomAttack(param1:Array, param2:Boolean = false) : Array
      {
         _started = true;
         WMATTACK._isAI = false;
         WMATTACK.AttackB();
         UI2.Show("scareAway");
         var _loc3_:Array = WMATTACK.SpawnA(param1);
         var _loc4_:* = _loc3_[0][0];
         MAP.FocusTo(_loc4_.x,_loc4_.y,2);
         return _loc3_;
      }
      
      public static function WMIAttack(param1:Array) : Array
      {
         _started = true;
         WMATTACK._isAI = false;
         WMATTACK.AttackB();
         UI2.Show("scareAway");
         return WMATTACK.SpawnA(param1);
      }
      
      public static function TutorialAttack() : void
      {
         var _loc1_:Array = null;
         var _loc2_:CREEP = null;
         var _loc3_:int = 0;
         var _loc4_:CREEP = null;
         _started = true;
         _loc1_ = WMATTACK.SpawnA([["C2","bounce",1,3 * 60,-10,0,1]]);
         _loc1_ = WMATTACK.SpawnA([["C2","bounce",2,190,-5,0,1]]);
         _loc1_ = WMATTACK.SpawnA([["C2","bounce",2,190,10,0,1]]);
         _loc1_ = WMATTACK.SpawnA([["C2","bounce",1,250,5,0,1]]);
         _loc1_ = WMATTACK.SpawnA([["C2","bounce",2,190,0,0,1]]);
         _loc2_ = _loc1_[0][0];
         _loc3_ = Point.distance(new Point(GLOBAL._bTower.x,GLOBAL._bTower.y),new Point(_loc2_.x,_loc2_.y));
         SOUNDS.PlayMusic("musicpanic");
         WMATTACK.AttackB();
         WMATTACK.AttackC();
         MAP.FocusTo(GLOBAL._bTower.x,GLOBAL._bTower.y,int(_loc3_ / 100),0,0,false);
         for each(_loc4_ in CREEPS._creeps)
         {
            _loc4_._health = new SecNum(1);
            _loc4_._maxHealth = 1;
            _loc4_._damage = new SecNum(50);
         }
         WMATTACK._isAI = false;
         WMATTACK._inProgress = true;
      }
   }
}

