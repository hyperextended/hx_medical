-- Unconscious
-- run loop lock player out of controls, and set to passout animation
PlayerIsUnconscious = false

local function knockout()
    -- lock user in animation'
    local expression = exports.scully_emotemenu:GetCurrentExpression()
    Citizen.CreateThread(function()
        DisableAllControlActions(0)
        exports.scully_emotemenu:SetExpression('dead_1')
        for i = 1, #anims do
            lib.requestAnimDict(anims[i][1])
        end
        local anim = cache.vehicle and anims[2] or anims[1]
        if IsPedRagdoll(cache.ped) then
            local coords = GetEntityCoords(cache.ped)
            -- SetPedCanRagdoll(cache.ped, false)
            ClearPedTasksImmediately(cache.ped)
            -- SetEntityCoordsNoOffset(cache.ped, coords.x, coords.y, coords.z)
        end
        while not PlayerIsDead and PlayerIsUnconscious do
            print('not PlayerIsDead and PlayerIsUnconscious')
            anim = cache.vehicle and anims[2] or anims[1]
            if not IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3) then
                TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
            end
            Wait(500)
        end
    end)
    local timer = 10
    Wait(500)
    print('starting progress circle')
    if lib.progressCircle({
        duration = timer * 1000,
        label = 'unconscious',
        useWhileDead = true,
        allowRagDoll = true,
        allowCuffed = true,
        allowFalling = true,
        canCancel = false,
    })
    then
        SetPedCanRagdoll(cache.ped, true)
        SetEntityInvincible(cache.ped, false)
        PlayerIsUnconscious = false
        EnableAllControlActions(0)
        ClearPedTasks(cache.ped)
        SetPedToRagdoll(cache.ped, 2500, 1, 2)
        TriggerServerEvent('medical:changeStatus', 'unconscious', 25)
        exports.scully_emotemenu:SetExpression(expression)
    end
end

AddEventHandler('ox:statusTick', function(statuses)
    if PlayerIsDead or not statuses.unconscious then return end
    -- print(statuses.unconscious, PlayerIsUnconscious, PlayerIsDead)
    if not PlayerIsUnconscious then
        if statuses.unconscious > 50 then
            PlayerIsUnconscious = true
            lib.notify({
                title = 'Medical',
                description = 'You are unconscious!',
                type = 'error'
            })
            knockout()
        end
    end
end)

if GetConvar('medical:debug', 'false') == 'true' then
    RegisterCommand('unconscious', function(source, args, rawCommand)
        TriggerServerEvent('medical:changeStatus', 'unconscious', tonumber(args[1]))
    end)
end
