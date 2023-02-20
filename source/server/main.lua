local AyseCore = exports['Ayse_Core']:GetCoreObject()
local RepairCosts = {}

lib.callback.register('Ayse_Customs:server:GetLocations', function()
    return(config.locations)
end)

AddEventHandler("playerDropped", function()
    local source = source
    RepairCosts[source] = nil
end)

AddEventHandler("playerConnecting", function()
    local source = source
    TriggerClientEvent('Ayse_Customs:client:getLocations', source)
end)

RegisterNetEvent('Ayse_Customs:server:attemptPurchase', function(type, upgradeLevel, location)
    local source = source
    local Player = AyseCore.Functions.GetPlayer(source)
    local price
    if type == "repair" then
        price = RepairCosts[source] or config.defaultRepairPrice
    elseif type == "performance" or type == "turbo" then
        price = vehicleCustomisationPrices[type].prices[upgradeLevel]
    else
        price = vehicleCustomisationPrices[type].price
    end
    if Player.cash >= price then
        AyseCore.Functions.DeductMoney(price, source, "cash")
    else
        TriggerClientEvent('Ayse_Customs:client:purchaseFailed', source)
    end
end)

RegisterNetEvent('Ayse_Customs:server:updateRepairCost', function(cost)
    local source = source
    RepairCosts[source] = cost
end)

-- Use this event to dynamically enable/disable a location. Can be used to change anything at a location.
-- TriggerEvent('Ayse_Customs:server:UpdateLocation', 'Hayes', 'settings', 'enabled', test)

RegisterNetEvent('Ayse_Customs:server:UpdateLocation', function(location, type, key, value)
    local source = source
    if not IsPlayerAceAllowed(source, config.acePerm) then 
        return 
        CancelEvent() 
    end
    config.locations[location][type][key] = value
    TriggerClientEvent('Ayse_Customs:client:UpdateLocation', -1, location, type, key, value)
end)

RegisterCommand('customs', function(source)
    if IsPlayerAceAllowed(source, config.acePerm) then
        local ped = GetPlayerPed(source)
        TriggerClientEvent('Ayse_Customs:client:EnterCustoms', source, {
            coords = GetEntityCoords(ped),
            heading = GetEntityHeading(ped),
            categories = {
                repair = true,
                mods = true,
                armor = true,
                respray = true,
                liveries = true,
                wheels = true,
                tint = true,
                plate = true,
                extras = true,
                neons = true,
                xenons = true,
                horn = true,
                turbo = true,
                cosmetics = true,
            }
        })
    else
        TriggerClientEvent("ox_lib:notify", source, {
            description = "You don't have permission to use this.",
            type = "error",
        })
    end
end, false)

TriggerClientEvent('chat:addSuggestion', '/customs', 'Open customs menu.')
