package DailyOpsHUD_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol73")]
   public dynamic class DailyUnlocksLockIcon_24 extends MovieClip
   {
       
      
      public function DailyUnlocksLockIcon_24()
      {
         super();
         addFrameScript(0,this.frame1,11,this.frame12,59,this.frame60);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame12() : *
      {
         stage.dispatchEvent(new Event("DailyOps::PlayDailyUnlockUnlockedSound"));
      }
      
      internal function frame60() : *
      {
         stop();
      }
   }
}
