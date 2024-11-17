package
{
   public class ACHIEVEMENTS
   {
      public static var _completed:Object;
      
      public static var _finished:Array = [];
      
      public static var _stats:Object = {
         "thlevel":0,
         "map2":0,
         "wmoutpost":0,
         "playeroutpost":0,
         "monstersblended":0,
         "upgrade_champ1":0,
         "upgrade_champ2":0,
         "upgrade_champ3":0,
         "heavytraps":0,
         "hugerage":0,
         "wm2hall":0,
         "blocksbuilt":0,
         "starterkit":0,
         "alliance":0,
         "unlock_monster":0,
         "upgrade_3":0,
         "stockpile":0
      };
      
      public static var _achievements:Array = [{
         "rules":{},
         "block":true
      },{"rules":{"thlevel":2}},{"rules":{"thlevel":5}},{"rules":{"thlevel":8}},{
         "rules":{
            "upgrade_champ1":1,
            "upgrade_champ2":1,
            "upgrade_champ3":1
         },
         "ANY":1
      },{"rules":{
         "upgrade_champ1":1,
         "upgrade_champ2":1,
         "upgrade_champ3":1
      }},{"rules":{"map2":1}},{"rules":{"wmoutpost":1}},{"rules":{"playeroutpost":5}},{
         "block":true,
         "rules":{"hugerage":1}
      },{"rules":{"wm2hall":1}},{"rules":{"monstersblended":5000}},{"rules":{"starterkit":1}},{"rules":{"alliance":1}},{"rules":{"stockpile":1}},{"rules":{"heavytraps":8}},{"rules":{"unlock_monster":1}},{
         "block":true,
         "rules":{"upgrade_3":1}
      }];
      
      public function ACHIEVEMENTS()
      {
         super();
      }
      
      public static function Data(param1:Object) : *
      {
         if(param1.s)
         {
            _stats = param1.s;
            _completed = param1.c;
         }
         else
         {
            _stats = param1;
         }
         if(!ACHIEVEMENTS._stats.upgrade_champ1 && Boolean(QUESTS._completed.UG1))
         {
            ACHIEVEMENTS._stats.upgrade_champ1 = 1;
         }
         if(!ACHIEVEMENTS._stats.upgrade_champ2 && Boolean(QUESTS._completed.UG2))
         {
            ACHIEVEMENTS._stats.upgrade_champ2 = 1;
         }
         if(!ACHIEVEMENTS._stats.upgrade_champ3 && Boolean(QUESTS._completed.UG3))
         {
            ACHIEVEMENTS._stats.upgrade_champ3 = 1;
         }
         if(ACHIEVEMENTS._stats.monstersblended < QUESTS._global.monstersblended)
         {
            ACHIEVEMENTS._stats.monstersblended = QUESTS._global.monstersblended;
         }
         if(!ACHIEVEMENTS._stats.wm2hall && Boolean(QUESTS._completed.WM2))
         {
            ACHIEVEMENTS._stats.wm2hall = 1;
         }
         ACHIEVEMENTS.Check("",0,true);
      }
      
      public static function Check(param1:String = "", param2:int = 0, param3:Boolean = false) : *
      {
         var fail:Boolean = false;
         var i:int = 0;
         var a:Object = null;
         var block:Boolean = false;
         var n:* = undefined;
         var s:String = param1;
         var v:int = param2;
         var checkall:Boolean = param3;
         try
         {
            if(GLOBAL._mode == "build" || s == "hugerage" || checkall)
            {
               if(s && _stats[s] != undefined && _stats[s] < v)
               {
                  _stats[s] = v;
               }
               if(!_completed)
               {
                  _completed = {};
               }
               i = 1;
               while(i < _achievements.length)
               {
                  a = _achievements[i];
                  block = false;
                  if(a.block)
                  {
                     block = true;
                  }
                  if((checkall || !_completed[i]) && !block)
                  {
                     fail = false;
                     for(n in a.rules)
                     {
                        if(n == "UNLOCK")
                        {
                           if(!CREATURELOCKER._lockerData[a.rules.UNLOCK] || CREATURELOCKER._lockerData[a.rules.UNLOCK].t == 1)
                           {
                              fail = true;
                           }
                        }
                        else if(a.rules[n] > _stats[n])
                        {
                           fail = true;
                           if(a["ANY"] == undefined || a["ANY"] == 0)
                           {
                              break;
                           }
                        }
                        else if(a["ANY"] != undefined)
                        {
                           break;
                        }
                     }
                     if(!fail)
                     {
                        _completed[i] = 1;
                        _finished.push(i);
                     }
                  }
                  i++;
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","ACHIEVEMENTS.Check: " + e.message + " | " + e.getStackTrace());
         }
      }
      
      public static function Report() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < _finished.length)
         {
            _loc1_.push(_finished[_loc2_]);
            _loc2_++;
         }
         _finished = [];
         return _loc1_;
      }
      
      public static function Export() : Object
      {
         if(!_completed)
         {
            _completed = {};
         }
         return {
            "s":_stats,
            "c":_completed
         };
      }
   }
}

