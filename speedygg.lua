local addonName, namespace = ...
local speedy = namespace
speedy.playerClass = select(3, UnitClass('player'))
speedy.name = UnitName('player')
speedy.server = GetRealmName()
speedy.guid = UnitGUID('player')
speedy.onUpdateFrame = CreateFrame("frame")
local addon = CreateFrame('Frame');
addon:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)
addon:RegisterEvent("ADDON_LOADED")
addon:RegisterEvent("SCENARIO_POI_UPDATE")
--addon:RegisterEvent("ZONE_CHANGED_NEW_AREA")
addon:RegisterEvent("PLAYER_ENTERING_WORLD")
local _format = string.format
local _floor = math.floor
local function GetFormatedTime(time, shortVersion)
	if not time then return "Error: time is nil" end
	local mins = _floor(time / 60)
	local seconds = time % 60
	local mseconds = (time - _floor(time))*100
	if shortVersion and mins == 0 then
			return _format("%02d.%03d", seconds, mseconds)
	end
	return _format("%02d:%02d.%03d", mins, seconds, mseconds)
end
function speedy:StartTimer()
	speedyggDB.currentInstance.startTime = GetTime()
	speedyggDB.currentInstance.alreadyStarted = true
	speedyggDB.currentInstance.alreadyDone = false
	speedy.onUpdateFrame:SetScript("OnUpdate", function()
		speedy.frames.mainTimerText:SetText(GetFormatedTime(GetTime()-speedyggDB.currentInstance.startTime))
	end)
	speedy.frames.watermark:Show()
	addon:UnregisterEvent("PLAYER_STARTED_MOVING")
end
function speedy:HideTimer()
	if speedy.frames and speedy.frames.mainFrame then
		speedy.frames.mainFrame:Hide()
	end
	if speedy.onUpdateFrame then
		speedy.onUpdateFrame:SetScript("OnUpdate", nil)
	end
end
function speedy:ExportData()
	if not speedy.frames.export then
		speedy.frames.export = CreateFrame("EditBox",nil, speedy.frames.mainFrame)
		speedy.frames.export:SetBackdrop({
				bgFile = [[Interface\Buttons\WHITE8x8]],
				edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
				edgeSize = 14,
				insets = {left = 3, right = 3, top = 3, bottom = 3},
			})
		speedy.frames.export:SetBackdropColor(0, 0, 0)
		speedy.frames.export:SetBackdropBorderColor(0.3, 0.3, 0.3)
		speedy.frames.export:SetMultiLine(true)
		speedy.frames.export:SetSize(300, 150)
		speedy.frames.export:SetPoint("TOP", speedy.frames.exportButton, "BOTTOM", 0, -3)
		speedy.frames.export:SetAutoFocus(true)
		--speedy.frames.export:SetCursorPosition(0)
		speedy.frames.export:SetFont(GameFontNormalSmall:GetFont(), 12)
		speedy.frames.export:SetJustifyH("LEFT")
		speedy.frames.export:SetJustifyV("TOP")
		speedy.frames.export:SetScript('OnEnterPressed', function()
			speedy.frames.export:ClearFocus()
			speedy.frames.export:Hide()
		end)
		speedy.frames.exportCloseButton = CreateFrame("Button", nil, speedy.frames.export, "UIPanelButtonTemplate")
		speedy.frames.exportCloseButton:SetSize(150,22) -- width, height
		speedy.frames.exportCloseButton:SetText("Close")
		speedy.frames.exportCloseButton:SetPoint("TOP", speedy.frames.export, "BOTTOM", 0,-2)
		speedy.frames.exportCloseButton:SetScript("OnClick", function(self)
			speedy.frames.export:Hide()
		end)
	else
		speedy.frames.export:Show()
	end
	speedy.frames.export:SetText(_format('{"class":"%s","time":"%s","startTime":"%s","endTime":"%s","instanceID":"%s","date":"%s","level":"%s","GUID":"%s","name":"%s","server":"%s", "difficultyID":"%s"}',
	speedy.playerClass,speedy.frames.mainTimerText:GetText(), speedyggDB.currentInstance.startTime, speedyggDB.currentInstance.endTime, speedyggDB.currentInstance.instanceID, speedyggDB.currentInstance.date, UnitLevel('player'), speedy.guid, speedy.name, speedy.server, select(3, GetInstanceInfo())))
