package
{
   import Shared.AS3.Events.CustomEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol96")]
   public dynamic class PaladinUnlocks extends DODailyUnlocksEntry
   {
       
      
      public function PaladinUnlocks()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4,45,this.frame46);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         stop();
      }
      
      internal function frame4() : *
      {
         gotoAndStop(45);
         LockIcon_mc.gotoAndPlay("unlock");
         stage.dispatchEvent(new CustomEvent("DailyOps::ShowDailyUnlockReward",{"index":1}));
      }
      
      internal function frame46() : *
      {
         stop();
      }
   }
}
