
function PipeManager:OnInitMutant()
	AI.LogEvent("PipeManager:OnInitMutant");

	AI.BeginGoalPipe("mutant_go_back_to_idlepos");
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
		AI.PushGoal("run", 0, 0);
		AI.PushGoal("lookaround", 1, 45, 3, 2, 5, AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("locate", 0, "refpoint");
		AI.PushGoal("approach", 1, 0, AILASTOPRES_USE);
		AI.PushGoal("locate", 0, "probtarget");
		AI.PushGoal("lookat", 0, 0, 0, 1);
		AI.PushGoal("clear", 0, 0);
		AI.PushGoal("lookaround", 1, 45, 3, 2, 5, AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("signal", 1, 1, "IDLEPOS_REACHED", 0); -- not sure what this does, does it reset everything?
	AI.EndGoalPipe();

	AI.BeginGoalPipe("do_nothing"); -- don't force a stance because of fall and play
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
	AI.EndGoalPipe();

	 -- generic idle for standing around doing nothing
	AI.BeginGoalPipe("mutant_idle");
		AI.PushGoal("bodypos", 0, BODYPOS_RELAX);
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("mutant_alert");
		AI.PushGoal("bodypos", 0, BODYPOS_STAND);
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
		AI.PushGoal("run", 0, 1); -- not in a hurry as we're just curious in this goal op
		AI.PushGoal("lookaround", 0, 70, 3, 100, 100, AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("locate", 0, "refpoint");
		AI.PushGoal("+approach", 1, 7, 0, 15.0);
		AI.PushGoal("clear", 0, 0);
		AI.PushGoal("lookaround", 0, 70, 2, 100, 100, AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("locate", 0, "refpoint");
		AI.PushGoal("+approach", 1, 1, 0, 15.0);
		AI.PushGoal("signal", 1, 1, "ALERT_IDLE", 0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("mutant_alert_idle");
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
		AI.PushGoal("bodypos", 0, 3);
		AI.PushGoal("lookaround", 1, 45, 3, 2, 5, AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("signal", 1, 1, "ALERT_IDLE_LOOKAROUND", 0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("mutant_seek");
		AI.PushGoal("bodypos", 1, BODYPOS_STAND);
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
		AI.PushGoal("run", 0, 3);
		AI.PushGoal("lookaround", 0, 70, 3, 100, 100, AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("timeout", 1, 0.2, 1);
		AI.PushGoal("locate", 1, "refpoint");
		AI.PushGoal("+stick", 1, 1.0, AILASTOPRES_USE + AILASTOPRES_LOOKAT + AI_USE_TARGET_MOVEMENT, STICK_BREAK + STICK_SHORTCUTNAV);
		--AI.PushGoal("+approach", 1, 7, 0, 15.0);
		--AI.PushGoal("clear", 0, 0);
		--AI.PushGoal("lookaround", 0, 70, 2, 100, 100, AI_BREAK_ON_LIVE_TARGET);
		--AI.PushGoal("locate", 0, "refpoint");
		--AI.PushGoal("+approach", 1, 1, 0, 15.0);
		AI.PushGoal("signal", 0, 1, "SEEK_FINISHED", 0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("mutant_seek_close");
		AI.PushGoal("bodypos", 1, BODYPOS_STAND);
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
		AI.PushGoal("run", 0, 2);
		AI.PushGoal("locate", 0, "atttarget");
		AI.PushGoal("lookat", 0, 0, 0, 1);
		AI.PushGoal("stick", 1, 1.1, AILASTOPRES_USE, STICK_BREAK + STICK_SHORTCUTNAV, 0, 0);
		AI.PushLabel("STICK_LOOP");
			AI.PushGoal("branch", 1, "END", IF_TARGET_DIST_LESS, 1.5);
			AI.PushGoal("branch", 1, "END", IF_TARGET_MOVED_SINCE_START, 1.5);
		AI.PushGoal("branch", 1, "STICK_LOOP", IF_ACTIVE_GOALS);
		AI.PushLabel("END");
		AI.PushGoal("signal", 1, 1, "SEEK_FINISHED", 0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("mutant_seek_standby");
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
		AI.PushGoal("run", 0, 1);
		AI.PushGoal("strafe", 0, 2, 2);
		AI.PushGoal("locate", 0, "refpoint");
		AI.PushGoal("+approach", 1, 3, AILASTOPRES_USE, 10, "", 3);
		AI.PushGoal("lookaround", 1, 45, 3, 1, 2, AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("signal", 1, 1, "SEEK_FINISHED", 0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("mutant_seek_random");
		AI.PushGoal("bodypos", 1, BODYPOS_STAND);
		AI.PushGoal("run", 0, 0);
		AI.PushGoal("firecmd", 0, 0);
		AI.PushGoal("strafe", 0, 4, 10);
		AI.PushGoal("locate", 1, "probtarget"); --probtarget_in_territory
		AI.PushGoal("timeout",1,5,7);
		AI.PushGoal("clear",0,0);
		AI.PushGoal("lookaround",1,120,3,1,3,AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("signal",0,1,"SEEK_RANDOM",0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("mutant_threatened");
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
		AI.PushGoal("run", 0, 3);
		AI.PushGoal("lookaround", 0, 70, 3, 100, 100, AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("locate", 0, "refpoint");
		AI.PushGoal("+approach", 1, 7, 0, 15.0);
		AI.PushGoal("clear", 0, 0);
		AI.PushGoal("lookaround", 0, 70, 2, 100, 100, AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("locate", 0, "refpoint");
		AI.PushGoal("+approach", 1, 1, 0, 15.0);
		--AI.PushGoal("signal", 1, 1, "SEEK_NOTHING_FOUND", 0);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("mutant_approach");
		AI.PushGoal("locate", 0, "player");
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
		AI.PushGoal("run", 0, 3); -- sprint
		AI.PushGoal("stick", 1, 1.0, AILASTOPRES_USE + AILASTOPRES_LOOKAT + AI_USE_TARGET_MOVEMENT, STICK_BREAK, -1);
		AI.PushLabel("STICK_LOOP");
			AI.PushGoal("branch", 1, "END", IF_TARGET_MOVED_SINCE_START, 2.5);
		AI.PushGoal("branch", 1, "STICK_LOOP", IF_ACTIVE_GOALS);
		AI.PushLabel("END");
		AI.PushGoal("signal", 1, 1, "AnalyzeSituation", SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

	AI.BeginGoalPipe("attack_1");   
		AI.PushGoal("firecmd",0,FIREMODE_MELEE);   
		AI.PushGoal("locate",0,"atttarget",1000);
		AI.PushGoal("lookat", 0, 0, 0, 1);
		AI.PushGoal("acqtarget",1,"");
		AI.PushGoal("bodypos",0,BODYPOS_STAND);   
		AI.PushGoal("run",0,2);
		AI.PushGoal("stick",1,0, 0, STICK_BREAK);   
	AI.EndGoalPipe();

	AI.BeginGoalPipe("mutant_melee");
		AI.PushGoal("branch", 1, "MELEE", IF_TARGET_DIST_LESS, 1.5);
			AI.PushGoal("stick", 1, 1.5, AILASTOPRES_USE, STICK_BREAK + STICK_SHORTCUTNAV, 0, 0);
			AI.PushGoal("branch", 1, "END", BRANCH_ALWAYS);
		AI.PushLabel("MELEE");
		AI.PushGoal("locate", 0, "probtarget");
		AI.PushGoal("lookat", 0, -90, 90, 1, AI_LOOKAT_CONTINUOUS + AI_LOOKAT_USE_BODYDIR);
		AI.PushGoal("firecmd", 1, FIREMODE_MELEE_FORCED);
		AI.PushGoal("timeout", 1, 0.05);
		AI.PushGoal("firecmd", 1, FIREMODE_OFF);
		AI.PushLabel("END");
		AI.PushGoal("signal", 1, 1, "ANALYZE_SITUATION", 0);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("mutant_look_at_target");
		AI.PushGoal("locate", 1, "target");
		AI.PushGoal("lookat", 1, 0, 0, 1);
		AI.PushGoal("timeout", 1, .6, .9);
		AI.PushGoal("clear", 0, 0);
	AI.EndGoalPipe();

	---------------------------------------------
	AI.BeginGoalPipe("mutant_look_at_probtarget");
		AI.PushGoal("locate", 1, "probtarget");
		AI.PushGoal("lookat", 1, 0, 0, 1);
		AI.PushGoal("timeout", 1, .6, .9);
		AI.PushGoal("clear", 0, 0);
	AI.EndGoalPipe();
	
	---------------------------------------------
	AI.BeginGoalPipe("mutant_look_at_lastop");
		AI.PushGoal("lookat",0,0,0,1);
		AI.PushGoal("timeout",1,0.6,0.9);
		AI.PushGoal("clear",0,0);
		AI.PushGoal("lookaround",0,20,2,1,2,AI_BREAK_ON_LIVE_TARGET);
	AI.EndGoalPipe();

	--------------------------------------------- not currently used
	AI.BeginGoalPipe("mutant_look_at_player");
		AI.PushGoal("locate", 0, "player");
		AI.PushGoal("+lookat", 1, 0, 0, true);
		AI.PushGoal("+timeout", 1, 0.2);
		AI.PushGoal("+lookat", 1, -500);
	AI.EndGoalPipe();
	
	--------------------------------------------- not currently used
	AI.BeginGoalPipe("mutant_seek_old2");
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
		AI.PushGoal("run", 0, 1);
		AI.PushGoal("lookaround", 0, 70, 3, 100, 100, AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("locate", 0, "refpoint");
		AI.PushGoal("acqtarget", 0, "refpoint");
		AI.PushGoal("approach", 0, 0, AILASTOPRES_USE + AILASTOPRES_LOOKAT);
		--AI.PushGoal("stick", 0, 1.0, AILASTOPRES_USE, STICK_BREAK, -1);
		AI.PushLabel("STICK_LOOP");
			AI.PushGoal("lookaround", 0, 360, 3, 100, 100, AI_BREAK_ON_LIVE_TARGET);
			AI.PushGoal("branch", 1, "SEEK_FOUND", IF_SEES_LASTOP, 1);
			AI.PushGoal("signal", 1, 1, "SEEK_PROCESS", 0);
			AI.PushGoal("branch", 1, "STICK_LOOP", IF_ACTIVE_GOALS);
			AI.PushGoal("branch", 1, "STICK_END", BRANCH_ALWAYS);

			--AI.PushGoal("branch", 1, "STICK_END", IF_SEES_TARGET);
				--AI.PushGoal("signal", 1, 1, "SEEK_PROCESS", 0);
				--AI.PushGoal("clear", 1, 1);
				--AI.PushGoal("lookaround", 1, 360, 10, .25, .25, AI_BREAK_ON_LIVE_TARGET);
				--AI.PushGoal("locate", 0, "target");
				--AI.PushGoal("lookat", 1, -45, 45, 1, AI_LOOKAT_CONTINUOUS + AI_LOOKAT_USE_BODYDIR);
				--AI.PushGoal("branch", 1, "STICK_LOOP", IF_ACTIVE_GOALS);
				--AI.PushGoal("branch", 1, "STICK_LOOP", BRANCH_ALWAYS);
		AI.PushLabel("SEEK_FOUND");
			AI.PushGoal("signal", 1, 1, "SEEK_SUCCESS", 0);
		AI.PushLabel("STICK_END");
		AI.PushGoal("clear", 0, 0);
		AI.PushGoal("lookaround", 1, 360, 3, 6, 10, AI_BREAK_ON_LIVE_TARGET);
		AI.PushGoal("signal", 1, 1, "SEEK_NOTHING_FOUND", 0);
	AI.EndGoalPipe();

	--------------------------------------------- not currently used
	AI.BeginGoalPipe("mutant_seek_old");
		AI.PushGoal("firecmd", 0, FIREMODE_OFF);
		AI.PushGoal("locate", 0, "player");
		AI.PushGoal("signal", 1, 1, "AnalyzeSituation", SIGNALFILTER_SENDER);
	AI.EndGoalPipe();

end

