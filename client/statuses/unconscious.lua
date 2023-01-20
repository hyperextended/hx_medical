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
        while PlayerIsUnconscious == true do
            anim = cache.vehicle and anims[2] or anims[1]
            if not IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3) then
                TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
            end
            Wait(500)
        end
    end)
    local timer = 10
    -- Countdown timer
    if lib.progressCircle({
        duration = timer * 1000,
        label = 'unconscious',
        allowRagDoll = true,
        allowCuffed = true,
        allowFalling = true,
        canCancel = false,
        disable = {
            move = true,
            car = true,
            combat = true
        }
    })
    then
        print('setting uncon false')
        PlayerIsUnconscious = false
        EnableAllControlActions(0)
        ClearPedTasks(cache.ped)
        SetPedToRagdoll(cache.ped, 2500, 1, 2)
        TriggerServerEvent('medical:changeStatus', 'unconscious', 25)
        exports.scully_emotemenu:SetExpression(expression)
    end
end

AddEventHandler('ox:statusTick', function(statuses)
    if PlayerIsDead then return end
    if not PlayerIsUnconscious then
        if statuses.unconscious > 90 then
            PlayerIsUnconscious = true
            knockout()
        end
    end
end)

RegisterCommand('unconscious', function(source, args, rawCommand)
    TriggerServerEvent('medical:changeStatus', 'unconscious', tonumber(args[1]))
end)
