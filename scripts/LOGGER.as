package
{
   import com.adobe.serialization.json.JSON;
   import flash.events.IOErrorEvent;
   
   public class LOGGER
   {
      public static var _logged:Object = {};
      
      public static var _statQueue:Array = [];
      
      public static var _statUpdated:int = 0;
      
      public function LOGGER()
      {
         super();
      }
      
      public static function Log(param1:String, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:Array = null;
         if(param2.search("recorddebugdata") != -1)
         {
            return;
         }
         if(param3 || !GLOBAL._flags || GLOBAL._flags && GLOBAL._flags.gamedebug == 1)
         {
            if(!_logged[param1 + param2])
            {
               if(param1 == "hak" || param1 == "err" || param1 == "log")
               {
                  _logged[param1 + param2] = 1;
               }
               param2 = "" + GLOBAL._softversion + " " + param2;
               _loc4_ = [["key",param1],["value",param2],["saveid",BASE._lastSaveID]];
               new URLLoaderApi().load(GLOBAL._apiURL + "player/recorddebugdata",_loc4_,handleLoadSuccessful,handleLoadError);
            }
         }
      }
      
      public static function Stat(param1:Array) : void
      {
         var st1:String = null;
         var st2:String = null;
         var st3:String = null;
         var name:String = null;
         var val:int = 0;
         var level:int = 0;
         var n2:int = 0;
         var o:Object = null;
         var data:Array = param1;
         if(!GLOBAL._flags.gamestatsb)
         {
            return;
         }
         try
         {
            n2 = 0;
            if(data[0] >= 1 && data[0] <= 4 || data[0] == 26 || data[0] == 51)
            {
               if(data[0] == 1 || data[0] == 2 || data[0] == 26)
               {
                  st1 = "buildings";
               }
               if(data[0] == 1)
               {
                  st2 = "build";
               }
               if(data[0] == 2)
               {
                  st2 = "upgrade";
               }
               if(data[0] == 26)
               {
                  st2 = "repairing";
               }
               if(data[0] == 3 || data[0] == 4 || data[0] == 51)
               {
                  st1 = "monsters";
               }
               if(data[0] == 3)
               {
                  st2 = "unlocking";
               }
               if(data[0] == 4)
               {
                  st2 = "training";
               }
               if(data[0] == 51)
               {
                  st2 = "powerup";
               }
               if(data[0] == 1 || data[0] == 2 || data[0] == 26)
               {
                  st3 = KEYS.Get(GLOBAL._buildingProps[data[1] - 1].name);
               }
               else
               {
                  st3 = KEYS.Get(CREATURELOCKER._creatures["C" + data[1]].name);
               }
               name = "speedup";
               val = int(data[4]);
            }
            else if(data[0] == 5)
            {
               st1 = "buildings";
               st2 = "build";
               st3 = KEYS.Get(GLOBAL._buildingProps[data[1] - 1].name);
               name = "build_start";
            }
            else if(data[0] == 6)
            {
               st1 = "buildings";
               st2 = "build";
               st3 = KEYS.Get(GLOBAL._buildingProps[data[1] - 1].name);
               name = "build_finish";
            }
            else if(data[0] == 7)
            {
               st1 = "buildings";
               st2 = "upgrade";
               st3 = KEYS.Get(GLOBAL._buildingProps[data[1] - 1].name);
               name = "upgrade_start";
               val = int(data[2]);
            }
            else if(data[0] == 8)
            {
               st1 = "buildings";
               st2 = "upgrade";
               st3 = KEYS.Get(GLOBAL._buildingProps[data[1] - 1].name);
               name = "upgrade_finish";
               val = int(data[2]);
            }
            else if(data[0] == 9)
            {
               st1 = "monsters";
               st2 = "unlock";
               st3 = KEYS.Get(CREATURELOCKER._creatures["C" + data[1]].name);
               name = "start";
            }
            else if(data[0] == 10)
            {
               st1 = "monsters";
               st2 = "unlock";
               st3 = KEYS.Get(CREATURELOCKER._creatures["C" + data[1]].name);
               name = "finish";
            }
            else if(data[0] == 11)
            {
               st1 = "monsters";
               st2 = "train";
               st3 = KEYS.Get(CREATURELOCKER._creatures["C" + data[1]].name);
               name = "start";
               val = int(data[2]);
            }
            else if(data[0] == 12)
            {
               st1 = "monsters";
               st2 = "train";
               st3 = KEYS.Get(CREATURELOCKER._creatures["C" + data[1]].name);
               name = "finish";
               val = int(data[2]);
            }
            else if(data[0] == 13)
            {
               st1 = "store";
               st2 = data[1];
               name = "cost";
               val = int(data[2]);
            }
            else if(data[0] == 14 || data[0] == 15)
            {
               st1 = "helping";
               st2 = "buildings";
               name = data[1];
               val = int(data[4]);
            }
            else if(data[0] != 16)
            {
               if(data[0] == 17)
               {
                  st1 = "looting";
                  st2 = KEYS.Get(GLOBAL._resourceNames[data[1] - 1]);
                  name = "quantity";
                  val = int(data[2]);
               }
               else if(data[0] == 18)
               {
                  st1 = "looting";
                  st2 = KEYS.Get(GLOBAL._resourceNames[data[1] - 1]);
                  name = "percent";
                  val = int(data[2]);
               }
               else if(data[0] != 19)
               {
                  if(data[0] == 27)
                  {
                     st1 = "catapult";
                     if(data[1] == 1)
                     {
                        st2 = "twig";
                     }
                     if(data[1] == 2)
                     {
                        st2 = "pebble";
                     }
                     if(data[1] == 3)
                     {
                        st2 = "putty";
                     }
                     if(data[2] == 0)
                     {
                        name = "small";
                     }
                     if(data[2] == 1)
                     {
                        name = "medium";
                     }
                     if(data[2] == 2)
                     {
                        name = "large";
                     }
                     if(data[2] == 3)
                     {
                        name = "huge";
                     }
                     val = int(data[3]);
                     if(data.length > 4)
                     {
                        n2 = int(data[4]);
                     }
                  }
                  else if(data[0] == 28)
                  {
                     st1 = "flinger";
                     name = data[1];
                     val = int(data[2]);
                     if(data.length > 3)
                     {
                        n2 = int(data[3]);
                     }
                  }
                  else if(data[0] == 29)
                  {
                     st1 = "load";
                     name = data[1];
                  }
                  else if(data[0] == 30)
                  {
                     st1 = "tutorial";
                     name = "start";
                  }
                  else if(data[0] == 31)
                  {
                     st1 = "tutorial";
                     name = "finish";
                  }
                  else if(data[0] == 32)
                  {
                     st1 = "banking";
                     name = KEYS.Get(GLOBAL._resourceNames[data[1] - 1]);
                     val = int(data[2]);
                  }
                  else if(data[0] == 33)
                  {
                     st1 = "levelup";
                     name = "level" + data[1];
                  }
                  else if(data[0] == 34)
                  {
                     st1 = "mushrooms";
                     name = "pick";
                     val = int(data[1]);
                  }
                  else if(data[0] == 35)
                  {
                     st1 = "mushrooms";
                     name = "spawn";
                     val = int(data[1]);
                  }
                  else if(data[0] == 36)
                  {
                     st1 = "marketing";
                     name = data[1];
                     val = 1;
                  }
                  else if(data[0] == 37)
                  {
                     st1 = "takeover";
                     name = data[1] == 1 ? "wildmonster" : "player";
                     val = 1;
                  }
                  else if(data[0] == 38)
                  {
                     st1 = "starterkit";
                     name = data[1];
                     val = int(data[2]);
                  }
                  else if(data[0] == 39)
                  {
                     st1 = "mushrooms";
                     name = "prompt";
                  }
                  else if(data[0] == 40)
                  {
                     st1 = "buildings";
                     st2 = "recycle";
                     st3 = KEYS.Get(GLOBAL._buildingProps[data[1] - 1].name);
                     name = "level";
                     val = int(data[2]);
                  }
                  else if(data[0] == 41)
                  {
                     st1 = "starterkit";
                     name = data[1];
                     val = int(data[2]);
                  }
                  else if(data[0] == 42)
                  {
                     st1 = "dailybonus";
                     name = "drop";
                     LOGGER.Log("log","db:drop",true);
                  }
                  else if(data[0] == 43)
                  {
                     st1 = "dailybonus";
                     name = "win";
                     val = int(data[1]);
                     LOGGER.Log("log","db:win " + data[1],true);
                  }
                  else if(data[0] == 44)
                  {
                     st1 = "dailybonus";
                     name = "buy";
                     val = int(data[1]);
                     LOGGER.Log("log","db:buy " + data[1],true);
                  }
                  else if(data[0] == 45)
                  {
                     st1 = "mapv2relocate";
                     name = "mine";
                     val = int(data[1]);
                  }
                  else if(data[0] == 46)
                  {
                     st1 = "monsters";
                     st2 = "unlock";
                     st3 = KEYS.Get(CREATURELOCKER._creatures["C" + data[1]].name);
                     name = "instant";
                  }
                  else if(data[0] == 47)
                  {
                     st1 = "monsters";
                     st2 = "train";
                     st3 = KEYS.Get(CREATURELOCKER._creatures["C" + data[1]].name);
                     name = "instant";
                     val = int(data[2]);
                  }
                  else if(data[0] == 48)
                  {
                     st1 = "monsters";
                     st2 = "powerup";
                     st3 = KEYS.Get(CREATURELOCKER._creatures["C" + data[1]].name);
                     name = "shiny";
                     val = int(data[2]);
                  }
                  else if(data[0] == 49)
                  {
                     st1 = "monsters";
                     st2 = "powerup";
                     st3 = KEYS.Get(CREATURELOCKER._creatures["C" + data[1]].name);
                     name = "start";
                     val = int(data[2]);
                  }
                  else if(data[0] == 50)
                  {
                     st1 = "monsters";
                     st2 = "powerup";
                     st3 = KEYS.Get(CREATURELOCKER._creatures["C" + data[1]].name);
                     name = "finish";
                     val = int(data[2]);
                  }
                  else if(data[0] == 59)
                  {
                     st1 = "champion";
                     st2 = "heal";
                     name = "level" + data[3];
                     st3 = GUARDIANCAGE._guardians[data[1]].name;
                     val = int(data[2]);
                  }
                  else if(data[0] == 52)
                  {
                     st1 = "champion";
                     st2 = "select";
                     name = "level1";
                     st3 = GUARDIANCAGE._guardians[data[1]].name;
                     val = int(data[2]);
                  }
                  else if(data[0] == 53)
                  {
                     st1 = "champion";
                     st2 = "attack_win";
                     name = "level" + data[3];
                     st3 = GUARDIANCAGE._guardians[data[1]].name;
                     val = int(data[2]);
                  }
                  else if(data[0] == 54)
                  {
                     st1 = "champion";
                     st2 = "attack_lose";
                     name = "level" + data[3];
                     st3 = GUARDIANCAGE._guardians[data[1]].name;
                     val = int(data[2]);
                  }
                  else if(data[0] == 55)
                  {
                     st1 = "champion";
                     st2 = "defense_win";
                     name = "level" + data[3];
                     st3 = GUARDIANCAGE._guardians[data[1]].name;
                     val = int(data[2]);
                  }
                  else if(data[0] == 56)
                  {
                     st1 = "champion";
                     st2 = "defense_lose";
                     name = "level" + data[3];
                     st3 = GUARDIANCAGE._guardians[data[1]].name;
                     val = int(data[2]);
                  }
                  else if(data[0] == 57)
                  {
                     st1 = "champion";
                     st2 = "evolve";
                     name = "level" + data[3];
                     st3 = GUARDIANCAGE._guardians[data[1]].name;
                     val = int(data[2]);
                  }
                  else if(data[0] == 58)
                  {
                     st1 = "champion";
                     st2 = "feed";
                     name = "level" + data[3];
                     st3 = GUARDIANCAGE._guardians[data[1]].name;
                     val = int(data[2]);
                  }
                  else if(data[0] == 59)
                  {
                     st1 = "store";
                     st2 = "purchase";
                     name = data[1];
                     val = int(data[2]);
                  }
               }
            }
            if(st1)
            {
               o = {};
               if(st1)
               {
                  o.st1 = st1.toLowerCase().replace(" ","_");
                  if(BASE._isOutpost)
                  {
                     o.st1 = "outpost-" + o.st1;
                  }
               }
               if(st2)
               {
                  o.st2 = st2.toLowerCase().replace(" ","_");
               }
               if(st3)
               {
                  o.st3 = st3.toLowerCase().replace(" ","_");
               }
               if(val)
               {
                  o.value = val;
               }
               if(n2)
               {
                  o.n2 = n2;
               }
               o.level = BASE.BaseLevel().level;
               GLOBAL.CallJS("cc.recordEvent",[name,o],false);
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","LOGGER.Stat " + data);
         }
      }
      
      public static function KongStat(param1:Array) : *
      {
         var st1:String = null;
         var st2:String = null;
         var st3:String = null;
         var name:String = null;
         var val:int = 0;
         var level:int = 0;
         var monsternames:Array = null;
         var arg:Object = null;
         var arrArg:Array = null;
         var data:Array = param1;
         if(!GLOBAL._flags.kongregate)
         {
            return;
         }
         try
         {
            monsternames = ["pokey","octo","bolt","fink","eyera","ichi","bandito","fang","brain","crabatron","projectx","dave","wormzer","teratorn","zafreeti"];
            switch(data[0])
            {
               case 1:
                  arg = {};
                  arg["unlock_" + monsternames[data[1] - 1]] = 1;
                  break;
               case 2:
                  arg = {"Townhall":data[1]};
                  break;
               case 3:
                  arg = {"looted":data[1]};
                  break;
               case 4:
                  arg = {"defense":data[1]};
                  break;
               case 5:
                  arg = {};
                  arg["train_" + monsternames[data[1] - 1]] = 1;
            }
            arrArg = [com.adobe.serialization.json.JSON.encode(arg)];
            GLOBAL.CallJS("cc.kg_statsUpdate",[arg]);
         }
         catch(e:Error)
         {
            LOGGER.Log("err","LOGGER.KongStat " + data);
         }
      }
      
      public static function Tick() : *
      {
      }
      
      public static function handleLoadSuccessful(param1:Object) : *
      {
         if(param1.error == 0)
         {
         }
      }
      
      public static function handleLoadError(param1:IOErrorEvent) : void
      {
      }
   }
}

