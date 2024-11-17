package
{
   import com.monsters.display.BuildingAssetContainer;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import gs.TweenLite;
   import gs.easing.*;
   
   public class SALESPECIALSPOPUP extends SALESPECIALSPOPUP_CLIP
   {
      public static var imageContainer:BuildingAssetContainer;
      
      public static var _open:Boolean;
      
      public static var _do:DisplayObject;
      
      public static var _iconsDO:DisplayObject;
      
      public static var _saleEnd:Number;
      
      public static var _page:String;
      
      public static var _popup:SALESPECIALSPOPUP;
      
      private static var _props:Object;
      
      public static var _saleDuration:Number = 600;
      
      public static var _alreadyDone:Boolean = false;
      
      public var _numGifts:int = 5;
      
      public var _giftSpacing:Number = 5;
      
      private var _giftsArray:Array;
      
      private var _giftItem:String = "HOD2";
      
      private var _textProps:Object = {
         "tTitleX":-150,
         "tTitleY":-100,
         "tTitleW":5 * 60,
         "tTitleH":70,
         "tDescX":-150,
         "tDescY":-50,
         "tDescW":5 * 60,
         "tDescH":100,
         "bActionX":-75,
         "bActionY":50,
         "bActionW":150,
         "bActionH":30,
         "mcIconsX":0,
         "mcIconsY":0,
         "mcIconsW":0,
         "mcIconsH":0,
         "mcFrameX":-170,
         "mcFrameY":-130,
         "mcFrameW":340,
         "mcFrameH":220,
         "tTitleText":"War Chest Feeling Light?<br>Fill it up with Shiny!",
         "tDescText1":"Limited time offer ! - ",
         "tDescText2":" remaining<br><br>",
         "tDescText3":"Upgrade buildings, purchase protection or unlock new monsters. Use Shiny to get bigger, better, and stronger!",
         "bActionText":"Buy Shiny"
      };
      
      private var _giftProps:Object = {
         "tTitleX":-150,
         "tTitleY":-100,
         "tTitleW":5 * 60,
         "tTitleH":70,
         "tDescX":-150,
         "tDescY":-70,
         "tDescW":5 * 60,
         "tDescH":100,
         "bActionX":-75,
         "bActionY":110,
         "bActionW":150,
         "bActionH":30,
         "mcIconsX":-190,
         "mcIconsY":-25,
         "mcIconsW":0,
         "mcIconsH":0,
         "mcFrameX":-210,
         "mcFrameY":-130,
         "mcFrameW":7 * 60,
         "mcFrameH":290,
         "tTitleText":"Buy Some, Get Some!",
         "tDescText1":"Limited time offer ! - ",
         "tDescText2":" remaining<br><br><br><br><br><br><br><br>",
         "tDescText3":"For a limited time, get five (5) Hatchery Speed-Ups for <b>FREE</b> when you purchasde any amount of Shiny!",
         "bActionText":"Buy Shiny"
      };
      
      private var _giftConfirmProps:Object = {
         "tTitleX":-150,
         "tTitleY":-100,
         "tTitleW":5 * 60,
         "tTitleH":70,
         "tDescX":-150,
         "tDescY":-60,
         "tDescW":5 * 60,
         "tDescH":100,
         "bActionX":-75,
         "bActionY":110,
         "bActionW":150,
         "bActionH":30,
         "mcIconsX":-190,
         "mcIconsY":-55,
         "mcIconsW":0,
         "mcIconsH":0,
         "mcFrameX":-210,
         "mcFrameY":-130,
         "mcFrameW":7 * 60,
         "mcFrameH":290,
         "tTitleText":"Reap the Rewards",
         "tDescText1":"",
         "tDescText2":"<br><br><br><br><br><br>",
         "tDescText3":"Your five Level 2 Hatchery Overdrives can be found in the Store.  Activate one and crank out a huge monster army!",
         "bActionText":"Go to Store"
      };
      
      private var _shinyDiscountProps:Object = {
         "tTitleX":-150,
         "tTitleY":-100,
         "tTitleW":5 * 60,
         "tTitleH":70,
         "tDescX":-150,
         "tDescY":-70,
         "tDescW":5 * 60,
         "tDescH":100,
         "bActionX":-75,
         "bActionY":30,
         "bActionW":150,
         "bActionH":30,
         "mcIconsX":0,
         "mcIconsY":0,
         "mcIconsW":0,
         "mcIconsH":0,
         "mcFrameX":-170,
         "mcFrameY":-130,
         "mcFrameW":340,
         "mcFrameH":200,
         "tTitleText":"Shiny on the Cheap!",
         "tDescText1":"Limited time offer ! - ",
         "tDescText2":" remaining<br><br>",
         "tDescText3":"Shiny on the cheap! For a limited time, get a <b>10% discount on Shiny</b> and beef up your yard with a well-timed purchase.",
         "bActionText":"Buy Shiny"
      };
      
      private var _shinyBonusProps:Object = {
         "tTitleX":-150,
         "tTitleY":-100,
         "tTitleW":5 * 60,
         "tTitleH":70,
         "tDescX":-150,
         "tDescY":-70,
         "tDescW":5 * 60,
         "tDescH":100,
         "bActionX":-75,
         "bActionY":30,
         "bActionW":150,
         "bActionH":30,
         "mcIconsX":0,
         "mcIconsY":0,
         "mcIconsW":0,
         "mcIconsH":0,
         "mcFrameX":-170,
         "mcFrameY":-130,
         "mcFrameW":340,
         "mcFrameH":200,
         "tTitleText":"Get it While it\'s Hot!",
         "tDescText1":"Limited time offer ! - ",
         "tDescText2":" remaining<br><br>",
         "tDescText3":"For a limited time, grab an extra <b>10% Shiny bonus</b> with each purchase and beef up your yard!",
         "bActionText":"Buy Shiny"
      };
      
      public function SALESPECIALSPOPUP(param1:String = "text")
      {
         super();
         _page = param1;
         this.Switch(_page);
      }
      
      public static function Check() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(GLOBAL._mode == "build" && !GLOBAL._monetized && !SALESPECIALSPOPUP._open && BASE.BaseLevel().level >= 26 && !_alreadyDone)
         {
            _loc1_ = 0;
            _loc2_ = int(LOGIN._digits[LOGIN._digits.length - 1]);
            _loc3_ = int(LOGIN._digits[LOGIN._digits.length - 2]);
            _loc4_ = int(LOGIN._digits[LOGIN._digits.length - 3]);
            _loc5_ = (_loc4_ + _loc2_) % 10;
            _loc6_ = (_loc3_ + _loc2_) % 10;
            if(_loc5_ <= 7)
            {
               _loc1_ = 0;
            }
            else if(_loc5_ == 8)
            {
               if(_loc6_ <= 4)
               {
                  _loc1_ = 1;
               }
               else
               {
                  _loc1_ = 2;
               }
            }
            else if(_loc5_ == 9)
            {
               if(_loc6_ <= 4)
               {
                  _loc1_ = 3;
               }
               else
               {
                  _loc1_ = 4;
               }
            }
            if(_loc1_ != 0)
            {
               SALESPECIALSPOPUP.CheckPromoTimer();
            }
            _alreadyDone = true;
         }
      }
      
      public static function Show(param1:String = "text") : *
      {
         if(!_open)
         {
            SOUNDS.Play("click1");
            BASE.BuildingDeselect();
            _open = true;
            _page = param1;
            _popup = new SALESPECIALSPOPUP(param1);
            CheckPromoTimer();
            POPUPS.Push(_popup,BUY.logPromoShown,[param1],null,null,false,"wait");
            TweenLite.to(_do,0.2,{
               "scaleX":1,
               "scaleY":1,
               "ease":Quad.easeOut
            });
            if(!_saleEnd && param1 != "giftconfirm")
            {
               SALESPECIALSPOPUP.StartSale();
            }
            _popup.Switch(_page);
            _popup.addEventListener(Event.ENTER_FRAME,SALESPECIALSPOPUP.Tick);
            _popup.bAction.addEventListener(MouseEvent.CLICK,SALESPECIALSPOPUP.OnActionClick);
         }
      }
      
      public static function Tick(param1:Event) : void
      {
         if(_open && Boolean(_popup))
         {
            _popup.Update(_page);
         }
         if(_saleEnd < GLOBAL.Timestamp())
         {
            SALESPECIALSPOPUP.EndSale();
         }
      }
      
      public static function CheckPromoTimer() : void
      {
         GLOBAL.CallJS("cc.startPromoTimer",[{"callback":"startPromoTimer"}]);
      }
      
      public static function StartSale(param1:int = 0) : void
      {
         if(param1 > 0 && param1 > GLOBAL.Timestamp())
         {
            _saleEnd = param1;
            if(GLOBAL._flags.midgameIncentive == 1)
            {
               SALESPECIALSPOPUP.Show("text");
            }
            else if(GLOBAL._flags.midgameIncentive == 2)
            {
               SALESPECIALSPOPUP.Show("gift");
            }
            else if(GLOBAL._flags.midgameIncentive == 3)
            {
               SALESPECIALSPOPUP.Show("shinydiscount");
            }
            else if(GLOBAL._flags.midgameIncentive == 4)
            {
               SALESPECIALSPOPUP.Show("shinybonus");
            }
            else if(GLOBAL._flags.midgameIncentive == 5)
            {
               SALESPECIALSPOPUP.Show("giftconfirm");
            }
         }
      }
      
      public static function EndSale() : void
      {
         _saleEnd = GLOBAL.Timestamp();
      }
      
      public static function OnActionClick(param1:MouseEvent = null) : void
      {
         if(_page == "giftconfirm")
         {
            POPUPS.Next();
            STORE.ShowB(3,1,["HOD","HOD2","HOD3"]);
         }
         else
         {
            BUY.MidGameOffers(_page);
         }
      }
      
      public static function Hide() : *
      {
         if(_open)
         {
            SOUNDS.Play("close");
            _open = false;
            _popup.removeEventListener(Event.ENTER_FRAME,SALESPECIALSPOPUP.Tick);
            _popup.bAction.removeEventListener(MouseEvent.CLICK,OnActionClick);
            POPUPS.Next();
         }
      }
      
      public function Switch(param1:String = "text") : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc6_:store_icon_CLIP = null;
         switch(param1)
         {
            case "text":
               _props = this._textProps;
               break;
            case "gift":
               _props = this._giftProps;
               break;
            case "giftconfirm":
               _props = this._giftConfirmProps;
               break;
            case "shinydiscount":
               _props = this._shinyDiscountProps;
               break;
            case "shinybonus":
               _props = this._shinyBonusProps;
         }
         this.tTitle.x = _props.tTitleX;
         this.tTitle.y = _props.tTitleY;
         this.tTitle.width = _props.tTitleW;
         this.tTitle.height = _props.tTitleH;
         this.tTitle.htmlText = _props.tTitleText;
         this.tDesc.x = _props.tDescX;
         this.tDesc.y = _props.tDescY;
         this.tDesc.width = _props.tDescW;
         this.tDesc.height = _props.tDescH;
         this.bAction.x = _props.bActionX;
         this.bAction.y = _props.bActionY;
         this.bAction.width = _props.bActionW;
         this.bAction.height = _props.bActionH;
         this.bAction.Setup(_props.bActionText);
         this.mcFrame.x = _props.mcFrameX;
         this.mcFrame.y = _props.mcFrameY;
         this.mcFrame.width = _props.mcFrameW;
         this.mcFrame.height = _props.mcFrameH;
         (this.mcFrame as frame2).Setup();
         if(_page == "gift" || _page == "giftconfirm")
         {
            if(Boolean(_iconsDO) && Boolean(_iconsDO.parent))
            {
               _iconsDO.parent.removeChild(_iconsDO);
               _iconsDO = null;
            }
            this._giftsArray = [];
            _loc2_ = Number(_props.mcIconsX);
            _loc3_ = Number(_props.mcIconsY);
            _loc4_ = new MovieClip();
            _loc5_ = 0;
            while(_loc5_ < this._numGifts)
            {
               _loc6_ = new store_icon_CLIP();
               _loc6_.gotoAndStop(this._giftItem);
               _loc6_.x = _loc2_;
               _loc6_.y = _loc3_;
               _loc2_ += this._giftSpacing + _loc6_.width;
               _loc4_.addChild(_loc6_);
               _loc5_++;
            }
            _iconsDO = this.addChild(_loc4_);
         }
         this.Update(_page);
      }
      
      public function Update(param1:String = "text") : void
      {
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc2_:String = "";
         _loc4_ = _saleEnd - GLOBAL.Timestamp();
         _loc3_ = GLOBAL.ToTime(_loc4_);
         _loc2_ += _props.tDescText1;
         if(_page != "giftconfirm")
         {
            _loc2_ += "<b>" + _loc3_ + "</b>";
         }
         _loc2_ += _props.tDescText2;
         _loc2_ += _props.tDescText3;
         this.tDesc.htmlText = _loc2_;
         this.tDesc.autoSize = TextFieldAutoSize.CENTER;
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         SALESPECIALSPOPUP.Hide();
      }
   }
}

