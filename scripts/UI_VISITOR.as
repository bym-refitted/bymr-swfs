package
{
   import com.monsters.maproom_advanced.MapRoom;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class UI_VISITOR extends UI_VISITOR_CLIP
   {
      public static var _helpButtons:*;
      
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
         mc.bReturn.addEventListener(MouseEvent.CLICK,this.Return);
         mc.gotoAndStop(1);
         this.Update();
      }
      
      public static function Focus(param1:BFOUNDATION) : *
      {
         var building:BFOUNDATION = param1;
         return function(param1:MouseEvent = null):*
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
      
      public function Return(param1:MouseEvent) : void
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
               BASE.LoadBase(null,null,0,"build",false,BASE.MAIN_YARD);
            }
            else
            {
               BASE.LoadBase(GLOBAL._infBaseURL,0,0,"ibuild",false,BASE.INFERNO_YARD);
            }
         }
         else
         {
            BASE.LoadBase(null,null,0,"build",false,BASE.MAIN_YARD);
         }
      }
      
      public function Attack(param1:MouseEvent) : *
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
      
      public function Update() : *
      {
         var count:int = 0;
         var building:* = undefined;
         var helped:Boolean = false;
         var helper:int = 0;
         var b:MovieClip = null;
         if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
         {
            if(ATTACK._countdown < 0)
            {
               mc.bReturn.Highlight = true;
            }
         }
         else if(GLOBAL._mode == "help")
         {
            try
            {
               if(_helpButtons)
               {
                  mc.removeChild(_helpButtons);
               }
            }
            catch(e:Error)
            {
            }
            _helpButtons = mc.addChild(new MovieClip());
            _helpButtons.x = 210;
            _helpButtons.y = 5;
            count = 0;
            for each(building in BASE._buildingsAll)
            {
               if(building._countdownBuild.Get() + building._countdownUpgrade.Get() + building._countdownFortify.Get() > 0)
               {
                  helped = false;
                  for each(helper in building._helpList)
                  {
                     if(helper == LOGIN._playerID)
                     {
                        helped = true;
                        break;
                     }
                  }
                  mc.gotoAndStop(2);
                  b = new button_buildings();
                  b.gotoAndStop(building._type);
                  b.x = count * 45;
                  if(!helped)
                  {
                     b.buttonMode = true;
                     b.addEventListener(MouseEvent.CLICK,Focus(building));
                     b.mcTick.visible = false;
                  }
                  _helpButtons.addChild(b);
                  count++;
               }
            }
            if(count > 0)
            {
               mc.mcBG.width = 220 + count * 45;
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

