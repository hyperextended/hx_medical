-- To use smelling_salt go to your server.cfg and do setr medical:smellingsalt 1
if GetConvarInt('medical:smellingsalt', 0) ~= 1 then return end

local function wakePlayer(ped)
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
            dict = "amb@world_human_bum_wash@male@low@idle_a",
            clip = "idle_a",
            flag = 10
        }
    })
    then
        local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
        local done = lib.callback.await('medical:smellingsaltOnPlayer', 200, playerId)
        if done then
            
        end
    end
end

print("run")
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
            print(isUnconscious)
            if isUnconscious then
                return true
            end
        end,
        onSelect = function(data)
            wakePlayer(data.entity)
        end
    }
}

local optionNames = { 'ox:option1', 'ox:option2' }

exports.ox_target:addGlobalPlayer(options)