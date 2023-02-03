-- To use targeting go to your server.cfg and do setr medical:targeting 1
if GetConvarInt('medical:targeting', 0) ~= 1 then return end

local labels = {}
for _, v in pairs(exports.ox_inventory:Items()) do
    labels[v.name] = v.label
end

local saltAnim = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a"}
local bleedAnim = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a"}

local function curePlayer(ped, cureType, animTable, item)
    TaskTurnPedToFaceEntity(cache.ped, ped, -1)
    while not IsPedFacingPed(cache.ped, ped, 10) do
        Wait(200)
    end
    if lib.progressBar({
        duration = 2000,
        label = locale("using", item),
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

local items = {
    {
        name = "medical:stopBleed",
        items = {"bandage", "medikit", "clothing"},
        icon = "fa-solid fa-droplet",
        cureType = "bleed",
        animTable = bleedAnim
    },
    {
        name = "medical:stopUnconscious",
        items = {"smelling_salt"},
        icon = "fa-solid fa-icon",
        cureType = "unconscious",
        animTable = saltAnim
    }
}

for index, value in ipairs(items) do
    print(index, json.encode(value.item))
    for i = 1, #value.items do
        label = locale('target',labels[value.items[i]])
        exports.ox_target:addGlobalPlayer({
            {
                name = value.name,
                icon = value.icon,
                label = label,
                items = value.items[i],
                canInteract = function (entity)
                    local target = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                    local needsCure = Player(target).state[value.cureType]
                    if needsCure then return true end
                end,
                onSelect = function (data)
                    curePlayer(data.entity, value.cureType, value.animTable, value.items[i])
                end
            }
        }) 
    end
end