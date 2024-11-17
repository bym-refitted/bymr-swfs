package
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gs.*;
   import gs.easing.*;
   
   public class CHAMPIONCAGE extends BFOUNDATION
   {
      public static var _housed:Object;
      
      public static var _popup:CHAMPIONCAGEPOPUP;
      
      public static var _select:CHAMPIONSELECTPOPUP;
      
      public static var _namepopup:CHAMPIONNAMEPOPUP;
      
      public static var _guardians:Object = {
         "G1":{
            "name":"Gorgo",
            "description":"mon_gorgodesc",
            "props":{
               "speed":[1,1.2,1.4,1.6,1.8,2],
               "health":[40000,80000,2 * 60 * 1000,140000,160000,200000],
               "healtime":[60 * 60,2 * 60 * 60,4 * 60 * 60,0x7080,16 * 60 * 60,32 * 60 * 60],
               "range":[35,45,55,65,70,70],
               "damage":[1000,20 * 60,25 * 60,2000,2500,50 * 60],
               "feeds":[{"C2":15},{
                  "C2":10,
                  "C6":5
               },{"C6":20},{
                  "C6":10,
                  "C10":10
               },{"C10":20}],
               "feedShiny":[26,44,75,111,136],
               "evolveShiny":[158,530,1358,2664,4076],
               "feedCount":[3,6,9,12,15],
               "feedTime":[82800],
               "buffs":[0],
               "movement":["ground"],
               "attack":["melee"],
               "bucket":[4 * 60],
               "offset_x":[-48,-38,-42,-52,-54,-46],
               "offset_y":[-38,-36,-52,-82,-98,-80],
               "bonusSpeed":[0.1,0.2,0.4],
               "bonusHealth":[12500,27500,50000],
               "bonusRange":[0,0,0],
               "bonusDamage":[150,330,10 * 60],
               "bonusBuffs":[0,0,0],
               "bonusFeeds":[{"C10":20},{"C10":20},{"C10":20}],
               "bonusFeedShiny":[136,136,136],
               "bonusFeedTime":[86400]
            }
         },
         "G2":{
            "name":"Drull",
            "description":"mon_drulldesc",
            "props":{
               "speed":[2,2.2,2.5,2.8,3.2,3.6],
               "health":[200 * 60,20000,10 * 60 * 60,700 * 60,52000,60 * 1000],
               "healtime":[60 * 60,2 * 60 * 60,4 * 60 * 60,0x7080,16 * 60 * 60,32 * 60 * 60],
               "range":[35,45,55,65,85,90],
               "damage":[50 * 60,60 * 60,70 * 60,5500,6500,0x1f40],
               "feeds":[{"C1":30},{
                  "C1":20,
                  "C4":15
               },{"C7":50},{
                  "C7":10,
                  "C8":15
               },{"C8":30}],
               "feedShiny":[26,44,75,105,131],
               "evolveShiny":[158,530,1358,2530,3918],
               "feedCount":[3,6,9,12,15],
               "feedTime":[82800],
               "buffs":[0],
               "movement":["ground"],
               "attack":["melee"],
               "bucket":[3 * 60],
               "offset_x":[-32,-38,-52,-56,-64,-70],
               "offset_y":[-28,-36,-50,-52,-68,-76],
               "bonusSpeed":[0.1,0.2,0.4],
               "bonusHealth":[2500,5500,10000],
               "bonusRange":[0,0,0],
               "bonusDamage":[400,880,1600],
               "bonusBuffs":[0,0,0],
               "bonusFeeds":[{"C8":30},{"C8":30},{"C8":30}],
               "bonusFeedShiny":[131,131,131],
               "bonusFeedTime":[86400]
            }
         },
         "G3":{
            "name":"Fomor",
            "description":"mon_fomordesc",
            "props":{
               "speed":[1.2,1.4,2,2.1,2.2,2.3],
               "health":[250 * 60,17500,20000,375 * 60,25000,40000],
               "healtime":[60 * 60,2 * 60 * 60,4 * 60 * 60,0x7080,16 * 60 * 60,32 * 60 * 60],
               "range":[140,140,3 * 60,190,200,210],
               "damage":[70,80,90,100,110,2 * 60],
               "feeds":[{"C3":20},{
                  "C3":20,
                  "C9":2
               },{
                  "C3":40,
                  "C9":5
               },{
                  "C3":30,
                  "C9":10
               },{"C9":20}],
               "feedShiny":[26,45,62,76,96],
               "evolveShiny":[154,537,1116,1822,2891],
               "feedCount":[3,6,9,12,15],
               "feedTime":[82800],
               "buffs":[0.1,0.2,0.3,0.4,0.5,0.6],
               "movement":["ground","ground","fly"],
               "attack":["ranged"],
               "bucket":[200],
               "offset_x":[-20,-38,-52,-56,-60,-58],
               "offset_y":[-21,-36,-50,-52,-68,-98],
               "bonusSpeed":[0.1,0.2,0.4],
               "bonusHealth":[1000,2200,0xfa0],
               "bonusRange":[3,6,10],
               "bonusDamage":[3,6,10],
               "bonusBuffs":[0.03,0.06,0.15],
               "bonusFeeds":[{"C9":20},{"C9":20},{"C9":20}],
               "bonusFeedShiny":[96,96,96],
               "bonusFeedTime":[86400]
            }
         }
      };
      
      public static var _open:Boolean = false;
      
      public function CHAMPIONCAGE()
      {
         super();
         _type = 114;
         _footprint = [new Rectangle(0,0,160,160)];
         _gridCost = [[new Rectangle(10,10,140,20),400],[new Rectangle(130,30,20,2 * 60),400],[new Rectangle(10,30,20,2 * 60),400],[new Rectangle(30,130,30,20),400],[new Rectangle(100,130,30,20),400]];
         SetProps();
      }
      
      public static function PointInCage(param1:Point) : Point
      {
         var _loc2_:Rectangle = new Rectangle(40,40,40,40);
         return GRID.ToISO(param1.x + (_loc2_.x + Math.random() * _loc2_.width),param1.y + (_loc2_.y + Math.random() * _loc2_.height),0);
      }
      
      public static function GetFeedTime() : int
      {
         if(CREATURES._guardian)
         {
            return CREATURES._guardian._feedTime.Get();
         }
         return 0;
      }
      
      public static function GetNumFeeds() : int
      {
         if(CREATURES._guardian)
         {
            return CREATURES._guardian._feeds.Get();
         }
         return 0;
      }
      
      public static function ShowJuice() : *
      {
         GLOBAL.Message(KEYS.Get("msg_juicechampion_confirm"),KEYS.Get("msg_juicechampion_yes"),JuiceChampion);
      }
      
      public static function JuiceChampion() : *
      {
         if(CREATURES._guardian)
         {
            CREATURES._guardian.ModeJuice();
         }
      }
      
      public static function Show() : *
      {
         if(!_open)
         {
            _open = true;
            GLOBAL.BlockerAdd();
            if(BASE._guardianData == null)
            {
               _select = GLOBAL._layerWindows.addChild(new CHAMPIONSELECTPOPUP());
               _select.Center();
               _select.ScaleUp();
            }
            else
            {
               if(CREATURES._guardian == null)
               {
                  GLOBAL._bCage.SpawnGuardian(BASE._guardianData.l.Get(),BASE._guardianData.fd,BASE._guardianData.ft,BASE._guardianData.t,BASE._guardianData.hp.Get(),BASE._guardianData.nm,BASE._guardianData.fb.Get());
               }
               _popup = GLOBAL._layerWindows.addChild(new CHAMPIONCAGEPOPUP());
               _popup.Center();
               _popup.ScaleUp();
            }
         }
      }
      
      public static function ShowName() : void
      {
         if(!_namepopup && Boolean(CREATURES._guardian))
         {
            _namepopup = new CHAMPIONNAMEPOPUP();
            POPUPS.Push(_namepopup,null,null,null);
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
            if(_select)
            {
               GLOBAL._layerWindows.removeChild(_select);
               _select = null;
               if(CREATURES._guardian)
               {
                  _popup = GLOBAL._layerWindows.addChild(new CHAMPIONCAGEPOPUP());
                  _popup.scaleY = 0.8;
                  _popup.scaleX = 0.8;
                  _popup.x = GLOBAL._SCREENCENTER.x;
                  _popup.y = GLOBAL._SCREENCENTER.y;
                  TweenLite.to(_popup,0.2,{
                     "scaleX":1,
                     "scaleY":1,
                     "ease":Quad.easeOut
                  });
                  _open = true;
                  return;
               }
            }
            if(_popup)
            {
               GLOBAL._layerWindows.removeChild(_popup);
               _popup = null;
            }
            if(_namepopup)
            {
               POPUPS.Next();
               _namepopup = null;
            }
         }
      }
      
      public static function GetGuardianProperty(param1:String, param2:int, param3:String) : *
      {
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc4_:Object = _guardians[param1];
         if(_loc4_)
         {
            _loc5_ = _loc4_.props;
            if(_loc5_[param3])
            {
               _loc6_ = int(_loc5_[param3].length);
               if(param2 > _loc6_)
               {
                  return _loc5_[param3][_loc6_ - 1];
               }
               return _loc5_[param3][param2 - 1];
            }
         }
         return null;
      }
      
      public static function HealGuardian() : void
      {
         if(CREATURES._guardian)
         {
            CREATURES._guardian.Heal();
         }
      }
      
      public static function Check() : *
      {
         var tmpArray:Array = null;
         var Push:Function = function(param1:int):*
         {
            var _loc2_:Object = _guardians["G" + param1];
            var _loc3_:Object = _loc2_.props;
            tmpArray.push([_loc3_.movement,_loc3_.attack,_loc3_.speed,_loc3_.health,_loc3_.damage,_loc3_.healtime,_loc3_.feedCount,_loc3_.feedShiny,_loc3_.evolveShiny,_loc3_.feedTime,_loc3_.bucket,_loc3_.buffs,_loc3_.range,_loc3_.bonusSpeed,_loc3_.bonusHealth,_loc3_.bonusRange,_loc3_.bonusDamage,_loc3_.bonusFeedShiny,_loc3_.bonusFeedTime,_loc3_.bonusBuffs]);
         };
         tmpArray = [];
         var i:* = 1;
         while(i <= 3)
         {
            Push(i);
            i++;
         }
         return MD5.hash(com.adobe.serialization.json.JSON.encode(tmpArray));
      }
      
      override public function StopMoveB() : *
      {
         super.StopMoveB();
         if(CREATURES._guardian)
         {
            CREATURES._guardian._targetCenter = GRID.FromISO(_mc.x,_mc.y);
            CREATURES._guardian.ModeCage();
         }
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         if(Boolean(BASE._guardianData) && Boolean(BASE._guardianData.t))
         {
            this.SpawnGuardian(BASE._guardianData.l.Get(),BASE._guardianData.fd,BASE._guardianData.ft,BASE._guardianData.t,BASE._guardianData.hp.Get(),BASE._guardianData.nm,BASE._guardianData.fb.Get());
            if(BASE._guardianData.l.Get() == 6)
            {
               ACHIEVEMENTS.Check("upgrade_champ" + CREATURES._guardian._type,1);
            }
         }
      }
      
      override public function Tick() : *
      {
         super.Tick();
         if(!GLOBAL._catchup)
         {
            if(GLOBAL._mode == "build" && (WMATTACK._inProgress || MONSTERBAITER._attacking) || GLOBAL._mode != "build")
            {
               Render("open");
            }
            else
            {
               Render("");
            }
         }
         if(_open && Boolean(_popup))
         {
            _popup.Tick();
         }
      }
      
      public function SpawnGuardian(param1:int, param2:int, param3:int = 0, param4:int = 1, param5:int = 1000000000, param6:String = "", param7:int = 0) : *
      {
         var _loc8_:Point = GRID.FromISO(x,y + 20);
         if(param3 == 0)
         {
            param3 = GLOBAL.Timestamp() + GetGuardianProperty("G" + param4,param1,"feedTime");
         }
         CREATURES._guardian = new CHAMPIONMONSTER("pen",PointInCage(_loc8_),0,_loc8_,true,this,param1,param2,param3,param4,param5,param7);
         CREATURES._guardian.Export();
         var _loc9_:Array = ["Gorgo","Drull","Fomor"];
         if(param6 != "")
         {
            CREATURES._guardian._name = param6;
         }
         else
         {
            CREATURES._guardian._name = _loc9_[param4 - 1];
         }
         MAP._BUILDINGTOPS.addChild(CREATURES._guardian);
         QUESTS.Check("hatch_champ" + param4,1);
      }
      
      public function FeedGuardian(param1:String, param2:int, param3:Boolean) : *
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:String = null;
         var _loc10_:BFOUNDATION = null;
         var _loc11_:Array = null;
         var _loc12_:String = null;
         var _loc13_:CREEP = null;
         var _loc14_:int = 0;
         if(_guardians[param1] == null)
         {
            return;
         }
         var _loc4_:Object = _guardians[param1].props.feeds[param2 - 1];
         var _loc5_:Object = {};
         if(param2 == 6)
         {
            _loc4_ = _guardians[param1].props.bonusFeeds[CREATURES._guardian._foodBonus.Get()];
            if(CREATURES._guardian._foodBonus.Get() == 3)
            {
               _loc4_ = CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,3,"bonusFeeds");
            }
         }
         if(param2 == 6)
         {
            if(param3)
            {
               if(BASE._credits.Get() < GetGuardianProperty(param1,CREATURES._guardian._foodBonus.Get() + 1,"bonusFeedShiny"))
               {
                  POPUPS.DisplayGetShiny();
                  return;
               }
               BASE.Purchase("IFD",GetGuardianProperty(param1,CREATURES._guardian._foodBonus.Get() + 1,"bonusFeedShiny"),"cage");
               CREATURES._guardian._foodBonus.Add(1);
               _loc6_ = CREATURES._guardian._health.Get();
               if(CREATURES._guardian._foodBonus.Get() > 0 && CREATURES._guardian._foodBonus.Get() <= 3)
               {
                  _loc6_ += CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._foodBonus.Get(),"bonusHealth");
               }
               _loc7_ = CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"health") + CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._foodBonus.Get(),"bonusHealth");
               if(_loc6_ >= _loc7_)
               {
                  _loc6_ = _loc7_;
               }
               CREATURES._guardian._health.Set(_loc6_);
               GLOBAL.Message(KEYS.Get("msg_champion_fed",{"v1":GLOBAL.ToTime(GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"))}));
               CREATURES._guardian._feedTime = new SecNum(GLOBAL.Timestamp() + GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"));
               CREATURES._guardian.Export();
               LOGGER.Log("fed","Buff Fed shiny " + CREATURES._guardian._foodBonus.Get());
               LOGGER.Stat([60,CREATURES._guardian._creatureID,GetGuardianProperty(param1,CREATURES._guardian._foodBonus.Get(),"bonusFeedShiny"),CREATURES._guardian._foodBonus.Get()]);
               BASE.Save();
            }
            else if(_loc4_)
            {
               _loc8_ = true;
               for(_loc9_ in _loc4_)
               {
                  if(HOUSING._creatures[_loc9_] == null || HOUSING._creatures[_loc9_] && HOUSING._creatures[_loc9_].Get() < _loc4_[_loc9_])
                  {
                     _loc8_ = false;
                     break;
                  }
                  _loc5_[_loc9_] = _loc4_[_loc9_];
               }
               if(_loc8_)
               {
                  _loc11_ = [];
                  for each(_loc10_ in BASE._buildingsAll)
                  {
                     if(_loc10_._type == 15)
                     {
                        _loc11_.push(_loc10_);
                     }
                  }
                  for(_loc12_ in _loc5_)
                  {
                     HOUSING._creatures[_loc12_].Add(-_loc5_[_loc12_]);
                     for each(_loc13_ in CREATURES._creatures)
                     {
                        if(_loc5_[_loc12_] > 0)
                        {
                           if(_loc13_._creatureID == _loc12_ && _loc13_._behaviour != "feed" && _loc13_._behaviour != "juice")
                           {
                              _loc13_.ModeFeed();
                              --_loc5_[_loc12_];
                           }
                        }
                     }
                     _loc14_ = 0;
                     while(_loc14_ < _loc5_[_loc12_])
                     {
                        _loc10_ = _loc11_[int(Math.random() * _loc11_.length)];
                        CREATURES.Spawn(_loc12_,MAP._BUILDINGTOPS,"feed",new Point(_loc10_.x,_loc10_.y).add(new Point(-60 + Math.random() * 135,65 + Math.random() * 50)),Math.random() * 360);
                        _loc14_++;
                     }
                     if(HOUSING._creatures[_loc12_].Get() < 0)
                     {
                        HOUSING._creatures[_loc12_].Set(0);
                     }
                  }
                  HOUSING.HousingSpace();
                  CREATURES._guardian._foodBonus.Add(1);
                  if(CREATURES._guardian._foodBonus.Get() > 3)
                  {
                     CREATURES._guardian._foodBonus.Set(3);
                  }
                  _loc6_ = CREATURES._guardian._health.Get();
                  if(CREATURES._guardian._foodBonus.Get() > 0 && CREATURES._guardian._foodBonus.Get() <= 3)
                  {
                     _loc6_ += CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._foodBonus.Get(),"bonusHealth");
                  }
                  _loc7_ = CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._level.Get(),"health") + CHAMPIONCAGE.GetGuardianProperty(CREATURES._guardian._creatureID,CREATURES._guardian._foodBonus.Get(),"bonusHealth");
                  if(_loc6_ >= _loc7_)
                  {
                     _loc6_ = _loc7_;
                  }
                  CREATURES._guardian._health.Set(_loc6_);
                  GLOBAL.Message(KEYS.Get("msg_champion_feeding",{"v1":GLOBAL.ToTime(GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"))}));
                  CREATURES._guardian._feedTime = new SecNum(GLOBAL.Timestamp() + GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"));
                  CREATURES._guardian.Export();
                  LOGGER.Log("fed","Buff Fed creeps " + CREATURES._guardian._foodBonus.Get());
                  LOGGER.Stat([60,CREATURES._guardian._creatureID,0,CREATURES._guardian._foodBonus.Get()]);
                  BASE.Save();
               }
               else
               {
                  GLOBAL.Message(KEYS.Get("msg_champion_morecreatures"));
               }
            }
         }
         else if(param3)
         {
            if(BASE._credits.Get() < GetGuardianProperty(param1,param2,"feedShiny"))
            {
               POPUPS.DisplayGetShiny();
               return;
            }
            BASE.Purchase("IFD",GetGuardianProperty(param1,param2,"feedShiny"),"cage");
            CREATURES._guardian._feeds.Add(1);
            if(CREATURES._guardian._feeds.Get() >= GetGuardianProperty(param1,param2,"feedCount"))
            {
               if(param2 < 5)
               {
                  GLOBAL.Message(KEYS.Get("msg_champion_evolved",{
                     "v1":param2 + 1,
                     "v2":GLOBAL.ToTime(GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"))
                  }));
               }
               else
               {
                  GLOBAL.Message(KEYS.Get("msg_champion_fullyevolved",{"v1":param2 + 1}));
               }
               CREATURES._guardian.LevelSet(param2 + 1);
               if(CREATURES._guardian._level.Get() == 6)
               {
                  ACHIEVEMENTS.Check("upgrade_champ" + CREATURES._guardian._type,1);
               }
            }
            else
            {
               GLOBAL.Message(KEYS.Get("msg_champion_fed",{"v1":GLOBAL.ToTime(GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"))}));
            }
            CREATURES._guardian._feedTime = new SecNum(GLOBAL.Timestamp() + GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"));
            CREATURES._guardian.Export();
            LOGGER.Log("fed","Fed shiny " + CREATURES._guardian._feeds.Get());
            LOGGER.Stat([58,CREATURES._guardian._creatureID,GetGuardianProperty(param1,param2,"feedShiny"),CREATURES._guardian._level.Get()]);
            BASE.Save();
         }
         else if(_loc4_)
         {
            _loc8_ = true;
            for(_loc9_ in _loc4_)
            {
               if(HOUSING._creatures[_loc9_] == null || HOUSING._creatures[_loc9_] && HOUSING._creatures[_loc9_].Get() < _loc4_[_loc9_])
               {
                  _loc8_ = false;
                  break;
               }
               _loc5_[_loc9_] = _loc4_[_loc9_];
            }
            if(_loc8_)
            {
               _loc11_ = [];
               for each(_loc10_ in BASE._buildingsAll)
               {
                  if(_loc10_._type == 15)
                  {
                     _loc11_.push(_loc10_);
                  }
               }
               for(_loc12_ in _loc5_)
               {
                  HOUSING._creatures[_loc12_].Add(-_loc5_[_loc12_]);
                  for each(_loc13_ in CREATURES._creatures)
                  {
                     if(_loc5_[_loc12_] > 0)
                     {
                        if(_loc13_._creatureID == _loc12_ && _loc13_._behaviour != "feed" && _loc13_._behaviour != "juice")
                        {
                           _loc13_.ModeFeed();
                           --_loc5_[_loc12_];
                        }
                     }
                  }
                  _loc14_ = 0;
                  while(_loc14_ < _loc5_[_loc12_])
                  {
                     _loc10_ = _loc11_[int(Math.random() * _loc11_.length)];
                     CREATURES.Spawn(_loc12_,MAP._BUILDINGTOPS,"feed",new Point(_loc10_.x,_loc10_.y).add(new Point(-60 + Math.random() * 135,65 + Math.random() * 50)),Math.random() * 360);
                     _loc14_++;
                  }
                  if(HOUSING._creatures[_loc12_].Get() < 0)
                  {
                     HOUSING._creatures[_loc12_].Set(0);
                  }
               }
               HOUSING.HousingSpace();
               CREATURES._guardian._feeds.Add(1);
               if(CREATURES._guardian._feeds.Get() >= GetGuardianProperty(param1,param2,"feedCount"))
               {
                  CREATURES._guardian.LevelSet(param2 + 1);
                  if(CREATURES._guardian._level.Get() == 6)
                  {
                     ACHIEVEMENTS.Check("upgrade_champ" + CREATURES._guardian._type,1);
                  }
                  if(param2 < 5)
                  {
                     GLOBAL.Message(KEYS.Get("msg_champion_evolved",{
                        "v1":param2 + 1,
                        "v2":GLOBAL.ToTime(GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"))
                     }));
                  }
                  else
                  {
                     GLOBAL.Message(KEYS.Get("msg_champion_fullyevolved",{"v1":param2 + 1}));
                  }
               }
               else
               {
                  GLOBAL.Message(KEYS.Get("msg_champion_feeding",{"v1":GLOBAL.ToTime(GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"))}));
               }
               CREATURES._guardian._feedTime = new SecNum(GLOBAL.Timestamp() + GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"));
               CREATURES._guardian.Export();
               LOGGER.Log("fed","Fed creeps " + CREATURES._guardian._feeds.Get());
               LOGGER.Stat([58,CREATURES._guardian._creatureID,0,CREATURES._guardian._level.Get()]);
               BASE.Save();
            }
            else
            {
               GLOBAL.Message(KEYS.Get("msg_champion_morecreatures"));
            }
         }
      }
      
      override public function PlaceB() : *
      {
         super.PlaceB();
         GLOBAL._bCage = this;
      }
      
      override public function Description() : *
      {
         super.Description();
         _upgradeDescription = KEYS.Get("building_monstercage_upgrade");
      }
      
      override public function Constructed() : *
      {
         super.Constructed();
         GLOBAL._bCage = this;
      }
      
      override public function Upgraded() : *
      {
         super.Upgraded();
      }
      
      override public function Recycle() : *
      {
         if(CREATURES._guardian)
         {
            GLOBAL.Message(KEYS.Get("msg_cage_recycle"));
         }
         else
         {
            GLOBAL._bCage = null;
            super.Recycle();
         }
      }
      
      override public function Export() : *
      {
         return super.Export();
      }
   }
}

