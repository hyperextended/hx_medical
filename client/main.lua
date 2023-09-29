PlayerIsLoaded = false
PlayerIsDead = false
PlayerCanRespawn = false
--CauseOfDeath = nil
playerState = LocalPlayer.state

local function SyncHealth()
    CurrentHealth = GetEntityHealth(cache.ped)
    if CurrentHealth ~= PreviousHealth then
        PreviousHealth = CurrentHealth
    end
end

local function DamageTaken()
    return PreviousHealth - GetEntityHealth(cache.ped)
end

AddEventHandler('ox:playerLoaded', function(data)
    PlayerIsLoaded = true
    SetPedMaxHealth(cache.ped, 200)
    SetEntityMaxHealth(cache.ped, 200)
    SyncHealth()
end)

AddEventHandler('ox:playerLogout', function()
    PlayerIsLoaded = false
    PlayerIsDead = false
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == cache.resource and cache.ped then
        PlayerIsLoaded = true
        SyncHealth()
    end
end)

local function addStatus(status, amount)
    TriggerServerEvent('medical:changeStatus', status, amount, 'add')
end

local function checkArmor(ped, bone)
    if GetPedArmour(ped) > 0 then
        return Data.ArmoredBones[bone] and true
    else
        return false
    end
end

local function applyBleed(multi, damage, isArmored)
    if isArmored then
        multi = multi / 10
    end
    addStatus('bleed', damage * multi)
end

local function applyUnconscious(multi, damage, isArmored)
    if isArmored then
        multi = multi / 10
    end
    addStatus('unconscious', damage * multi)
end

local function applyStagger(multi, damage, isArmored, bone)
    if isArmored then
        multi = multi / 10
    end
    if not lib.table.contains(Data.StaggerAreas, bone) then
        return
    else
        addStatus('stagger', damage * multi)
    end
end

Data.ApplyStatus = {
    ['stagger'] = applyStagger,
    ['unconscious'] = applyUnconscious,
    ['bleed'] = applyBleed
}

local function handleDamage(weapon, bone, damageTaken)
    if not (weapon or bone or damageTaken) then return end
    if damageTaken < 1 then return end

    local weaponData = Data.WeaponsTable[weapon]
    local boneName = Data.Bones[bone]
    local isArmored = checkArmor(cache.ped, boneName)
    if not weaponData.statuses then
        return
    else
        local statuses = weaponData.statuses
        for k, v in pairs(statuses) do
            if GetConvarInt('medical:debug', 0) == 1 then
                print("Multi:", v, "DamageTaken", damageTaken, "isArmored", isArmored, "bone: ", boneName, "status", k)
            end
            Data.ApplyStatus[k](v, damageTaken, isArmored, boneName)
        end
    end
end

RegisterNetEvent('medical:heal', function(amount)
    SetEntityMaxHealth(cache.ped, 200)
    SetEntityHealth(cache.ped, GetEntityHealth(cache.ped) + amount)
end)



AddEventHandler('gameEventTriggered', function(event, data)
    if event ~= "CEventNetworkEntityDamage" then return end
    local victim, attacker, fatal, weapon = data[1], data[2], data[4], data[7]
    if victim ~= cache.ped then return end
    local damageTaken = DamageTaken()

    SyncHealth()
    local hit, bone = GetPedLastDamageBone(cache.ped)
    local armored = GetPedArmour(cache.ped)
    handleDamage(weapon, bone, damageTaken)
end)

if GetConvarInt('medical:debug', 0) == 1 then
    RegisterCommand('generatelist', function(source, args, rawCommand)
        local weaponTable = {}
        for name, data in pairs(Data.QBWeapons) do
            weaponTable[tonumber(name)] = {
                label = data.label,
                name = data.name,
                type = data.weapontype,
                class = Data.Weapons[name]
            }
        end
        lib.setClipboard(json.encode(weaponTable, { indent = true }))
    end)
end


-- CreateThread(function()
--     local player = LocalPlayer.state
--     while true do
--         Wait(1000)
--         print('invBusy', LocalPlayer.state.invBusy)
--     end
-- end)
