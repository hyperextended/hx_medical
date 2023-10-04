PlayerIsBleeding = false
local intensity = 0
local blurCounter = 0

RegisterNetEvent('medical:clearBlurEffect', function()
    TriggerScreenblurFadeOut(1)
end)

RegisterNetEvent('medical:clearBleedEffect', function()
    PlayerIsBleeding = false
    intensity = 0
    blurCounter = 0
    SetTimecycleModifier("default")
    SetTimecycleModifierStrength(0.0)
end)

local function blurScreen()
    CreateThread(function()
        TriggerScreenblurFadeIn(1500.0)
        Wait(1000 * (intensity / 10))
        TriggerScreenblurFadeOut(1500.0)
    end)
end

local function bleed()
    local desaturation = 0

    while PlayerIsBleeding and not PlayerIsDead do
        if PlayerIsDead then return end

        local tickTime = (110 - intensity) * 100
        local tickDamage = 1
        local desatTick = intensity / 20000

        if desaturation <= 0.80 then desaturation += desatTick end

        blurCounter += 1

        if blurCounter == 2 then
            lib.notify({
                title = 'Status',
                duration = 3000,
                description = 'You are bleeding!',
                type = 'error'
            })
        end

        if blurCounter >= 10 then
            blurScreen()
            blurCounter = 0
        end

        SetTimecycleModifier("rply_saturation_neg")
        SetTimecycleModifierStrength(desaturation)

        ApplyDamageToPed(cache.ped, tickDamage, false)
        ApplyPedBlood(cache.ped, 0, math.random(0, 4) + 0.0, math.random(-0, 4) + 0.0, math.random(-0, 4) + 0.0,
            'wound_sheet')

        Wait(tickTime)
    end
end


AddEventHandler('ox:statusTick', function(statuses)
    if PlayerIsDead or not statuses.bleed or not PlayerIsLoaded then return end
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
        intensity = 0
        TriggerEvent('clearBleedEffect')
        PlayerIsBleeding = false
        playerState:set('bleeding', false, true)
    end
    intensity = statuses.bleed
end)

AddEventHandler('ox:playerLogout', function()
    playerState:set('bleeding', false, true)
    intensity = 0
    TriggerEvent('medical:clearBleedEffect')
    TriggerEvent('medical:clearBlurEffect')
    PlayerIsBleeding = false
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
