PlayerInPrison = false
InBedDict = "anim@gangops@morgue@table@"
InBedAnim = "body_search"

local prison = lib.points.new(vec3(1691.02, 2601.022, 45.564), 190)

function prison:nearby()
    if not playerState.prison then playerState:set('prison', true, true) end
end

function prison:onExit()
    if playerState.prison then playerState:set('prison', false, true) end
end

local function countdownBedTimer()
    local bedTimer = 10
    while bedTimer > 0 do
        lib.showTextUI(('Respawn in %s'):format(bedTimer))
        bedTimer -= 1
        Wait(1000)
        lib.hideTextUI()
    end
end

local function leaveBed(bed)
    local ped = cache.ped
    local getOutDict = 'switch@franklin@bed'
    local getOutAnim = 'sleep_getup_rubeyes'
    lib.requestAnimDict(getOutDict)
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)
    SetEntityHeading(ped, bed.coords.w + 90)
    TaskPlayAnim(ped, getOutDict, getOutAnim, 100.0, 1.0, -1, 8, -1, false, false, false)
    Wait(4000)
    ClearPedTasks(ped)
    local bedObject = GetClosestObjectOfType(bed.coords.x, bed.coords.y, bed.coords.z,
        1.0, bed.model, false, false, false)
    FreezeEntityPosition(bedObject, true)
    TriggerServerEvent('medical:releaseBed')
end

local function wakeUpListener(bed)
    lib.showTextUI('[E] to Get Up')
    local canGetUp = true
    while canGetUp do
        Wait(0)
        if not canGetUp then
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
                canGetUp = false
                lib.hideTextUI()
                leaveBed(bed)
                return
            else
                controlPressed = false
            end
        end
    end
end

local function keepInBed(bed)
    IsInHospitalBed = true
    CanLeaveBed = false
    local player = cache.ped
    if IsPedDeadOrDying(player) then
        local pos = GetEntityCoords(player, true)
        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
    end
    local bedObject = GetClosestObjectOfType(bed.coords.x, bed.coords.y, bed.coords.z,
        1.0, bed.model, false, false, false)
    FreezeEntityPosition(bedObject, true)
    SetEntityCoords(player, bed.coords.x, bed.coords.y, bed.coords.z + 0.02)
    Wait(500)
    FreezeEntityPosition(player, true)
    lib.requestAnimDict(InBedDict)
    TaskPlayAnim(player, InBedDict, InBedAnim, 8.0, 1.0, -1, 1, 0, false, false, false)
    SetEntityHeading(player, bed.coords.w)
    local heading = GetEntityHeading(player)
    heading = (heading > 180) and heading - 180 or heading + 180
    DoScreenFadeIn(1000)
    Wait(1000)
    FreezeEntityPosition(player, true)
    countdownBedTimer()
    wakeUpListener(bed)
end

local function teleportBed(coords)
    DoScreenFadeOut(1000)
    while not IsScreenFadedOut() do Wait(100) end
    SetEntityCoords(cache.ped, coords.x, coords.y, coords.z)
    SetEntityHeading(cache.ped, coords.w)
end

function hospitalBed()
    local bed = lib.callback.await('medical:getBed', false)
    if bed ~= nil then
        teleportBed(bed.coords)
        keepInBed(bed)
    end
end

-- RegisterCommand('findbed', function()
--     local bed, index = lib.callback.await('medical:getBed', false)
--     print(json.encode(bed), index, LocalPlayer.state.bedIndex)
--     Wait(2500)
--     print(LocalPlayer.state.bedIndex)
--     -- TriggerServerEvent('medical:releaseBed', LocalPlayer.state.bedIndex)
-- end)

-- RegisterCommand('releasebed', function()
--     TriggerServerEvent('medical:releaseBed', LocalPlayer.state.bedIndex)
--     Wait(1000)
--     print(LocalPlayer.state.bedIndex)
-- end)

AddEventHandler('ox:playerLogout', function()
    TriggerServerEvent('medical:releaseBed', LocalPlayer.state.bedIndex)
end)
