package DailyOpsHUD_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol62")]
   public dynamic class MissionRankingGraphic_mc_37 extends MovieClip
   {
       
      
      public var CompletionTime_mc:MovieClip;
      
      public var DOLogo_mc:MovieClip;
      
      public var ModeInfo_mc:MovieClip;
      
      public var RankEntryLeft_mc:DORankEntry;
      
      public var RankEntryMid_mc:DORankEntry;
      
      public var RankEntryRight_mc:DORankEntry;
      
      public function MissionRankingGraphic_mc_37()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         gotoAndStop("on");
         stage.dispatchEvent(new Event("DailyOps::ActivateRanks"));
      }
   }
}
