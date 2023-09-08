local canRespawn = false
local RespawnTimer = 0
local timerRunning = false
local anims = {
    { 'missfinale_c1@', 'lying_dead_player0' },
    { 'veh@low@front_ps@idle_duck', 'sit' },
    { 'dead', 'dead_a' },
}

local function dropInventory()
    if GetConvarInt('medical:dropInventory', 0) == 1 then
        -- TODO:dump inventory at location
        lib.callback.await('medical:dropInventory', source, GetEntityCoords(cache.ped))
        print('it worked!')
        -- print(json.encode(playerItems, { indent = true }))
    end
end

local function revive()
    if not PlayerIsDead then
        Wait(30) -- resolve issue with hud updating correctly
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
        exports.scully_emotemenu:ToggleLimitation(false)
        canRespawn = false
        SetPedCanRagdoll(cache.ped, true)
        exports.scully_emotemenu:ResetExpression()
    end

end

local function initializeVariables()
    RespawnTimer = GetConvarInt('medical:deathTimer', 60)
    PlayerIsUnconscious = false
    PlayerIsStaggered = false
end

local function resetStatuses()
    local statuses = { 'hunger', 'thirst', 'stagger', 'unconscious', 'bleed', 'stress' }
    for i = 1, #statuses do
        -- print(statuses[i])
        TriggerServerEvent('medical:changeStatus', statuses[i], 0)
    end
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
        local anim = cache.vehicle and anims[2] or anims[1]
        local isInAnim = IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3)
        if not isInAnim then
            TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
        end
    else
        ClearPedTasks(cache.ped)
    end
end

local function countdownRespawnTimer()
    print("starting timer")
    while RespawnTimer > 0 and PlayerIsDead do
        playDeathAnimation()
        lib.showTextUI(('Respawn in %s'):format(RespawnTimer))
        RespawnTimer -= 1
        Wait(1000)
        lib.hideTextUI()
        if not PlayerIsDead then RespawnTimer = 0 return end
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
                --[[                 repeat
                    Wait(100)
                until not canRespawn ]]
                hospitalBed()
                TriggerServerEvent('medical:revive')
                return
            else
                controlPressed = false
            end
        end
    end
end

local function setDead()
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
    exports.scully_emotemenu:SetExpression('dead_1')
    Wait(1000)
    if lib.progressActive() then
        lib.cancelProgress()
    end
end

local function playerDeath()
    initializeVariables()
    resetStatuses()
    exports.scully_emotemenu:ToggleLimitation(true)
    SetPlayerInvincible(cache.playerId, true)
    LoadAnimations()
    waitForRagdoll()
    setDead()
    countdownRespawnTimer()
    CreateThread(function()
        while PlayerIsDead and playerState.bedIndex == nil do playDeathAnimation() Wait(0) end
    end)
    CreateThread(function()
        checkForRespawn()
    end)
end

local function startDeathLoop()
    CreateThread(function()
        while PlayerIsLoaded do
            Wait(100)
            cache.ped = PlayerPedId()
            if not PlayerIsDead and IsPedDeadOrDying(cache.ped, true) then
                playerState:set('dead', true, true)
            end
        end
    end)
end

AddEventHandler('ox:playerLoaded', function(data)
    startDeathLoop()
end)

-- Support resource restart
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == cache.resource and cache.ped then
        SetEntityMaxHealth(cache.ped, 200)
        SetEntityHealth(cache.ped, 200)
        PlayerIsLoaded = true
        startDeathLoop()
    end
end)

AddStateBagChangeHandler('dead', 'player:' .. cache.serverId, function(bagName, key, value, _unused, replicated)
    if value == playerState.dead then return end
    if value == true then
        PlayerIsDead = true
        TriggerServerEvent('ox:playerDeath', true)
        print('triggering death')
        playerDeath()
    else
        PlayerIsDead = false
        TriggerServerEvent('ox:playerDeath', false)
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
    RegisterCommand('status', function()
        ShowStatus = not ShowStatus
    end)

    RegisterCommand('dropInv', function()
        dropInventory()
    end)
end