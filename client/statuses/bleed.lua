PlayerIsBleeding = false
local intensity = 0
local function bleed(amount)
    local tickDamage = math.ceil(intensity / 15)
    SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) - 1)
end

AddEventHandler('ox:statusTick', function(statuses)
    if PlayerIsDead or not statuses.bleed then return end
    if not PlayerIsBleeding then
        if statuses.bleed > 25 then
            intensity = statuses.bleed
            lib.notify({
                title = 'Medical',
                description = 'You are bleeding!',
                type = 'error'
            })
            bleed(intensity)
        elseif statuses.bleed == 0 and PlayerIsBleeding then
            intensity = 0
            PlayerIsBleeding = false
        end
    else
        intensity = statuses.bleed
    end
end)

if GetConvar('medical:debug', 'false') == 'true' then
    RegisterCommand('bleed', function(source, args, rawCommand)
        TriggerServerEvent('medical:changeStatus', 'limping', tonumber(args[1]))
        bleed(args[1])
    end)
end