end
local _format = string.format
do
	local colors = {
		GREEN = '\124cff008000%s\124r',
		RED = '\124cffff0000%s\124r',
	}
	function speedy:FormatToColor(color, str)
		if colors[color] then
			return colors[color]:format(str)
		else
			return str
		end
	end
end
function speedy:GetFormatedDungeonInfo()
	local _abs = math.abs
	local t = {}
	for i = 1, #speedyggDB.currentInstance.encounters do
		local str = (i > 1 and "\n") or ""
			-- Criteria
		if not speedyggDB.currentInstance.encounters[i].completeTime then
			t[i] = string.format("%s%s - \124cff00ffff%s\124r",str, speedyggDB.currentInstance.encounters[i].criteria, (speedyggDB.currentInstance.encounters[i].bestTime or "N/A"))
		else
			local _e = speedy:FormatToColor("GREEN", speedyggDB.currentInstance.encounters[i].criteria)
			local _ct = GetFormatedTime(speedyggDB.currentInstance.encounters[i].completeTime, true)
			local _dif = ""
			if speedyggDB.currentInstance.encounters[i].dif then
				local isFaster = speedyggDB.currentInstance.encounters[i].dif < 0
				_dif = speedy:FormatToColor((isFaster and "GREEN" or "RED"), (isFaster and " -" or " +") .. GetFormatedTime(_abs(speedyggDB.currentInstance.encounters[i].dif), true))
			end
			t[i] = string.format("%s%s - %s%s", str, _e, _ct, _dif)
		end
	end
	return #t > 0 and table.concat(t) or ""
end
function speedy:UpdateFontSizes()
	if not speedy.frames then return end

	speedy.frames.mainTimerText:SetFont(GameFontNormal:GetFont(), speedyggDB.fontSize, "OUTLINE")
	speedy.frames.dungeonInfo:SetFont(GameFontNormal:GetFont(), speedyggDB.objectiveFontSize, "OUTLINE")
	speedy.frames.watermarkText:SetFont(GameFontNormal:GetFont(), speedyggDB.objectiveFontSize+4, "OUTLINE")

	local w, h = speedy.frames.dungeonInfo:GetSize()
	speedy.frames.dungeonInfoBG:SetSize(w, h+2)
	speedy.frames.mainFrame:SetWidth(speedy.frames.mainTimerText:GetWidth())
	speedy.frames.mainFrame:SetHeight(speedy.frames.mainTimerText:GetHeight())
end
function speedy:UpdateEncounterInfo()
	if not speedy.frames or not speedy.frames.dungeonInfo then return end
	speedy.frames.dungeonInfo:SetText(speedy:GetFormatedDungeonInfo(speedyggDB.currentInstance.encounters))
	local w, h = speedy.frames.dungeonInfo:GetSize()
	speedy.frames.dungeonInfoBG:SetSize(w, h+2)
end
local function toggleFrameLock()
	if not (speedy.frames and speedy.frames.mainFrame) then return end
	if speedyggDB.lock then
		speedy.frames.mainFrame:EnableMouse(false)
		speedy.frames.mainFrame:SetMovable(false)
		speedy.frames.mainFrame:SetScript('OnMouseDown', nil)
		speedy.frames.mainFrame:SetScript('OnMouseUp', nil)
		return
	end
	speedy.frames.mainFrame:EnableMouse(true)
	speedy.frames.mainFrame:SetMovable(true)
	speedy.frames.mainFrame:SetScript('OnMouseDown', function(self,button)
		speedy.frames.mainFrame:ClearAllPoints()
		speedy.frames.mainFrame:StartMoving()
	end)
	speedy.frames.mainFrame:SetScript('OnMouseUp', function(self, button)
		speedy.frames.mainFrame:StopMovingOrSizing()
		local _a, _, _, _x, _y = speedy.frames.mainFrame:GetPoint()
		speedyggDB.pos = {
			x = _x,
			y = _y,
			anchor = _a,
		}
		if _a:find("LEFT") then
			speedyggDB.pos.j = "LEFT"
			speedy.frames.mainTimerText:SetJustifyH("LEFT")
		elseif _a:find("RIGHT") then
			speedyggDB.pos.j = "RIGHT"
			speedy.frames.mainTimerText:SetJustifyH("RIGHT")
			else
				speedyggDB.pos.j = "CENTER"
				speedy.frames.mainTimerText:SetJustifyH("CENTER")
		end
	end)
