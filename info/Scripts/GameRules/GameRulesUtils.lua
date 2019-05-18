Script.ReloadScript("scripts/gamerules/SinglePlayer.lua");

function GameRulesSetStandardFuncs(gamerules)

	if (not gamerules) then
		return;
	end;

	gamerules.actionableEntityList = {}

-- ///////// Server/Client /////////
	if (not gamerules.Server) then
		gamerules.Server={};
	end;

	if (not gamerules.Client) then
		gamerules.Client={};
	end;

	if(not gamerules.AreUsable) then
		gamerules.AreUsable = SinglePlayer.AreUsable;
	end

-- Functions that unfortunately are called by CryAction (Interactor.cpp:47) and thus can't be 
-- moved into c++ without engine changes

-- ///////// IsUsable /////////
	if (not gamerules.IsUsable) then
		gamerules.IsUsable = function (self, srcId, objId)
			if not objId then return 0 end;

			local obj = System.GetEntity(objId);
			if (obj.IsUsable) then
				if (obj:IsHidden()) then
					return 0;
				end;
				local src = System.GetEntity(srcId);
				if (src and src.actor and (src:IsDead() or (src.actor:GetSpectatorMode()~=0))) then
					return 0;
				end
				return obj:IsUsable(src);
			end

			return 0;
		end
	end

-- ///////// OnNewUsable /////////
	if (not gamerules.OnNewUsable) then
		gamerules.OnNewUsable = function (self, srcId, objId, usableId)
			if not srcId then return end
			if objId and not System.GetEntity(objId) then objId = nil end

			local src = System.GetEntity(srcId)
			if src and src.SetOnUseData then
				src:SetOnUseData(objId or NULL_ENTITY, usableId)
			end

			if srcId ~= g_localActorId then return end

			if self.UsableMessage then
				self.UsableMessage = nil
			end
		end
	end

-- ///////// OnUsableMessage /////////
	if (not gamerules.OnUsableMessage) then
		gamerules.OnUsableMessage = SinglePlayer.OnUsableMessage;
	end

-- ///////// OnLongHover /////////
	if (not gamerules.OnLongHover) then
		gamerules.OnLongHover = function(self, srcId, objId)
		end
	end

	if (not gamerules.ProcessActorDamage) then
		gamerules.ProcessActorDamage = function(self, hit)
			-- Using SinglePlayer ProcessActorDamage
			gamerules.GetDamageAbsorption = SinglePlayer.GetDamageAbsorption;
			local died = SinglePlayer.ProcessActorDamage(self, hit);
			return died;
		end
	end

	if (not gamerules.Createhit) then
		gamerules.CreateHit = SinglePlayer.CreateHit;
	end

	if (not gamerules.CreateExplosion) then
		gamerules.CreateExplosion = SinglePlayer.CreateExplosion;
	end

-- // EI Begin

	if (not gamerules.AreActionable) then
		gamerules.AreActionable = function(self, src, objs)
			if (objs) then
				for i,entity in ipairs(objs) do
					self.actionableEntityList[i] = entity:IsActionable(src);
				end
			end

			return self.actionableEntityList;
		end
	end

	if (not gamerules.IsActionable) then
		gamerules.IsActionable = function(self, srcId, objId)
			if not objId then return 0 end;

			local obj = System.GetEntity(objId);
			if (obj and obj.IsActionable) then
				if (obj:IsHidden()) then
					return 0;
				end;
				local src = System.GetEntity(srcId);
				if (src and src.actor and (src:IsDead() or (src.actor:GetSpectatorMode()~=0) or src.actorStats.isFrozen)) then
					return 0;
				end
				return obj:IsActionable(src);
			end

			return 0;
		end
	end

	if (not gamerules.DidActionsChange) then
		gamerules.DidActionsChange = function(self, objId)
			if not objId then return 0 end;

			local obj = System.GetEntity(objId);
			if (obj and obj.DidActionsChange) then
				return obj:DidActionsChange();
			end
			return 0;
		end
	end

	if (not gamerules.OnNewActionable) then
		gamerules.OnNewActionable = function(self, srcId, objId, usableId)
			if not srcId then return end
			if objId and not System.GetEntity(objId) then objId = nil end
	
			local src = System.GetEntity(srcId)
			if src and src.SetOnActionData then
				src:SetOnActionData(objId or NULL_ENTITY, usableId)
			end
		end
	end

	if (not gamerules.GetActions) then
		gamerules.GetActions = function(self, srcId, objId)
			if not objId then return 0 end;

			local obj = System.GetEntity(objId);
			if (obj and obj.IsActionable) then
				if (obj:IsHidden()) then
					return 0;
				end;
				local src = System.GetEntity(srcId);
				if (src and src.actor and (src:IsDead() or (src.actor:GetSpectatorMode()~=0) or src.actorStats.isFrozen)) then
					return 0;
				end
				return obj:GetActions(src);
			end

			return 0;
		end
	end

	if (not gamerules.PerformAction) then
		gamerules.PerformAction = function(self, srcId, objId, name)
			if not objId then return 0 end;

			local obj = System.GetEntity(objId);
			if (obj and obj.IsActionable) then
				-- The ~="" is needed to the user can press a hotkey to perform the default action
				if (obj:IsHidden() and name ~="") then
					return 0;
				end;
				local src = System.GetEntity(srcId);
				if (src and src.actor and (src:IsDead() or (src.actor:GetSpectatorMode()~=0) or src.actorStats.isFrozen)) then
					return 0;
				end
				return obj:PerformAction(src, name);
			end

			return 0;
		end
	end

	if (not gamerules.DisplayActionableMenu) then
		gamerules.DisplayActionableMenu = function(self, srcId, objId, index)
			if srcId ~= g_localActorId then return end
	
			local actions = {};
	
			if objId then
				obj = System.GetEntity(objId)
				if obj then
					local src = System.GetEntity(srcId);

					if obj.GetActions then
						actions = obj:GetActions(src)
					else
						local state = obj:GetState()
						if state ~= "" then
							state = obj[state]
							if state.GetActions then
								actions = state.GetActions(obj, src)
							end
						end
					end
				end
			end
	
			self.game:DisplayActionableMenu(actions);
		end
	end

-- // EI End

end
