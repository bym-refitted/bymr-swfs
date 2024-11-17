package
{
   import com.cc.utils.SecNum;
   import com.monsters.ai.*;
   import com.monsters.alliances.ALLIANCES;
   import com.monsters.display.ScrollSet;
   import com.monsters.effects.ResourceBombs;
   import com.monsters.effects.particles.ParticleText;
   import com.monsters.events.AttackEvent;
   import com.monsters.monsters.champions.KOTHChampion;
   import com.monsters.siege.SiegeWeapons;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.TextFieldAutoSize;
   import flash.utils.*;
   import gs.TweenLite;
   
   public class ATTACK
   {
      public static var _damageGrid:Object;
      
      public static var _loot:Object;
      
      public static var _hpLoot1:int;
      
      public static var _hpLoot2:int;
      
      public static var _hpLoot3:int;
      
      public static var _hpLoot4:int;
      
      public static var _log:Array;
      
      public static var _dropZone:DROPZONE;
      
      public static var _flingerCooldown:int;
      
      public static var _flingerCooling:int;
      
      public static var _flingerBucket:Object;
      
      public static var _bombSize:int;
      
      public static var _countdown:int;
      
      public static var _attackStart:int;
      
      public static var _sentOver:Boolean;
      
      public static var _flingValue:int;
      
      public static var _flingCount:int;
      
      public static var _logOpen:Boolean;
      
      public static var _shownLog:Boolean;
      
      public static var _acted:Boolean;
      
      public static var _healthOnStart:Number;
      
      public static var _healthOnComplete:Number;
      
      public static var _attackLog:popup_attack_log;
      
      public static var _shownAIPopup:Boolean;
      
      private static var _flungSpace:SecNum;
      
      public static var _deltaLoot:Object;
      
      public static var _hpDeltaLoot:Object;
      
      public static var _savedDeltaLoot:Object;
      
      public static var _taunted:Boolean = false;
      
      public static var _tauntThreshold:Number = 0.1;
      
      public static var _shownFinal:Boolean = false;
      
      public static var _creaturesFlung:SecNum = new SecNum(0);
      
      public static var _creaturesLoaded:SecNum = new SecNum(0);
      
      public function ATTACK()
      {
         super();
      }
      
      public static function Setup() : void
      {
         var _loc3_:BFOUNDATION = null;
         _flingerCooldown = 5;
         _flingerCooling = 0;
         _creaturesFlung.Set(0);
         _creaturesLoaded.Set(0);
         _flingerBucket = {};
         _flingCount = 0;
         _log = [];
         _attackStart = GLOBAL.Timestamp();
         _flungSpace = new SecNum(0);
         _loot = {
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0)
         };
         _savedDeltaLoot = {
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0)
         };
         _deltaLoot = {"dirty":false};
         _hpDeltaLoot = {"dirty":false};
         _hpLoot1 = 0;
         _hpLoot2 = 0;
         _hpLoot3 = 0;
         _hpLoot4 = 0;
         _dropZone = null;
         _sentOver = false;
         _logOpen = false;
         _shownLog = false;
         _shownAIPopup = false;
         _acted = false;
         _flingValue = 0;
         if(Boolean(GLOBAL._attackersCatapult) && (GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack"))
         {
            ResourceBombs.Setup();
         }
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         for each(_loc3_ in BASE._buildingsMain)
         {
            _loc1_ += _loc3_._hp;
            _loc2_ += _loc3_._hpMax;
         }
         _healthOnStart = _loc1_ / _loc2_;
      }
      
      public static function Tick() : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:SecNum = null;
         var _loc9_:Boolean = false;
         var _loc10_:BFOUNDATION = null;
         var _loc11_:SecNum = null;
         var _loc12_:SecNum = null;
         if(_flingerCooling > 0)
         {
            --_flingerCooling;
         }
         --_countdown;
         if(_countdown == -120)
         {
            RetreatAll();
         }
         var _loc1_:* = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < GLOBAL._playerGuardianData.length)
         {
            if(Boolean(GLOBAL._playerGuardianData[_loc3_]) && GLOBAL._playerGuardianData[_loc3_].hp.Get() > 0)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         if(GLOBAL._advancedMap)
         {
            for each(_loc11_ in GLOBAL._attackerMapCreatures)
            {
               _loc2_ += _loc11_.Get();
            }
         }
         else
         {
            for each(_loc12_ in GLOBAL._attackerCreatures)
            {
               _loc2_ += _loc12_.Get();
            }
         }
         _loc4_ = false;
         for each(_loc5_ in ResourceBombs._bombs)
         {
            if(_loc5_.catapultLevel <= GLOBAL._attackersCatapult)
            {
               if(_loc5_.resource == 3)
               {
                  if(!_loc5_.used && _loc2_ > 0)
                  {
                     _loc4_ = true;
                  }
               }
               else if(!_loc5_.used)
               {
                  _loc4_ = true;
               }
            }
         }
         _loc6_ = 0;
         for(_loc7_ in ResourceBombs._activeBombs)
         {
            _loc6_++;
         }
         _loc4_ ||= _loc6_ > 0;
         for each(_loc8_ in _flingerBucket)
         {
            _loc2_ += _loc8_.Get();
         }
         _loc1_ = _loc2_ > 0;
         _loc9_ = false;
         for each(_loc10_ in BASE._buildingsAll)
         {
            if(_loc10_._class != "wall" && _loc10_._class != "trap" && _loc10_._class != "enemy" && _loc10_._class != "decoration" && _loc10_._class != "cage" && _loc10_._hp.Get() > 0)
            {
               _loc9_ = true;
               break;
            }
         }
         if(!_sentOver && (!_loc9_ || !CREEPS._creepCount))
         {
            if(_countdown < 0 || !_loc9_ || !_loc1_ && !_loc4_)
            {
               _sentOver = true;
               if(BASE._saveOver != 1)
               {
                  BASE.Save(1,false,true);
               }
               TweenLite.to(new Sprite(),2,{
                  "x":1,
                  "onComplete":End
               });
            }
         }
      }
      
      public static function ShowLog(param1:int = 0) : void
      {
         var onActionDown:Function;
         var b:BFOUNDATION = null;
         var logLength:int = 0;
         var i:String = null;
         var str:String = null;
         var ss:ScrollSet = null;
         var delay:int = param1;
         var shouldShowTaunt:Boolean = BASE._isProtected > 0;
         for each(b in BASE._buildingsMain)
         {
            if(b._type == 14 && b._hp.Get() == 0)
            {
               shouldShowTaunt = true;
            }
         }
         _shownLog = false;
         if(!_logOpen && GLOBAL._mode == "attack")
         {
            _logOpen = true;
            _shownLog = true;
            logLength = 0;
            for(i in _log)
            {
               logLength++;
            }
            if(logLength > 0)
            {
               onActionDown = function(param1:MouseEvent):void
               {
                  if(param1.target.label == "Next" || param1.target.labelKey == "btn_returnhome" || param1.target.labelKey == "btn_skip")
                  {
                     _logOpen = false;
                     _attackLog.parent.removeChild(_attackLog);
                     EndB();
                  }
                  if(param1.target.labelKey == "btn_talktrash")
                  {
                     ShowTaunt();
                  }
               };
               _attackLog = new popup_attack_log();
               _attackLog.Resize = function():void
               {
                  _attackLog.x = 0;
                  _attackLog.y = 0;
               };
               (_attackLog.mcFrame as frame).Setup(false);
               _attackLog.title_txt.htmlText = "<b>" + KEYS.Get("attack_log_title") + "</b>";
               GLOBAL._layerMessages.addChild(_attackLog);
               if(shouldShowTaunt && !ATTACK._taunted && MAPROOM._visitingFriend)
               {
                  _attackLog.bAction.SetupKey("btn_talktrash");
                  _attackLog.bAction.addEventListener(MouseEvent.CLICK,onActionDown);
                  _attackLog.bAction.Highlight = true;
                  if(GLOBAL._advancedMap)
                  {
                     _attackLog.b2.Setup(KEYS.Get("btn_next"));
                  }
                  else
                  {
                     _attackLog.b2.SetupKey("btn_returnhome");
                  }
                  _attackLog.b2.addEventListener(MouseEvent.CLICK,onActionDown);
               }
               else
               {
                  _attackLog.removeChild(_attackLog.b2);
                  _attackLog.bAction.Highlight = false;
                  if(GLOBAL._advancedMap)
                  {
                     _attackLog.bAction.Setup(KEYS.Get("btn_next"));
                  }
                  else
                  {
                     _attackLog.bAction.SetupKey("btn_returnhome");
                  }
                  _attackLog.bAction.addEventListener(MouseEvent.CLICK,onActionDown);
               }
               str = LogRead();
               str += "<br><br>";
               _attackLog.shell.body_txt.htmlText = str;
               _attackLog.shell.body_txt.autoSize = TextFieldAutoSize.LEFT;
               ss = new ScrollSet();
               _attackLog.addChild(ss);
               ss.x = 613;
               ss.y = 115;
               ss.Init(_attackLog.shell,_attackLog.maskMC,0,_attackLog.maskMC.y,270);
               _attackLog.shell.mask = _attackLog.maskMC;
            }
            else
            {
               EndB();
            }
         }
         else
         {
            EndB();
         }
      }
      
      public static function ShowTaunt(param1:MouseEvent = null) : void
      {
         var taunt:popup_taunt_friend = null;
         var i:int = 0;
         var imgNumber:int = 0;
         var onClose:Function = null;
         var onShare:Function = null;
         var e:MouseEvent = param1;
         var Switch:Function = function(param1:int):Function
         {
            var n:int = param1;
            return function(param1:MouseEvent = null):void
            {
               SwitchB(n);
            };
         };
         var SwitchB:Function = function(param1:int):void
         {
            imgNumber = param1;
            i = 1;
            while(i < 4)
            {
               taunt["mcIcon" + i].alpha = 0.4;
               ++i;
            }
            taunt["mcIcon" + param1].alpha = 1;
         };
         onClose = function(param1:MouseEvent = null):void
         {
            if(taunt.parent)
            {
               taunt.parent.removeChild(taunt);
            }
            End();
         };
         onShare = function(param1:MouseEvent):void
         {
            ATTACK._taunted = true;
            GLOBAL.CallJS("sendFeed",["taunt",KEYS.Get("attack_taunt_streamtitle"),KEYS.Get("attack_taunt_streambody"),"taunt" + imgNumber + ".png",BASE._loadedFBID]);
            onClose();
         };
         try
         {
            _attackLog.parent.removeChild(_attackLog);
         }
         catch(e:Error)
         {
         }
         taunt = new popup_taunt_friend();
         taunt.tTitle.htmlText = KEYS.Get("popup_title_tauntfriend");
         taunt.Resize = function():void
         {
            taunt.x = 0;
            taunt.y = 0;
         };
         taunt.bShare.SetupKey("btn_talktrash");
         GLOBAL._layerMessages.addChild(taunt);
         taunt.bShare.addEventListener(MouseEvent.CLICK,onShare);
         taunt.bShare.Highlight = true;
         (taunt.mcFrame as frame).Setup(true,onClose);
         i = 1;
         while(i < 4)
         {
            taunt["mcIcon" + i].buttonMode = true;
            taunt["mcIcon" + i].gotoAndStop(i);
            taunt["mcIcon" + i].addEventListener(MouseEvent.CLICK,Switch(i));
            i++;
         }
         SwitchB(1);
      }
      
      public static function DropZone(param1:int, param2:int = 1) : void
      {
         if(!_dropZone)
         {
            _dropZone = MAP._BUILDINGBASES.addChild(new DROPZONE(param1,param2)) as DROPZONE;
         }
         else
         {
            _dropZone.Update(param1,param2);
         }
      }
      
      public static function Log(param1:String, param2:String) : void
      {
         _acted = true;
         var _loc3_:int = 0;
         while(_loc3_ < _log.length)
         {
            if(_log[_loc3_].id == param1)
            {
               _log[_loc3_].event = param2;
               _log[_loc3_].time = int(GLOBAL.Timestamp() - _attackStart);
               return;
            }
            _loc3_++;
         }
         _log.push({
            "id":param1,
            "time":GLOBAL.Timestamp() - _attackStart,
            "event":param2
         });
      }
      
      public static function LogRead() : String
      {
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc1_:* = "";
         if(_log.length > 0)
         {
            _loc1_ = "<ul>";
            _log.sortOn("time",Array.NUMERIC);
            _loc5_ = 0;
            while(_loc5_ < _log.length)
            {
               _loc1_ += "<li><font color=\"#999999\">" + GLOBAL.ToTime(_log[_loc5_].time,true) + "</font>: " + _log[_loc5_].event + "</li>";
               _loc5_++;
            }
            _loc1_ += "</ul>";
            if(ATTACK._loot.r1.Get() + ATTACK._loot.r2.Get() + ATTACK._loot.r3.Get() + ATTACK._loot.r4.Get() > 0)
            {
               _loc1_ += "<br>" + KEYS.Get("attack_log_resourceslooted") + ":<br>";
               _loc6_ = [];
               if(ATTACK._loot.r1.Get() > 0)
               {
                  _loc6_.push([ATTACK._loot.r1.Get(),KEYS.Get(GLOBAL._resourceNames[0])]);
               }
               if(ATTACK._loot.r2.Get() > 0)
               {
                  _loc6_.push([ATTACK._loot.r2.Get(),KEYS.Get(GLOBAL._resourceNames[1])]);
               }
               if(ATTACK._loot.r3.Get() > 0)
               {
                  _loc6_.push([ATTACK._loot.r3.Get(),KEYS.Get(GLOBAL._resourceNames[2])]);
               }
               if(ATTACK._loot.r4.Get() > 0)
               {
                  _loc6_.push([ATTACK._loot.r4.Get(),KEYS.Get(GLOBAL._resourceNames[3])]);
               }
               _loc1_ += GLOBAL.Array2String(_loc6_);
            }
         }
         return _loc1_;
      }
      
      public static function RemoveDropZone() : void
      {
         if(_dropZone)
         {
            _dropZone.Destroy();
            MAP._BUILDINGBASES.removeChild(_dropZone);
         }
         _dropZone = null;
      }
      
      public static function Spawn(param1:Point, param2:int) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Point = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         var _loc14_:* = undefined;
         var _loc6_:Array = [];
         for(_loc8_ in _flingerBucket)
         {
            if(_flingerBucket[_loc8_].Get() > 0)
            {
               _loc9_ = false;
               if(_loc8_.substr(0,1) == "G")
               {
                  _loc10_ = GLOBAL.getPlayerGuardianIndex(int(_loc8_.substr(1)));
                  _loc11_ = int(GLOBAL._playerGuardianData[_loc10_].l.Get());
                  _loc3_ = Math.random() * 360 * 0.0174532925;
                  _loc4_ = Math.random() * param2 / 2;
                  _loc5_ = param1.add(new Point(Math.sin(_loc3_) * _loc4_,Math.cos(_loc3_) * _loc4_));
                  CREEPS.SpawnGuardian(GLOBAL._playerGuardianData[_loc10_].t,MAP._BUILDINGTOPS,"bounce",_loc11_,_loc5_,Math.random() * 360,GLOBAL._playerGuardianData[_loc10_].hp.Get(),GLOBAL._playerGuardianData[_loc10_].fb.Get(),GLOBAL._playerGuardianData[_loc10_].pl.Get());
                  _flungSpace.Add(CHAMPIONCAGE.GetGuardianProperty(_loc8_,_loc11_,"bucket"));
                  _loc12_ = "Level " + GLOBAL._playerGuardianData[_loc10_].l.Get() + " " + CHAMPIONCAGE._guardians["G" + GLOBAL._playerGuardianData[_loc10_].t].name;
                  _loc6_.push([1,_loc12_]);
                  if(CREEPS._flungGuardian)
                  {
                     if(CREEPS._flungGuardian.length != GLOBAL._playerGuardianData.length)
                     {
                        CREEPS._flungGuardian = new Vector.<Boolean>(GLOBAL._playerGuardianData.length);
                     }
                     if(_loc10_ < CREEPS._flungGuardian.length)
                     {
                        CREEPS._flungGuardian[_loc10_] = true;
                     }
                  }
               }
               else
               {
                  _flungSpace.Add(CREATURES.GetProperty(_loc8_,"cStorage") * _flingerBucket[_loc8_].Get());
                  _loc7_ = KEYS.Get(CREATURELOCKER._creatures[_loc8_].name);
                  _loc6_.push([_flingerBucket[_loc8_].Get(),_loc7_]);
                  _loc13_ = 0;
                  while(_loc13_ < _flingerBucket[_loc8_].Get())
                  {
                     _loc3_ = Math.random() * 360 * 0.0174532925;
                     _loc4_ = Math.random() * param2 / 2;
                     _loc5_ = param1.add(new Point(Math.sin(_loc3_) * _loc4_,Math.cos(_loc3_) * _loc4_));
                     _loc14_ = CREEPS.Spawn(_loc8_,MAP._BUILDINGTOPS,"bounce",_loc5_,Math.random() * 360);
                     _loc14_._hitLimit = int.MAX_VALUE;
                     _loc13_++;
                  }
                  if(ALLIANCES._myAlliance)
                  {
                     LOGGER.Stat([28,_loc8_,_flingerBucket[_loc8_].Get(),ALLIANCES._allianceID]);
                  }
                  else
                  {
                     LOGGER.Stat([28,_loc8_,_flingerBucket[_loc8_].Get()]);
                  }
                  _flingValue += CREATURES.GetProperty(_loc8_,"cResource");
               }
            }
         }
         _creaturesFlung.Add(_creaturesLoaded.Get());
         _creaturesLoaded.Set(0);
         if(_loc6_.length == 1 && _loc6_[0][0] == 1)
         {
            Log("fling" + _flingCount,"<font color=\"#0000FF\">" + KEYS.Get("attack_log_flungin",{"v1":GLOBAL.Array2String(_loc6_)}) + "</font>");
         }
         else
         {
            Log("fling" + _flingCount,"<font color=\"#0000FF\">" + KEYS.Get("attack_log_flungin_pl",{"v1":GLOBAL.Array2String(_loc6_)}) + "</font>");
         }
         ++_flingCount;
         ATTACK._flingerBucket = {};
         _flingerCooling = _flingerCooldown;
         UI2.Update();
         if(BASE._saveOver != 1)
         {
            BASE.Save(0,false,true);
         }
         RemoveDropZone();
      }
      
      public static function BucketAdd(param1:String) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(GLOBAL._buildingProps[4].capacity[GLOBAL._attackersFlinger - 1]);
         if(MAPROOM_DESCENT.InDescent)
         {
            _loc2_ = int(YARD_PROPS._yardProps[4].capacity[GLOBAL._attackersFlinger - 1]);
         }
         if(POWERUPS.CheckPowers(POWERUPS.ALLIANCE_DECLAREWAR,"OFFENSE"))
         {
            _loc2_ += Math.floor(_loc2_ * 0.25);
         }
         if(param1.substr(0,1) == "G")
         {
            _loc4_ = GLOBAL.getPlayerGuardianIndex(int(param1.substr(1)));
            _loc2_ -= CHAMPIONCAGE.GetGuardianProperty(param1.substr(0,2),GLOBAL._playerGuardianData[_loc4_].l.Get(),"bucket");
            ATTACK._flingerBucket[param1] = new SecNum(1);
            _creaturesLoaded.Add(1);
            SOUNDS.Play("click1");
         }
         else if(GLOBAL._advancedMap)
         {
            if(GLOBAL._attackerMapCreatures[param1].Get() > 0)
            {
               for(_loc3_ in _flingerBucket)
               {
                  _loc2_ -= CREATURES.GetProperty(_loc3_,"bucket") * ATTACK._flingerBucket[_loc3_].Get();
               }
               if(_loc2_ >= CREATURES.GetProperty(param1,"bucket"))
               {
                  GLOBAL._attackerMapCreatures[param1].Add(-1);
                  _creaturesLoaded.Add(1);
                  if(!ATTACK._flingerBucket[param1])
                  {
                     ATTACK._flingerBucket[param1] = new SecNum(0);
                  }
                  ATTACK._flingerBucket[param1].Add(1);
                  SOUNDS.Play("click1");
               }
            }
         }
         else if(GLOBAL._attackerCreatures[param1].Get() > 0)
         {
            for(_loc3_ in _flingerBucket)
            {
               _loc2_ -= CREATURES.GetProperty(_loc3_,"bucket") * ATTACK._flingerBucket[_loc3_].Get();
            }
            if(_loc2_ >= CREATURES.GetProperty(param1,"bucket"))
            {
               GLOBAL._attackerCreatures[param1].Add(-1);
               _creaturesLoaded.Add(1);
               if(!ATTACK._flingerBucket[param1])
               {
                  ATTACK._flingerBucket[param1] = new SecNum(0);
               }
               ATTACK._flingerBucket[param1].Add(1);
               SOUNDS.Play("click1");
            }
         }
         return false;
      }
      
      public static function BucketRemove(param1:String) : Boolean
      {
         if(Boolean(ATTACK._flingerBucket[param1]) && ATTACK._flingerBucket[param1].Get() > 0)
         {
            ATTACK._flingerBucket[param1].Add(-1);
            if(param1.substr(0,1) == "G")
            {
               delete ATTACK._flingerBucket[param1];
            }
            else if(GLOBAL._advancedMap)
            {
               GLOBAL._attackerMapCreatures[param1].Add(1);
               _creaturesLoaded.Add(-1);
            }
            else
            {
               GLOBAL._attackerCreatures[param1].Add(1);
               _creaturesLoaded.Add(-1);
            }
            SOUNDS.Play("click1");
            return true;
         }
         return false;
      }
      
      public static function BucketUpdate() : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         for(_loc2_ in _flingerBucket)
         {
            if(_loc2_.substr(0,1) == "G")
            {
               _loc3_ = 0;
               while(_loc3_ < GLOBAL._playerGuardianData.length)
               {
                  if(_loc2_.substr(1) == GLOBAL._playerGuardianData[_loc3_].t)
                  {
                     break;
                  }
                  _loc3_++;
               }
               _loc1_ += CHAMPIONCAGE.GetGuardianProperty(_loc2_.substr(0,2),GLOBAL._playerGuardianData[_loc3_].l.Get(),"bucket");
            }
            else
            {
               _loc1_ += CREATURES.GetProperty(_loc2_,"bucket") * ATTACK._flingerBucket[_loc2_].Get();
            }
         }
         ResourceBombs.BombRemove();
         if(Boolean(UI2._top) && Boolean(UI2._top._siegeweapon))
         {
            UI2._top._siegeweapon.Cancel();
         }
         if(_loc1_ == 0)
         {
            RemoveDropZone();
         }
         else
         {
            _loc1_ /= 4;
            if(_loc1_ < 200)
            {
               _loc1_ = 200;
            }
            DropZone(_loc1_,1);
         }
         UI2.Update();
      }
      
      public static function Loot(param1:int, param2:int, param3:int, param4:int, param5:int = 10, param6:BFOUNDATION = null, param7:Boolean = false) : int
      {
         if(LOGIN._playerLevel < 20)
         {
            param2 += param2 * Math.max(0,(20 - LOGIN._playerLevel) * 0.03);
         }
         _loot["r" + param1].Add(param2);
         switch(param1)
         {
            case 1:
               _hpLoot1 += param2;
               break;
            case 2:
               _hpLoot2 += param2;
               break;
            case 3:
               _hpLoot3 += param2;
               break;
            case 4:
               _hpLoot4 += param2;
         }
         var _loc8_:Number = param2;
         var _loc9_:Number = Number(GLOBAL._resources["r" + param1 + "max"]);
         var _loc10_:Number = Number(GLOBAL._resources["r" + param1].Get());
         var _loc11_:KOTHChampion = CREEPS.krallen;
         if(_loc11_)
         {
            _loc9_ += _loc9_ * _loc11_._buff;
         }
         if(_loc10_ + param2 > _loc9_)
         {
            if(BASE.isInferno() && MAPROOM_DESCENT.DescentPassed || GLOBAL._mode == GLOBAL._loadmode)
            {
               _loc8_ = _loc9_ - _loc10_;
               if(_loc8_ < 0)
               {
                  _loc8_ = 0;
               }
            }
         }
         GLOBAL._resources["r" + param1].Add(_loc8_);
         GLOBAL._hpResources["r" + param1] += _loc8_;
         if(_deltaLoot["r" + param1])
         {
            _deltaLoot["r" + param1].Add(_loc8_);
            _hpDeltaLoot["r" + param1] += _loc8_;
         }
         else
         {
            _deltaLoot["r" + param1] = new SecNum(_loc8_);
            _hpDeltaLoot["r" + param1] = _loc8_;
         }
         _deltaLoot.dirty = true;
         _hpDeltaLoot.dirty = true;
         if(GLOBAL._render && Boolean(param6))
         {
            if(BASE.isInferno())
            {
               param1 += 4;
            }
            if(param7)
            {
               new ParticleVacuumLoot(param6,param2,param1);
            }
            else
            {
               new ParticleLoot(param6,param2,param1);
            }
            ParticleText.Create(new Point(param3,param4),param2,param1);
         }
         return param2;
      }
      
      public static function SaveDeltaLoot() : void
      {
         var _loc1_:int = 0;
         if(_deltaLoot.dirty)
         {
            _loc1_ = 1;
            while(_loc1_ < 5)
            {
               if(_deltaLoot["r" + _loc1_])
               {
                  if(_savedDeltaLoot["r" + _loc1_])
                  {
                     _savedDeltaLoot["r" + _loc1_].Add(_deltaLoot["r" + _loc1_].Get());
                  }
                  else
                  {
                     _savedDeltaLoot["r" + _loc1_] = new SecNum(_deltaLoot["r" + _loc1_].Get());
                  }
                  if(_deltaLoot["r" + _loc1_].Get() != _hpDeltaLoot["r" + _loc1_])
                  {
                     LOGGER.Log("log","ATTACK.SaveDeltaLoot delta loot mismatch secure " + _deltaLoot.Get() + " unsecure " + _hpDeltaLoot[_loc1_]);
                     GLOBAL.ErrorMessage("ATTACK.SaveDeltaLoot");
                  }
               }
               _loc1_++;
            }
         }
         _deltaLoot = {"dirty":false};
         _hpDeltaLoot = {"dirty":false};
      }
      
      public static function CleanLoot() : void
      {
         _savedDeltaLoot = {
            "r1":new SecNum(0),
            "r2":new SecNum(0),
            "r3":new SecNum(0),
            "r4":new SecNum(0)
         };
      }
      
      public static function Miss(param1:Number, param2:Number) : void
      {
      }
      
      public static function Damage(param1:Number, param2:Number, param3:int, param4:Boolean = true, param5:Boolean = false) : void
      {
         if(param3 == 0)
         {
            param4 = false;
         }
         var _loc6_:uint = ParticleText.TYPE_DAMAGE;
         if(param5)
         {
            _loc6_ = ParticleText.TYPE_THORN;
         }
         else if(param3 < 0)
         {
            _loc6_ = ParticleText.TYPE_HEAL;
         }
         if(param4)
         {
            ParticleText.Create(new Point(param1,param2),param3,_loc6_);
         }
      }
      
      public static function ProcessDamageGrid() : void
      {
      }
      
      public static function RetreatAll() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in CREEPS._creeps)
         {
            _loc1_.ModeRetreat();
         }
         if(BASE._saveOver != 1)
         {
            BASE.Save(1,false,true);
         }
         GLOBAL.Message(KEYS.Get("attack_msg_attackover"));
      }
      
      private static function BucketClear() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         for(_loc1_ in _flingerBucket)
         {
            _loc2_ = int(_flingerBucket[_loc1_].Get());
            _loc3_ = 0;
            while(_loc3_ <= _loc2_)
            {
               BucketRemove(_loc1_);
               _loc3_++;
            }
         }
         BucketUpdate();
      }
      
      public static function End() : void
      {
         var _loc1_:* = undefined;
         BucketClear();
         if(!_sentOver)
         {
            if(BASE._saveOver != 1)
            {
               BASE.Save(1,false,true);
            }
            _sentOver = true;
         }
         if(GLOBAL._mode == "attack" || GLOBAL._mode == "iattack")
         {
            if(Boolean(CREEPS._guardian) && CREEPS._guardian._health.Get() > 0)
            {
               LOGGER.Stat([53,CREEPS._guardian._creatureID,1]);
            }
            if(Boolean(CREATURES._guardian) && CREATURES._guardian._health.Get() > 0)
            {
               LOGGER.Stat([55,CREATURES._guardian._creatureID,1]);
            }
         }
         for each(_loc1_ in CREEPS._creeps)
         {
            _loc1_.ModeRetreat();
         }
         SiegeWeapons.deactivateWeapon();
         if(GLOBAL._mode == "attack" || GLOBAL._mode == "iattack")
         {
            _logOpen = false;
            ShowLog();
            _shownFinal = false;
         }
         else if(Boolean(MAPROOM_DESCENT.DescentLevel) && MAPROOM_DESCENT.InDescent)
         {
            ShowComplete();
         }
         else
         {
            EndB();
         }
         var _loc2_:Number = _loot.r1.Get() + _loot.r2.Get() + _loot.r3.Get() + _loot.r4.Get();
         LOGGER.KongStat([3,_loc2_]);
      }
      
      public static function ShowComplete() : void
      {
         EndB();
      }
      
      public static function EndB() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:BFOUNDATION = null;
         var _loc7_:BFOUNDATION = null;
         var _loc8_:popup_attackend = null;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         _shownFinal = true;
         if(GLOBAL._advancedMap)
         {
            for(_loc5_ in BASE._buildingsAll)
            {
               _loc6_ = BASE._buildingsAll[_loc5_];
               if(!(_loc6_._class == "trap" && _loc6_._class == "enemy" && _loc6_._fired || _loc6_._type == 53 && _loc6_._expireTime < GLOBAL.Timestamp()))
               {
                  if(_loc6_._class != "wall")
                  {
                     _loc3_ += _loc6_._hp.Get();
                     _loc4_ += _loc6_._hpMax.Get();
                  }
               }
            }
            _loc2_ = 100 - 100 / _loc4_ * _loc3_;
            if((BASE._yardType == BASE.OUTPOST || GLOBAL._loadmode == "wmattack") && _loc2_ >= 90)
            {
               _loc1_ = true;
               if(GLOBAL._mode == "wmattack")
               {
                  WMBASE._destroyed = true;
               }
            }
            else if((BASE._yardType == BASE.INFERNO_YARD || GLOBAL._loadmode == "iwmattack") && _loc2_ >= 90)
            {
               _loc1_ = true;
               if(GLOBAL._loadmode == "iwmattack")
               {
                  WMBASE._destroyed = true;
               }
            }
         }
         else if(GLOBAL._mode == "wmattack" || GLOBAL._mode == "iwmattack")
         {
            for each(_loc7_ in BASE._buildingsMain)
            {
               if(_loc7_._hp.Get() == 0 && _loc7_._repairing == 0 && _loc7_._type == 14 && (GLOBAL._mode == "wmattack" || GLOBAL._mode == "iwmattack"))
               {
                  if(TRIBES.TribeForBaseID(BASE._wmID).id == 2)
                  {
                     ACHIEVEMENTS.Check("wm2hall",1);
                  }
                  _loc1_ = true;
                  break;
               }
            }
            if(INFERNO_DESCENT_POPUPS.isInDescent())
            {
               INFERNO_DESCENT_POPUPS.ShowPostAttackPopup(MAPROOM_DESCENT._descentLvl,_loc1_,Vector.<uint>([_loot.r1.Get(),_loot.r2.Get(),_loot.r3.Get(),_loot.r4.Get()]),Vector.<uint>([MAPROOM_DESCENT._loot.r1.Get(),MAPROOM_DESCENT._loot.r2.Get(),MAPROOM_DESCENT._loot.r3.Get(),MAPROOM_DESCENT._loot.r4.Get()]));
               ACHIEVEMENTS.Check(ACHIEVEMENTS.DESCENT_LEVEL,MAPROOM_DESCENT.DescentLevel);
            }
         }
         if(BASE.isInferno())
         {
            SOUNDS.PlayMusic("musicibuild");
         }
         else
         {
            SOUNDS.PlayMusic("musicbuild");
         }
         GLOBAL.eventDispatcher.dispatchEvent(new AttackEvent(AttackEvent.ATTACK_OVER,_loc1_,BASE._wmID,_loot));
         if(GLOBAL._advancedMap && BASE._yardType == BASE.OUTPOST || (GLOBAL._mode == "wmattack" || GLOBAL._mode == "iwmattack"))
         {
            _loc8_ = new popup_attackend(_loc1_);
            _loc8_.mcFrame.Setup(false);
            POPUPS.Push(_loc8_);
            if(Boolean(GLOBAL._advancedMap) && !GLOBAL.m_mapRoomFunctional)
            {
               GLOBAL.Message(KEYS.Get("map_msg_damaged"));
            }
         }
         else if(GLOBAL._advancedMap)
         {
            GLOBAL.ShowMap();
         }
         else if(GLOBAL._loadmode == GLOBAL._mode)
         {
            BASE.LoadBase(null,0,0,"build",false,BASE.MAIN_YARD);
         }
         else if(MAPROOM_DESCENT.InDescent)
         {
            BASE.LoadBase(null,0,0,"build",false,BASE.MAIN_YARD);
         }
         else
         {
            BASE.LoadBase(GLOBAL._infBaseURL,0,0,"ibuild",false,BASE.INFERNO_YARD);
         }
      }
      
      public static function WellDefended(param1:Boolean = true, param2:String = "") : void
      {
         var Post:Function = null;
         var popupMC:popup_defense = null;
         var tribe:Object = null;
         var wildMonsters:Boolean = param1;
         var attackersName:String = param2;
         Post = function():void
         {
            if(wildMonsters)
            {
               GLOBAL.CallJS("sendFeed",["defense-wild",KEYS.Get("ai_gooddefense_streamtitle",{"v1":tribe.name}),KEYS.Get("ai_gooddefense",{"v1":tribe.name}),tribe.streampostpic]);
            }
            else
            {
               GLOBAL.CallJS("sendFeed",["defense-human",KEYS.Get("attack_gooddefense_streamtitle",{"v1":attackersName}),KEYS.Get("attack_gooddefense_streambody"),"defense2.png"]);
            }
            POPUPS.Next();
         };
         if(INFERNO_EMERGENCE_EVENT.isAttackActive)
         {
            INFERNO_EMERGENCE_POPUPS.ShowStagePassed(INFERNOPORTAL.building._lvl.Get());
            return;
         }
         popupMC = new popup_defense();
         tribe = TRIBES.TribeForBaseID(WMATTACK._attackersBaseID);
         if(wildMonsters)
         {
            popupMC.tText.htmlText = "<b>" + KEYS.Get("ai_gooddefense",{"v1":tribe.name}) + "</b>";
         }
         else
         {
            popupMC.tText.htmlText = "<b>" + KEYS.Get("attack_gooddefense",{"v1":attackersName}) + "</b>";
         }
         popupMC.bAction.SetupKey("btn_brag");
         popupMC.bAction.addEventListener(MouseEvent.CLICK,Post);
         popupMC.bAction.Highlight = true;
         if(wildMonsters)
         {
            POPUPS.Push(popupMC,null,null,null,tribe.splash.split("popups/").join(""));
         }
         else
         {
            POPUPS.Push(popupMC,null,null,null,"defense2.png");
         }
      }
      
      public static function PoorDefense() : void
      {
         var mc:popup_damaged_ai = null;
         var RepairAll:Function = null;
         var RepairNow:Function = null;
         if(INFERNO_EMERGENCE_EVENT.isAttackActive)
         {
            INFERNO_EMERGENCE_POPUPS.ShowStagePassed(INFERNOPORTAL.building._lvl.Get());
            return;
         }
         if(TUTORIAL._stage > 40)
         {
            RepairAll = function(param1:MouseEvent = null):void
            {
               var _loc2_:BFOUNDATION = null;
               mc.bAction.removeEventListener(MouseEvent.CLICK,RepairAll);
               mc.bAction2.removeEventListener(MouseEvent.CLICK,RepairNow);
               for each(_loc2_ in BASE._buildingsAll)
               {
                  if(_loc2_._hp.Get() < _loc2_._hpMax.Get() && _loc2_._repairing == 0)
                  {
                     _loc2_.Repair();
                  }
               }
               SOUNDS.Play("repair1",0.25);
               POPUPS.Next();
            };
            RepairNow = function(param1:MouseEvent = null):void
            {
               var _loc2_:BFOUNDATION = null;
               mc.bAction.removeEventListener(MouseEvent.CLICK,RepairAll);
               mc.bAction2.removeEventListener(MouseEvent.CLICK,RepairNow);
               for each(_loc2_ in BASE._buildingsAll)
               {
                  if(_loc2_._hp.Get() < _loc2_._hpMax.Get() && _loc2_._repairing == 0)
                  {
                     _loc2_.Repair();
                  }
               }
               STORE.ShowB(3,1,["FIX"],true);
               POPUPS.Next();
            };
            mc = new popup_damaged_ai();
            (mc.mcFrame as frame).Setup(false);
            mc.tA.htmlText = "<b>" + KEYS.Get("ai_poordefense_ta") + "</b>";
            mc.tB.htmlText = "<b>" + KEYS.Get("ai_poordefense_tb") + "</b>";
            mc.tC.htmlText = KEYS.Get("ai_poordefense_tc");
            mc.bAction.SetupKey("ai_repairdamage_btn");
            mc.bAction.addEventListener(MouseEvent.CLICK,RepairAll);
            mc.bAction2.SetupKey("pop_damaged_repairnow_btn");
            mc.bAction2.addEventListener(MouseEvent.CLICK,RepairNow);
            mc.bAction2.Highlight = true;
            POPUPS.Push(mc,null,null,"shotgun","military.png");
         }
      }
   }
}

