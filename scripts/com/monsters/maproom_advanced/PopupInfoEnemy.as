package com.monsters.maproom_advanced
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import com.monsters.display.ImageCache;
   import com.monsters.mailbox.Message;
   import com.monsters.mailbox.model.Contact;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import gs.TweenLite;
   import gs.easing.Elastic;
   
   public class PopupInfoEnemy extends PopupInfoEnemy_CLIP
   {
      private static var _takeoverCost:SecNum;
      
      private static var _minTakeoverCost:SecNum;
      
      private static var _takeoverCoeff1:SecNum;
      
      private static var _takeoverCoeff2:SecNum;
      
      private static var _shinyCost:SecNum;
      
      private static var _bookmarked:Boolean;
      
      private static var _protectedInRange:Boolean;
      
      private var _cell:MapRoomCell;
      
      private var _mcMonsters:MovieClip;
      
      private var _mcResources:MovieClip;
      
      private var _message:Message;
      
      private var _profilePic:Loader;
      
      private var _profileBmp:Bitmap;
      
      public function PopupInfoEnemy()
      {
         super();
         x = 455;
         y = 260;
         this.bAttack.SetupKey("map_attack_btn");
         this.bAttack.Highlight = true;
         this.bAttack.Enabled = true;
         this.bAttack.addEventListener(MouseEvent.MOUSE_OVER,function(param1:MouseEvent):*
         {
            ButtonInfo("attack");
         });
         this.bAttack.addEventListener(MouseEvent.CLICK,this.Attack);
         this.bView.SetupKey("map_view_btn");
         this.bView.addEventListener(MouseEvent.MOUSE_OVER,function(param1:MouseEvent):*
         {
            ButtonInfo("view");
         });
         this.bView.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            View();
         });
         this.bSendMessage.SetupKey("map_message_btn");
         this.bSendMessage.addEventListener(MouseEvent.MOUSE_OVER,function(param1:MouseEvent):*
         {
            ButtonInfo("message");
         });
         this.bSendMessage.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            ShowMessage();
         });
         this.bTruce.SetupKey("newmap_truce_btn");
         this.bTruce.addEventListener(MouseEvent.MOUSE_OVER,function(param1:MouseEvent):*
         {
            ButtonInfo("truce");
         });
         this.bTruce.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            ShowTruce();
         });
         this.bBookmark.SetupKey("newmap_bookmark_btn");
         this.bBookmark.addEventListener(MouseEvent.MOUSE_OVER,function(param1:MouseEvent):*
         {
            ButtonInfo("bookmark");
         });
         this.bBookmark.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
         {
            if(!_bookmarked)
            {
               MapRoom._mc.ShowBookmarkAddPopup(_cell);
            }
            else
            {
               GLOBAL.Message(KEYS.Get("newmap_bm_done"));
            }
         });
         _minTakeoverCost = new SecNum(2000000);
         _takeoverCoeff1 = new SecNum(5000000);
         _takeoverCoeff2 = new SecNum(20000000);
         (mcFrame as frame2).Setup();
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
         MapRoom._mc.HideInfoEnemy();
      }
      
      public function Setup(param1:MapRoomCell, param2:Boolean = false) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:MapRoomCell = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         this._cell = param1;
         GLOBAL._attackerCellsInRange = MapRoom._mc.GetCellsInRange(this._cell.X,this._cell.Y,4);
         MapRoom._flingerInRange = param2;
         for each(_loc3_ in GLOBAL._attackerCellsInRange)
         {
            _loc8_ = _loc3_["cell"];
            _loc9_ = int(_loc3_["range"]);
            if(_loc8_ && _loc8_._mine && _loc8_._flinger.Get() >= _loc9_)
            {
               MapRoom._flingerInRange = true;
            }
            if(MapRoom._flingerInRange && _protectedInRange)
            {
               break;
            }
         }
         if(this._cell._destroyed && !this._cell._protected && (this._cell._locked == 0 || this._cell._locked == LOGIN._playerID) && MapRoom._flingerInRange)
         {
            this.bAttack.Setup("Take Over");
            this.bAttack.Enabled = true;
            this.bAttack.Highlight = true;
         }
         else
         {
            this.bAttack.Setup("Attack");
            if(this._cell._protected || this._cell._locked != 0 && this._cell._locked != LOGIN._playerID || !MapRoom._flingerInRange)
            {
               this.bAttack.Highlight = false;
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
            if(!this._cell._destroyed)
            {
               tName.htmlText = "<b>" + this._cell._name + "\'s " + KEYS.Get("b_outpost") + "</b>";
            }
            else
            {
               tName.htmlText = "<b>" + this._cell._name + "\'s " + KEYS.Get("b_outpost") + " (" + KEYS.Get("newmap_inf_destroyed") + ")</b>";
            }
            this.ProfilePic();
         }
         else if(this._cell._base == 2)
         {
            this.bSendMessage.Enabled = true;
            this.bTruce.Enabled = true;
            tName.htmlText = "<b>" + this._cell._name + "\'s Yard</b>";
            this.ProfilePic();
         }
         else if(this._cell._base == 1)
         {
            this.bSendMessage.Enabled = false;
            this.bTruce.Enabled = false;
            if(!this._cell._destroyed)
            {
               tName.htmlText = "<b>" + this._cell._name + " Tribe</b>";
            }
            else
            {
               tName.htmlText = "<b>" + this._cell._name + " Tribe (" + KEYS.Get("newmap_inf_destroyed") + ")</b>";
            }
            this.ProfilePic();
         }
         tLocation.htmlText = this._cell.X + "x" + this._cell.Y;
         tHeight.htmlText = this._cell._height - 100 + "m";
         if(this._cell._base == 2)
         {
            _loc4_ = 0;
         }
         else
         {
            _loc4_ = this._cell._height * 100 / GLOBAL._averageAltitude.Get() - 100;
         }
         if(this._cell._base == 2)
         {
            _loc5_ = 0;
         }
         else
         {
            _loc5_ = 100 * GLOBAL._averageAltitude.Get() / this._cell._height - 100;
         }
         if(_loc4_ >= 0)
         {
            _loc6_ = "<font color=\"#003300\">+" + KEYS.Get("newmap_h1",{"v1":_loc4_}) + "</font>";
         }
         else
         {
            _loc6_ = "<font color=\"#330000\">- " + KEYS.Get("newmap_h1",{"v1":Math.abs(_loc4_)}) + "</font>";
         }
         if(_loc5_ >= 0)
         {
            _loc7_ = "<font color=\"#003300\">+" + KEYS.Get("newmap_h2",{"v1":_loc5_}) + "</font>";
         }
         else
         {
            _loc7_ = "<font color=\"#330000\">- " + KEYS.Get("newmap_h2",{"v1":Math.abs(_loc5_)}) + "</font>";
         }
         tBonus.htmlText = _loc6_ + "<br>" + _loc7_;
         if(this._cell._friend)
         {
            this.bView.SetupKey("btn_help");
         }
         else
         {
            this.bView.SetupKey("map_view_btn");
         }
         this.ButtonInfo("attack");
         _bookmarked = false;
         this.bBookmark.Enabled = true;
         if(MapRoom._bookmarks)
         {
            _loc10_ = 0;
            while(_loc10_ < MapRoom._bookmarks.length)
            {
               if(MapRoom._bookmarks[_loc10_].location.x == this._cell.X && MapRoom._bookmarks[_loc10_].location.y == this._cell.Y)
               {
                  _bookmarked = true;
                  break;
               }
               _loc10_++;
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
      
      public function Attack(param1:MouseEvent) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:PopupTakeover = null;
         if(this._cell._destroyed && !this._cell._protected && (this._cell._locked == 0 || this._cell._locked == LOGIN._playerID) && MapRoom._flingerInRange)
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
               _loc4_ = new PopupTakeover(this._cell);
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
         else
         {
            MapRoom._mc.ShowAttack(this._cell);
         }
      }
      
      public function DoAttack() : *
      {
         MapRoom._mc.ShowAttack(this._cell);
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
               BASE._isOutpost = 1;
               BASE.LoadBase(null,null,_cell._baseID,"build");
               LOGGER.Stat([37,BASE._takeoverFirstOpen]);
            }
            else
            {
               GLOBAL.Message("There was a problem taking over this yard. " + param1.error);
            }
         };
         takeoverError = function(param1:IOErrorEvent):*
         {
            GLOBAL.Message("There was a problem taking over this yard:" + param1.text);
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
         MapRoom._mc.HideInfoEnemy();
         MapRoom.Hide();
         if(MapRoom._mc)
         {
            GLOBAL._attackerCellsInRange = MapRoom._mc.GetCellsInRange(this._cell.X,this._cell.Y,4);
         }
         GLOBAL._currentCell = this._cell;
         if(this._cell._base == 1)
         {
            BASE._isOutpost = 0;
            BASE.LoadBase(null,null,this._cell._baseID,"wmview");
         }
         else
         {
            BASE._isOutpost = this._cell._base == 3 ? 1 : 0;
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
      
      public function ButtonInfo(param1:String) : *
      {
         if(param1 == "attack")
         {
            if(this._cell._destroyed)
            {
               txtButtonInfo.htmlText = KEYS.Get("newmap_take5");
            }
            else
            {
               txtButtonInfo.htmlText = KEYS.Get("newmap_att4");
            }
            mcArrow.x = bAttack.x + bAttack.width / 2 - 5;
         }
         else if(param1 == "view")
         {
            txtButtonInfo.htmlText = KEYS.Get("newmap_view",{"v1":this._cell._name});
            mcArrow.x = bView.x + bView.width / 2 - 5;
         }
         else if(param1 == "message")
         {
            txtButtonInfo.htmlText = KEYS.Get("newmap_msg");
            mcArrow.x = bSendMessage.x + bSendMessage.width / 2 - 5;
         }
         else if(param1 == "truce")
         {
            txtButtonInfo.htmlText = KEYS.Get("newmap_reqtruce");
            mcArrow.x = bTruce.x + bTruce.width / 2 - 5;
         }
         else if(param1 == "bookmark")
         {
            txtButtonInfo.htmlText = KEYS.Get("newmap_bookmark");
            mcArrow.x = bBookmark.x + bBookmark.width / 2 - 5;
         }
         TweenLite.to(mcArrow,0.6,{
            "x":mcArrow.x + 5,
            "ease":Elastic.easeOut
         });
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

