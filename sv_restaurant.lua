local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-restaurant:server:removeItem', function(name, amount)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(src)

    if PlayerData ~= nil then
        PlayerData.Functions.RemoveItem(name, amount) 

        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[name], "remove")
    end
end)

RegisterNetEvent('qb-restaurant:server:pay', function(pay)
    local src = source
    local PlayerData = QBCore.Functions.GetPlayer(src)

    if PlayerData ~= nil then
        PlayerData.Functions.AddMoney('cash', pay)
    end
end)
