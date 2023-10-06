local canRespawn = false
local RespawnTimer = 0
local controls = { 25, 30, 31, 32, 33, 34, 35, 36, 140, 141, 142, 143, }
local anims = {
    { 'missfinale_c1@',             'lying_dead_player0' },
    { 'veh@low@front_ps@idle_duck', 'sit' },
    { 'dead',                       'dead_a' },
    { 'nm',                         'firemans_carry' },
}

-- TaskPlayAnim(playerPed, 'dam_ko', 'drown', 8.0, 8.0, -1, 33, 0, 0, 0, 0)

local function dropInventory()
    if GetConvarInt('medical:dropInventory', 0) == 1 then
        -- TODO:dump inventory at location
        lib.callback.await('medical:dropInventory', source, GetEntityCoords(cache.ped))
        -- print(json.encode(playerItems, { indent = true }))
    end
end

RegisterNetEvent('medical:revive', function()
    PlayerIsDead = false
    LocalPlayer.state.dead = false


    TriggerServerEvent('ox:playerDeath', false)
    TriggerEvent('medical:clearBlurEffect')
    Wait(30)
    if lib.progressActive() then
        lib.cancelProgress()
    end
    SetEntityMaxHealth(cache.ped, 200)
    SetEntityHealth(cache.ped, 200)
    RespawnTimer = 0
    ClearPedTasks(cache.ped)
    ClearPedBloodDamage(cache.ped)

    if cache.vehicle then
        SetPedIntoVehicle(cache.ped, cache.vehicle, cache.seat)
    end

    EnableAllControlActions(0)
    SetEveryoneIgnorePlayer(cache.playerId, false)
    SetEntityInvincible(PlayerPedId(), false)
    SetPlayerInvincible(PlayerPedId(), false)
    exports.scully_emotemenu:setLimitation(false)

    canRespawn = false

    SetPedCanRagdoll(cache.ped, true)
    lib.disableControls:Remove(controls)
    exports.scully_emotemenu:resetExpression()
end)

local function initializeVariables()
    RespawnTimer = GetConvarInt('medical:deathTimer', 60)
    PlayerIsUnconscious = false
    PlayerIsStaggered = false
end

function LoadAnimations()
    for i = 1, #anims do
        lib.requestAnimDict(anims[i][1])
    end
end

local function waitForRagdoll()
    local timer = 0
    while GetEntitySpeed(cache.ped) > 0.5 or IsPedRagdoll(cache.ped) do
        timer = timer + 1
        Wait(200)
        if timer > 20 then
            SetPedCanRagdoll(cache.ped, false)
            return
        end
    end
end

local function playDeathAnimation()
    if PlayerIsDead then
        local anim = cache.vehicle and anims[2] or IsEntityInWater(cache.ped) and anims[4] or anims[1]
        local isInAnim = IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3)

        lib.disableControls()

        if not isInAnim then
            TaskPlayAnim(cache.ped, anim[1], anim[2], 8.0, 8.0, -1, 33, 0, false, false, false)
        end
    else
        ClearPedTasks(cache.ped)
    end
end

local function countdownRespawnTimer()
    while RespawnTimer > 0 and PlayerIsDead do
        lib.showTextUI(('Respawn in %s'):format(RespawnTimer))
        RespawnTimer -= 1
        Wait(1000)
        lib.hideTextUI()
        if not PlayerIsDead then
            RespawnTimer = 0
            return
        end
    end
end

local function checkForRespawn()
    lib.showTextUI('[E] - Respawn')
    canRespawn = true
    while canRespawn do
        Wait(0)
        if not PlayerIsDead then
            lib.hideTextUI()
            return
        end
        if IsControlJustReleased(2, 51) and not lib.progressActive() then
            if lib.progressCircle({
                    duration = 2000,
                    position = 'bottom',
                    canCancel = true,
                    useWhileDead = true,
                    allowRagdoll = true,
                })
            then
                lib.hideTextUI()
                if GetConvarInt('medical:useBeds', 1) == 1 then
                    Hospital:hospitalBed()
                else
                    Hospital:teleportHospital()
                end
                TriggerServerEvent('medical:revive')
                return
            else
                controlPressed = false
            end
        end
    end
end

local function setPlayerDead()
    local coords = GetEntityCoords(cache.ped)

    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(cache.ped), false, false)
    SetPlayerHealthRechargeMultiplier(cache.playerId, 0.0)
    SetEntityInvincible(PlayerPedId(), true)
    SetEntityMaxHealth(cache.ped, 100)
    SetEntityHealth(cache.ped, 100)

    if cache.vehicle then
        SetPedIntoVehicle(cache.ped, cache.vehicle, cache.seat)
    end

    Wait(200)

    TriggerEvent('ox_inventory:disarm')
    exports.scully_emotemenu:setExpression('dead_1')

    Wait(1000)

    if lib.progressActive() then
        lib.cancelProgress()
    end
end

RegisterNetEvent('medical:playerDeath', function()
    initializeVariables()
    exports.scully_emotemenu:setLimitation(true)
    SetPlayerInvincible(cache.playerId, true)
    LoadAnimations()
    lib.disableControls:Add(controls)
    waitForRagdoll()
    setPlayerDead()

    CreateThread(function()
        while PlayerIsDead and playerState.bed == nil do
            playDeathAnimation()
            Wait(0)
        end
    end)

    countdownRespawnTimer()

    CreateThread(function()
        checkForRespawn()
    end)
end)

local function startDeathLoop()
    CreateThread(function()
        while PlayerIsLoaded do
            Wait(100)
            -- cache.ped = PlayerPedId()
            if not PlayerIsDead and IsPedDeadOrDying(cache.ped, true) or not PlayerIsDead and LocalPlayer.state.dead then
                PlayerIsDead = true
                LocalPlayer.state.dead = true
                TriggerServerEvent('ox:playerDeath', true)
                TriggerServerEvent('medical:playerDeath', true)
            end
        end
    end)
end

AddEventHandler('ox:playerLoaded', function(data)
    PlayerIsLoaded = false
    SetEntityMaxHealth(cache.ped, 200)
    SetEntityHealth(cache.ped, 200)
    SetPlayerHealthRechargeMultiplier(cache.playerId, 0.0)
    PlayerIsLoaded = true
    startDeathLoop()
end)

AddEventHandler('ox:playerLogout', function()
    LocalPlayer.state.dead = nil
    lib.hideTextUI()
end)

RegisterNetEvent('medical:killPlayer', function()
    SetEntityHealth(cache.ped, 0)
end)

if GetConvarInt('medical:debug', 0) == 1 then
    -- Support resource restart
    AddEventHandler('onResourceStart', function(resourceName)
        if resourceName == cache.resource and cache.ped then
            PlayerIsLoaded = false
            SetEntityMaxHealth(cache.ped, 200)
            SetEntityHealth(cache.ped, 200)
            SetPlayerHealthRechargeMultiplier(cache.playerId, 0.0)
            PlayerIsLoaded = true
            startDeathLoop()
        end
    end)
    local ShowStatus = false
    AddEventHandler('ox:statusTick', function(statuses)
        if ShowStatus then
            print(json.encode(statuses, { indent = true }))
        end
    end)
    RegisterCommand('status', function()
        ShowStatus = not ShowStatus
    end)

    RegisterCommand('dropInv', function()
        dropInventory()
    end)
end

CreateThread(function()
    while true do
        Wait(100)
        print('LocalPlayer.state.dead', LocalPlayer.state.dead)
    end
end)
