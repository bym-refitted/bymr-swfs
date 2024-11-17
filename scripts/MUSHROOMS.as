package
{
   import com.gskinner.utils.Rndm;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class MUSHROOMS
   {
      public static var _mushroom:BFOUNDATION;
      
      public static var _mushroomID:int;
      
      public function MUSHROOMS()
      {
         super();
      }
      
      public static function Setup() : void
      {
         var mushroomCount:int;
         var count:int = 0;
         var t:int = 0;
         var num:Number = NaN;
         var twist:int = 0;
         var i:int = 0;
         var dist:int = 0;
         var angle:int = 0;
         var spawn:int = 0;
         var X:* = undefined;
         var Y:* = undefined;
         var a:int = 0;
         var b:int = 0;
         var iso:* = undefined;
         var s:int = 0;
         var n:int = 0;
         var X2:* = undefined;
         var Y2:* = undefined;
         var shroom:Object = null;
         var replace:Boolean = false;
         var spawnCount:int = 0;
         if(!GLOBAL._flags.mushrooms && GLOBAL._mode == "build")
         {
            return;
         }
         if(BASE._isOutpost)
         {
            return;
         }
         mushroomCount = 0;
         try
         {
            if(BASE._lastSpawnedMushroom == 0)
            {
               BASE._mushroomList = [];
               count = 0;
               t = getTimer();
               num = Math.random();
               twist = int(Math.random() * 360);
               i = 1;
               while(i < 6)
               {
                  dist = i * 100 + 5 * 60;
                  angle = i * 60 + twist;
                  spawn = 4;
                  X = Math.sin(angle * 0.0174532925) * dist;
                  Y = Math.cos(angle * 0.0174532925) * dist;
                  a = 100 + Math.random() * 80;
                  b = 100 + Math.random() * 80;
                  s = 0;
                  while(s < spawn)
                  {
                     n = int(Math.random() * 5) + 1;
                     X2 = X + Math.sin(int(Math.random() * 360) * 0.0174532925) * a;
                     Y2 = Y + Math.cos(int(Math.random() * 360) * 0.0174532925) * b;
                     X2 = int(X2 / 10) * 10;
                     Y2 = int(Y2 / 10) * 10;
                     _mushroom = BASE.addBuildingC(7);
                     _mushroom.Setup({
                        "X":X2,
                        "Y":Y2,
                        "id":mushroomCount,
                        "t":7,
                        "frame":n
                     });
                     mushroomCount++;
                     s++;
                  }
                  i++;
               }
               BASE._lastSpawnedMushroom = GLOBAL.Timestamp();
            }
            else
            {
               i = 0;
               while(i < Math.min(BASE._mushroomList.length,20))
               {
                  shroom = {
                     "frame":BASE._mushroomList[i][0],
                     "X":BASE._mushroomList[i][1],
                     "Y":BASE._mushroomList[i][2],
                     "id":mushroomCount,
                     "t":7
                  };
                  replace = false;
                  if(shroom.X > GLOBAL._mapWidth * 0.5)
                  {
                     replace = true;
                  }
                  else if(shroom.X < 0 - GLOBAL._mapWidth * 0.5)
                  {
                     replace = true;
                  }
                  else if(shroom.Y > GLOBAL._mapHeight * 0.5)
                  {
                     replace = true;
                  }
                  else if(shroom.Y < 0 - GLOBAL._mapHeight * 0.5)
                  {
                     replace = true;
                  }
                  if(!replace)
                  {
                     _mushroom = BASE.addBuildingC(7);
                     _mushroom.Setup(shroom);
                  }
                  else
                  {
                     Spawn(1);
                  }
                  mushroomCount++;
                  i++;
               }
               if(BASE._mushroomList.length > 20)
               {
                  i = int(BASE._mushroomList.length - 1);
                  while(i > 19)
                  {
                     delete BASE._mushroomList[i];
                     i--;
                  }
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","MUSHROOMS.SetupA: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("");
         }
         try
         {
            spawnCount = Math.floor(GLOBAL.Timestamp() - BASE._lastSpawnedMushroom) / 17280;
            if(spawnCount > 0)
            {
               BASE._lastSpawnedMushroom = GLOBAL.Timestamp();
               if(spawnCount > 10)
               {
                  spawnCount = 10;
               }
               if(mushroomCount + spawnCount > 10)
               {
                  spawnCount = 10 - mushroomCount;
               }
               if(spawnCount > 0)
               {
                  Spawn(spawnCount);
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","MUSHROOMS.SetupB: " + e.message + " | " + e.getStackTrace());
            GLOBAL.ErrorMessage("");
         }
      }
      
      public static function Spawn(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(!GLOBAL._flags.mushrooms && GLOBAL._mode == "build")
         {
            return;
         }
         if(BASE._isOutpost)
         {
            return;
         }
         BASE._lastSpawnedMushroom = GLOBAL.Timestamp();
         LOGGER.Stat([35,param1]);
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc4_ = int(Math.random() * 5) + 1;
            _loc5_ = false;
            _loc6_ = 0;
            _loc7_ = 0;
            _loc8_ = 0;
            while(!_loc5_ && _loc8_ < 5000)
            {
               _loc8_++;
               _loc6_ = 200 + GLOBAL._mapWidth * 0.5 - Math.random() * (GLOBAL._mapWidth + 400);
               _loc7_ = 200 + GLOBAL._mapHeight * 0.5 - Math.random() * (GLOBAL._mapHeight + 400);
               if(_loc6_ > GLOBAL._mapWidth * 0.5 || _loc6_ < 0 - GLOBAL._mapWidth * 0.5 || _loc7_ > GLOBAL._mapHeight * 0.5 || _loc7_ < 0 - GLOBAL._mapHeight * 0.5)
               {
                  _loc5_ = true;
               }
               if(!_loc5_ && !GRID.FootprintBlocked([new Rectangle(0,0,30,30)],GRID.ToISO(_loc6_,_loc7_,0),true))
               {
                  _loc5_ = true;
               }
            }
            if(_loc5_)
            {
               _mushroom = BASE.addBuildingC(7);
               ++BASE._buildingCount;
               _mushroom.Setup({
                  "X":_loc6_,
                  "Y":_loc7_,
                  "id":BASE._buildingCount,
                  "t":7,
                  "frame":_loc4_
               });
            }
            _loc3_++;
         }
      }
      
      public static function PickWorker(param1:BFOUNDATION) : *
      {
         if(!param1._picking)
         {
            if(QUEUE.Add("mushroom" + param1._id,param1))
            {
               param1._mc.alpha = 0.5;
               param1._picking = true;
            }
            else
            {
               POPUPS.DisplayWorker(2,param1);
            }
         }
      }
      
      public static function Pick(param1:BFOUNDATION) : Boolean
      {
         var _loc4_:Rndm = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         var _loc2_:int = param1._id;
         var _loc3_:String = "";
         if(BASE._pendingPurchase.length > 0)
         {
            return false;
         }
         if(param1.RecycleC())
         {
            _loc4_ = new Rndm(int(param1.x * param1.y));
            _loc5_ = 0;
            _loc6_ = 0;
            ++QUESTS._global.mushroomspicked;
            if(int(_loc4_.random() * 4) == 0)
            {
               ++QUESTS._global.goldmushroomspicked;
               GLOBAL.ValidateMushroomPick(param1);
               _loc5_ = Math.random() * 3 + 1;
               if(_loc5_ == 3)
               {
                  _loc5_ = 1;
               }
               BASE.Purchase("MUSHROOM" + _loc5_,1,"MUSHROOMS");
               _loc6_ = 3;
               if(_loc5_ == 2)
               {
                  _loc6_ = 8;
               }
               _loc3_ = KEYS.Get("pop_mushroom_msg1",{"v1":_loc6_});
               _loc7_ = new popup_mushroomshiny();
               _loc7_.tTitle.htmlText = "<b>" + KEYS.Get("pop_goldenmushroom_title") + "</b>";
               _loc7_.tMessage.htmlText = "You\'ve picked a golden mushroom worth " + _loc6_ + " Shiny. <b>Mushrooms grow back every day.</b>";
               POPUPS.Push(_loc7_,null,null,"chaching","goldmushroom.png");
            }
            else
            {
               _loc8_ = int(Math.random() * 3);
               if(_loc8_ == 0)
               {
                  _loc3_ = KEYS.Get("pop_mushroom_msg2");
               }
               else if(_loc8_ == 1)
               {
                  _loc3_ = KEYS.Get("pop_mushroom_msg3");
               }
               else if(_loc8_ == 2)
               {
                  _loc3_ = KEYS.Get("pop_mushroom_msg4");
               }
               BASE.Save();
            }
            LOGGER.Stat([34,_loc6_]);
            QUESTS.Check();
            WORKERS.Say(_loc3_,QUEUE.Remove("mushroom" + _loc2_,true),50 * 60);
         }
         return true;
      }
   }
}

