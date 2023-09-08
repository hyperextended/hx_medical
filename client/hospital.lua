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
    local bedTimer = 2
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
    TriggerServerEvent('medical:releaseBed', LocalPlayer.state.bedIndex)
    Wait(1000)
    print(LocalPlayer.state.bedIndex)
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
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    SetEntityCoordsNoOffset(cache.ped, coords.x, coords.y, coords.z)
    SetEntityHeading(cache.ped, coords.w)
    FreezeEntityPosition(cache.ped, true)
    while not HasCollisionLoadedAroundEntity(cache.ped) do Wait(0) end
    FreezeEntityPosition(cache.ped, false)
end

function hospitalBed()
    local bed = lib.callback.await('medical:getBed', false)
    if bed ~= nil then
        teleportBed(bed.coords)
        keepInBed(bed)
    end
end

RegisterNetEvent('medical:selfService', function()
    -- lib.requestAnimDict('code_human_wander_clipboard', 200)
    local isDead = playerState.dead
    local anim = {}
    if not isDead then
        anim = {
            dict = 'missfam4',
            clip = 'base',
        }
    end

    if lib.progressBar({
            duration = 10000,
            label = 'Receiving treatment',
            useWhileDead = true,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = anim,
            prop = {
                model = `p_amb_clipboard_01`,
                bone = 36029,
                pos = vec3(0.160000, 0.080000, 0.100000),
                rot = vec3(-130.000000, -50.000000, 0.000000)
            },
        }) then
        lib.notify({
            title = 'You feel better!',
            description = 'All your wounds have been healed!',
            type = 'success'
        })
        if not playerState.dead then
            local statuses = { 'hunger', 'thirst', 'stagger', 'unconscious', 'bleed', 'stress' }
            for i = 1, #statuses do
                -- print(statuses[i])
                TriggerServerEvent('medical:changeStatus', statuses[i], 0)
            end
            SetEntityHealth(cache.ped, 200)
        else
            playerState:set('dead', false, true)
        end
    else
        lib.notify({
            title = 'Cancelled',
            description = 'You cancelled treatment!',
            type = 'error'
        })
    end
    SetEntityHealth(cache.ped, 200)
end)

exports.ox_target:addSphereZone({
    coords = vec3(308.3, -595.985, 43.364),
    radius = 1.5,
    debug = false,
    options = {
        {
            name = 'self-service-sphere',
            event = 'medical:selfService',
            icon = 'fa-solid fa-circle',
            label = 'Request Treatment',
        }
    }
})

AddEventHandler('ox:playerLogout', function()
    TriggerServerEvent('medical:releaseBed', LocalPlayer.state.bedIndex)
end)
