PlayerIsStaggered = false
local intensity = 100
local prevWalk

local walkAnim

local function canTrip(ped)
    if IsPedWalking(ped) or IsPedSwimming(ped) or IsPedClimbing(ped) or IsPedRagdoll(ped) or not IsPedOnFoot(ped) then
        return false
    elseif IsPedRunning(ped) or IsPedSprinting(ped) then
        return true
    else
        return false
    end
end

local function stagger()
    prevWalk = exports.scully_emotemenu:getCurrentWalk()
    while PlayerIsStaggered do
        local curWalk = exports.scully_emotemenu:getCurrentWalk()
        local chance = math.random(100)
        if curWalk ~= walkAnim then
            exports.scully_emotemenu:setWalk(walkAnim)
        end
        SetPedMoveRateOverride(cache.ped, 100 - (intensity / 5))
        if canTrip(cache.ped) and chance > 95 then
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
            SetPedToRagdollWithFall(cache.ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                0.0)
        end
        Wait(1000)
    end
    if prevWalk ~= 'default' then
        exports.scully_emotemenu:setWalk(prevWalk)
    else
        exports.scully_emotemenu:resetWalk()
    end
    walkAnim = nil
end


local function MaleFemale()
    if player.gender == 'female' then
        walkAnim = 'move_f@injured'
    else
        walkAnim = 'move_m@injured'
    end
end

AddEventHandler('ox:statusTick', function(statuses)
    if walkAnim == nil then
        MaleFemale()
    end
    if PlayerIsDead or not statuses.stagger then return end
    if not PlayerIsStaggered and statuses.stagger > 0 then
        PlayerIsStaggered = true
        stagger()
    elseif PlayerIsStaggered and statuses.stagger == 0 then
        PlayerIsStaggered = false
    end
    intensity = statuses.stagger
end)
