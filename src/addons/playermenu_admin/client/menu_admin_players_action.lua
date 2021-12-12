--[[
  This file is part of FlashLand.
  Created at 11/12/2021 17:59
  
  Copyright (c) FlashLand - All Rights Reserved
  
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
---@author VibR1cY

local teleportType = { _FlashEnum_TELEPORTATIONTYPE.STAFF_ON_PLAYER, _FlashEnum_TELEPORTATIONTYPE.PLAYER_ON_STAFF }
local teleportIndex = 1

local function checkPerm(permission)
    return (_FlashClient_Staff.hasPermission(permission))
end

---@param player _Player
_FlashClient_PlayerMenu.drawer[15] = function(player)
    local perm = nil
    if (_FlashClient_PlayerMenu.var.selectedPlayer ~= nil) then
        local players = _FlashClient_Staff.getPlayerList()
        local playerData = players[_FlashClient_PlayerMenu.var.selectedPlayer]
        RageUI.Separator(("Nom : ~b~%s"):format(playerData.name))
        RageUI.Separator(("Flash ID : ~b~%s"):format(playerData.flashId))
        RageUI.Separator(("ID : ~b~%s"):format(playerData.sId))
        RageUI.Line()
        perm = "admin.teleport"
        RageUI.List("Teleportation : ", teleportType, teleportIndex, nil, {}, (not (checkPerm(perm))), {
            onListChange = function(Index)
                teleportIndex = Index
            end,
            onSelected = function()
                if teleportIndex == 1 then
                    _FlashLand.toServer("staff:teleportStaffToPlayer", playerData.source)
                elseif teleportIndex == 2 then
                    _FlashLand.toServer("staff:teleportPlayerToStaff", playerData.source)
                end
            end,
        })
        perm = "admin.playerinv"
        RageUI.Button("Inventaire", nil, {}, (not (checkPerm(perm))), {}, _FlashClient_PlayerMenu.getMenus()[16])
    end
end