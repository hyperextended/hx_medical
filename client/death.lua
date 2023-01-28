local canRespawn = false
local anims = {
    { 'missfinale_c1@', 'lying_dead_player0' },
    { 'veh@low@front_ps@idle_duck', 'sit' },
    { 'dead', 'dead_a' },
}

RegisterNetEvent('medical:revive', function(...)
    print("PlayerIsDead", PlayerIsDead)
    if not PlayerIsDead then
        ClearPedTasksImmediately(cache.ped)
        SetPedMaxHealth(cache.ped, 200)
        TriggerServerEvent('ox:playerDeath', false)
        ClearPedBloodDamage(cache.ped)
        if cache.vehicle then
            SetPedIntoVehicle(cache.ped, cache.vehicle, cache.seat)
        end
        EnableAllControlActions(0)
        SetEveryoneIgnorePlayer(cache.playerId, false)
        SetEntityInvincible(cache.ped, false)
        SetEntityHealth(cache.ped, 200)
        exports.scully_emotemenu:ToggleLimitation(false)
        canRespawn = false
    end
end)

local function revive()
    print("PlayerIsDead", PlayerIsDead)
    if not PlayerIsDead then
        ClearPedTasksImmediately(cache.ped)
        SetPedMaxHealth(cache.ped, 200)
        SetEntityHealth(cache.ped, 200)
        ClearPedBloodDamage(cache.ped)
        if cache.vehicle then
            SetPedIntoVehicle(cache.ped, cache.vehicle, cache.seat)
        end
        EnableAllControlActions(0)
        SetEveryoneIgnorePlayer(cache.playerId, false)
        SetEntityInvincible(cache.ped, false)
        TriggerServerEvent('ox:playerDeath', false)
        exports.scully_emotemenu:ToggleLimitation(false)
        canRespawn = false
    end
end

local function initializeVariables()
    PlayerIsUnconscious = false
    PlayerIsStaggered = false
    RespawnTimer = 10
end

local function triggerServerEvents()
    TriggerServerEvent('ox:playerDeath', true)
    TriggerServerEvent('medical:changeStatus', 'bleed', 0)
    TriggerServerEvent('medical:changeStatus', 'stagger', 0)
    TriggerServerEvent('medical:changeStatus', 'unconscious', 0)
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
        Wait(100)
        if timer > 20 then
            SetPedCanRagdoll(cache.ped, false)
            return
        end
    end
end

local function playDeathAnimation()
    if PlayerIsDead then
        local anim = cache.vehicle and anims[2] or anims[1]
        local isInAnim = IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3)
        if not isInAnim then
            TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
        end
    end
end

local function countdownRespawnTimer()
    while RespawnTimer > 0 do
        playDeathAnimation()
        lib.showTextUI(('Respawn in %s'):format(RespawnTimer))
        RespawnTimer = RespawnTimer - 1
        Wait(1000)
        lib.hideTextUI()
        if not PlayerIsDead then return end
    end
end

local function checkForRespawn()
    lib.showTextUI('[E] - Respawn')
    canRespawn = true
    while canRespawn do
        Wait(0)
        playDeathAnimation()
        if not PlayerIsDead then
            lib.hideTextUI()
            return
        end
        if IsControlJustReleased(2, 51) then
            if lib.progressCircle({
                duration = 2000,
                position = 'bottom',
                canCancel = true,
                useWhileDead = true,
                allowRagdoll = true,
            })
            then
                lib.hideTextUI()
                return playerState:set('dead', false)
            else
                print('Do stuff when cancelled')
            end
        end
    end
end

local function respawnPlayer()
    local coords = GetEntityCoords(cache.ped)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(cache.ped), false, false)
    SetEntityHealth(cache.ped, 100)

    if cache.vehicle then
        SetPedIntoVehicle(cache.ped, cache.vehicle, cache.seat)
    end
    Wait(200)

    while PlayerIsDead do
        Wait(0)
        TriggerEvent('ox_inventory:disarm')
        playDeathAnimation()
        SetEveryoneIgnorePlayer(cache.playerId, true)
        countdownRespawnTimer()
        checkForRespawn()
    end
    SetPedCanRagdoll(cache.ped, true)
end

local function death()
    Citizen.CreateThread(function()
        initializeVariables()
        exports.scully_emotemenu:ToggleLimitation(true)
        SetEntityInvincible(cache.ped, true)
        triggerServerEvents()
        LoadAnimations()
        waitForRagdoll()
        respawnPlayer()
    end)
end

local function startDeathLoop()
    Citizen.CreateThread(function()
        while PlayerIsLoaded do
            Wait(100)
            cache.ped = PlayerPedId()
            if not PlayerIsDead and IsPedDeadOrDying(cache.ped, true) then
                playerState:set('dead', true)
            end
        end
    end)
end

local function HpRegen()
    if GetConvarInt('medical:HealthRecharge', 1) == 0 then
        SetPlayerHealthRechargeMultiplier(cache.ped, 0.0)
    end
end

AddEventHandler('ox:playerLoaded', function(data)
    PlayerIsLoaded = true
    HpRegen()
    startDeathLoop()
end)

AddEventHandler('ox:playerLogout', function()
    PlayerIsLoaded = false
    PlayerIsDead = false
end)

-- Support resource restart
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == cache.resource and cache.ped then
        PlayerIsLoaded = true
        HpRegen()
        startDeathLoop()
    end
end)

AddStateBagChangeHandler('dead', 'player:' .. cache.serverId, function(bagName, key, value, _unused, replicated)
    print("new value: ", value)
    if value == true then
        PlayerIsDead = true
        death()
    else
        PlayerIsDead = false
        revive()
    end
end)

if GetConvarInt('medical:debug', 0) == 1 then

    local ShowStatus = false

    AddEventHandler('ox:statusTick', function(statuses)
        if ShowStatus then
            print(json.encode(statuses, { indent = true }))
        end
    end)

    RegisterCommand('kill', function()
        playerState:set('dead', true)
    end)

    RegisterCommand('revive', function()
        lib.hideTextUI()
        canRespawn = false
        playerState:set('dead', false)
    end)

    RegisterCommand('status', function()
        ShowStatus = not ShowStatus
    end)
end
