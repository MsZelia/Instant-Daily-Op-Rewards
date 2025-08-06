package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class DODailyUnlocksEntry extends MovieClip
   {
      
      public var BackgroundAnim_mc:MovieClip;
      
      public var LockIcon_mc:MovieClip;
      
      public var EarnedText_tf:TextField;
      
      public var RewardsText_tf:TextField;
      
      public var RewardsText2_tf:TextField;
      
      public var RewardsText3_tf:TextField;
      
      public var RankText_tf:TextField;
      
      public function DODailyUnlocksEntry()
      {
         super();
      }
      
      public function populateUnlockData(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            gotoAndStop("achieved");
         }
         else if(param2)
         {
            gotoAndStop("unlock");
         }
         else
         {
            gotoAndStop("locked");
         }
         TextFieldEx.setTextAutoSize(this.EarnedText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.RewardsText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.RewardsText2_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.RankText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         if(this.RewardsText3_tf)
         {
            TextFieldEx.setTextAutoSize(this.RewardsText3_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         }
      }
      
      public function playUnlockAnimationIfValid() : void
      {
         if(currentLabel == "unlock")
         {
            gotoAndPlay("unlock");
         }
      }
   }
}