end
function speedy:ShowTimer(completed)
	if not speedy.frames then
		speedy.frames = {}
		speedy.frames.mainFrame = CreateFrame("Frame", "SpeedyGGMainFrame", UIParent)
		speedy.frames.mainFrame:SetSize(20, 20)
		speedy.frames.mainFrame:SetPoint(speedyggDB.pos.anchor, UIParent, speedyggDB.pos.x,speedyggDB.pos.y)

		speedy.frames.mainTimerText = speedy.frames.mainFrame:CreateFontString()
		speedy.frames.mainTimerText:SetFont(GameFontNormal:GetFont(), speedyggDB.fontSize, "OUTLINE")
		speedy.frames.mainTimerText:SetPoint("CENTER", speedy.frames.mainFrame, "CENTER", 0, 0)
		speedy.frames.mainTimerText:SetJustifyH(speedyggDB.pos.j)
		speedy.frames.mainTimerText:SetText("00:00.000")

		speedy.frames.dungeonInfoBG = CreateFrame("Frame", "SpeedyGGDungeonInfoBG", UIParent)
		speedy.frames.dungeonInfoBG:SetSize(20, 20)
		if speedyggDB.pos.j == "CENTER" then
			speedy.frames.dungeonInfoBG:SetPoint("TOP", speedy.frames.mainFrame, "BOTTOM", 0, 0)
		else
			speedy.frames.dungeonInfoBG:SetPoint("TOP"..speedyggDB.pos.j, speedy.frames.mainFrame, "BOTTOM"..speedyggDB.pos.j, 0, 0)
		end
		speedy.frames.dungeonInfo = speedy.frames.mainFrame:CreateFontString()
		speedy.frames.dungeonInfo:SetFont(GameFontNormal:GetFont(), speedyggDB.objectiveFontSize, "OUTLINE")
		speedy.frames.dungeonInfo:SetPoint("CENTER", speedy.frames.dungeonInfoBG, "CENTER", 2, -2)
		--speedy.frames.dungeonInfo:SetPoint("TOP"..speedyggDB.pos.j, speedy.frames.mainFrame, "BOTTOM"..speedyggDB.pos.j, 0, 0)
		speedy.frames.dungeonInfo:SetJustifyH(speedyggDB.pos.j)

		speedy.frames.watermark = CreateFrame("Frame", nil, UIParent)
		speedy.frames.watermark:SetSize(5, 5)
		speedy.frames.watermark:SetPoint("CENTER", speedy.frames.dungeonInfoBG, 0,0)
		speedy.frames.watermark:SetFrameStrata("DIALOG")

		speedy.frames.watermarkText = speedy.frames.watermark:CreateFontString()
		speedy.frames.watermarkText:SetFont(GameFontNormal:GetFont(), speedyggDB.objectiveFontSize+4, "OUTLINE")
		speedy.frames.watermarkText:SetTextColor(1,1,0)
		speedy.frames.watermarkText:SetPoint("CENTER", speedy.frames.watermark, "CENTER", 0, 0)
		speedy.frames.watermarkText:SetJustifyH("CENTER")
		speedy.frames.watermark:Hide()

		speedy.frames.watermark.animGroup = speedy.frames.watermark:CreateAnimationGroup()
		speedy.frames.watermark.animFade = speedy.frames.watermark.animGroup:CreateAnimation("Alpha")
		speedy.frames.watermark.animFade:SetOrder(1)
		speedy.frames.watermark.animFade:SetFromAlpha(1)
		speedy.frames.watermark.animFade:SetToAlpha(0)
		speedy.frames.watermark.animFade:SetDuration(1.5)

		speedy.frames.watermark:SetScript("OnShow", function()
			speedy.frames.watermarkText:SetText(string.format("%s\n%s",date('%H:%M:%S\n%y.%m.%d'),GetTime()))
			speedy.frames.watermark.animGroup:Play()
		end)

		speedy.frames.watermark.animGroup:SetScript("OnFinished", function(self)
			speedy.frames.watermark:Hide()
		end)

		speedy:UpdateEncounterInfo()

		speedy.frames.mainFrame:SetWidth(speedy.frames.mainTimerText:GetWidth())
		speedy.frames.mainFrame:SetHeight(speedy.frames.mainTimerText:GetHeight())



		speedy.frames.startButton = CreateFrame("Button", nil, speedy.frames.mainFrame, "UIPanelButtonTemplate")
		speedy.frames.startButton:SetSize(100,22) -- width, height
		speedy.frames.startButton:SetText("Ready")
		speedy.frames.startButton:SetPoint("TOP", speedy.frames.dungeonInfoBG, "BOTTOM", 0,-2)
		speedy.frames.startButton:SetScript("OnClick", function(self)
				self:Hide()
				--speedy:StartTimer()
				speedy:print("Timer will start when you start moving.")
				speedy.isReady = true
		end)

		speedy.frames.exportButton = CreateFrame("Button", nil, speedy.frames.mainFrame, "UIPanelButtonTemplate")
		speedy.frames.exportButton:SetSize(100,22) -- width, height
		speedy.frames.exportButton:SetText("Export")
		speedy.frames.exportButton:SetPoint("TOP", speedy.frames.dungeonInfoBG, "BOTTOM", 0,-2)
		speedy.frames.exportButton:SetScript("OnClick", function(self)
				speedy:ExportData()
		end)
		speedy.frames.exportButton:Hide()

		toggleFrameLock()

		if speedyggDB.currentInstance.alreadyStarted then
			if not completed then
				speedy.frames.startButton:Hide()
				speedy.onUpdateFrame:SetScript("OnUpdate", function()
					speedy.frames.mainTimerText:SetText(GetFormatedTime(GetTime()-speedyggDB.currentInstance.startTime))
				end)
			else
				speedy.frames.mainTimerText:SetText(GetFormatedTime(speedyggDB.currentInstance.endTime-speedyggDB.currentInstance.startTime))
				speedy.frames.mainTimerText:SetTextColor(0,1,0)
				speedy.frames.startButton:Hide()
				speedy.frames.exportButton:Show()
			end
		end
	else
		if not speedyggDB.currentInstance.alreadyStarted then
			speedy.frames.mainTimerText:SetText("00:00.000")
			speedy.frames.mainTimerText:SetTextColor(1,1,1)
			speedy.frames.startButton:Show()
			speedy.frames.exportButton:Hide()
		end
		speedy.frames.mainFrame:Show()
		speedy:UpdateEncounterInfo()
	end

