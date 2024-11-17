package com.monsters.maproom_advanced
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import flash.display.*;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class PopupRelocateMe extends PopupRelocateMe_CLIP
   {
      private var _cell:MapRoomCell;
      
      private var _oldCell:MapRoomCell;
      
      private var RESOURCECOST:SecNum;
      
      private var SHINYCOST:SecNum;
      
      private var _mode:String;
      
      public function PopupRelocateMe()
      {
         super();
      }
      
      public function Setup(param1:MapRoomCell, param2:String = "outpost") : *
      {
         var i:*;
         var resource:MovieClip = null;
         var cell:MapRoomCell = param1;
         var mode:String = param2;
         this._cell = cell;
         if(!MapRoom._open)
         {
            x = 365;
            y = 260;
         }
         else
         {
            x = 395;
            y = 260;
         }
         this._mode = mode;
         this.tTitle.htmlText = "<b>Relocate your main yard to this location.</b>";
         if(mode == "invite")
         {
            this.mcInstant.bAction.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               if(this.parent)
               {
                  this.parent.removeChild(this);
               }
               MapRoom.AcceptInvitation(true);
            });
            this.RESOURCECOST = new SecNum(10000000);
            this.SHINYCOST = new SecNum(20 * 60);
            this.tDescription.htmlText = "<font color=\"#CC0000\"><b>WARNING:</b> By relocating to this location you will lose all your outposts in your old empire and start fresh with just your new main yard.</font>";
         }
         else
         {
            this.mcInstant.bAction.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               RelocateConfirm(true);
            });
            this.RESOURCECOST = new SecNum(500 * 60 * 1000);
            this.SHINYCOST = new SecNum(25 * 60);
            this.tDescription.htmlText = "<font color=\"#CC0000\"><b>WARNING:</b> Relocating your yard to this outpost will destroy the outpost and all buildings on it. Wild Monsters will claim your old main yard location.</font>";
         }
         this.mcInstant.tDescription.htmlText = "<b>Keep your resources and relocate instantly!</b>";
         this.mcInstant.bAction.Setup("Use " + GLOBAL.FormatNumber(this.SHINYCOST.Get()) + " Shiny");
         i = 1;
         while(i < 5)
         {
            resource = this.mcResources["mcR" + i];
            resource.gotoAndStop(i);
            resource.tTitle.htmlText = "<b>" + KEYS.Get(GLOBAL._resourceNames[i - 1]) + "</b>";
            resource.tValue.htmlText = "<b>" + GLOBAL.FormatNumber(this.RESOURCECOST.Get()) + "</b>";
            i++;
         }
         this.mcResources.mcTime.visible = false;
         this.mcResources.bAction.Setup("Use Resources");
         if(mode == "invite")
         {
            this.mcResources.bAction.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               if(this.parent)
               {
                  this.parent.removeChild(this);
               }
               MapRoom.AcceptInvitation(false);
            });
         }
         else
         {
            this.mcResources.bAction.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               RelocateConfirm(false);
            });
         }
      }
      
      public function Hide() : *
      {
         GLOBAL.BlockerRemove();
         this.parent.removeChild(this);
      }
      
      public function RelocateConfirm(param1:Boolean) : *
      {
         var RelocateSuccess:Function = null;
         var RelocateFail:Function = null;
         var useShiny:Boolean = param1;
         RelocateSuccess = function(param1:Object):*
         {
            PLEASEWAIT.Hide();
            if(param1.error == 0)
            {
               GLOBAL._resources.r1max -= GLOBAL._outpostCapacity.Get();
               GLOBAL._resources.r2max -= GLOBAL._outpostCapacity.Get();
               GLOBAL._resources.r3max -= GLOBAL._outpostCapacity.Get();
               GLOBAL._resources.r4max -= GLOBAL._outpostCapacity.Get();
               LOGGER.Stat([45,useShiny ? SHINYCOST.Get() : 0]);
               Hide();
               MapRoom._mc._popupInfoMine.Hide();
               MapRoom.BookmarksClear();
               GLOBAL._mapOutpost.shift();
               if(param1.coords && param1.coords.length == 2 && param1.coords[0] > -1 && param1.coords[1] > -1)
               {
                  GLOBAL._mapHome = new Point(param1.coords[0],param1.coords[1]);
                  MapRoom.Setup(GLOBAL._mapHome);
               }
               if(useShiny)
               {
                  GLOBAL._credits.Add(-SHINYCOST.Get());
               }
               else
               {
                  GLOBAL._resources.r1.Add(-RESOURCECOST.Get());
                  GLOBAL._resources.r2.Add(-RESOURCECOST.Get());
                  GLOBAL._resources.r3.Add(-RESOURCECOST.Get());
                  GLOBAL._resources.r4.Add(-RESOURCECOST.Get());
               }
               _cell._updated = false;
               _cell._dirty = true;
               _oldCell = MapRoom._homeCell;
               if(_oldCell)
               {
                  _oldCell._updated = false;
                  _oldCell._dirty = false;
               }
               else
               {
                  LOGGER.Log("err","Null home cell when transfering base");
               }
               MapRoom.ClearCells();
               PLEASEWAIT.Show("Packing Up Yard");
               addEventListener(Event.ENTER_FRAME,RelocateComplete);
               MapRoom.Tick();
            }
            else
            {
               GLOBAL.Message("There was a problem relocating your yard: " + param1.error);
            }
         };
         RelocateFail = function(param1:IOErrorEvent):*
         {
            Hide();
            GLOBAL.Message("There was a problem relocating your yard: " + param1.text);
         };
         var relocateVars:Array = [["type","outpost"],["baseid",this._cell._baseID]];
         if(useShiny)
         {
            if(GLOBAL._credits.Get() < this.SHINYCOST.Get())
            {
               this.Hide();
               POPUPS.DisplayGetShiny();
               return;
            }
            relocateVars.push(["shiny",this.SHINYCOST.Get()]);
         }
         else
         {
            if(GLOBAL._resources.r1.Get() < this.RESOURCECOST.Get() || GLOBAL._resources.r2.Get() < this.RESOURCECOST.Get() || GLOBAL._resources.r3.Get() < this.RESOURCECOST.Get() || GLOBAL._resources.r4.Get() < this.RESOURCECOST.Get())
            {
               this.Hide();
               GLOBAL.Message("You don’t have enough resources to relocate.");
               return;
            }
            relocateVars.push(["resources",com.adobe.serialization.json.JSON.encode({
               "r1":this.RESOURCECOST.Get(),
               "r2":this.RESOURCECOST.Get(),
               "r3":this.RESOURCECOST.Get(),
               "r4":this.RESOURCECOST.Get()
            })]);
         }
         PLEASEWAIT.Show("Relocating Main Yard");
         new URLLoaderApi().load(GLOBAL._baseURL + "migrate",relocateVars,RelocateSuccess,RelocateFail);
      }
      
      private function RelocateComplete(param1:Event) : *
      {
         if(this._cell._updated && this._oldCell._updated)
         {
            removeEventListener(Event.ENTER_FRAME,this.RelocateComplete);
            PLEASEWAIT.Hide();
         }
      }
   }
}
