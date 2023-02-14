PlayerIsBleeding = false
local intensity = 0
local blurCounter = 0

local function blurScreen()
    Citizen.CreateThread(function()

        TriggerScreenblurFadeIn(1000.0)
        Wait(1000 * (intensity / 10))
        TriggerScreenblurFadeOut(1000.0)
        
    end)
end

local function bleed()
    local desaturation = 0

    while PlayerIsBleeding and not PlayerIsDead do

        if PlayerIsDead then return end

        local coords = GetEntityCoords(cache.ped)
        local forwardVector = GetEntityForwardVector(cache.ped)
        local tickTime = (110 - intensity) * 100
        local tickDamage = 1

        if desaturation <= 0.80 then desaturation += 0.02 end

        blurCounter += 1

        if blurCounter >= 5 then blurScreen() blurCounter = 0 end

        SetTimecycleModifier("rply_saturation_neg")
        SetTimecycleModifierStrength(desaturation)
        ApplyDamageToPed(cache.ped, tickDamage, false)
        ApplyPedBlood(cache.ped, 0, math.random(0, 4) + 0.0, math.random(-0, 4) + 0.0, math.random(-0, 4) + 0.0,'wound_sheet')

        Wait(tickTime)
    end
end


AddEventHandler('ox:statusTick', function(statuses)
    
    if PlayerIsDead or not statuses.bleed then return end

    if not PlayerIsBleeding and statuses.bleed > 25 then

        PlayerIsBleeding = true
        playerState:set('bleeding', true, true)
        intensity = statuses.bleed

        lib.notify({
            title = 'Status',
            duration = 3000,
            description = 'You are bleeding!',
            type = 'error'
        })

        bleed()

    elseif PlayerIsBleeding and statuses.bleed == 0 then

        PlayerIsBleeding = false
        playerState:set('bleeding', false, true)
        intensity = 0
        SetTimecycleModifierStrength(0)
        ClearTimecycleModifier()

    end

    intensity = statuses.bleed

    if PlayerIsBleeding then

      lib.notify({
            id = "medical_playerbleed",
            title = 'Medical',
            duration = 1000,
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
            TriggerServerEvent('medical:changeStatus', 'bleed', tonumber(args[1]) or 100)
        end
    end)

end