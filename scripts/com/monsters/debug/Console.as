package com.monsters.debug
{
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Console
   {
      public static var view:ConsoleView;
      
      private static var _commands:Dictionary;
      
      public static const PRINT:String = "print";
      
      public static const WARNING:String = "warning";
      
      public static const ERROR:String = "error";
      
      public static const keyCodes:Vector.<uint> = Vector.<uint>([223,192]);
      
      public function Console()
      {
         super();
      }
      
      public static function initialize(param1:Stage) : void
      {
         if(!GLOBAL._aiDesignMode)
         {
            return;
         }
         view = new ConsoleView();
         _commands = new Dictionary();
         param1.addChild(view);
         param1.tabChildren = false;
         view.deactivate();
         param1.addEventListener(KeyboardEvent.KEY_UP,onKeyDown);
         ConsoleCommands.initialize();
      }
      
      protected static function onKeyDown(param1:KeyboardEvent) : void
      {
         if(isKey(param1.keyCode) && Boolean(view))
         {
            view.toggleActive();
            param1.stopImmediatePropagation();
         }
      }
      
      public static function warning(param1:String = "", param2:Boolean = false) : void
      {
         print("WARNING: " + param1,param2,WARNING);
      }
      
      public static function print(param1:*, param2:Boolean = false, param3:String = "print") : void
      {
         if(!GLOBAL._aiDesignMode)
         {
            return;
         }
         if(!(param1 is String))
         {
            param1 = Object(param1).toString();
         }
         if(!GLOBAL._aiDesignMode)
         {
            return;
         }
         var _loc4_:int = getTimer() / 1000;
         if(param2 && !ExternalInterface.available)
         {
            param1 = getSource() + "|| " + param1;
         }
         view.addLogMessage(param3,"",param1);
      }
      
      public static function processLine(param1:String) : String
      {
         var _loc6_:Number = NaN;
         var _loc3_:int = param1.indexOf(" ") + 1;
         var _loc4_:String = param1.substring(0,!!_loc3_ ? _loc3_ - 1 : param1.length).toLowerCase();
         var _loc5_:Function = _commands[_loc4_];
         if(_loc5_ != null)
         {
            arguments = [];
            _loc6_ = Number(param1.indexOf(",",_loc3_));
            arguments.push(param1.substring(_loc3_,_loc6_ != -1 ? _loc6_ : param1.length));
            _loc3_ = _loc6_;
            while(_loc6_ != -1)
            {
               arguments.push(param1.substring(_loc3_,_loc6_));
               _loc6_ = Number(param1.indexOf(",",_loc6_));
            }
            return _loc5_.apply(null,arguments);
         }
         view.addLogMessage(WARNING,"","INVALID COMMAND");
         return null;
      }
      
      public static function registerCommand(param1:String, param2:Function) : void
      {
         _commands[param1.toLowerCase()] = param2;
      }
      
      public static function getSource(param1:uint = 4) : String
      {
         var lineNumber:String;
         var stackTrace:String = null;
         var depth:uint = param1;
         if(ExternalInterface.available)
         {
            return "";
         }
         try
         {
            throw new Error();
         }
         catch(e:Error)
         {
            stackTrace = e.getStackTrace();
         }
         stackTrace = stackTrace.split("at ")[depth];
         lineNumber = stackTrace.substring(stackTrace.lastIndexOf(":"),stackTrace.indexOf("]"));
         stackTrace = stackTrace.substring(0,stackTrace.indexOf("()") + 2);
         stackTrace = stackTrace.replace("Function","");
         stackTrace = stackTrace.replace("$","");
         while(stackTrace.search("/") != -1)
         {
            stackTrace = stackTrace.replace("/",".");
         }
         return stackTrace + lineNumber;
      }
      
      public static function isKey(param1:uint) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < keyCodes.length)
         {
            if(keyCodes[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public static function get commands() : Dictionary
      {
         return _commands;
      }
   }
}

