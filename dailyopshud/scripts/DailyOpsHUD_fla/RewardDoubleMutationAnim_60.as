package DailyOpsHUD_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol9")]
   public dynamic class RewardDoubleMutationAnim_60 extends MovieClip
   {
       
      
      public var RewardMultiplierBacker_mc:MovieClip;
      
      public var RewardMultiplier_mc:MovieClip;
      
      public function RewardDoubleMutationAnim_60()
      {
         super();
         addFrameScript(0,this.frame1,23,this.frame24,35,this.frame36);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame24() : *
      {
         dispatchEvent(new Event("DailyOps::ShowDoubleMutationReward"));
      }
      
      internal function frame36() : *
      {
         stop();
      }
   }
}
