package
{
   import com.monsters.display.BuildingAssetContainer;
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import gs.*;
   import gs.easing.*;
   import gs.plugins.*;
   
   public class UI_SIDEBAR_SLOT extends UI_SIDEBAR_SLOT_CLIP
   {
      private var _do:DisplayObject;
      
      private var _mc:MovieClip;
      
      private var _workers:Array;
      
      private var _popupmc:bubblepopup;
      
      private var _popupdo:DisplayObject;
      
      private var _popupID:int;
      
      public var _worker:MovieClip;
      
      public var _workPortrait:MovieClip;
      
      public var _hitbox:MovieClip;
      
      public var _mcimage:MovieClip;
      
      public var _image:BuildingAssetContainer;
      
      public var _bg:MovieClip;
      
      public var _bgmask:MovieClip;
      
      public var _instant:MovieClip;
      
      public var _mask:MovieClip;
      
      public var _desc:TextField;
      
      public var _descbg:MovieClip;
      
      public var _pBar:MovieClip;
      
      public var _pBarTxt:TextField;
      
      public var _alert:MovieClip;
      
      public var animAssets:Array;
      
      public var _id:int = -1;
      
      private var _STATE:String = "CLOSE";
      
      public var _ANIMSTATE:String = "CLOSE";
      
      private var _TYPE:String = "DESC";
      
      public var _isIdle:Boolean = false;
      
      public var _isLoaded:Boolean = false;
      
      public var _isWorker:Boolean = true;
      
      public var _isPurchased:Boolean = false;
      
      public var _disableBtn:Boolean = false;
      
      private var dest_open_time:Number = 0.5;
      
      private var dest_close_time:Number = 0.3;
      
      private var dest_desc_time:Number = 0.5;
      
      private var dest_close:Point = new Point(194,0);
      
      private var dest_open:Point = new Point(0,0);
      
      private var dest_desc:Point = new Point(75,0);
      
      private var dest_close_width:int = 36;
      
      private var dest_open_width:int = 240;
      
      private var dest_desc_width:int = 158;
      
      private var dest_img_width:int = 36;
      
      private var dest_neg_offset:int = 36;
      
      private var dest_desc_pos0:Point = new Point(-192,3);
      
      private var dest_desc_pos1:Point = new Point(-118,4);
      
      public var _isAnimating:Boolean = false;
      
      public var _lastTransition:Number = 0;
      
      public var _isSingle:Boolean = false;
      
      public var _objChanged:Boolean = false;
      
      public var _lastChanged:Number = 0;
      
      public var _showNotice:Boolean = false;
      
      private var _dropShadow:DropShadowFilter;
      
      public var _index:int = 0;
      
      public var configObj:Object;
      
      public var _building:BFOUNDATION;
      
      public var _checkMouse:Boolean = false;
      
      public var _mouseInRange:Boolean = true;
      
      public var _busy:* = false;
      
      public var _txt:String = "";
      
      public var _imageURL:String = "";
      
      public var _timePct:int = 0;
      
      public var _timetxt:String = "";
      
      public var _popuptype:String = "speedup";
      
      public var _desctxt:String = "";
      
      public var _mouseArea:Rectangle;
      
      public var _w:int;
      
      public var _h:int;
      
      public var _hasChanged:Boolean = false;
      
      public var _startupShow:Boolean = true;
      
      public var _showBar:Boolean = false;
      
      public var _showDesc:Boolean = false;
      
      public var _showInstant:Boolean = false;
      
      public var _showImage:Boolean = false;
      
      public var _showAlert:Boolean = false;
      
      public var _shinyCost:int = 0;
      
      public var _instantItemCode:String = "";
      
      private var _useFinishNow:Boolean = false;
      
      public function UI_SIDEBAR_SLOT()
      {
         super();
         this._image = new BuildingAssetContainer();
         this._image.mouseChildren = false;
         this._image.mouseEnabled = false;
         mc.mcImage.addChild(this._image);
         this._mc = mc;
         this._worker = mc.mcWorker;
         this._mcimage = mc.mcImage;
         this._hitbox = mc.mcHit;
         this._bg = mc.mcBG;
         this._bgmask = mc.mcBGMask;
         this._mask = mc.mcMask;
         this._instant = mc.mcInstant;
         this._alert = mc.mcAlert;
         this._pBar = mc.mcProgress;
         this._pBarTxt = mc.tProgress;
         this._desc = mc.tDesc;
         this._descbg = mc.tDescBG;
         this._worker.mouseEnabled = false;
         this._mcimage.mouseEnabled = false;
         this._bg.mouseEnabled = false;
         this._bgmask.mouseEnabled = false;
         this._mask.mouseEnabled = false;
         this._alert.mouseEnabled = false;
         this._pBar.mouseEnabled = false;
         this._pBarTxt.mouseEnabled = false;
         this._desc.mouseEnabled = false;
         this._descbg.mouseenabled = false;
         this.buttonMode = true;
         this._instant.gCoin.mouseEnabled = false;
         this._instant.gCoin.visible = false;
         this._instant.tLabel.mouseEnabled = false;
         this._instant.tLabel.visible = false;
         this.animAssets = [this._bg,this._bgmask,this._hitbox,this._mask,this._worker,this._mcimage,this._instant,this._alert,this._pBar,this._pBarTxt,this._desc,this._descbg];
         this.UpdateAlert("!");
         this.Update();
         this.AnimClose();
         if(this._startupShow)
         {
            this.AnimStop();
            this.ChangeState("OPEN");
            TweenLite.delayedCall(10,this.StartShowCB);
         }
      }
      
      public function Setup(param1:Object) : *
      {
         if(GLOBAL._mode == "build")
         {
            if(param1)
            {
               if(this.configObj != param1)
               {
                  this._objChanged = true;
                  this._lastChanged = GLOBAL.Timestamp();
                  this._hasChanged = true;
                  this._showNotice = true;
               }
               this.configObj = param1;
               if(this._txt != param1.message)
               {
                  this._txt = param1.message;
                  this._hasChanged = true;
               }
               this._imageURL = param1.image;
               this._timePct = param1.timePercent;
               this._timetxt = param1.time;
               if(this._desctxt != param1.message)
               {
                  this._desctxt = param1.message;
                  this._hasChanged = true;
               }
               if(this._TYPE != param1.slottype)
               {
                  this._TYPE = param1.slottype;
                  this._hasChanged = true;
               }
               if(this._building != param1.building)
               {
                  this._building = param1.building;
                  this._hasChanged = true;
               }
               this._busy = param1.active || param1.production;
               if(this._isPurchased != param1.purchased)
               {
                  this._isPurchased = param1.purchased;
                  this._hasChanged = true;
               }
               if(param1.building)
               {
                  if(!param1.building._type)
                  {
                  }
               }
               this._isLoaded = true;
            }
            else
            {
               this._showAlert = false;
            }
            if(this._isWorker)
            {
               this._image.visible = false;
               this._worker.visible = true;
            }
            else
            {
               this._image.visible = true;
               this._worker.visible = false;
            }
            this.Update();
         }
      }
      
      public function Update() : *
      {
         this.CheckAlert();
         if(this.configObj)
         {
            this._timePct = this.configObj.timePercent;
            this._timetxt = this.configObj.time;
            this._desctxt = this.configObj.message;
            this._busy = this.configObj.active || this.configObj.production;
            this._showAlert = this._busy;
            switch(this._TYPE)
            {
               case "DESC":
                  this._showDesc = true;
                  this._showBar = false;
                  this._showInstant = false;
                  this._desc.htmlText = this._desctxt;
                  break;
               case "INSTANT":
                  this._showDesc = false;
                  this._showBar = true;
                  this._showInstant = true;
                  this.UpdateBar(this._timePct);
                  this._pBarTxt.htmlText = this._desctxt + "<br>" + this._timetxt;
                  break;
               case "BUY":
                  this._showDesc = true;
                  this._showBar = false;
                  this._showInstant = true;
                  this._desc.htmlText = "Hire an Extra Worker.";
                  break;
               default:
                  this._showDesc = false;
                  this._showBar = false;
                  this._showInstant = false;
            }
            if(this._isWorker && Boolean(this._building))
            {
               if(this._useFinishNow)
               {
                  this.CalculateBuildingInstant();
               }
               else
               {
                  this.ConfigSpeedup();
               }
            }
            else if(!this._isWorker && Boolean(this._building))
            {
               this._image.Clear();
               if(this.configObj.icon)
               {
                  this._imageURL = this.configObj.icon;
               }
               if(Boolean(this._imageURL) && this._imageURL.length > 0)
               {
                  this.LoadImage(this._imageURL);
               }
               if(this._building._type)
               {
                  if(this._building._type == 8 && Boolean(CREATURELOCKER._unlocking))
                  {
                     if(CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].t == 1)
                     {
                        if(this._useFinishNow)
                        {
                           this.CalculateInstantUnlock();
                        }
                        else
                        {
                           this.ConfigSpeedup();
                        }
                     }
                  }
                  else if(this._building._type == 26 && Boolean(this._building._upgrading))
                  {
                     if(this._useFinishNow)
                     {
                        this.CalculateInstantTraining();
                     }
                     else
                     {
                        this.ConfigSpeedup();
                     }
                  }
               }
            }
            else
            {
               this._image.Clear();
               if(Boolean(this._imageURL) && this._imageURL.length > 0)
               {
                  this.LoadImage(this._imageURL);
               }
               if(this._mouseInRange)
               {
               }
            }
            if(this._isWorker && !this._isPurchased)
            {
               TweenLite.to(this._worker.mcIcon,0.25,{"autoAlpha":0.5});
            }
            else if(this._isWorker && this._isPurchased && this._worker.mcIcon.alpha < 1)
            {
               TweenLite.to(this._worker.mcIcon,0.25,{"autoAlpha":1});
            }
         }
         else
         {
            this._showAlert = false;
            this._showDesc = true;
            this._showBar = false;
            this._showInstant = false;
         }
         this._desc.htmlText = this._txt;
         var _loc1_:Boolean = UI_PROGRESSBAR._hatcheryFull;
         if(this._disableBtn)
         {
            _loc1_ = this._disableBtn;
         }
         if(_loc1_ && Boolean(this._building))
         {
            if((this._building._type == 13 || this._building._type == 16) && !this._isWorker)
            {
               this._instant.visible = false;
               this._instant.enabled = false;
            }
         }
         if(Boolean(this._building) && !this._isWorker)
         {
            if(this._building._countdownUpgrade.Get() + this._building._countdownBuild.Get() > 0)
            {
               this._bg.gotoAndStop(2);
            }
         }
         if(this._ANIMSTATE != this._STATE || this._hasChanged)
         {
            this.ChangeState(this._STATE);
         }
      }
      
      public function UpdateBar(param1:int) : void
      {
         var _loc2_:int = param1 / 100 * 100;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         this._pBar.mcBar.width = _loc2_;
      }
      
      public function TogglePortrait(param1:Boolean = false) : void
      {
      }
      
      public function ChangeState(param1:String, param2:Boolean = false) : *
      {
         if(param1 != this._ANIMSTATE || param2)
         {
            this._ANIMSTATE = param1;
            this._hasChanged = true;
         }
         if(this._startupShow && this._ANIMSTATE == "OPEN")
         {
            this._startupShow = false;
         }
         var _loc3_:* = GLOBAL.Timestamp() - this._lastChanged > UI_PROGRESSBAR._noticeDelay;
         if(!_loc3_)
         {
            this._isSingle = false;
            this._hasChanged = true;
         }
         if(this._ANIMSTATE != this._STATE && !this._isAnimating)
         {
            switch(this._ANIMSTATE)
            {
               case "OPEN":
                  this._showDesc = false;
                  this._showBar = true;
                  this._showInstant = true;
                  this._isSingle = false;
                  break;
               case "CLOSE":
                  this._showDesc = false;
                  this._showBar = false;
                  this._showInstant = false;
                  this._isSingle = false;
                  break;
               case "DESC":
                  this._showDesc = true;
                  this._showBar = false;
                  this._showInstant = false;
                  this._isSingle = false;
                  break;
               case "SINGLE":
                  this._showDesc = false;
                  this._showBar = true;
                  this._showInstant = true;
                  if(_loc3_)
                  {
                     this._isSingle = true;
                  }
                  break;
               default:
                  this._showBar = false;
                  this._showDesc = false;
                  this._showInstant = false;
                  this._ANIMSTATE = "CLOSE";
                  this._isSingle = false;
            }
            if(this._ANIMSTATE == "CLOSE" || UI_PROGRESSBAR._slotsState == "CLOSE" && this._ANIMSTATE != "SINGLE")
            {
               this._isSingle = false;
               if(this._STATE != "CLOSE")
               {
                  this.AnimClose();
               }
            }
            else if(this._ANIMSTATE == "OPEN" || _loc3_)
            {
               this._isSingle = false;
               if(this._TYPE == "INSTANT")
               {
                  this._showAlert = false;
                  this.AnimOpen();
               }
               else if(this._TYPE == "DESC")
               {
                  this._showAlert = false;
                  this._showDesc = true;
                  this.AnimDesc();
               }
               else
               {
                  this._showAlert = false;
                  this.AnimOpen();
               }
            }
            else if(this._ANIMSTATE == "SINGLE" && _loc3_)
            {
               this._isSingle = true;
               if(this._TYPE == "INSTANT")
               {
                  this._showAlert = false;
                  this.AnimOpen();
               }
               else if(this._TYPE == "DESC")
               {
                  this._showAlert = false;
                  this._showDesc = true;
               }
               else
               {
                  this._showAlert = false;
               }
            }
            else if(this._ANIMSTATE == "DESC" && UI_PROGRESSBAR._slotsState == "OPEN")
            {
               this._isSingle = false;
               this._showAlert = false;
               this.AnimDesc();
            }
            else
            {
               this._isSingle = false;
               this.AnimClose();
            }
         }
      }
      
      private function ConfigCB(param1:String) : void
      {
         this._lastTransition = GLOBAL.Timestamp();
         this._STATE = param1;
         if(UI_PROGRESSBAR._slotsState == "CLOSE" && this._isSingle)
         {
            this.ChangeState("CLOSE");
         }
      }
      
      public function LoadImage(param1:String) : void
      {
         var img:String = null;
         var ImageLoaded:Function = null;
         var imageURL:String = param1;
         ImageLoaded = function(param1:String, param2:BitmapData):void
         {
            _image.Clear();
            var _loc3_:* = new Bitmap(param2);
            _loc3_.x = (36 - _loc3_.width) / 2 - 36;
            _loc3_.y = (36 - _loc3_.width) / 2;
            _image.addChild(_loc3_);
         };
         if(imageURL.length > 0)
         {
            img = imageURL;
         }
         else if(STORE._storeData.BST)
         {
            img = "buildingthumbs/idle_worker_bst_icon.png";
         }
         else
         {
            img = "buildingthumbs/idle_worker_icon.png";
         }
         ImageCache.GetImageWithCallBack(img,ImageLoaded);
      }
      
      public function RenderBuilding(param1:Object) : *
      {
         var _building:Object;
         var _renderLevel:int;
         var numImageElements:Function;
         var imageDataA:Object = null;
         var imageDataB:Object = null;
         var imageLevel:int = 0;
         var thumbImgURL:String = null;
         var img:String = null;
         var thumbImgLen:int = 0;
         var i:int = 0;
         var j:int = 0;
         var _targetObj:Object = param1;
         if(!_targetObj.building)
         {
            return;
         }
         _building = _targetObj.building;
         _renderLevel = -1;
         if(GLOBAL._buildingProps[_building._type - 1].thumbImgData)
         {
            imageDataA = GLOBAL._buildingProps[_building._type - 1].thumbImgData;
            if(_building._lvl.Get() == 0)
            {
               imageDataB = imageDataA[1];
               imageLevel = 1;
            }
            else
            {
               numImageElements = function(param1:Object):int
               {
                  var _loc3_:String = null;
                  var _loc2_:int = 0;
                  for(_loc3_ in param1)
                  {
                     _loc2_++;
                  }
                  return _loc2_;
               };
               thumbImgLen = numImageElements(imageDataA);
               if(Boolean(imageDataA[_building._lvl.Get()]) && imageDataA[_building._lvl.Get()] >= _building._buildingProps.hp.length)
               {
                  imageDataB = imageDataA[_building._lvl.Get()];
                  imageLevel = int(_building._lvl.Get());
               }
               else
               {
                  i = int(_building._lvl.Get());
                  if(Boolean(imageDataA[i]) && i > _building._lvl.Get())
                  {
                     imageDataB = imageDataA[i];
                     imageLevel = i;
                  }
                  else
                  {
                     j = int(_building._lvl.Get());
                     while(j > 0)
                     {
                        if(imageDataA[j])
                        {
                           imageDataB = imageDataA[j];
                           imageLevel = j;
                           break;
                        }
                        if(j == 1)
                        {
                           imageDataB = imageDataB[1];
                           imageLevel = 1;
                           break;
                        }
                        j--;
                     }
                  }
               }
            }
            thumbImgURL = GLOBAL._buildingProps[_building._type - 1].thumbImgData[imageLevel].img;
            img = GLOBAL._buildingProps[_building._type - 1].thumbImgData.baseurl + thumbImgURL;
            this.LoadImage(img);
         }
         else
         {
            img = "buildingthumbs/" + _building._type + ".png";
            this.LoadImage(img);
         }
      }
      
      public function CheckAlert() : void
      {
         if(this.configObj)
         {
            this._busy = this.configObj.active || this.configObj.production;
         }
         else
         {
            this._busy = false;
         }
         if(this._busy)
         {
            this._showAlert = true;
         }
         else
         {
            this._showAlert = false;
         }
         if(this._showAlert && this._STATE == "CLOSE")
         {
            TweenLite.to(this._alert,this.dest_close_time * 0.5,{
               "autoAlpha":1,
               "ease":Sine.easeIn
            });
         }
         else
         {
            TweenLite.to(this._alert,this.dest_open_time * 0.5,{
               "autoAlpha":0,
               "ease":Sine.easeIn
            });
         }
      }
      
      public function UpdateAlert(param1:String, param2:int = 1) : void
      {
         this._alert.mcCounter.t.htmlText = "<b>" + param1 + "</b>";
         this._alert.mcSpin.visible = false;
         this._alert.mcCounter.gotoAndStop(param2);
         this.alpha = 1;
         this.visible = 1;
         this.enabled = 1;
      }
      
      public function AnimOpen() : void
      {
         this.AnimStop();
         this._isAnimating = true;
         TweenLite.to(this._mc,this.dest_open_time,{
            "x":this.dest_open.x,
            "ease":Expo.easeOut,
            "onComplete":this.AnimOpenFinish
         });
         this.AnimOpenCB();
      }
      
      public function AnimOpenCB() : void
      {
         if(this._showInstant)
         {
            TweenLite.to(this._instant,this.dest_open_time * 0,{
               "autoAlpha":1,
               "ease":Sine.easeIn
            });
         }
         else
         {
            TweenLite.to(this._instant,0,{
               "autoAlpha":0,
               "ease":Sine.easeIn
            });
         }
         if(this._showDesc)
         {
            TweenLite.to(this._desc,this.dest_open_time * 0,{
               "autoAlpha":1,
               "ease":Sine.easeIn
            });
            TweenLite.to(this._descbg,this.dest_open_time * 0,{
               "autoAlpha":1,
               "ease":Sine.easeIn
            });
         }
         else
         {
            TweenLite.to(this._desc,0,{
               "autoAlpha":0,
               "ease":Sine.easeIn
            });
            TweenLite.to(this._descbg,0,{
               "autoAlpha":0,
               "ease":Sine.easeIn
            });
         }
         if(this._showBar)
         {
            TweenLite.to(this._pBar,this.dest_open_time * 0,{
               "autoAlpha":1,
               "ease":Sine.easeIn
            });
            TweenLite.to(this._pBarTxt,this.dest_open_time * 0,{
               "autoAlpha":1,
               "ease":Sine.easeIn
            });
         }
         else
         {
            TweenLite.to(this._pBar,0,{
               "autoAlpha":0,
               "ease":Sine.easeIn
            });
            TweenLite.to(this._pBarTxt,0,{
               "autoAlpha":0,
               "ease":Sine.easeIn
            });
         }
         TweenLite.to(this._alert,this.dest_open_time * 0,{
            "autoAlpha":0,
            "ease":Sine.easeIn
         });
      }
      
      public function AnimOpenFinish() : void
      {
         this._isAnimating = false;
         this._ANIMSTATE = "OPEN";
         this.EnableInteraction();
         this.ConfigCB("OPEN");
      }
      
      public function AnimClose() : void
      {
         this.AnimStop();
         this._isAnimating = true;
         TweenLite.to(this._instant,this.dest_close_time * 0,{
            "autoAlpha":0,
            "ease":Sine.easeIn
         });
         TweenLite.to(this._desc,this.dest_close_time * 0,{
            "autoAlpha":0,
            "ease":Sine.easeIn
         });
         TweenLite.to(this._descbg,this.dest_close_time * 0,{
            "autoAlpha":0,
            "ease":Sine.easeIn
         });
         TweenLite.to(this._pBar,this.dest_close_time * 0,{
            "autoAlpha":0,
            "ease":Sine.easeIn
         });
         TweenLite.to(this._pBarTxt,this.dest_close_time * 0,{
            "autoAlpha":0,
            "ease":Sine.easeIn
         });
         TweenLite.to(this._alert,this.dest_close_time * 0,{
            "autoAlpha":0,
            "ease":Sine.easeIn
         });
         this.AnimCloseCB();
      }
      
      public function AnimCloseCB() : void
      {
         TweenLite.to(this._mc,this.dest_close_time,{
            "x":this.dest_close.x,
            "ease":Expo.easeOut,
            "onComplete":this.AnimCloseFinish
         });
      }
      
      public function AnimCloseFinish() : void
      {
         if(this._showAlert)
         {
            TweenLite.to(this._alert,this.dest_close_time * 0,{
               "autoAlpha":1,
               "ease":Sine.easeIn
            });
         }
         else
         {
            TweenLite.to(this._alert,this.dest_open_time * 0,{
               "autoAlpha":0,
               "ease":Sine.easeIn
            });
         }
         this._isAnimating = false;
         this._ANIMSTATE = "CLOSE";
         this.ConfigCB("CLOSE");
         this.DisableInteraction();
      }
      
      public function AnimDesc() : void
      {
         this.AnimStop();
         this._isAnimating = true;
         TweenLite.to(this._instant,this.dest_desc_time * 0,{
            "autoAlpha":0,
            "ease":Sine.easeIn
         });
         TweenLite.to(this._pBar,this.dest_desc_time * 0,{
            "autoAlpha":0,
            "ease":Sine.easeIn
         });
         TweenLite.to(this._pBarTxt,this.dest_desc_time * 0,{
            "autoAlpha":0,
            "ease":Sine.easeIn
         });
         TweenLite.to(this._alert,this.dest_desc_time * 0,{
            "autoAlpha":0,
            "ease":Sine.easeIn
         });
         this.AnimDescCB();
         if(this._showDesc)
         {
            TweenLite.to(this._desc,this.dest_desc_time * 0,{
               "autoAlpha":1,
               "ease":Sine.easeIn
            });
            TweenLite.to(this._descbg,this.dest_desc_time * 0,{
               "autoAlpha":1,
               "ease":Sine.easeIn
            });
         }
      }
      
      public function AnimDescCB() : void
      {
         TweenLite.to(this._mc,this.dest_desc_time,{
            "x":this.dest_desc.x,
            "ease":Expo.easeOut,
            "onComplete":this.AnimDescFinish
         });
      }
      
      public function AnimDescFinish() : void
      {
         if(this._showDesc)
         {
            TweenLite.to(this._desc,this.dest_desc_time * 0,{
               "autoAlpha":1,
               "ease":Sine.easeIn
            });
            TweenLite.to(this._descbg,this.dest_desc_time * 0,{
               "autoAlpha":1,
               "ease":Sine.easeIn
            });
         }
         this._isAnimating = false;
         this._ANIMSTATE = "DESC";
         this.ConfigCB("DESC");
         this.DisableInteraction();
      }
      
      public function AnimStop() : void
      {
         var _loc1_:* = 0;
         while(_loc1_ < this.animAssets.length)
         {
            TweenLite.killTweensOf(this.animAssets[_loc1_],true);
            _loc1_++;
         }
         this._isAnimating = false;
      }
      
      private function SpeedupStore(param1:MouseEvent) : void
      {
         POPUPS.Next();
         GLOBAL._selectedBuilding = this._building;
         if(this._building._type == 26)
         {
            ACADEMY._monsterID = this._building._upgrading;
         }
         STORE.ShowB(3,0,["SP1","SP2","SP3","SP4"]);
      }
      
      private function ConfigSpeedup() : void
      {
         this._instant.visible = true;
         this._instant.bAction.addEventListener(MouseEvent.CLICK,this.SpeedupStore);
         this._instant.bAction.Setup("Speed-Up");
         this._instant.tLabel.visible = false;
         this._instant.tLabel.mouseEnabled = false;
         this._instant.gCoin.mouseEnabled = false;
         this._instant.bAction.Highlight = true;
      }
      
      private function CalculateBuildingInstant() : void
      {
         this._instantItemCode = "SP4";
         this._shinyCost = this._building.FinishNowCost();
         this._instant.visible = true;
         this._instant.bAction.addEventListener(MouseEvent.CLICK,this.ActionInstant);
         this._instant.bAction.Setup("  ");
         this._instant.tLabel.htmlText = "<b>Finish Now for<br>" + this._shinyCost + " Shiny</b>";
         this._instant.tLabel.mouseEnabled = false;
         this._instant.gCoin.mouseEnabled = false;
         this._hitbox.mouseEnabled = false;
      }
      
      private function CalculateInstantUnlock() : void
      {
         this._instantItemCode = "SP4";
         this._instant.visible = true;
         this._instant.bAction.addEventListener(MouseEvent.CLICK,this.ActionInstantUnlock);
         this._shinyCost = STORE.GetTimeCost(CREATURELOCKER._lockerData[CREATURELOCKER._unlocking].e - GLOBAL.Timestamp());
         this._instant.bAction.Setup("  ");
         this._instant.tLabel.htmlText = "<b>Finish Now for<br>" + this._shinyCost + " Shiny</b>";
         this._instant.tLabel.mouseEnabled = false;
         this._instant.gCoin.mouseEnabled = false;
         this._hitbox.mouseEnabled = false;
      }
      
      private function CalculateInstantTraining() : void
      {
         this._instantItemCode = "SP4";
         if(ACADEMY._monsterID == null)
         {
            ACADEMY._monsterID = this._building._upgrading;
         }
         this._shinyCost = STORE.GetTimeCost(ACADEMY._upgrades[this._building._upgrading].time.Get() - GLOBAL.Timestamp());
         this._instant.visible = true;
         this._instant.bAction.addEventListener(MouseEvent.CLICK,this.ActionInstantTraining);
         this._instant.bAction.Setup("  ");
         this._instant.tLabel.htmlText = "<b>Finish Now for<br>" + this._shinyCost + " Shiny</b>";
         this._instant.tLabel.mouseEnabled = false;
         this._instant.gCoin.mouseEnabled = false;
         this._hitbox.mouseEnabled = false;
      }
      
      private function CalculateInstantFinish() : void
      {
         this._shinyCost = (this._building as BUILDING13)._finishCost.Get();
         if(this._shinyCost <= 0)
         {
            this._instant.visible = false;
            this._instant.mouseEnabled = false;
            this._txt = "<b>" + KEYS.Get("hat_status_nospace") + "</b>";
            this._disableBtn = true;
         }
         else
         {
            this._instant.visible = true;
            this._instant.mouseEnabled = true;
            this._instant.bAction.addEventListener(MouseEvent.CLICK,this.ActionInstantFinish);
            this._instant.bAction.Setup("  ");
            this._instant.tLabel.htmlText = "<b>Finish Now for<br>" + this._shinyCost + " Shiny</b>";
            this._instant.tLabel.mouseEnabled = false;
            this._instant.gCoin.mouseEnabled = false;
         }
      }
      
      private function CalculateInstantFinishHCC() : void
      {
         var _loc1_:BFOUNDATION = null;
         var _loc2_:BFOUNDATION = null;
         for each(_loc2_ in BASE._buildingsAll)
         {
            if(_loc2_._type == 16)
            {
               _loc1_ = _loc2_;
            }
         }
         if(_loc1_._type == 16)
         {
            this._shinyCost = (_loc1_ as BUILDING16)._finishCost.Get();
         }
         else
         {
            this._shinyCost = 0;
         }
         if(this._shinyCost <= 0)
         {
            this._instant.visible = false;
            this._instant.mouseEnabled = false;
            this._txt = "<b>" + KEYS.Get("hat_status_nospace") + "</b>";
            this._disableBtn = true;
         }
         else
         {
            this._instant.visible = true;
            this._instant.bAction.addEventListener(MouseEvent.CLICK,this.ActionInstantFinishHCC);
            this._instant.bAction.Setup("  ");
            this._instant.tLabel.htmlText = "<b>Finish All for<br>" + this._shinyCost + " Shiny</b>";
            this._instant.tLabel.mouseEnabled = false;
            this._instant.gCoin.mouseEnabled = false;
         }
         this._building = _loc1_;
      }
      
      private function ActionInstant(param1:MouseEvent) : *
      {
         if(this._STATE == "OPEN" && this._instant.visible == true && this._instant.alpha == 1)
         {
            this.PurchaseInstant();
            this._instant.bAction.removeEventListener(MouseEvent.CLICK,this.ActionInstant);
            param1.stopPropagation();
         }
      }
      
      private function ActionInstantUpgrade(param1:MouseEvent) : *
      {
         var _loc2_:Object = BASE.CanUpgrade(this._building);
         if(Boolean(_loc2_.error) && !_loc2_.needResource)
         {
            GLOBAL.Message(_loc2_.errorMessage);
         }
         else if(this._building.DoInstantUpgrade())
         {
            BUILDINGOPTIONS.Hide();
         }
      }
      
      private function ActionInstantUnlock(param1:MouseEvent) : *
      {
         GLOBAL._selectedBuilding = this._building;
         if(GLOBAL._selectedBuilding._type == 8)
         {
            STORE._storeItems.SP4.c = [this._shinyCost];
            STORE.BuyB(this._instantItemCode);
            CREATURELOCKER._unlocking = null;
            this._instant.bAction.removeEventListener(MouseEvent.CLICK,this.ActionInstantTraining);
         }
      }
      
      private function ActionInstantTraining(param1:MouseEvent) : *
      {
         GLOBAL._selectedBuilding = this._building;
         if(GLOBAL._selectedBuilding._type == 26)
         {
            this.CalculateInstantTraining();
            STORE._storeItems.SP4.c = [this._shinyCost];
            STORE.BuyB(this._instantItemCode);
         }
      }
      
      private function ActionInstantFinish(param1:MouseEvent) : *
      {
         GLOBAL._selectedBuilding = this._building;
         if(GLOBAL._selectedBuilding._type == 13)
         {
            (this._building as BUILDING13).FinishNow();
            this._instant.bAction.removeEventListener(MouseEvent.CLICK,this.ActionInstantFinish);
            this.Update();
         }
      }
      
      private function ActionInstantFinishHCC(param1:MouseEvent) : *
      {
         GLOBAL._selectedBuilding = this._building;
         if(GLOBAL._selectedBuilding._type == 16)
         {
            (this._building as BUILDING16).FinishNow();
            this._instant.bAction.removeEventListener(MouseEvent.CLICK,this.ActionInstantFinishHCC);
         }
      }
      
      public function PurchaseInstant() : *
      {
         GLOBAL._selectedBuilding = this._building;
         if(GLOBAL._selectedBuilding == this._building)
         {
            STORE._storeItems.SP4.c = [this._shinyCost];
            STORE.BuyB(this._instantItemCode);
         }
      }
      
      public function PurchaseInstantTraining() : *
      {
         GLOBAL._selectedBuilding = this._building;
         if(GLOBAL._selectedBuilding._type == 26)
         {
            STORE._storeItems.SP4.c = [this._shinyCost];
            STORE.BuyB(this._instantItemCode);
         }
      }
      
      public function PurchaseInstantUnlock() : *
      {
         GLOBAL._selectedBuilding = this._building;
         if(GLOBAL._selectedBuilding._type == 8)
         {
            STORE._storeItems.SP4.c = [this._shinyCost];
            STORE.BuyB(this._instantItemCode);
         }
      }
      
      public function DisableInteraction() : void
      {
         this._hitbox.mouseEnabled = true;
         this._instant.mouseChildren = false;
         this._alert.mouseEnabled = false;
         this._desc.mouseEnabled = false;
         this._pBarTxt.mouseEnabled = false;
         this._pBar.mouseEnabled = false;
         this._mask.mouseEnabled = false;
         this._worker.mouseEnabled = false;
         this._image.mouseEnabled = false;
         this._bg.mouseEnabled = true;
      }
      
      public function EnableInteraction() : void
      {
         this._hitbox.mouseEnabled = false;
         this._instant.mouseChildren = true;
         this._alert.mouseEnabled = false;
         this._desc.mouseEnabled = false;
         this._pBarTxt.mouseEnabled = false;
         this._pBar.mouseEnabled = false;
         this._mask.mouseEnabled = false;
         this._worker.mouseEnabled = false;
         this._image.mouseEnabled = false;
         this._bg.mouseEnabled = true;
      }
      
      public function StartShowCB() : void
      {
         if(this._startupShow)
         {
            this.ChangeState("CLOSE");
         }
      }
      
      public function Hide(param1:Boolean) : void
      {
         this.DisableInteraction();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         if(param1)
         {
            TweenLite.to(this,0.5,{"autoAlpha":0});
         }
         else
         {
            TweenLite.to(this,0,{"autoAlpha":0});
         }
      }
      
      public function Show(param1:Boolean) : void
      {
         this.EnableInteraction();
         this.mouseEnabled = true;
         this.mouseChildren = true;
         if(param1)
         {
            TweenLite.to(this,0.5,{"autoAlpha":0});
         }
         else
         {
            TweenLite.to(this,0,{"autoAlpha":0});
         }
      }
      
      public function get STATE() : String
      {
         return this._STATE;
      }
      
      public function set STATE(param1:String) : void
      {
         if(this._STATE != param1)
         {
            this._STATE = param1;
         }
      }
   }
}

import gs.OverwriteManager;
import gs.plugins.AutoAlphaPlugin;
import gs.plugins.TweenPlugin;

TweenPlugin.activate([AutoAlphaPlugin]);
OverwriteManager.init(OverwriteManager.AUTO);

