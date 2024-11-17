package com.monsters.inferno
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import flash.display.*;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class InfernoPopupRelocateMe extends PopupRelocateMe_CLIP
   {
      private var _cell:InfernoMapCell;
      
      private var _oldCell:InfernoMapCell;
      
      private var RESOURCECOST:SecNum;
      
      private var SHINYCOST:SecNum;
      
      private var _mode:String;
      
      public function InfernoPopupRelocateMe()
      {
         super();
      }
      
      public function Setup(param1:InfernoMapCell, param2:String = "outpost") : *
      {
         var i:*;
         var resource:MovieClip = null;
         var cell:InfernoMapCell = param1;
         var mode:String = param2;
         this._cell = cell;
         if(!InfernoMap._open)
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
         this.tTitle.htmlText = "<b>" + KEYS.Get("map_relocate") + "</b>";
         if(mode == "invite")
         {
            this.mcInstant.bAction.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               if(this.parent)
               {
                  this.parent.removeChild(this);
               }
               InfernoMap.AcceptInvitation(true);
            });
            this.RESOURCECOST = new SecNum(10000000);
            this.SHINYCOST = new SecNum(20 * 60);
            this.tDescription.htmlText = "<font color=\"#CC0000\">" + KEYS.Get("msg_moveyard_warn") + "</font>";
         }
         else
         {
            this.mcInstant.bAction.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               RelocateConfirm(true);
            });
            this.RESOURCECOST = new SecNum(500 * 60 * 1000);
            this.SHINYCOST = new SecNum(25 * 60);
            this.tDescription.htmlText = "<font color=\"#CC0000\">" + KEYS.Get("msg_movetooutpost_warn") + "</font>";
         }
         this.mcInstant.tDescription.htmlText = "<b>" + KEYS.Get("map_relocateinstant") + "</b>";
         this.mcInstant.bAction.Setup(KEYS.Get("btn_useshiny",{"v1":GLOBAL.FormatNumber(this.SHINYCOST.Get())}));
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
         this.mcResources.bAction.SetupKey("btn_useresources");
         if(mode == "invite")
         {
            this.mcResources.bAction.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               if(this.parent)
               {
                  this.parent.removeChild(this);
               }
               InfernoMap.AcceptInvitation(false);
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
      
      public function Cleanup() : *
      {
         if(this._mode == "invite")
         {
            this.mcInstant.bAction.removeEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               if(this.parent)
               {
                  this.parent.removeChild(this);
               }
               InfernoMap.AcceptInvitation(true);
            });
            this.mcResources.bAction.removeEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               if(this.parent)
               {
                  this.parent.removeChild(this);
               }
               InfernoMap.AcceptInvitation(false);
            });
         }
         else
         {
            this.mcInstant.bAction.removeEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               RelocateConfirm(true);
            });
            this.mcResources.bAction.removeEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               RelocateConfirm(false);
            });
         }
      }
      
      public function Hide() : *
      {
         GLOBAL.BlockerRemove();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
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
               if(param1.cantMoveTill)
               {
                  GLOBAL.Message(KEYS.Get("movebase_warning",{"v1":GLOBAL.ToTime(param1.cantMoveTill - param1.currenttime)}));
                  Hide();
               }
               else
               {
                  GLOBAL._resources.r1max -= GLOBAL._outpostCapacity.Get();
                  GLOBAL._resources.r2max -= GLOBAL._outpostCapacity.Get();
                  GLOBAL._resources.r3max -= GLOBAL._outpostCapacity.Get();
                  GLOBAL._resources.r4max -= GLOBAL._outpostCapacity.Get();
                  LOGGER.Stat([45,useShiny ? SHINYCOST.Get() : 0]);
                  Hide();
                  InfernoMap._mc._popupInfoMine.Hide();
                  InfernoMap.BookmarksClear();
                  GLOBAL._mapOutpost.shift();
                  if(param1.coords && param1.coords.length == 2 && param1.coords[0] > -1 && param1.coords[1] > -1)
                  {
                     GLOBAL._mapHome = new Point(param1.coords[0],param1.coords[1]);
                     InfernoMap.Setup(GLOBAL._mapHome);
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
                  _oldCell = InfernoMap._homeCell;
                  if(_oldCell)
                  {
                     _oldCell._updated = false;
                     _oldCell._dirty = false;
                  }
                  else
                  {
                     LOGGER.Log("err","Null home cell when transfering base");
                  }
                  InfernoMap.ClearCells();
                  PLEASEWAIT.Show(KEYS.Get("wait_packingyard"));
                  addEventListener(Event.ENTER_FRAME,RelocateComplete);
                  InfernoMap.Tick();
               }
            }
            else
            {
               GLOBAL.Message(KEYS.Get("msg_err_relocate") + param1.error);
            }
         };
         RelocateFail = function(param1:IOErrorEvent):*
         {
            Hide();
            GLOBAL.Message(KEYS.Get("msg_err_relocate") + param1.text);
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
               GLOBAL.Message(KEYS.Get("map_rel_res"));
               return;
            }
            relocateVars.push(["resources",com.adobe.serialization.json.JSON.encode({
               "r1":this.RESOURCECOST.Get(),
               "r2":this.RESOURCECOST.Get(),
               "r3":this.RESOURCECOST.Get(),
               "r4":this.RESOURCECOST.Get()
            })]);
         }
         PLEASEWAIT.Show(KEYS.Get("wait_relocating"));
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

