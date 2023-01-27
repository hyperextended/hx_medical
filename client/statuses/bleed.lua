PlayerIsBleeding = false
local intensity = 0

local function bleed()
    while PlayerIsBleeding do
        local tickTime = (110 - intensity) * 100
        local tickDamage = 1
        SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) - tickDamage)
        Wait(tickTime)
    end
end

AddEventHandler('ox:statusTick', function(statuses)
    if PlayerIsDead or not statuses.bleed then return end
    if not PlayerIsBleeding and statuses.bleed > 25 then
        PlayerIsBleeding = true
        lib.notify({
            title = 'Medical',
            description = 'You are bleeding!',
            type = 'error'
        })
        intensity = statuses.bleed
        bleed()
    elseif PlayerIsBleeding and statuses.bleed == 0 then
        intensity = 0
        PlayerIsBleeding = false
    end
    intensity = statuses.bleed
end)

if GetConvarInt('medical:debug', 0) == 1 then
    RegisterCommand('bleed', function(source, args, rawCommand)
        if intensity > 0 then
            TriggerServerEvent('medical:changeStatus', 'bleed', 0)
        else
            TriggerServerEvent('medical:changeStatus', 'bleed', tonumber(args[1]))
        end
        bleed(args[1])
    end)
end
