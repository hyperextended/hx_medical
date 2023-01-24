PlayerIsStaggered = false
local intensity = 100
local prevWalk = 'default'

local function canTrip(ped)
    if IsPedWalking(ped) or IsPedSwimming(ped) or IsPedClimbing(ped) or IsPedRagdoll(ped) or not IsPedOnFoot(ped) then return false
    elseif IsPedRunning(ped) or IsPedSprinting(ped) then return true else return false end
end

local function stagger(amount)
    prevWalk = exports.scully_emotemenu:GetCurrentWalk()
    PlayerIsStaggered = true
    while PlayerIsStaggered and (intensity > 0) do
        local ped = cache.ped
        local curWalk = exports.scully_emotemenu:GetCurrentWalk()
        local chance = math.random(100)
        print(curWalk)
        if curWalk ~= 'move_m@injured' then
            SetPedMoveRateOverride(cache.ped, 100 - (intensity / 5))
            SetPedMovementClipset(
                cache.ped,
                'move_injured_generic',
                0.85)
        end
        print(canTrip(ped), chance)
        if IsPedSprinting(ped) then chance = chance + 10 end
        if canTrip(ped) and chance > 95 then
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.1)
            SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        end
        Wait(1000)
    end
    print('restoring walk')
    exports.scully_emotemenu:SetWalk(prevWalk)
end

AddEventHandler('ox:statusTick', function(statuses)
    if PlayerIsDead or not statuses.stagger then return end
    if not PlayerIsStaggered then
        if statuses.stagger > 50 then
            intensity = statuses.stagger
            lib.notify({
                title = 'Medical',
                description = 'You are staggered!',
                type = 'error'
            })
            stagger(intensity)
        elseif statuses.stagger == 0 and PlayerIsStaggered then
            intensity = 0
            PlayerIsStaggered = false
        end
    else
        intensity = statuses.stagger
    end
end)

if GetConvar('medical:debug', 'false') == 'true' then
    RegisterCommand('stagger', function(source, args, rawCommand)
        TriggerServerEvent('medical:changeStatus', 'limping', tonumber(args[1]))
        stagger(args[1])
    end)
end
