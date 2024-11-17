package
{
   import com.cc.utils.SecNum;
   import com.monsters.monsters.champions.ChampionBase;
   import flash.display.MovieClip;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFieldAutoSize;
   
   public class UPDATES
   {
      public static var _updates:Array;
      
      public static var _myUpdates:Array;
      
      public static var _lastUpdateID:Number;
      
      public static var _catchupList:Array;
      
      public static var _actions:Array;
      
      public function UPDATES()
      {
         super();
      }
      
      public static function Setup() : void
      {
         _updates = [];
         _myUpdates = [];
         _catchupList = [];
         _actions = [];
         _lastUpdateID = 0;
      }
      
      public static function addAction(param1:Function, param2:String) : void
      {
         _actions[param2] = param1;
      }
      
      public static function Process(param1:Array) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         if(!GLOBAL._save)
         {
            return;
         }
         if(param1)
         {
            for each(_loc2_ in param1)
            {
               if(_loc2_.data)
               {
                  if(_loc2_.id > _lastUpdateID)
                  {
                     _lastUpdateID = _loc2_.id;
                  }
                  _loc3_ = JSON.decode(_loc2_.data);
                  for each(_loc4_ in _loc3_)
                  {
                     _updates.push({
                        "fbid":_loc2_.fbid,
                        "name":_loc2_.name,
                        "data":_loc4_
                     });
                  }
               }
            }
         }
      }
      
      public static function Check() : void
      {
         var _loc3_:Object = null;
         if(!GLOBAL._save)
         {
            return;
         }
         var _loc1_:int = GLOBAL.Timestamp();
         var _loc2_:int = 0;
         while(_loc2_ < _updates.length)
         {
            _loc3_ = _updates[_loc2_].data;
            if(_loc3_[0] <= _loc1_)
            {
               if(Action(_updates[_loc2_]))
               {
                  _updates.splice(_loc2_,1);
                  _loc2_--;
               }
            }
            _loc2_++;
         }
         if(_catchupList.length > 0 && !GLOBAL._catchup)
         {
            Catchup();
         }
      }
      
      public static function Action(param1:Object) : Boolean
      {
         var building:BFOUNDATION = null;
         var popupMC:MovieClip = null;
         var time:int = 0;
         var length:int = 0;
         var i:int = 0;
         var monsterdata:Object = null;
         var refundType:int = 0;
         var refundLevel:int = 0;
         var refundFeeds:int = 0;
         var refundBuff:int = 0;
         var refundID:String = null;
         var refundName:String = null;
         var refundHealth:int = 0;
         var refundFeedtime:int = 0;
         var update:Object = param1;
         var freezeChamp:Function = function():void
         {
            var _loc1_:int = 0;
            var _loc2_:int = 0;
            if(CREATURES._guardian)
            {
               CREATURES._guardian._health.Set(CREATURES._guardian._maxHealth);
               CREATURES._guardian.Export();
               CREATURES._guardian.ModeFreeze();
               _loc1_ = 0;
               _loc2_ = 0;
               while(_loc2_ < BASE._guardianData.length)
               {
                  if(BASE._guardianData[_loc2_].t == CREATURES._guardian._type)
                  {
                     _loc1_ = _loc2_;
                  }
                  _loc2_++;
               }
               BASE._guardianData[_loc1_].ft -= GLOBAL.Timestamp();
               (GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen.push(BASE._guardianData[_loc1_]);
               BASE._guardianData.splice(_loc1_,1);
               if(GLOBAL._mode == "build")
               {
                  _loc2_ = GLOBAL.getPlayerGuardianIndex(CREATURES._guardian._type);
                  GLOBAL._playerGuardianData[_loc2_] = null;
                  GLOBAL._playerGuardianData.splice(_loc2_,1);
               }
               CREATURES._guardian = null;
            }
         };
         var thawChamp:Function = function(param1:int):void
         {
            var _loc3_:Point = null;
            var _loc4_:int = 0;
            var _loc5_:Point = null;
            var _loc6_:Array = null;
            var _loc7_:int = 0;
            var _loc2_:int = 0;
            while(_loc2_ < (GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen.length)
            {
               if((GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen[_loc2_].t == param1)
               {
                  _loc3_ = new Point(GLOBAL._bChamber.x,GLOBAL._bChamber.y + 80);
                  _loc4_ = int((GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen[_loc2_].l.Get());
                  _loc5_ = GRID.FromISO(GLOBAL._bCage.x,GLOBAL._bCage.y + 20);
                  if(refundLevel > 0)
                  {
                     CREATURES._guardian = new ChampionBase("cage",_loc3_,0,_loc5_,true,GLOBAL._bChamber,(GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen[_loc2_].l.Get(),(GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen[_loc2_].fd,(GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen[_loc2_].ft + GLOBAL.Timestamp(),(GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen[_loc2_].t,(GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen[_loc2_].hp.Get(),(GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen[_loc2_].fb.Get());
                     CREATURES._guardian.Export();
                     MAP._BUILDINGTOPS.addChild(CREATURES._guardian);
                     CREATURES._guardian.ModeCage();
                  }
                  _loc6_ = [];
                  _loc7_ = 0;
                  while(_loc7_ < (GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen.length)
                  {
                     if(_loc2_ != _loc7_)
                     {
                        _loc6_.push((GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen[_loc7_]);
                     }
                     _loc7_++;
                  }
                  (GLOBAL._bChamber as CHAMPIONCHAMBER)._frozen = _loc6_;
                  break;
               }
               _loc2_++;
            }
         };
         if(!GLOBAL._save)
         {
            return false;
         }
         if(BASE.isInferno())
         {
            return false;
         }
         if(_actions[update.data[1]])
         {
            return _actions[update.data[1]]();
         }
         if(update.data[1] == "BU")
         {
            building = GetBuilding(update.data[2]);
            if(building)
            {
               building.UpgradeB();
            }
         }
         if(update.data[1] == "BUC")
         {
            building = GetBuilding(update.data[2]);
            if(building)
            {
               building.UpgradeCancelC();
            }
         }
         if(update.data[1] == "BF")
         {
            building = GetBuilding(update.data[2]);
            if(building)
            {
               building.FortifyB();
            }
         }
         if(update.data[1] == "BFC")
         {
            building = GetBuilding(update.data[2]);
            if(building)
            {
               building.FortifyCancelC();
            }
         }
         if(update.data[1] == "BMU")
         {
            length = int(update.data.length);
            if(HOUSING._creatures)
            {
               i = 2;
               while(i < length)
               {
                  monsterdata = update.data[i];
                  if(Boolean(HOUSING._creatures[monsterdata.creatureID]) && HOUSING._creatures[monsterdata.creatureID].Get() > 0)
                  {
                     HOUSING._creatures[monsterdata.creatureID].Add(-monsterdata.count);
                     if(HOUSING._creatures[monsterdata.creatureID].Get() <= 0)
                     {
                        HOUSING._creatures[monsterdata.creatureID].Set(0);
                     }
                  }
                  else if(monsterdata.count < 0)
                  {
                     HOUSING._creatures[monsterdata.creatureID] = new SecNum(-monsterdata.count);
                  }
                  i++;
               }
            }
         }
         if(update.data[1] == "BH")
         {
            building = GetBuilding(update.data[2]);
            if(building)
            {
               building._helpList.push(update.data[3]);
            }
            if(building)
            {
               time = building.HelpB();
            }
            if(time > 0 && GLOBAL._mode == "build")
            {
               _catchupList.push(["build",update.fbid,update.name,GLOBAL._buildingProps[building._type - 1].name,time]);
            }
         }
         if(update.data[1] == "BP")
         {
            if(GLOBAL._mode != "build")
            {
               building = BASE.addBuildingC(update.data[2]);
               building.Setup(update.data[3]);
            }
         }
         if(update.data[1] == "DBU")
         {
            BASE._damagedBaseWarnTime = update.data[0];
         }
         if(update.data[1] == "BT")
         {
            building = GetBuilding(update.data[2]);
            if(building)
            {
               building._threadid = update.data[3];
            }
            if(building)
            {
               building._subject = update.data[4];
            }
            if(building)
            {
               building._senderid = update.data[5];
            }
            if(building)
            {
               building._senderName = update.data[6];
            }
            if(building)
            {
               building._senderPic = update.data[7];
            }
         }
         if(update.data[1] == "BE")
         {
            BASE._resources.r1.Add(-update.data[3]);
            BASE._hpResources.r1 -= update.data[3];
            BASE._resources.r2.Add(-update.data[4]);
            BASE._hpResources.r2 -= update.data[4];
            BASE._resources.r3.Add(-update.data[5]);
            BASE._hpResources.r3 -= update.data[5];
            BASE._resources.r4.Add(-update.data[6]);
            BASE._hpResources.r4 -= update.data[6];
            BASE._credits.Add(-update.data[7]);
            BASE._hpCredits -= update.data[7];
         }
         if(update.data[1] == "CMR")
         {
            if(BASE.isInferno())
            {
               LOGGER.Log("log","ABORTING Champion Refund because user is in Inferno",Boolean(BASE._yardType));
               return false;
            }
            refundType = int(update.data[2]);
            refundLevel = int(update.data[3]);
            refundFeeds = int(update.data[4]);
            refundBuff = 0;
            refundID = "G" + refundType;
            refundName = CHAMPIONCAGE.GetGuardianProperty(refundID,refundLevel,"name");
            refundHealth = CHAMPIONCAGE.GetGuardianProperty(refundID,refundLevel,"health");
            refundFeedtime = GLOBAL.Timestamp();
            if(CREATURES._guardian)
            {
               MAP._BUILDINGTOPS.removeChild(CREATURES._guardian);
            }
            if(Boolean(CREATURES._guardian) && CREATURES._guardian._creatureID == refundID)
            {
               CREATURES._guardian.Clear();
            }
            else if(GLOBAL._bChamber)
            {
               if(Boolean(CREATURES._guardian) && CREATURES._guardian._creatureID != refundID)
               {
                  freezeChamp();
               }
               if(CHAMPIONCHAMBER.HasFrozen(refundType))
               {
                  thawChamp(refundType);
               }
            }
            if(CREATURES._guardian)
            {
               CREATURES._guardian._health.Set(-10);
               CREATURES._guardian.Tick(1);
               CREATURES.removeGuardianType(CREATURES._guardian._type);
            }
            if(GLOBAL._bCage)
            {
               if(refundLevel > 0)
               {
                  GLOBAL._bCage.SpawnGuardian(refundLevel,refundFeeds,refundFeedtime,refundType,refundHealth,refundName,refundBuff,0);
               }
               BASE.Save();
            }
         }
         return true;
      }
      
      public static function Catchup() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:popup_helped = null;
         var _loc9_:* = null;
         if(!GLOBAL._save)
         {
            return;
         }
         if(BASE.isInferno())
         {
            return;
         }
         if(_catchupList.length > 0)
         {
            _loc3_ = [];
            _loc4_ = [];
            _loc8_ = new popup_helped();
            _loc8_.tB.autoSize = TextFieldAutoSize.LEFT;
            _loc7_ = 0;
            _loc1_ = 0;
            while(_loc1_ < _catchupList.length)
            {
               _loc6_ = false;
               _loc2_ = 0;
               while(_loc2_ < _loc3_.length)
               {
                  if(_loc3_[_loc2_][1] == _catchupList[_loc1_][2])
                  {
                     _loc6_ = true;
                  }
                  _loc2_++;
               }
               if(!_loc6_)
               {
                  _loc3_.push([_catchupList[_loc1_][1],_catchupList[_loc1_][2]]);
               }
               _loc6_ = false;
               _loc2_ = 0;
               while(_loc2_ < _loc4_.length)
               {
                  if(_loc4_[_loc2_][1] == _catchupList[_loc1_][3])
                  {
                     _loc6_ = true;
                  }
                  _loc2_++;
               }
               if(!_loc6_)
               {
                  _loc4_.push([0,_catchupList[_loc1_][3]]);
               }
               _loc7_ += _catchupList[_loc1_][4];
               _loc1_++;
            }
            _loc9_ = KEYS.Get("pop_helped_1a");
            if(!GLOBAL._catchup)
            {
               if(_loc3_.length == 1)
               {
                  _loc9_ = " " + KEYS.Get("pop_helped_1b") + " ";
               }
               if(_loc3_.length > 1)
               {
                  _loc9_ = " " + KEYS.Get("pop_helped_1c") + " ";
               }
            }
            if(_loc3_.length == 1)
            {
               _loc8_.tA.htmlText = "<font size=\"14\"><b>" + KEYS.Get("pop_helped_title",{"v1":_loc3_[0][1]}) + "</b></font>";
               if(_loc4_.length > 1)
               {
                  _loc5_ = _loc3_[0][1] + _loc9_ + KEYS.Get("pop_helped_2a",{"v1":GLOBAL.Array2StringB(_loc4_)});
               }
               else
               {
                  _loc5_ = _loc3_[0][1] + _loc9_ + KEYS.Get("pop_helped_2b",{"v1":GLOBAL.Array2StringB(_loc4_)});
               }
               _loc5_ += ", <b>" + KEYS.Get("pop_helped_3a",{"v1":GLOBAL.ToTime(_loc7_,false,false)}) + "</b>";
               _loc8_.tB.htmlText = _loc5_;
               _loc8_.bPost.Setup(KEYS.Get("pop_helped_saythanks_btn",{"v1":_loc3_[0][1]}));
               _loc8_.bPost.addEventListener(MouseEvent.CLICK,GiveThanks(_loc3_[0][0],KEYS.Get("pop_helped_streamtitle"),KEYS.Get("pop_helped_pl_streambody",{"v1":_loc3_[0][1]}),"quests/build.v2.png"));
               _loc8_.bPost.Highlight = true;
            }
            else
            {
               _loc8_.tA.htmlText = "<font size=\"14\"><b>" + KEYS.Get("pop_helped_title_pl") + "</b></font>";
               _loc8_.tB.htmlText = KEYS.Get("pop_helped_pl_1a",{
                  "v1":GLOBAL.Array2StringB(_loc3_),
                  "v2":_loc9_,
                  "v3":GLOBAL.Array2StringB(_loc4_),
                  "v4":GLOBAL.ToTime(_loc7_,false,false)
               });
               _loc8_.bPost.SetupKey("pop_saythanks_btn");
               _loc8_.bPost.addEventListener(MouseEvent.CLICK,GiveThanks(0,KEYS.Get("pop_helped_streamtitle"),KEYS.Get("pop_helped_pl_streambody",{"v1":GLOBAL.Array2StringB(_loc3_)}),"quests/build.v2.png"));
               _loc8_.bPost.Highlight = true;
            }
            _loc8_.bPost.y = _loc8_.tB.height - 15;
            _loc8_.mcFrame.height = _loc8_.bPost.y + 110;
            (_loc8_.mcFrame as frame).Setup();
            POPUPS.Push(_loc8_,null,null,"","build.v2.png");
            _catchupList = [];
         }
      }
      
      public static function GiveThanks(param1:Number, param2:String, param3:String, param4:String) : Function
      {
         var fbid:Number = param1;
         var messageA:String = param2;
         var messageB:String = param3;
         var image:String = param4;
         return function(param1:MouseEvent):void
         {
            GLOBAL.CallJS("sendFeed",["thanks",messageA,messageB,image,fbid]);
            POPUPS.Next();
         };
      }
      
      public static function Create(param1:Array, param2:int = 0) : void
      {
         if(BASE.isInferno())
         {
            return;
         }
         var _loc3_:int = BASE._loadedBaseID;
         if(param2)
         {
            _loc3_ = param2;
         }
         CreateB(param1,_loc3_,_lastUpdateID);
      }
      
      public static function CreateB(param1:Array, param2:int, param3:Number) : void
      {
         var url:String;
         var loadVars:Array;
         var handleLoadSuccessful:Function = null;
         var handleLoadError:Function = null;
         var update:Array = param1;
         var id:int = param2;
         var lastupdate:Number = param3;
         handleLoadSuccessful = function(param1:Object):void
         {
            if(param1.error == 0)
            {
               Process(param1.updates);
            }
            else
            {
               LOGGER.Log("err","UPDATES.Create: " + JSON.encode(param1));
               GLOBAL.ErrorMessage("UPDATES.Create");
            }
         };
         handleLoadError = function(param1:IOErrorEvent):void
         {
            LOGGER.Log("err","UPDATES.Create HTTP");
         };
         if(!GLOBAL._save)
         {
            return;
         }
         if(BASE.isInferno())
         {
            return;
         }
         if(!GLOBAL._openBase && TUTORIAL._stage < 200)
         {
            return;
         }
         if(GLOBAL._mode == "build" && GLOBAL._friendCount == 0)
         {
            return;
         }
         update.splice(0,0,GLOBAL.Timestamp());
         url = GLOBAL._baseURL;
         if(GLOBAL._baseURL2)
         {
            url = GLOBAL._baseURL2;
         }
         loadVars = [["baseid",id],["data",JSON.encode([update])],["lastupdate",lastupdate]];
         new URLLoaderApi().load(url + "saveupdate",loadVars,handleLoadSuccessful,handleLoadError);
      }
      
      public static function GetBuilding(param1:int) : BFOUNDATION
      {
         var _loc2_:BFOUNDATION = null;
         for each(_loc2_ in BASE._buildingsAll)
         {
            if(_loc2_._id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

