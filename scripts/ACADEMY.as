package
{
   import com.cc.utils.SecNum;
   import flash.events.MouseEvent;
   
   public class ACADEMY
   {
      public static var _monsterID:String;
      
      public static const ID:int = 26;
      
      public static var _building:BFOUNDATION = null;
      
      public static var _upgrades:Object = {};
      
      public static var _mc:ACADEMYPOPUP = null;
      
      public static var _open:Boolean = false;
      
      private static var _monsterString:String = "C";
      
      private static var _maxMonsters:int = 16;
      
      private static const _infernoFrameOffset:int = 6;
      
      private static const _yardMaxMonsters:int = 16;
      
      private static const _infernoMaxMonsters:int = 9;
      
      public function ACADEMY()
      {
         super();
      }
      
      public static function Data(param1:Object) : *
      {
         var _loc2_:String = null;
         _upgrades = {};
         for(_loc2_ in param1)
         {
            if((_loc2_.substr(0,1) == "C" || _loc2_.substr(0,2) == "IC") && Boolean(param1[_loc2_]))
            {
               _upgrades[_loc2_] = {};
               if(param1[_loc2_].time)
               {
                  if(param1[_loc2_].time <= 583200)
                  {
                     _upgrades[_loc2_].time = new SecNum(param1[_loc2_].time + GLOBAL.Timestamp());
                  }
                  else
                  {
                     _upgrades[_loc2_].time = new SecNum(param1[_loc2_].time);
                  }
               }
               if(param1[_loc2_].duration)
               {
                  _upgrades[_loc2_].duration = param1[_loc2_].duration;
               }
               if(param1[_loc2_].powerup)
               {
                  _upgrades[_loc2_].powerup = param1[_loc2_].powerup;
               }
               _upgrades[_loc2_].level = param1[_loc2_].level;
            }
         }
         if(_upgrades.C100)
         {
            _upgrades.C12 = _upgrades.C100;
            delete _upgrades.C100;
         }
      }
      
      public static function Show(param1:BFOUNDATION) : *
      {
         if(!_open)
         {
            _open = true;
            _building = param1;
            GLOBAL.BlockerAdd();
            _mc = GLOBAL._layerWindows.addChild(new ACADEMYPOPUP());
            _mc.Center();
            _mc.ScaleUp();
         }
      }
      
      public static function Hide(param1:MouseEvent = null) : *
      {
         if(_open)
         {
            GLOBAL.BlockerRemove();
            SOUNDS.Play("close");
            BASE.BuildingDeselect();
            _open = false;
            GLOBAL._layerWindows.removeChild(_mc);
            _mc = null;
         }
      }
      
      public static function StartMonsterUpgrade(param1:String, param2:Boolean = false) : Object
      {
         var _loc6_:Array = null;
         if(!_upgrades[param1])
         {
            _upgrades[param1] = {"level":1};
         }
         var _loc3_:Boolean = false;
         var _loc4_:String = "";
         var _loc5_:String = KEYS.Get("acad_status_level",{"v1":_upgrades[param1].level});
         if(Boolean(_building) && !_building._upgrading)
         {
            if(!_upgrades[param1].time)
            {
               if(Boolean(CREATURELOCKER._lockerData[param1]) && CREATURELOCKER._lockerData[param1].t == 2)
               {
                  if(_upgrades[param1].level < CREATURELOCKER._creatures[param1].trainingCosts.length + 1)
                  {
                     if(_upgrades[param1].level <= _building._lvl.Get())
                     {
                        _loc6_ = CREATURELOCKER._creatures[param1].trainingCosts[ACADEMY._upgrades[param1].level - 1];
                        if(BASE.Charge(3,_loc6_[0],true) > 0)
                        {
                           if(!param2)
                           {
                              BASE.Charge(3,_loc6_[0]);
                              _upgrades[param1].time = new SecNum(GLOBAL.Timestamp() + _loc6_[1]);
                              _upgrades[param1].duration = _loc6_[1];
                              _building._upgrading = param1;
                              BASE.Save();
                              LOGGER.Stat([11,int(param1.substr(1)),_upgrades[param1].level + 1]);
                           }
                        }
                        else
                        {
                           _loc3_ = true;
                           _loc4_ = BASE.isInferno() ? KEYS.Get("acad_err_sulfur") : KEYS.Get("acad_err_putty");
                           _loc5_ = BASE.isInferno() ? KEYS.Get("acad_err_sulfur") : KEYS.Get("acad_err_putty");
                        }
                     }
                     else
                     {
                        _loc3_ = true;
                        _loc4_ = KEYS.Get("acad_err_upgrade");
                        _loc5_ = KEYS.Get("acad_err_upgrade");
                        if(BASE.isInferno() && _upgrades[param1].level >= 4)
                        {
                           _loc3_ = true;
                           _loc4_ = KEYS.Get("acad_err_fullytrained");
                           _loc5_ = KEYS.Get("acad_err_lfullytrained",{"v1":_upgrades[param1].level});
                        }
                     }
                  }
                  else
                  {
                     _loc3_ = true;
                     _loc4_ = KEYS.Get("acad_err_fullytrained");
                     _loc5_ = KEYS.Get("acad_err_lfullytrained",{"v1":_upgrades[param1].level});
                  }
               }
               else
               {
                  _loc3_ = true;
                  _loc4_ = KEYS.Get("acad_err_locked");
                  _loc5_ = KEYS.Get("acad_err_locked");
               }
            }
            else
            {
               _loc3_ = true;
               _loc4_ = KEYS.Get("acad_err_training",{"v1":_upgrades[param1].level + 1});
               _loc5_ = KEYS.Get("acad_err_trainingstatus",{
                  "v1":_upgrades[param1].level + 1,
                  "v2":GLOBAL.ToTime(_upgrades[param1].time.Get() - GLOBAL.Timestamp())
               });
            }
         }
         else
         {
            _loc3_ = true;
            _loc4_ = KEYS.Get("acad_err_busy");
            if(_upgrades[param1].time)
            {
               _loc5_ = KEYS.Get("acad_err_trainingstatus",{
                  "v1":_upgrades[param1].level + 1,
                  "v2":GLOBAL.ToTime(_upgrades[param1].time.Get() - GLOBAL.Timestamp())
               });
            }
         }
         return {
            "error":_loc3_,
            "errorMessage":_loc4_,
            "status":_loc5_
         };
      }
      
      public static function CancelMonsterUpgrade(param1:String) : *
      {
         var _loc2_:* = undefined;
         delete _upgrades[param1].time;
         delete _upgrades[param1].duration;
         for each(_loc2_ in BASE._buildingsAll)
         {
            if(_loc2_._type == 26 && _loc2_._upgrading == param1)
            {
               _loc2_._upgrading = null;
               break;
            }
         }
         BASE.Fund(3,CREATURELOCKER._creatures[param1].trainingCosts[ACADEMY._upgrades[param1].level - 1][0]);
         BASE.Save();
      }
      
      public static function FinishMonsterUpgrade(param1:String) : *
      {
         var stat:Array;
         var Post:Function;
         var building:* = undefined;
         var id:String = null;
         var bragImage:String = null;
         var monsterName:String = null;
         var popupMC:popup_monster = null;
         var monsterID:String = param1;
         delete _upgrades[monsterID].time;
         delete _upgrades[monsterID].duration;
         ++_upgrades[monsterID].level;
         ++GLOBAL._playerCreatureUpgrades[monsterID].level;
         stat = CREATURELOCKER._creatures[monsterID].props.cResource;
         if(Boolean(stat) && _upgrades[monsterID].level == stat.length - 1)
         {
            LOGGER.KongStat([5,monsterID.substr(1)]);
         }
         for each(building in BASE._buildingsAll)
         {
            if(building._type == 26)
            {
            }
            if(building._type == 26 && building._upgrading == monsterID)
            {
               building._upgrading = null;
               break;
            }
         }
         LOGGER.Stat([12,monsterID.substr(monsterID.indexOf("C") + 1),_upgrades[monsterID].level]);
         if(GLOBAL._mode == "build")
         {
            Post = function():*
            {
               if(BASE.isInferno())
               {
                  GLOBAL.CallJS("sendFeed",["academy-training",KEYS.Get("acad_stream_title_inf",{
                     "v1":monsterName,
                     "v2":_upgrades[monsterID].level
                  }),KEYS.Get("acad_stream_description"),bragImage,0]);
               }
               else
               {
                  GLOBAL.CallJS("sendFeed",["academy-training",KEYS.Get("acad_stream_title",{
                     "v1":monsterName,
                     "v2":_upgrades[monsterID].level
                  }),KEYS.Get("acad_stream_description"),bragImage,0]);
               }
               POPUPS.Next();
            };
            for(id in ACADEMY._upgrades)
            {
               GLOBAL._playerCreatureUpgrades[id] = {"level":_upgrades[id].level};
            }
            if(CREATURELOCKER._creatures[_monsterID].stream[2])
            {
               bragImage = CREATURELOCKER._creatures[_monsterID].stream[2];
            }
            monsterName = KEYS.Get(CREATURELOCKER._creatures[monsterID].name);
            popupMC = new popup_monster();
            popupMC.tText.htmlText = KEYS.Get("acad_pop_complete",{"v1":monsterName});
            popupMC.bAction.SetupKey("btn_warnyourfriends");
            popupMC.bAction.addEventListener(MouseEvent.CLICK,Post);
            popupMC.bAction.Highlight = true;
            popupMC.bSpeedup.visible = false;
            POPUPS.Push(popupMC,null,null,null,"" + monsterID + "-150.png");
         }
      }
      
      public static function Tick() : *
      {
         var _loc1_:String = null;
         var _loc2_:Object = null;
         for(_loc1_ in _upgrades)
         {
            _loc2_ = _upgrades[_loc1_];
            if(_loc2_.time != null)
            {
               if(_upgrades[_loc1_].time.Get() <= GLOBAL.Timestamp())
               {
                  FinishMonsterUpgrade(_loc1_);
               }
            }
         }
         Update();
      }
      
      public static function Export() : Object
      {
         var _loc2_:String = null;
         var _loc1_:Object = {};
         for(_loc2_ in _upgrades)
         {
            if(_upgrades[_loc2_])
            {
               _loc1_[_loc2_] = {};
               _loc1_[_loc2_].level = _upgrades[_loc2_].level;
               if(_upgrades[_loc2_].time)
               {
                  _loc1_[_loc2_].time = _upgrades[_loc2_].time.Get();
               }
               if(_upgrades[_loc2_].duration)
               {
                  _loc1_[_loc2_].duration = _upgrades[_loc2_].duration;
               }
               if(_upgrades[_loc2_].powerup)
               {
                  _loc1_[_loc2_].powerup = _upgrades[_loc2_].powerup;
               }
            }
         }
         return _loc1_;
      }
      
      public static function Update() : *
      {
         if(_mc)
         {
            _mc.Update();
         }
      }
   }
}

