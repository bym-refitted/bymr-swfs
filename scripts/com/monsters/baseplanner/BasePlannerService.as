package com.monsters.baseplanner
{
   import com.monsters.baseplanner.events.BasePlannerServiceEvent;
   import flash.events.EventDispatcher;
   
   public class BasePlannerService extends EventDispatcher
   {
      public function BasePlannerService()
      {
         super();
      }
      
      public function callServerMethod(param1:String, param2:Array, param3:Function = null) : void
      {
         var _loc4_:URLLoaderApi = new URLLoaderApi();
         _loc4_.load(GLOBAL._apiURL + "bm/yardplanner/" + param1,param2,param3);
      }
      
      public function saveTemplate(param1:BaseTemplate, param2:uint) : *
      {
         var _loc3_:Object = JSON.encode(param1.exportData());
         this.callServerMethod("savetemplate",[["slotid",param2],["name",param1.name],["data",_loc3_]],this.savedTemplate);
         print("saving \'" + param1.name + "\' in slot " + param2);
      }
      
      private function savedTemplate(param1:Object) : void
      {
         if(param1.error)
         {
            print(param1.error);
            return;
         }
         this.loadedTemplates(param1);
      }
      
      public function loadTemplates() : void
      {
         this.callServerMethod("gettemplates",null,this.loadedTemplates);
         print("loading template list from the server");
      }
      
      private function loadedTemplates(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:BaseTemplate = null;
         var _loc5_:* = 0;
         var _loc2_:Vector.<BaseTemplate> = new Vector.<BaseTemplate>(BasePlanner.slots,true);
         for each(_loc3_ in param1)
         {
            if(!(_loc3_ is Number))
            {
               _loc4_ = new BaseTemplate();
               _loc5_ = uint(_loc3_.slotid);
               _loc4_.name = _loc3_.name;
               _loc4_.slot = _loc5_;
               _loc4_.importData(JSON.decode(_loc3_.data));
               _loc2_[_loc5_] = _loc4_;
            }
         }
         print("new template list is " + _loc2_);
         dispatchEvent(new BasePlannerServiceEvent(BasePlannerServiceEvent.LOADED_TEMPLATES_LIST,_loc2_));
      }
      
      public function clearSlot(param1:uint) : void
      {
         this.callServerMethod("deletetemplate",[["slotid",param1]]);
         print("deleting \'blah\' at slot index of " + param1);
      }
   }
}

