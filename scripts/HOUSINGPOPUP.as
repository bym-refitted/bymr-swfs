package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class HOUSINGPOPUP extends HOUSINGPOPUP_CLIP
   {
      public var _juiceList:Object;
      
      public function HOUSINGPOPUP()
      {
         var _loc2_:String = null;
         this._juiceList = {};
         super();
         if(GLOBAL._bJuicer)
         {
            gotoAndStop(2);
            bJuice.SetupKey("mh_nomonsters_btn");
            bJuice.Enabled = false;
            bJuice.addEventListener(MouseEvent.CLICK,this.Juice);
            bAll.SetupKey("mh_selectall_btn");
            bAll.addEventListener(MouseEvent.CLICK,this.SelectAll);
            bCancel.SetupKey("mh_cancel_btn");
            bCancel.Enabled = false;
            bCancel.addEventListener(MouseEvent.CLICK,this.SelectNone);
         }
         else
         {
            gotoAndStop(1);
         }
         this._juiceList = {};
         var _loc1_:int = 1;
         while(_loc1_ <= 15)
         {
            _loc2_ = "C" + _loc1_;
            ImageCache.GetImageWithCallBack("monsters/C" + _loc1_ + "-medium.jpg",this.IconLoaded,true,1,"",[this["m" + _loc1_].mcIcon]);
            this["m" + _loc1_].tName.htmlText = "<b>" + KEYS.Get(CREATURELOCKER._creatures[_loc2_].name) + "</b>";
            if(GLOBAL._bJuicer)
            {
               this["m" + _loc1_].addEventListener(MouseEvent.CLICK,this.JuicerAdd(_loc1_));
               this["m" + _loc1_].buttonMode = true;
               this["m" + _loc1_].mouseChildren = false;
            }
            _loc1_++;
         }
         _loc1_ = 16;
         while(_loc1_ <= 21)
         {
            this["m" + _loc1_].visible = false;
            _loc1_++;
         }
         title_txt.text = KEYS.Get("mh_title");
         capacity_desc_txt.htmlText = "<b>" + KEYS.Get("mh_capacity_desc") + "</b>";
         if(GLOBAL._bJuicer)
         {
            juicefooter_desc_txt.htmlText = KEYS.Get("mh_juicefooter_desc");
         }
         else
         {
            footer_desc_txt.htmlText = KEYS.Get("mh_footer_desc");
         }
         this.Update();
      }
      
      public function IconLoaded(param1:String, param2:BitmapData, param3:Array = null) : *
      {
         var _loc4_:Bitmap = new Bitmap(param2);
         _loc4_.smoothing = true;
         param3[0].mcImage.addChild(_loc4_);
         param3[0].mcImage.visible = true;
         param3[0].mcLoading.visible = false;
      }
      
      public function Update() : *
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:Number = NaN;
         HOUSING.HousingSpace();
         _loc3_ = 0;
         for(_loc2_ in this._juiceList)
         {
            _loc3_ += CREATURELOCKER._creatures[_loc2_].props.cStorage * this._juiceList[_loc2_];
         }
         HOUSING._housingUsed.Add(-_loc3_);
         _loc6_ = 100 / HOUSING._housingCapacity.Get() * HOUSING._housingUsed.Get();
         mcStorage.mcBar.width = 535 / HOUSING._housingCapacity.Get() * HOUSING._housingUsed.Get();
         mcStorage.mcBarB.width = 1;
         tStorage.htmlText = "<b>" + GLOBAL.FormatNumber(HOUSING._housingUsed.Get()) + " / " + GLOBAL.FormatNumber(HOUSING._housingCapacity.Get()) + " (" + _loc6_ + "%)</b>";
         _loc7_ = 1;
         while(_loc7_ <= 15)
         {
            _loc1_ = "C" + _loc7_;
            if(!CREATURELOCKER._lockerData[_loc1_])
            {
               this["m" + _loc7_].tInfo.htmlText = KEYS.Get("mh_item_locked");
               this["m" + _loc7_].alpha = 0.5;
            }
            else if(CREATURELOCKER._lockerData[_loc1_].t == 1)
            {
               this["m" + _loc7_].tInfo.htmlText = KEYS.Get("mh_item_unlocking");
               this["m" + _loc7_].alpha = 0.5;
            }
            else
            {
               this["m" + _loc7_].tInfo.htmlText = KEYS.Get("mh_item_0housed");
               this["m" + _loc7_].alpha = 0.5;
            }
            _loc7_++;
         }
         for(_loc2_ in HOUSING._creatures)
         {
            _loc8_ = HOUSING._creatures[_loc2_].Get();
            if(_loc8_ > 0)
            {
               _loc5_ = CREATURELOCKER._creatures[_loc2_];
               _loc9_ = _loc2_.substr(1);
               if(Boolean(this._juiceList[_loc2_]) && this._juiceList[_loc2_] > 0)
               {
                  this["m" + _loc9_].tInfo.htmlText = "<font color=\"#FF0000\">" + KEYS.Get("mh_selectedforjuicing",{
                     "v1":this._juiceList[_loc2_],
                     "v2":GLOBAL.FormatNumber(_loc8_)
                  }) + "</font>";
               }
               else
               {
                  this["m" + _loc9_].tInfo.htmlText = KEYS.Get("mh_item_cost",{
                     "v1":GLOBAL.FormatNumber(_loc8_),
                     "v2":GLOBAL.FormatNumber(CREATURES.GetProperty(_loc2_,"cStorage") * _loc8_)
                  });
               }
               this["m" + _loc9_].alpha = 1;
            }
         }
         if(GLOBAL._bJuicer)
         {
            _loc3_ = 0;
            _loc4_ = 0;
            for(_loc2_ in this._juiceList)
            {
               _loc3_ += this._juiceList[_loc2_];
               _loc10_ = 0.6;
               if(GLOBAL._bJuicer._lvl.Get() == 2)
               {
                  _loc10_ = 0.8;
               }
               if(GLOBAL._bJuicer._lvl.Get() == 3)
               {
                  _loc10_ = 1;
               }
               _loc4_ += Math.ceil(CREATURES.GetProperty(_loc2_,"cResource") * _loc10_) * this._juiceList[_loc2_];
            }
            if(_loc3_ > 0)
            {
               bJuice.Enabled = true;
               bJuice.Highlight = true;
               bCancel.Enabled = true;
               if(_loc3_ == 1)
               {
                  bJuice.Setup(KEYS.Get("mh_juicemonsterX_btn",{
                     "v1":_loc3_,
                     "v2":GLOBAL.FormatNumber(_loc4_)
                  }));
               }
               else
               {
                  bJuice.Setup(KEYS.Get("mh_juicemonstersX_btn",{
                     "v1":_loc3_,
                     "v2":GLOBAL.FormatNumber(_loc4_)
                  }));
               }
            }
            else
            {
               bJuice.Enabled = false;
               bCancel.Enabled = false;
            }
            if(HOUSING._housingUsed.Get() == 0)
            {
               bAll.Enabled = false;
            }
            else
            {
               bAll.Enabled = true;
            }
         }
      }
      
      public function JuicerAdd(param1:int) : *
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):*
         {
            var _loc2_:* = undefined;
            if(GLOBAL._bJuicer._countdownUpgrade.Get() == 0)
            {
               if(GLOBAL._bJuicer._hp.Get() > GLOBAL._bJuicer._hpMax.Get() * 0.5)
               {
                  _loc2_ = "C" + n;
                  if(Boolean(HOUSING._creatures[_loc2_]) && HOUSING._creatures[_loc2_].Get() - int(_juiceList[_loc2_]) > 0)
                  {
                     if(!_juiceList[_loc2_])
                     {
                        _juiceList[_loc2_] = 0;
                     }
                     ++_juiceList[_loc2_];
                  }
                  Update();
               }
               else
               {
                  GLOBAL.Message(KEYS.Get("msg_juicerdamaged"));
               }
            }
            else
            {
               GLOBAL.Message(KEYS.Get("msg_juicerupgrading"));
            }
         };
      }
      
      public function Juice(param1:MouseEvent = null) : *
      {
         var _loc2_:String = null;
         var _loc4_:BFOUNDATION = null;
         var _loc5_:CREEP = null;
         var _loc7_:int = 0;
         var _loc6_:Array = [];
         for each(_loc4_ in BASE._buildingsAll)
         {
            if(_loc4_._type == 15)
            {
               _loc6_.push(_loc4_);
            }
         }
         for(_loc2_ in this._juiceList)
         {
            HOUSING._creatures[_loc2_].Add(-this._juiceList[_loc2_]);
            for each(_loc5_ in CREATURES._creatures)
            {
               if(this._juiceList[_loc2_] > 0)
               {
                  if(_loc5_._creatureID == _loc2_ && _loc5_._behaviour != "juice")
                  {
                     _loc5_.ModeJuice();
                     --this._juiceList[_loc2_];
                  }
               }
            }
            _loc7_ = 0;
            while(_loc7_ < this._juiceList[_loc2_])
            {
               _loc4_ = _loc6_[int(Math.random() * _loc6_.length)];
               CREATURES.Spawn(_loc2_,MAP._BUILDINGTOPS,"juice",new Point(_loc4_.x,_loc4_.y).add(new Point(-60 + Math.random() * 135,65 + Math.random() * 50)),Math.random() * 360);
               _loc7_++;
            }
            if(HOUSING._creatures[_loc2_].Get() < 0)
            {
               HOUSING._creatures[_loc2_].Set(0);
            }
         }
         this._juiceList = {};
         HOUSING.HousingSpace();
         BASE.Save();
         HOUSING.Hide();
      }
      
      public function SelectAll(param1:MouseEvent = null) : *
      {
         var _loc2_:String = null;
         if(GLOBAL._bJuicer._countdownUpgrade.Get() == 0)
         {
            this._juiceList = {};
            for(_loc2_ in HOUSING._creatures)
            {
               if(HOUSING._creatures[_loc2_].Get() > 0)
               {
                  this._juiceList[_loc2_] = HOUSING._creatures[_loc2_].Get();
               }
            }
            this.Update();
         }
         else
         {
            GLOBAL.Message(KEYS.Get("msg_juicerupgrading"));
         }
      }
      
      public function SelectNone(param1:MouseEvent = null) : *
      {
         this._juiceList = {};
         bJuice.SetupKey("mh_nomonsters_btn");
         bJuice.Enabled = false;
         bJuice.Highlight = false;
         this.Update();
      }
      
      public function Hide() : *
      {
         HOUSING.Hide();
      }
   }
}

