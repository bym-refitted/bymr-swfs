package com.monsters.replayableEvents
{
   import com.monsters.debug.Console;
   import com.monsters.frontPage.FrontPageGraphic;
   import com.monsters.frontPage.messages.Message;
   import com.monsters.ui.UI_BOTTOM;
   import flash.events.Event;
   
   public class ReplayableEventHandler
   {
      public static var debugDate:Date;
      
      public static var doesDebugClear:Boolean;
      
      public static var activeEvent:ReplayableEvent;
      
      private static var _graphic:ReplayableEventUI;
      
      private static const _DURATION_UNTIL_EVENT_STARTS:Number = 7 * 24 * 60 * 60;
      
      private static const _DURATION_UNTIL_EVENT_RESET:Number = 60 * 24 * 60 * 60;
      
      private static const _DURATION_BETWEEN_EVENTS:Number = 14 * 24 * 60 * 60;
      
      internal static const DURATION_REQUIRED_TO_CONFIRM_EVENT:Number = 3 * 24 * 60 * 60;
      
      public function ReplayableEventHandler()
      {
         super();
      }
      
      public static function get currentTime() : Number
      {
         if(Boolean(debugDate) && GLOBAL._aiDesignMode)
         {
            return debugDate.time / 1000;
         }
         return GLOBAL.Timestamp();
      }
      
      public static function initialize(param1:Object = null) : void
      {
         var _loc2_:ReplayableEvent = null;
         var _loc3_:Number = NaN;
         if(GLOBAL._mode != "build" || BASE.isInferno())
         {
            return;
         }
         if(param1)
         {
            importData(param1);
         }
         if(activeEvent)
         {
            assureAccurateStartDate();
            activeEvent.initialize();
            checkIfActiveEventIsFinished();
         }
         else if(canScheduleNewEvent())
         {
            _loc2_ = getQualifiedEvent();
            if(_loc2_)
            {
               _loc3_ = getPotentialStartDateForEvent(_loc2_);
               if(_loc3_)
               {
                  scheduleNewEvent(_loc2_,_loc3_);
                  activeEvent.initialize();
               }
            }
         }
         addUI();
      }
      
      private static function assureAccurateStartDate() : void
      {
         var _loc1_:Number = activeEvent.originalStartDate;
         if(Boolean(_loc1_) && activeEvent.startDate != _loc1_)
         {
            activeEvent.setStartDate(_loc1_);
         }
      }
      
      private static function checkIfActiveEventIsFinished() : void
      {
         var _loc1_:Message = null;
         if(activeEvent.hasEventEnded || activeEvent.hasCompletedEvent)
         {
            LOGGER.StatB({
               "st1":"ERS",
               "st2":activeEvent.name
            },"event_end");
            _loc1_ = activeEvent.getCurrentMessage();
            if(Boolean(_loc1_) && !_loc1_.hasBeenSeen)
            {
               POPUPS.Push(new FrontPageGraphic(_loc1_));
               _loc1_.viewed();
            }
            if(_graphic)
            {
               removeUI();
            }
            activeEvent = null;
         }
      }
      
      public static function scheduleNewEvent(param1:ReplayableEvent, param2:Number) : void
      {
         param1.setStartDate(param2);
         callServerMethod("startevent",[["eventid",param1.id],["starttime",param1.startDate],["endtime",param1.endDate]]);
         LOGGER.StatB({
            "st1":"ERS",
            "st2":param1.name
         },"event_start");
         activeEvent = param1;
      }
      
      public static function callServerMethod(param1:String, param2:Array, param3:Function = null) : void
      {
         var _loc4_:URLLoaderApi = new URLLoaderApi();
         _loc4_.load(GLOBAL._apiURL + "bm/event/" + param1,param2,param3);
      }
      
      private static function addUI() : void
      {
         if(!activeEvent)
         {
            return;
         }
         _graphic = new ReplayableEventUI();
         _graphic.Setup(activeEvent);
         _graphic.addEventListener(Event.ENTER_FRAME,update,false,0,true);
         _graphic.addEventListener(ReplayableEventUI.CLICKED_ACTION,pressedActionButton,false,0,true);
         _graphic.addEventListener(ReplayableEventUI.CLICKED_INFO,pressedInfoButton,false,0,true);
         UI_BOTTOM.addChild(_graphic);
      }
      
      private static function removeUI() : void
      {
         if(!_graphic)
         {
            return;
         }
         _graphic.removeEventListener(Event.ENTER_FRAME,update);
         _graphic.removeEventListener(ReplayableEventUI.CLICKED_ACTION,pressedActionButton);
         _graphic.removeEventListener(ReplayableEventUI.CLICKED_INFO,pressedInfoButton);
         UI_BOTTOM.removeChild(_graphic);
      }
      
      private static function update(param1:Event) : void
      {
         _graphic.Update();
         if(activeEvent)
         {
            activeEvent.update();
         }
         checkIfActiveEventIsFinished();
      }
      
      private static function pressedActionButton(param1:Event) : void
      {
         activeEvent.pressedActionButton();
      }
      
      private static function pressedInfoButton(param1:Event) : void
      {
         var _loc3_:FrontPageGraphic = null;
         var _loc2_:Message = activeEvent.pressedHelpButton();
         if(_loc2_)
         {
            _loc3_ = new FrontPageGraphic(_loc2_);
            POPUPS.Push(_loc3_);
         }
      }
      
      public static function getPotentialStartDateForEvent(param1:ReplayableEvent) : Number
      {
         var _loc5_:Date = null;
         var _loc6_:Number = NaN;
         if(Boolean(param1.originalStartDate) && param1.originalStartDate - currentTime <= _DURATION_UNTIL_EVENT_STARTS)
         {
            return param1.originalStartDate;
         }
         var _loc3_:Number = currentTime;
         var _loc4_:int = 0;
         while(_loc4_ < 7)
         {
            _loc3_ += 24 * 60 * 60;
            _loc5_ = new Date(_loc3_ * 1000);
            if(_loc5_.day == 4)
            {
               _loc3_ = _loc5_.setHours(12,0,0,0) / 1000;
               _loc6_ = _loc3_ - currentTime;
               if(!hasQualifiedLiveEventSoonAfter(_loc3_) && _loc6_ < _DURATION_UNTIL_EVENT_STARTS && _loc6_ > DURATION_REQUIRED_TO_CONFIRM_EVENT)
               {
                  return _loc3_;
               }
            }
            _loc4_++;
         }
         return null;
      }
      
      private static function canScheduleNewEvent() : Boolean
      {
         return !activeEvent && !hasRecentlyParticipatedInAnEvent() || Boolean(getQualifiedLiveEvent());
      }
      
      private static function getQualifiedLiveEvent() : ReplayableEvent
      {
         var _loc2_:ReplayableEvent = null;
         var _loc1_:int = 0;
         while(_loc1_ < ReplayableEventLibrary.EVENTS.length)
         {
            _loc2_ = ReplayableEventLibrary.EVENTS[_loc1_];
            if(Boolean(_loc2_.originalStartDate) && _loc2_.originalStartDate - currentTime <= _DURATION_UNTIL_EVENT_STARTS)
            {
               return _loc2_;
            }
            _loc1_++;
         }
         return null;
      }
      
      private static function hasQualifiedLiveEventSoonAfter(param1:Number) : Boolean
      {
         var _loc3_:ReplayableEvent = null;
         var _loc2_:int = 0;
         while(_loc2_ < ReplayableEventLibrary.EVENTS.length)
         {
            _loc3_ = ReplayableEventLibrary.EVENTS[_loc2_];
            if(Boolean(_loc3_.originalStartDate) && _loc3_.originalStartDate - param1 <= _DURATION_BETWEEN_EVENTS)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private static function hasRecentlyParticipatedInAnEvent() : Boolean
      {
         var _loc2_:ReplayableEvent = null;
         var _loc1_:int = 0;
         while(_loc1_ < ReplayableEventLibrary.EVENTS.length)
         {
            _loc2_ = ReplayableEventLibrary.EVENTS[_loc1_];
            if(Boolean(_loc2_.endDate) && currentTime - _loc2_.endDate <= 7 * 24 * 60 * 60)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public static function getQualifiedEvent() : ReplayableEvent
      {
         var _loc3_:ReplayableEvent = null;
         var _loc4_:ReplayableEvent = null;
         var _loc1_:Vector.<ReplayableEvent> = new Vector.<ReplayableEvent>();
         var _loc2_:int = 0;
         while(_loc2_ < ReplayableEventLibrary.EVENTS.length)
         {
            _loc4_ = ReplayableEventLibrary.EVENTS[_loc2_];
            if(_loc4_.doesQualify() && !_loc4_.startDate)
            {
               _loc1_.push(_loc4_);
            }
            _loc2_++;
         }
         _loc1_.sort(comparePriority);
         if(_loc1_.length >= 1)
         {
            _loc3_ = _loc1_[0];
         }
         return _loc3_;
      }
      
      private static function comparePriority(param1:ReplayableEvent, param2:ReplayableEvent) : Number
      {
         return param1.priority - param2.priority;
      }
      
      public static function exportData() : Object
      {
         var _loc2_:Boolean = false;
         var _loc4_:ReplayableEvent = null;
         var _loc5_:Object = null;
         if(doesDebugClear)
         {
            doesDebugClear = false;
            return {};
         }
         if(GLOBAL._mode != "build" || BASE.isInferno())
         {
            return null;
         }
         var _loc1_:Object = {};
         var _loc3_:int = 0;
         while(_loc3_ < ReplayableEventLibrary.EVENTS.length)
         {
            _loc4_ = ReplayableEventLibrary.EVENTS[_loc3_];
            _loc5_ = _loc4_.exportData();
            if(_loc5_)
            {
               _loc1_[_loc4_.name] = _loc5_;
               _loc2_ = true;
            }
            _loc3_++;
         }
         if(debugDate)
         {
            _loc1_.debugDate = debugDate.time;
            _loc2_ = true;
         }
         if(activeEvent)
         {
            _loc1_.activeEvent = activeEvent.id;
            _loc2_ = true;
         }
         return _loc2_ ? _loc1_ : null;
      }
      
      public static function importData(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:ReplayableEvent = null;
         for(_loc2_ in param1)
         {
            _loc3_ = ReplayableEventLibrary.getEventByName(_loc2_);
            if(_loc3_)
            {
               _loc3_.importData(param1[_loc2_]);
            }
         }
         if(param1.debugDate)
         {
            debugDate = new Date(param1.debugDate);
         }
         if(param1.activeEvent)
         {
            activeEvent = ReplayableEventLibrary.getEventByID(param1.activeEvent);
         }
      }
      
      public static function optInForEventEmails() : void
      {
         if(!activeEvent)
         {
            Console.warning("You\'re trying to opt-in for an event that isnt currently running, something is fucked");
            return;
         }
         callServerMethod("emailoptin",[["eventid",activeEvent.id]]);
      }
   }
}

