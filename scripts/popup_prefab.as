package
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import com.monsters.display.ImageCache;
   import com.monsters.pathing.PATHING;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class popup_prefab extends popup_prefab_CLIP
   {
      private var _triggered:Boolean = false;
      
      public function popup_prefab()
      {
         super();
         var _loc1_:Array = [];
         var _loc2_:int = 1;
         while(_loc2_ < 4)
         {
            ImageCache.GetImageWithCallBack("ui/prefab-" + _loc2_ + ".v4.jpg",this.ThumbnailLoaded,true,1,"",[_loc2_]);
            this["img" + _loc2_].addEventListener(MouseEvent.CLICK,this.Enlarge(_loc2_));
            this["img" + _loc2_].buttonMode = true;
            _loc1_ = this.GetBuildings(_loc2_).costs;
            this["c" + _loc2_].htmlText = "<b>" + GLOBAL.FormatNumber(_loc1_[0].Get()) + " Twigs<br>" + GLOBAL.FormatNumber(_loc1_[1].Get()) + " Pebbles<br>" + GLOBAL.FormatNumber(_loc1_[2].Get()) + " Putty</b>";
            this["b" + _loc2_].SetupKey("btn_useresources");
            this["b" + _loc2_].addEventListener(MouseEvent.CLICK,this.PreSelect(_loc2_));
            this["b" + _loc2_ + "s"].Setup(KEYS.Get("btn_useshiny",{"v1":_loc1_[3].Get()}));
            this["b" + _loc2_ + "s"].addEventListener(MouseEvent.CLICK,this.PreBuyOutright(_loc2_,_loc1_[3].Get()));
            this["b" + _loc2_ + "s"].Highlight = true;
            this.tSelect.htmlText = "<b>" + KEYS.Get("str_selectsk") + "</b>";
            this.t1.htmlText = "<b>" + KEYS.Get("str_regularkit") + "</b>";
            this.t2.htmlText = "<b>" + KEYS.Get("str_largekit") + "</b>";
            this.t3.htmlText = "<b>" + KEYS.Get("str_megakit") + "</b>";
            _loc2_++;
         }
         this.tShiny.htmlText = "<b>" + GLOBAL.FormatNumber(BASE._credits.Get()) + " " + KEYS.Get("#r_shiny#") + "</b>";
      }
      
      public function Enlarge(param1:int) : Function
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):void
         {
            var _loc2_:* = new popup_prefab_enlarge();
            GLOBAL.BlockerAdd(GLOBAL._layerTop);
            GLOBAL._layerTop.addChild(_loc2_);
            _loc2_.Setup(n);
         };
      }
      
      public function ThumbnailLoaded(param1:String, param2:BitmapData, param3:Array) : *
      {
         if(param3[0] == 1)
         {
            img1.addChild(new Bitmap(param2));
         }
         else if(param3[0] == 2)
         {
            img2.addChild(new Bitmap(param2));
         }
         else if(param3[0] == 3)
         {
            img3.addChild(new Bitmap(param2));
         }
      }
      
      public function PreBuyOutright(param1:int, param2:int) : *
      {
         var kitID:int = param1;
         var shinyCost:int = param2;
         return function(param1:MouseEvent = null):*
         {
            var _loc3_:* = undefined;
            var _loc2_:* = 0;
            for each(_loc3_ in BASE._buildingsAll)
            {
               _loc2_++;
               if(_loc2_ > 1)
               {
                  break;
               }
            }
            if(_loc2_ > 1)
            {
               GLOBAL.Message(KEYS.Get("kit_warning"),KEYS.Get("btn_build"),BuyOutright,[kitID,shinyCost]);
            }
            else
            {
               BuyOutright(kitID,shinyCost);
            }
         };
      }
      
      public function BuyOutright(param1:int, param2:int) : *
      {
         if(BASE._credits.Get() < param2)
         {
            POPUPS.Next();
            POPUPS.DisplayGetShiny();
            return;
         }
         var _loc3_:Array = this.GetBuildings(param1).costs;
         var _loc4_:int = int(_loc3_[3].Get());
         if(param2 == _loc4_)
         {
            this.BuildKit(param1);
            BASE.Purchase("KIT",param2,"popup_prefab");
            LOGGER.Stat([41,param1 + "b",param2]);
         }
         else
         {
            LOGGER.Log("err","KitCostMismatch (BuyOutright) expected:" + _loc4_ + " got:" + param2);
            GLOBAL.ErrorMessage("Expected to cost:" + param2 + " recalculated cost was:" + _loc4_);
         }
      }
      
      public function PreSelect(param1:int) : *
      {
         var kitID:int = param1;
         return function(param1:MouseEvent = null):*
         {
            var _loc3_:* = undefined;
            var _loc2_:* = 0;
            for each(_loc3_ in BASE._buildingsAll)
            {
               _loc2_++;
               if(_loc2_ > 1)
               {
                  break;
               }
            }
            if(_loc2_ > 1)
            {
               GLOBAL.Message(KEYS.Get("kit_warning"),KEYS.Get("btn_build"),Select,[kitID]);
            }
            else
            {
               Select(kitID);
            }
         };
      }
      
      public function Select(param1:int) : *
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         if(this._triggered)
         {
            return;
         }
         var _loc4_:Array = this.GetBuildings(param1).costs;
         var _loc5_:Array = [];
         var _loc7_:int = 0;
         _loc6_ = Math.min(GLOBAL._resources.r1.Get(),_loc4_[0].Get());
         _loc7_ += _loc4_[0].Get() - _loc6_;
         if(_loc6_ != _loc4_[0].Get())
         {
            _loc5_.push([_loc4_[0].Get() - _loc6_,KEYS.Get("#r_twigs#")]);
         }
         _loc6_ = Math.min(GLOBAL._resources.r2.Get(),_loc4_[1].Get());
         _loc7_ += _loc4_[1].Get() - _loc6_;
         if(_loc6_ != _loc4_[1].Get())
         {
            _loc5_.push([_loc4_[1].Get() - _loc6_,KEYS.Get("#r_pebbles#")]);
         }
         _loc6_ = Math.min(GLOBAL._resources.r3.Get(),_loc4_[2].Get());
         _loc7_ += _loc4_[2].Get() - _loc6_;
         if(_loc6_ != _loc4_[2].Get())
         {
            _loc5_.push([_loc4_[2].Get() - _loc6_,KEYS.Get("#r_putty#")]);
         }
         if(_loc5_.length > 0)
         {
            _loc8_ = Math.ceil(Math.pow(Math.sqrt(_loc7_ / 2),0.75));
            GLOBAL.Message("<b>You need an extra " + GLOBAL.Array2String(_loc5_) + " to build this kit.</b><br><br>You can bank resources in your outposts and main yard or use " + _loc8_ + " shiny to make up the difference.","Use " + _loc8_ + " Shiny",this.PayForKit,[param1,_loc8_]);
            return;
         }
         if(GLOBAL._resources.r1.Get() >= _loc4_[0].Get())
         {
            if(GLOBAL._resources.r2.Get() >= _loc4_[1].Get())
            {
               if(GLOBAL._resources.r3.Get() >= _loc4_[2].Get())
               {
                  BASE.Charge(1,_loc4_[0].Get());
                  BASE.Charge(2,_loc4_[1].Get());
                  BASE.Charge(3,_loc4_[2].Get());
                  LOGGER.Stat([38,param1,0]);
                  this.BuildKit(param1);
                  BASE.Save();
                  POPUPS.Next();
                  return;
               }
               GLOBAL.Message(KEYS.Get("newmap_sk_res"));
               return;
            }
            GLOBAL.Message(KEYS.Get("newmap_sk_res"));
            return;
         }
         GLOBAL.Message(KEYS.Get("newmap_sk_res"));
      }
      
      private function PayForKit(param1:int, param2:int) : *
      {
         var _loc5_:int = 0;
         if(BASE._credits.Get() < param2)
         {
            GLOBAL.Message("<b>" + KEYS.Get("pop_noshiny_title") + "</b><br>" + KEYS.Get("pop_noshiny_body"),KEYS.Get("str_getmore_btn"),BUY.Show);
            return;
         }
         var _loc3_:Array = this.GetBuildings(param1).costs;
         var _loc4_:int = 0;
         _loc5_ = Math.min(GLOBAL._resources.r1.Get(),_loc3_[0].Get());
         _loc4_ += _loc3_[0].Get() - _loc5_;
         BASE.Charge(1,_loc5_);
         _loc5_ = Math.min(GLOBAL._resources.r2.Get(),_loc3_[1].Get());
         _loc4_ += _loc3_[1].Get() - _loc5_;
         BASE.Charge(2,_loc5_);
         _loc5_ = Math.min(GLOBAL._resources.r3.Get(),_loc3_[2].Get());
         _loc4_ += _loc3_[2].Get() - _loc5_;
         BASE.Charge(3,_loc5_);
         if(param2 == Math.ceil(Math.pow(Math.sqrt(_loc4_ / 2),0.75)))
         {
            this.BuildKit(param1);
            BASE.Purchase("KIT",param2,"popup_prefab");
            LOGGER.Stat([38,param1,param2]);
         }
         else
         {
            LOGGER.Log("err","KitCostMismatch expected:" + param2 + " got:" + Math.ceil(Math.pow(Math.sqrt(_loc4_ / 2),0.75)));
            GLOBAL.ErrorMessage("Expected to cost:" + param2 + " recalculated cost was:" + Math.ceil(Math.pow(Math.sqrt(_loc4_ / 2),0.75)));
         }
      }
      
      private function BuildKit(param1:int) : *
      {
         var _loc3_:BFOUNDATION = null;
         var _loc4_:Object = null;
         this._triggered = true;
         b1.Enabled = false;
         b2.Enabled = false;
         b3.Enabled = false;
         var _loc2_:Object = this.GetBuildings(param1).buildings;
         CREATURES.Clear();
         CREEPS.Clear();
         for each(_loc3_ in BASE._buildingsAll)
         {
            if(_loc3_._type != 112)
            {
               _loc3_.Clean();
               _loc3_._mc.visible = false;
               _loc3_._mc.removeEventListener(Event.ENTER_FRAME,_loc3_.TickFast);
               _loc3_._mcBase.Clear();
               _loc3_.topContainer.Clear();
               _loc3_.animContainer.Clear();
               _loc3_._animBMD = null;
               _loc3_._animContainerBMD = null;
            }
         }
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_.t == 112)
            {
               GLOBAL._bTownhall.Setup(_loc4_);
            }
            else
            {
               if(!_loc4_.prefab)
               {
                  _loc4_.prefab = 1;
               }
               _loc3_ = BASE.addBuildingC(_loc4_.t);
               _loc3_.Setup(_loc4_);
               if(_loc3_._class == "resource")
               {
                  _loc3_._stored = new SecNum(0);
               }
            }
         }
         PATHING.ResetCosts();
         POPUPS.Next();
         BASE.Save();
      }
      
      private function GetBuildings(param1:int) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:Array = [];
         if(param1 == 1)
         {
            _loc2_ = com.adobe.serialization.json.JSON.decode("{\"0\":{\"Y\":-105,\"t\":112,\"id\":0,\"X\":-5},\"1\":{\"Y\":25,\"t\":21,\"id\":1,\"prefab\":5,\"X\":95},\"2\":{\"Y\":-175,\"t\":21,\"id\":2,\"prefab\":5,\"X\":-45},\"3\":{\"Y\":-175,\"t\":20,\"id\":3,\"prefab\":5,\"X\":95},\"4\":{\"Y\":25,\"t\":20,\"id\":4,\"prefab\":5,\"X\":-45},\"5\":{\"Y\":-385,\"t\":15,\"id\":5,\"X\":-225},\"6\":{\"Y\":-220,\"t\":13,\"id\":6,\"X\":-190},\"7\":{\"Y\":-110,\"t\":13,\"id\":7,\"X\":-200},\"8\":{\"Y\":95,\"t\":5,\"id\":8,\"X\":-185},\"9\":{\"Y\":0,\"t\":51,\"id\":9,\"X\":-185},\"10\":{\"prefab\":7,\"cP\":5,\"rCP\":5,\"X\":-75,\"pr\":1,\"Y\":-75,\"t\":1,\"id\":10,\"st\":125},\"11\":{\"prefab\":7,\"cP\":7,\"rCP\":7,\"X\":25,\"pr\":1,\"Y\":25,\"t\":2,\"id\":11,\"st\":4900},\"12\":{\"prefab\":7,\"cP\":10,\"rCP\":10,\"X\":25,\"pr\":1,\"Y\":-175,\"t\":3,\"id\":12,\"st\":175},\"13\":{\"prefab\":7,\"cP\":1,\"rCP\":1,\"X\":125,\"pr\":1,\"Y\":-75,\"t\":4,\"id\":13,\"st\":4825},\"14\":{\"Y\":-200,\"t\":17,\"id\":14,\"prefab\":2,\"X\":115},\"15\":{\"Y\":95,\"t\":17,\"id\":15,\"prefab\":2,\"X\":-5},\"16\":{\"Y\":-200,\"t\":17,\"id\":16,\"prefab\":2,\"X\":135},\"17\":{\"Y\":95,\"t\":17,\"id\":17,\"prefab\":2,\"X\":15},\"18\":{\"Y\":-200,\"t\":17,\"id\":18,\"prefab\":2,\"X\":35},\"19\":{\"Y\":95,\"t\":17,\"id\":19,\"prefab\":2,\"X\":35},\"20\":{\"Y\":-200,\"t\":17,\"id\":20,\"prefab\":2,\"X\":15},\"21\":{\"Y\":95,\"t\":17,\"id\":21,\"prefab\":2,\"X\":55},\"22\":{\"Y\":-200,\"t\":17,\"id\":22,\"prefab\":2,\"X\":75},\"23\":{\"Y\":95,\"t\":17,\"id\":23,\"prefab\":2,\"X\":75},\"24\":{\"Y\":-95,\"t\":17,\"id\":24,\"prefab\":2,\"X\":-75},\"25\":{\"Y\":95,\"t\":17,\"id\":25,\"prefab\":2,\"X\":95},\"26\":{\"Y\":-115,\"t\":17,\"id\":26,\"prefab\":2,\"X\":-65},\"27\":{\"Y\":95,\"t\":17,\"id\":27,\"prefab\":2,\"X\":115},\"28\":{\"Y\":-120,\"t\":17,\"id\":28,\"prefab\":2,\"X\":165},\"29\":{\"Y\":35,\"t\":17,\"id\":29,\"prefab\":2,\"X\":165},\"30\":{\"Y\":-95,\"t\":17,\"id\":30,\"prefab\":2,\"X\":190},\"31\":{\"Y\":95,\"t\":17,\"id\":31,\"prefab\":2,\"X\":135},\"32\":{\"Y\":-100,\"t\":17,\"id\":32,\"prefab\":2,\"X\":170},\"33\":{\"Y\":-200,\"t\":17,\"id\":33,\"prefab\":2,\"X\":-25},\"34\":{\"Y\":-75,\"t\":17,\"id\":34,\"prefab\":2,\"X\":195},\"35\":{\"Y\":-200,\"t\":17,\"id\":35,\"prefab\":2,\"X\":-5},\"36\":{\"Y\":-55,\"t\":17,\"id\":36,\"prefab\":2,\"X\":195},\"37\":{\"Y\":95,\"t\":17,\"id\":37,\"prefab\":2,\"X\":-25},\"38\":{\"Y\":-35,\"t\":17,\"id\":38,\"prefab\":2,\"X\":195},\"39\":{\"Y\":-155,\"t\":17,\"id\":39,\"prefab\":2,\"X\":-65},\"40\":{\"Y\":-15,\"t\":17,\"id\":40,\"prefab\":2,\"X\":195},\"41\":{\"Y\":15,\"t\":17,\"id\":41,\"prefab\":2,\"X\":165},\"42\":{\"Y\":-5,\"t\":17,\"id\":42,\"prefab\":2,\"X\":175},\"43\":{\"Y\":-200,\"t\":17,\"id\":43,\"prefab\":2,\"X\":95},\"44\":{\"Y\":55,\"t\":17,\"id\":44,\"prefab\":2,\"X\":-65},\"45\":{\"Y\":-135,\"t\":17,\"id\":45,\"prefab\":2,\"X\":-65},\"46\":{\"Y\":-85,\"t\":17,\"id\":46,\"prefab\":2,\"X\":-95},\"47\":{\"Y\":-200,\"t\":17,\"id\":47,\"prefab\":2,\"X\":55},\"48\":{\"Y\":15,\"t\":17,\"id\":48,\"prefab\":2,\"X\":-75},\"49\":{\"Y\":35,\"t\":17,\"id\":49,\"prefab\":2,\"X\":-65},\"50\":{\"Y\":-5,\"t\":17,\"id\":50,\"prefab\":2,\"X\":-85},\"51\":{\"Y\":-45,\"t\":17,\"id\":51,\"prefab\":2,\"X\":-95},\"52\":{\"Y\":-25,\"t\":17,\"id\":52,\"prefab\":2,\"X\":-95},\"53\":{\"Y\":-65,\"t\":17,\"id\":53,\"prefab\":2,\"X\":-95},\"56\":{\"Y\":75,\"t\":17,\"id\":56,\"X\":-65},\"57\":{\"Y\":95,\"t\":17,\"id\":57,\"X\":155},\"58\":{\"Y\":75,\"t\":17,\"id\":58,\"X\":165},\"59\":{\"Y\":-175,\"t\":17,\"id\":59,\"X\":-65},\"60\":{\"Y\":95,\"t\":17,\"id\":60,\"X\":-45},\"61\":{\"Y\":95,\"t\":17,\"id\":61,\"X\":-65},\"62\":{\"Y\":-200,\"t\":17,\"id\":62,\"X\":155},\"63\":{\"Y\":-200,\"t\":17,\"id\":63,\"X\":-45},\"64\":{\"Y\":-195,\"t\":17,\"id\":64,\"X\":-65},\"65\":{\"Y\":-140,\"t\":17,\"id\":65,\"prefab\":2,\"X\":165},\"66\":{\"Y\":-160,\"t\":17,\"id\":66,\"X\":165},\"67\":{\"Y\":-180,\"t\":17,\"id\":67,\"X\":165},\"68\":{\"Y\":55,\"t\":17,\"id\":68,\"X\":165}}");
            _loc3_[0] = new SecNum(5000000);
            _loc3_[1] = new SecNum(5000000);
            _loc3_[2] = new SecNum(2500000);
            _loc3_[3] = new SecNum(5 * 60);
         }
         else if(param1 == 2)
         {
            _loc2_ = com.adobe.serialization.json.JSON.decode("{\"0\":{\"Y\":-105,\"t\":112,\"id\":0,\"X\":-65},\"1\":{\"Y\":-165,\"t\":21,\"id\":1,\"prefab\":5,\"X\":-155},\"2\":{\"Y\":25,\"t\":21,\"id\":2,\"prefab\":5,\"X\":-15},\"3\":{\"Y\":-175,\"t\":21,\"id\":3,\"prefab\":5,\"X\":125},\"4\":{\"Y\":15,\"t\":20,\"id\":4,\"prefab\":5,\"X\":-155},\"5\":{\"Y\":25,\"t\":20,\"id\":5,\"prefab\":5,\"X\":125},\"6\":{\"Y\":-175,\"t\":20,\"id\":6,\"prefab\":5,\"X\":-15},\"7\":{\"Y\":-75,\"t\":25,\"id\":7,\"X\":-155},\"8\":{\"Y\":150,\"t\":15,\"id\":8,\"prefab\":2,\"X\":170},\"9\":{\"Y\":-315,\"t\":13,\"id\":9,\"prefab\":2,\"X\":-35},\"10\":{\"Y\":120,\"t\":13,\"id\":10,\"prefab\":2,\"X\":-70},\"11\":{\"Y\":-305,\"t\":5,\"id\":11,\"prefab\":2,\"X\":-125},\"12\":{\"Y\":120,\"t\":51,\"id\":12,\"prefab\":2,\"X\":30},\"13\":{\"Y\":-85,\"t\":22,\"id\":13,\"X\":85},\"14\":{\"prefab\":8,\"rCP\":9,\"pr\":1,\"X\":-85,\"Y\":-175,\"t\":1,\"id\":14,\"cP\":9,\"st\":7780},\"15\":{\"prefab\":8,\"rCP\":4,\"pr\":1,\"X\":55,\"Y\":25,\"t\":1,\"id\":15,\"cP\":4,\"st\":7595},\"16\":{\"prefab\":8,\"rCP\":2,\"pr\":1,\"X\":55,\"Y\":-175,\"t\":2,\"id\":16,\"cP\":2,\"st\":7790},\"17\":{\"prefab\":8,\"rCP\":8,\"pr\":1,\"X\":-85,\"Y\":25,\"t\":2,\"id\":17,\"cP\":8,\"st\":7655},\"18\":{\"Y\":-195,\"t\":17,\"id\":18,\"prefab\":2,\"X\":165},\"19\":{\"prefab\":8,\"rCP\":3,\"pr\":1,\"X\":-255,\"Y\":-40,\"t\":3,\"id\":19,\"cP\":3,\"st\":7665},\"20\":{\"prefab\":8,\"rCP\":1,\"pr\":1,\"X\":225,\"Y\":-35,\"t\":4,\"id\":20,\"cP\":1,\"st\":7690},\"21\":{\"prefab\":8,\"rCP\":10,\"pr\":1,\"X\":-255,\"Y\":-110,\"t\":4,\"id\":21,\"cP\":10,\"st\":7730},\"22\":{\"Y\":-75,\"t\":17,\"id\":22,\"prefab\":3,\"X\":185},\"23\":{\"Y\":-65,\"t\":17,\"id\":23,\"prefab\":3,\"X\":-85},\"24\":{\"Y\":-95,\"t\":17,\"id\":24,\"prefab\":3,\"X\":185},\"25\":{\"Y\":-105,\"t\":17,\"id\":25,\"prefab\":3,\"X\":85},\"26\":{\"Y\":-55,\"t\":17,\"id\":26,\"prefab\":3,\"X\":185},\"27\":{\"Y\":-105,\"t\":17,\"id\":27,\"prefab\":3,\"X\":125},\"28\":{\"Y\":-35,\"t\":17,\"id\":28,\"prefab\":3,\"X\":185},\"29\":{\"Y\":-105,\"t\":17,\"id\":29,\"prefab\":3,\"X\":105},\"30\":{\"Y\":-45,\"t\":17,\"id\":30,\"prefab\":3,\"X\":-85},\"31\":{\"Y\":-105,\"t\":17,\"id\":31,\"prefab\":3,\"X\":145},\"32\":{\"Y\":-25,\"t\":17,\"id\":32,\"prefab\":3,\"X\":-85},\"33\":{\"Y\":5,\"t\":17,\"id\":33,\"prefab\":3,\"X\":165},\"34\":{\"Y\":-105,\"t\":17,\"id\":34,\"prefab\":3,\"X\":65},\"35\":{\"Y\":5,\"t\":17,\"id\":35,\"prefab\":3,\"X\":145},\"36\":{\"Y\":-105,\"t\":17,\"id\":36,\"prefab\":3,\"X\":165},\"37\":{\"Y\":5,\"t\":17,\"id\":37,\"prefab\":3,\"X\":125},\"38\":{\"Y\":-5,\"t\":17,\"id\":38,\"prefab\":3,\"X\":-185},\"39\":{\"Y\":-5,\"t\":17,\"id\":39,\"prefab\":3,\"X\":65},\"40\":{\"Y\":-85,\"t\":17,\"id\":40,\"prefab\":3,\"X\":65},\"41\":{\"Y\":5,\"t\":17,\"id\":41,\"prefab\":3,\"X\":85},\"42\":{\"Y\":-65,\"t\":17,\"id\":42,\"prefab\":3,\"X\":65},\"43\":{\"Y\":5,\"t\":17,\"id\":43,\"prefab\":3,\"X\":105},\"44\":{\"Y\":-45,\"t\":17,\"id\":44,\"prefab\":3,\"X\":65},\"45\":{\"Y\":-85,\"t\":17,\"id\":45,\"prefab\":3,\"X\":-185},\"46\":{\"Y\":-25,\"t\":17,\"id\":46,\"prefab\":3,\"X\":65},\"47\":{\"Y\":-45,\"t\":17,\"id\":47,\"prefab\":3,\"X\":-185},\"48\":{\"Y\":-95,\"t\":17,\"id\":48,\"prefab\":3,\"X\":-145},\"49\":{\"Y\":-95,\"t\":17,\"id\":49,\"prefab\":3,\"X\":-165},\"50\":{\"Y\":-95,\"t\":17,\"id\":50,\"prefab\":3,\"X\":-105},\"51\":{\"Y\":-95,\"t\":17,\"id\":51,\"prefab\":3,\"X\":-125},\"52\":{\"Y\":-85,\"t\":17,\"id\":52,\"prefab\":3,\"X\":-85},\"53\":{\"Y\":-65,\"t\":17,\"id\":53,\"prefab\":3,\"X\":-185},\"54\":{\"Y\":-25,\"t\":17,\"id\":54,\"prefab\":3,\"X\":-185},\"55\":{\"Y\":-5,\"t\":17,\"id\":55,\"prefab\":3,\"X\":-165},\"56\":{\"Y\":-5,\"t\":17,\"id\":56,\"prefab\":3,\"X\":-105},\"57\":{\"Y\":-5,\"t\":17,\"id\":57,\"prefab\":3,\"X\":-145},\"58\":{\"Y\":-5,\"t\":17,\"id\":58,\"prefab\":3,\"X\":-125},\"59\":{\"Y\":-15,\"t\":17,\"id\":59,\"prefab\":3,\"X\":185},\"60\":{\"Y\":-5,\"t\":17,\"id\":60,\"prefab\":3,\"X\":-85},\"61\":{\"Y\":5,\"t\":17,\"id\":61,\"prefab\":3,\"X\":185},\"62\":{\"Y\":-195,\"t\":17,\"id\":62,\"prefab\":2,\"X\":185},\"63\":{\"Y\":-185,\"t\":17,\"id\":63,\"prefab\":2,\"X\":-115},\"64\":{\"Y\":95,\"t\":17,\"id\":64,\"prefab\":2,\"X\":165},\"65\":{\"Y\":95,\"t\":17,\"id\":65,\"prefab\":2,\"X\":145},\"66\":{\"Y\":95,\"t\":17,\"id\":66,\"prefab\":3,\"X\":125},\"67\":{\"Y\":95,\"t\":17,\"id\":67,\"prefab\":3,\"X\":105},\"68\":{\"Y\":95,\"t\":17,\"id\":68,\"prefab\":3,\"X\":85},\"69\":{\"Y\":95,\"t\":17,\"id\":69,\"prefab\":3,\"X\":65},\"70\":{\"Y\":95,\"t\":17,\"id\":70,\"prefab\":3,\"X\":45},\"71\":{\"Y\":95,\"t\":17,\"id\":71,\"prefab\":3,\"X\":25},\"72\":{\"Y\":95,\"t\":17,\"id\":72,\"prefab\":3,\"X\":5},\"73\":{\"Y\":95,\"t\":17,\"id\":73,\"prefab\":3,\"X\":-15},\"74\":{\"Y\":95,\"t\":17,\"id\":74,\"prefab\":3,\"X\":-35},\"75\":{\"Y\":95,\"t\":17,\"id\":75,\"prefab\":3,\"X\":-55},\"76\":{\"Y\":95,\"t\":17,\"id\":76,\"prefab\":3,\"X\":-75},\"77\":{\"Y\":95,\"t\":17,\"id\":77,\"prefab\":3,\"X\":-95},\"78\":{\"Y\":95,\"t\":17,\"id\":78,\"prefab\":2,\"X\":-115},\"79\":{\"Y\":95,\"t\":17,\"id\":79,\"prefab\":2,\"X\":-135},\"80\":{\"Y\":85,\"t\":17,\"id\":80,\"prefab\":2,\"X\":-155},\"81\":{\"Y\":15,\"t\":17,\"id\":81,\"prefab\":3,\"X\":-185},\"82\":{\"Y\":35,\"t\":17,\"id\":82,\"prefab\":2,\"X\":-185},\"83\":{\"Y\":55,\"t\":17,\"id\":83,\"prefab\":2,\"X\":-185},\"84\":{\"Y\":75,\"t\":17,\"id\":84,\"prefab\":2,\"X\":-175},\"85\":{\"Y\":95,\"t\":17,\"id\":85,\"prefab\":2,\"X\":185},\"86\":{\"Y\":75,\"t\":17,\"id\":86,\"prefab\":2,\"X\":195},\"87\":{\"Y\":55,\"t\":17,\"id\":87,\"prefab\":2,\"X\":195},\"88\":{\"Y\":35,\"t\":17,\"id\":88,\"prefab\":2,\"X\":205},\"89\":{\"Y\":15,\"t\":17,\"id\":89,\"prefab\":3,\"X\":205},\"90\":{\"Y\":-115,\"t\":17,\"id\":90,\"prefab\":3,\"X\":-175},\"91\":{\"Y\":-135,\"t\":17,\"id\":91,\"prefab\":2,\"X\":-175},\"92\":{\"Y\":-155,\"t\":17,\"id\":92,\"prefab\":2,\"X\":-175},\"93\":{\"Y\":-175,\"t\":17,\"id\":93,\"prefab\":2,\"X\":-175},\"94\":{\"Y\":-185,\"t\":17,\"id\":94,\"prefab\":2,\"X\":-155},\"95\":{\"Y\":-185,\"t\":17,\"id\":95,\"prefab\":2,\"X\":-135},\"96\":{\"Y\":-195,\"t\":17,\"id\":96,\"prefab\":2,\"X\":145},\"97\":{\"Y\":-195,\"t\":17,\"id\":97,\"prefab\":3,\"X\":-95},\"98\":{\"Y\":-195,\"t\":17,\"id\":98,\"prefab\":3,\"X\":-75},\"99\":{\"Y\":-195,\"t\":17,\"id\":99,\"prefab\":3,\"X\":-55},\"100\":{\"Y\":-195,\"t\":17,\"id\":100,\"prefab\":3,\"X\":-35},\"101\":{\"Y\":-195,\"t\":17,\"id\":101,\"prefab\":3,\"X\":-15},\"102\":{\"Y\":-195,\"t\":17,\"id\":102,\"prefab\":3,\"X\":5},\"103\":{\"Y\":-195,\"t\":17,\"id\":103,\"prefab\":3,\"X\":25},\"104\":{\"Y\":-195,\"t\":17,\"id\":104,\"prefab\":3,\"X\":45},\"105\":{\"Y\":-195,\"t\":17,\"id\":105,\"prefab\":3,\"X\":65},\"106\":{\"Y\":-195,\"t\":17,\"id\":106,\"prefab\":3,\"X\":85},\"107\":{\"Y\":-195,\"t\":17,\"id\":107,\"prefab\":3,\"X\":105},\"108\":{\"Y\":-115,\"t\":17,\"id\":108,\"prefab\":3,\"X\":195},\"110\":{\"Y\":-135,\"t\":17,\"id\":110,\"prefab\":2,\"X\":195},\"111\":{\"Y\":-155,\"t\":17,\"id\":111,\"prefab\":2,\"X\":195},\"112\":{\"Y\":-175,\"t\":17,\"id\":112,\"prefab\":2,\"X\":195},\"113\":{\"Y\":-195,\"t\":17,\"id\":113,\"prefab\":3,\"X\":125},\"114\":{\"prefab\":8,\"rCP\":8,\"pr\":1,\"X\":225,\"Y\":-105,\"t\":3,\"id\":114,\"cP\":8,\"st\":365}}");
            _loc3_[0] = new SecNum(200 * 60 * 1000);
            _loc3_[1] = new SecNum(200 * 60 * 1000);
            _loc3_[2] = new SecNum(100 * 60 * 1000);
            _loc3_[3] = new SecNum(7 * 60);
         }
         else if(param1 == 3)
         {
            _loc2_ = com.adobe.serialization.json.JSON.decode("{\"0\":{\"Y\":-85,\"t\":112,\"id\":0,\"X\":-145},\"1\":{\"Y\":-315,\"t\":21,\"id\":1,\"prefab\":6,\"X\":-215},\"2\":{\"Y\":45,\"t\":21,\"id\":2,\"prefab\":6,\"X\":145},\"3\":{\"Y\":-155,\"t\":21,\"id\":3,\"prefab\":6,\"X\":-375},\"4\":{\"Y\":205,\"t\":21,\"id\":4,\"prefab\":6,\"X\":-15},\"5\":{\"Y\":-155,\"t\":20,\"id\":5,\"prefab\":6,\"X\":-85},\"6\":{\"Y\":45,\"t\":20,\"id\":6,\"prefab\":6,\"X\":-145},\"7\":{\"Y\":-155,\"t\":20,\"id\":7,\"prefab\":6,\"X\":-215},\"8\":{\"Y\":45,\"t\":20,\"id\":8,\"prefab\":6,\"X\":-15},\"9\":{\"Y\":115,\"t\":25,\"id\":9,\"X\":55},\"10\":{\"Y\":-225,\"t\":25,\"id\":10,\"X\":-285},\"11\":{\"Y\":-95,\"t\":23,\"id\":11,\"X\":-15},\"12\":{\"Y\":-15,\"t\":23,\"id\":12,\"X\":-215},\"13\":{\"Y\":135,\"t\":15,\"id\":13,\"prefab\":3,\"X\":-195},\"14\":{\"Y\":-65,\"t\":13,\"id\":14,\"prefab\":3,\"X\":-335},\"15\":{\"Y\":-75,\"t\":13,\"id\":15,\"prefab\":3,\"X\":75},\"16\":{\"Y\":-285,\"t\":16,\"id\":16,\"X\":-125},\"17\":{\"Y\":205,\"t\":5,\"id\":17,\"prefab\":3,\"X\":145},\"18\":{\"Y\":-335,\"t\":51,\"id\":18,\"prefab\":3,\"X\":-395},\"19\":{\"prefab\":8,\"cP\":10,\"rCP\":10,\"X\":-285,\"pr\":1,\"Y\":-315,\"t\":1,\"id\":19,\"st\":214975},\"20\":{\"prefab\":8,\"cP\":7,\"rCP\":7,\"X\":-15,\"pr\":1,\"Y\":115,\"t\":1,\"id\":20,\"st\":195535},\"21\":{\"prefab\":8,\"cP\":5,\"rCP\":5,\"X\":-215,\"pr\":1,\"Y\":-225,\"t\":2,\"id\":21,\"st\":214945},\"22\":{\"prefab\":8,\"cP\":5,\"rCP\":5,\"X\":145,\"pr\":1,\"Y\":115,\"t\":2,\"id\":22,\"st\":720},\"23\":{\"prefab\":8,\"cP\":10,\"rCP\":10,\"X\":-285,\"pr\":1,\"Y\":-155,\"t\":3,\"id\":23,\"st\":214910},\"24\":{\"prefab\":8,\"cP\":3,\"rCP\":3,\"X\":55,\"pr\":1,\"Y\":205,\"t\":3,\"id\":24,\"st\":195470},\"25\":{\"prefab\":8,\"cP\":2,\"rCP\":2,\"X\":-375,\"pr\":1,\"Y\":-225,\"t\":4,\"id\":25,\"st\":214945},\"26\":{\"prefab\":8,\"cP\":9,\"rCP\":9,\"X\":55,\"pr\":1,\"Y\":45,\"t\":4,\"id\":26,\"st\":2130},\"27\":{\"Y\":-185,\"t\":17,\"id\":27,\"prefab\":4,\"X\":-305},\"28\":{\"Y\":-145,\"t\":17,\"id\":28,\"prefab\":4,\"X\":-305},\"29\":{\"Y\":-165,\"t\":17,\"id\":29,\"prefab\":4,\"X\":-305},\"30\":{\"Y\":-125,\"t\":17,\"id\":30,\"prefab\":4,\"X\":-305},\"31\":{\"Y\":-105,\"t\":17,\"id\":31,\"prefab\":4,\"X\":-305},\"32\":{\"Y\":-205,\"t\":17,\"id\":32,\"prefab\":4,\"X\":-305},\"33\":{\"Y\":-85,\"t\":17,\"id\":33,\"prefab\":4,\"X\":-305},\"34\":{\"Y\":-225,\"t\":17,\"id\":34,\"prefab\":4,\"X\":-305},\"35\":{\"Y\":-245,\"t\":17,\"id\":35,\"prefab\":4,\"X\":-285},\"36\":{\"Y\":-245,\"t\":17,\"id\":36,\"prefab\":4,\"X\":-205},\"37\":{\"Y\":-245,\"t\":17,\"id\":37,\"prefab\":4,\"X\":-265},\"38\":{\"Y\":-245,\"t\":17,\"id\":38,\"prefab\":4,\"X\":-185},\"39\":{\"Y\":-245,\"t\":17,\"id\":39,\"prefab\":4,\"X\":-245},\"40\":{\"Y\":-245,\"t\":17,\"id\":40,\"prefab\":4,\"X\":-165},\"41\":{\"Y\":-245,\"t\":17,\"id\":41,\"prefab\":4,\"X\":-225},\"42\":{\"Y\":-245,\"t\":17,\"id\":42,\"prefab\":4,\"X\":-145},\"43\":{\"Y\":-225,\"t\":17,\"id\":43,\"prefab\":4,\"X\":-145},\"44\":{\"Y\":-205,\"t\":17,\"id\":44,\"prefab\":4,\"X\":-145},\"45\":{\"Y\":-185,\"t\":17,\"id\":45,\"prefab\":4,\"X\":-145},\"46\":{\"Y\":-165,\"t\":17,\"id\":46,\"prefab\":4,\"X\":-145},\"47\":{\"Y\":-145,\"t\":17,\"id\":47,\"prefab\":4,\"X\":-145},\"48\":{\"Y\":-125,\"t\":17,\"id\":48,\"prefab\":4,\"X\":-145},\"49\":{\"Y\":-85,\"t\":17,\"id\":49,\"prefab\":4,\"X\":-285},\"50\":{\"Y\":-105,\"t\":17,\"id\":50,\"prefab\":4,\"X\":-145},\"51\":{\"Y\":-85,\"t\":17,\"id\":51,\"prefab\":4,\"X\":-265},\"52\":{\"Y\":-85,\"t\":17,\"id\":52,\"prefab\":4,\"X\":-245},\"53\":{\"Y\":-85,\"t\":17,\"id\":53,\"prefab\":4,\"X\":-225},\"54\":{\"Y\":-65,\"t\":17,\"id\":54,\"prefab\":4,\"X\":-165},\"55\":{\"Y\":-85,\"t\":17,\"id\":55,\"prefab\":4,\"X\":-205},\"56\":{\"Y\":-45,\"t\":17,\"id\":56,\"prefab\":4,\"X\":-165},\"57\":{\"Y\":-85,\"t\":17,\"id\":57,\"prefab\":4,\"X\":-165},\"58\":{\"Y\":-35,\"t\":17,\"id\":58,\"prefab\":4,\"X\":-215},\"59\":{\"Y\":-35,\"t\":17,\"id\":59,\"prefab\":4,\"X\":-195},\"60\":{\"Y\":-35,\"t\":17,\"id\":60,\"prefab\":4,\"X\":-235},\"61\":{\"Y\":-15,\"t\":17,\"id\":61,\"prefab\":4,\"X\":-235},\"62\":{\"Y\":45,\"t\":17,\"id\":62,\"prefab\":4,\"X\":-235},\"63\":{\"Y\":5,\"t\":17,\"id\":63,\"prefab\":4,\"X\":-235},\"64\":{\"Y\":55,\"t\":17,\"id\":64,\"prefab\":4,\"X\":-215},\"65\":{\"Y\":25,\"t\":17,\"id\":65,\"prefab\":4,\"X\":-235},\"66\":{\"Y\":55,\"t\":17,\"id\":66,\"prefab\":4,\"X\":-195},\"67\":{\"Y\":75,\"t\":24,\"id\":67,\"X\":-165},\"68\":{\"Y\":205,\"t\":24,\"id\":68,\"X\":125},\"69\":{\"Y\":55,\"t\":17,\"id\":69,\"prefab\":4,\"X\":-175},\"70\":{\"Y\":-105,\"t\":17,\"id\":70,\"prefab\":4,\"X\":-125},\"71\":{\"Y\":-105,\"t\":17,\"id\":71,\"prefab\":4,\"X\":-105},\"72\":{\"Y\":-155,\"t\":17,\"id\":72,\"prefab\":4,\"X\":-105},\"73\":{\"Y\":-125,\"t\":24,\"id\":73,\"X\":-105},\"74\":{\"Y\":-135,\"t\":24,\"id\":74,\"X\":-125},\"75\":{\"Y\":-175,\"t\":17,\"id\":75,\"prefab\":4,\"X\":-105},\"76\":{\"Y\":-175,\"t\":17,\"id\":76,\"prefab\":4,\"X\":-85},\"77\":{\"Y\":-175,\"t\":17,\"id\":77,\"prefab\":4,\"X\":-65},\"78\":{\"Y\":-175,\"t\":17,\"id\":78,\"prefab\":4,\"X\":-45},\"79\":{\"Y\":-175,\"t\":17,\"id\":79,\"prefab\":4,\"X\":-25},\"80\":{\"Y\":-165,\"t\":17,\"id\":80,\"prefab\":4,\"X\":-5},\"81\":{\"Y\":-135,\"t\":24,\"id\":81,\"X\":-15},\"82\":{\"Y\":-245,\"t\":24,\"id\":82,\"X\":-305},\"83\":{\"Y\":-265,\"t\":24,\"id\":83,\"X\":-305},\"84\":{\"Y\":-245,\"t\":24,\"id\":84,\"X\":-325},\"85\":{\"Y\":-115,\"t\":17,\"id\":85,\"prefab\":4,\"X\":-5},\"86\":{\"Y\":-115,\"t\":17,\"id\":86,\"prefab\":4,\"X\":15},\"87\":{\"Y\":-115,\"t\":17,\"id\":87,\"prefab\":4,\"X\":35},\"88\":{\"Y\":-105,\"t\":17,\"id\":88,\"prefab\":4,\"X\":55},\"89\":{\"Y\":-85,\"t\":17,\"id\":89,\"prefab\":4,\"X\":55},\"90\":{\"Y\":-65,\"t\":17,\"id\":90,\"prefab\":4,\"X\":55},\"91\":{\"Y\":-45,\"t\":17,\"id\":91,\"prefab\":4,\"X\":55},\"92\":{\"Y\":-25,\"t\":17,\"id\":92,\"prefab\":4,\"X\":55},\"93\":{\"Y\":-25,\"t\":17,\"id\":93,\"prefab\":4,\"X\":35},\"94\":{\"Y\":-25,\"t\":17,\"id\":94,\"prefab\":4,\"X\":15},\"95\":{\"Y\":-15,\"t\":17,\"id\":95,\"prefab\":4,\"X\":-15},\"96\":{\"Y\":5,\"t\":17,\"id\":96,\"prefab\":4,\"X\":-15},\"97\":{\"Y\":25,\"t\":17,\"id\":97,\"prefab\":4,\"X\":-15},\"98\":{\"Y\":45,\"t\":17,\"id\":98,\"prefab\":4,\"X\":-35},\"99\":{\"Y\":45,\"t\":17,\"id\":99,\"prefab\":4,\"X\":-55},\"100\":{\"Y\":45,\"t\":17,\"id\":100,\"prefab\":4,\"X\":-75},\"101\":{\"Y\":95,\"t\":17,\"id\":101,\"prefab\":4,\"X\":-75},\"102\":{\"Y\":115,\"t\":17,\"id\":102,\"prefab\":4,\"X\":-75},\"103\":{\"Y\":115,\"t\":17,\"id\":103,\"prefab\":4,\"X\":-95},\"104\":{\"Y\":115,\"t\":17,\"id\":104,\"prefab\":4,\"X\":-115},\"105\":{\"Y\":115,\"t\":17,\"id\":105,\"prefab\":4,\"X\":-135},\"106\":{\"Y\":115,\"t\":17,\"id\":106,\"prefab\":4,\"X\":-155},\"107\":{\"Y\":105,\"t\":17,\"id\":107,\"prefab\":4,\"X\":-175},\"108\":{\"Y\":65,\"t\":17,\"id\":108,\"prefab\":4,\"X\":-35},\"109\":{\"Y\":85,\"t\":17,\"id\":109,\"prefab\":4,\"X\":-35},\"110\":{\"Y\":105,\"t\":17,\"id\":110,\"prefab\":4,\"X\":-35},\"111\":{\"Y\":125,\"t\":17,\"id\":111,\"prefab\":4,\"X\":-35},\"112\":{\"Y\":145,\"t\":17,\"id\":112,\"prefab\":4,\"X\":-35},\"113\":{\"Y\":165,\"t\":17,\"id\":113,\"prefab\":4,\"X\":-35},\"114\":{\"Y\":185,\"t\":17,\"id\":114,\"prefab\":4,\"X\":-35},\"115\":{\"Y\":185,\"t\":17,\"id\":115,\"prefab\":4,\"X\":-15},\"116\":{\"Y\":185,\"t\":17,\"id\":116,\"prefab\":4,\"X\":5},\"117\":{\"Y\":185,\"t\":17,\"id\":117,\"prefab\":4,\"X\":25},\"118\":{\"Y\":185,\"t\":17,\"id\":118,\"prefab\":4,\"X\":45},\"119\":{\"Y\":185,\"t\":17,\"id\":119,\"prefab\":4,\"X\":65},\"120\":{\"Y\":185,\"t\":17,\"id\":120,\"prefab\":4,\"X\":85},\"121\":{\"Y\":185,\"t\":17,\"id\":121,\"prefab\":4,\"X\":105},\"122\":{\"Y\":165,\"t\":17,\"id\":122,\"prefab\":4,\"X\":125},\"123\":{\"Y\":145,\"t\":17,\"id\":123,\"prefab\":4,\"X\":125},\"124\":{\"Y\":125,\"t\":17,\"id\":124,\"prefab\":4,\"X\":125},\"125\":{\"Y\":105,\"t\":17,\"id\":125,\"prefab\":4,\"X\":125},\"126\":{\"Y\":85,\"t\":17,\"id\":126,\"prefab\":4,\"X\":125},\"127\":{\"Y\":65,\"t\":17,\"id\":127,\"prefab\":4,\"X\":125},\"128\":{\"Y\":45,\"t\":17,\"id\":128,\"prefab\":4,\"X\":125},\"129\":{\"Y\":25,\"t\":17,\"id\":129,\"prefab\":4,\"X\":125},\"130\":{\"Y\":25,\"t\":17,\"id\":130,\"prefab\":4,\"X\":105},\"131\":{\"Y\":25,\"t\":17,\"id\":131,\"prefab\":4,\"X\":85},\"132\":{\"Y\":25,\"t\":17,\"id\":132,\"prefab\":4,\"X\":65},\"133\":{\"Y\":25,\"t\":17,\"id\":133,\"prefab\":4,\"X\":45},\"134\":{\"Y\":25,\"t\":17,\"id\":134,\"prefab\":4,\"X\":25},\"135\":{\"Y\":-55,\"t\":24,\"id\":135,\"X\":-185},\"136\":{\"Y\":-75,\"t\":24,\"id\":136,\"X\":-185},\"137\":{\"Y\":-55,\"t\":24,\"id\":137,\"X\":-205},\"138\":{\"Y\":-145,\"t\":24,\"id\":138,\"X\":5},\"139\":{\"Y\":-5,\"t\":24,\"id\":139,\"X\":5},\"140\":{\"Y\":-5,\"t\":24,\"id\":140,\"X\":25},\"141\":{\"Y\":15,\"t\":24,\"id\":141,\"X\":5},\"142\":{\"Y\":185,\"t\":24,\"id\":142,\"X\":125},\"143\":{\"Y\":185,\"t\":24,\"id\":143,\"X\":145},\"144\":{\"Y\":85,\"t\":24,\"id\":144,\"X\":-185},\"145\":{\"Y\":65,\"t\":24,\"id\":145,\"X\":-75},\"146\":{\"Y\":75,\"t\":24,\"id\":146,\"X\":-55},\"147\":{\"Y\":75,\"t\":22,\"id\":147,\"X\":-285},\"148\":{\"Y\":-205,\"t\":22,\"id\":148,\"X\":25}}");
            _loc3_[0] = new SecNum(50000000);
            _loc3_[1] = new SecNum(50000000);
            _loc3_[2] = new SecNum(25000000);
            _loc3_[3] = new SecNum(800);
         }
         else
         {
            LOGGER.Log("err","popup_prefab.GetBuildings " + param1);
         }
         return {
            "buildings":_loc2_,
            "costs":_loc3_
         };
      }
   }
}

