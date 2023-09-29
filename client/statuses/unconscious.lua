PlayerIsUnconscious = false
local timer = 0
local anims = {
    { 'missfinale_c1@',             'lying_dead_player0' },
    { 'veh@low@front_ps@idle_duck', 'sit' },
    { 'dead',                       'dead_a' },
}

local function resetUnconscious()
    if lib.progressActive() then
        lib.cancelProgress()
    end
    LocalPlayer.state.invBusy = false
    SetPedCanRagdoll(cache.ped, true)
    PlayerIsUnconscious = false
    LocalPlayer.state:set('unconscious', false, true)
    EnableAllControlActions(0)
    ClearPedTasks(cache.ped)
    SetPedToRagdoll(cache.ped, 2500, 1, 2)
    exports.scully_emotemenu:resetExpression()
    exports.scully_emotemenu:setLimitation(false)
    timer = 0
    PlayerIsUnconscious = false
end

RegisterNetEvent('medical:wakeUp', function()
    lib.hideTextUI()
    resetUnconscious()
end)

local function playUnconsciousAnimation()
    local anim = cache.vehicle and anims[2] or anims[1]
    if not IsEntityPlayingAnim(cache.ped, anim[1], anim[2], 3) then
        TaskPlayAnim(cache.ped, anim[1], anim[2], 50.0, 8.0, -1, 1, 1.0, false, false, false)
    end
end

local function countdownUnconsciousTimer(timer)
    -- while timer > 0 and PlayerIsUnconscious do
    playUnconsciousAnimation()
    lib.hideTextUI()
    local timer = math.floor(timer)
    lib.showTextUI(('Unconscious - %s'):format(timer))
    if PlayerIsDead then
        lib.hideTextUI()
        resetUnconscious()
        return
    end
    if timer < 1 then PlayerIsUnconscious = false end
    return true
end

local function checkForWakeUp()
    lib.showTextUI('[E] - Get up')
    local canWakeUp = true
    while canWakeUp and not PlayerIsDead do
        playUnconsciousAnimation()
        Wait(0)
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
                resetUnconscious()
                return
            else
                -- controlPressed = false
            end
        end
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
local function knockout(startingTimer)
    if PlayerIsDead then return end
    if PlayerIsUnconscious then
        LocalPlayer.state.invBusy = true
        CreateThread(function()
            SetPedCanRagdoll(cache.ped, false)
            DisableAllControlActions(0)
            exports.scully_emotemenu:setLimitation(true)
            exports.scully_emotemenu:setExpression('dead_1')
            LoadAnimations()
            waitForRagdoll()
            if IsPedRagdoll(cache.ped) then
                ClearPedTasksImmediately(cache.ped)
            end
            while not PlayerIsDead and PlayerIsUnconscious do
                playUnconsciousAnimation()
                Wait(100)
            end
        end)

        while not PlayerIsDead and PlayerIsUnconscious do
            Wait(1000)
            countdownUnconsciousTimer(timer)
        end
        Wait(500)
        checkForWakeUp()
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
        -- resetUnconscious()
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
