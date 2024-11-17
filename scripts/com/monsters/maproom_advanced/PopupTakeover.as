package com.monsters.maproom_advanced
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import com.monsters.display.ImageCache;
   import flash.display.*;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class PopupTakeover extends MapRoomPopup_takeover_CLIP
   {
      private var _resourceCost:SecNum;
      
      private var _shinyCost:SecNum;
      
      public var _costGap:int;
      
      public var _cell:MapRoomCell;
      
      public function PopupTakeover(param1:MapRoomCell)
      {
         var i:int;
         var bonusTower:int;
         var bonusResource:int;
         var ImageLoaded:Function = null;
         var bonusStr:String = null;
         var numPosts:int = 0;
         var costMC:MovieClip = null;
         var colorString:String = null;
         var cell:MapRoomCell = param1;
         super();
         ImageLoaded = function(param1:String, param2:BitmapData):*
         {
            mcImage.addChild(new Bitmap(param2));
         };
         this._cell = cell;
         this.Center();
         ImageCache.GetImageWithCallBack("popups/outpost-takeover.png",ImageLoaded,true,1);
         this._costGap = 0;
         this._resourceCost = new SecNum(2000000);
         if(GLOBAL._mapOutpost)
         {
            numPosts = int(GLOBAL._mapOutpost.length);
            if(numPosts >= 5)
            {
               this._resourceCost.Set(Math.min(10000000,2000000 + 2000000 * (numPosts - 4)));
            }
         }
         if(POWERUPS.CheckPowers(POWERUPS.ALLIANCE_CONQUEST,"NORMAL"))
         {
            this._resourceCost.Set(POWERUPS.Apply(POWERUPS.ALLIANCE_CONQUEST,[this._resourceCost.Get()]));
         }
         this._shinyCost = new SecNum(Math.ceil(Math.pow(Math.sqrt(this._resourceCost.Get() / 2),0.75) * 4));
         i = 1;
         while(i < 5)
         {
            costMC = this.mcResources["mcR" + i];
            costMC.gotoAndStop(i);
            costMC.tTitle.htmlText = "<b>" + KEYS.Get(GLOBAL._resourceNames[i - 1]) + "</b>";
            colorString = "000000";
            if(GLOBAL._resources["r" + i].Get() <= this._resourceCost)
            {
               colorString = "FF0000";
            }
            else if(GLOBAL._allianceConquestTime.Get() > GLOBAL.Timestamp())
            {
               colorString = "0000FF";
            }
            costMC.tValue.htmlText = "<b><font color=\"#" + (this._resourceCost > GLOBAL._resources["r" + i].Get() ? "FF0000" : "000000") + "\">" + GLOBAL.FormatNumber(this._resourceCost.Get()) + "</font></b>";
            i++;
         }
         bonusTower = this._cell._height * 100 / GLOBAL._averageAltitude.Get() - 100;
         bonusResource = 100 * GLOBAL._averageAltitude.Get() / this._cell._height - 100;
         if(this._cell._height != GLOBAL._averageAltitude.Get())
         {
            if(this._cell._height > GLOBAL._averageAltitude.Get())
            {
               bonusStr = KEYS.Get("bonus_towerrange",{"v1":bonusTower});
            }
            else
            {
               bonusStr = KEYS.Get("bonus_resourceproduction",{"v1":bonusResource});
            }
         }
         if(this._cell._base == 1)
         {
            this.tTitle.htmlText = "<b>" + KEYS.Get("takeover_wildmonsteryard") + "</b>";
         }
         else
         {
            this.tTitle.htmlText = "<b>" + KEYS.Get("takeover_outpost",{"v1":this._cell._name}) + "</b>";
         }
         this.tDescription.htmlText = "<b>" + KEYS.Get("takeover_expand") + (!!bonusStr ? " " + bonusStr : "") + "</b>";
         this.mcResources.mcTime.visible = false;
         this.mcResources.bAction.SetupKey("btn_useresources");
         this.mcResources.bAction.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            TakeOverConfirm(false);
         });
         this.mcInstant.bAction.Setup(KEYS.Get("btn_useshiny",{"v1":this._shinyCost.Get()}));
         this.mcInstant.tDescription.htmlText = KEYS.Get("takeover_instant");
         this.mcInstant.bAction.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            TakeOverConfirm(true);
         });
      }
      
      public function Hide() : *
      {
         GLOBAL.BlockerRemove();
         this.parent.removeChild(this);
      }
      
      public function TakeOverConfirm(param1:Boolean) : *
      {
         var mapIndex:int;
         var r1:int;
         var r2:int;
         var r3:int;
         var r4:int;
         var takeoverVars:Array = null;
         var takeoverSuccessful:Function = null;
         var takeoverError:Function = null;
         var useShiny:Boolean = param1;
         takeoverSuccessful = function(param1:Object):*
         {
            PLEASEWAIT.Hide();
            if(param1.error == 0)
            {
               BASE._takeoverFirstOpen = _cell._base == 1 ? 1 : 2;
               BASE._takeoverPreviousOwnersName = _cell._name;
               MapRoom.GetCell(_cell.X,_cell.Y,true);
               GLOBAL._mapOutpost.push(new Point(_cell.X,_cell.Y));
               GLOBAL._resources.r1max += GLOBAL._outpostCapacity.Get();
               GLOBAL._resources.r2max += GLOBAL._outpostCapacity.Get();
               GLOBAL._resources.r3max += GLOBAL._outpostCapacity.Get();
               GLOBAL._resources.r4max += GLOBAL._outpostCapacity.Get();
               MapRoom.ClearCells();
               MapRoom.Hide();
               GLOBAL._attackerCellsInRange = [];
               GLOBAL._currentCell = _cell;
               GLOBAL._currentCell._base = 3;
               BASE._yardType = BASE.OUTPOST;
               BASE.LoadBase(null,null,_cell._baseID,"build",false,BASE.OUTPOST);
               LOGGER.Stat([37,BASE._takeoverFirstOpen]);
            }
            else
            {
               GLOBAL.Message(KEYS.Get("err_takeoverproblem") + param1.error);
            }
            Hide();
         };
         takeoverError = function(param1:IOErrorEvent):*
         {
            Hide();
            GLOBAL.Message(KEYS.Get("err_takeoverproblem") + param1.text);
         };
         if(useShiny)
         {
            if(GLOBAL._credits.Get() < this._shinyCost.Get())
            {
               POPUPS.DisplayGetShiny();
               return;
            }
            takeoverVars = [["baseid",this._cell._baseID],["shiny",this._shinyCost.Get()]];
         }
         else
         {
            if(GLOBAL._resources.r1.Get() < this._resourceCost.Get() || GLOBAL._resources.r2.Get() < this._resourceCost.Get() || GLOBAL._resources.r3.Get() < this._resourceCost.Get() || GLOBAL._resources.r4.Get() < this._resourceCost.Get())
            {
               GLOBAL.Message(KEYS.Get("newmap_take4"));
               return;
            }
            takeoverVars = [["baseid",this._cell._baseID],["resources",com.adobe.serialization.json.JSON.encode({
               "r1":this._resourceCost.Get(),
               "r2":this._resourceCost.Get(),
               "r3":this._resourceCost.Get(),
               "r4":this._resourceCost.Get()
            })]];
         }
         mapIndex = 1;
         r1 = this._resourceCost.Get();
         r2 = this._resourceCost.Get();
         r3 = this._resourceCost.Get();
         r4 = this._resourceCost.Get();
         PLEASEWAIT.Show(KEYS.Get("plsw_taking"));
         new URLLoaderApi().load(GLOBAL._mapURL + "takeovercell",takeoverVars,takeoverSuccessful,takeoverError);
      }
      
      public function Center() : void
      {
         POPUPSETTINGS.AlignToCenter(this);
      }
   }
}

