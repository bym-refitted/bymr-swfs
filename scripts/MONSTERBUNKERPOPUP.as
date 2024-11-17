package
{
   import com.cc.utils.SecNum;
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MONSTERBUNKERPOPUP extends MONSTERBUNKERPOPUP_CLIP
   {
      public var _juiceList:Object;
      
      private var _bunker:* = null;
      
      private var _capacity:int = 0;
      
      private var _mode:String;
      
      private var _selected:Object;
      
      private var _guidePage:int = 0;
      
      public function MONSTERBUNKERPOPUP()
      {
         var _loc1_:MovieClip = null;
         this._juiceList = {};
         super();
         this._bunker = GLOBAL._selectedBuilding;
         this._capacity = GLOBAL._buildingProps[21].capacity[this._bunker._lvl.Get() - 1];
         this._selected = {};
         this._juiceList = {};
         title_txt.htmlText = KEYS.Get("bunker_title");
         tCapacity.htmlText = "<b>" + KEYS.Get("bunker_capacity") + "</b>";
         bHousing.addEventListener(MouseEvent.CLICK,this.Switch("housing"));
         bHousing.SetupKey("bunker_btn_housing");
         bHousing.buttonMode = true;
         bSpecial.addEventListener(MouseEvent.CLICK,this.Switch("special"));
         bSpecial.SetupKey("bunker_btn_store");
         bSpecial.buttonMode = true;
         bTransfer.addEventListener(MouseEvent.CLICK,this.Transfer);
         bTransfer.Setup(">>");
         bTransfer.buttonMode = true;
         var _loc2_:int = 1;
         while(_loc2_ <= 8)
         {
            _loc1_ = this["house" + _loc2_];
            _loc1_.bAdd.addEventListener(MouseEvent.CLICK,this.SelectAdd);
            _loc1_.bAdd.Setup("+");
            _loc1_.bAdd.buttonMode = true;
            _loc1_.bRemove.addEventListener(MouseEvent.CLICK,this.SelectRemove);
            _loc1_.bRemove.Setup("-");
            _loc1_.bRemove.buttonMode = true;
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= 8)
         {
            _loc1_ = this["bunker" + _loc2_];
            _loc1_.bRemove.addEventListener(MouseEvent.CLICK,this.BunkerJuice);
            if(GLOBAL._bJuicer)
            {
               _loc1_.bRemove.SetupKey("bunker_btn_juice");
            }
            else
            {
               _loc1_.bRemove.SetupKey("bunker_btn_remove");
            }
            _loc1_.bRemove.buttonMode = true;
            _loc2_++;
         }
         this.SwitchB("housing");
      }
      
      public function IconLoaded(param1:String, param2:BitmapData, param3:Array = null) : *
      {
         var _loc4_:Bitmap = new Bitmap(param2);
         _loc4_.smoothing = true;
         param3[0].mcImage.addChild(_loc4_);
         param3[0].mcLoading.visible = false;
      }
      
      private function Switch(param1:String) : *
      {
         var mode:String = param1;
         return function(param1:MouseEvent):*
         {
            SwitchB(mode);
         };
      }
      
      private function SwitchB(param1:String) : *
      {
         SOUNDS.Play("click1");
         this._mode = param1;
         this._selected = {};
         if(this._mode == "housing")
         {
            bHousing.Enabled = false;
            bSpecial.Enabled = true;
         }
         else
         {
            bHousing.Enabled = true;
            bSpecial.Enabled = false;
         }
         this.Update();
      }
      
      public function Update() : *
      {
         var monsterID:String = null;
         var c:String = null;
         var goo:int = 0;
         var creatureProps:Object = null;
         var i:int = 0;
         var n:int = 0;
         var v:int = 0;
         var barMC:MovieClip = null;
         var p:int = 0;
         var arr:Array = null;
         var quantity:* = undefined;
         var count:int = 0;
         var usedA:int = 0;
         var usedB:int = 0;
         try
         {
            if(this._mode == "housing")
            {
               n = 1;
               i = 1;
               while(i <= 13)
               {
                  if(n < 9 && (HOUSING._creatures["C" + i] && HOUSING._creatures["C" + i].Get() > 0) || this._selected["C" + i] && this._selected["C" + i].Get() > 0)
                  {
                     barMC = this["house" + n];
                     if(!barMC.visible)
                     {
                        barMC.visible = true;
                     }
                     ImageCache.GetImageWithCallBack("monsters/C" + i + "-medium.jpg",this.IconLoaded,true,1,"",[barMC.mcIcon]);
                     barMC.tName.htmlText = "<b>" + KEYS.Get(CREATURELOCKER._creatures["C" + i].name) + "</b>";
                     barMC._id = i;
                     v = int(HOUSING._creatures["C" + i].Get());
                     if(this._selected["C" + i])
                     {
                        v -= this._selected["C" + i].Get();
                     }
                     if(v == 0)
                     {
                        barMC.tHoused.htmlText = "<font color=\"#FF0000\">" + KEYS.Get("bunker_housed",{"v1":0}) + "</font>";
                     }
                     else
                     {
                        barMC.tHoused.htmlText = "<font color=\"#000000\">" + KEYS.Get("bunker_housed",{"v1":v}) + "</font>";
                     }
                     if(Boolean(this._selected["C" + i]) && this._selected["C" + i].Get() > 0)
                     {
                        barMC.tSelected.htmlText = "<font color=\"#FF0000\">" + KEYS.Get("bunker_selected",{"v1":this._selected["C" + i].Get()}) + "</font>";
                     }
                     else
                     {
                        barMC.tSelected.htmlText = "<font color=\"#CCCCCC\">" + KEYS.Get("bunker_selected",{"v1":0}) + "</font>";
                     }
                     n += 1;
                  }
                  i++;
               }
               if(n == 1)
               {
                  tNoMonsters.htmlText = KEYS.Get("bunker_empty");
               }
               else
               {
                  tNoMonsters.htmlText = "";
               }
               while(n < 9)
               {
                  barMC = this["house" + n];
                  if(barMC.visible)
                  {
                     barMC.visible = false;
                  }
                  n += 1;
               }
            }
            else
            {
               arr = [2,6,7,8,10,5,12];
               n = 1;
               while(n <= arr.length)
               {
                  i = int(arr[n - 1]);
                  barMC = this["house" + n];
                  if(!barMC.visible)
                  {
                     barMC.visible = true;
                  }
                  ImageCache.GetImageWithCallBack("monsters/C" + i + "-medium.jpg",this.IconLoaded,true,1,"",[barMC.mcIcon]);
                  barMC.tName.htmlText = "<b>" + KEYS.Get(CREATURELOCKER._creatures["C" + i].name) + "</b>";
                  barMC._id = i;
                  if(Boolean(CREATURELOCKER._lockerData["C" + i]) && CREATURELOCKER._lockerData["C" + i].t == 2)
                  {
                     barMC.tHoused.htmlText = "<font color=\"#0000CC\">" + this.GetCost("C" + i,1) + " " + KEYS.Get(GLOBAL._resourceNames[4]) + "</font>";
                     if(Boolean(this._selected["C" + i]) && this._selected["C" + i].Get() > 0)
                     {
                        barMC.tSelected.htmlText = "<font color=\"#FF0000\">" + KEYS.Get("bunker_selected",{"v1":this._selected["C" + i].Get()}) + "</font>";
                     }
                     else
                     {
                        barMC.tSelected.htmlText = "<font color=\"#CCCCCC\">" + KEYS.Get("bunker_selected",{"v1":0}) + "</font>";
                     }
                  }
                  else
                  {
                     barMC.tHoused.htmlText = "<font color=\"#0000CC\">" + this.GetCost("C" + i,1) + " " + KEYS.Get(GLOBAL._resourceNames[4]) + "</font>";
                     barMC.tSelected.htmlText = "<font color=\"#CC0000\">" + KEYS.Get("bunker_store_locked") + "</font>";
                  }
                  n++;
               }
               tNoMonsters.htmlText = "";
               while(n < 9)
               {
                  barMC = this["house" + n];
                  if(barMC.visible)
                  {
                     barMC.visible = false;
                  }
                  n += 1;
               }
            }
         }
         catch(e:Error)
         {
            GLOBAL.ErrorMessage("MONSTERBUNKERPOPUP.Update " + e.message + " | " + e.getStackTrace());
            LOGGER.Log("err","MONSTERBUNKERPOPUP.Update " + e.message + " | " + e.getStackTrace());
         }
         n = 0;
         for(c in this._selected)
         {
            n += this._selected[c].Get();
         }
         if(n > 0)
         {
            bTransfer.Highlight = true;
            bTransfer.Enabled = true;
         }
         else
         {
            bTransfer.Highlight = false;
            bTransfer.Enabled = false;
         }
         for(c in this._bunker._monsters)
         {
            usedA += CREATURES.GetProperty(c,"cStorage",0,true) * this._bunker._monsters[c];
         }
         this._bunker._used = usedA;
         for(c in this._selected)
         {
            usedB += CREATURES.GetProperty(c,"cStorage",0,true) * this._selected[c].Get();
         }
         p = 100 / this._capacity * (usedA + usedB);
         mcStorage.mcBar.width = 535 / this._capacity * usedA;
         mcStorage.mcBarB.width = 535 / this._capacity * (usedA + usedB);
         if(usedA + usedB >= this._capacity)
         {
            if(this._bunker._lvl.Get() < 3)
            {
               tStored.htmlText = KEYS.Get("bunker_full_2");
            }
            else
            {
               tStored.htmlText = "<b>" + KEYS.Get("bunker_full") + "</b>";
            }
         }
         else
         {
            tStored.htmlText = "<b>" + GLOBAL.FormatNumber(usedA + usedB) + " / " + GLOBAL.FormatNumber(this._capacity) + " (" + p + "%)</b>";
         }
         usedA = 0;
         for(c in this._selected)
         {
            usedA += this.GetCost(c,this._selected[c].Get());
         }
         if(this._mode == "housing")
         {
            if(usedA > 0)
            {
               tCost.htmlText = "<b>" + GLOBAL.FormatNumber(usedA) + "<br>" + KEYS.Get(GLOBAL._resourceNames[2]) + "</b>";
            }
            else
            {
               tCost.htmlText = "<b>" + KEYS.Get("bunker_btn_transfer") + "</b>";
            }
         }
         else
         {
            tCost.htmlText = "<font color=\"#0000CC\"><b>" + GLOBAL.FormatNumber(usedA) + "<br>" + KEYS.Get(GLOBAL._resourceNames[4]) + "</b></font>";
         }
         n = 1;
         for(c in this._bunker._monsters)
         {
            quantity = this._bunker._monsters[c];
            if(quantity > 0 && n <= 8)
            {
               creatureProps = CREATURELOCKER._creatures[c];
               barMC = this["bunker" + n];
               if(!barMC.visible)
               {
                  barMC.visible = true;
               }
               barMC._id = c.substr(1);
               barMC.tName.htmlText = "<b>" + KEYS.Get(CREATURELOCKER._creatures[c].name) + "</b>";
               barMC.tHoused.htmlText = KEYS.Get("bunker_bunkered",{"v1":quantity});
               ImageCache.GetImageWithCallBack("monsters/" + c + "-medium.jpg",this.IconLoaded,true,1,"",[barMC.mcIcon]);
               n += 1;
            }
         }
         while(n < 9)
         {
            barMC = this["bunker" + n];
            if(barMC.visible)
            {
               barMC.visible = false;
            }
            n += 1;
         }
      }
      
      private function GetCost(param1:String, param2:int) : int
      {
         var _loc5_:Object = null;
         var _loc3_:String = LOGIN._playerID.toString();
         if(this._mode == "housing")
         {
            return CREATURES.GetProperty(param1,"cResource",0,true) * 0.5 * param2;
         }
         _loc5_ = {
            "C2":2,
            "C6":5,
            "C5":16,
            "C7":8,
            "C8":12,
            "C10":14,
            "C12":65
         };
         if(!_loc5_[param1])
         {
            GLOBAL.ErrorMessage("MONSTERBUNKERPOPUP");
            return 0;
         }
         return _loc5_[param1] * param2;
      }
      
      private function SelectAdd(param1:MouseEvent = null) : *
      {
         SOUNDS.Play("click1");
         var _loc2_:int = int(param1.target.parent._id);
         if(this.Check(_loc2_))
         {
            if(this._selected["C" + _loc2_])
            {
               this._selected["C" + _loc2_].Add(1);
            }
            else
            {
               this._selected["C" + _loc2_] = new SecNum(1);
            }
            this.Update();
         }
      }
      
      private function SelectRemove(param1:MouseEvent = null) : *
      {
         SOUNDS.Play("click1");
         var _loc2_:int = int(param1.target.parent._id);
         if(this._selected["C" + _loc2_])
         {
            this._selected["C" + _loc2_].Add(-1);
         }
         if(Boolean(this._selected["C" + _loc2_]) && this._selected["C" + _loc2_].Get() <= 0)
         {
            delete this._selected["C" + _loc2_];
         }
         this.Update();
      }
      
      private function Transfer(param1:MouseEvent) : *
      {
         var _loc2_:String = null;
         var _loc5_:int = 0;
         if(!bTransfer.Enabled)
         {
            return;
         }
         var _loc3_:SecNum = new SecNum(0);
         var _loc4_:Array = [];
         if(this._mode == "housing")
         {
            for(_loc2_ in this._selected)
            {
               _loc3_.Add(this.GetCost(_loc2_,this._selected[_loc2_].Get()));
            }
            if(_loc3_.Get() == 0 || Boolean(BASE.Charge(3,_loc3_.Get(),false)))
            {
               for(_loc2_ in this._selected)
               {
                  _loc5_ = 0;
                  while(_loc5_ < this._selected[_loc2_].Get())
                  {
                     this.BunkerStore(_loc2_);
                     _loc5_++;
                  }
               }
               SOUNDS.Play("click1");
               this._selected = {};
               this.Update();
               BASE.Save();
            }
            else
            {
               GLOBAL.Message(KEYS.Get("bunker_lowputty"),KEYS.Get("bunker_btn_lowputty"),STORE.ShowB,[2,0.8,["BR31","BR32","BR33"]]);
            }
         }
         else
         {
            for(_loc2_ in this._selected)
            {
               _loc3_.Add(this.GetCost(_loc2_,this._selected[_loc2_].Get()));
               _loc4_.push([this._selected[_loc2_].Get(),KEYS.Get(CREATURELOCKER._creatures[_loc2_].name)]);
            }
            if(_loc3_.Get() <= BASE._credits.Get())
            {
               for(_loc2_ in this._selected)
               {
                  if(this._bunker._monsters[_loc2_])
                  {
                     this._bunker._monsters[_loc2_] += this._selected[_loc2_].Get();
                  }
                  else
                  {
                     this._bunker._monsters[_loc2_] = this._selected[_loc2_].Get();
                     this._bunker._monstersDispatched[_loc2_] = 0;
                  }
               }
               SOUNDS.Play("purchasepopup");
               this._selected = {};
               BASE.Purchase("BUNK",_loc3_.Get(),"bunker");
               GLOBAL.Message(KEYS.Get("bunker_purchased",{"v1":_loc3_.Get()}));
            }
            else
            {
               POPUPS.DisplayGetShiny();
            }
            this.Update();
         }
      }
      
      private function Check(param1:int) : *
      {
         var _loc5_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         for(_loc5_ in this._bunker._monsters)
         {
            _loc3_ += CREATURES.GetProperty(_loc5_,"cStorage",0,true) * this._bunker._monsters[_loc5_];
         }
         for(_loc5_ in this._selected)
         {
            _loc4_ += CREATURES.GetProperty(_loc5_,"cStorage",0,true) * this._selected[_loc5_].Get();
         }
         _loc4_ += int(CREATURELOCKER._creatures["C" + param1].props.cStorage);
         if(_loc3_ + _loc4_ > this._capacity)
         {
            return false;
         }
         if(this._mode == "housing")
         {
            if(Boolean(HOUSING._creatures["C" + param1]) && HOUSING._creatures["C" + param1].Get() > 0)
            {
               _loc2_ = int(HOUSING._creatures["C" + param1].Get());
            }
            if(this._selected["C" + param1])
            {
               _loc2_ -= this._selected["C" + param1].Get();
            }
            if(_loc2_ > 0)
            {
               return true;
            }
         }
         else
         {
            if(Boolean(CREATURELOCKER._lockerData["C" + param1]) && CREATURELOCKER._lockerData["C" + param1].t == 2)
            {
               return true;
            }
            GLOBAL.Message(KEYS.Get("bunker_locker_desc",{"v1":KEYS.Get(CREATURELOCKER._creatures["C" + param1].name)}),KEYS.Get("btn_openlocker"),CREATURELOCKER.Show);
         }
         return false;
      }
      
      private function BunkerStore(param1:String) : *
      {
         var _loc3_:BFOUNDATION = null;
         var _loc4_:int = 0;
         var _loc5_:CREEP = null;
         var _loc6_:CREEP = null;
         var _loc2_:Array = [];
         for each(_loc3_ in BASE._buildingsHousing)
         {
            _loc2_.push(_loc3_);
         }
         _loc4_ = int(CREATURELOCKER._creatures[param1].props.cStorage);
         if(Boolean(HOUSING._creatures[param1]) && _loc4_ <= this._bunker._capacity - this._bunker._used)
         {
            _loc5_ = null;
            for each(_loc6_ in CREATURES._creatures)
            {
               if(_loc6_._creatureID == param1 && (_loc6_._behaviour == "housing" || _loc6_._behaviour == "pen"))
               {
                  _loc5_ = _loc6_;
                  break;
               }
            }
            if(_loc5_ == null)
            {
               _loc3_ = _loc2_[int(Math.random() * _loc2_.length)];
               _loc5_ = CREATURES.Spawn(param1,MAP._BUILDINGTOPS,"bunker",new Point(_loc3_.x,_loc3_.y).add(new Point(-60 + Math.random() * 135,65 + Math.random() * 50)),Math.random() * 360);
            }
            if(_loc5_)
            {
               _loc5_._homeBunker = this._bunker;
               _loc5_.ModeBunker();
               HOUSING._creatures[param1].Add(-1);
               if(Boolean(this._bunker._monsters[param1]) && this._bunker._monsters[param1] > 0)
               {
                  this._bunker._monsters[param1] += 1;
                  this._bunker._used += int(_loc4_);
                  if(this._bunker._monstersDispatched[param1])
                  {
                     this._bunker._monstersDispatched[param1] += 1;
                  }
                  else
                  {
                     this._bunker._monstersDispatched[param1] = 1;
                  }
               }
               else
               {
                  this._bunker._monsters[param1] = 1;
                  this._bunker._monstersDispatched[param1] = 1;
               }
               ++this._bunker._monstersDispatchedTotal;
            }
            this.Update();
            HOUSING.HousingSpace();
         }
      }
      
      private function BunkerJuice(param1:MouseEvent = null) : *
      {
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         var _loc5_:CREEP = null;
         SOUNDS.Play("click1");
         var _loc2_:int = int(param1.target.parent._id);
         if(GLOBAL._bJuicer)
         {
            if(GLOBAL._bJuicer && GLOBAL._bJuicer._countdownUpgrade.Get() == 0)
            {
               if(GLOBAL._bJuicer._hp.Get() > GLOBAL._bJuicer._hpMax.Get() * 0.5)
               {
                  _loc3_ = "C" + _loc2_;
                  if(this._bunker._monsters[_loc3_])
                  {
                     _loc4_ = false;
                     for each(_loc5_ in CREATURES._creatures)
                     {
                        if(_loc5_._creatureID == _loc3_ && _loc5_._behaviour == "bunker")
                        {
                           _loc5_.ModeJuice();
                           --this._bunker._monstersDispatched[_loc3_];
                           if(this._bunker._monstersDispatched[_loc3_] < 0)
                           {
                              this._bunker._monstersDispatched[_loc3_] = 0;
                           }
                           --this._bunker._monstersDispatchedTotal;
                           if(this._bunker._monstersDispatchedTotal < 0)
                           {
                              this._bunker._monstersDispatchedTotal = 0;
                           }
                           _loc4_ = true;
                           break;
                        }
                     }
                     if(!_loc4_)
                     {
                        CREATURES.Spawn(_loc3_,MAP._BUILDINGTOPS,"juice",new Point(this._bunker.x,this._bunker.y).add(new Point(-60 + Math.random() * 135,-5 + Math.random() * 20)),Math.random() * 360);
                     }
                     --this._bunker._monsters[_loc3_];
                     if(this._bunker._monsters[_loc3_] < 0)
                     {
                        this._bunker._monsters[_loc3_] = 0;
                     }
                  }
                  this.Update();
                  BASE.Save();
                  return;
               }
            }
         }
         _loc3_ = "C" + _loc2_;
         if(this._bunker._monsters[_loc3_])
         {
            --this._bunker._monsters[_loc3_];
            if(this._bunker._monsters[_loc3_] < 0)
            {
               this._bunker._monsters[_loc3_] = 0;
            }
         }
         this.Update();
         BASE.Save();
      }
      
      public function Help(param1:MouseEvent = null) : void
      {
         this._guidePage += 1;
         var _loc2_:String = KEYS.Get("bunker_tut_" + this._guidePage);
         if(this._guidePage <= 3)
         {
            this.gotoAndStop(2);
            txtGuide.htmlText = _loc2_;
            if(this._guidePage == 1)
            {
               this.bContinue.addEventListener(MouseEvent.CLICK,this.Help);
               this.bContinue.SetupKey("btn_continue");
            }
         }
         else
         {
            this._guidePage = 0;
            this.gotoAndStop(1);
         }
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         MONSTERBUNKER.Hide(param1);
      }
      
      public function Center() : void
      {
         POPUPSETTINGS.AlignToCenter(this);
      }
      
      public function ScaleUp() : void
      {
         POPUPSETTINGS.ScaleUp(this);
      }
   }
}

