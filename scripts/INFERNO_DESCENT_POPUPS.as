package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class INFERNO_DESCENT_POPUPS
   {
      private static const _MOLOCH_PORTRAIT_GLOAT:String = "portrait_muloch_gloat.png";
      
      private static const _MOLOCH_PORTRAIT_WHIMPER:String = "portrait_muloch_whimper.png";
      
      private static const _MOLOCH_PORTRAIT_NUETRAL:String = "portrait_moloch.png";
      
      private static const _PORTRAIT_IMAGE_OFFSET:Point = new Point(-75,50);
      
      public function INFERNO_DESCENT_POPUPS()
      {
         super();
      }
      
      public static function ShowTauntDialog(param1:uint) : void
      {
         var _loc2_:popup_dialogue = POPUPS.DisplayDialogue("",KEYS.Get("ai_moloch_taunt" + param1),KEYS.Get("taunt_player_response" + param1),_MOLOCH_PORTRAIT_NUETRAL,_PORTRAIT_IMAGE_OFFSET,POPUPS.Next) as popup_dialogue;
         FormatTextFieldForDialog(_loc2_.tBody);
      }
      
      public static function ShowPostAttackPopup(param1:uint, param2:Boolean) : void
      {
         var _loc3_:MovieClip = null;
         if(!param2)
         {
            _loc3_ = ShowWhimperDialog(param1);
         }
         else
         {
            _loc3_ = ShowGloatDialog(param1);
         }
         _loc3_.addEventListener(Event.REMOVED_FROM_STAGE,ClosedPostAttackPopup);
      }
      
      private static function ClosedPostAttackPopup(param1:Event) : void
      {
         MovieClip(param1.target).removeEventListener(Event.REMOVED_FROM_STAGE,ClosedPostAttackPopup);
         ShowBattleReport();
      }
      
      public static function ShowGloatDialog(param1:uint) : MovieClip
      {
         return ShowAttackEndDialog(_MOLOCH_PORTRAIT_GLOAT,KEYS.Get("ai_moloch_gloat" + param1),KEYS.Get("gloat_player_response" + param1));
      }
      
      public static function ShowWhimperDialog(param1:uint) : MovieClip
      {
         return ShowAttackEndDialog(_MOLOCH_PORTRAIT_WHIMPER,KEYS.Get("ai_moloch_whimper" + param1),KEYS.Get("whimper_player_response" + param1));
      }
      
      public static function ShowBattleReport(param1:Array = null) : void
      {
         param1 = [ATTACK._loot.r1.Get(),ATTACK._loot.r2.Get(),ATTACK._loot.r3.Get(),ATTACK._loot.r4.Get()];
         var _loc2_:String = KEYS.Get("descent_battlereport",{
            "v1":param1[0],
            "v2":param1[1],
            "v3":param1[2],
            "v4":param1[3]
         });
         var _loc3_:InfernoBattleReportPopup = new InfernoBattleReportPopup(KEYS.Get("pop_youlooted_title"),_loc2_,param1,"btn_brag");
         _loc3_.bButton.addEventListener(MouseEvent.CLICK,BragBattleReport,false,0,true);
         POPUPS.Push(_loc3_,null,null,null,"loot.png");
      }
      
      private static function BragBattleReport(param1:MouseEvent) : void
      {
         GLOBAL.CallJS("sendFeed",["loot",KEYS.Get("pop_cavernwin1_streamtitle"),KEYS.Get("pop_cavernwin2_streambody"),"loot.png"]);
         POPUPS.Next();
      }
      
      public static function ShowCapturePopup() : void
      {
         POPUPS.DisplayDialogue("descent_pop_victory_title",KEYS.Get("descent_pop_victory_body"),KEYS.Get("descent_pop_victory_button"),null,null,ClosedCapturePopup);
         GLOBAL.StatSet("descentLvl",14,true);
      }
      
      private static function ClosedCapturePopup() : void
      {
         BASE.LoadBase(GLOBAL._infBaseURL,0,0,"ibuild",false,BASE.INFERNO_YARD);
      }
      
      private static function ShowAttackEndDialog(param1:String, param2:String, param3:String) : MovieClip
      {
         var _loc4_:popup_dialogue = POPUPS.DisplayDialogue("",param2,param3,param1,_PORTRAIT_IMAGE_OFFSET,POPUPS.Next) as popup_dialogue;
         FormatTextFieldForDialog(_loc4_.tBody);
         return _loc4_;
      }
      
      private static function FormatTextFieldForDialog(param1:TextField) : TextField
      {
         param1.htmlText = "<i>" + param1.htmlText + "</i>";
         return param1;
      }
      
      public static function isInDescent() : Boolean
      {
         return BASE.isInferno() && GLOBAL._inInferno == 0;
      }
   }
}

import flash.display.MovieClip;

class InfernoBattleReportPopup extends popup_infernodescent_battle_report
{
   public function InfernoBattleReportPopup(param1:String, param2:String, param3:Array, param4:String)
   {
      var _loc6_:String = null;
      var _loc7_:MovieClip = null;
      super();
      tTitle.htmlText = param1;
      tBody.htmlText = param2;
      var _loc5_:int = 0;
      while(_loc5_ < param3.length)
      {
         _loc6_ = "mcResource" + (_loc5_ + 1);
         _loc7_ = MovieClip(getChildByName(_loc6_));
         _loc7_.tValue.htmlText = int(param3[_loc5_]).toString();
         _loc7_.stop();
         _loc5_++;
      }
      bButton.htmlText = param4;
      bButton.SetupKey(param4);
      bButton.Highlight = true;
   }
}
