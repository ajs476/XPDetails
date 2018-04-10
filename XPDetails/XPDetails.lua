EVENT_MANAGER:RegisterForEvent("XPDetails", EVENT_PLAYER_ACTIVATED, function()
    --d("Alex's XP Add-On Loaded")
    local saveData = ZO_SavedVars:NewAccountWide("XPDetails_Data", 1)
    local current_player_level_xp = 0
    local max_player_level_xp = 0
    local progress_percent = 0
    local percent_symbol = "%"
    current_player_level_xp = GetUnitXP("player")
    max_player_level_xp = GetNumExperiencePointsInLevel(GetUnitLevel("player"))
    progress_percent = current_player_level_xp/max_player_level_xp*100
    XPDetailsOutput:SetText(string.format("XP    %d / %d    %d%s", current_player_level_xp, max_player_level_xp, progress_percent, percent_symbol))

    XPDetails:SetHandler("OnMoveStop", function(control)
        local x, y = control:GetScreenRect()
        --d(string.format("move stopped at %d/%d", x, y))
        --d("saving window")
        saveData.window = { x=x, y=y }
    end)

    XPDetails:SetHandler("OnResizeStop", function(control)
      local width, height = control:GetDimensions()
      saveData.window.width = width
      saveData.window.height = height
    end)

    local window = XPDetails
    if(saveData.window) then
      --d("loaded window")
      window:ClearAnchors()
      window:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, saveData.window.x, saveData.window.y)
      window:SetDimensions(saveData.window.width, saveData.window.height)
    else
        --nothing
    end

end)

EVENT_MANAGER:RegisterForEvent("XPDetails", EVENT_EXPERIENCE_UPDATE, function()
    --d("GAINED XP")
    local current_player_level_xp = 0
    local max_player_level_xp = 0
    local progress_percent = 0
    local percent_symbol = "%"
    current_player_level_xp = GetUnitXP("player")
    max_player_level_xp = GetNumExperiencePointsInLevel(GetUnitLevel("player"))
    progress_percent = current_player_level_xp/max_player_level_xp*100
    XPDetailsOutput:SetText(string.format("XP    %d / %d    %d%s", current_player_level_xp, max_player_level_xp, progress_percent, percent_symbol))
end)
