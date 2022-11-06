local QBCore = exports['qb-core']:GetCoreObject()

local startedJob = false

local orders = nil

local pay = 0

RegisterNetEvent('qb-restaurant:client:initialize', function()
    QBCore.Functions.LoadModel(Config.ManagerPedModel)
    ManagerPed = CreatePed(0, Config.ManagerPedModel, Config.ManagerPedSpawn.x, Config.ManagerPedSpawn.y, Config.ManagerPedSpawn.z - 1, Config.ManagerPedSpawn.w, false, false)

    local RestaurantBlip = AddBlipForEntity(ManagerPed)
    
    TaskStartScenarioInPlace(ManagerPed, "WORLD_HUMAN_CLIPBOARD", true)
    FreezeEntityPosition(ManagerPed, true)
    SetEntityInvincible(ManagerPed, true)
    SetBlockingOfNonTemporaryEvents(ManagerPed, true)

    exports['qb-target']:AddTargetEntity(ManagerPed, {
        options = {
            {
                num = 1,
                icon = "fas fa-circle",
                label = "Start Job",
                canInteract = function()
                    if not startedJob then return true end
                    return false
                end,
                action = function()
                    startedJob = true
                    TriggerEvent('qb-restaurant:client:createOrders')
                end,
            },
            {
                num = 3,
                icon = "fas fa-circle",
                label = "End Job",
                canInteract = function()
                    if startedJob then return true end
                    return false
                end,
                action = function()
                    EndJob()
                end,
            },
            {
                num = 2,
                icon = "fas fa-circle",
                label = "Open Orders",
                canInteract = function()
                    if startedJob then return true end
                    return false
                end,
                action = function()
                    TriggerEvent('qb-restaurant:client:openOrderMenu')
                end,
            }
        },
        distance = 2
    })
end)

-- Functions
function EndJob()
    startedJob = false
    TriggerEvent('qb-restaurant:client:closeOrderMenu')
    TriggerServerEvent('qb-restaurant:server:pay', pay)
    pay = 0
end

RegisterCommand('restaurant::fix', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeOrders",
    })
end)

-- NUI
RegisterNetEvent('qb-restaurant:client:openOrderMenu', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openOrders",
    })
end)

RegisterNetEvent('qb-restaurant:client:closeOrderMenu', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeOrders",
    })
end)

RegisterNetEvent('qb-restaurant:client:createOrders', function()
    SendNUIMessage({
        action = "createOrders",
        possibleOrders = Config.Items,
        maximumOrders = Config.maximumOrders,
    })
end)

RegisterNetEvent('qb-restaurant:client:createRecipe', function(orderId)
    SendNUIMessage({
        action = "createRecipe",
        orderNumber = orderId,
    })
end)

-- NUI Callbacks
RegisterNUICallback("exit", function(data)
    TriggerEvent('qb-restaurant:client:closeOrderMenu')
end)

RegisterNUICallback("completeOrder", function(data)
    local recipe = {}
    local hasItems = true

    for k, v in pairs(Config.Items) do
        if v.name == data.itemName then
            recipe = v.recipe
        end
    end

    for k, v in pairs(recipe) do
        if not QBCore.Functions.HasItem(k) then
            hasItems = false
        end
    end

    if not hasItems then
        QBCore.Functions.Notify("You do not have the required items for this recipe.")
        return
    end

    for k, v in pairs(recipe) do
        TriggerServerEvent('qb-restaurant:server:removeItem', k, v)
    end

    for k, v in pairs(recipe) do
        TriggerServerEvent('qb-restaurant:server:completeOrder', k, v)
    end

    TriggerEvent('QBCore:Notify', "You have completed order " .. tostring(data.orderNumber) .. ".")
    pay += math.random(Config.MinPayout, Config.MaxPayout);

    SendNUIMessage({
        action = "completeOrder",
        orderNumber = data.orderNumber,
    })

    TriggerServerEvent('qb-restaurant:server:resetItems')
end)


-- Initialize
TriggerEvent('qb-restaurant:client:initialize')
