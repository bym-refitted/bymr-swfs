package
{
   import com.cc.utils.SecNum;
   import com.monsters.display.ImageCache;
   import com.monsters.ui.UI_BOTTOM;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gs.TweenLite;
   import gs.easing.Elastic;
   
   public class TUTORIAL
   {
      private static var _mcBob:TUTORIALPOPUPMC;
      
      private static var _mcArrow:MovieClip;
      
      private static var _doBob:DisplayObject;
      
      private static var _doArrow:DisplayObject;
      
      private static var _container:*;
      
      private static var _timer:int;
      
      private static var _setupDone:Boolean;
      
      public static var _stage:int = 0;
      
      public static var _currentStage:int = 0;
      
      private static const ARROW_STORE_BUY_1:Point = new Point(215,200);
      
      private static const ARROW_STORE_BUY_2:Point = new Point(225,200);
      
      private static const ARROW_STORE_BUY_3:Point = new Point(580,345);
      
      private static const ARROW_STORE_BUY_4:Point = new Point(225,365);
      
      private static const ARROW_BUILDING_UPGRADE:Point = new Point(586,5 * 60);
      
      private static const ARROW_BUILDINGS_HOUSING:Point = new Point(470,4 * 60);
      
      private static const ARROW_BUILDINGS_FLINGER:Point = new Point(250,5 * 60);
      
      private static const ARROW_BUILDINGS_MAPROOM:Point = new Point(510,5 * 60);
      
      private static const ARROW_BUILDINGS_HATCHERY:Point = new Point(610,4 * 60);
      
      private static var _advanceCondition:Function = null;
      
      private static var _rewindCondition:Function = null;
      
      private static var BOBBOTTOMLEFTLOW:Point = new Point(10,510);
      
      private static var BOBBOTTOMLEFTHIGH:Point = new Point(10,510);
      
      private static var POINT_QUEST:Point = new Point(583,481);
      
      private static var POINT_BUILDINGS:Point = new Point(496,483);
      
      private static var POINT_MAP:Point = new Point(706,474);
      
      private static var _secondWorker:Boolean = true;
      
      private static var _freeSpeedup:Boolean = true;
      
      public function TUTORIAL()
      {
         super();
      }
      
      public static function Setup() : *
      {
         _container = GLOBAL._layerMessages;
         _doBob = null;
         _doArrow = null;
         _mcBob = new TUTORIALPOPUPMC();
         _mcArrow = new TUTORIALARROWMC();
         _currentStage = 0;
      }
      
      public static function Process() : *
      {
         var _loc1_:BFOUNDATION = null;
         var _loc2_:int = 0;
         if(GLOBAL._flags.showProgressBar == 0)
         {
            if(BASE._isOutpost)
            {
               _stage = 202;
               UI_WORKERS.Show();
            }
         }
         if(_stage < 200)
         {
            if(GLOBAL._mode == "build")
            {
               if(Boolean(GLOBAL._bHousing) && _stage < 57)
               {
                  _stage = 57;
               }
               if(_stage == 102)
               {
                  _stage = 101;
               }
               if(QUESTS._completed.WM1 == 1)
               {
                  _stage = 130;
               }
               if(QUESTS._completed.WM1 == 2)
               {
                  _stage = 140;
               }
               if(QUESTS._global.b4lvl > 0)
               {
                  _stage = 3 * 60;
               }
               if(_stage >= 110 && _stage < 130)
               {
                  _stage = 99;
               }
               if(_stage >= 80 && _stage < 110)
               {
                  if(GLOBAL._bHousing)
                  {
                     _loc1_ = GLOBAL._bHousing;
                     if(CREATURES._creatureCount < 50)
                     {
                        _loc2_ = 50;
                        while(_loc2_ > CREATURES._creatureCount)
                        {
                           HOUSING.HousingStore("C1",new Point(_loc1_.x,_loc1_.y + 80),false);
                           _loc2_--;
                        }
                     }
                  }
                  else
                  {
                     _stage = 202;
                  }
               }
               if(_stage < 150 && GLOBAL._bHatchery)
               {
                  if(GLOBAL._bHatchery._countdownBuild.Get() > 0)
                  {
                     _stage = 145;
                  }
                  else
                  {
                     _stage = 150;
                  }
               }
            }
            else if(GLOBAL._mode == "wmattack")
            {
               _stage = 110;
            }
         }
      }
      
      public static function Advance(param1:MouseEvent = null) : *
      {
         if(Boolean(_doBob) && Boolean(_doBob.parent))
         {
            _container.removeChild(_doBob);
         }
         if(Boolean(_doArrow) && Boolean(_doArrow.parent))
         {
            _container.removeChild(_doArrow);
         }
         if(_mcArrow.rotation != 0)
         {
            _mcArrow.rotation = 0;
         }
         _advanceCondition = null;
         _rewindCondition = null;
         _stage += 1;
         QUESTS.Check();
         Tick();
      }
      
      private static function Rewind() : *
      {
         if(Boolean(_doBob) && Boolean(_doBob.parent))
         {
            _container.removeChild(_doBob);
         }
         if(Boolean(_doArrow) && Boolean(_doArrow.parent))
         {
            _container.removeChild(_doArrow);
         }
         _advanceCondition = null;
         _rewindCondition = null;
         --_stage;
         Tick();
      }
      
      public static function Tick() : *
      {
         if(GLOBAL._mode == "build" || GLOBAL._mode == "wmattack")
         {
            if(_stage < 1)
            {
               _stage = 1;
            }
            if(_stage > 205)
            {
               _stage = 205;
            }
            if(!GLOBAL._catchup)
            {
               if(_currentStage != _stage)
               {
                  _currentStage = _stage;
                  Show();
               }
               if(_advanceCondition != null)
               {
                  _advanceCondition();
               }
               if(_rewindCondition != null)
               {
                  _rewindCondition();
               }
            }
         }
      }
      
      private static function Show() : *
      {
         var _loc2_:BFOUNDATION = null;
         var _loc3_:int = 0;
         var _loc4_:Point = null;
         var _loc5_:* = undefined;
         var _loc6_:BFOUNDATION = null;
         var _loc7_:int = 0;
         var _loc8_:SecNum = null;
         var _loc1_:Point = new Point();
         switch(_stage)
         {
            case 1:
               MAP._canScroll = false;
               for each(_loc2_ in BASE._buildingsAll)
               {
                  if(_loc2_._type == 1)
                  {
                     MAP.Focus(_loc2_.x,_loc2_.y);
                     break;
                  }
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_1",{"v1":LOGIN._playerName}),null,true,true);
               break;
            case 3:
               MAP._canScroll = false;
               for each(_loc2_ in BASE._buildingsAll)
               {
                  if(_loc2_._type == 1)
                  {
                     MAP.Focus(_loc2_.x,_loc2_.y);
                     _loc1_.x = _loc2_.x + MAP._GROUND.x;
                     _loc1_.y = _loc2_.y + MAP._GROUND.y + 20;
                     break;
                  }
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_3"),_loc1_,false,false,ConditionSelectTwig);
               break;
            case 4:
               MAP._canScroll = false;
               BASE._bankedValue = 0;
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_4"),null,false,false,ConditionBank,ConditionDeselectTwig);
               break;
            case 5:
               MAP._canScroll = false;
               Add(1,BOBBOTTOMLEFTLOW,KEYS.Get("tut_5",{"v1":BASE._bankedValue}),null,true,true);
               break;
            case 20:
               if(QUESTS._global.b1lvl == 2)
               {
                  Advance();
                  break;
               }
               BASE.BuildingDeselect();
               MAP._canScroll = false;
               for each(_loc2_ in BASE._buildingsAll)
               {
                  if(_loc2_._type == 1)
                  {
                     MAP.Focus(_loc2_.x,_loc2_.y);
                     _loc1_.x = _loc2_.x + MAP._GROUND.x;
                     _loc1_.y = _loc2_.y + MAP._GROUND.y + 20;
                     break;
                  }
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_20"),_loc1_,false,false,ConditionSelectTwig);
               break;
            case 21:
               if(QUESTS._global.b1lvl == 2)
               {
                  Advance();
                  break;
               }
               MAP._canScroll = false;
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_21"),null,false,false,ConditionBuildingOptionsOpen,ConditionDeselectTwig);
               break;
            case 22:
               if(QUESTS._global.b1lvl == 2)
               {
                  Advance();
                  break;
               }
               MAP._canScroll = false;
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_22"),ARROW_BUILDING_UPGRADE,false,false,ConditionBuildingOptionsClose);
               break;
            case 23:
               if(QUESTS._global.b1lvl == 2)
               {
                  Advance();
                  break;
               }
               BASE.BuildingDeselect();
               MAP._canScroll = false;
               for each(_loc2_ in BASE._buildingsAll)
               {
                  if(_loc2_._type == 1)
                  {
                     MAP.Focus(_loc2_.x,_loc2_.y);
                     _loc1_.x = _loc2_.x + MAP._GROUND.x;
                     _loc1_.y = _loc2_.y + MAP._GROUND.y + 20;
                     break;
                  }
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_23"),_loc1_,false,false,ConditionSelectTwig,ConditionRewindNotUpgrading);
               break;
            case 24:
               if(QUESTS._global.b1lvl == 2)
               {
                  Advance();
                  break;
               }
               MAP._canScroll = false;
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_24"),null,false,false,ConditionStoreOpen,ConditionRewindDeselect);
               break;
            case 25:
               if(QUESTS._global.b1lvl == 2)
               {
                  Advance();
                  break;
               }
               MAP._canScroll = false;
               if(_freeSpeedup)
               {
                  Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_25"),ARROW_STORE_BUY_1,false,false,ConditionStoreClose);
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_25_b"),ARROW_STORE_BUY_3,false,false,ConditionStoreClose);
               break;
            case 26:
               QUESTS.Check();
               if(QUESTS._global.b1lvl < 2)
               {
                  _stage = 22;
                  Advance();
                  break;
               }
               BASE.BuildingDeselect();
               MAP._canScroll = false;
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_26"),POINT_QUEST,false,false,ConditionQuestsOpen,ConditionQuestCollectU1);
               break;
            case 27:
               _advanceCondition = ConditionQuestCollectU1;
               break;
            case 31:
               SPRITES.SetupSprite("C2");
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_31"),POINT_BUILDINGS,false,false,ConditionBuildingsOpen);
               break;
            case 32:
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_32"),new Point(445,52),false,false,ConditionBuildingsDefense,ConditionRewindBuildingsClosed);
               break;
            case 33:
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_33"),new Point(166,242),false,false,ConditionBuildingsSniper,ConditionRewindBuildingsClosed);
               break;
            case 34:
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_34"),new Point(595,291),false,false,ConditionNewBuilding,ConditionRewindBuildingsDeselect21);
               break;
            case 35:
               MAP._canScroll = true;
               QUEUE._placed = 0;
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_35"),null,false,false,ConditionPlacedBuilding,ConditionRewindNoNewBuilding);
               break;
            case 36:
               if(QUESTS._global.b21lvl > 0)
               {
                  Advance();
                  break;
               }
               MAP._canScroll = false;
               var _loc9_:int = 0;
               var _loc10_:* = BASE._buildingsTowers;
               for each(_loc2_ in _loc10_)
               {
                  MAP.Focus(_loc2_.x,_loc2_.y);
                  _loc1_.x = _loc2_.x + MAP._GROUND.x;
                  _loc1_.y = _loc2_.y + MAP._GROUND.y + 20;
               }
               Add(1,BOBBOTTOMLEFTLOW,KEYS.Get("tut_36"),_loc1_,false,false,ConditionStoreOpen,ConditionConstructed21);
               break;
            case 37:
               if(_freeSpeedup)
               {
                  Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_25"),ARROW_STORE_BUY_1,false,false,ConditionConstructed21,ConditionStoreClose);
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_25_b"),ARROW_STORE_BUY_3,false,false,ConditionConstructed21,ConditionStoreClose);
               break;
            case 38:
               MAP._canScroll = true;
               Add(1,BOBBOTTOMLEFTLOW,KEYS.Get("tut_38"),POINT_QUEST,false,false,ConditionQuestsOpen,ConditionQuestCollectT1);
               break;
            case 39:
               _advanceCondition = ConditionQuestCollectT1;
               break;
            case 40:
               CUSTOMATTACKS.TutorialAttack();
               Add(4,BOBBOTTOMLEFTLOW,KEYS.Get("tut_40"),null,false,false,ConditionAttackOver);
               break;
            case 41:
               for each(_loc6_ in BASE._buildingsAll)
               {
                  if(_loc6_._hp.Get() < _loc6_._hpMax.Get() && _loc6_._repairing == 0)
                  {
                     _loc6_.Repair();
                  }
               }
               Advance();
               break;
            case 42:
               BUILDINGS._buildingID = 0;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_42"),POINT_QUEST,false,false,ConditionQuestsOpen,ConditionQuestCollectD1);
               break;
            case 43:
               _advanceCondition = ConditionQuestCollectD1;
               break;
            case 44:
               Add(8,BOBBOTTOMLEFTHIGH,KEYS.Get("tut_44"),null,true,true);
               break;
            case 50:
               ImageCache.GetImageWithCallBack("buildingbuttons/15.jpg");
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_50"),POINT_BUILDINGS,false,false,ConditionBuildingsOpen);
               break;
            case 51:
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_51"),new Point(322,51),false,false,ConditionBuildingsBuildings,ConditionRewindBuildingsClosedB);
               break;
            case 52:
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_52"),ARROW_BUILDINGS_HOUSING,false,false,ConditionBuildingsHousing,ConditionRewindBuildingsClosedB);
               break;
            case 53:
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_53"),new Point(595,291),false,false,ConditionNewBuilding,ConditionRewindBuildingsDeselect15);
               break;
            case 54:
               SPRITES.SetupSprite("C1");
               MAP._canScroll = true;
               QUEUE._placed = 0;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_54"),null,false,false,ConditionPlacedBuilding,ConditionRewindNoNewBuildingB);
               break;
            case 55:
               if(QUESTS._global.b15lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_55"),null,false,false,ConditionStoreOpen,ConditionConstructed15);
               break;
            case 56:
               if(QUESTS._global.b15lvl > 0)
               {
                  Advance();
                  break;
               }
               if(!GLOBAL._selectedBuilding._type == 15)
               {
                  Rewind();
                  break;
               }
               if(_freeSpeedup)
               {
                  Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_56"),ARROW_STORE_BUY_1,false,false,ConditionConstructed15,ConditionRewindStoreClosed);
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_56_b"),ARROW_STORE_BUY_3,false,false,ConditionConstructed15,ConditionRewindStoreClosed);
               break;
            case 57:
               BASE.BuildingDeselect();
               _loc4_ = GRID.ToISO(-600,0,0);
               _loc5_ = Point.distance(new Point(GLOBAL._bHousing.x,GLOBAL._bHousing.y),_loc4_);
               _loc7_ = 0;
               while(_loc7_ < 50)
               {
                  HOUSING.HousingStore("C1",new Point(_loc4_.x - 200 + Math.random() * 400,_loc4_.y - 100 + Math.random() * 200),false);
                  _loc7_++;
               }
               MAP.Focus(_loc4_.x,_loc4_.y);
               MAP.FocusTo(GLOBAL._bHousing.x,GLOBAL._bHousing.y,int(_loc5_ / 120),0,0,false);
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_57"),POINT_QUEST,false,false,ConditionQuestsOpen,ConditionQuestCollectCR3);
               break;
            case 58:
               _advanceCondition = ConditionQuestCollectCR3;
               break;
            case 60:
               if(!_secondWorker)
               {
                  _stage = 64;
                  Advance();
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_60"),new Point(5 * 60,30),true,true);
               break;
            case 61:
               if(!_secondWorker)
               {
                  _stage = 64;
                  Advance();
                  break;
               }
               UI_BOTTOM.Update();
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_61"),new Point(652,477),false,false,ConditionStoreOpen);
               break;
            case 62:
               if(!_secondWorker)
               {
                  _stage = 64;
                  Advance();
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_62"),new Point(225,200),false,false,Condition2Workers,ConditionRewindStoreClosed);
               break;
            case 63:
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_63"),null,true,true);
               break;
            case 65:
               if(QUESTS._global.b5lvl > 0)
               {
                  Advance();
                  break;
               }
               BUILDINGS._buildingID = 0;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_65"),POINT_BUILDINGS,false,false,ConditionBuildingsOpen);
               break;
            case 66:
               if(QUESTS._global.b5lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_66"),new Point(322,51),false,false,ConditionBuildingsBuildings,ConditionRewindBuildingsClosedC);
               break;
            case 67:
               if(QUESTS._global.b5lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_67"),ARROW_BUILDINGS_FLINGER,false,false,ConditionBuildingsFlinger,ConditionRewindBuildingsClosedC);
               break;
            case 68:
               if(QUESTS._global.b5lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_68"),new Point(595,291),false,false,ConditionNewBuilding,ConditionRewindBuildingsDeselect5);
               break;
            case 69:
               if(QUESTS._global.b5lvl > 0)
               {
                  Advance();
                  break;
               }
               QUEUE._placed = 0;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_69"),null,false,false,ConditionPlacedBuilding,ConditionRewindNoNewBuildingC);
               break;
            case 80:
               if(!_secondWorker)
               {
                  Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_69_b"),null,false,false,ConditionStoreOpen);
                  break;
               }
               Advance();
               break;
            case 81:
               if(!_secondWorker)
               {
                  if(_freeSpeedup)
                  {
                     Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_98"),ARROW_STORE_BUY_4,false,false,ConditionConstructed5);
                     _mcArrow.rotation = 70;
                     break;
                  }
                  Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_98"),ARROW_STORE_BUY_3,false,false,ConditionConstructed5);
                  break;
               }
               Advance();
               break;
            case 90:
               if(QUESTS._global.b11lvl > 0)
               {
                  Advance();
                  break;
               }
               BUILDINGS._buildingID = 0;
               if(_secondWorker)
               {
                  Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_90"),POINT_BUILDINGS,false,false,ConditionBuildingsOpen);
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_90_b"),POINT_BUILDINGS,false,false,ConditionBuildingsOpen);
               break;
            case 91:
               if(QUESTS._global.b11lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_91"),new Point(322,51),false,false,ConditionBuildingsBuildings,ConditionRewindBuildingsClosedD);
               break;
            case 92:
               if(QUESTS._global.b11lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_92"),ARROW_BUILDINGS_MAPROOM,false,false,ConditionBuildingsMapRoom,ConditionRewindBuildingsDeselectBuildingsD);
               break;
            case 93:
               if(QUESTS._global.b11lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_93"),new Point(595,291),false,false,ConditionNewBuilding,ConditionRewindBuildingsDeselect11);
               break;
            case 94:
               if(QUESTS._global.b11lvl > 0)
               {
                  Advance();
                  break;
               }
               QUEUE._placed = 0;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_94"),null,false,false,ConditionPlacedBuilding,ConditionRewindNoNewBuildingD);
               break;
            case 95:
               if(QUESTS._global.b5lvl > 0 || !_secondWorker)
               {
                  Advance();
                  break;
               }
               for each(_loc2_ in BASE._buildingsAll)
               {
                  if(_loc2_._type == 5)
                  {
                     MAP.Focus(_loc2_.x,_loc2_.y);
                     _loc1_.x = _loc2_.x + MAP._GROUND.x;
                     _loc1_.y = _loc2_.y + MAP._GROUND.y + 20;
                     break;
                  }
               }
               MAP._canScroll = false;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_95"),_loc1_,false,false,ConditionStoreOpen,ConditionConstructed5);
               break;
            case 96:
               MAP._canScroll = true;
               if(QUESTS._global.b5lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_96"),ARROW_STORE_BUY_4,false,false,ConditionConstructed5,ConditionRewindStoreClosed);
               _mcArrow.rotation = 70;
               break;
            case 97:
               if(QUESTS._global.b11lvl > 0)
               {
                  Advance();
                  break;
               }
               MAP._canScroll = false;
               for each(_loc2_ in BASE._buildingsAll)
               {
                  if(_loc2_._type == 11)
                  {
                     MAP.Focus(_loc2_.x,_loc2_.y);
                     _loc1_.x = _loc2_.x + MAP._GROUND.x;
                     _loc1_.y = _loc2_.y + MAP._GROUND.y + 20;
                     break;
                  }
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_97"),_loc1_,false,false,ConditionStoreOpen,ConditionConstructed11);
               break;
            case 98:
               MAP._canScroll = true;
               if(QUESTS._global.b11lvl > 0)
               {
                  Advance();
                  break;
               }
               if(_freeSpeedup)
               {
                  Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_98"),ARROW_STORE_BUY_4,false,false,ConditionConstructed11,ConditionRewindStoreClosed);
                  _mcArrow.rotation = 70;
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_98"),ARROW_STORE_BUY_3,false,false,ConditionConstructed11,ConditionRewindStoreClosed);
               break;
            case 99:
               MAP._canScroll = true;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_99"),POINT_QUEST,false,false,ConditionQuestsOpen,ConditionQuestCollectBunch);
               break;
            case 100:
               _advanceCondition = ConditionQuestCollectBunch;
               _rewindCondition = ConditionRewindQuestsClose;
               break;
            case 101:
               BASE.BuildingDeselect();
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_101"),POINT_MAP,false,false,ConditionMapRoomOpen);
               break;
            case 102:
               if(!MAPROOM._open)
               {
                  Rewind();
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_102"),null,false,false,ConditionFightBack,ConditionRewindMapClosed);
               break;
            case 110:
               MAP.Focus(-200,0);
               MAP.FocusTo(200,0,5,0,0,false);
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_110"),null,true,true);
               break;
            case 111:
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_111"),new Point(102,152),false,false,ConditionFlingerAdd15,ConditionFlung);
               break;
            case 112:
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_112"),new Point(9 * 60,345),false,false,ConditionFlung);
               break;
            case 113:
               _timer = 0;
               _loc3_ = 0;
               for each(_loc8_ in GLOBAL._attackerCreatures)
               {
                  _loc3_ += _loc8_.Get();
               }
               if(_loc3_ > 0)
               {
                  Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_113_more"),null,false,false,ConditionTimer10);
                  break;
               }
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_113"),null,false,false,ConditionTimer5);
               break;
            case 114:
               _timer = 0;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_114"),null,false,false,ConditionTimer5);
               break;
            case 115:
               _timer = 0;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_115"),new Point(5 * 60,60),false,false,ConditionTimer5);
               break;
            case 116:
               _timer = 0;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_116"),null,false,false,ConditionCrushedEnemy);
               break;
            case 2 * 60:
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_120"),null,false,false,ConditionReturnToYard);
               break;
            case 130:
               QUESTS.Check("destroy_tribe1",1);
               MAP._canScroll = false;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_130"),new Point(84,60),false,false,ConditionPopupClose);
               break;
            case 131:
               QUESTS.Check("destroy_tribe1",1);
               MAP._canScroll = false;
               Add(6,BOBBOTTOMLEFTLOW,KEYS.Get("tut_131"),POINT_QUEST,false,false,ConditionQuestsOpen,ConditionQuestCollectWM1);
               break;
            case 132:
               QUESTS.Check("destroy_tribe1",1);
               MAP._canScroll = false;
               _advanceCondition = ConditionQuestCollectWM1;
               break;
            case 140:
               if(QUESTS._global.b13lvl > 0)
               {
                  Advance();
                  break;
               }
               MAP._canScroll = true;
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_140"),POINT_BUILDINGS,false,false,ConditionBuildingsOpen);
               break;
            case 141:
               if(QUESTS._global.b13lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_141"),new Point(322,51),false,false,ConditionBuildingsBuildings,ConditionRewindBuildingsClosedE);
               break;
            case 142:
               if(QUESTS._global.b13lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_142"),ARROW_BUILDINGS_HATCHERY,false,false,ConditionBuildingsHatchery,ConditionRewindBuildingsClosedE);
               break;
            case 143:
               if(QUESTS._global.b13lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_143"),new Point(595,291),false,false,ConditionNewBuilding,ConditionRewindBuildingsDeselect13);
               break;
            case 144:
               if(QUESTS._global.b13lvl > 0)
               {
                  Advance();
                  break;
               }
               QUEUE._placed = 0;
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_144"),null,false,false,ConditionPlacedBuilding,ConditionRewindNoNewBuildingE);
               break;
            case 145:
               if(QUESTS._global.b13lvl > 0)
               {
                  Advance();
                  break;
               }
               MAP._canScroll = false;
               for each(_loc2_ in BASE._buildingsAll)
               {
                  if(_loc2_._type == 13)
                  {
                     MAP.Focus(_loc2_.x,_loc2_.y);
                     _loc1_.x = _loc2_.x + MAP._GROUND.x;
                     _loc1_.y = _loc2_.y + MAP._GROUND.y + 20;
                     break;
                  }
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_145"),null,false,false,ConditionStoreOpen,ConditionConstructed13);
               break;
            case 146:
               MAP._canScroll = true;
               if(QUESTS._global.b13lvl > 0)
               {
                  Advance();
                  break;
               }
               if(_freeSpeedup)
               {
                  Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_146"),ARROW_STORE_BUY_4,false,false,ConditionConstructed13,ConditionRewindStoreClosed);
                  _mcArrow.rotation = 70;
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_146"),ARROW_STORE_BUY_3,false,false,ConditionConstructed13,ConditionRewindStoreClosed);
               break;
            case 150:
               MAP._canScroll = false;
               for each(_loc2_ in BASE._buildingsAll)
               {
                  if(_loc2_._type == 13)
                  {
                     MAP.Focus(_loc2_.x,_loc2_.y);
                     _loc1_.x = _loc2_.x + MAP._GROUND.x;
                     _loc1_.y = _loc2_.y + MAP._GROUND.y + 20;
                     break;
                  }
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_150"),_loc1_,false,false,ConditionHatcheryOpen);
               break;
            case 151:
               MAP._canScroll = true;
               _timer = 0;
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_151"),new Point(130,217),false,false,ConditionHatcheryProducing,ConditionRewindHatcheryClose);
               break;
            case 152:
               Add(1,BOBBOTTOMLEFTLOW,KEYS.Get("tut_152"),new Point(730,21),false,false,ConditionHatcheryClose);
               break;
            case 160:
               if(QUESTS._global.b3lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_160"),POINT_BUILDINGS,false,false,ConditionBuildingsOpen);
               break;
            case 161:
               if(QUESTS._global.b3lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_161"),new Point(216,50),false,false,ConditionBuildingsResources,ConditionRewindBuildingsClosedF);
               break;
            case 162:
               if(QUESTS._global.b3lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_162"),new Point(353,256),false,false,ConditionBuildingsPutty,ConditionRewindBuildingsClosedF);
               break;
            case 163:
               if(QUESTS._global.b3lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_163"),new Point(595,291),false,false,ConditionNewBuilding,ConditionRewindBuildingsDeselect3);
               break;
            case 164:
               if(QUESTS._global.b3lvl > 0)
               {
                  Advance();
                  break;
               }
               QUEUE._placed = 0;
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_164"),null,false,false,ConditionPlacedBuilding,ConditionRewindNoNewBuildingF);
               break;
            case 170:
               if(!_secondWorker)
               {
                  _stage = 179;
                  Advance();
                  break;
               }
               if(QUESTS._global.b4lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_170"),POINT_BUILDINGS,false,false,ConditionBuildingsOpen);
               break;
            case 171:
               if(QUESTS._global.b4lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_171"),new Point(5 * 60,5 * 60),false,false,ConditionBuildingsResources,ConditionRewindBuildingsClosedG);
               break;
            case 172:
               if(QUESTS._global.b4lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_172"),new Point(488,245),false,false,ConditionBuildingsGoo,ConditionRewindBuildingsClosedG);
               break;
            case 173:
               if(QUESTS._global.b4lvl > 0)
               {
                  Advance();
                  break;
               }
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_173"),new Point(595,291),false,false,ConditionNewBuilding,ConditionRewindBuildingsDeselect4);
               break;
            case 174:
               if(QUESTS._global.b4lvl > 0)
               {
                  Advance();
                  break;
               }
               QUEUE._placed = 0;
               Add(2,BOBBOTTOMLEFTLOW,KEYS.Get("tut_174"),null,false,false,ConditionPlacedBuilding,ConditionRewindNoNewBuildingG);
               break;
            case 3 * 60:
               Add(1,BOBBOTTOMLEFTHIGH,KEYS.Get("tut_180"),null,true,true);
               break;
            case 181:
               Add(1,BOBBOTTOMLEFTHIGH,KEYS.Get("tut_181"),null,true,true);
               break;
            case 190:
               UI2.Update();
               Add(1,BOBBOTTOMLEFTHIGH,KEYS.Get("tut_190"),new Point(572,23),true,true);
               break;
            case 191:
               Add(1,BOBBOTTOMLEFTHIGH,KEYS.Get("tut_191"),POINT_QUEST,true,true);
               break;
            case 192:
               if(GLOBAL._flags.showProgressBar == 1)
               {
                  UI_PROGRESSBAR.Show();
               }
               else
               {
                  UI_WORKERS.Show();
               }
               BASE.Save();
               Advance();
               break;
            default:
               if(_stage >= 205)
               {
                  _stage = 205;
                  break;
               }
               Advance();
               break;
         }
      }
      
      private static function Add(param1:int, param2:Point, param3:String, param4:Point = null, param5:Boolean = false, param6:Boolean = false, param7:Function = null, param8:Function = null) : *
      {
         param2 = AdjustPoint(param2,"bob");
         param4 = AdjustPoint(param4,"hand");
         _mcBob.x = param2.x;
         _mcBob.y = param2.y;
         _mcBob.Say(param3,param6,param5);
         if(param5)
         {
            _advanceCondition = null;
         }
         else
         {
            _advanceCondition = param7;
         }
         _rewindCondition = param8;
         if(_stage < 200)
         {
            _mcBob.mcButton.SetupKey("tut_next_btn");
         }
         else
         {
            _mcBob.mcButton.SetupKey("tut_finish_btn");
         }
         if(param6)
         {
            _mcBob.mcBlocker.visible = true;
         }
         else
         {
            _mcBob.mcBlocker.visible = false;
         }
         _mcBob.mcArrow.visible = false;
         if(param5)
         {
            if(_stage <= 5)
            {
               _mcBob.mcArrow.visible = true;
            }
            _mcBob.mcButton.visible = true;
            _mcBob.mcBubble.height = _mcBob.mcText.height + 55;
            _advanceCondition = null;
         }
         else
         {
            _mcBob.mcButton.visible = false;
            _mcBob.mcBubble.height = _mcBob.mcText.height + 15;
            _advanceCondition = param7;
         }
         _mcBob.mcText.y = 0 - _mcBob.mcBubble.height + 10;
         if(param4)
         {
            _mcArrow.x = param4.x;
            _mcArrow.y = param4.y;
            _mcArrow.Rotate();
            _mcArrow.mcArrow.mcArrow.y = -82;
            TweenLite.to(_mcArrow.mcArrow.mcArrow,0.6,{
               "y":-72,
               "ease":Elastic.easeOut
            });
            _doArrow = _container.addChild(_mcArrow);
         }
         _doBob = _container.addChild(_mcBob);
      }
      
      private static function ConditionScroll() : *
      {
         if(MAP._dragDistance > 100)
         {
            Advance();
         }
      }
      
      private static function ConditionSelectTwig() : *
      {
         if(GLOBAL._selectedBuilding && GLOBAL._selectedBuilding._type != 1)
         {
            BASE.BuildingDeselect();
         }
         if(GLOBAL._selectedBuilding && GLOBAL._selectedBuilding._type == 1)
         {
            Advance();
         }
      }
      
      private static function ConditionBank() : *
      {
         if(BASE._bankedValue > 0)
         {
            Advance();
         }
      }
      
      private static function ConditionDeselectTwig() : *
      {
         if(!GLOBAL._selectedBuilding || GLOBAL._selectedBuilding._type != 1)
         {
            Rewind();
         }
      }
      
      private static function ConditionQuestCollectQ1() : *
      {
         if(QUESTS._completed.Q1 == 2)
         {
            Advance();
         }
      }
      
      private static function ConditionQuestCollectQ2() : *
      {
         if(QUESTS._completed.Q2 == 2)
         {
            Advance();
         }
      }
      
      private static function ConditionQuestCollectU1() : *
      {
         if(QUESTS._completed.U1 == 2)
         {
            Advance();
         }
      }
      
      private static function ConditionQuestCollectT1() : *
      {
         if(QUESTS._completed.T1 == 2)
         {
            Advance();
         }
      }
      
      private static function ConditionQuestCollectD1() : *
      {
         if(QUESTS._completed.D1 == 2)
         {
            Advance();
         }
      }
      
      private static function ConditionQuestCollectWM1() : *
      {
         if(QUESTS._completed.WM1 == 2)
         {
            Advance();
         }
      }
      
      private static function ConditionQuestCollectCR3() : *
      {
         if(QUESTS._completed.CR3 == 2)
         {
            Advance();
         }
      }
      
      private static function ConditionQuestCollectBunch() : *
      {
         if(QUESTS._completed.C17 == 2 && QUESTS._completed.C18 == 2)
         {
            Advance();
         }
      }
      
      private static function ConditionPopupOpen() : *
      {
         if(POPUPS._open)
         {
            Advance();
         }
      }
      
      private static function ConditionPopupClose() : *
      {
         if(!POPUPS._open)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingOptionsOpen() : *
      {
         if(BUILDINGOPTIONS._open)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingOptionsClose() : *
      {
         if(!BUILDINGOPTIONS._open)
         {
            Advance();
         }
      }
      
      private static function ConditionStoreOpen() : *
      {
         if(STORE._open)
         {
            Advance();
         }
      }
      
      private static function ConditionStoreClose() : *
      {
         if(!STORE._open)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingsOpen() : *
      {
         if(BUILDINGS._open)
         {
            Advance();
         }
      }
      
      private static function ConditionMapRoomOpen() : *
      {
         if(MAPROOM._open)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingsDefense() : *
      {
         if(BUILDINGS._open && BUILDINGS._menuA == 3)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingsBuildings() : *
      {
         if(BUILDINGS._open && BUILDINGS._menuA == 2)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingsResources() : *
      {
         if(BUILDINGS._open && BUILDINGS._menuA == 1)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingsSniper() : *
      {
         if(BUILDINGS._open && BUILDINGS._buildingID == 21)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingsHatchery() : *
      {
         if(BUILDINGS._open && BUILDINGS._buildingID == 13)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingsHousing() : *
      {
         if(BUILDINGS._open && BUILDINGS._buildingID == 15)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingsPutty() : *
      {
         if(BUILDINGS._open && BUILDINGS._buildingID == 3)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingsGoo() : *
      {
         if(BUILDINGS._open && BUILDINGS._buildingID == 4)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingsFlinger() : *
      {
         if(BUILDINGS._open && BUILDINGS._buildingID == 5)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingsMapRoom() : *
      {
         if(BUILDINGS._open && BUILDINGS._buildingID == 11)
         {
            Advance();
         }
      }
      
      private static function ConditionHatcheryProducing() : *
      {
         ++_timer;
         if(Boolean((GLOBAL._bHatchery as BUILDING13)._inProduction) && _timer > 160)
         {
            Advance();
         }
      }
      
      private static function ConditionNewBuilding() : *
      {
         if(GLOBAL._newBuilding)
         {
            Advance();
         }
      }
      
      private static function ConditionPlacedBuilding() : *
      {
         if(QUEUE._placed > 0)
         {
            Advance();
         }
      }
      
      private static function ConditionWorkerBusy() : *
      {
         if(QUEUE._workingCount > 0)
         {
            Advance();
         }
      }
      
      private static function ConditionConstructed21() : *
      {
         if(QUESTS._global.b21lvl > 0)
         {
            Advance();
         }
      }
      
      private static function ConditionConstructed15() : *
      {
         if(QUESTS._global.b15lvl > 0)
         {
            Advance();
         }
      }
      
      private static function ConditionConstructed5() : *
      {
         if(QUESTS._global.b5lvl > 0)
         {
            Advance();
            _mcArrow.rotation = 0;
         }
      }
      
      private static function ConditionConstructed11() : *
      {
         if(QUESTS._global.b11lvl > 0)
         {
            Advance();
         }
      }
      
      private static function ConditionConstructed13() : *
      {
         if(QUESTS._global.b13lvl > 0)
         {
            Advance();
         }
      }
      
      private static function ConditionAttackOver() : *
      {
         if(CREEPS._creepCount == 2)
         {
            CREEPS.Retreat();
         }
         if(!WMATTACK._inProgress)
         {
            Advance();
         }
      }
      
      private static function Condition2Workers() : *
      {
         if(QUEUE._workerCount > 1)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingFlinger() : *
      {
         if(GLOBAL._bFlinger)
         {
            Advance();
         }
      }
      
      private static function ConditionBuildingMapRoom() : *
      {
         if(GLOBAL._bMap)
         {
            Advance();
         }
      }
      
      private static function ConditionRewindBuildingOptionsClose() : *
      {
         if(!BUILDINGOPTIONS._open)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindNotUpgrading() : *
      {
         if(QUEUE._workingCount == 0)
         {
            _stage = 9;
            Advance();
         }
      }
      
      private static function ConditionRewindNotLevel2() : *
      {
         if(QUESTS._global.blvl < 2)
         {
            _stage = 19;
            Advance();
         }
      }
      
      private static function ConditionTimer5() : *
      {
         ++_timer;
         if(_timer == 200)
         {
            Advance();
         }
      }
      
      private static function ConditionTimer10() : *
      {
         ++_timer;
         if(_timer == 400)
         {
            Advance();
         }
      }
      
      private static function ConditionFightBack() : *
      {
         if(GLOBAL._mode == "wmattack")
         {
            Advance();
         }
      }
      
      private static function ConditionReturnToYard() : *
      {
         if(GLOBAL._mode == "build")
         {
            Advance();
         }
      }
      
      private static function ConditionFlingerAdd15() : *
      {
         var _loc2_:SecNum = null;
         var _loc1_:int = 0;
         for each(_loc2_ in ATTACK._flingerBucket)
         {
            _loc1_ += _loc2_.Get();
         }
         if(_loc1_ >= 15)
         {
            Advance();
         }
      }
      
      private static function ConditionFlung() : *
      {
         if(CREEPS._creepCount > 0)
         {
            Advance();
         }
      }
      
      private static function ConditionCrushedEnemy() : *
      {
         var _loc3_:BFOUNDATION = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for each(_loc3_ in BASE._buildingsAll)
         {
            if(_loc3_._class != "wall")
            {
               _loc1_ += _loc3_._hp.Get();
               _loc2_ += 1;
            }
         }
         if(_loc1_ <= 0)
         {
            Advance();
         }
      }
      
      private static function ConditionQuestsOpen() : *
      {
         if(QUESTS._open)
         {
            Advance();
         }
      }
      
      private static function ConditionHatcheryOpen() : *
      {
         if(HATCHERY._open)
         {
            Advance();
         }
      }
      
      private static function ConditionHatcheryClose() : *
      {
         if(!HATCHERY._open)
         {
            Advance();
         }
      }
      
      private static function ConditionRewindDeselect() : *
      {
         if(!GLOBAL._selectedBuilding)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindBuildingsClosed() : *
      {
         if(!BUILDINGS._open)
         {
            _stage = 30;
            Advance();
         }
      }
      
      private static function ConditionRewindBuildingsClosedB() : *
      {
         if(!BUILDINGS._open)
         {
            _stage = 49;
            Advance();
         }
      }
      
      private static function ConditionRewindBuildingsClosedC() : *
      {
         if(!BUILDINGS._open)
         {
            _stage = 61;
            Advance();
         }
      }
      
      private static function ConditionRewindBuildingsClosedD() : *
      {
         if(!BUILDINGS._open)
         {
            _stage = 89;
            Advance();
         }
      }
      
      private static function ConditionRewindBuildingsClosedE() : *
      {
         if(!BUILDINGS._open)
         {
            _stage = 139;
            Advance();
         }
      }
      
      private static function ConditionRewindBuildingsClosedF() : *
      {
         if(!BUILDINGS._open)
         {
            _stage = 159;
            Advance();
         }
      }
      
      private static function ConditionRewindBuildingsClosedG() : *
      {
         if(!BUILDINGS._open)
         {
            _stage = 169;
            Advance();
         }
      }
      
      private static function ConditionRewindQuestsClose() : *
      {
         if(!QUESTS._open)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindNoNewBuilding() : *
      {
         if(!GLOBAL._newBuilding)
         {
            _stage = 31;
            Advance();
         }
      }
      
      private static function ConditionRewindNoNewBuildingB() : *
      {
         if(!GLOBAL._newBuilding)
         {
            _stage = 51;
            Advance();
         }
      }
      
      private static function ConditionRewindNoNewBuildingC() : *
      {
         if(!GLOBAL._newBuilding)
         {
            _stage = 61;
            Advance();
         }
      }
      
      private static function ConditionRewindNoNewBuildingD() : *
      {
         if(!GLOBAL._newBuilding)
         {
            _stage = 89;
            Advance();
         }
      }
      
      private static function ConditionRewindNoNewBuildingE() : *
      {
         if(!GLOBAL._newBuilding)
         {
            _stage = 139;
            Advance();
         }
      }
      
      private static function ConditionRewindNoNewBuildingF() : *
      {
         if(!GLOBAL._newBuilding)
         {
            _stage = 159;
            Advance();
         }
      }
      
      private static function ConditionRewindNoNewBuildingG() : *
      {
         if(!GLOBAL._newBuilding)
         {
            _stage = 169;
            Advance();
         }
      }
      
      private static function ConditionRewindHatcheryClose() : *
      {
         if(!HATCHERY._open)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindStoreClosed() : *
      {
         if(!STORE._open)
         {
            Rewind();
            _mcArrow.rotation = 0;
         }
      }
      
      private static function ConditionRewindBuildingsDeselect21() : *
      {
         if(!BUILDINGS._open)
         {
            _stage = 30;
            Advance();
         }
         if(BUILDINGS._buildingID == 0)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindBuildingsDeselect3() : *
      {
         ConditionRewindBuildingsClosedF();
         if(BUILDINGS._buildingID == 0)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindBuildingsDeselect4() : *
      {
         ConditionRewindBuildingsClosedG();
         if(BUILDINGS._buildingID == 0)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindBuildingsDeselect5() : *
      {
         ConditionRewindBuildingsClosedC();
         if(BUILDINGS._buildingID == 0)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindBuildingsDeselect11() : *
      {
         ConditionRewindBuildingsClosedD();
         if(BUILDINGS._buildingID == 0)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindBuildingsDeselect13() : *
      {
         ConditionRewindBuildingsClosedE();
         if(BUILDINGS._buildingID == 0)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindBuildingsDeselect15() : *
      {
         ConditionRewindBuildingsClosedB();
         if(BUILDINGS._buildingID == 0)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindBuildingsDeselectBuildingsC() : *
      {
         if(!BUILDINGS._open)
         {
            _stage = 64;
            Advance();
         }
         if(BUILDINGS._open && BUILDINGS._menuA != 2)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindBuildingsDeselectBuildingsD() : *
      {
         if(!BUILDINGS._open)
         {
            _stage = 89;
            Advance();
         }
         if(BUILDINGS._open && BUILDINGS._menuA != 2)
         {
            Rewind();
         }
      }
      
      private static function ConditionRewindMapClosed() : *
      {
         if(!MAPROOM._open)
         {
            _stage = 99;
            Advance();
         }
      }
      
      private static function AdjustPoint(param1:Point = null, param2:String = "") : Point
      {
         var _loc3_:int = 0;
         var _loc4_:int = GLOBAL._ROOT.stage.stageWidth;
         if(param1)
         {
            if(param1.x > 470 && param1.y > 385)
            {
               _loc3_ = 760 - param1.x;
               param1.x = 760 + (_loc4_ - 760) * 0.5 - _loc3_;
            }
            else if(param1.x < 465 && param1.y > 358)
            {
               param1.x -= (_loc4_ - 760) * 0.5;
            }
            else if(param1.x < 150 && param1.y < 230)
            {
               param1.x -= (_loc4_ - 760) * 0.5;
            }
            else if(param1.x > 470 && param1.y > 385)
            {
               _loc3_ = 760 - param1.x;
               param1.x = 760 + (_loc4_ - 760) * 0.5 - _loc3_;
            }
            return param1;
         }
         return null;
      }
   }
}
