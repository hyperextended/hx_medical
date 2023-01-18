-- Outline:
local PlayerIsLoaded = true
local playerState = LocalPlayer.state
local anims = {
    { 'missfinale_c1@', 'lying_dead_player0' },
    { 'veh@low@front_ps@idle_duck', 'sit' },
    { 'dead', 'dead_a' },
}

playerState:set('dead', false)
-- Trigger event for player death
--     option to persist death

-- while dead loop ->
--     Disable most actions/keys
--     Set player anim to passout
--     Hold E display and counter
--     teleport to hospital - possibly vacant bed
--     config to optionally wipe inventory

local function revive(full)
    -- playerState:set('dead', false)
    SetEntityMaxHealth(cache.ped, 200)
    SetEntityHealth(cache.ped, 200)
    ClearPedBloodDamage(cache.ped)
    if cache.vehicle then
        SetPedIntoVehicle(cache.ped, cache.vehicle, cache.seat)
    end
    ClearPedTasks(cache.ped)
    EnableAllControlActions(0)
    SetEntityInvincible(cache.ped, false)
    SetEveryoneIgnorePlayer(cache.playerId, false)
    TriggerServerEvent('ox:playerDeath', false)
    playerState:set('health', GetEntityHealth(cache.ped))
    playerState:set('canRespawn', false)
end

local function death()
    Citizen.CreateThread(function()
        print('starting thread')

        -- main loop
        while LocalPlayer.state.dead do


            for i = 1, #anims do
                lib.requestAnimDict(anims[i][1])
            end
            while GetEntitySpeed(cache.ped) > 0.5 or IsPedRagdoll(cache.ped) do
                Wait(100)
            end
            local coords = GetEntityCoords(cache.ped) --[[@as vector]]
            NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(cache.ped), false, false)
            SetEntityInvincible(cache.ped, true)
            SetEntityHealth(cache.ped, 100)
            playerState:set('health', 0)
            playerState:set('deathTimer', 10)
            TriggerEvent('ox_inventory:disarm')
            TriggerServerEvent('ox:playerDeath', true)
            if cache.vehicle then
                SetPedIntoVehicle(cache.ped, cache.vehicle, cache.seat)
            end
            -- main loop
            Wait(200)
            -- print('running main loop')
            local anim = cache.vehicle and anims[2] or anims[1]

            -- sub loop
            while LocalPlayer.state.dead do


                if not IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3) then
                    TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
                end
                SetEveryoneIgnorePlayer(cache.playerId, true)
                Wait(0)
                -- print('running sub loop')
                while playerState.deathTimer > 0 do
                    anim = cache.vehicle and anims[2] or anims[1]
                    if not IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3) then
                        TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
                    end
                    lib.showTextUI(('Respawn in %s'):format(LocalPlayer.state.deathTimer))
                    playerState:set('deathTimer', LocalPlayer.state.deathTimer - 1)
                    Wait(1000)
                    lib.hideTextUI()
                    if not playerState.dead then return end
                end
                lib.showTextUI('[E] - Respawn')
                playerState:set('canRespawn', true)
                while playerState.canRespawn do
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
                            playerState:set('dead', false)
                            lib.hideTextUI()
                            return revive(true)
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

AddStateBagChangeHandler('dead', nil, function(bagName, key, value, _unused, replicated)
    -- if not replicated then return end
    -- print('entity:', bagName:gsub('entity:', ''))
    -- print('death triggered')
    if value then
        death()
    else
        TriggerServerEvent('ox:playerDeath', false)
        revive(true)
    end
end)

RegisterCommand('kill', function()
    print(LocalPlayer.state.deathTimer)
    playerState:set('dead', true)
end)

RegisterCommand('revive', function()
    playerState:set('dead', false)
    lib.hideTextUI()
    revive(full)
end)

RegisterCommand('status', function()
    local statuses = lib.callback.await('ox:getStatus', 0, source)
    print(json.encode(statuses, { indent = true }))
end)
startDeathLoop()
