-- To use smelling_salt go to your server.cfg and do setr medical:smellingsalt 1
if GetConvarInt('medical:smellingsalt', 0) ~= 1 then return end

local saltAnim = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a"}
local bleedAnim = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a"}

local function curePlayer(ped, cureType, animTable)
    TaskTurnPedToFaceEntity(cache.ped, ped, -1)
    while not IsPedFacingPed(cache.ped, ped, 10) do
        Wait(200)
    end
    if lib.progressBar({
        duration = 2000,
        label = 'Using Smelling Salt',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            dict = animTable[1],
            clip = animTable[2],
            flag = 10
        }
    })
    then
        local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
        local done = lib.callback.await('medical:curePlayer', 200, playerId, cureType)
        if done then return end
    end
end

local options = {
    {
        name = "medical:smelling_salt",
        icon = "fa-solid fa-handshake-angle",
        label = "Use Smelling Salt",
        distance = 1,
        items = "smelling_salt",
        canInteract = function(entity)
            local target = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local isUnconscious = Player(target).state.unconscious
            if isUnconscious then
                return true
            end
        end,
        onSelect = function(data)
            curePlayer(data.entity, 'unconscious', saltAnim)
        end
    },
    {
        name = "medical:bleeding_stop",
        icon = "fa-solid fa-handshake-angle",
        label = "Use Bandage",
        distance = 1,
        items = "bandage",
        canInteract = function(entity)
            local target = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
            local isBleeding = Player(target).state.bleed
            if isBleeding then
                return true
            end
        end,
        onSelect = function(data)
            curePlayer(data.entity, 'bleed', bleedAnim)
        end
    },
}

local optionNames = { 'ox:option1', 'ox:option2' }

exports.ox_target:addGlobalPlayer(options)