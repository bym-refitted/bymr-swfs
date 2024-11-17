package com.monsters.maproom_advanced
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import com.monsters.display.ImageCache;
   import com.monsters.effects.ResourceBombs;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   
   public class PopupAttackA extends PopupAttackA_CLIP
   {
      private var _cell:MapRoomCell;
      
      private var _mcMonsters:MovieClip;
      
      private var _mcResources:MovieClip;
      
      private var _attackMonsters:Object = {};
      
      private var _attackResources:Object = {};
      
      private var _monstersInRange:Boolean = false;
      
      public var _cellsInRange:Array = [];
      
      private var _enabled:Boolean = false;
      
      private var _profilePic:Loader;
      
      private var _profileBmp:Bitmap;
      
      private var _protectedInRange:Boolean;
      
      public function PopupAttackA()
      {
         super();
         this.bAttack.SetupKey("map_attack_btn");
         this.bAttack.addEventListener(MouseEvent.CLICK,this.Attack);
         this.bAttack.enabled = false;
         this.bAttack.buttonMode = true;
         this.bCancel.SetupKey("btn_cancel");
         this.bCancel.addEventListener(MouseEvent.CLICK,this.Hide);
         this.bCancel.buttonMode = true;
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         var _loc2_:int = int(mcProfilePic.mcBG.numChildren);
         while(_loc2_--)
         {
            mcProfilePic.mcBG.removeChildAt(_loc2_);
         }
         MapRoom._mc.HideAttack();
      }
      
      public function Setup(param1:MapRoomCell) : *
      {
         this._cell = param1;
         if(this._cell._base == 3)
         {
            this.tAttackText.htmlText = "<b>" + KEYS.Get("newmap_att1",{"v1":this._cell._name}) + "</b>";
         }
         else if(this._cell._base == 2)
         {
            this.tAttackText.htmlText = "<b>" + KEYS.Get("newmap_att2",{"v1":this._cell._name}) + "</b>";
         }
         else if(this._cell._base == 1)
         {
            this.tAttackText.htmlText = "<b>" + KEYS.Get("newmap_att3",{"v1":this._cell._name}) + "</b>";
         }
         else
         {
            LOGGER.Log("err","Cell at (" + this._cell.X + "," + this._cell.Y + ") has invalid base type " + this._cell._base + " when being attacked");
            this.tAttackText.htmlText = "<b>Attack</b>";
         }
         this._enabled = false;
         this.bAttack.Enabled = false;
         this.ProfilePic();
         this.Update();
      }
      
      private function Attack(param1:MouseEvent) : *
      {
         if(!this._enabled)
         {
            return false;
         }
         MapRoom._mc.HideAttack();
         if(!this._cell._protected && !(this._cell._truce && this._cell._truce > GLOBAL.Timestamp()) && this._monstersInRange)
         {
            if(this._protectedInRange)
            {
               GLOBAL.Message(KEYS.Get("newmap_attack"),KEYS.Get("confirm_btn"),this.DoAttack);
               return;
            }
            MapRoom.Hide();
            MapRoom.ClearCells();
            GLOBAL._attackerMapCreatures = this._attackMonsters;
            GLOBAL._attackerMapResources = this._attackResources;
            GLOBAL._attackerCellsInRange = this._cellsInRange;
            GLOBAL._currentCell = this._cell;
            if(this._cell._base == 1)
            {
               BASE._isOutpost = 0;
               BASE.LoadBase(null,null,this._cell._baseID,"wmattack");
            }
            else
            {
               BASE._isOutpost = this._cell._base == 3 ? 1 : 0;
               BASE.LoadBase(null,null,this._cell._baseID,"attack");
            }
         }
         else if(this._cell._protected)
         {
            if(!MapRoom._open)
            {
               POPUPS.Next();
            }
            GLOBAL.Message(KEYS.Get("newmap_dp"));
         }
         else if(Boolean(this._cell._truce) && this._cell._truce > GLOBAL.Timestamp())
         {
            if(!MapRoom._open)
            {
               POPUPS.Next();
            }
            GLOBAL.Message(KEYS.Get("newmap_truce"));
         }
         else if(!MapRoom._flingerInRange)
         {
            if(!MapRoom._open)
            {
               POPUPS.Next();
            }
            GLOBAL.Message(KEYS.Get("newmap_range"));
         }
         else
         {
            if(!MapRoom._open)
            {
               POPUPS.Next();
            }
            GLOBAL.Message(KEYS.Get("newmap_nomonsters"));
         }
      }
      
      public function DoAttack() : *
      {
         this._protectedInRange = false;
         this.Attack(null);
      }
      
      public function Update() : *
      {
         var _loc1_:Object = null;
         var _loc3_:MapRoomCell = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc8_:CATAPULTITEM = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:String = null;
         var _loc16_:MapRoomPopupInfoMonster = null;
         var _loc17_:MapRoomPopupInfoMonster = null;
         if(MapRoom._open)
         {
            this._cellsInRange = MapRoom._mc.GetCellsInRange(this._cell.X,this._cell.Y,4);
            for each(_loc1_ in this._cellsInRange)
            {
               _loc3_ = _loc1_["cell"];
               if(Boolean(_loc3_) && !_loc3_._processed)
               {
                  return false;
               }
            }
         }
         else
         {
            this._cellsInRange = GLOBAL._attackerCellsInRange;
         }
         if(!this._enabled)
         {
            this._monstersInRange = false;
            this._protectedInRange = false;
            MapRoom._flingerInRange = false;
            this._attackMonsters = {};
            this._attackResources = {
               "r1":GLOBAL._resources.r1.Get(),
               "r2":GLOBAL._resources.r2.Get(),
               "r3":GLOBAL._resources.r3.Get(),
               "catapult":new SecNum(0),
               "flinger":new SecNum(0)
            };
            for each(_loc1_ in this._cellsInRange)
            {
               _loc3_ = _loc1_["cell"];
               _loc9_ = int(_loc1_["range"]);
               if(Boolean(_loc3_) && Boolean(_loc3_._mine))
               {
                  _loc10_ = 0;
                  if(_loc3_._flinger.Get() >= _loc9_)
                  {
                     for(_loc11_ in _loc3_._monsters)
                     {
                        _loc12_ = int(_loc3_._monsters[_loc11_].Get());
                        this._monstersInRange = true;
                        _loc10_++;
                        if(_loc12_ > 0 && Boolean(_loc3_._protected))
                        {
                           this._protectedInRange = true;
                        }
                        if(this._attackMonsters[_loc11_])
                        {
                           this._attackMonsters[_loc11_].Add(_loc12_);
                        }
                        else
                        {
                           this._attackMonsters[_loc11_] = new SecNum(_loc12_);
                        }
                     }
                     MapRoom._flingerInRange = true;
                  }
                  if(_loc3_._catapult.Get() >= _loc9_ && _loc3_._catapult.Get() > this._attackResources.catapult.Get())
                  {
                     this._attackResources.catapult.Set(_loc3_._catapult.Get());
                  }
                  if(_loc3_._flinger.Get() >= this._attackResources.flinger.Get())
                  {
                     this._attackResources.flinger.Set(_loc3_._flinger.Get());
                  }
               }
            }
            if(GLOBAL._playerGuardianData && GLOBAL._playerGuardianData.hp.Get() > 0 && MapRoom._flingerInRange)
            {
               this._monstersInRange = true;
            }
            if(this._monstersInRange)
            {
               if(Boolean(this._mcMonsters) && Boolean(this._mcMonsters.parent))
               {
                  this._mcMonsters.parent.removeChild(this._mcMonsters);
                  this._mcMonsters = null;
               }
               this._mcMonsters = new MovieClip();
               this._mcMonsters.x = -180;
               this._mcMonsters.y = 25;
               _loc13_ = 0;
               _loc14_ = 0;
               if(Boolean(GLOBAL._playerGuardianData) && GLOBAL._playerGuardianData.hp.Get() > 0)
               {
                  _loc16_ = new MapRoomPopupInfoMonster();
                  _loc16_.Setup(0,0,"G" + GLOBAL._playerGuardianData.t + "_L" + GLOBAL._playerGuardianData.l.Get(),1);
                  this._mcMonsters.addChild(_loc16_);
                  _loc13_ += 1;
               }
               for(_loc15_ in this._attackMonsters)
               {
                  if(_loc14_ < 4)
                  {
                     _loc17_ = new MapRoomPopupInfoMonster();
                     _loc17_.Setup(_loc13_ * 125,_loc14_ * 30,_loc15_,this._attackMonsters[_loc15_].Get());
                     _loc13_ += 1;
                     if(_loc14_ <= 2)
                     {
                        this._mcMonsters.addChild(_loc17_);
                     }
                     if(_loc13_ == 3)
                     {
                        _loc13_ = 0;
                        _loc14_ += 1;
                     }
                  }
               }
               this.addChild(this._mcMonsters);
            }
            else if(Boolean(this._mcMonsters) && Boolean(this._mcMonsters.parent))
            {
               this._mcMonsters.parent.removeChild(this._mcMonsters);
               this._mcMonsters = null;
            }
            _loc5_ = -1;
            _loc6_ = -1;
            _loc7_ = -1;
            this._mcResources = new MovieClip();
            this._mcResources.x = -175;
            this._mcResources.y = -75;
            if(this._attackResources.catapult.Get() >= 1)
            {
               _loc4_ = 0;
               while(_loc4_ < 3)
               {
                  if(this._attackResources.r1 < ResourceBombs._bombs["tw" + _loc4_].cost)
                  {
                     break;
                  }
                  _loc5_ = _loc4_;
                  _loc4_++;
               }
            }
            if(this._attackResources.catapult.Get() >= 2)
            {
               _loc4_ = 0;
               while(_loc4_ < 4)
               {
                  if(this._attackResources.r2 < ResourceBombs._bombs["pb" + _loc4_].cost)
                  {
                     break;
                  }
                  _loc6_ = _loc4_;
                  _loc4_++;
               }
            }
            if(this._attackResources.catapult.Get() >= 3)
            {
               _loc4_ = 0;
               while(_loc4_ < 4)
               {
                  if(this._attackResources.r3 < ResourceBombs._bombs["pu" + _loc4_].cost)
                  {
                     break;
                  }
                  _loc7_ = _loc4_;
                  _loc4_++;
               }
            }
            _loc8_ = new CATAPULTITEM();
            if(_loc5_ >= 0)
            {
               _loc8_.Setup("tw" + _loc5_,true,true);
            }
            else
            {
               _loc8_.Setup("tw0",true,false);
            }
            _loc8_.x = 0;
            _loc8_.y = 0;
            this._mcResources.addChild(_loc8_);
            _loc8_ = new CATAPULTITEM();
            if(_loc6_ >= 0)
            {
               _loc8_.Setup("pb" + _loc6_,true,true);
            }
            else
            {
               _loc8_.Setup("pb0",true,false);
            }
            _loc8_.x = 65;
            _loc8_.y = 0;
            this._mcResources.addChild(_loc8_);
            _loc8_ = new CATAPULTITEM();
            if(_loc7_ >= 0)
            {
               _loc8_.Setup("pu" + _loc7_,true,true);
            }
            else
            {
               _loc8_.Setup("pu0",true,false);
            }
            _loc8_.x = 130;
            _loc8_.y = 0;
            this._mcResources.addChild(_loc8_);
            this.addChild(this._mcResources);
            this.bAttack.Enabled = true;
            this._enabled = true;
         }
         var _loc2_:String = "";
         _loc2_ = "X:" + this._cell.X + " Y:" + this._cell.Y + "<br>_base:" + this._cell._base + "<br>_height:" + this._cell._height + "<br>_water:" + this._cell._water + "<br>_mine:" + this._cell._mine + "<br>_flinger:" + this._cell._flinger + "<br>_catapult:" + this._cell._catapult + "<br>_userID:" + this._cell._userID + "<br>_truce:" + this._cell._truce + "<br>_name:" + this._cell._name + "<br>_protected:" + this._cell._protected + "<br>_resources:" + com.adobe.serialization.json.JSON.encode(this._cell._resources) + "<br>_ticks:" + com.adobe.serialization.json.JSON.encode(this._cell._ticks) + "<br>_monsters:" + com.adobe.serialization.json.JSON.encode(this._cell._monsters);
         if(this._cell._monsterData)
         {
            _loc2_ += "<br>_monsterData:" + com.adobe.serialization.json.JSON.encode(this._cell._monsterData);
            _loc2_ += "<br>_monsterData.saved:" + com.adobe.serialization.json.JSON.encode(this._cell._monsterData.saved);
            _loc2_ += "<br>_monsterData.h:" + com.adobe.serialization.json.JSON.encode(this._cell._monsterData.h);
            _loc2_ += "<br>_monsterData.hcount:" + this._cell._monsterData.hcount;
         }
         return this._enabled;
      }
      
      private function ProfilePic() : *
      {
         var onImageLoad:Function = null;
         var imageComplete:Function = null;
         var LoadImageError:Function = null;
         onImageLoad = function(param1:Event):void
         {
            _profilePic.height = 50;
            _profilePic.width = 50;
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
   }
}

