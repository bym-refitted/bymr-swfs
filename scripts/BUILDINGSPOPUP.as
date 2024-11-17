package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class BUILDINGSPOPUP extends BUILDINGSPOPUP_CLIP
   {
      public var _subButtonsMC:*;
      
      public var _thumbnailsMC:*;
      
      public var _buildingInfoMC:*;
      
      public var _pageCount:int;
      
      public var _excluded:Array;
      
      public var _subButtons:Array;
      
      public function BUILDINGSPOPUP()
      {
         super();
         this._subButtonsMC = null;
         this._thumbnailsMC = null;
         this._buildingInfoMC = null;
         this._pageCount = 0;
         mcNew.visible = GLOBAL._newThings;
         b1.SetupKey("btn_resources");
         b2.SetupKey("btn_buildings");
         b3.SetupKey("btn_defensive");
         b4.SetupKey("btn_decorations");
         b1.addEventListener(MouseEvent.CLICK,this.Switch(1,1,0));
         b2.addEventListener(MouseEvent.CLICK,this.Switch(2,1,0));
         b3.addEventListener(MouseEvent.CLICK,this.Switch(3,1,0));
         b4.addEventListener(MouseEvent.CLICK,this.Switch(4,0,0));
         bPrevious.addEventListener(MouseEvent.CLICK,this.Previous);
         bPrevious.buttonMode = true;
         bNext.addEventListener(MouseEvent.CLICK,this.Next);
         bNext.buttonMode = true;
         if(!GLOBAL._bTownhall)
         {
            this.SwitchB(2,1,0);
         }
         else
         {
            this.SwitchB(BUILDINGS._menuA,BUILDINGS._menuB,BUILDINGS._page);
         }
      }
      
      public function Switch(param1:int, param2:int, param3:int) : *
      {
         var a:int = param1;
         var b:int = param2;
         var p:int = param3;
         return function(param1:MouseEvent):*
         {
            if(param1.target.Enabled)
            {
               SOUNDS.Play("click1");
               SwitchB(a,b,p);
            }
         };
      }
      
      public function Exclude(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] is Array)
            {
               if(this._subButtons)
               {
                  if(param1[_loc2_].length == this._subButtons.length)
                  {
                     _loc3_ = 0;
                     while(_loc3_ < param1[_loc2_].length)
                     {
                        this._subButtons[param1[_loc2_][_loc3_]].Enabled = false;
                        _loc2_++;
                     }
                  }
               }
            }
            else
            {
               this["b" + param1[_loc2_]].Enabled = false;
            }
            _loc2_++;
         }
         this._excluded = param1;
      }
      
      public function SwitchB(param1:int, param2:int, param3:int) : *
      {
         var _loc9_:Object = null;
         var _loc10_:BUILDINGBUTTON = null;
         BUILDINGS._menuA = param1;
         BUILDINGS._menuB = param2;
         BUILDINGS._page = param3;
         var _loc4_:int = 1;
         while(_loc4_ < 5)
         {
            this["b" + _loc4_].Highlight = false;
            _loc4_++;
         }
         this["b" + param1].Highlight = true;
         if(param1 == 4)
         {
            this.SubMenu([KEYS.Get("btn_evil"),KEYS.Get("btn_plants"),KEYS.Get("btn_good"),KEYS.Get("btn_flags"),KEYS.Get("btn_premium")]);
         }
         else
         {
            this.SubMenu([]);
         }
         if(this._thumbnailsMC)
         {
            this.removeChild(this._thumbnailsMC);
         }
         this._thumbnailsMC = this.addChild(new MovieClip());
         this._thumbnailsMC.x = 60;
         this._thumbnailsMC.y = 115;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Array = GLOBAL._buildingProps.concat();
         var _loc8_:int = 0;
         _loc7_.sortOn("order",Array.NUMERIC);
         param2 = 0;
         while(param2 < _loc7_.length)
         {
            _loc9_ = _loc7_[param2];
            if(_loc9_.group == param1 && (_loc9_.subgroup == null || _loc9_.subgroup == BUILDINGS._menuB) && (!_loc9_.block || BASE.BuildingStorageCount(_loc9_.id)))
            {
               if(_loc8_ >= 10 * BUILDINGS._page && _loc8_ < 10 + 10 * BUILDINGS._page)
               {
                  _loc10_ = this._thumbnailsMC.addChild(new BUILDINGBUTTON());
                  _loc10_.x = _loc5_ * 130;
                  _loc10_.y = _loc6_ * 170;
                  _loc10_.Setup(_loc9_.id);
                  _loc5_++;
                  if(_loc5_ == 5)
                  {
                     _loc5_ = 0;
                     _loc6_++;
                  }
                  if(_loc6_ == 2)
                  {
                     _loc6_ = 0;
                  }
               }
               _loc8_++;
            }
            param2++;
         }
         if(_loc8_ == 0)
         {
            this._thumbnailsMC.addChild(new BUILDINGBUTTONSOON());
         }
         this._pageCount = Math.ceil(_loc8_ / 10);
         if(BUILDINGS._page > 0)
         {
            bPrevious.Trigger(true);
         }
         else
         {
            bPrevious.Trigger(false);
         }
         if(BUILDINGS._page < this._pageCount - 1 && TUTORIAL._stage >= 200)
         {
            bNext.Trigger(true);
         }
         else
         {
            bNext.Trigger(false);
         }
      }
      
      public function SubMenu(param1:Array) : *
      {
         var _loc4_:Button = null;
         if(this._subButtonsMC)
         {
            this.removeChild(this._subButtonsMC);
         }
         this._subButtonsMC = this.addChild(new MovieClip());
         var _loc2_:* = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = this._subButtonsMC.addChild(new Button_CLIP());
            _loc4_.x = _loc3_ * 110;
            _loc4_.width = 105;
            _loc4_.Setup(param1[_loc3_]);
            _loc2_.push(_loc4_);
            _loc4_.addEventListener(MouseEvent.CLICK,this.Switch(BUILDINGS._menuA,_loc3_,0));
            if(_loc3_ == BUILDINGS._menuB)
            {
               _loc4_.Highlight = true;
            }
            _loc3_++;
         }
         this._subButtonsMC.x = 380 - this._subButtonsMC.width / 2;
         this._subButtonsMC.y = 75;
      }
      
      public function ShowInfo(param1:int) : void
      {
         BUILDINGS._buildingID = param1;
         if(this._buildingInfoMC)
         {
            this._buildingInfoMC.parent.removeChild(this._buildingInfoMC);
         }
         GLOBAL.BlockerAdd();
         this._buildingInfoMC = GLOBAL._layerWindows.addChild(new BUILDINGOPTIONSPOPUP("build",param1));
         this._buildingInfoMC.x = 380;
         this._buildingInfoMC.y = 260;
      }
      
      public function HideInfo() : *
      {
         if(this._buildingInfoMC)
         {
            GLOBAL.BlockerRemove();
            SOUNDS.Play("close");
            this._buildingInfoMC.parent.removeChild(this._buildingInfoMC);
            this._buildingInfoMC = null;
         }
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         BUILDINGS.Hide();
      }
      
      public function Previous(param1:MouseEvent = null) : *
      {
         if(BUILDINGS._page > 0)
         {
            --BUILDINGS._page;
            this.SwitchB(BUILDINGS._menuA,BUILDINGS._menuB,BUILDINGS._page);
            SOUNDS.Play("click1");
         }
      }
      
      public function Next(param1:MouseEvent = null) : *
      {
         if(BUILDINGS._page < this._pageCount - 1)
         {
            ++BUILDINGS._page;
            this.SwitchB(BUILDINGS._menuA,BUILDINGS._menuB,BUILDINGS._page);
            SOUNDS.Play("click1");
         }
      }
   }
}
