PlayerIsUnconscious = false
local timer = 0
local anims = {
    { 'missfinale_c1@', 'lying_dead_player0' },
    { 'veh@low@front_ps@idle_duck', 'sit' },
    { 'dead', 'dead_a' },
}

local function resetUnconscious()
    if lib.progressActive() then
        lib.cancelProgress()
    end
    SetPedCanRagdoll(cache.ped, true)
    PlayerIsUnconscious = false
    LocalPlayer.state:set('unconscious', false, true)
    EnableAllControlActions(0)
    ClearPedTasks(cache.ped)
    SetPedToRagdoll(cache.ped, 2500, 1, 2)
    exports.scully_emotemenu:ResetExpression()
    exports.scully_emotemenu:ToggleLimitation(false)
    timer = 0
    PlayerIsUnconscious = false
end

local function playUnconsciousAnimation()
    local anim = cache.vehicle and anims[2] or anims[1]
    if not IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3) then
        TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
    end
end

local function countdownUnconsciousTimer(timer)
    print(timer)
    while timer > 0 and PlayerIsUnconscious do
        playUnconsciousAnimation()
        lib.showTextUI(('Unconscious - %s'):format(timer))
        timer = timer - 1
        Wait(1000)
        lib.hideTextUI()
        if not PlayerIsDead or not PlayerIsUnconscious then resetUnconscious() return end
    end
    return true
end

local function knockout(timer)
    if PlayerIsDead then return end
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
                Wait(100)
            end
        end)

        Wait(500)
        if lib.progressCircle({
            duration = timer * 1000,
            label = 'unconscious',
            useWhileDead = true,
            allowRagdoll = true,
            allowCuffed = true,
            allowFalling = true,
            canCancel = false,
        })
        then
            TriggerServerEvent('medical:changeStatus', 'unconscious', 0)
        end
    end
end

AddEventHandler('ox:statusTick', function(statuses)
    if PlayerIsDead or not statuses.unconscious then return end
    if not PlayerIsUnconscious then
        if statuses.unconscious > 5 then
            PlayerIsUnconscious = true
            LocalPlayer.state:set('unconscious', true, true)
            lib.notify({
                title = 'Medical',
                description = 'You are unconscious!',
                type = 'error'
            })
            timer = statuses.unconscious
            knockout(timer)
        end
    elseif PlayerIsUnconscious and statuses.unconscious == 0 then
        resetUnconscious()
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
