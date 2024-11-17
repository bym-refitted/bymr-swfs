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
   
   public class GUARDIANCAGE extends BFOUNDATION
   {
      public static var _housed:Object;
      
      public static var _popup:GUARDIANCAGEPOPUP;
      
      public static var _select:GUARDIANSELECTPOPUP;
      
      public static var _namepopup:GUARDIANNAMEPOPUP;
      
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
               "evolveShiny":[79,265,679,1332,2038],
               "feedCount":[3,6,9,12,15],
               "feedTime":[86400],
               "buffs":[0],
               "movement":["ground"],
               "attack":["melee"],
               "bucket":[4 * 60],
               "offset_x":[-48,-38,-42,-52,-54,-46],
               "offset_y":[-38,-36,-52,-82,-98,-80]
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
               "feedTime":[86400],
               "buffs":[0],
               "movement":["ground"],
               "attack":["melee"],
               "bucket":[3 * 60],
               "offset_x":[-32,-38,-52,-56,-64,-70],
               "offset_y":[-28,-36,-50,-52,-68,-76]
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
               "feedTime":[86400],
               "buffs":[0.1,0.2,0.3,0.4,0.5,0.6],
               "movement":["ground","ground","fly"],
               "attack":["ranged"],
               "bucket":[200],
               "offset_x":[-20,-38,-52,-56,-60,-58],
               "offset_y":[-21,-36,-50,-52,-68,-98]
            }
         }
      };
      
      public static var _open:Boolean = false;
      
      public function GUARDIANCAGE()
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
         GLOBAL.Message("Do you really want to juice your Champion? <b>This cannot be undone.</b>","Yes, juice my Champion.",JuiceChampion);
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
               _select = GLOBAL._layerWindows.addChild(new GUARDIANSELECTPOPUP());
               _select.scaleX = _select.scaleY = 0.8;
               _select.x = GLOBAL._SCREENCENTER.x;
               _select.y = GLOBAL._SCREENCENTER.y;
               TweenLite.to(_select,0.2,{
                  "scaleX":1,
                  "scaleY":1,
                  "ease":Quad.easeOut
               });
            }
            else
            {
               if(CREATURES._guardian == null)
               {
                  GLOBAL._bCage.SpawnGuardian(BASE._guardianData.l.Get(),BASE._guardianData.fd,BASE._guardianData.ft,BASE._guardianData.t,BASE._guardianData.hp.Get(),BASE._guardianData.nm);
               }
               _popup = GLOBAL._layerWindows.addChild(new GUARDIANCAGEPOPUP());
               _popup.scaleX = _popup.scaleY = 0.8;
               _popup.x = GLOBAL._SCREENCENTER.x;
               _popup.y = GLOBAL._SCREENCENTER.y;
               TweenLite.to(_popup,0.2,{
                  "scaleX":1,
                  "scaleY":1,
                  "ease":Quad.easeOut
               });
            }
         }
      }
      
      public static function ShowName() : void
      {
         if(!_namepopup && Boolean(CREATURES._guardian))
         {
            _namepopup = new GUARDIANNAMEPOPUP();
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
                  _popup = GLOBAL._layerWindows.addChild(new GUARDIANCAGEPOPUP());
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
            tmpArray.push([_loc3_.movement,_loc3_.attack,_loc3_.speed,_loc3_.health,_loc3_.damage,_loc3_.healtime,_loc3_.feedCount,_loc3_.feedShiny,_loc3_.evolveShiny,_loc3_.feedTime,_loc3_.bucket,_loc3_.buffs,_loc3_.range]);
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
            this.SpawnGuardian(BASE._guardianData.l.Get(),BASE._guardianData.fd,BASE._guardianData.ft,BASE._guardianData.t,BASE._guardianData.hp.Get(),BASE._guardianData.nm);
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
      
      public function SpawnGuardian(param1:int, param2:int, param3:int = 0, param4:int = 1, param5:int = 1000000000, param6:String = "") : *
      {
         var _loc7_:Point = GRID.FromISO(x,y + 20);
         if(param3 == 0)
         {
            param3 = GLOBAL.Timestamp() + GetGuardianProperty("G" + param4,param1,"feedTime");
         }
         CREATURES._guardian = new GUARDIANMONSTER("pen",PointInCage(_loc7_),0,_loc7_,true,this,param1,param2,param3,param4,param5);
         CREATURES._guardian.Export();
         var _loc8_:Array = ["Gorgo","Drull","Fomor"];
         if(param6 != "")
         {
            CREATURES._guardian._name = param6;
         }
         else
         {
            CREATURES._guardian._name = _loc8_[param4 - 1];
         }
         MAP._BUILDINGTOPS.addChild(CREATURES._guardian);
         QUESTS.Check("hatch_champ" + param4,1);
      }
      
      public function FeedGuardian(param1:String, param2:int, param3:Boolean) : *
      {
         var _loc6_:Boolean = false;
         var _loc7_:String = null;
         var _loc8_:BFOUNDATION = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc11_:CREEP = null;
         var _loc12_:int = 0;
         if(_guardians[param1] == null)
         {
            return;
         }
         var _loc4_:Object = _guardians[param1].props.feeds[param2 - 1];
         var _loc5_:Object = {};
         if(param3)
         {
            if(BASE._credits.Get() < GetGuardianProperty(param1,param2,"feedShiny"))
            {
               POPUPS.DisplayGetShiny();
               return;
            }
            BASE.Purchase("IFD",GetGuardianProperty(param1,param2,"feedShiny"),"store");
            CREATURES._guardian._feeds.Add(1);
            if(CREATURES._guardian._feeds.Get() >= GetGuardianProperty(param1,param2,"feedCount"))
            {
               if(param2 < 5)
               {
                  GLOBAL.Message("Congratulations!  Your Champion has just evolved to Stage " + (param2 + 1) + "!  Its next feeding time is in " + GLOBAL.ToTime(GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime")));
               }
               else
               {
                  GLOBAL.Message("Congratulations!  Your Champion has just evolved to Stage " + (param2 + 1) + "!");
               }
               CREATURES._guardian.LevelSet(param2 + 1);
            }
            else
            {
               GLOBAL.Message("Your Champion is now fed.  Its next feeding time is in " + GLOBAL.ToTime(GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime")));
            }
            CREATURES._guardian._feedTime = new SecNum(GLOBAL.Timestamp() + GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"));
            CREATURES._guardian.Export();
            LOGGER.Log("fed","Fed shiny " + CREATURES._guardian._feeds.Get());
            LOGGER.Stat([58,CREATURES._guardian._creatureID,GetGuardianProperty(param1,param2,"feedShiny"),CREATURES._guardian._level.Get()]);
            BASE.Save();
         }
         else if(_loc4_)
         {
            _loc6_ = true;
            for(_loc7_ in _loc4_)
            {
               if(HOUSING._creatures[_loc7_] == null || HOUSING._creatures[_loc7_] && HOUSING._creatures[_loc7_].Get() < _loc4_[_loc7_])
               {
                  _loc6_ = false;
                  break;
               }
               _loc5_[_loc7_] = _loc4_[_loc7_];
            }
            if(_loc6_)
            {
               _loc9_ = [];
               for each(_loc8_ in BASE._buildingsAll)
               {
                  if(_loc8_._type == 15)
                  {
                     _loc9_.push(_loc8_);
                  }
               }
               for(_loc10_ in _loc5_)
               {
                  HOUSING._creatures[_loc10_].Add(-_loc5_[_loc10_]);
                  for each(_loc11_ in CREATURES._creatures)
                  {
                     if(_loc5_[_loc10_] > 0)
                     {
                        if(_loc11_._creatureID == _loc10_ && _loc11_._behaviour != "feed" && _loc11_._behaviour != "juice")
                        {
                           _loc11_.ModeFeed();
                           --_loc5_[_loc10_];
                        }
                     }
                  }
                  _loc12_ = 0;
                  while(_loc12_ < _loc5_[_loc10_])
                  {
                     _loc8_ = _loc9_[int(Math.random() * _loc9_.length)];
                     CREATURES.Spawn(_loc10_,MAP._BUILDINGTOPS,"feed",new Point(_loc8_.x,_loc8_.y).add(new Point(-60 + Math.random() * 135,65 + Math.random() * 50)),Math.random() * 360);
                     _loc12_++;
                  }
                  if(HOUSING._creatures[_loc10_].Get() < 0)
                  {
                     HOUSING._creatures[_loc10_].Set(0);
                  }
               }
               HOUSING.HousingSpace();
               CREATURES._guardian._feeds.Add(1);
               if(CREATURES._guardian._feeds.Get() >= GetGuardianProperty(param1,param2,"feedCount"))
               {
                  CREATURES._guardian.LevelSet(param2 + 1);
                  if(param2 < 5)
                  {
                     GLOBAL.Message("Congratulations!  Your Champion has just evolved to Stage " + (param2 + 1) + "!  Its next feeding time is in " + GLOBAL.ToTime(GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime")));
                  }
                  else
                  {
                     GLOBAL.Message("Congratulations!  Your Champion has just evolved to Stage " + (param2 + 1) + "!");
                  }
               }
               else
               {
                  GLOBAL.Message("Your Champion is now being fed.  Its next feeding time is in " + GLOBAL.ToTime(GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime")));
               }
               CREATURES._guardian._feedTime = new SecNum(GLOBAL.Timestamp() + GetGuardianProperty(param1,CREATURES._guardian._level.Get(),"feedTime"));
               CREATURES._guardian.Export();
               LOGGER.Log("fed","Fed creeps " + CREATURES._guardian._feeds.Get());
               LOGGER.Stat([58,CREATURES._guardian._creatureID,0,CREATURES._guardian._level.Get()]);
               BASE.Save();
            }
            else
            {
               GLOBAL.Message("Not enough creatures.  The Champion will still be hungry!");
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
         _upgradeDescription = "Upgrade the Monster Cage to gain access to a more powerful Champion Monster.";
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
            GLOBAL.Message("You cannot recycle your Champion Cage, you will leave your Champion without a home!");
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

