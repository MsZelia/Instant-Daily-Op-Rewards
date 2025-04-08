package DailyOpsHUD_fla
{
   import Shared.AS3.Events.CustomEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol116")]
   public dynamic class DailyUnlocks_mc_20 extends MovieClip
   {
       
      
      public var ElderUnlocks_mc:ElderUnlocks;
      
      public var InitiateUnlocks_mc:InitiateUnlocks;
      
      public var PaladinUnlocks_mc:PaladinUnlocks;
      
      public var Title_tf:TextField;
      
      public function DailyUnlocks_mc_20()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4,4,this.frame5,61,this.frame62);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stage.dispatchEvent(new Event("DailyOps::PlayDailyUnlockFadeSound"));
         stage.dispatchEvent(new CustomEvent("DailyOps::UnlockDailyUnlock",{"index":0}));
      }
      
      internal function frame3() : *
      {
         stage.dispatchEvent(new Event("DailyOps::PlayDailyUnlockFadeSound"));
         stage.dispatchEvent(new CustomEvent("DailyOps::UnlockDailyUnlock",{"index":1}));
      }
      
      internal function frame4() : *
      {
         stage.dispatchEvent(new Event("DailyOps::PlayDailyUnlockFadeSound"));
         stage.dispatchEvent(new CustomEvent("DailyOps::UnlockDailyUnlock",{"index":2}));
      }
      
      internal function frame5() : *
      {
         stage.dispatchEvent(new Event("DailyOps::FinalDailyUnlockShown"));
         gotoAndStop(61);
      }
      
      internal function frame62() : *
      {
         stop();
      }
   }
}
