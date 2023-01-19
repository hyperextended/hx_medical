-- Outline:

local playerState = LocalPlayer.state
local respawnTimer = 10
local canRespawn

local anims = {
    { 'missfinale_c1@', 'lying_dead_player0' },
    { 'veh@low@front_ps@idle_duck', 'sit' },
    { 'dead', 'dead_a' },
}

Citizen.CreateThread(function()
    while true do
        Wait(200)
        print(GetGameplayCamRelativePitch())
    end
end)

-- Trigger event for player death
--     option to persist death

-- while dead loop ->
--     Disable most actions/keys
--     Set player anim to passout
--     Hold E display and counter
--     teleport to hospital - possibly vacant bed
--     config to optionally wipe inventory

local function revive(full)
    -- SetEntityMaxHealth(cache.ped, 200)
    if not PlayerIsDead then
        -- TriggerServerEvent('ox:playerDeath', false)
        SetEntityHealth(cache.ped, 100)
        ClearPedBloodDamage(cache.ped)
        if cache.vehicle then
            SetPedIntoVehicle(cache.ped, cache.vehicle, cache.seat)
        end
        ClearPedTasks(cache.ped)
        EnableAllControlActions(0)
        SetEntityInvincible(cache.ped, false)
        SetEveryoneIgnorePlayer(cache.playerId, false)
        CurrentHealth = 200
        PreviousHealth = 200
        canRespawn = false
        print('revive:', playerState.dead)
        SetEntityHealth(cache.ped, 200)
    end
end

local function death()
    Citizen.CreateThread(function()
        print('starting thread')

        -- main loop
        -- TriggerServerEvent('ox:playerDeath', true)

        while PlayerIsDead do

            for i = 1, #anims do
                lib.requestAnimDict(anims[i][1])
            end

            while GetEntitySpeed(cache.ped) > 0.5 or IsPedRagdoll(cache.ped) do
                Wait(100)
            end

            CurrentHealth = 100
            PreviousHealth = 100
            local coords = GetEntityCoords(cache.ped) --[[@as vector]]
            NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(cache.ped), false, false)
            SetEntityInvincible(cache.ped, true)
            SetEntityHealth(cache.ped, 100)
            respawnTimer = 10

            if cache.vehicle then
                SetPedIntoVehicle(cache.ped, cache.vehicle, cache.seat)
            end
            -- main loop
            Wait(200)
            -- print('running main loop')
            local anim = cache.vehicle and anims[2] or anims[1]

            -- sub loop
            while PlayerIsDead do

                TriggerEvent('ox_inventory:disarm')
                if not IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3) then
                    TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
                end
                SetEveryoneIgnorePlayer(cache.playerId, true)
                Wait(0)
                -- print('running sub loop')
                while respawnTimer > 0 do
                    anim = cache.vehicle and anims[2] or anims[1]
                    if not IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3) then
                        TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
                    end
                    lib.showTextUI(('Respawn in %s'):format(respawnTimer))
                    respawnTimer = respawnTimer - 1
                    Wait(1000)
                    lib.hideTextUI()
                    if not PlayerIsDead then return end
                end
                lib.showTextUI('[E] - Respawn')
                canRespawn = true
                while canRespawn do
                    Wait(0)
                    anim = cache.vehicle and anims[2] or anims[1]
                    if not IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3) then
                        TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
                    end
                    if IsControlJustReleased(2, 51) then
                        print('released E')
                        if lib.progressCircle({
                            duration = 2000,
                            position = 'bottom',
                            canCancel = true,
                            useWhileDead = true,
                            allowRagdoll = true,
                        }) then
                            -- playerState:set('dead', false)
                            lib.hideTextUI()
                            return playerState:set('dead', false)
                        else print('Do stuff when cancelled') end
                    end
                end
            end
        end
    end)
end

local function startDeathLoop()
    Citizen.CreateThread(function()
        while PlayerIsLoaded do
            Wait(500)
            -- print(LocalPlayer.state.dead)
            cache.ped = PlayerPedId()
            -- print('startDeathLoop', playerState.dead)
            if not playerState.dead and IsPedDeadOrDying(cache.ped, true) then
                playerState:set('dead', true)
            end
        end
    end)
end

AddEventHandler('ox:playerLoaded', function(data)
    PlayerIsLoaded = true
    startDeathLoop()
end)

AddStateBagChangeHandler('dead', 'player:' .. cache.serverId, function(bagName, key, value, _unused, replicated)
    -- if not replicated then return end
    -- print('entity:', bagName:gsub('entity:', ''))
    -- print('death triggered')
    if value == true then
        PlayerIsDead = true
        death()
    else
        PlayerIsDead = false
        revive(true)
    end
end)

RegisterCommand('kill', function()
    print(respawnTimer)
    playerState:set('dead', true)
    print('state:', playerState.dead)
end)

RegisterCommand('revive', function()
    playerState:set('dead', false)
    print('state:', playerState.dead)
end)

RegisterCommand('status', function()
    local statuses = lib.callback.await('ox:getStatus', 0, source)
    print(json.encode(statuses, { indent = true }))
end)
startDeathLoop()
