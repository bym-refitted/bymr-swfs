package com.monsters.replayableEvents.monsterInvasion
{
   import com.monsters.replayableEvents.ReplayableEvent;
   import com.monsters.replayableEvents.attackDefend.AttackDefend;
   import flash.events.Event;
   
   public class MonsterInvasion extends ReplayableEvent
   {
      protected static const TYPE_CREEP:int = 0;
      
      protected static const TYPE_GUARDIAN:int = 1;
      
      protected var _currentAttackers:Array = new Array();
      
      protected var _retreatAllMonsters:Boolean = false;
      
      protected var _randDir:int = 0;
      
      protected var _wavesTotal:uint;
      
      protected var _wavesDestroyed:uint = 0;
      
      protected var _waitTimer:int = 0;
      
      protected var _internalWaveIndex:int = 0;
      
      protected var _curSend:Array = [];
      
      protected var _isActive:Boolean = false;
      
      protected var _numAttempts:int;
      
      private var _saveTimer:int;
      
      public function MonsterInvasion(param1:uint = 0)
      {
         super();
         this._wavesTotal = param1;
      }
      
      override public function set score(param1:Number) : void
      {
         super.score = param1;
         this._wavesDestroyed = param1;
         progress = this._wavesDestroyed / this._wavesTotal;
      }
      
      protected function set wavesDestroyed(param1:uint) : void
      {
         this._wavesDestroyed = param1;
         progress = this._wavesDestroyed / this._wavesTotal;
      }
      
      protected function endWave() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:BFOUNDATION = null;
         WMATTACK.setEnd(WMATTACK.CleanUp);
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for(_loc4_ in BASE._buildingsAll)
         {
            _loc5_ = BASE._buildingsAll[_loc4_];
            if(!(_loc5_._class == "trap" && _loc5_._fired || _loc5_._type == 53 && _loc5_._expireTime < GLOBAL.Timestamp()))
            {
               if(_loc5_._class != "wall")
               {
                  _loc1_ += _loc5_._hp.Get();
                  _loc2_ += _loc5_._hpMax.Get();
               }
            }
         }
         _loc3_ = 100 - 100 / _loc2_ * _loc1_;
         if(_loc3_ < 90)
         {
            LOGGER.StatB({
               "st1":"ERS",
               "st2":_name,
               "st3":"Wave_Num_" + this._wavesDestroyed,
               "value":this._numAttempts
            },"Attack_Success");
            if(_score < 0)
            {
               _score = 0;
            }
            this.score = _score + 1;
            this._numAttempts = 0;
         }
         else
         {
            LOGGER.StatB({
               "st1":"ERS",
               "st2":_name,
               "st3":"Wave_Num_" + this._wavesDestroyed,
               "value":this._numAttempts
            },"Attack_Failed");
         }
         this.cleanupWave();
         WMATTACK.CleanUpLite();
      }
      
      override public function exportData() : Object
      {
         var _loc1_:Object = super.exportData();
         _loc1_["_wavesDestroyed"] = this._wavesDestroyed;
         _loc1_["_numAttempts"] = this._numAttempts;
         return _loc1_;
      }
      
      override public function importData(param1:Object) : void
      {
         super.importData(param1);
         this.wavesDestroyed = param1["_wavesDestroyed"];
         this._numAttempts = param1["_numAttempts"];
      }
      
      override public function update() : void
      {
         if(!this._isActive)
         {
            return;
         }
         ++this._saveTimer;
         if(!(this._saveTimer % 120))
         {
            BASE.Save(0,false,true);
         }
         if(this._waitTimer)
         {
            --this._waitTimer;
         }
         else
         {
            this.sendWave();
         }
      }
      
      protected function setupNextWave() : void
      {
         var _loc1_:Array = null;
         if(!WMATTACK._inProgress && progress < 1)
         {
            this._isActive = true;
            _loc1_ = this.getWaveArray();
            this._curSend = _loc1_[this._wavesDestroyed % _loc1_.length];
            this._internalWaveIndex = 0;
            this._randDir = Math.random() * 360;
            this._currentAttackers = [];
         }
      }
      
      protected function sendWave() : void
      {
         var _loc1_:Array = null;
         if(this._internalWaveIndex >= this._curSend.length)
         {
            return;
         }
         _loc1_ = [];
         this._internalWaveIndex;
         while(this._internalWaveIndex < this._curSend.length && !this._waitTimer)
         {
            if(!(this._curSend[this._internalWaveIndex] is Number))
            {
               _loc1_ = _loc1_.concat(WMATTACK.SpawnWave(this._curSend[this._internalWaveIndex],this._randDir));
            }
            else
            {
               this._waitTimer = this._curSend[this._internalWaveIndex] * 20;
            }
            ++this._internalWaveIndex;
         }
         this._currentAttackers = this._currentAttackers.concat(_loc1_);
         this.postSend();
      }
      
      private function postSend() : void
      {
         if(BASE.isInferno())
         {
            SOUNDS.PlayMusic("musicipanic");
         }
         else
         {
            SOUNDS.PlayMusic("musicpanic");
         }
         WMATTACK.AttackB();
         WMATTACK.AttackC();
         BASE._blockSave = false;
         UI2.Show("surrender");
         if(UI2._scareAway)
         {
            UI2._scareAway.addEventListener("scareAway",this.Surrender);
         }
         WMATTACK.setEnd(this.endWave);
         WMATTACK._isAI = false;
         WMATTACK._inProgress = true;
      }
      
      private function cleanupWave() : void
      {
         this._isActive = false;
         this._curSend = [];
         this._internalWaveIndex = 0;
         this._currentAttackers = [];
      }
      
      public function Surrender(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Number = 0;
         WMATTACK.setEnd(WMATTACK.CleanUp);
         this._retreatAllMonsters = true;
         for each(_loc2_ in this._currentAttackers)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc2_[_loc3_].ModeRetreat();
               _loc3_++;
            }
         }
         this.cleanupWave();
         WMATTACK.CleanUpLite();
         LOGGER.StatB({
            "st1":"ERS",
            "st2":_name,
            "st3":"Wave_Num_" + this._wavesDestroyed,
            "value":this._numAttempts
         },"Attack_Surrender");
      }
      
      protected function StartRepairs() : void
      {
         var _loc1_:BFOUNDATION = null;
         for each(_loc1_ in BASE._buildingsAll)
         {
            if(_loc1_._hp.Get() < _loc1_._hpMax.Get() && _loc1_._repairing == 0)
            {
               _loc1_.Repair();
            }
         }
      }
      
      override protected function onInitialize() : void
      {
         super.onInitialize();
         if(this is AttackDefend === false)
         {
            this.score = this._wavesDestroyed;
         }
         WMATTACK.enabled = false;
         this._isActive = false;
         if(GLOBAL._mode == "build" && BASE._yardType == BASE.MAIN_YARD)
         {
            _buttonCopy = KEYS.Get("btn_next");
         }
         else
         {
            _buttonCopy = null;
         }
      }
      
      protected function getWaveArray() : Array
      {
         return null;
      }
      
      override public function pressedActionButton() : void
      {
         this.setupNextWave();
         ++this._numAttempts;
         LOGGER.StatB({
            "st1":"ERS",
            "st2":_name,
            "st3":"Wave_Num_" + this._wavesDestroyed,
            "value":this._numAttempts
         },"Attack_Start");
      }
      
      override protected function onEventComplete() : void
      {
      }
      
      override public function reset() : void
      {
         super.reset();
         this._numAttempts = 0;
         this._wavesDestroyed = 0;
      }
   }
}

