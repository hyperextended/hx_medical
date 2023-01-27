PlayerIsUnconscious = false
local timer = 0
local anims = {
    { 'missfinale_c1@', 'lying_dead_player0' },
    { 'veh@low@front_ps@idle_duck', 'sit' },
    { 'dead', 'dead_a' },
}

local function playUnconsciousAnimation()
    local anim = cache.vehicle and anims[2] or anims[1]
    if not IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3) then
        TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
    end
    Wait(500)
end

local function resetUnconscious()
    SetPedCanRagdoll(cache.ped, true)
    PlayerIsUnconscious = false
    EnableAllControlActions(0)
    ClearPedTasks(cache.ped)
    SetPedToRagdoll(cache.ped, 2500, 1, 2)
    exports.scully_emotemenu:ResetExpression(false)
    timer = 0
    TriggerServerEvent('medical:changeStatus', 'unconscious', 0, 'set')
end

local function knockout(timer)
    if PlayerIsUnconscious then
        Citizen.CreateThread(function()
            SetPedCanRagdoll(cache.ped, false)
            DisableAllControlActions(0)
            exports.scully_emotemenu:ToggleLimitation(true)
            exports.scully_emotemenu:SetExpression('dead_1')
            LoadAnimations()
            if IsPedRagdoll(cache.ped) then
                ClearPedTasksImmediately(cache.ped)
            end
            while not PlayerIsDead and PlayerIsUnconscious do
                playUnconsciousAnimation()
            end
        end)
        Wait(500)
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
            resetUnconscious()
        end
    end
end

AddEventHandler('ox:statusTick', function(statuses)
    if PlayerIsDead or not statuses.unconscious then return end
    if not PlayerIsUnconscious then
        if statuses.unconscious > 5 then
            PlayerIsUnconscious = true
            lib.notify({
                title = 'Medical',
                description = 'You are unconscious!',
                type = 'error'
            })
            timer = statuses.unconscious
            knockout(timer)
        end
    end
    timer = statuses.unconscious
end)

if GetConvarInt('medical:debug', 0) == 1 then
    RegisterCommand('unconscious', function(source, args, rawCommand)
        if timer > 5 then
            TriggerServerEvent('medical:changeStatus', 'unconscious', 0)
        else
            TriggerServerEvent('medical:changeStatus', 'unconscious', tonumber(args[1]))
        end
    end)
end
