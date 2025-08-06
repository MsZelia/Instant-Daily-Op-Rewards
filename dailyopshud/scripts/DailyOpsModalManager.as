package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.IMenu;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol130")]
   public class DailyOpsModalManager extends IMenu
   {
      
      public static const EVENT_EXIT:String = "DailyOps::Exit";
      
      private static const RANKING_MODAL:uint = 0;
      
      private static const REWARDS_MODAL:uint = 1;
      
      private static const TALLY_MODAL:uint = 2;
      
      public var MissionRanking_mc:DOMissionRankingModal;
      
      public var MissionRewards_mc:DOMissionRewardsModal;
      
      public var MissionTally_mc:MovieClip;
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      private var m_AcceptBtn:BSButtonHintData;
      
      private var m_ExitBtn:BSButtonHintData;
      
      private var m_Modal:uint = 0;
      
      public function DailyOpsModalManager()
      {
         this.m_AcceptBtn = new BSButtonHintData("$VIEW_REWARDS","ENTER","PSN_A","Xenon_A",1,this.onAccept);
         this.m_ExitBtn = new BSButtonHintData("$EXIT","ESC","PSN_Start","Xenon_Start",1,this.onExit);
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3);
         this.ButtonHintBar_mc.SetButtonHintData(new <BSButtonHintData>[this.m_AcceptBtn,this.m_ExitBtn]);
         BSUIDataManager.Subscribe("DailyOpsModalData",this.onDailyOpsDataUpdate);
      }
      
      override public function onAddedToStage() : void
      {
         this.show();
      }
      
      public function show() : void
      {
         this.gotoAndStop("MissionRanking");
         this.MissionRanking_mc.show();
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {
         var _loc3_:Boolean = false;
         if(!_loc3_ && !param2 && this.visible)
         {
            switch(param1)
            {
               case "Accept":
               case "Activate":
                  if(this.m_AcceptBtn.ButtonVisible)
                  {
                     _loc3_ = true;
                     this.onAccept();
                  }
                  break;
               case "Start":
               case "ForceClose":
                  _loc3_ = true;
                  this.onExit();
            }
         }
         return _loc3_;
      }
      
      private function onDailyOpsDataUpdate(param1:FromClientDataEvent) : void
      {
         if(param1.data.rankDataA != null)
         {
            this.MissionRanking_mc.populateRankData(param1.data.rankDataA,param1.data.completionTime);
            this.MissionRanking_mc.populateDOData(param1.data.location,param1.data.gameMode,param1.data.enemy,param1.data.mutator);
            this.MissionRewards_mc.setRewardsData(param1.data.rankDataA,param1.data.rewardData,param1.data.mutationMode);
            this.MissionRewards_mc.setTooltip(param1.data.mutationMode);
         }
      }
      
      private function onAccept() : void
      {
         GlobalFunc.PlayMenuSound("UIMenuOK");
         switch(this.m_Modal)
         {
            case RANKING_MODAL:
               this.MissionRanking_mc.hide();
               this.gotoAndStop("MissionRewards");
               this.MissionRewards_mc.show();
               this.m_AcceptBtn.ButtonVisible = false;
         }
      }
      
      private function onExit() : void
      {
         GlobalFunc.PlayMenuSound("UIMenuCancel");
         switch(this.m_Modal)
         {
            case RANKING_MODAL:
               this.MissionRanking_mc.gotoAndPlay("rollOff");
               break;
            case REWARDS_MODAL:
               this.MissionRewards_mc.gotoAndPlay("rollOff");
         }
         this.visible = false;
         BSUIDataManager.dispatchEvent(new Event(EVENT_EXIT));
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
   }
}

