package com.monsters.mailbox
{
   import com.monsters.display.ScrollSet;
   import com.monsters.mailbox.model.Contact;
   import com.monsters.maproom_advanced.MapRoom;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import gs.TweenLite;
   import package_1.class_1;
   
   public class FriendPicker extends FriendPicker_CLIP
   {
      public var pool:Array;
      
      private var currentPage:uint = 0;
      
      public var loader:Loader;
      
      public var currentSelection:FriendPickerItem;
      
      public var isOpen:Boolean = false;
      
      private var shell:Sprite;
      
      public var scroller:ScrollSet;
      
      public function FriendPicker(param1:String = "all")
      {
         super();
         this.scroller = new ScrollSet();
         this.scroller.x = 292;
         this.scroller.y = 63;
         addChild(this.scroller);
         if(param1 == "map2friends")
         {
            hitBtn.addEventListener(MouseEvent.CLICK,this.openMap2Friends);
         }
         else
         {
            hitBtn.addEventListener(MouseEvent.CLICK,this.open);
         }
         this.shell = new Sprite();
         this.shell.mask = mask_mc;
         this.shell.x = mask_mc.x;
         this.shell.y = mask_mc.y;
         this.scroller.visible = false;
         bg_mc.visible = false;
         name_txt.text = "";
         photoRing.visible = false;
         arrowBtn.gotoAndStop(2);
         placeholder.visible = false;
      }
      
      private function open(... rest) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Number = 0;
         var _loc5_:FriendPickerItem = null;
         if(this.isOpen)
         {
            this.close();
            return;
         }
         this.scroller.visible = true;
         arrowBtn.gotoAndStop(1);
         if(!this.pool)
         {
            _loc2_ = Contact.contacts;
            _loc3_ = int(_loc2_.length);
            this.pool = [];
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = new FriendPickerItem(_loc2_[_loc4_]);
               _loc5_.addEventListener(MouseEvent.MOUSE_OVER,this.onItemOver);
               _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.onItemOut);
               _loc5_.addEventListener(MouseEvent.MOUSE_DOWN,this.onItemDown);
               _loc5_.shouldLoadImage();
               _loc5_.mouseChildren = false;
               _loc5_.useHandCursor = true;
               _loc5_.buttonMode = true;
               this.pool.push(_loc5_);
               _loc4_++;
            }
            this.pool = this.pool.sortOn("name_str",Array.CASEINSENSITIVE);
            _loc4_ = 0;
            while(_loc4_ < this.pool.length)
            {
               _loc5_ = this.pool[_loc4_];
               this.shell.addChild(_loc5_);
               _loc5_.x = 0;
               _loc5_.y = _loc4_ * 60;
               _loc4_++;
            }
            this.scroller.initWith(this.shell,mask_mc,mask_mc.y,mask_mc.height - 4,60);
            this.scroller.hardObjectHeight = 60 * this.pool.length;
            this.scroller.easing = 2;
         }
         if(this.currentSelection)
         {
            this.shell.addChild(this.currentSelection);
         }
         bg_mc.visible = true;
         addChild(this.shell);
         this.isOpen = true;
         this.scroller.scrollTo(0);
         this.scroller.Show();
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
      }
      
      private function openMap2Friends(... rest) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Number = 0;
         var _loc5_:FriendPickerItem = null;
         if(this.isOpen)
         {
            this.close();
            return;
         }
         this.scroller.visible = true;
         arrowBtn.gotoAndStop(1);
         if(!this.pool)
         {
            _loc2_ = MapRoom._contacts;
            _loc3_ = int(_loc2_.length);
            this.pool = [];
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = new FriendPickerItem(_loc2_[_loc4_]);
               _loc5_.addEventListener(MouseEvent.MOUSE_OVER,this.onItemOver);
               _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.onItemOut);
               _loc5_.addEventListener(MouseEvent.MOUSE_DOWN,this.onItemDown);
               _loc5_.shouldLoadImage();
               _loc5_.mouseChildren = false;
               _loc5_.useHandCursor = true;
               _loc5_.buttonMode = true;
               this.pool.push(_loc5_);
               _loc4_++;
            }
            this.pool = this.pool.sortOn("name_str",Array.CASEINSENSITIVE);
            _loc4_ = 0;
            while(_loc4_ < this.pool.length)
            {
               _loc5_ = this.pool[_loc4_];
               this.shell.addChild(_loc5_);
               _loc5_.x = 0;
               _loc5_.y = _loc4_ * 60;
               _loc4_++;
            }
            this.scroller.initWith(this.shell,mask_mc,mask_mc.y,mask_mc.height - 4,60);
            this.scroller.hardObjectHeight = 60 * this.pool.length;
            this.scroller.easing = 2;
         }
         if(this.currentSelection)
         {
            this.shell.addChild(this.currentSelection);
         }
         bg_mc.visible = true;
         addChild(this.shell);
         this.isOpen = true;
         this.scroller.scrollTo(0);
         this.scroller.Show();
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
      }
      
      private function onKey(param1:KeyboardEvent) : void
      {
         var _loc7_:Number = NaN;
         var _loc2_:String = class_1.method_1(80,-166);
         var _loc3_:Array = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90];
         var _loc4_:Object = {};
         var _loc5_:Number = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_[_loc3_[_loc5_]] = _loc2_.charAt(_loc5_);
            _loc5_++;
         }
         var _loc6_:String = _loc4_[param1.keyCode];
         _loc5_ = 0;
         while(_loc5_ < this.pool.length)
         {
            if(this.pool[_loc5_].name_str.toLowerCase().charAt(0) == _loc6_)
            {
               _loc7_ = this.pool[_loc5_].y / (this.shell.height - mask_mc.height);
               if(_loc7_ > 1)
               {
                  _loc7_ = 1;
               }
               if(_loc7_ < 0)
               {
                  _loc7_ = 0;
               }
               this.scroller.scrollTo(_loc7_);
               return;
            }
            _loc5_++;
         }
      }
      
      public function preloadSelection(param1:Contact) : void
      {
         var _loc2_:FriendPickerItem = new FriendPickerItem(param1);
         this.setData(_loc2_);
         removeChild(hitBtn);
         removeChild(arrowBtn);
         removeChild(arrowLine);
      }
      
      public function getCurrentData() : Contact
      {
         return this.currentSelection.data;
      }
      
      public function onItemOver(param1:MouseEvent) : void
      {
      }
      
      public function onItemOut(param1:MouseEvent) : void
      {
      }
      
      public function onItemDown(param1:MouseEvent) : void
      {
         this.setData(param1.target as FriendPickerItem);
      }
      
      public function setData(param1:FriendPickerItem) : void
      {
         var last_str:String;
         var onErr:Function = null;
         var onImgComplete:Function = null;
         var item:FriendPickerItem = param1;
         onErr = function(param1:IOErrorEvent):void
         {
         };
         onImgComplete = function(param1:Event):void
         {
            photoRing.visible = true;
            loader.height = 50;
            loader.width = 50;
            setChildIndex(photoRing,this.numChildren - 1);
         };
         this.currentSelection = item;
         this.close();
         last_str = this.currentSelection.data.lastname.length > 2 ? " " + this.currentSelection.data.lastname.charAt(0).toUpperCase() + "." : "";
         name_txt.htmlText = "<b>" + this.currentSelection.data.firstname.toUpperCase() + last_str;
         if(this.loader)
         {
            removeChild(this.loader);
            this.loader = null;
         }
         this.loader = new Loader();
         this.loader.x = this.loader.y = 5;
         addChild(this.loader);
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImgComplete);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onErr);
         try
         {
            if(this.currentSelection.data.pic.length > 5)
            {
               this.loader.load(new URLRequest(this.currentSelection.data.pic));
            }
         }
         catch(e:*)
         {
         }
         placeholder.visible = true;
      }
      
      public function gotoPage(param1:uint) : void
      {
         var _loc2_:uint = param1 * 15 + 15 > this.pool.length ? this.pool.length : uint(param1 * 15 + 15);
         var _loc3_:Number = mask_mc.x - 630 * param1;
         TweenLite.to(this.shell,0.5,{"x":_loc3_});
         this.currentPage = param1;
      }
      
      public function close() : void
      {
         if(!this.isOpen)
         {
            return;
         }
         this.isOpen = false;
         arrowBtn.gotoAndStop(2);
         this.scroller.visible = false;
         removeChild(this.shell);
         bg_mc.visible = false;
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKey);
      }
   }
}

