package com.monsters.inferno
{
   import com.cc.utils.SecNum;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class InfernoPopupMonstersA extends PopupMonstersA_CLIP
   {
      private var _cell:InfernoMapCell;
      
      private var _transfer:Object;
      
      private var _mc:*;
      
      private var _mcMonsters:MovieClip;
      
      private var _tempMonsterID:String;
      
      private var _tickDelay:int;
      
      private var _transferMonsters:Object = {};
      
      private var _monstersLeft:Object = {};
      
      private var _transferBars:Array = [];
      
      public function InfernoPopupMonstersA()
      {
         super();
         x = 455;
         y = 250;
         this._mc = this;
         this.bCancel.Setup("Cancel");
         this.bCancel.addEventListener(MouseEvent.CLICK,this.Hide);
         this.bTransfer.Setup("Transfer");
         this.bTransfer.addEventListener(MouseEvent.CLICK,this.Transfer);
      }
      
      public function Setup(param1:InfernoMapCell, param2:Boolean = false) : *
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:MonsterTransferBar = null;
         var _loc9_:InfernoMapPopupInfoMonster = null;
         this._cell = param1;
         this._transfer = {};
         this._transferMonsters = {};
         this._monstersLeft = {};
         this._transferBars = [];
         tDesc.htmlText = KEYS.Get("popup_desc_monstertransfera");
         if(param2)
         {
            for(_loc3_ in InfernoMap._monsterTransfer)
            {
               this._transfer[_loc3_] = new SecNum(int(InfernoMap._monsterTransfer[_loc3_].Get()));
            }
         }
         if(this._cell._monsters)
         {
            _loc4_ = 0;
            _loc5_ = 0;
            _loc6_ = 0;
            for(_loc7_ in this._cell._monsters)
            {
               _loc8_ = new MonsterTransferBar();
               _loc9_ = new InfernoMapPopupInfoMonster();
               _loc9_.Setup(0,0,_loc7_,0);
               _loc8_.addChild(_loc9_);
               _loc8_.x = -140;
               _loc8_.y = _loc5_ * _loc8_.height - 100;
               _loc8_.b1a.Setup("-");
               _loc8_.b1a.addEventListener(MouseEvent.MOUSE_DOWN,this.Subtract(_loc6_));
               _loc8_.b1a.buttonMode = true;
               _loc8_.b1a.enabled = true;
               _loc8_.b1b.Setup("+");
               _loc8_.b1b.addEventListener(MouseEvent.MOUSE_DOWN,this.Add(_loc6_));
               _loc8_.b1b.buttonMode = true;
               _loc8_.b1b.enabled = true;
               _loc6_++;
               if(param2)
               {
                  if(this._monstersLeft[_loc7_])
                  {
                     this._monstersLeft[_loc7_].Set(int(this._cell._monsters[_loc7_].Get() - this._transfer[_loc7_].Get()));
                  }
                  else
                  {
                     this._monstersLeft[_loc7_] = new SecNum(int(this._cell._monsters[_loc7_].Get() - this._transfer[_loc7_].Get()));
                  }
                  _loc8_.r1.text = this._monstersLeft[_loc7_].Get();
                  this._transferMonsters[_loc7_] = new SecNum(int(this._transfer[_loc7_].Get()));
                  _loc8_.t1.text = this._transferMonsters[_loc7_].Get();
               }
               else
               {
                  _loc8_.r1.text = this._cell._monsters[_loc7_].Get();
                  _loc8_.t1.text = "0";
                  this._monstersLeft[_loc7_] = new SecNum(int(this._cell._monsters[_loc7_].Get()));
                  this._transferMonsters[_loc7_] = new SecNum(0);
               }
               if(_loc5_ < 7)
               {
                  this._transferBars.push({
                     "bar":_loc8_,
                     "monster":_loc7_
                  });
                  this._mc.addChild(_loc8_);
               }
               _loc5_ += 1;
            }
         }
         this.Update();
      }
      
      public function Hide(param1:MouseEvent = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(this._transferBars.length);
         if(_loc2_ > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(Boolean(this._transferBars[_loc3_]) && Boolean(this._transferBars[_loc3_].bar) && Boolean(this._transferBars[_loc3_].bar.parent))
               {
                  this._transferBars[_loc3_].bar.parent.removeChild(this._transferBars[_loc3_].bar);
               }
               _loc3_++;
            }
         }
         InfernoMap._mc.HideMonstersA();
         InfernoMap._mc.ShowInfoMine(this._cell);
         InfernoMap._monsterTransferInProgress = false;
         this._mc.removeEventListener(Event.ENTER_FRAME,this.AddTick);
         this._mc.removeEventListener(Event.ENTER_FRAME,this.SubtractTick);
         this._mc.removeEventListener(MouseEvent.MOUSE_UP,this.TickRemove);
      }
      
      public function Cleanup() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.AddTick);
         removeEventListener(Event.ENTER_FRAME,this.SubtractTick);
         removeEventListener(MouseEvent.MOUSE_UP,this.TickRemove);
         this.bCancel.removeEventListener(MouseEvent.CLICK,this.Hide);
         this.bTransfer.removeEventListener(MouseEvent.CLICK,this.Transfer);
      }
      
      private function Update() : *
      {
         var _loc2_:MonsterTransferBar = null;
         var _loc3_:String = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._transferBars.length)
         {
            _loc2_ = this._transferBars[_loc1_].bar;
            if(_loc2_ && _loc2_.r1 && Boolean(_loc2_.t1))
            {
               _loc3_ = this._transferBars[_loc1_].monster;
               _loc2_.r1.htmlText = "<b>" + GLOBAL.FormatNumber(this._monstersLeft[_loc3_].Get()) + "</b>";
               _loc2_.t1.htmlText = "<b>" + GLOBAL.FormatNumber(this._transferMonsters[_loc3_].Get()) + "</b>";
            }
            _loc1_++;
         }
      }
      
      private function Add(param1:int) : *
      {
         var i:int = param1;
         return function(param1:MouseEvent):*
         {
            if(_cell._monsters[_transferBars[i].monster].Get() > 0)
            {
               _tempMonsterID = _transferBars[i].monster;
               _tickDelay = 0;
               AddTick();
               _tickDelay = 10;
               _mc.addEventListener(Event.ENTER_FRAME,AddTick);
               _mc.addEventListener(MouseEvent.MOUSE_UP,TickRemove);
            }
         };
      }
      
      private function AddTick(param1:Event = null) : *
      {
         if(this._monstersLeft[this._tempMonsterID].Get() > 0 && this._cell._monsters[this._tempMonsterID].Get() - this._transferMonsters[this._tempMonsterID].Get() > 0 && this._tickDelay <= 0)
         {
            this._transferMonsters[this._tempMonsterID].Add(1);
            this._monstersLeft[this._tempMonsterID].Add(-1);
            this.Update();
         }
         --this._tickDelay;
      }
      
      private function Subtract(param1:int) : *
      {
         var i:int = param1;
         return function(param1:MouseEvent):*
         {
            if(Boolean(_transferMonsters) && _transferMonsters[_transferBars[i].monster].Get() >= 1)
            {
               _tempMonsterID = _transferBars[i].monster;
               _tickDelay = 0;
               SubtractTick();
               _tickDelay = 10;
               _mc.addEventListener(Event.ENTER_FRAME,SubtractTick);
               _mc.addEventListener(MouseEvent.MOUSE_UP,TickRemove);
            }
         };
      }
      
      private function SubtractTick(param1:Event = null) : *
      {
         if(this._transferMonsters[this._tempMonsterID].Get() >= 1 && this._tickDelay <= 0)
         {
            this._transferMonsters[this._tempMonsterID].Add(-1);
            this._monstersLeft[this._tempMonsterID].Add(1);
            this.Update();
         }
         --this._tickDelay;
      }
      
      private function TickRemove(param1:MouseEvent) : *
      {
         this._mc.removeEventListener(Event.ENTER_FRAME,this.AddTick);
         this._mc.removeEventListener(Event.ENTER_FRAME,this.SubtractTick);
         this._mc.removeEventListener(MouseEvent.MOUSE_UP,this.TickRemove);
      }
      
      private function Transfer(param1:MouseEvent) : *
      {
         var _loc3_:int = 0;
         InfernoMap.TransferMonstersA(this._cell,this._transferMonsters);
         var _loc2_:int = int(this._transferBars.length);
         if(_loc2_ > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(Boolean(this._transferBars[_loc3_]) && Boolean(this._transferBars[_loc3_].bar) && Boolean(this._transferBars[_loc3_].bar.parent))
               {
                  this._transferBars[_loc3_].bar.parent.removeChild(this._transferBars[_loc3_].bar);
               }
               _loc3_++;
            }
         }
         InfernoMap._mc.HideMonstersA();
         this._mc.removeEventListener(Event.ENTER_FRAME,this.AddTick);
         this._mc.removeEventListener(Event.ENTER_FRAME,this.SubtractTick);
         this._mc.removeEventListener(MouseEvent.MOUSE_UP,this.TickRemove);
      }
   }
}

