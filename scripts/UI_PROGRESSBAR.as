package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import gs.TweenLite;
   
   public class UI_PROGRESSBAR extends MovieClip
   {
      private static var _do:DisplayObject;
      
      public static var _mc:MovieClip;
      
      public static var _mousebox:MovieClip;
      
      private static var _popupdo:DisplayObject;
      
      private static var _popupID:int;
      
      private static var _maxWorkers:int;
      
      private static var _maxBuildings:int;
      
      public static var _popupTarget:MovieClip;
      
      public static var _noticeShowWorker:Object;
      
      private static var _workers:Array = [];
      
      private static var _tmpWorkers:Array = [];
      
      private static var _buildings:Array = [];
      
      private static var _buildingtype:Array = [];
      
      private static var _typeClickCounter:int = 0;
      
      private static var _buildingslots:Array = [];
      
      private static var _popupkill:Array = [];
      
      private static var _layoutOrigin:Point = new Point(0,0);
      
      private static var _layoutCellWidth:int = 50;
      
      private static var _layoutCellHeight:int = 36;
      
      private static var _layoutRowSpacing:int = 5;
      
      private static var _layoutColumnSpacing:int = 3;
      
      public static var _popupOn:Boolean = false;
      
      public static var _academies:Array = [];
      
      public static var _lockers:Array = [];
      
      public static var _hatcheries:Array = [];
      
      public static var _HCC:Array = [];
      
      public static var _hasHCC:Boolean = false;
      
      public static var _hatcheryFull:Boolean = false;
      
      public static var _PROGRESSQUEUE:Array = [];
      
      public static var _runOnce:Boolean = true;
      
      public static var _loaded:Boolean = false;
      
      public static var _startDelay:Number = 10;
      
      public static var _startMarker:Number = GLOBAL.Timestamp();
      
      public static var _startNotice:Boolean = true;
      
      public static var _noticeDelay:Number = 6;
      
      public static var _noticeMarker:Number = GLOBAL.Timestamp();
      
      public static var _noticeShow:Boolean = false;
      
      public static var _noticeComplete:Boolean = false;
      
      private static var _mouseboxOver:Boolean = false;
      
      public static var _slotsState:String = "CLOSE";
      
      public static var _slotsOpenWidth:int = 230;
      
      public static var _slotsCloseWidth:int = 50;
      
      public function UI_PROGRESSBAR()
      {
         super();
      }
      
      public static function Setup() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:UI_SIDEBAR_SLOT = null;
         if(Boolean(_do) && Boolean(_do.parent))
         {
            _do.parent.removeChild(_do);
            _do = null;
         }
         if(GLOBAL._mode == "build")
         {
            _mc = new MovieClip();
            _mousebox = new MovieClip();
            _mousebox.graphics.beginFill(0xff0000);
            _mousebox.graphics.drawRect(0,0,_slotsCloseWidth,_slotsCloseWidth);
            _mousebox.graphics.endFill();
            _mousebox.alpha = 0;
            _mousebox.x = -_mousebox.width;
            _mousebox.y = _mc.y;
            _mousebox.mouseEnabled = false;
            _mousebox.mouseChildren = false;
            _mc.mouseEnabled = false;
            _mc.addChild(_mousebox);
            _workers = [];
            _buildings = [];
            _hatcheries = [];
            _lockers = [];
            _academies = [];
            _buildingtype = [];
            _buildingtype.push(_hatcheries);
            _buildingtype.push(_lockers);
            _buildingtype.push(_academies);
            _buildingslots = [];
            _PROGRESSQUEUE = [];
            _PROGRESSQUEUE.push(_workers);
            _PROGRESSQUEUE.push(_buildingslots);
            _loc1_ = 0;
            _maxWorkers = 5;
            if(BASE._isOutpost)
            {
               _maxWorkers = 1;
            }
            _loc2_ = 0;
            while(_loc2_ < _maxWorkers)
            {
               _loc3_ = new UI_SIDEBAR_SLOT();
               _loc1_ += _layoutColumnSpacing;
               _loc3_.x = _layoutOrigin.x;
               _loc3_.y = _layoutOrigin.y + _loc1_;
               _loc1_ += _layoutCellHeight;
               _loc3_.addEventListener(MouseEvent.CLICK,EventCallbackEx(WorkerMouseClicked,[_loc2_]));
               _loc3_.addEventListener(MouseEvent.ROLL_OVER,EventCallbackEx(WorkerMouseOver,[_loc2_]));
               _loc3_.addEventListener(MouseEvent.ROLL_OUT,MouseOut);
               _loc3_._isWorker = true;
               _mc.addChild(_loc3_);
               _workers.push({
                  "isworker":true,
                  "purchased":false,
                  "active":false,
                  "id":"",
                  "message":"<b>FINISH NOW!</b> ",
                  "buildstate":"",
                  "slottype":"",
                  "level":0,
                  "mc":_loc3_,
                  "image":"",
                  "target":false,
                  "time":"",
                  "timeLeft":0,
                  "timeTotal":0,
                  "timePercent":0,
                  "building":new Object(),
                  "added":""
               });
               _loc2_++;
            }
            _do = GLOBAL._layerUI.addChild(_mc);
            _loaded = true;
            _startMarker = GLOBAL.Timestamp();
         }
         Update();
         if(!UI2._showBottom)
         {
            Hide();
         }
      }
      
      public static function Update(param1:Boolean = false) : *
      {
         var render:Boolean = false;
         var cleanup:Boolean = false;
         var i:int = 0;
         var tmpWorker:Object = null;
         var tmpStack:* = undefined;
         var buildingName:String = null;
         var buildingLevel:String = null;
         var timerConfig:Object = null;
         var tmpBuilding:Object = null;
         var pctComplete:int = 0;
         var upgrade:Object = null;
         var monsterID:* = undefined;
         var monsterStatus:Object = null;
         var monsterName:String = null;
         var monsterAction:String = null;
         var _locker:* = undefined;
         var creatureID:* = undefined;
         var monsterData:Object = null;
         var _hatchery:* = undefined;
         var force:Boolean = param1;
         try
         {
            render = false;
            cleanup = false;
            _hatcheryFull = false;
            if(force)
            {
               render = force;
            }
            if(GLOBAL._mode != "build" || !_loaded)
            {
               return;
            }
            if(Boolean(_workers) && _workers.length > 0)
            {
               i = 0;
               while(i < _workers.length)
               {
                  tmpWorker = _workers[i];
                  if(Boolean(QUEUE._stack) && Boolean(QUEUE._stack[i]))
                  {
                     tmpStack = QUEUE._stack[i];
                     if(tmpWorker.id != tmpStack.id)
                     {
                        tmpWorker.id = tmpStack.id;
                     }
                     buildingName = "";
                     buildingLevel = "";
                     if(tmpStack.building)
                     {
                        buildingName = KEYS.Get(GLOBAL._buildingProps[tmpStack.building._type - 1].name);
                        buildingLevel = "Level " + [tmpStack.building._lvl.Get() + 1];
                        if(tmpStack.building._buildingProps)
                        {
                           timerConfig = UpdateTimer(tmpStack.building);
                           tmpWorker.timeTotal = timerConfig.timetotal;
                           tmpWorker.timeLeft = timerConfig.timeleft;
                           tmpWorker.timePercent = timerConfig.timepercent;
                           tmpWorker.buildstate = timerConfig.buildstate;
                        }
                        else
                        {
                           tmpWorker.timeTotal = 0;
                           tmpWorker.timeLeft = 0;
                           tmpWorker.timePercent = 0;
                           tmpWorker.buildstate = "null";
                        }
                        tmpWorker.building = tmpStack.building;
                        tmpWorker.message = buildingName + " to " + buildingLevel;
                        if(tmpStack.building._type == 16)
                        {
                           tmpWorker.message = "Hatchery CC to " + buildingLevel;
                        }
                        else if(tmpStack.building._type == 115)
                        {
                           tmpWorker.message = "Aerial Tower to " + buildingLevel;
                        }
                        else if(tmpStack.building._type == 19)
                        {
                           tmpWorker.message = "Monster Baiter to " + buildingLevel;
                        }
                        tmpWorker.added = tmpStack.timestamp;
                        if(tmpWorker.building._type == 7)
                        {
                           tmpWorker.slottype = "DESC";
                           tmpWorker.message = "Picking Mushroom";
                        }
                     }
                     else
                     {
                        tmpWorker.timeTotal = -1;
                        tmpWorker.timeLeft = -1;
                        tmpWorker.building = null;
                     }
                     tmpWorker.time = tmpStack.message;
                     tmpWorker.level = buildingLevel;
                     if(!tmpWorker.purchased)
                     {
                        tmpWorker.purchased = true;
                        render = true;
                     }
                     if(tmpWorker.active != tmpStack.active)
                     {
                        tmpWorker.active = tmpStack.active;
                        render = true;
                     }
                     if(!tmpStack.active || !tmpWorker.active)
                     {
                        tmpWorker.id = "";
                        tmpWorker.active = false;
                        tmpWorker.message = "<b>Idle</b> ";
                        tmpWorker.buildstate = "";
                        tmpWorker.slottype = "DESC";
                        tmpWorker.level = 1;
                        tmpWorker.image = "";
                        tmpWorker.target = false;
                        tmpWorker.time = "";
                        tmpWorker.timeLeft = -1;
                        tmpWorker.timeTotal = -1;
                        tmpWorker.timePercent = -1;
                        tmpWorker.building = null;
                        cleanup = true;
                     }
                     if(tmpWorker.building)
                     {
                        if(tmpWorker.building._hp.Get() < tmpWorker.building._hpMax.Get())
                        {
                           tmpWorker.message = "Building Damaged";
                           tmpWorker.buildstate = "damaged";
                           tmpWorker.slottype = "DESC";
                           cleanup = true;
                        }
                     }
                  }
                  else
                  {
                     tmpWorker.id = "";
                     tmpWorker.active = false;
                     tmpWorker.message = "<b>Idle</b> ";
                     tmpWorker.buildstate = "";
                     tmpWorker.slottype = "DESC";
                     tmpWorker.level = 1;
                     tmpWorker.image = "";
                     tmpWorker.target = false;
                     tmpWorker.time = "";
                     tmpWorker.timeLeft = -1;
                     tmpWorker.timeTotal = -1;
                     tmpWorker.timePercent = -1;
                     tmpWorker.building = null;
                     cleanup = true;
                  }
                  render = true;
                  i++;
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","UI_PROGRESSBAR.Update A: " + e.message + " | " + e.getStackTrace());
         }
         try
         {
            if(Boolean(_buildings) && _buildings.length > 0)
            {
               i = 0;
               while(i < _buildings.length)
               {
                  if(_buildings[i])
                  {
                     tmpBuilding = _buildings[i];
                     tmpBuilding.id = _buildings[i].id + _maxWorkers;
                  }
                  if(Boolean(tmpBuilding.building) && Boolean(tmpBuilding.building._type))
                  {
                     if(tmpBuilding.building._type == 26)
                     {
                        tmpBuilding.level = _buildings[i].building._lvl.Get();
                        tmpBuilding.mc = _buildings[i].building._mc;
                        tmpBuilding.production = false;
                        tmpBuilding.timeLeft = -1;
                        tmpBuilding.time = "";
                        tmpBuilding.timeTotal = -1;
                        tmpBuilding.timePercent = 0;
                        if(tmpBuilding.building._countdownUpgrade.Get() + tmpBuilding.building._countdownBuild.Get() > 0)
                        {
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = tmpBuilding.icon;
                           tmpBuilding.message = "Building Upgrading. ";
                           timerConfig = UpdateTimer(tmpBuilding.building);
                           tmpBuilding.timeTotal = timerConfig.indextotal;
                           tmpBuilding.timeLeft = timerConfig.indexprogress;
                           tmpBuilding.timePercent = timerConfig.indexpercent;
                        }
                        else if(tmpBuilding.building._hp.Get() < tmpBuilding.building._hpMax.Get())
                        {
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = tmpBuilding.icon;
                           tmpBuilding.message = "Building Damaged. ";
                           timerConfig = UpdateTimer(tmpBuilding.building);
                           tmpBuilding.timeTotal = timerConfig.indextotal;
                           tmpBuilding.timeLeft = timerConfig.indexprogress;
                           tmpBuilding.timePercent = timerConfig.indexpercent;
                        }
                        else if(tmpBuilding.building._upgrading)
                        {
                           upgrade = ACADEMY._upgrades[tmpBuilding.building._upgrading];
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = "monsters/" + tmpBuilding.building._upgrading + "-small" + ".png";
                           monsterID = tmpBuilding.building._upgrading;
                           monsterStatus = ACADEMY.StartMonsterUpgrade(monsterID,true);
                           monsterName = KEYS.Get(CREATURELOCKER._creatures[monsterID].name);
                           monsterAction = "Training Level " + (ACADEMY._upgrades[monsterID].level + 1);
                           tmpBuilding.time = GLOBAL.ToTime(ACADEMY._upgrades[monsterID].time.Get() - GLOBAL.Timestamp());
                           tmpBuilding.message = monsterAction + " " + monsterName;
                           if(upgrade != null)
                           {
                              if(upgrade.time != null)
                              {
                                 tmpBuilding.production = true;
                                 tmpBuilding.timeLeft = upgrade.time.Get() - GLOBAL.Timestamp();
                                 tmpBuilding.time = GLOBAL.ToTime(tmpBuilding.timeLeft);
                                 tmpBuilding.timeTotal = upgrade.duration;
                                 pctComplete = Math.floor((tmpBuilding.timeTotal - tmpBuilding.timeLeft) / tmpBuilding.timeTotal * 100);
                                 tmpBuilding.timePercent = pctComplete;
                              }
                           }
                        }
                        else
                        {
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = tmpBuilding.icon;
                           tmpBuilding.message = "<b>No Monsters <br>being Trained.</b> ";
                        }
                     }
                     else if(tmpBuilding.building._type == 8)
                     {
                        tmpBuilding.level = _buildings[i].building._lvl.Get();
                        tmpBuilding.mc = _buildings[i].building._mc;
                        tmpBuilding.production = false;
                        tmpBuilding.timeLeft = -1;
                        tmpBuilding.time = "";
                        tmpBuilding.timeTotal = -1;
                        tmpBuilding.timePercent = 0;
                        _locker = _buildings[i].building;
                        if(tmpBuilding.building._countdownUpgrade.Get() + tmpBuilding.building._countdownBuild.Get() > 0)
                        {
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = tmpBuilding.icon;
                           tmpBuilding.message = "<b>Building Upgrading.</b> ";
                           timerConfig = UpdateTimer(tmpBuilding.building);
                           tmpBuilding.timeTotal = timerConfig.indextotal;
                           tmpBuilding.timeLeft = timerConfig.indexprogress;
                           tmpBuilding.timePercent = timerConfig.indexpercent;
                        }
                        else if(tmpBuilding.building._hp.Get() < tmpBuilding.building._hpMax.Get())
                        {
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = tmpBuilding.icon;
                           tmpBuilding.message = "Building Damaged. ";
                           timerConfig = UpdateTimer(tmpBuilding.building);
                           tmpBuilding.timeTotal = timerConfig.indextotal;
                           tmpBuilding.timeLeft = timerConfig.indexprogress;
                           tmpBuilding.timePercent = timerConfig.indexpercent;
                        }
                        else if(CREATURELOCKER._unlocking)
                        {
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = "monsters/" + CREATURELOCKER._unlocking + "-small.png";
                           if(CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].t == 1)
                           {
                              tmpBuilding.production = true;
                           }
                           tmpBuilding.timeLeft = CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e - GLOBAL.Timestamp();
                           creatureID = CREATURELOCKER._unlocking;
                           monsterData = CREATURELOCKER._creatures[creatureID];
                           monsterName = "Unlocking " + KEYS.Get(monsterData.name) + "";
                           tmpBuilding.message = monsterName;
                           tmpBuilding.time = GLOBAL.ToTime(tmpBuilding.timeLeft);
                           tmpBuilding.timeTotal = CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e - CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].s;
                           pctComplete = Math.floor((tmpBuilding.timeTotal - tmpBuilding.timeLeft) / tmpBuilding.timeTotal * 100);
                           tmpBuilding.timePercent = pctComplete;
                        }
                        else
                        {
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = tmpBuilding.icon;
                           tmpBuilding.message = "<b>No Monsters <br>being Unlocked.</b> ";
                        }
                     }
                     else if(tmpBuilding.building._type == 13)
                     {
                        tmpBuilding.level = _buildings[i].building._lvl.Get();
                        tmpBuilding.mc = _buildings[i].building._mc;
                        tmpBuilding.production = false;
                        tmpBuilding.timeLeft = -1;
                        tmpBuilding.time = "";
                        tmpBuilding.timeTotal = -1;
                        tmpBuilding.timePercent = 0;
                        _hatchery = _buildings[i].building;
                        if(tmpBuilding.building._countdownUpgrade.Get() + tmpBuilding.building._countdownBuild.Get() > 0)
                        {
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = tmpBuilding.icon;
                           tmpBuilding.message = "<b>Building Upgrading.</b> ";
                           timerConfig = UpdateTimer(tmpBuilding.building);
                           tmpBuilding.timeTotal = timerConfig.indextotal;
                           tmpBuilding.timeLeft = timerConfig.indexprogress;
                           tmpBuilding.timePercent = timerConfig.indexpercent;
                        }
                        else if(tmpBuilding.building._hp.Get() < tmpBuilding.building._hpMax.Get())
                        {
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = tmpBuilding.icon;
                           tmpBuilding.message = "Building Damaged. ";
                           timerConfig = UpdateTimer(tmpBuilding.building);
                           tmpBuilding.timeTotal = timerConfig.indextotal;
                           tmpBuilding.timeLeft = timerConfig.indexprogress;
                           tmpBuilding.timePercent = timerConfig.indexpercent;
                        }
                        else if(_hatchery._inProduction)
                        {
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = "monsters/" + _hatchery._inProduction + "-small.png";
                           tmpBuilding.production = true;
                           tmpBuilding.timeLeft = _hatchery._countdownProduce.Get();
                           tmpBuilding.time = GLOBAL.ToTime(tmpBuilding.timeLeft);
                           tmpBuilding.timeTotal = CREATURES.GetProperty(_hatchery._inProduction,"cTime");
                           pctComplete = Math.floor((tmpBuilding.timeTotal - tmpBuilding.timeLeft) / tmpBuilding.timeTotal * 100);
                           tmpBuilding.timePercent = pctComplete;
                           if(_hatchery._countdownProduce.Get() > 0 && Boolean(_hatchery._hasResources))
                           {
                              tmpBuilding.message = "";
                           }
                           else if(_hatchery._productionStage.Get() == 2 && Boolean(_hatchery._inProduction))
                           {
                              _hatcheryFull = true;
                              tmpBuilding.message = "<b>" + KEYS.Get("hat_status_nospace") + "</b>";
                           }
                           else if(_hatchery._productionStage.Get() == 3 && _hatchery._taken.Get() == 0)
                           {
                              tmpBuilding.message = "<b>" + KEYS.Get("hat_status_nogoo") + "</b>";
                           }
                           else
                           {
                              tmpBuilding.message = "<b>" + KEYS.Get("hat_status_waiting") + "</b>";
                           }
                        }
                        else
                        {
                           tmpBuilding.icon = RenderBuilding(tmpBuilding.building,_buildingslots[0],tmpBuilding.building._lvl.Get(),true);
                           tmpBuilding.image = tmpBuilding.icon;
                           tmpBuilding.message = "<b>No Monsters <br>in Production.</b> ";
                           if(_hasHCC)
                           {
                              tmpBuilding.message = "<b>No Monsters <br>in Production.</b> ";
                           }
                        }
                     }
                  }
                  if(Boolean(tmpBuilding.production) || Boolean(_buildings[i].production))
                  {
                     tmpBuilding.production = _buildings[i].production;
                     render = true;
                  }
                  i++;
               }
            }
            MouseboxCheck();
            if(cleanup)
            {
               CleanupSlots();
            }
            if(GLOBAL.Timestamp() - _startMarker > _startDelay && _startNotice)
            {
               _startNotice = false;
               ChangeSlots("CLOSE",0,true);
            }
            else if(GLOBAL.Timestamp() - _noticeMarker > _noticeDelay && _noticeShow && !_startNotice)
            {
               _noticeShow = false;
               ChangeSlots("CLOSE",0,true);
            }
            Render();
         }
         catch(e:Error)
         {
            LOGGER.Log("err","UI_PROGRESSBAR.Update B: " + e.message + " | " + e.getStackTrace());
         }
      }
      
      private static function Render() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         _loc1_ = 0;
         while(_loc1_ < _workers.length)
         {
            _loc2_ = _workers[_loc1_];
            if(_loc2_.mc._isLoaded)
            {
               if(_loc2_.purchased)
               {
                  _loc2_.mc._descbg.gotoAndStop(1);
                  if(_loc2_.active)
                  {
                     _loc2_.mc._bg.gotoAndStop(2);
                     if(_loc2_.building._type == 7)
                     {
                        _loc2_.slottype = "DESC";
                        _loc3_ = "DESC";
                     }
                     else
                     {
                        _loc2_.slottype = "INSTANT";
                        _loc3_ = "OPEN";
                     }
                  }
                  else
                  {
                     _loc2_.mc._bg.gotoAndStop(1);
                     _loc2_.mc._image.Clear();
                     _loc2_.slottype = "DESC";
                     _loc3_ = "DESC";
                  }
                  if(_loc2_.mc._worker)
                  {
                     _loc2_.mc._worker.gotoAndStop(1);
                     if(_loc2_.mc._worker.mcIcon)
                     {
                        if(STORE._storeData.BST)
                        {
                           _loc2_.mc._worker.mcIcon.gotoAndStop(2);
                        }
                        else
                        {
                           _loc2_.mc._worker.mcIcon.gotoAndStop(1);
                        }
                     }
                  }
               }
               else
               {
                  _loc2_.mc._worker.gotoAndStop(3);
                  _loc2_.mc._descbg.gotoAndStop(2);
                  _loc2_.slottype = "DESC";
                  _loc2_.message = "Hire an <br>Extra Worker";
                  _loc3_ = "DESC";
               }
            }
            _loc2_.mc.Setup(_loc2_);
            if(Boolean(_loc2_.mc._isLoaded) && Boolean(_loc2_.building) && Boolean(_loc2_.timeTotal) && Boolean(_loc2_.timeLeft) && !_startNotice)
            {
               _loc4_ = _loc2_.building._countdownUpgrade.Get() + _loc2_.building._countdownBuild.Get() > 0;
               _loc5_ = GLOBAL.Timestamp() - _noticeMarker > _noticeDelay;
               _loc6_ = GLOBAL.Timestamp() - _loc2_.added == 0;
               if(_loc4_ && _loc6_ && !_startNotice)
               {
                  _loc2_.showNotice = true;
                  _noticeShow = true;
                  _noticeMarker = GLOBAL.Timestamp();
                  _loc2_.mc.ChangeState("SINGLE");
               }
            }
            if(!_loc2_.mc._isSingle)
            {
               _loc2_.mc.ChangeState(_loc3_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _buildings.length)
         {
            if(_buildings[_loc1_])
            {
               _loc7_ = _buildings[_loc1_];
               _loc7_.id = _buildings[_loc1_].id + _maxWorkers;
               _loc8_ = _buildingslots[_loc1_];
            }
            if(_loc7_.building._countdownUpgrade.Get() + _loc7_.building._countdownBuild.Get() > 0)
            {
               _loc8_.mc._bg.gotoAndStop(1);
               _loc7_.slottype = "DESC";
               _loc3_ = "DESC";
            }
            else if(_loc7_.production)
            {
               _loc8_.mc._bg.gotoAndStop(2);
               _loc7_.slottype = "INSTANT";
               _loc3_ = "OPEN";
            }
            else
            {
               _loc8_.mc._bg.gotoAndStop(1);
               _loc7_.slottype = "DESC";
               _loc3_ = "DESC";
            }
            if(_loc7_)
            {
               _loc8_.image = RenderBuilding(_loc7_.building,_buildingslots[_loc1_],_loc7_.level);
               _loc8_.mc.Setup(_loc7_);
               _loc8_.mc.ChangeState(_loc3_);
            }
            _loc1_++;
         }
      }
      
      public static function RenderBuilding(param1:Object, param2:Object, param3:int, param4:Boolean = false) : String
      {
         var numImageElements:Function;
         var ImageLoaded:Function;
         var DefaultImageLoaded:Function;
         var imageDataA:Object = null;
         var imageDataB:Object = null;
         var imageLevel:int = 0;
         var imgURL:String = null;
         var thumbImgURL:String = null;
         var thumbImgLen:int = 0;
         var i:int = 0;
         var j:int = 0;
         var _building:Object = param1;
         var _slot:Object = param2;
         var lvl:int = param3;
         var test:Boolean = param4;
         var _renderLevel:int = -1;
         if(GLOBAL._buildingProps[_building._type - 1].thumbImgData)
         {
            imageDataA = GLOBAL._buildingProps[_building._type - 1].thumbImgData;
            if(_building._lvl.Get() == 0)
            {
               imageDataB = imageDataA[1];
               imageLevel = 1;
            }
            else
            {
               numImageElements = function(param1:Object):int
               {
                  var _loc3_:String = null;
                  var _loc2_:int = 0;
                  for(_loc3_ in param1)
                  {
                     _loc2_++;
                  }
                  return _loc2_;
               };
               thumbImgLen = numImageElements(imageDataA);
               if(Boolean(imageDataA[_building._lvl.Get()]) && imageDataA[_building._lvl.Get()] >= _building._buildingProps.hp.length)
               {
                  imageDataB = imageDataA[_building._lvl.Get()];
                  imageLevel = int(_building._lvl.Get());
               }
               else
               {
                  i = int(_building._lvl.Get());
                  if(Boolean(imageDataA[i]) && i > _building._lvl.Get())
                  {
                     imageDataB = imageDataA[i];
                     imageLevel = i;
                  }
                  else
                  {
                     j = int(_building._lvl.Get());
                     while(j > 0)
                     {
                        if(imageDataA[j])
                        {
                           imageDataB = imageDataA[j];
                           imageLevel = j;
                           break;
                        }
                        if(j == 1)
                        {
                           imageDataB = imageDataB[1];
                           imageLevel = 1;
                           break;
                        }
                        j--;
                     }
                  }
               }
            }
            thumbImgURL = GLOBAL._buildingProps[_building._type - 1].thumbImgData[imageLevel].img;
            imgURL = GLOBAL._buildingProps[_building._type - 1].thumbImgData.baseurl + thumbImgURL;
            if(!test)
            {
               ImageLoaded = function(param1:String, param2:BitmapData):void
               {
                  _slot.mc._image.Clear();
                  _slot.mc._image.addChild(new Bitmap(param2));
               };
               ImageCache.GetImageWithCallBack(imgURL,ImageLoaded);
            }
         }
         else
         {
            imgURL = "buildingthumbs/" + _building._type + ".png";
            if(!test)
            {
               DefaultImageLoaded = function(param1:String, param2:BitmapData):void
               {
                  _slot.mc._image.Clear();
                  _slot.mc._image.addChild(new Bitmap(param2));
               };
               ImageCache.GetImageWithCallBack(imgURL,DefaultImageLoaded);
            }
         }
         _slot.image = imgURL;
         return imgURL;
      }
      
      public static function UpdateTimer(param1:BFOUNDATION, param2:Boolean = false) : Object
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:Object = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Array = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc3_:int = -1;
         var _loc4_:String = "";
         var _loc8_:int = getTimer();
         _loc9_ = {
            "buildstate":"",
            "timeleft":-1,
            "buildhp":-1,
            "timetotal":-1,
            "timepercent":-1
         };
         if(param1._countdownBuild.Get() > 0)
         {
            if(param1._prefab)
            {
               _loc11_ = 0;
               _loc12_ = 0;
               while(_loc12_ < param1._prefab)
               {
                  _loc11_ += GLOBAL._buildingProps[param1._type - 1].costs[_loc12_].time;
                  _loc12_++;
               }
               _loc6_ = _loc11_;
            }
            else if(param1._buildingProps)
            {
               if(param1._lvl.Get() < param1._buildingProps.costs.length)
               {
                  _loc6_ = int(param1._buildingProps.costs[param1._lvl.Get()].time);
               }
               else
               {
                  _loc6_ = int(param1._buildingProps.costs[0].time);
               }
            }
            else
            {
               _loc6_ = 0;
            }
            if(GLOBAL._flags.split)
            {
               if(GLOBAL._mode == "build")
               {
                  _loc13_ = LOGIN._digits;
               }
               else
               {
                  _loc13_ = BASE._userDigits;
               }
               _loc14_ = int(_loc13_[_loc13_.length - 1]);
               _loc15_ = int(_loc13_[_loc13_.length - 2]);
               _loc16_ = _loc14_ + _loc15_;
               if(_loc16_ > 9)
               {
                  _loc16_ -= 10;
               }
               if(_loc16_ >= 7)
               {
                  _loc6_ *= 1.5;
               }
               else if(_loc16_ >= 4)
               {
                  _loc6_ *= 1.25;
               }
            }
            _loc3_ = 49 / _loc6_ * (_loc6_ - param1._countdownBuild.Get());
            _loc4_ = "building";
            _loc7_ = param1._countdownBuild.Get();
         }
         else if(param1._countdownUpgrade.Get() > 0)
         {
            _loc6_ = int(param1._buildingProps.costs[param1._lvl.Get()].time);
            if(GLOBAL._flags.split)
            {
               if(GLOBAL._mode == "build")
               {
                  _loc13_ = LOGIN._digits;
               }
               else
               {
                  _loc13_ = BASE._userDigits;
               }
               _loc14_ = int(_loc13_[_loc13_.length - 1]);
               _loc15_ = int(_loc13_[_loc13_.length - 2]);
               _loc16_ = _loc14_ + _loc15_;
               if(_loc16_ > 9)
               {
                  _loc16_ -= 10;
               }
               if(_loc16_ >= 7)
               {
                  _loc6_ *= 1.5;
               }
               else if(_loc16_ >= 4)
               {
                  _loc6_ *= 1.25;
               }
            }
            _loc3_ = 49 / _loc6_ * (_loc6_ - param1._countdownUpgrade.Get());
            _loc4_ = "upgrading";
            _loc7_ = param1._countdownUpgrade.Get();
         }
         if(_loc3_ == -1)
         {
            if(_loc9_.timeleft != -1)
            {
               _loc9_.timeleft = -1;
               _loc9_.timetotal = -1;
               return -1;
            }
         }
         else if(_loc3_ != _loc9_.timeleft)
         {
            _loc9_.timeleft = _loc7_;
            _loc9_.timetotal = _loc6_;
         }
         var _loc10_:int = Math.floor((_loc9_.timetotal - _loc9_.timeleft) / _loc9_.timetotal * 100);
         _loc9_.timepercent = _loc10_;
         _loc9_.buildstate = _loc4_;
         return _loc9_;
      }
      
      public static function ShouldProcess(param1:BFOUNDATION) : Boolean
      {
         if(param1._type == 8 || param1._type == 26)
         {
            return true;
         }
         return false;
      }
      
      public static function ProcessBuildings(param1:Boolean = false) : void
      {
         var _loc2_:BFOUNDATION = null;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:Object = null;
         var _loc7_:UI_SIDEBAR_SLOT = null;
         if(param1)
         {
            _buildings = [];
            _academies = [];
            _lockers = [];
            _hatcheries = [];
            _HCC = [];
            _hasHCC = false;
            _buildingtype = [];
            _loc4_ = int(_buildingslots.length);
            if(_buildingslots.length > 0)
            {
               _loc4_ = int(_buildingslots.length - 1);
               while(_loc4_ >= 0)
               {
                  if(Boolean(_buildingslots[_loc4_].mc) && Boolean(_buildingslots[_loc4_].mc.parent))
                  {
                     _buildingslots[_loc4_].mc.parent.removeChild(_buildingslots[_loc4_].mc);
                  }
                  _loc5_ = _buildingslots.splice(_loc4_,1);
                  _loc5_ = null;
                  _loc4_--;
               }
               _buildingslots = [];
            }
         }
         for each(_loc2_ in BASE._buildingsAll)
         {
            _loc6_ = {};
            if(_loc2_._type == 26 || _loc2_._type == 8)
            {
               _loc6_ = {
                  "production":_loc2_._inProduction,
                  "id":_loc2_._type,
                  "message":"FINISH NOW!",
                  "level":_loc2_._lvl.Get(),
                  "mc":_loc2_._mc,
                  "image":"",
                  "target":false,
                  "type":_loc2_._type,
                  "time":"",
                  "timeLeft":_loc2_._countdownProduce.Get(),
                  "timeTotal":0,
                  "timePercent":0,
                  "building":_loc2_
               };
               _buildings.push(_loc6_);
            }
            if(_loc2_._type == 26 && _loc2_._countdownBuild.Get() <= 0)
            {
               _academies.push(_loc6_);
            }
            if(_loc2_._type == 8 && _loc2_._countdownBuild.Get() <= 0)
            {
               _lockers.push(_loc6_);
            }
            if(_loc2_._type == 13 && _loc2_._countdownBuild.Get() <= 0)
            {
               _hatcheries.push(_loc6_);
            }
            if(_loc2_._type == 16 && _loc2_._countdownBuild.Get() <= 0)
            {
               _HCC.push(_loc6_);
               _hasHCC = true;
            }
         }
         _buildingtype = [_hatcheries,_lockers,_academies];
         _loc3_ = _maxWorkers * _layoutColumnSpacing + _maxWorkers * _layoutCellHeight;
         _loc4_ = 0;
         while(_loc4_ < _buildings.length)
         {
            _loc7_ = new UI_SIDEBAR_SLOT();
            _loc3_ += _layoutColumnSpacing;
            _loc7_.x = _layoutOrigin.x;
            _loc7_.y = _layoutOrigin.y + _loc3_;
            _loc3_ += _layoutCellHeight;
            _loc7_.addEventListener(MouseEvent.CLICK,EventCallbackEx(BuildingMouseClicked,[_loc4_]));
            _loc7_.addEventListener(MouseEvent.MOUSE_OVER,EventCallbackEx(BuildingMouseOver,[_loc4_]));
            _loc7_.addEventListener(MouseEvent.MOUSE_OUT,MouseOut);
            _loc7_._isWorker = false;
            _mc.addChild(_loc7_);
            _buildingslots.push({
               "isworker":false,
               "production":false,
               "array":_loc4_,
               "id":"",
               "message":"<b>FINISH NOW!</b> ",
               "slottype":"",
               "level":0,
               "mc":_loc7_,
               "image":"",
               "target":false,
               "time":"",
               "timeLeft":0,
               "timeTotal":0,
               "timePercent":0,
               "building":new Object()
            });
            _loc4_++;
         }
         if(_startNotice == true || _runOnce)
         {
            ChangeSlots("OPEN",0,true);
            _startNotice = true;
            _startMarker = GLOBAL.Timestamp();
         }
         _runOnce = false;
         Update(true);
         CleanupSlots();
         Resize();
      }
      
      private static function EventCallbackEx(param1:Function, param2:Array) : Function
      {
         var method:Function = param1;
         var args:Array = param2;
         return function(param1:Event):void
         {
            method.apply(null,[param1].concat(args));
         };
      }
      
      private static function WorkerMouseOver(param1:Event, param2:int) : *
      {
         _mouseboxOver = true;
         MouseboxCheck();
      }
      
      private static function WorkerMouseClicked(param1:Event, param2:int) : *
      {
         if(_workers[param2])
         {
            if(_workers[param2].purchased)
            {
               if(_workers[param2].active)
               {
                  PanTo(_workers[param2].building._mc);
               }
               else
               {
                  QUEUE.JumpToWorker(param2);
               }
               _popupOn = true;
            }
            else
            {
               STORE.ShowB(1,0,["BEW"]);
            }
         }
         _popupOn = true;
         _popupTarget = param1.target.parent;
      }
      
      private static function WorkerMouseOut(param1:MouseEvent, param2:int) : *
      {
         _mouseboxOver = false;
         MouseboxCheck();
      }
      
      private static function BuildingMouseOver(param1:MouseEvent, param2:int) : *
      {
         _mouseboxOver = true;
         MouseboxCheck();
      }
      
      private static function BuildingMouseClicked(param1:MouseEvent, param2:int) : *
      {
         if(_buildings[param2])
         {
            PanTo(_buildings[param2].building._mc);
         }
      }
      
      private static function MouseOut(param1:MouseEvent) : *
      {
         _mouseboxOver = false;
         MouseboxCheck();
      }
      
      public static function PanTo(param1:MovieClip) : *
      {
         MAP.FocusTo(param1.x,param1.y,0.5);
      }
      
      public static function CleanupSlots() : *
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc1_:Array = new Array();
         _loc2_ = 0;
         while(_loc2_ < _buildings.length)
         {
            _loc3_ = {
               "target":_buildings[_loc2_],
               "production":int(_buildings[_loc2_].production),
               "timeleft":_buildings[_loc2_].timeLeft
            };
            _loc1_.push(_loc3_);
            _loc2_++;
         }
         _loc1_.sortOn("production",Array.NUMERIC | Array.DESCENDING);
         _loc2_ = 0;
         while(_loc2_ < _buildings.length)
         {
            _buildings[_loc2_] = _loc1_[_loc2_].target;
            _loc2_++;
         }
      }
      
      public static function SlotsStateAll(param1:String) : *
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         _loc2_ = 0;
         while(_loc2_ < _workers.length)
         {
            _loc3_ = _workers[_loc2_];
            _loc3_.mc.ChangeState(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _buildingslots.length)
         {
            _loc4_ = _buildingslots[_loc2_];
            _loc4_.mc.ChangeState(param1);
            _loc2_++;
         }
         _slotsState = param1;
      }
      
      public static function SlotsCloseAll() : *
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         _loc2_ = 0;
         while(_loc2_ < _workers.length)
         {
            _loc3_ = _workers[_loc2_];
            _loc3_.mc.AnimStop();
            _loc3_.mc.ChangeState("CLOSE");
            _loc3_.showNotice = false;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _buildingslots.length)
         {
            _loc4_ = _buildingslots[_loc2_];
            _loc4_.mc.AnimStop();
            _loc4_.mc.ChangeState("CLOSE");
            _loc2_++;
         }
      }
      
      public static function SlotsState(param1:String, param2:Object) : *
      {
         var _loc3_:Object = param2;
         _loc3_.ChangeState(param1);
      }
      
      public static function SlotsAnimCheck() : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc1_:Boolean = false;
         for each(_loc2_ in _workers)
         {
            _loc1_ = Boolean(_loc2_.mc._isAnimating);
            if(_loc1_)
            {
               return _loc1_;
            }
         }
         for each(_loc3_ in _buildingslots)
         {
            _loc1_ = Boolean(_loc3_.mc._isAnimating);
            if(_loc1_)
            {
               return _loc1_;
            }
         }
         return _loc1_;
      }
      
      public static function Resize() : *
      {
         if(Boolean(_mc) && UI_PROGRESSBAR._loaded)
         {
            _mc.x = GLOBAL._SCREEN.right;
            _mc.y = GLOBAL._SCREEN.top + 50;
         }
         else
         {
            _mc.x = 700;
            _mc.y = 50;
         }
         MouseboxUpdate();
      }
      
      public static function ChangeSlots(param1:String, param2:Number = 0, param3:Boolean = false) : void
      {
         _noticeShow = false;
         _startNotice = false;
         if(param1 != _slotsState || param3)
         {
            if(param2 > 0)
            {
               TweenLite.delayedCall(param2,ChangeSlots,[param1,0]);
               return;
            }
            _slotsState = param1;
            if(_slotsState == "CLOSE")
            {
               SlotsCloseAll();
            }
            else if(_slotsState == "OPEN")
            {
               SlotsStateAll("OPEN");
            }
            MouseboxUpdate();
         }
      }
      
      public static function MouseboxUpdate() : void
      {
         var _loc1_:* = undefined;
         if(_mousebox)
         {
            _loc1_ = _buildings.length + _workers.length;
            _mousebox.height = _loc1_ * _layoutCellHeight + _loc1_ + 5 * _layoutColumnSpacing;
            if(_slotsState == "OPEN")
            {
               _mousebox.width = _slotsOpenWidth;
               _mousebox.x = -_slotsOpenWidth;
            }
            else if(_slotsState == "CLOSE")
            {
               if(_noticeShow)
               {
                  _mousebox.width = _slotsOpenWidth;
                  _mousebox.x = -_slotsOpenWidth;
               }
               else
               {
                  _mousebox.width = _slotsCloseWidth;
                  _mousebox.x = -_slotsCloseWidth;
               }
            }
         }
      }
      
      public static function MouseboxCheck() : void
      {
         if(_mc.mouseX < int(_mousebox.x) || _mc.mouseX > int(_mousebox.x + _mousebox.width) || _mc.mouseY < int(_mousebox.y) || _mc.mouseY > _mousebox.y + _mousebox.height)
         {
            if(!_startNotice && !_noticeShow)
            {
               ChangeSlots("CLOSE",0,true);
            }
         }
         else
         {
            if(GLOBAL.Timestamp() - _startMarker >= 3 && _startNotice)
            {
               _startNotice = false;
            }
            if(GLOBAL.Timestamp() - _noticeMarker >= 1 && _noticeShow)
            {
               _noticeShow = false;
            }
            if(_slotsState == "CLOSE" && !_startNotice && !_noticeShow)
            {
               ChangeSlots("OPEN",0,true);
            }
         }
      }
      
      public static function MBoxOver(param1:MouseEvent = null) : void
      {
         MouseboxCheck();
      }
      
      public static function MBoxOut(param1:MouseEvent = null) : void
      {
         MouseboxCheck();
      }
      
      public static function Show() : *
      {
         if(TUTORIAL._stage < 192)
         {
            _mc.visible = false;
         }
         else
         {
            _mc.visible = true;
         }
      }
      
      public static function Hide() : *
      {
         _mc.visible = false;
      }
   }
}

