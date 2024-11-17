package com.monsters.maproom_advanced
{
   import com.cc.utils.SecNum;
   import com.monsters.alliances.*;
   import com.monsters.display.ImageCache;
   import com.monsters.display.ScrollSet;
   import com.monsters.effects.ResourceBombs;
   import com.monsters.siege.SiegeWeapons;
   import com.monsters.siege.weapons.SiegeWeapon;
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
      
      private var _mcResources:MovieClip;
      
      private var _attackMonsters:Object = {};
      
      private var _attackResources:Object = {};
      
      private var _monstersInRange:Boolean = false;
      
      public var _cellsInRange:Vector.<CellData> = new Vector.<CellData>(0,true);
      
      private var _enabled:Boolean = false;
      
      private var _profilePic:Loader;
      
      private var _profileBmp:Bitmap;
      
      private var _protectedInRange:Boolean;
      
      private var _scroller:ScrollSet;
      
      public function PopupAttackA()
      {
         super();
         mMonsters.mask = mMonstersMask;
         this._scroller = new ScrollSet();
         this._scroller.isHiddenWhileUnnecessary = true;
         this._scroller.AutoHideEnabled = false;
         this._scroller.width = scroll.width;
         this._scroller.x = scroll.x;
         this._scroller.y = scroll.y;
         addChild(this._scroller);
         this._scroller.Init(mMonsters,mMonstersMask,0,scroll.y,scroll.height);
         this.bAttack.SetupKey("map_attack_btn");
         this.bAttack.addEventListener(MouseEvent.CLICK,this.Attack);
         this.bAttack.enabled = false;
         this.bAttack.buttonMode = true;
         this.bCancel.SetupKey("btn_cancel");
         this.bCancel.addEventListener(MouseEvent.CLICK,this.Hide);
         this.bCancel.buttonMode = true;
         tCatapult.htmlText = "<b>" + KEYS.Get("newmap_catapultrange") + "</b>";
         tMonsters.htmlText = "<b>" + KEYS.Get("newmap_monstersrange") + "</b>";
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
         if(this._cell._alliance)
         {
            this.AlliancePic(AllyInfo._picURLs.sizeM,this.mcAlliancePic.mcImage,this.mcAlliancePic.mcBG,true);
         }
         else
         {
            this.mcAlliancePic.visible = false;
         }
         this.Update();
      }
      
      public function Cleanup() : void
      {
         this.bAttack.removeEventListener(MouseEvent.CLICK,this.Attack);
         this.bCancel.removeEventListener(MouseEvent.CLICK,this.Hide);
      }
      
      private function Attack(param1:MouseEvent) : *
      {
         var _loc2_:int = 0;
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
               BASE.LoadBase(null,null,this._cell._baseID,"wmattack",false,BASE.MAIN_YARD);
            }
            else
            {
               _loc2_ = this._cell._base == 3 ? BASE.OUTPOST : BASE.MAIN_YARD;
               BASE.LoadBase(null,null,this._cell._baseID,"attack",false,_loc2_);
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
         var _loc2_:CellData = null;
         var _loc4_:MapRoomCell = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         var _loc9_:CATAPULTITEM = null;
         var _loc10_:SiegeWeapon = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:String = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:String = null;
         var _loc18_:MapRoomPopupInfoMonster = null;
         var _loc19_:MapRoomPopupInfoMonster = null;
         var _loc1_:Number = 0;
         if(POWERUPS.CheckPowers(POWERUPS.ALLIANCE_DECLAREWAR,"NORMAL"))
         {
            _loc1_ = POWERUPS.Apply(POWERUPS.ALLIANCE_DECLAREWAR,[0]);
         }
         if(MapRoom._open)
         {
            this._cellsInRange = MapRoom._mc.GetCellsInRange(this._cell.X,this._cell.Y,10 + _loc1_);
            for each(_loc2_ in this._cellsInRange)
            {
               _loc4_ = _loc2_.cell;
               if((Boolean(_loc4_)) && !_loc4_._processed)
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
            for each(_loc2_ in this._cellsInRange)
            {
               _loc4_ = _loc2_["cell"];
               _loc11_ = int(_loc2_["range"]);
               if(Boolean(_loc4_) && Boolean(_loc4_._mine))
               {
                  _loc12_ = 0;
                  if(_loc4_._flingerRange.Get() + _loc1_ >= _loc11_)
                  {
                     for(_loc13_ in _loc4_._monsters)
                     {
                        _loc14_ = int(_loc4_._monsters[_loc13_].Get());
                        this._monstersInRange = true;
                        _loc12_++;
                        if(_loc14_ > 0 && Boolean(_loc4_._protected))
                        {
                           this._protectedInRange = true;
                        }
                        if(this._attackMonsters[_loc13_])
                        {
                           this._attackMonsters[_loc13_].Add(_loc14_);
                        }
                        else
                        {
                           this._attackMonsters[_loc13_] = new SecNum(_loc14_);
                        }
                     }
                     MapRoom._flingerInRange = true;
                  }
                  if(_loc4_._flingerRange.Get() >= this._attackResources.flinger.Get())
                  {
                     this._attackResources.flinger.Set(_loc4_._flingerLevel.Get());
                  }
               }
            }
            if(MapRoom._flingerInRange)
            {
               if(GLOBAL._playerCatapultLevel)
               {
                  this._attackResources.catapult.Set(GLOBAL._playerCatapultLevel.Get());
               }
               if(Boolean(GLOBAL._playerGuardianData) && GLOBAL._playerGuardianData.hp.Get() > 0)
               {
                  this._monstersInRange = true;
               }
            }
            while(mMonsters.numChildren)
            {
               mMonsters.removeChildAt(0);
            }
            if(this._monstersInRange)
            {
               _loc15_ = 0;
               _loc16_ = 0;
               if(Boolean(GLOBAL._playerGuardianData) && GLOBAL._playerGuardianData.hp.Get() > 0)
               {
                  _loc18_ = new MapRoomPopupInfoMonster();
                  _loc18_.Setup(0,0,"G" + GLOBAL._playerGuardianData.t + "_L" + GLOBAL._playerGuardianData.l.Get(),1);
                  mMonsters.addChild(_loc18_);
                  _loc15_ += 1;
               }
               for(_loc17_ in this._attackMonsters)
               {
                  _loc19_ = new MapRoomPopupInfoMonster();
                  _loc19_.Setup(_loc15_ * 125,_loc16_ * 30,_loc17_,this._attackMonsters[_loc17_].Get());
                  _loc15_ += 1;
                  mMonsters.addChild(_loc19_);
                  if(_loc15_ == 3)
                  {
                     _loc15_ = 0;
                     _loc16_ += 1;
                  }
               }
               this.addChild(mMonsters);
            }
            _loc6_ = -1;
            _loc7_ = -1;
            _loc8_ = -1;
            if(Boolean(this._mcResources) && Boolean(this._mcResources.parent))
            {
               this._mcResources.parent.removeChild(this._mcResources);
               this._mcResources = null;
            }
            this._mcResources = new MovieClip();
            this._mcResources.x = -175;
            this._mcResources.y = -75;
            if(this._attackResources.catapult.Get() >= 1)
            {
               _loc5_ = 0;
               while(_loc5_ < 3)
               {
                  if(this._attackResources.r1 < ResourceBombs._bombs["tw" + _loc5_].cost)
                  {
                     break;
                  }
                  _loc6_ = _loc5_;
                  _loc5_++;
               }
            }
            if(this._attackResources.catapult.Get() >= 2)
            {
               _loc5_ = 0;
               while(_loc5_ < 4)
               {
                  if(this._attackResources.r2 < ResourceBombs._bombs["pb" + _loc5_].cost)
                  {
                     break;
                  }
                  _loc7_ = _loc5_;
                  _loc5_++;
               }
            }
            if(this._attackResources.catapult.Get() >= 3)
            {
               _loc5_ = 0;
               while(_loc5_ < 4)
               {
                  if(this._attackResources.r3 < ResourceBombs._bombs["pu" + _loc5_].cost)
                  {
                     break;
                  }
                  _loc8_ = _loc5_;
                  _loc5_++;
               }
            }
            _loc9_ = new CATAPULTITEM();
            if(_loc6_ >= 0)
            {
               _loc9_.Setup("tw" + _loc6_,true,true);
            }
            else
            {
               _loc9_.Setup("tw0",true,false);
            }
            _loc9_.x = 0;
            _loc9_.y = 0;
            this._mcResources.addChild(_loc9_);
            _loc9_ = new CATAPULTITEM();
            if(_loc7_ >= 0)
            {
               _loc9_.Setup("pb" + _loc7_,true,true);
            }
            else
            {
               _loc9_.Setup("pb0",true,false);
            }
            _loc9_.x = 65;
            _loc9_.y = 0;
            this._mcResources.addChild(_loc9_);
            _loc9_ = new CATAPULTITEM();
            if(_loc8_ >= 0)
            {
               _loc9_.Setup("pu" + _loc8_,true,true);
            }
            else
            {
               _loc9_.Setup("pu0",true,false);
            }
            _loc9_.x = 130;
            _loc9_.y = 0;
            this._mcResources.addChild(_loc9_);
            _loc10_ = SiegeWeapons.availableWeapon;
            if((Boolean(_loc10_)) && MapRoom._flingerInRange)
            {
               _loc9_ = new CATAPULTITEM();
               _loc9_._props = _loc10_;
               _loc9_._bombid = _loc10_.weaponID;
               _loc9_._txtMC._tA.htmlText = "<b>" + _loc10_.name + "</b>";
               _loc9_._image = new MovieClip();
               _loc9_.addChild(_loc9_._image);
               _loc9_._popup = new bubblepopup3();
               _loc9_._popup.x = 44;
               _loc9_._popup.y = 29;
               _loc9_.addChild(_loc9_._popup);
               _loc9_._popX = _loc9_._popup.x;
               _loc9_._popY = _loc9_._popup.y;
               _loc9_.Enabled = true;
               _loc9_.Hide();
               _loc9_.setChildIndex(_loc9_._image,1);
               _loc9_.setChildIndex(_loc9_._txtMC,2);
               _loc9_.setChildIndex(_loc9_._popup,3);
               ImageCache.GetImageWithCallBack(_loc10_.image,this.onSiegeIconComplete,true,1,"",[_loc9_._image]);
               _loc9_.mouseEnabled = false;
               _loc9_.x = 195;
               _loc9_.y = 0;
               this._mcResources.addChild(_loc9_);
            }
            this.addChild(this._mcResources);
            this.bAttack.Enabled = true;
            this._enabled = true;
         }
         var _loc3_:String = "";
         _loc3_ = "X:" + this._cell.X + " Y:" + this._cell.Y + "<br>_base:" + this._cell._base + "<br>_height:" + this._cell._height + "<br>_water:" + this._cell._water + "<br>_mine:" + this._cell._mine + "<br>_flinger:" + this._cell._flingerRange + "<br>_catapult:" + this._cell._catapult + "<br>_userID:" + this._cell._userID + "<br>_truce:" + this._cell._truce + "<br>_name:" + this._cell._name + "<br>_protected:" + this._cell._protected + "<br>_resources:" + JSON.encode(this._cell._resources) + "<br>_ticks:" + JSON.encode(this._cell._ticks) + "<br>_monsters:" + JSON.encode(this._cell._monsters);
         if(this._cell._monsterData)
         {
            _loc3_ += "<br>_monsterData:" + JSON.encode(this._cell._monsterData);
            _loc3_ += "<br>_monsterData.saved:" + JSON.encode(this._cell._monsterData.saved);
            _loc3_ += "<br>_monsterData.h:" + JSON.encode(this._cell._monsterData.h);
            _loc3_ += "<br>_monsterData.hcount:" + this._cell._monsterData.hcount;
         }
         if(this._scroller)
         {
            this._scroller.Update();
         }
         return this._enabled;
      }
      
      private function onSiegeIconComplete(param1:String, param2:BitmapData, param3:Array = null) : void
      {
         var _loc4_:MovieClip = null;
         if(param3[0])
         {
            _loc4_ = param3[0];
            while(_loc4_.numChildren > 0)
            {
               _loc4_.removeChildAt(0);
            }
         }
         var _loc5_:* = new Bitmap(param2);
         _loc5_.height = 60;
         _loc5_.width = 60;
         if(_loc4_)
         {
            _loc4_.addChild(_loc5_);
         }
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
         if(!this._cell._facebookID && this._cell._base != 1 && !this._cell._pic_square)
         {
            return;
         }
         if(this._cell._base > 1)
         {
            this._profilePic = new Loader();
            this._profilePic.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,LoadImageError,false,0,true);
            this._profilePic.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoad);
            if(Boolean(GLOBAL._flags.viximo) && Boolean(this._cell._pic_square))
            {
               this._profilePic.load(new URLRequest(this._cell._pic_square));
            }
            else
            {
               this._profilePic.load(new URLRequest("http://graph.facebook.com/" + this._cell._facebookID + "/picture"));
            }
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
            return;
         }
         if(this._cell._base > 1 && Boolean(this._cell._alliance))
         {
            k = int(this.mcAlliancePic.mcImage.numChildren);
            while(k--)
            {
               this.mcAlliancePic.mcImage.removeChildAt(k);
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
   }
}

