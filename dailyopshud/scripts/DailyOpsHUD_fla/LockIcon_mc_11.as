package DailyOpsHUD_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol55")]
   public dynamic class LockIcon_mc_11 extends MovieClip
   {
      
      public function LockIcon_mc_11()
      {
         super();
         addFrameScript(0,this.frame1,14,this.frame15,63,this.frame64,74,this.frame75);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame15() : *
      {
         stage.dispatchEvent(new Event("DailyOps::PlayUnlockSound"));
      }
      
      internal function frame64() : *
      {
         stop();
      }
      
      internal function frame75() : *
      {
         stop();
      }
   }
}

