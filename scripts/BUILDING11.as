package
{
   import com.monsters.alliances.ALLIANCES;
   import com.monsters.maproom_advanced.MapRoom;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING11 extends BFOUNDATION
   {
      private var callPending:Boolean;
      
      public function BUILDING11()
      {
         super();
         _type = 11;
         _footprint = [new Rectangle(0,0,90,90)];
         _gridCost = [[new Rectangle(0,0,90,90),10],[new Rectangle(10,10,70,70),200]];
         SetProps();
      }
      
      override public function Tick() : *
      {
         if(_countdownBuild.Get() + _countdownUpgrade.Get() == 0 && _repairing != 1)
         {
            delete BASE._buildingsCatchup["b" + _id];
         }
         if(_countdownBuild.Get() > 0 || _hp.Get() < _hpMax.Get() * 0.5)
         {
            _canFunction = false;
         }
         else
         {
            _canFunction = true;
         }
         if(_lvl.Get() < 2 && GLOBAL.StatGet("mrl") == 2)
         {
            GLOBAL.StatSet("mrl",1);
         }
         if(GLOBAL._mode == "build" && _lvl.Get() == 2 && GLOBAL.StatGet("mrl") != 2 && BASE._saveCounterA == BASE._saveCounterB && !BASE._saving)
         {
            this.NewWorld();
         }
         if(!GLOBAL._catchup && GLOBAL._render && _countdownUpgrade.Get() && _countdownUpgrade.Get() < 172800)
         {
            this.PopupUpgrade(2);
         }
         super.Tick();
      }
      
      private function NewWorld() : *
      {
         PLEASEWAIT.Show("Entering New World....");
         ACHIEVEMENTS.Check("map2",1);
         if(this.callPending)
         {
            return;
         }
         this.callPending = true;
         var _loc1_:Array = [["version",2]];
         new URLLoaderApi().load(GLOBAL._mapURL + "setmapversion",_loc1_,this.NewWorldSuccess,this.NewWorldFail);
      }
      
      private function NewWorldSuccess(param1:Object) : *
      {
         var _loc2_:int = 0;
         if(param1.error == 0)
         {
            GLOBAL.StatSet("mrl",2,true);
            GLOBAL._newMapFirstOpen = true;
            GLOBAL._advancedMap = 1;
            GLOBAL._baseURL = param1.baseurl;
            GLOBAL._homeBaseID = param1.homebaseid;
            BASE._loadedBaseID = param1.homebaseid;
            BASE._baseID = 0;
            BASE._loadedFriendlyBaseID = GLOBAL._homeBaseID;
            MapRoom.BookmarksClear();
            if(param1.basesaveid != 1)
            {
               BASE._lastSaveID = param1.basesaveid;
            }
            if(param1.homebase.length == 2 && param1.homebase[0] > -1 && param1.homebase[1] > -1)
            {
               if(param1.worldsize)
               {
                  MapRoom._mapWidth = param1.worldsize[0];
                  MapRoom._mapHeight = param1.worldsize[1];
               }
               GLOBAL._mapHome = new Point(param1.homebase[0],param1.homebase[1]);
               if(param1.outposts)
               {
                  GLOBAL._mapOutpost = [];
                  _loc2_ = 0;
                  while(_loc2_ < param1.outposts.length)
                  {
                     if(param1.outposts[_loc2_].length == 2)
                     {
                        GLOBAL._mapOutpost.push(new Point(param1.outposts[_loc2_][0],param1.outposts[_loc2_][1]));
                     }
                     _loc2_++;
                  }
               }
            }
            else
            {
               LOGGER.Log("err","BUILDING11.NewWorldSuccess Invalid home base coordinate. " + param1.homebase);
               GLOBAL.ErrorMessage("BUILDING11 1");
            }
         }
         else
         {
            LOGGER.Log("err",param1.error);
            GLOBAL.ErrorMessage("BUILDING11 2");
         }
         this.callPending = false;
         PLEASEWAIT.Hide();
      }
      
      private function NewWorldFail(param1:IOErrorEvent) : *
      {
         this.callPending = false;
         LOGGER.Log("err","BUILDING11.NewWorld HTTP");
         GLOBAL.ErrorMessage("BUILDING11.NewWorld HTTP");
         PLEASEWAIT.Hide();
      }
      
      override public function PlaceB() : *
      {
         super.PlaceB();
         GLOBAL._bMap = this;
      }
      
      override public function Constructed() : *
      {
         GLOBAL._bMap = this;
         super.Constructed();
      }
      
      override public function UpgradeB() : *
      {
         super.UpgradeB();
         this.PopupUpgrade(1);
      }
      
      public function PopupUpgrade(param1:int) : void
      {
         var Speedup:Function = null;
         var popupMC:popup_generic = null;
         var n:int = param1;
         Speedup = function(param1:MouseEvent = null):*
         {
            POPUPS.Next();
            STORE.SpeedUp("SP4");
         };
         if(GLOBAL.StatGet("mrp") < n && !STORE._open)
         {
            GLOBAL.StatSet("mrp",n);
            GLOBAL._selectedBuilding = GLOBAL._bMap;
            popupMC = new popup_generic();
            popupMC.tA.htmlText = "<b>Backyard Domination</b>";
            popupMC.tB.htmlText = "Speed-up your Map Room upgrade and get a head start on building your backyard empire!";
            popupMC.bAction.Setup("Speed-Up");
            popupMC.bAction.addEventListener(MouseEvent.CLICK,Speedup);
            popupMC.mcImage.x = -200;
            popupMC.mcImage.y = -95;
            POPUPS.Push(popupMC,null,null,null,"mapv2.jpg",true,"now");
         }
      }
      
      override public function Upgraded() : *
      {
         var Brag:Function = null;
         Brag = function():*
         {
            GLOBAL.CallJS("sendFeed",["upgrade-mr",KEYS.Get("newmap_upgraded3"),KEYS.Get("newmap_upgraded1"),"build-maproom.png"]);
            POPUPS.Next();
         };
         POPUPS.DisplayGeneric(KEYS.Get("newmap_upgraded1"),KEYS.Get("newmap_upgraded2"),KEYS.Get("btn_brag"),"building-map.png",Brag);
         PLEASEWAIT.Show("Entering New World...");
         super.Upgraded();
      }
      
      override public function Recycle() : *
      {
         if(GLOBAL._advancedMap)
         {
            if(ALLIANCES._myAlliance != null)
            {
               GLOBAL.Message(KEYS.Get("map_alliance_recycle",{"v1":ALLIANCES._myAlliance.name}));
               return;
            }
            GLOBAL.Message(KEYS.Get("newmap_recycle1"),KEYS.Get("btn_recycle"),this.RecycleD);
         }
         else
         {
            GLOBAL.Message(KEYS.Get("newmap_recycle2"),KEYS.Get("btn_recycle"),this.RecycleD);
         }
      }
      
      private function RecycleD() : *
      {
         var _loc1_:Array = [["version",1]];
         new URLLoaderApi().load(GLOBAL._mapURL + "setmapversion",_loc1_,this.RecycleDSuccess,this.RecycleDFail);
         PLEASEWAIT.Show();
      }
      
      private function RecycleDSuccess(param1:Object) : *
      {
         PLEASEWAIT.Hide();
         if(param1.error == 0)
         {
            GLOBAL.StatSet("mrl",1,true);
            GLOBAL._bMap = null;
            GLOBAL._advancedMap = 0;
            GLOBAL._baseURL = param1.baseurl;
            BASE._baseID = 0;
            BASE._loadedFriendlyBaseID = 0;
            if(param1.basesaveid != 1)
            {
               BASE._lastSaveID = param1.basesaveid;
            }
            MapRoom.BookmarksClear();
            RecycleB();
            if(_lvl.Get() == 2)
            {
               GLOBAL.Message(KEYS.Get("newmap_return"));
            }
         }
         else
         {
            LOGGER.Log("err",param1.error);
            GLOBAL.ErrorMessage("BUILDING11 RecycleD 1");
         }
      }
      
      private function RecycleDFail(param1:IOErrorEvent) : *
      {
         PLEASEWAIT.Hide();
         LOGGER.Log("err","BUILDING11.Recycle HTTP");
         GLOBAL.ErrorMessage("BUILDING11 RecycleD 2");
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         if(_lvl.Get() > 1)
         {
            ACHIEVEMENTS.Check("map2",1);
         }
         if(_countdownBuild.Get() == 0)
         {
            GLOBAL._bMap = this;
         }
      }
   }
}