end
function speedy:StopTimer()
	if speedy.frames and speedy.frames.mainTimerText then
		speedy.frames.mainTimerText:SetText(GetFormatedTime(GetTime()-speedyggDB.currentInstance.startTime))
		speedy.frames.mainTimerText:SetTextColor(0,1,0)
		if not speedyggDB.currentInstance.alreadyDone then
			speedyggDB.currentInstance.endTime = GetTime()
			speedyggDB.currentInstance.date = date('%y.%m.%d %H:%M:%S')
			speedy:SaveDungeonToHistory()
			speedyggDB.currentInstance.alreadyDone = true
			speedy.frames.watermark:Show()
		end
		speedy:UpdateEncounterInfo()
		speedy.frames.exportButton:Show()
	end
	speedy.onUpdateFrame:SetScript("OnUpdate",nil)
end
function speedy:GetDiff(id, currentTime, returnBest)
	local dID = speedyggDB.currentInstance.difficultyID
	local iID = speedyggDB.currentInstance.instanceID
	if not (speedyggDB.instanceHistory[dID] and speedyggDB.instanceHistory[dID][iID] and speedyggDB.instanceHistory[dID][iID][id]) then
		return returnBest and "N/A" or false
	end
	if returnBest then
		return GetFormatedTime(speedyggDB.instanceHistory[dID][iID][id], true)
	end
	return currentTime - speedyggDB.instanceHistory[dID][iID][id]
