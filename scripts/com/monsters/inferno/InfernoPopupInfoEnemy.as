package com.monsters.inferno
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import com.monsters.alliances.*;
   import com.monsters.display.ImageCache;
   import com.monsters.mailbox.Message;
   import com.monsters.mailbox.model.Contact;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   
   public class InfernoPopupInfoEnemy extends PopupInfoEnemy_CLIP
   {
      private static var _takeoverCost:SecNum;
      
      private static var _minTakeoverCost:SecNum;
      
      private static var _takeoverCoeff1:SecNum;
      
      private static var _takeoverCoeff2:SecNum;
      
      private static var _shinyCost:SecNum;
      
      private static var _popupmc:bubblepopupRight;
      
      private static var _popupdo:DisplayObject;
      
      private static var _bookmarked:Boolean;
      
      private static var _protectedInRange:Boolean;
      
      private var _cell:InfernoMapCell;
      
      private var _mcMonsters:MovieClip;
      
      private var _mcResources:MovieClip;
      
      private var _message:Message;
      
      private var _profilePic:Loader;
      
      private var _profileBmp:Bitmap;
      
      public function InfernoPopupInfoEnemy()
      {
         super();
         x = 455;
         y = 260;
         this.tNameLabel.htmlText = "<b>" + KEYS.Get("popup_label_name") + "</b>";
         this.tLocationLabel.htmlText = "<b>" + KEYS.Get("popup_label_location") + "</b>";
         this.tHeightLabel.htmlText = "<b>" + KEYS.Get("popup_label_height") + "</b>";
         this.tYardHasLabel.htmlText = "<b>" + KEYS.Get("popup_label_thisyardhas") + "</b>";
         this.bAttack.SetupKey("map_attack_btn");
         this.bAttack.Highlight = true;
         this.bAttack.Enabled = true;
         this.bAttack.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bAttack.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bAttack.addEventListener(MouseEvent.CLICK,this.Attack);
         this.bView.SetupKey("map_view_btn");
         this.bView.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bView.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bView.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            View();
         });
         this.bSendMessage.SetupKey("map_message_btn");
         this.bSendMessage.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bSendMessage.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bSendMessage.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            ShowMessage();
         });
         this.bTruce.SetupKey("newmap_truce_btn");
         this.bTruce.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bTruce.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bTruce.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            ShowTruce();
         });
         this.bAlliance.Setup("Invite to Alliance");
         this.bAlliance.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bAlliance.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bAlliance.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            ShowAllianceInvite();
         });
         this.bBookmark.SetupKey("newmap_bookmark_btn");
         this.bBookmark.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bBookmark.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bBookmark.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            if(!_bookmarked)
            {
               InfernoMap._mc.ShowBookmarkAddPopup(_cell);
            }
            else
            {
               GLOBAL.Message(KEYS.Get("newmap_bm_done"));
            }
         });
         _minTakeoverCost = new SecNum(2000000);
         _takeoverCoeff1 = new SecNum(5000000);
         _takeoverCoeff2 = new SecNum(20000000);
         (mcFrame as frame).Setup();
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         if(Boolean(this._profilePic) && Boolean(this._profilePic.parent))
         {
            this._profilePic.parent.removeChild(this._profilePic);
            this._profilePic = null;
         }
         if(Boolean(this._profileBmp) && Boolean(this._profileBmp.parent))
         {
            this._profileBmp.parent.removeChild(this._profileBmp);
            this._profileBmp = null;
         }
         InfernoMap._mc.HideInfoEnemy();
      }
      
      public function Setup(param1:InfernoMapCell, param2:Boolean = false) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:InfernoMapCell = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         this._cell = param1;
         var _loc3_:Boolean = false;
         var _loc4_:Number = 0;
         if(POWERUPS.CheckPowers(POWERUPS.ALLIANCE_DECLAREWAR,"NORMAL"))
         {
            _loc3_ = true;
            _loc4_ = POWERUPS.Apply(POWERUPS.ALLIANCE_DECLAREWAR,[0]);
         }
         GLOBAL._attackerCellsInRange = InfernoMap._mc.GetCellsInRange(this._cell.X,this._cell.Y,1);
         InfernoMap._flingerInRange = param2;
         for each(_loc5_ in GLOBAL._attackerCellsInRange)
         {
            _loc10_ = _loc5_["cell"];
            _loc11_ = int(_loc5_["range"]);
            if(Boolean(_loc10_) && Boolean(_loc10_._mine))
            {
               InfernoMap._flingerInRange = true;
            }
         }
         if(this._cell._destroyed && !this._cell._protected && (this._cell._locked == 0 || this._cell._locked == LOGIN._playerID) && InfernoMap._flingerInRange)
         {
            this.bAttack.Setup("Take Over");
            this.bAttack.Enabled = true;
            this.bAttack.Highlight = true;
         }
         else
         {
            this.bAttack.SetupKey("map_attack_btn");
            if(this._cell._protected || this._cell._locked != 0 && this._cell._locked != LOGIN._playerID || !InfernoMap._flingerInRange)
            {
               this.bAttack.Highlight = false;
               this.bAttack.Enabled = false;
            }
            else
            {
               this.bAttack.Highlight = true;
               this.bAttack.Enabled = true;
            }
         }
         if(this._cell._base == 3)
         {
            this.bSendMessage.Enabled = true;
            this.bTruce.Enabled = true;
            if(ALLIANCES._myAlliance)
            {
               this.bAlliance.Enabled = true;
            }
            else
            {
               this.bAlliance.Enabled = false;
            }
            if(!this._cell._destroyed)
            {
               tName.htmlText = "<b>" + KEYS.Get("map_outpostowner",{"v1":this._cell._name}) + "</b>";
               if(this._cell._alliance)
               {
                  tName.htmlText += "<br>" + this._cell._alliance.name;
               }
            }
            else
            {
               tName.htmlText = "<b>" + KEYS.Get("map_outpostowner",{"v1":this._cell._name}) + " (" + KEYS.Get("newmap_inf_destroyed") + ")</b>";
               if(this._cell._alliance)
               {
                  tName.htmlText += "<br>" + this._cell._alliance.name;
               }
            }
            this.ProfilePic();
            if(this._cell._level)
            {
               mcLevel.visible = true;
               mcLevel.lv_txt.htmlText = "<b>" + this._cell._level + "</b>";
            }
            else
            {
               mcLevel.visible = false;
            }
            if(this._cell._alliance)
            {
               this.AlliancePic(AllyInfo._picURLs.sizeM,this.mcAlliancePic.mcImage,this.mcAlliancePic.mcBG,true);
            }
            else
            {
               this.mcAlliancePic.visible = false;
               this.mcRelations.visible = false;
            }
         }
         else if(this._cell._base == 2)
         {
            this.bSendMessage.Enabled = true;
            this.bTruce.Enabled = true;
            if(ALLIANCES._myAlliance)
            {
               this.bAlliance.Enabled = true;
            }
            else
            {
               this.bAlliance.Enabled = false;
            }
            tName.htmlText = "<b>" + KEYS.Get("map_yardowner",{"v1":this._cell._name}) + "</b>";
            if(this._cell._alliance)
            {
               tName.htmlText += "<br>" + this._cell._alliance.name;
            }
            this.ProfilePic();
            if(this._cell._level)
            {
               mcLevel.visible = true;
               mcLevel.lv_txt.htmlText = "<b>" + this._cell._level + "</b>";
            }
            else
            {
               mcLevel.visible = false;
            }
            if(this._cell._alliance)
            {
               this.AlliancePic(AllyInfo._picURLs.sizeM,this.mcAlliancePic.mcImage,this.mcAlliancePic.mcBG,true);
            }
            else
            {
               this.mcAlliancePic.visible = false;
               this.mcRelations.visible = false;
            }
         }
         else if(this._cell._base == 1)
         {
            this.bSendMessage.Enabled = false;
            this.bTruce.Enabled = false;
            this.bAlliance.Enabled = false;
            if(!this._cell._destroyed)
            {
               tName.htmlText = "<b>" + KEYS.Get("ai_tribe",{"v1":this._cell._name}) + "</b>";
            }
            else
            {
               tName.htmlText = "<b>" + KEYS.Get("ai_tribe",{"v1":this._cell._name}) + " (" + KEYS.Get("newmap_inf_destroyed") + ")</b>";
            }
            this.ProfilePic();
            if(this._cell._level)
            {
               mcLevel.visible = true;
               mcLevel.lv_txt.htmlText = "<b>" + this._cell._level + "</b>";
            }
            else
            {
               mcLevel.visible = false;
            }
            if(this._cell._alliance)
            {
               this.AlliancePic(AllyInfo._picURLs.sizeM,this.mcAlliancePic.mcImage,this.mcAlliancePic.mcBG,false);
            }
            else
            {
               this.mcAlliancePic.visible = false;
               this.mcRelations.visible = false;
            }
         }
         tLocation.htmlText = this._cell.X + "x" + this._cell.Y;
         tHeight.htmlText = this._cell._height - 100 + "m";
         if(this._cell._base == 2)
         {
            _loc6_ = 0;
         }
         else
         {
            _loc6_ = this._cell._height * 100 / GLOBAL._averageAltitude.Get() - 100;
         }
         if(this._cell._base == 2)
         {
            _loc7_ = 0;
         }
         else
         {
            _loc7_ = 100 * GLOBAL._averageAltitude.Get() / this._cell._height - 100;
         }
         if(_loc6_ >= 0)
         {
            _loc8_ = "<font color=\"#003300\">+" + KEYS.Get("newmap_h1",{"v1":_loc6_}) + "</font>";
         }
         else
         {
            _loc8_ = "<font color=\"#330000\">- " + KEYS.Get("newmap_h1",{"v1":Math.abs(_loc6_)}) + "</font>";
         }
         if(_loc7_ >= 0)
         {
            _loc9_ = "<font color=\"#003300\">+" + KEYS.Get("newmap_h2",{"v1":_loc7_}) + "</font>";
         }
         else
         {
            _loc9_ = "<font color=\"#330000\">- " + KEYS.Get("newmap_h2",{"v1":Math.abs(_loc7_)}) + "</font>";
         }
         tBonus.htmlText = _loc8_ + "<br>" + _loc9_;
         if(this._cell._friend)
         {
            this.bView.SetupKey("btn_help");
         }
         else
         {
            this.bView.SetupKey("map_view_btn");
         }
         _bookmarked = false;
         this.bBookmark.Enabled = true;
         if(InfernoMap._bookmarks)
         {
            _loc12_ = 0;
            while(_loc12_ < InfernoMap._bookmarks.length)
            {
               if(InfernoMap._bookmarks[_loc12_].location.x == this._cell.X && InfernoMap._bookmarks[_loc12_].location.y == this._cell.Y)
               {
                  _bookmarked = true;
                  break;
               }
               _loc12_++;
            }
            if(_bookmarked)
            {
               this.bBookmark.Enabled = false;
            }
            else
            {
               this.bBookmark.Enabled = true;
            }
         }
         this.Update();
      }
      
      public function Cleanup() : *
      {
         this.bAttack.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bAttack.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bAttack.removeEventListener(MouseEvent.CLICK,this.Attack);
         this.bView.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bView.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bView.removeEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            View();
         });
         this.bSendMessage.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bSendMessage.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bSendMessage.removeEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            ShowMessage();
         });
         this.bTruce.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bTruce.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bTruce.removeEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            ShowTruce();
         });
         this.bAlliance.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bAlliance.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bAlliance.removeEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            ShowAllianceInvite();
         });
         this.bBookmark.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfo);
         this.bBookmark.addEventListener(MouseEvent.MOUSE_OUT,function(param1:MouseEvent):*
         {
            PopupHide();
         });
         this.bBookmark.removeEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            if(!_bookmarked)
            {
               InfernoMap._mc.ShowBookmarkAddPopup(_cell);
            }
            else
            {
               GLOBAL.Message(KEYS.Get("newmap_bm_done"));
            }
         });
         _minTakeoverCost = null;
         _takeoverCoeff1 = null;
         _takeoverCoeff2 = null;
         mcFrame = null;
      }
      
      private function ProfilePic() : *
      {
         var onImageLoad:Function = null;
         var imageComplete:Function = null;
         var LoadImageError:Function = null;
         onImageLoad = function(param1:Event):void
         {
            if(_profilePic)
            {
               _profilePic.height = 50;
               _profilePic.width = 50;
            }
         };
         imageComplete = function(param1:String, param2:BitmapData):void
         {
            _profileBmp = new Bitmap(param2);
            mcProfilePic.mcBG.addChild(_profileBmp);
         };
         LoadImageError = function(param1:IOErrorEvent):*
         {
         };
         if(!this._cell._facebookID && this._cell._base != 1)
         {
            return;
         }
         if(this._cell._base > 1)
         {
            this._profilePic = new Loader();
            this._profilePic.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,LoadImageError,false,0,true);
            this._profilePic.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoad);
            this._profilePic.load(new URLRequest("http://graph.facebook.com/" + this._cell._facebookID + "/picture"));
            this.mcProfilePic.mcBG.addChild(this._profilePic);
         }
         else
         {
            switch(this._cell._name)
            {
               case "Dreadnought":
               case "Dreadnaut":
                  ImageCache.GetImageWithCallBack("monsters/tribe_dreadnaut_50.v2.jpg",imageComplete);
                  break;
               case "Kozu":
                  ImageCache.GetImageWithCallBack("monsters/tribe_kozu_50.v2.jpg",imageComplete);
                  break;
               case "Legionnaire":
                  ImageCache.GetImageWithCallBack("monsters/tribe_legionnaire_50.v2.jpg",imageComplete);
                  break;
               case "Abunakki":
                  ImageCache.GetImageWithCallBack("monsters/tribe_abunakki_50.v2.jpg",imageComplete);
            }
         }
      }
      
      public function AlliancePic(param1:String, param2:MovieClip, param3:MovieClip = null, param4:Boolean = false) : *
      {
         var k:int = 0;
         var allyinfo:AllyInfo = null;
         var size:String = param1;
         var container:MovieClip = param2;
         var containerBG:MovieClip = param3;
         var showRel:Boolean = param4;
         var AllianceIconLoaded:Function = function(param1:String, param2:BitmapData, param3:Array = null):*
         {
            var _loc4_:Bitmap = new Bitmap(param2);
            if(param3[0])
            {
               param3[0].addChild(_loc4_);
               param3[0].setChildIndex(_loc4_,0);
               if(param3[0].parent)
               {
                  param3[0].parent.visible = true;
               }
            }
         };
         var AllianceIconRelationLoaded:Function = function(param1:String, param2:BitmapData, param3:Array = null):*
         {
            var _loc4_:Bitmap = new Bitmap(param2);
            if(param3[0])
            {
               param3[0].addChild(_loc4_);
               param3[0].visible = true;
            }
         };
         if(!this._cell._facebookID || this._cell._base <= 1)
         {
            this.mcAlliancePic.visible = false;
            this.mcRelations.visible = false;
            return;
         }
         if(this._cell._base > 1 && Boolean(this._cell._alliance))
         {
            k = int(this.mcAlliancePic.mcImage.numChildren);
            while(k--)
            {
               this.mcAlliancePic.mcImage.removeChildAt(k);
            }
            k = this.mcRelations.numChildren;
            while(k--)
            {
               this.mcRelations.removeChildAt(k);
            }
            this.mcAlliancePic.visible = true;
            allyinfo = this._cell._alliance;
            allyinfo.AlliancePic(size,container,containerBG,true);
         }
         else
         {
            this.mcAlliancePic.visible = false;
         }
      }
      
      public function Attack(param1:MouseEvent) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:InfernoPopupTakeover = null;
         if(this._cell._destroyed && !this._cell._protected && (this._cell._locked == 0 || this._cell._locked == LOGIN._playerID) && InfernoMap._flingerInRange)
         {
            _loc2_ = _minTakeoverCost.Get();
            if(GLOBAL._mapOutpost)
            {
               _loc3_ = int(GLOBAL._mapOutpost.length);
               if(_loc3_ > 0 && _loc3_ <= 4)
               {
                  _loc2_ = _takeoverCoeff1.Get() * _loc3_;
               }
               else if(_loc3_ > 4)
               {
                  _loc2_ = _takeoverCoeff2.Get() + _minTakeoverCost.Get() * (_loc3_ - 4);
               }
            }
            _takeoverCost = new SecNum(_loc2_);
            _shinyCost = new SecNum(Math.ceil(Math.pow(Math.sqrt(_takeoverCost.Get() * 2),0.75)));
            if(_takeoverCost.Get() == 0)
            {
               this.TakeOverConfirm();
            }
            else
            {
               GLOBAL.BlockerAdd(GLOBAL._layerTop);
               _loc4_ = new InfernoPopupTakeover(this._cell);
               GLOBAL._layerTop.addChild(_loc4_);
            }
         }
         else if(this._cell._locked != 0 && this._cell._locked != LOGIN._playerID)
         {
            if(this._cell._base == 1)
            {
               GLOBAL.Message(KEYS.Get("newmap_take2"));
            }
            else
            {
               GLOBAL.Message(KEYS.Get("newmap_take3"));
            }
         }
         else if(this._cell._protected)
         {
            GLOBAL.Message(KEYS.Get("newmap_dp"));
         }
         else if(Boolean(this._cell._truce) && this._cell._truce > GLOBAL.Timestamp())
         {
            GLOBAL.Message(KEYS.Get("newmap_truce"));
         }
         else if(Boolean(this._cell._alliance) && this._cell._allianceID == ALLIANCES._allianceID)
         {
            GLOBAL.Message(KEYS.Get("map_attack_ally",{"v1":this._cell._name}),KEYS.Get("map_attack_btn"),this.DoAttack);
         }
         else if(Boolean(this._cell._alliance) && this._cell._alliance.relationship > 0)
         {
            GLOBAL.Message(KEYS.Get("map_attack_allyfriend",{"v1":this._cell._name}),KEYS.Get("map_attack_btn"),this.DoAttack);
         }
         else if(this._cell._friend)
         {
            GLOBAL.Message(KEYS.Get("map_msg_attackfriend",{"v1":this._cell._name}),KEYS.Get("map_attack_btn"),this.DoAttack);
         }
         else if(!bAttack.Enabled)
         {
            GLOBAL.Message(KEYS.Get("newmap_range"));
         }
         else
         {
            InfernoMap._mc.ShowAttack(this._cell);
         }
      }
      
      public function DoAttack() : *
      {
         InfernoMap._mc.ShowAttack(this._cell);
      }
      
      public function TakeOverConfirm() : *
      {
         var empire:Object = null;
         var takeoverSuccessful:Function = null;
         var takeoverError:Function = null;
         takeoverSuccessful = function(param1:Object):*
         {
            PLEASEWAIT.Hide();
            if(param1.error == 0)
            {
               BASE._takeoverFirstOpen = _cell._base == 1 ? 1 : 2;
               BASE._takeoverPreviousOwnersName = _cell._name;
               InfernoMap.GetCell(_cell.X,_cell.Y,true);
               GLOBAL._mapOutpost.push(new Point(_cell.X,_cell.Y));
               GLOBAL._resources.r1max += GLOBAL._outpostCapacity.Get();
               GLOBAL._resources.r2max += GLOBAL._outpostCapacity.Get();
               GLOBAL._resources.r3max += GLOBAL._outpostCapacity.Get();
               GLOBAL._resources.r4max += GLOBAL._outpostCapacity.Get();
               InfernoMap.ClearCells();
               InfernoMap.Hide();
               GLOBAL._attackerCellsInRange = [];
               GLOBAL._currentCell = _cell;
               GLOBAL._currentCell._base = 3;
               BASE._yardType = BASE.INFERNO_OUTPOST;
               GLOBAL.BlockerRemove();
               BASE.LoadBase(null,null,_cell._baseID,"build");
               LOGGER.Stat([37,BASE._takeoverFirstOpen]);
            }
            else
            {
               GLOBAL.Message(KEYS.Get("err_takeoverproblem") + param1.error);
            }
         };
         takeoverError = function(param1:IOErrorEvent):*
         {
            GLOBAL.Message(KEYS.Get("err_takeoverproblem") + param1.text);
         };
         var takeoverVars:Array = [["baseid",this._cell._baseID],["resources",com.adobe.serialization.json.JSON.encode({
            "r1":_takeoverCost.Get(),
            "r2":_takeoverCost.Get(),
            "r3":_takeoverCost.Get(),
            "r4":_takeoverCost.Get()
         })]];
         var mapIndex:int = 1;
         var possible:Boolean = false;
         var r1:int = _takeoverCost.Get();
         var r2:int = _takeoverCost.Get();
         var r3:int = _takeoverCost.Get();
         var r4:int = _takeoverCost.Get();
         if(GLOBAL._resources)
         {
            empire = {
               "r1":GLOBAL._resources.r1.Get(),
               "r2":GLOBAL._resources.r2.Get(),
               "r3":GLOBAL._resources.r3.Get(),
               "r4":GLOBAL._resources.r4.Get()
            };
            if(-r1 <= GLOBAL._resources.r1.Get() && -r2 <= GLOBAL._resources.r2.Get() && -r3 <= GLOBAL._resources.r3.Get() && -r4 <= GLOBAL._resources.r4.Get())
            {
               possible = true;
            }
         }
         if(possible)
         {
            PLEASEWAIT.Show(KEYS.Get("plsw_taking"));
            new URLLoaderApi().load(GLOBAL._mapURL + "takeovercell",takeoverVars,takeoverSuccessful,takeoverError);
         }
         else
         {
            GLOBAL.Message(KEYS.Get("newmap_take4"));
         }
      }
      
      public function View() : *
      {
         InfernoMap._mc.HideInfoEnemy();
         InfernoMap.Hide();
         if(InfernoMap._mc)
         {
            GLOBAL._attackerCellsInRange = InfernoMap._mc.GetCellsInRange(this._cell.X,this._cell.Y,4);
         }
         GLOBAL._currentCell = this._cell;
         if(this._cell._base == 1)
         {
            BASE._yardType = BASE.INFERNO_YARD;
            BASE.LoadBase(null,null,this._cell._baseID,"wmview");
         }
         else
         {
            BASE._yardType = this._cell._base == 3 ? BASE.INFERNO_OUTPOST : BASE.INFERNO_YARD;
            if(this._cell._friend)
            {
               BASE.LoadBase(null,null,this._cell._baseID,"help");
            }
            else
            {
               BASE.LoadBase(null,null,this._cell._baseID,"view");
            }
         }
      }
      
      public function ShowMessage() : *
      {
         if(this._cell._base < 2)
         {
            GLOBAL.Message(KEYS.Get("newmap_wmmsg"));
            return;
         }
         if(Boolean(this._message) && Boolean(this._message.parent))
         {
            this._message.parent.removeChild(this._message);
            this._message = null;
         }
         var _loc1_:Contact = new Contact(String(this._cell._userID),{
            "first_name":this._cell._name,
            "last_name":"",
            "pic_square":"http://graph.facebook.com/" + this._cell._facebookID + "/picture"
         });
         this._message = new Message();
         this._message.picker.preloadSelection(_loc1_);
         this._message.requestType = "message";
         this._message.body_txt.text = "";
         this._message.x = 0;
         this._message.y = -450;
         GLOBAL.BlockerAdd(this.parent as MovieClip);
         (this.parent as MovieClip).addChild(this._message);
      }
      
      public function ShowTruce() : *
      {
         if(this._cell._base < 2)
         {
            GLOBAL.Message(KEYS.Get("newmap_wmtruce",{"v1":this._cell._name}));
            return;
         }
         if(Boolean(this._message) && Boolean(this._message.parent))
         {
            this._message.parent.removeChild(this._message);
            this._message = null;
         }
         var _loc1_:Contact = new Contact(String(this._cell._userID),{
            "first_name":this._cell._name,
            "last_name":"",
            "pic_square":"http://graph.facebook.com/" + this._cell._facebookID + "/picture"
         });
         this._message = new Message();
         this._message.picker.preloadSelection(_loc1_);
         this._message.requestType = "trucerequest";
         this._message.subject_txt.text = KEYS.Get("map_trucerequest") + " " + this._cell._name;
         this._message.body_txt.text = KEYS.Get("map_trucemessage");
         this._message.x = 0;
         this._message.y = -450;
         GLOBAL.BlockerAdd(this.parent as MovieClip);
         (this.parent as MovieClip).addChild(this._message);
      }
      
      public function ShowAllianceInvite() : *
      {
         if(this._cell._base < 2)
         {
            GLOBAL.Message(KEYS.Get("newmap_wmtruce",{"v1":this._cell._name}));
            return;
         }
         ALLIANCES.AllianceInvite(this._cell);
      }
      
      public function ButtonInfo(param1:MouseEvent) : *
      {
         var _loc2_:String = "";
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1.currentTarget.name == "bAttack")
         {
            if(this._cell._destroyed)
            {
               _loc2_ = KEYS.Get("newmap_take5");
            }
            else
            {
               _loc2_ = KEYS.Get("newmap_att4");
            }
            _loc3_ = bAttack.x - 5;
            _loc4_ = bAttack.y + bAttack.height / 2 - 0;
         }
         else if(param1.currentTarget.name == "bView")
         {
            _loc2_ = KEYS.Get("newmap_view",{"v1":this._cell._name});
            _loc3_ = bView.x - 5;
            _loc4_ = bView.y + bAttack.height / 2 - 0;
         }
         else if(param1.currentTarget.name == "bSendMessage")
         {
            _loc2_ = KEYS.Get("newmap_msg");
            _loc3_ = bSendMessage.x - 5;
            _loc4_ = bSendMessage.y + bAttack.height / 2 - 0;
         }
         else if(param1.currentTarget.name == "bTruce")
         {
            _loc2_ = KEYS.Get("newmap_reqtruce");
            _loc3_ = bTruce.x - 5;
            _loc4_ = bTruce.y + bAttack.height / 2 - 0;
         }
         else if(param1.currentTarget.name == "bBookmark")
         {
            _loc2_ = KEYS.Get("newmap_bookmark");
            _loc3_ = bBookmark.x - 5;
            _loc4_ = bBookmark.y + bAttack.height / 2 - 0;
         }
         else if(param1.currentTarget.name == "bAlliance")
         {
            _loc2_ = KEYS.Get("btn_invitetoalliance");
            _loc3_ = bAlliance.x - 5;
            _loc4_ = bAlliance.y + bAttack.height / 2 - 0;
         }
         _loc3_ += this.x;
         _loc4_ += this.y;
         this.PopupShow(_loc3_,_loc4_,_loc2_);
      }
      
      public function PopupShow(param1:int, param2:int, param3:String) : *
      {
         this.PopupHide();
         _popupmc = new bubblepopupRight();
         _popupmc.Setup(param1,param2,param3,150);
         _popupmc.Nudge("left");
         _popupdo = this.parent.addChild(_popupmc);
      }
      
      public function PopupUpdate(param1:String) : *
      {
         if(_popupmc)
         {
            _popupmc.Update(param1);
         }
      }
      
      public function PopupHide() : *
      {
         if(_popupdo)
         {
            if(this.parent)
            {
               this.parent.removeChild(_popupdo);
            }
            _popupdo = null;
         }
      }
      
      public function Update() : *
      {
         var _loc1_:String = "";
         _loc1_ = "X:" + this._cell.X + " Y:" + this._cell.Y + "<br>_base:" + this._cell._base + "<br>_height:" + this._cell._height + "<br>_water:" + this._cell._water + "<br>_mine:" + this._cell._mine + "<br>_flinger:" + this._cell._flinger + "<br>_catapult:" + this._cell._catapult + "<br>_userID:" + this._cell._userID + "<br>_truce:" + this._cell._truce + "<br>_name:" + this._cell._name + "<br>_protected:" + this._cell._protected + "<br>_resources:" + com.adobe.serialization.json.JSON.encode(this._cell._resources) + "<br>_ticks:" + com.adobe.serialization.json.JSON.encode(this._cell._ticks) + "<br>_monsters:" + com.adobe.serialization.json.JSON.encode(this._cell._monsters);
         if(this._cell._monsterData)
         {
            _loc1_ += "<br>_monsterData:" + com.adobe.serialization.json.JSON.encode(this._cell._monsterData);
            _loc1_ += "<br>_monsterData.saved:" + com.adobe.serialization.json.JSON.encode(this._cell._monsterData.saved);
            _loc1_ += "<br>_monsterData.h:" + com.adobe.serialization.json.JSON.encode(this._cell._monsterData.h);
            _loc1_ += "<br>_monsterData.hcount:" + this._cell._monsterData.hcount;
         }
      }
   }
}

