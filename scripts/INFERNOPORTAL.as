package
{
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class INFERNOPORTAL extends BFOUNDATION
   {
      public static var building:INFERNOPORTAL;
      
      public static const ENTER_BUTTON:String = "btn_entercavern";
      
      public static const EXIT_BUTTON:String = "btn_exitcavern";
      
      public static var _descentPassed:Boolean = false;
      
      private var _popup:popup_horse;
      
      public function INFERNOPORTAL()
      {
         super();
         _type = 127;
         _footprint = [new Rectangle(0,0,190,160)];
         _gridCost = [[new Rectangle(0,0,190,160),200]];
         SetProps();
      }
      
      public static function GetMaxLevel() : Number
      {
         if(!building)
         {
            throw new Error("FUCK");
         }
         return building._buildingProps.costs.length;
      }
      
      public static function EnterPortal(param1:Boolean = false) : void
      {
         if(MAPROOM_DESCENT.DescentPassed)
         {
            ToggleYard();
         }
         else
         {
            EnterDescent();
         }
      }
      
      private static function EnterDescent() : void
      {
         MAPROOM_DESCENT.Setup(true);
      }
      
      public static function ToggleYard() : void
      {
         GLOBAL._advancedMap = 0;
         if(BASE.isInferno())
         {
            BASE.LoadBase(null,null,0,"build",false,BASE.MAIN_YARD);
         }
         else
         {
            BASE.LoadBase(GLOBAL._infBaseURL,0,0,"ibuild",false,BASE.INFERNO_YARD);
         }
      }
      
      public static function AddPortal(param1:uint = 0) : INFERNOPORTAL
      {
         var _loc2_:Point = BASE.isInferno() ? new Point(-750,-150) : new Point(-1200,-150);
         var _loc3_:Point = GRID.ToISO(_loc2_.x,_loc2_.y,0);
         var _loc4_:INFERNOPORTAL = BASE.addBuildingC(127) as INFERNOPORTAL;
         building = _loc4_;
         ++BASE._buildingCount;
         _loc4_.Setup({
            "X":_loc2_.x,
            "Y":_loc2_.y,
            "t":127,
            "id":BASE._buildingCount,
            "l":param1
         });
         _loc4_.SetLevel(param1);
         return _loc4_;
      }
      
      public static function isAboveMaxLevel() : Boolean
      {
         return building._lvl.Get() >= GetMaxLevel();
      }
      
      override public function Click(param1:MouseEvent = null) : *
      {
         if(isAboveMaxLevel() && (BASE.isInferno() || GLOBAL._bTownhall._lvl.Get() >= INFERNO_EMERGENCE_EVENT.TOWN_HALL_LEVEL_REQUIREMENT))
         {
            super.Click(param1);
         }
         else if(GLOBAL._mode == "build" && !INFERNO_EMERGENCE_EVENT.isAttackActive)
         {
            INFERNO_EMERGENCE_POPUPS.ShowRSVP(building._lvl.Get());
         }
      }
      
      public function SetLevel(param1:uint) : void
      {
         param1 = Math.min(param1,_buildingProps.costs.length);
         var _loc2_:int = _lvl.Get();
         var _loc3_:uint = uint(_buildingProps.costs.length);
         if(param1 == _loc2_)
         {
            return;
         }
         var _loc4_:int = param1 - _loc2_;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            Upgraded();
            _loc5_++;
         }
         RenderClear();
         Update(true);
         Render();
      }
      
      public function Hide() : void
      {
         _mc.visible = false;
         _mcBase.visible = false;
      }
      
      public function Show() : void
      {
         _mc.visible = true;
         _mcBase.visible = true;
      }
      
      override public function Export() : *
      {
         return false;
      }
   }
}

