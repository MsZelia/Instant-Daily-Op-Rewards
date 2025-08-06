package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol56")]
   public class DORankEntry extends MovieClip
   {
      
      private static const INIT_ACTIVATE_WAIT_TIME:Number = 25;
      
      private static const NEXT_ACTIVATE_WAIT_TIME:Number = 25;
      
      private static const RANK_INITIATE:uint = 0;
      
      private static const RANK_PALADIN:uint = 1;
      
      private static const RANK_ELDER:uint = 2;
      
      public var RankAchievedText_mc:MovieClip;
      
      public var RankIcon_mc:MovieClip;
      
      public var RankTitle_mc:MovieClip;
      
      public var LockIcon_mc:MovieClip;
      
      public var TimeText_mc:MovieClip;
      
      public var TeamRecommended_mc:MovieClip;
      
      private var m_RankAchieved:Boolean = false;
      
      private var m_CurrentRankAchieved:Boolean = false;
      
      private var m_ActivationTimer:Timer;
      
      public function DORankEntry()
      {
         super();
         addFrameScript(0,this.frame1,31,this.frame32,150,this.frame151,151,this.frame152);
         this.m_ActivationTimer = new Timer(INIT_ACTIVATE_WAIT_TIME);
         this.m_ActivationTimer.stop();
         TextFieldEx.setTextAutoSize(this.RankAchievedText_mc.RankAchievedText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.TimeText_mc.TimeText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         gotoAndStop("off");
      }
      
      public function get rankAchieved() : Boolean
      {
         return this.m_RankAchieved;
      }
      
      public function populateRankData(param1:uint, param2:Boolean, param3:Boolean, param4:Number) : void
      {
         this.m_RankAchieved = param2;
         this.m_CurrentRankAchieved = param3;
         if(this.m_RankAchieved)
         {
            this.RankAchievedText_mc.RankAchievedText_tf.text = "$DO_EARNED";
            this.RankAchievedText_mc.RankAchievedText_tf.text = this.RankAchievedText_mc.RankAchievedText_tf.text.replace(" ","\n");
            this.LockIcon_mc.gotoAndStop("off");
            gotoAndStop("achieved");
         }
         this.RankIcon_mc.gotoAndStop(param1 + 1);
         this.RankTitle_mc.gotoAndStop(param1 + 1);
         var _loc5_:uint = param4 / 60;
         this.TimeText_mc.TimeText_tf.text = GlobalFunc.LocalizeFormattedString("$DO_RANKTIME",_loc5_.toString());
         this.TeamRecommended_mc.visible = param1 == RANK_ELDER && !this.m_CurrentRankAchieved && !this.m_RankAchieved;
         TextFieldEx.setTextAutoSize(this.RankTitle_mc.RankTitle_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.TeamRecommended_mc.TeamRecommended_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public function activate(param1:uint) : *
      {
         if(this.m_CurrentRankAchieved && !this.m_RankAchieved)
         {
            this.LockIcon_mc.gotoAndPlay("unlock");
            this.RankAchievedText_mc.RankAchievedText_tf.text = this.RankAchievedText_mc.RankAchievedText_tf.text.replace(" ","\n");
            this.m_ActivationTimer = new Timer(INIT_ACTIVATE_WAIT_TIME + NEXT_ACTIVATE_WAIT_TIME * param1);
            this.m_ActivationTimer.addEventListener(TimerEvent.TIMER,this.onTimer);
            this.m_ActivationTimer.start();
         }
      }
      
      public function cancelActivation() : *
      {
         this.m_ActivationTimer.stop();
         this.m_ActivationTimer.removeEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      private function onTimer() : void
      {
         this.cancelActivation();
         this.LockIcon_mc.gotoAndPlay("fadeOut");
         gotoAndPlay("activate");
         GlobalFunc.PlayMenuSound("UIDailyOpsRankAchieved");
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame32() : *
      {
         gotoAndPlay(149);
      }
      
      internal function frame151() : *
      {
         gotoAndPlay("on");
      }
      
      internal function frame152() : *
      {
         stop();
      }
   }
}

