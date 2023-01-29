PlayerIsBleeding = false
local intensity = 0

local function bleed()
    while PlayerIsBleeding do
        local tickTime = (110 - intensity) * 100
        local tickDamage = 1
        SetTimecycleModifier("glasses_red") -- might not needed if notification is not stuck on screen
        SetTimecycleModifierStrength(intensity / 100) -- might crash the game idk need more test
        SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) - tickDamage)
        Wait(tickTime)
    end
end

AddEventHandler('ox:statusTick', function(statuses)
    if PlayerIsDead or not statuses.bleed then return end
    if not PlayerIsBleeding and statuses.bleed > 25 then
        PlayerIsBleeding = true
        intensity = statuses.bleed

        bleed()
    elseif PlayerIsBleeding and statuses.bleed == 0 then
        PlayerIsBleeding = false
        intensity = 0
        ClearTimecycleModifier()
    end
    intensity = statuses.bleed
    if PlayerIsBleeding then
        lib.notify({
            id = "1",
            title = 'Status',
            duration = 3000,
            description = 'You are bleeding!',
            type = 'error'
        })
    end
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