end
function speedy:SaveDungeonToHistory()
	local dID = speedyggDB.currentInstance.difficultyID
	local iID = speedyggDB.currentInstance.instanceID
	if not (dID and iID) then return end
	if not speedyggDB.instanceHistory[dID] then
		speedyggDB.instanceHistory[dID] = {}
	end
	if not speedyggDB.instanceHistory[dID][iID] then
		speedyggDB.instanceHistory[dID][iID] = {}
	end
	local currentTime = speedyggDB.currentInstance.endTime - speedyggDB.currentInstance.startTime
	if speedyggDB.instanceHistory[dID][iID].bestTime and speedyggDB.instanceHistory[dID][iID].bestTime < currentTime then
		speedy:print(string.format("Your best run was %s faster than this run.", GetFormatedTime(currentTime-speedyggDB.instanceHistory[dID][iID].bestTime, true)))
		return
	end
	speedyggDB.instanceHistory[dID][iID].bestTime = currentTime
	for k,v in pairs(speedyggDB.currentInstance.encounters) do
		speedyggDB.instanceHistory[dID][iID][k] = v.completeTime
	end
	speedy:print("Congratz! New best run.")
end
function speedy:loadDefaults()
	if speedyggDB and not speedyggDB.instanceHistory then
		speedyggDB = {
			currentInstance = {
				instanceID = 0,
				alreadyStarted = false,
				startTime = 0,
				hasMoved = false,
				difficultyID = 0,
				encounters = {},
			},
			fontSize = 18,
			objectiveFontSize = 12,
			pos = {
				x = 0,
				y = -50,
				anchor = "TOP",
				j = "CENTER"
			},
			instanceHistory = {}
		}
		return
	end
	speedyggDB = speedyggDB or {
		currentInstance = {
			instanceID = 0,
			alreadyStarted = false,
			startTime = 0,
			hasMoved = false,
			difficultyID = 0,
			encounters = {},
		},
		fontSize = 18,
		objectiveFontSize = 12,
		pos = {
			x = 0,
			y = -50,
			anchor = "TOP",
			j = "CENTER"
		},
		instanceHistory = {}
	}
end
function speedy:print(msg)
	print(string.format("SpeedyGG Timer: %s", msg))
end
function addon:ADDON_LOADED(_addonName)
	if addonName == _addonName then
		addon:UnregisterEvent("ADDON_LOADED")
		speedy:loadDefaults()
	end
end

function addon:PLAYER_STARTED_MOVING()
	local moving = IsPlayerMoving()
	if moving then
		if speedy.isReady then
			speedy:StartTimer()
			speedyggDB.currentInstance.hasMoved = true
		else
			speedy:HideTimer()
			speedy:print("Timer disabled because you moved. Re-enter to enable again.")
		end
		addon:UnregisterEvent("PLAYER_STARTED_MOVING")
	end
end

