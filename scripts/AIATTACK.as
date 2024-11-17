package
{
   import com.gskinner.utils.Rndm;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class AIATTACK
   {
      public static var _history:Object;
      
      public static var _inProgress:Boolean;
      
      public static var _lastClick:int = 0;
      
      public static var _isAI:Boolean = false;
      
      public static var _attacks:Array = [0x1f40,18800,43240,97290,214038,460182,966382,1981082,3962164,7726221,14679819,27157666,48883798,85546647,145429299,189058089,245775516,319508170,415360622,539968808,701959450,912547286,1186311471,1542204913,2004866386,2606326302,3388224193,4404691451,5726098886,7443928552,9677107118,12580239253,16354311030,21260604338,27638785640,35930421332,46709547731,60722412051];
      
      public function AIATTACK()
      {
         super();
      }
      
      public static function Setup(param1:Object) : *
      {
         _history = param1;
         if(!_history || _history.currentid != null)
         {
            _history = {};
         }
         if(!_history.lastattack)
         {
            _history.lastattack = 0;
         }
      }
      
      public static function Trigger() : *
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:BFOUNDATION = null;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         if(GLOBAL._mode == "build" && GLOBAL._render && POPUPS.Done())
         {
            if(_inProgress)
            {
               return false;
            }
            for(_loc1_ in _history)
            {
               if(_loc1_ != "lastattack" && _history[_loc1_][0] == 1)
               {
                  return false;
               }
            }
            if(TUTORIAL._stage == 110 && !_history.tut)
            {
               _history.tut = [1,GLOBAL.Timestamp()];
               BASE.Save();
               Tick();
               return true;
            }
            if(TUTORIAL._stage >= 200 && GLOBAL._bBaiter == null)
            {
               _loc2_ = int(BASE._basePoints) + int(BASE._baseValue);
               _loc3_ = 0;
               for each(_loc4_ in BASE._buildingsAll)
               {
                  if(_loc4_._hp.Get() < _loc4_._hpMax.Get())
                  {
                     _loc3_++;
                  }
               }
               if(_loc3_ == 0)
               {
                  if(GLOBAL.Timestamp() - _history.lastattack > 43200)
                  {
                     _loc5_ = 0;
                     while(_loc5_ < _attacks.length - 1)
                     {
                        _loc6_ = Number(_attacks[_loc5_]);
                        _loc7_ = _loc6_ + (_attacks[_loc5_ + 1] - _attacks[_loc5_]) * 0.5;
                        if(_loc2_ > _loc6_ && _loc2_ < _loc7_ && !_history["a" + _loc5_] && GLOBAL.Timestamp() - _history.lastattack > 600)
                        {
                           _history.lastattack = GLOBAL.Timestamp();
                           _loc8_ = 5 + Math.random() * 20;
                           if(_loc5_ == 2 || _loc5_ % 5 == 0)
                           {
                              _loc8_ = 60 + Math.random() * 60;
                           }
                           if(_loc5_ % 10 == 0)
                           {
                              _loc8_ = 2 * 60 + Math.random() * 60;
                           }
                           _history["a" + (_loc5_ + 1)] = [1,GLOBAL.Timestamp() + _loc8_];
                           BASE.Save();
                           Tick();
                           return true;
                        }
                        _loc5_++;
                     }
                     if(_loc2_ > 2000000 && !_history["s1"])
                     {
                        _history.s1 = [1,GLOBAL.Timestamp()];
                        BASE.Save();
                        Tick();
                        return true;
                     }
                  }
               }
            }
         }
      }
      
      public static function Tick() : *
      {
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         if(GLOBAL._mode != "build")
         {
            return false;
         }
         var _loc1_:int = 0;
         for(_loc2_ in _history)
         {
            if(_loc2_ != "lastattack")
            {
               _loc3_ = _history[_loc2_];
               if(_loc3_[0] == 1)
               {
                  if(_loc2_.substr(0,1) == "s")
                  {
                     Attack(_loc2_);
                  }
                  else
                  {
                     UI2.Show("warning");
                     if(_loc3_[1] <= GLOBAL.Timestamp())
                     {
                        UI2._warning.Update("<font size=\"28\">Don\'t Panic!</font>");
                        Attack(_loc2_);
                     }
                     else
                     {
                        _loc1_ = _loc3_[1] - GLOBAL.Timestamp();
                        UI2._warning.Update("<font size=\"15\">Wild Monsters approaching!</font><br><font size=\"11\">" + GLOBAL.ToTime(_loc1_,true) + "</font>");
                     }
                  }
               }
            }
         }
         if(_inProgress)
         {
            if(CREEPS._creepCount == 0)
            {
               End();
            }
            else if(GLOBAL.Timestamp() % 10 == 0)
            {
               _loc1_ = 0;
               for each(_loc4_ in CREEPS._creeps)
               {
                  if(_loc4_._behaviour == "attack" || _loc4_._behaviour == "bounce" || _loc4_._behaviour == "loot")
                  {
                     _loc1_++;
                  }
               }
               if(_loc1_ == 0)
               {
                  End();
               }
            }
         }
      }
      
      public static function Attack(param1:String) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _isAI = true;
         _history[param1] = [2];
         if(param1 == "s1")
         {
            TrojanHorse();
            return false;
         }
         AttackB();
         SOUNDS.PlayMusic("musicpanic");
         if(param1 == "tut")
         {
            if(GLOBAL._bTower)
            {
               _loc2_ = SpawnA([["C2","bounce",6,100,0,0,1]])[0][0];
               _loc3_ = Point.distance(new Point(GLOBAL._bTower.x,GLOBAL._bTower.y),new Point(_loc2_.x,_loc2_.y));
               MAP.FocusTo(GLOBAL._bTower.x,GLOBAL._bTower.y,_loc3_ / 60,2,0,false);
            }
            else
            {
               MAP.FocusTo(0,0,15,3,0);
            }
         }
         if(param1 == "a1")
         {
            SpawnA([["C2","bounce",5,100,160,0,0],["C1","bounce",5,100,3 * 60,0,1]]);
         }
         if(param1 == "a2")
         {
            SpawnA([["C1","bounce",10,200,90,0,1]]);
         }
         if(param1 == "a3")
         {
            SpawnA([["C1","bounce",5,200,270,0,1],["C2","bounce",5,200,290,0,0]]);
         }
         if(param1 == "a4")
         {
            SpawnA([["C2","bounce",8,5 * 60,90,0,1]]);
         }
         if(param1 == "a5")
         {
            SpawnA([["C3","bounce",10,400,330,0,1]]);
         }
         if(param1 == "a6")
         {
            SpawnA([["C2","bounce",8,400,3 * 60,0,1],["C3","bounce",5,400,200,0,1]]);
         }
         if(param1 == "a7")
         {
            SpawnA([["C2","bounce",6,400,45,0,1],["C2","bounce",6,400,65,0,1],["C2","bounce",6,400,85,0,1]]);
         }
         if(param1 == "a8")
         {
            SpawnA([["C4","bounce",10,400,320,0,1]]);
         }
         if(param1 == "a9")
         {
            SpawnA([["C4","bounce",15,400,20,0,1],["C3","bounce",15,400,50,0,1]]);
         }
         if(param1 == "a10")
         {
            SpawnA([["C4","bounce",10,400,45,0,1],["C2","bounce",10,400,65,0,1],["C1","bounce",10,400,85,0,1]]);
         }
         if(param1 == "a11")
         {
            SpawnA([["C7","bounce",10,400,270,0,1],["C7","bounce",10,400,4 * 60,0,1]]);
         }
         if(param1 == "a12")
         {
            SpawnA([["C4","bounce",20,400,3 * 60,0,1],["C3","bounce",20,400,210,0,1]]);
         }
         if(param1 == "a13")
         {
            SpawnA([["C4","bounce",15,400,210,0,1],["C2","bounce",15,400,250,0,1],["C1","bounce",10,400,85,0,1]]);
         }
         if(param1 == "a14")
         {
            SpawnA([["C7","bounce",10,400,350,0,1],["C7","bounce",10,400,330,0,1]]);
         }
         if(param1 == "a15")
         {
            SpawnA([["C1","bounce",10,400,20,0,1],["C1","bounce",10,400,0,0,1],["C1","bounce",10,400,70,0,1],["C1","bounce",10,400,90,0,1]]);
         }
         if(param1 == "a16")
         {
            SpawnA([["C8","bounce",10,400,340,0,1]]);
         }
         if(param1 == "a17")
         {
            SpawnA([["C8","bounce",10,400,5 * 60,0,1],["C9","bounce",10,400,350,0,1]]);
         }
         if(param1 == "a18")
         {
            SpawnA([["C10","bounce",5,400,20,0,1],["C9","bounce",10,400,50,0,1]]);
         }
         if(param1 == "a19")
         {
            SpawnA([["C10","bounce",5,400,310,0,1],["C11","bounce",5,400,290,0,1]]);
         }
         if(param1 == "a20")
         {
            SpawnA([["C12","bounce",2,400,20,0,1]]);
         }
         if(param1 == "a21")
         {
            SpawnA([["C12","bounce",2,400,200,0,1],["C9","bounce",5,400,230,0,1]]);
         }
         if(param1 == "a22")
         {
            SpawnA([["C10","bounce",15,400,250,0,1],["C11","bounce",15,400,270,0,1]]);
         }
         if(param1 == "a23")
         {
            SpawnA([["C6","bounce",30,400,20,0,1],["C3","bounce",30,400,50,0,1]]);
         }
         if(param1 == "a24")
         {
            SpawnA([["C2","bounce",15,400,160,0,1],["C3","bounce",15,400,200,0,1]]);
         }
         if(param1 == "a25")
         {
            SpawnA([["C6","bounce",8,400,45,0,1],["C6","bounce",8,400,65,0,1],["C6","bounce",8,400,85,0,1]]);
         }
         if(param1 == "a26")
         {
            SpawnA([["C7","bounce",15,400,3 * 60,0,1]]);
         }
         if(param1 == "a27")
         {
            SpawnA([["C4","bounce",20,400,20,0,1],["C3","bounce",20,400,50,0,1]]);
         }
         if(param1 == "a28")
         {
            SpawnA([["C4","bounce",20,400,45,0,1],["C2","bounce",20,400,65,0,1],["C1","bounce",20,400,85,0,1]]);
         }
         if(param1 == "a29")
         {
            SpawnA([["C7","bounce",15,400,20,0,1],["C7","bounce",15,400,50,0,1]]);
         }
         if(param1 == "a30")
         {
            SpawnA([["C4","bounce",30,400,170,0,1],["C3","bounce",20,400,210,0,1]]);
         }
         if(param1 == "a31")
         {
            SpawnA([["C2","bounce",15,400,45,0,1],["C4","bounce",15,400,65,0,1],["C10","bounce",10,400,85,0,1]]);
         }
         if(param1 == "a32")
         {
            SpawnA([["C7","bounce",15,400,20,0,1],["C7","bounce",15,400,50,0,1]]);
         }
         if(param1 == "a33")
         {
            SpawnA([["C1","bounce",10,400,3 * 60,0,1],["C1","bounce",10,400,160,0,1],["C1","bounce",10,400,70,0,1]]);
         }
         if(param1 == "a34")
         {
            SpawnA([["C8","bounce",25,400,250,0,1]]);
         }
         if(param1 == "a35")
         {
            SpawnA([["C8","bounce",20,400,190,0,1],["C9","bounce",10,400,230,0,1]]);
         }
         if(param1 == "a36")
         {
            SpawnA([["C10","bounce",15,400,20,0,1],["C9","bounce",10,400,50,0,1]]);
         }
         if(param1 == "a37")
         {
            SpawnA([["C10","bounce",15,400,200,0,1],["C11","bounce",10,400,220,0,1]]);
         }
         if(param1 == "a38")
         {
            SpawnA([["C12","bounce",4,400,20,0,1]]);
         }
         if(param1 == "a39")
         {
            SpawnA([["C12","bounce",4,400,210,0,1],["C9","bounce",15,10 * 60,230,0,1]]);
         }
         if(param1 == "a40")
         {
            SpawnA([["C10","bounce",20,400,45,0,1],["C11","bounce",20,400,65,0,1]]);
         }
         if(param1 == "a41")
         {
            SpawnA([["C6","bounce",30,400,20,0,1],["C9","bounce",25,400,50,0,1]]);
         }
         if(param1 == "a42")
         {
            SpawnA([["C6","bounce",30,400,230,0,1],["C9","bounce",40,400,260,0,1]]);
         }
         if(param1 == "a99")
         {
            SpawnA([["C1","bounce",20,400,230,0,1],["C2","bounce",20,400,230,0,1],["C3","bounce",20,400,230,0,1]]);
         }
      }
      
      public static function CustomAttack(param1:Array) : Array
      {
         _isAI = false;
         AttackB();
         UI2.Show("scareAway");
         var _loc2_:Array = SpawnA(param1);
         var _loc3_:* = _loc2_[0][0];
         var _loc4_:* = Point.distance(new Point(GLOBAL._bBaiter.x,GLOBAL._bBaiter.y),new Point(_loc3_.x,_loc3_.y));
         MAP.FocusTo(_loc3_.x,_loc3_.y,2);
         return _loc2_;
      }
      
      public static function AttackB() : *
      {
         ATTACK.Setup();
         BASE._blockSave = true;
         UI2.Hide("top");
         UI2.Hide("bottom");
         PLANNER.Hide();
         STORE.Hide();
         HATCHERY.Hide();
         HATCHERYCC.Hide();
         _inProgress = true;
      }
      
      public static function SpawnA(param1:Array) : Array
      {
         var _loc5_:int = 0;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:* = undefined;
         var _loc2_:int = getTimer();
         var _loc3_:Array = [];
         var _loc4_:* = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = int(param1[_loc4_][4]);
            _loc6_ = GRID.ToISO(Math.sin(_loc5_ * 0.0174532925) * (800 + param1[_loc4_][3] / 2),Math.cos(_loc5_ * 0.0174532925) * (800 + param1[_loc4_][3] / 2),0);
            _loc7_ = GRID.ToISO(Math.sin(_loc5_ * 0.0174532925) * 900,Math.cos(_loc5_ * 0.0174532925) * 900,0);
            _loc8_ = SpawnB(_loc6_,param1[_loc4_][3],param1[_loc4_][0],param1[_loc4_][2],param1[_loc4_][1]);
            _loc3_.push(_loc8_);
            if(param1[_loc4_][6] == 1)
            {
               MAP.FocusTo(_loc7_.x,_loc7_.y,2);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function SpawnB(param1:Point, param2:int, param3:String, param4:int, param5:String) : Array
      {
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Point = null;
         var _loc9_:MovieClip = null;
         var _loc10_:int = int(BASE._basePoints) + int(BASE._baseValue);
         var _loc11_:Number = 0.4;
         var _loc12_:Rndm = new Rndm(int(param1.x + param1.y));
         if(_loc10_ > 1000000)
         {
            _loc11_ = 0.5;
         }
         if(_loc10_ > 50 * 60 * 1000)
         {
            _loc11_ = 0.6;
         }
         if(_loc10_ > 100 * 60 * 1000)
         {
            _loc11_ = 0.7;
         }
         if(_loc10_ > 250 * 60 * 1000)
         {
            _loc11_ = 0.8;
         }
         if(_loc10_ > 50000000)
         {
            _loc11_ = 0.9;
         }
         if(TUTORIAL._stage < 200)
         {
            _loc11_ = 0.08;
         }
         param1 = GRID.FromISO(param1.x,param1.y);
         var _loc13_:Array = [];
         var _loc14_:int = 0;
         while(_loc14_ < param4)
         {
            _loc6_ = _loc12_.random() * 360 * 0.0174532925;
            _loc7_ = _loc12_.random() * param2 / 2;
            _loc8_ = param1.add(new Point(Math.sin(_loc6_) * _loc7_,Math.cos(_loc6_) * _loc7_));
            _loc9_ = CREEPS.Spawn(param3,MAP._BUILDINGTOPS,"bounce",GRID.ToISO(_loc8_.x,_loc8_.y,0),_loc12_.random() * 360,_loc11_,true);
            _loc13_.push(_loc9_);
            _loc14_++;
         }
         return _loc13_;
      }
      
      public static function End() : *
      {
         var _loc1_:BFOUNDATION = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:BFOUNDATION = null;
         _inProgress = false;
         UI2.Show("top");
         UI2.Show("bottom");
         UI2.Hide("warning");
         UI2.Hide("scareAway");
         for each(_loc1_ in BASE._buildingsAll)
         {
            _loc1_.GridCost(true);
         }
         for each(_loc1_ in BASE._buildingsMushrooms)
         {
            _loc1_.GridCost();
         }
         BASE._blockSave = false;
         BASE.Save();
         for(_loc4_ in BASE._buildingsAll)
         {
            _loc1_ = BASE._buildingsAll[_loc4_];
            if(_loc1_._class != "trap" && _loc1_._class != "wall")
            {
               _loc2_ += _loc1_._hp.Get();
               _loc3_ += _loc1_._hpMax.Get();
            }
         }
         for each(_loc5_ in BASE._buildingsAll)
         {
            if(_loc5_._hp.Get() < _loc5_._hpMax.Get() && _loc5_._repairing == 0)
            {
               _loc5_.Repair();
            }
         }
         if(MONSTERBAITER._scaredAway && _loc2_ < _loc3_)
         {
            ATTACK.PoorDefense();
         }
         else if(_loc2_ < _loc3_ * 0.9 || TUTORIAL._stage < 200)
         {
            ATTACK.PoorDefense();
         }
         else if(_loc2_ >= _loc3_ * 0.9)
         {
            if(!MONSTERBAITER._scaredAway)
            {
               ATTACK.WellDefended(true);
            }
         }
         MONSTERBAITER._scaredAway = false;
         QUESTS.Check();
         MONSTERBAITER._attacking = 0;
      }
      
      public static function TrojanHorse() : *
      {
         var _loc2_:Point = GRID.ToISO(-70,-800,0);
         var _loc3_:* = BASE.addBuildingC(27);
         _loc3_.x = _loc2_.x;
         _loc3_.y = _loc2_.y;
         _loc3_.PlaceB();
         MAP.FocusTo(_loc2_.x,_loc2_.y,2);
         BASE.Save();
      }
   }
}

