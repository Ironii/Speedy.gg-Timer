
local addonName, addon = ...

local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
frame.name = addonName
frame:Hide()

frame:SetScript("OnShow", function(frame)
	local function newCheckbox(name, desc, func)
		local check = CreateFrame("CheckButton", "SpeedyGG"..name, frame, "InterfaceOptionsCheckButtonTemplate")
		check:SetScript("OnClick", function(self)
			local isChecked = self:GetChecked()
			func(self, isChecked)
		end)
		check.label = _G[check:GetName() .. "Text"]
		check.label:SetText(name)
		check.tooltipText = name
		check.tooltipRequirement = desc
		return check
  end

  local function newSlider(name, desc, func, minValue, maxValue, stepSize, val)
    local slider = CreateFrame("Slider", "SpeedyGG"..name, frame, "OptionsSliderTemplate")
    slider:SetMinMaxValues(minValue,maxValue)
    slider:SetValueStep(stepSize)
    slider:SetObeyStepOnDrag(true)
    slider.label = _G[slider:GetName() .. "Low"]
    slider.label:SetText(name)
    slider.label:ClearAllPoints()
    slider.label:SetPoint("BOTTOM", slider, "TOP", 0,0)

    slider.valueText = _G[slider:GetName() .. "High"]
    slider.valueText:ClearAllPoints()
    slider.valueText:SetPoint("LEFT", slider, "RIGHT", 5,0)

    slider.tooltipText = name
    slider.tooltipRequirement = desc

    slider:SetScript("OnValueChanged", function(self, value)
      slider.valueText:SetText(value)
			func(self, value)
		end)
		return slider
  end

	local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(addonName)

  local locked = newCheckbox("Lock","Lock frame",function(self, val)
    speedyggDB.lock = val
  end)
	locked:SetChecked(speedyggDB.lock)
	locked:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -2, -16)

  local timerFontSize = newSlider("Timer font size","Timer font size",function(self, val)
      speedyggDB.fontSize = val
      addon:UpdateFontSizes()
    end, 8, 100, 2)
	--chatFrame:SetChecked(addon.db.chatframe)
  timerFontSize:SetPoint("TOPLEFT", locked, "BOTTOMLEFT", 0, -12)
  timerFontSize:SetValue(speedyggDB.fontSize)
  timerFontSize.valueText:SetText(speedyggDB.fontSize)

  local objectiveFontSize = newSlider("Objective font size","Objective font size",function(self, val)
    speedyggDB.objectiveFontSize = val
    addon:UpdateFontSizes()
  end, 8, 100, 2)
  objectiveFontSize:SetPoint("TOPLEFT", timerFontSize, "BOTTOMLEFT", 0, -12)
  objectiveFontSize:SetValue(speedyggDB.objectiveFontSize)
  objectiveFontSize.valueText:SetText(speedyggDB.objectiveFontSize)
	--minimap:SetChecked(not BugSackLDBIconDB.hide)

	frame:SetScript("OnShow", nil)
end)
InterfaceOptions_AddCategory(frame)

