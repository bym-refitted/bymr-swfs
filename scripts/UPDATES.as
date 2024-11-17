package
{
   import com.adobe.serialization.json.JSON;
   import com.cc.utils.SecNum;
   import flash.display.MovieClip;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class UPDATES
   {
      public static var _updates:Array;
      
      public static var _myUpdates:Array;
      
      public static var _lastUpdateID:int;
      
      public static var _catchupList:Array;
      
      public function UPDATES()
      {
         super();
      }
      
      public static function Setup() : *
      {
         _updates = [];
         _myUpdates = [];
         _catchupList = [];
         _lastUpdateID = 0;
      }
      
      public static function Process(param1:Array) : *
      {
         var _loc2_:Object = null;
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         if(!GLOBAL._save)
         {
            return;
         }
         if(param1)
         {
            for each(_loc2_ in param1)
            {
               if(_loc2_.data)
               {
                  if(_loc2_.id > _lastUpdateID)
                  {
                     _lastUpdateID = _loc2_.id;
                  }
                  _loc3_ = com.adobe.serialization.json.JSON.decode(_loc2_.data);
                  for each(_loc4_ in _loc3_)
                  {
                     _updates.push({
                        "fbid":_loc2_.fbid,
                        "name":_loc2_.name,
                        "data":_loc4_
                     });
                  }
               }
            }
         }
      }
      
      public static function Check() : *
      {
         var _loc3_:Object = null;
         if(!GLOBAL._save)
         {
            return;
         }
         var _loc1_:int = GLOBAL.Timestamp();
         var _loc2_:int = 0;
         while(_loc2_ < _updates.length)
         {
            _loc3_ = _updates[_loc2_].data;
            if(_loc3_[0] <= _loc1_)
            {
               Action(_updates[_loc2_]);
               _updates.splice(_loc2_,1);
               _loc2_--;
            }
            _loc2_++;
         }
         if(_catchupList.length > 0 && !GLOBAL._catchup)
         {
            Catchup();
         }
      }
      
      public static function Action(param1:Object) : *
      {
         var _loc2_:BFOUNDATION = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         if(!GLOBAL._save)
         {
            return;
         }
         if(param1.data[1] == "BU")
         {
            _loc2_ = GetBuilding(param1.data[2]);
            if(_loc2_)
            {
               _loc2_.UpgradeB();
            }
         }
         if(param1.data[1] == "BUC")
         {
            _loc2_ = GetBuilding(param1.data[2]);
            if(_loc2_)
            {
               _loc2_.UpgradeCancelC();
            }
         }
         if(param1.data[1] == "BMU")
         {
            _loc5_ = int(param1.data.length);
            if(HOUSING._creatures)
            {
               _loc6_ = 2;
               while(_loc6_ < _loc5_)
               {
                  _loc7_ = param1.data[_loc6_];
                  if(Boolean(HOUSING._creatures[_loc7_.creatureID]) && HOUSING._creatures[_loc7_.creatureID].Get() > 0)
                  {
                     HOUSING._creatures[_loc7_.creatureID].Add(-_loc7_.count);
                     if(HOUSING._creatures[_loc7_.creatureID].Get() <= 0)
                     {
                        HOUSING._creatures[_loc7_.creatureID].Set(0);
                     }
                  }
                  else if(_loc7_.count < 0)
                  {
                     HOUSING._creatures[_loc7_.creatureID] = new SecNum(-_loc7_.count);
                  }
                  _loc6_++;
               }
            }
         }
         if(param1.data[1] == "BH")
         {
            _loc2_ = GetBuilding(param1.data[2]);
            if(_loc2_)
            {
               _loc2_._helpList.push(param1.data[3]);
            }
            if(_loc2_)
            {
               _loc4_ = _loc2_.HelpB();
            }
            if(_loc4_ > 0 && GLOBAL._mode == "build")
            {
               _catchupList.push(["build",param1.fbid,param1.name,GLOBAL._buildingProps[_loc2_._type - 1].name,_loc4_]);
            }
         }
         if(param1.data[1] == "BP")
         {
            if(GLOBAL._mode != "build")
            {
               _loc2_ = BASE.addBuildingC(param1.data[2]);
               _loc2_.Setup(param1.data[3]);
            }
         }
         if(param1.data[1] == "DBU")
         {
            BASE._damagedBaseWarnTime = param1.data[0];
         }
         if(param1.data[1] == "BT")
         {
            _loc2_ = GetBuilding(param1.data[2]);
            if(_loc2_)
            {
               _loc2_._threadid = param1.data[3];
            }
            if(_loc2_)
            {
               _loc2_._subject = param1.data[4];
            }
            if(_loc2_)
            {
               _loc2_._senderid = param1.data[5];
            }
            if(_loc2_)
            {
               _loc2_._senderName = param1.data[6];
            }
            if(_loc2_)
            {
               _loc2_._senderPic = param1.data[7];
            }
         }
         if(param1.data[1] == "BE")
         {
            BASE._resources.r1.Add(-param1.data[3]);
            BASE._hpResources.r1 -= param1.data[3];
            BASE._resources.r2.Add(-param1.data[4]);
            BASE._hpResources.r2 -= param1.data[4];
            BASE._resources.r3.Add(-param1.data[5]);
            BASE._hpResources.r3 -= param1.data[5];
            BASE._resources.r4.Add(-param1.data[6]);
            BASE._hpResources.r4 -= param1.data[6];
            BASE._credits.Add(-param1.data[7]);
            BASE._hpCredits -= param1.data[7];
         }
      }
      
      public static function Catchup() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:* = null;
         if(!GLOBAL._save)
         {
            return;
         }
         if(_catchupList.length > 0)
         {
            _loc3_ = [];
            _loc4_ = [];
            _loc8_ = new popup_helped();
            _loc8_.tB.autoSize = TextFieldAutoSize.LEFT;
            _loc7_ = 0;
            _loc1_ = 0;
            while(_loc1_ < _catchupList.length)
            {
               _loc6_ = false;
               _loc2_ = 0;
               while(_loc2_ < _loc3_.length)
               {
                  if(_loc3_[_loc2_][1] == _catchupList[_loc1_][2])
                  {
                     _loc6_ = true;
                  }
                  _loc2_++;
               }
               if(!_loc6_)
               {
                  _loc3_.push([_catchupList[_loc1_][1],_catchupList[_loc1_][2]]);
               }
               _loc6_ = false;
               _loc2_ = 0;
               while(_loc2_ < _loc4_.length)
               {
                  if(_loc4_[_loc2_][1] == _catchupList[_loc1_][3])
                  {
                     _loc6_ = true;
                  }
                  _loc2_++;
               }
               if(!_loc6_)
               {
                  _loc4_.push([0,_catchupList[_loc1_][3]]);
               }
               _loc7_ += _catchupList[_loc1_][4];
               _loc1_++;
            }
            _loc9_ = KEYS.Get("pop_helped_1a");
            if(!GLOBAL._catchup)
            {
               if(_loc3_.length == 1)
               {
                  _loc9_ = " " + KEYS.Get("pop_helped_1b") + " ";
               }
               if(_loc3_.length > 1)
               {
                  _loc9_ = " " + KEYS.Get("pop_helped_1c") + " ";
               }
            }
            if(_loc3_.length == 1)
            {
               _loc8_.tA.htmlText = "<font size=\"14\"><b>" + KEYS.Get("pop_helped_title",{"v1":_loc3_[0][1]}) + "</b></font>";
               if(_loc4_.length > 1)
               {
                  _loc5_ = _loc3_[0][1] + _loc9_ + KEYS.Get("pop_helped_2a",{"v1":GLOBAL.Array2StringB(_loc4_)});
               }
               else
               {
                  _loc5_ = _loc3_[0][1] + _loc9_ + KEYS.Get("pop_helped_2b",{"v1":GLOBAL.Array2StringB(_loc4_)});
               }
               _loc5_ += ", <b>" + KEYS.Get("pop_helped_3a",{"v1":GLOBAL.ToTime(_loc7_,false,false)}) + "</b>";
               _loc8_.tB.htmlText = _loc5_;
               _loc8_.bPost.Setup(KEYS.Get("pop_helped_saythanks_btn",{"v1":_loc3_[0][1]}));
               _loc8_.bPost.addEventListener(MouseEvent.CLICK,GiveThanks(_loc3_[0][0],KEYS.Get("pop_helped_streamtitle"),"","quests/build.png"));
               _loc8_.bPost.Highlight = true;
            }
            else
            {
               _loc8_.tA.htmlText = "<font size=\"14\"><b>" + KEYS.Get("pop_helped_title_pl") + "</b></font>";
               _loc8_.tB.htmlText = KEYS.Get("pop_helped_pl_1a",{
                  "v1":GLOBAL.Array2StringB(_loc3_),
                  "v2":_loc9_,
                  "v3":GLOBAL.Array2StringB(_loc4_),
                  "v4":GLOBAL.ToTime(_loc7_,false,false)
               });
               _loc8_.bPost.SetupKey("pop_saythanks_btn");
               _loc8_.bPost.addEventListener(MouseEvent.CLICK,GiveThanks(0,KEYS.Get("pop_helped_streamtitle"),KEYS.Get("pop_helped_pl_streambody",{"v1":GLOBAL.Array2StringB(_loc3_)}),"quests/build.png"));
               _loc8_.bPost.Highlight = true;
            }
            _loc8_.bPost.y = _loc8_.tB.height - 15;
            _loc8_.mcFrame.height = _loc8_.bPost.y + 110;
            (_loc8_.mcFrame as frame2).Setup();
            POPUPS.Push(_loc8_,null,null,"","build.png");
            _catchupList = [];
         }
      }
      
      public static function GiveThanks(param1:Number, param2:String, param3:String, param4:String) : *
      {
         var fbid:Number = param1;
         var messageA:String = param2;
         var messageB:String = param3;
         var image:String = param4;
         return function(param1:MouseEvent):*
         {
            GLOBAL.CallJS("sendFeed",["thanks",messageA,messageB,image,fbid]);
            POPUPS.Next();
         };
      }
      
      public static function Create(param1:Array, param2:int = 0) : void
      {
         var _loc3_:int = BASE._loadedBaseID;
         if(param2)
         {
            _loc3_ = param2;
         }
         CreateB(param1,_loc3_,_lastUpdateID);
      }
      
      public static function CreateB(param1:Array, param2:int, param3:int) : void
      {
         var url:String;
         var loadVars:Array;
         var handleLoadSuccessful:Function = null;
         var handleLoadError:Function = null;
         var update:Array = param1;
         var id:int = param2;
         var lastupdate:int = param3;
         handleLoadSuccessful = function(param1:Object):*
         {
            if(param1.error == 0)
            {
               Process(param1.updates);
            }
            else
            {
               LOGGER.Log("err","UPDATES.Create: " + com.adobe.serialization.json.JSON.encode(param1));
               GLOBAL.ErrorMessage("UPDATES.Create");
            }
         };
         handleLoadError = function(param1:IOErrorEvent):void
         {
            LOGGER.Log("err","UPDATES.Create HTTP");
         };
         if(!GLOBAL._save)
         {
            return;
         }
         if(!GLOBAL._openBase && TUTORIAL._stage < 200)
         {
            return;
         }
         if(GLOBAL._mode == "build" && GLOBAL._friendCount == 0)
         {
            return;
         }
         update.splice(0,0,GLOBAL.Timestamp());
         url = GLOBAL._baseURL;
         if(GLOBAL._baseURL2)
         {
            url = GLOBAL._baseURL2;
         }
         loadVars = [["baseid",id],["data",com.adobe.serialization.json.JSON.encode([update])],["lastupdate",lastupdate]];
         new URLLoaderApi().load(url + "saveupdate",loadVars,handleLoadSuccessful,handleLoadError);
      }
      
      public static function GetBuilding(param1:int) : BFOUNDATION
      {
         var _loc2_:BFOUNDATION = null;
         for each(_loc2_ in BASE._buildingsAll)
         {
            if(_loc2_._id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

