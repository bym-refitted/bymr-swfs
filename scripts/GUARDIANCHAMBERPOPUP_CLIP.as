package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1351")]
   public dynamic class GUARDIANCHAMBERPOPUP_CLIP extends MovieClip
   {
      public var buff_txt:TextField;
      
      public var bSpeed:MovieClip;
      
      public var bFreeze2:Button_CLIP;
      
      public var bFreeze3:Button_CLIP;
      
      public var selectedImage:MovieClip;
      
      public var bBuff:MovieClip;
      
      public var bFreeze1:Button_CLIP;
      
      public var bDamage:MovieClip;
      
      public var health_txt:TextField;
      
      public var slot1:MovieClip;
      
      public var tTitle:TextField;
      
      public var slot2:MovieClip;
      
      public var tSpeed:TextField;
      
      public var slot3:MovieClip;
      
      public var tHealth:TextField;
      
      public var frame:frame_CLIP;
      
      public var tEvoDesc:TextField;
      
      public var tEvoStage:TextField;
      
      public var tBuff:TextField;
      
      public var tDamage:TextField;
      
      public var damage_txt:TextField;
      
      public var speed_txt:TextField;
      
      public var bHealth:MovieClip;
      
      public function GUARDIANCHAMBERPOPUP_CLIP()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

