local is_champ = false
local current_player_level_xp = GetUnitXP("player")
local progress_percent = 0
local player_level = GetUnitLevel("player")
local max_player_level_xp = 0
local player_champ_xp = 0
local player_champ_xp_max = 0


EVENT_MANAGER:RegisterForEvent("XPDetails", EVENT_PLAYER_ACTIVATED, function()

    local saveData = ZO_SavedVars:NewAccountWide("XPDetails_Data", 1)

    -- saving coordinates of window
    XPDetails:SetHandler("OnMoveStop", function(control)
      --d("window moved")
      local x, y = control:GetScreenRect()
      saveData.window = { x=x, y=y }
      end)

    local window = XPDetails
      if(saveData.window) then
        --d("loading window")
        window:ClearAnchors()
        window:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, saveData.window.x, saveData.window.y)
        window:SetDimensions(saveData.window.width, saveData.window.height)
      end

    if player_level >= 50 then
      is_champ = true
    end
    if is_champ then
      --TODO update this to work with champion points and xp values
      player_champ_xp = GetPlayerChampionXP()
      player_champ_xp_max =  GetNumChampionXPInChampionPoint(GetPlayerChampionPointsEarned())
      progress_percent = player_champ_xp / player_champ_xp_max*100
      XPDetailsOutput:SetText(string.format("XP    %d / %d    %d%%", player_champ_xp, player_champ_xp_max, progress_percent))
    else
      -- player is not max level yet
      max_player_level_xp = GetNumExperiencePointsInLevel(player_level)
      progress_percent = current_player_level_xp / max_player_level_xp*100
      XPDetailsOutput:SetText(string.format("XP    %d / %d    %d%%", current_player_level_xp, max_player_level_xp, progress_percent))
    end

end)

EVENT_MANAGER:RegisterForEvent("XPDetails", EVENT_EXPERIENCE_UPDATE, function()
    --d("GAINED XP")
    if is_champ then
      player_champ_xp = GetPlayerChampionXP()
      player_champ_xp_max =  GetNumChampionXPInChampionPoint(GetPlayerChampionPointsEarned())
      progress_percent = player_champ_xp / player_champ_xp_max*100
      XPDetailsOutput:SetText(string.format("XP    %d / %d    %d%%", player_champ_xp, player_champ_xp_max, progress_percent))
    else
        current_player_level_xp = GetUnitXP("player")
        max_player_level_xp = GetNumExperiencePointsInLevel(player_level)
        if max_player_level_xp == nil then
          max_player_level_xp = 1
        end
        progress_percent = (current_player_level_xp / max_player_level_xp)*100
        XPDetailsOutput:SetText(string.format("XP    %d / %d    %d%%", current_player_level_xp, max_player_level_xp, progress_percent))
    end
end)
