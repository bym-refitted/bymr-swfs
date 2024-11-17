package
{
   import com.monsters.maproom_advanced.MapRoom;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class UI_VISITOR extends UI_VISITOR_CLIP
   {
      public static var _helpButtons:MovieClip;
      
      public function UI_VISITOR()
      {
         super();
         if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
         {
            mc.mcBG.width = 100;
            mc.bReturn.SetupKey("btn_endattack");
            mc.bAttack.visible = false;
         }
         else if(Boolean(GLOBAL._advancedMap) && !BASE.isInferno())
         {
            mc.bReturn.SetupKey("btn_openmap");
            if(GLOBAL._mode != "help" && !MapRoom._viewOnly && GLOBAL._currentCell && MapRoom._flingerInRange)
            {
               if(GLOBAL._currentCell._destroyed)
               {
                  mc.bAttack.SetupKey("newmap_take_btn");
               }
               else
               {
                  mc.bAttack.SetupKey("map_attack_btn");
               }
               mc.bAttack.addEventListener(MouseEvent.CLICK,this.Attack);
               mc.bAttack.visible = true;
               if(GLOBAL._currentCell._locked != 0 && GLOBAL._currentCell._locked != LOGIN._playerID)
               {
                  mc.bAttack.Enabled = false;
               }
               else
               {
                  mc.bAttack.Enabled = true;
               }
            }
            else
            {
               mc.bAttack.visible = false;
               if(GLOBAL._mode != "help")
               {
                  mc.mcBG.width = 100;
               }
            }
         }
         else
         {
            if(GLOBAL._mode != "help")
            {
               mc.mcBG.width = 100;
            }
            mc.bReturn.SetupKey("btn_returnhome");
            mc.bAttack.visible = false;
         }
         mc.bReturn.addEventListener(MouseEvent.CLICK,this.ReturnCB);
         mc.gotoAndStop(1);
         this.Update();
      }
      
      public static function Focus(param1:BFOUNDATION) : Function
      {
         var building:BFOUNDATION = param1;
         return function(param1:MouseEvent = null):void
         {
            MAP.FocusTo(building._mc.x,building._mc.y,0.6);
            BASE.BuildingSelect(building,true);
         };
      }
      
      public function Taunt(param1:MouseEvent = null) : void
      {
         BUILDINGS.Show();
      }
      
      public function Gift(param1:MouseEvent = null) : void
      {
         BUILDINGS.Show();
      }
      
      public function ReturnCB(param1:MouseEvent) : void
      {
         if(GLOBAL._newBuilding)
         {
            GLOBAL._newBuilding.Cancel();
         }
         if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
         {
            ATTACK.End();
         }
         else if(Boolean(GLOBAL._advancedMap) && GLOBAL._loadmode == GLOBAL._mode)
         {
            MapRoom.Setup(GLOBAL._mapHome,MapRoom._worldID,MapRoom._inviteBaseID,MapRoom._viewOnly);
            MapRoom.Show();
         }
         else if(BASE.isInferno())
         {
            if(MAPROOM_DESCENT.InDescent)
            {
               BASE.LoadBase(null,0,0,"build",false,BASE.MAIN_YARD);
            }
            else
            {
               BASE.LoadBase(GLOBAL._infBaseURL,0,0,"ibuild",false,BASE.INFERNO_YARD);
            }
         }
         else
         {
            BASE.LoadBase(null,0,0,"build",false,BASE.MAIN_YARD);
         }
      }
      
      public function Attack(param1:MouseEvent) : void
      {
         if(GLOBAL._currentCell)
         {
         }
         if(GLOBAL._currentCell && GLOBAL._currentCell._locked != 0 && GLOBAL._currentCell._locked != LOGIN._playerID)
         {
            if(GLOBAL._currentCell._online)
            {
               GLOBAL.Message(KEYS.Get("msg_cantattackoccupied"));
            }
            else
            {
               GLOBAL.Message(KEYS.Get("msg_cantattackbeingattacked"));
            }
         }
         else if(GLOBAL._currentCell)
         {
            if(GLOBAL._currentCell._destroyed)
            {
               MapRoom._showEnemyWait = true;
               MapRoom.Show();
            }
            else if(!GLOBAL._currentCell._protected && !(GLOBAL._currentCell._truce && GLOBAL._currentCell._truce > GLOBAL.Timestamp()))
            {
               MapRoom._showAttackWait = true;
               MapRoom.Show();
            }
            else if(GLOBAL._currentCell._protected)
            {
               GLOBAL.Message(KEYS.Get("newmap_dp"));
            }
            else if(Boolean(GLOBAL._currentCell._truce) && GLOBAL._currentCell._truce > GLOBAL.Timestamp())
            {
               GLOBAL.Message(KEYS.Get("newmap_truce"));
            }
         }
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:BFOUNDATION = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
         {
            if(ATTACK._countdown < 0)
            {
               mc.bReturn.Highlight = true;
            }
         }
         else if(GLOBAL._mode == "help")
         {
            if(Boolean(_helpButtons) && mc.contains(_helpButtons))
            {
               mc.removeChild(_helpButtons);
            }
            _helpButtons = mc.addChild(new MovieClip()) as MovieClip;
            _helpButtons.x = 210;
            _helpButtons.y = 5;
            _loc1_ = 0;
            for each(_loc2_ in BASE._buildingsAll)
            {
               if(_loc2_._countdownBuild.Get() + _loc2_._countdownUpgrade.Get() + _loc2_._countdownFortify.Get() > 0)
               {
                  _loc3_ = false;
                  for each(_loc4_ in _loc2_._helpList)
                  {
                     if(_loc4_ == LOGIN._playerID)
                     {
                        _loc3_ = true;
                        break;
                     }
                  }
                  mc.gotoAndStop(2);
                  _loc5_ = new button_buildings();
                  _loc5_.gotoAndStop(_loc2_._type);
                  _loc5_.x = _loc1_ * 45;
                  if(!_loc3_)
                  {
                     _loc5_.buttonMode = true;
                     _loc5_.addEventListener(MouseEvent.CLICK,Focus(_loc2_));
                     _loc5_.mcTick.visible = false;
                  }
                  _helpButtons.addChild(_loc5_);
                  _loc1_++;
               }
            }
            if(_loc1_ > 0)
            {
               mc.mcBG.width = 220 + _loc1_ * 45;
            }
            else
            {
               mc.mcBG.width = 100;
               mc.gotoAndStop(1);
            }
         }
         this.Resize();
      }
      
      public function Resize() : void
      {
         GLOBAL.RefreshScreen();
         mc.x = GLOBAL._SCREEN.x + GLOBAL._SCREEN.width - mc.mcBG.width - 10;
         if(GLOBAL._flags.viximo)
         {
            mc.y = GLOBAL._SCREEN.y + GLOBAL._SCREEN.height - (mc.height + 10);
         }
         else
         {
            mc.y = GLOBAL._SCREENHUD.y - (mc.mcBG.height + 10);
         }
      }
      
      public function checkMapRoomHealth() : void
      {
         var _loc2_:Object = null;
         var _loc3_:BUILDING11 = null;
         var _loc1_:Object = BASE._buildingsAll;
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = _loc2_ as BUILDING11;
            if(_loc3_)
            {
               if(_loc3_._hp.Get() < _loc3_._hpMax.Get() / 2)
               {
                  mc.bReturn.SetupKey("btn_returnhome");
               }
               return;
            }
         }
      }
   }
}

