playerState = LocalPlayer.state
PlayerIsLoaded = true
PlayerIsDead = false
PlayerCanRespawn = false
CurrentHealth = 0
PreviousHealth = CurrentHealth
anims = {
    { 'missfinale_c1@', 'lying_dead_player0' },
    { 'veh@low@front_ps@idle_duck', 'sit' },
    { 'dead', 'dead_a' },
}


GetEntityHealth(cache.ped)
AddEventHandler('ox:playerLoaded', function(data)
    GetPedMaxHealth(cache.ped)
    GetEntityMaxHealth(cache.ped)
    PlayerIsLoaded = true
    SetPedMaxHealth(cache.ped, 200)
    SetEntityMaxHealth(cache.ped, 200)
    CurrentHealth = GetEntityHealth(cache.ped)
end)

SetEntityMaxHealth(cache.ped, 200)
CurrentHealth = GetEntityHealth(cache.ped)
-- Outline:

-- Damange event handler
-- decide when to trigger death / wounding

-- Player revival

-- Player healing
-- Exports for medical items

-- Player woudning removal
-- used these tables to form damageTypes
-- local Melee = { -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466 }
-- local Knife = { -1716189206, 1223143800, -1955384325, -1833087301, 910830060, }
-- local Bullet = { 453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547,
--     -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529,
--     205991906, 1119849093 }
-- local Animal = { -100946242, 148160082 }
-- local FallDamage = { -842959696 }
-- local Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745,
--     -37975472, 539292904, 341774354, -1090665087 }
-- local Gas = { -1600701090 }
-- local Burn = { 615608432, 883325847, -544306709 }
-- local Drown = { -10959621, 1936677264 }
-- local Car = { 133987706, -1553120962 }
local damageTypes = {
    [-1569615261] = "Melee",
    [1737195953] = "Melee",
    [1317494643] = "Melee",
    [-1786099057] = "Melee",
    [1141786504] = "Melee",
    [-2067956739] = "Melee",
    [-868994466] = "Melee",
    [-1716189206] = "Knife",
    [1223143800] = "Knife",
    [-1955384325] = "Knife",
    [-1833087301] = "Knife",
    [910830060] = "Knife",
    [453432689] = "Bullet",
    [1593441988] = "Bullet",
    [584646201] = "Bullet",
    [-1716589765] = "Bullet",
    [324215364] = "Bullet",
    [736523883] = "Bullet",
    [-270015777] = "Bullet",
    [-1074790547] = "Bullet",
    [-2084633992] = "Bullet",
    [-1357824103] = "Bullet",
    [-1660422300] = "Bullet",
    [2144741730] = "Bullet",
    [487013001] = "Bullet",
    [2017895192] = "Bullet",
    [-494615257] = "Bullet",
    [-1654528753] = "Bullet",
    [100416529] = "Bullet",
    [205991906] = "Bullet",
    [1119849093] = "Bullet",
    [-100946242] = "Animal",
    [148160082] = "Animal",
    [-842959696] = "FallDamage",
    [-1568386805] = "Explosion",
    [1305664598] = "Explosion",
    [-1312131151] = "Explosion",
    [375527679] = "Explosion",
    [324506233] = "Explosion",
    [1752584910] = "Explosion",
    [-1813897027] = "Explosion",
    [741814745] = "Explosion",
    [-37975472] = "Explosion",
    [539292904] = "Explosion",
    [341774354] = "Explosion",
    [-1090665087] = "Explosion",
    [-1600701090] = "Gas",
    [615608432] = "Burn",
    [883325847] = "Burn",
    [-544306709] = "Burn",
    [-10959621] = "Drown",
    [1936677264] = "Drown",
    [133987706] = "Car",
    [-1553120962] = "Car",
}

-- local damages = { Melee, Knife, Bullet, Animal, FallDamage, Explosion, Gas, Burn, Drown, Car }
-- local damageNames = { 'Melee', 'Knife', 'Bullet', 'Animal', 'FallDamage', 'Explosion', 'Gas', 'Burn', 'Drown', 'Car' }
-- for i = 1, #damages do
--     for k = 1, #damages[i] do
--         -- print(damageNames[i], damages[i][k])
--         print(('[%s] = "%s",'):format(damages[i][k], damageNames[i]))
--     end
-- end

Citizen.CreateThread(function()
    while true do
        PreviousHealth = CurrentHealth
        CurrentHealth = GetEntityHealth(cache.ped)
        Wait(200)
        if CurrentHealth < 126 then
            SetEntityHealth(cache.ped, 150)
        end
    end
end)

AddEventHandler('gameEventTriggered', function(event, data)
    local victim, attacker, fatal, weapon = data[1], data[2], data[4], data[7]
    if event ~= "CEventNetworkEntityDamage" then return end
    if victim ~= cache.ped then return end
    CurrentHealth = GetEntityHealth(cache.ped)
    -- print(json.encode(data, { indent = true }))
    local damageTaken = PreviousHealth - CurrentHealth
    if IsPedDeadOrDying(cache.ped) then
        if damageTypes[weapon] == "Car" or damageTypes[weapon] == 'FallDamage' or damageTypes[weapon] == 'Melee' then
            playerState:set('dead', false)
        end
        print(('Killed by %s.'):format(damageTypes[weapon]))
        return
    else
        print(('Damaged by %s.'):format(damageTypes[weapon]))
    end
    if damageTypes[weapon] == "Car" or damageTypes[weapon] == 'FallDamage' or damageTypes[weapon] == 'Melee' then
        print('blunted', damageTaken)
        if damageTaken >= 12 then
            print('knockout')
            TriggerServerEvent('medical:changeStatus', 'unconscious', 10, set)
        end
    end


    print(CurrentHealth, PreviousHealth)
    print('Health:', GetEntityHealth(cache.ped), 'Damage taken:', PreviousHealth - CurrentHealth)
    if PreviousHealth - CurrentHealth >= 25 then
        print('took 25 damage or greater to', GetPedLastDamageBone(cache.ped))
    end

    PreviousHealth = CurrentHealth
    CurrentHealth = GetEntityHealth(cache.ped)
end)
