playerState = LocalPlayer.state
PlayerIsLoaded = true
PlayerIsDead = false
PlayerCanRespawn = false
CauseOfDeath = nil
CurrentHealth = 0
PreviousHealth = CurrentHealth
anims = {
    { 'missfinale_c1@', 'lying_dead_player0' },
    { 'veh@low@front_ps@idle_duck', 'sit' },
    { 'dead', 'dead_a' },
}

AddEventHandler('ox:playerLoaded', function(data)
    PlayerIsLoaded = true
    SetPedMaxHealth(cache.ped, 200)
    SetEntityMaxHealth(cache.ped, 200)
    CurrentHealth = GetEntityHealth(cache.ped)
end)

SetEntityMaxHealth(cache.ped, 200)
CurrentHealth = GetEntityHealth(cache.ped)

Citizen.CreateThread(function()
    while true do
        PreviousHealth = CurrentHealth
        CurrentHealth = GetEntityHealth(cache.ped)
        Wait(200)
        -- if CurrentHealth < 126 then
        --     SetEntityHealth(cache.ped, 150)
        -- end
    end
end)

local function handleDamage(weapon, bone, damageTaken)
    if not (weapon or bone or damageTaken) then return end
    if damageTaken < 1 then return end

    local weaponData = Data.WeaponsTable[weapon]
    local boneName = Data.Bones[bone]

    -- shitty if hell for applying damage
    if Data.KnockOutWeapons[weapon] then
        local statusAmount = damageTaken * 3
        if statusAmount > 100 then statusAmount = 100 end
        TriggerServerEvent('medical:changeStatus', 'unconscious', statusAmount, 'add')
    end
end

AddEventHandler('gameEventTriggered', function(event, data)
    local victim, attacker, fatal, weapon = data[1], data[2], data[4], data[7]
    if event ~= "CEventNetworkEntityDamage" then return end
    if victim ~= cache.ped then return end
    CurrentHealth = GetEntityHealth(cache.ped)
    local damageTaken = PreviousHealth - CurrentHealth
    local hit, bone = GetPedLastDamageBone(cache.ped)
    handleDamage(weapon, bone, damageTaken)

    PreviousHealth = CurrentHealth
    CurrentHealth = GetEntityHealth(cache.ped)
end)


RegisterCommand('gh', function(source, args, rawCommand)
    local name = joaat(tostring(args[1]))
    print(name)
    lib.setClipboard(name)
end)

RegisterCommand('generatelist', function(source, args, rawCommand)
    local weaponTable = {}
    for name, data in pairs(Data.QBWeapons) do
        -- print(name, data.name)
        weaponTable[tonumber(name)] = {
            label = data.label,
            name = data.name,
            type = data.weapontype,
            class = Data.Weapons[name]
        }
        print(weaponTable[name].class)
    end
    lib.setClipboard(json.encode(weaponTable, { indent = true }))
end)
