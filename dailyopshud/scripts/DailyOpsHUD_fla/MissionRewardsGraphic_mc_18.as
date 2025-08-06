package DailyOpsHUD_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol122")]
   public dynamic class MissionRewardsGraphic_mc_18 extends MovieClip
   {
      
      public var DOLogo_mc:MovieClip;
      
      public var DailyUnlocks_mc:MovieClip;
      
      public var Rewards_mc:MovieClip;
      
      public var Tooltip_mc:MovieClip;
      
      public var UniqueRewards_mc:MovieClip;
      
      public function MissionRewardsGraphic_mc_18()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         gotoAndStop(40);
         stage.dispatchEvent(new Event("DailyOps::ShowNextReward"));
      }
   }
}