function addon:SCENARIO_POI_UPDATE()
	local scenarioDone = select(7, C_Scenario.GetInfo())
	local _time = GetTime()
	if scenarioDone then
		for k,v in pairs(speedyggDB.currentInstance.encounters) do
			if not v.completeTime then
				v.completeTime = _time - speedyggDB.currentInstance.startTime
				v.dif = speedy:GetDiff(k,v.completeTime)
			end
		end
		speedy:StopTimer()
		return
	end
	local instanceName, scenarioDesc, objectiveCount = C_Scenario.GetStepInfo()
	local isAllCompleted = true
	for i = 1, objectiveCount do
		local criteriaString, criteriaType, completed, quantity, totalQuantity, flags, assetID, quantityString, criteriaID, duration, elapsed, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(i)
		if not completed then
			isAllCompleted = false
		end
		if not speedyggDB.currentInstance.encounters[i] then
			speedyggDB.currentInstance.encounters[i] = {
				criteria = criteriaString and criteriaString:gsub(" defeated$", "") or "",
				completeTime = nil,
				bestTime = speedy:GetDiff(i, 0, true),
				dif = false
			}
		elseif completed and not speedyggDB.currentInstance.encounters[i].completeTime then
			speedyggDB.currentInstance.encounters[i].completeTime = _time - speedyggDB.currentInstance.startTime
			speedyggDB.currentInstance.encounters[i].dif = speedy:GetDiff(i, speedyggDB.currentInstance.encounters[i].completeTime)
		end
	end
	if isAllCompleted then
		speedy:StopTimer()
	end
	speedy:UpdateEncounterInfo()
end

function addon:PLAYER_ENTERING_WORLD()
	if not IsInInstance() then
		addon:UnregisterEvent("PLAYER_STARTED_MOVING")
		speedyggDB.currentInstance = {
			instanceID = instanceID,
			alreadyStarted = false,
			hasMoved = false,
			startTime = 0,
			difficultyID = select(3, GetInstanceInfo()),
			encounters = {},
		}
		speedy:HideTimer()
		speedy.isReady = false
		return
	end
	local instanceID = select(8, GetInstanceInfo())
	if not speedyggDB.currentInstance.alreadyStarted and (speedyggDB.currentInstance.instanceID ~= instanceID or not speedyggDB.currentInstance.hasMoved) then
		speedyggDB.currentInstance = {
			instanceID = instanceID,
			alreadyStarted = false,
			hasMoved = false,
			startTime = 0,
			difficultyID = select(3, GetInstanceInfo()),
			encounters = {},
		}
		local instanceName, scenarioDesc, objectiveCount = C_Scenario.GetStepInfo()
		for i = 1, objectiveCount do
			local criteriaString, criteriaType, completed, quantity, totalQuantity, flags, assetID, quantityString, criteriaID, duration, elapsed, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(i)
			if completed then
				speedyggDB.currentInstance.encounters = {}
				return
			end
			speedyggDB.currentInstance.encounters[i] = {
					criteria = criteriaString and criteriaString:gsub(" defeated$", "") or "",
					completeTime = nil,
					bestTime = speedy:GetDiff(i, 0, true),
					dif = false
			}
		end
		addon:RegisterEvent("PLAYER_STARTED_MOVING")
		speedy:ShowTimer()
	elseif speedyggDB.currentInstance.alreadyStarted and speedyggDB.currentInstance.startTime < GetTime() then -- reboot check
		local instanceName, scenarioDesc, objectiveCount = C_Scenario.GetStepInfo()
		local _completed = true
		for i = 1, objectiveCount do
			local criteriaString, criteriaType, completed, quantity, totalQuantity, flags, assetID, quantityString, criteriaID, duration, elapsed, _, isWeightedProgress = C_Scenario.GetCriteriaInfo(i)
			if not completed then
				_completed = false
			end
		end
		speedy:ShowTimer(_completed)
	end
end

SLASH_SPEEDYGG1 = "/speedy"
SLASH_SPEEDYGG2 = "/sgg"
SlashCmdList["SPEEDYGG"] = function(msg)
	if msg and msg:len() > 0 then
		msg = msg:lower()
	end
	if msg == "reset" or msg == "r" then
		speedyggDB.instanceHistory = nil
		speedyggDB.instanceHistory = {}
		speedy:print("History cleaned.")
	else
		InterfaceOptionsFrame_OpenToCategory(addonName)
	end
end