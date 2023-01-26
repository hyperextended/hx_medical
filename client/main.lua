playerState = LocalPlayer.state
PlayerIsLoaded = true
PlayerIsDead = false
PlayerCanRespawn = false
CauseOfDeath = nil
CurrentHealth = 0
PreviousHealth = CurrentHealth

AddEventHandler('ox:playerLoaded', function(data)
    PlayerIsLoaded = true
    SetPedMaxHealth(cache.ped, 200)
    SetEntityMaxHealth(cache.ped, 200)
    CurrentHealth = GetEntityHealth(cache.ped)
end)

---@param status string
---@param amount number
local function addStatus(status, amount)
    TriggerServerEvent('medical:changeStatus', status, amount, 'add')
end

local function checkArmor(ped, bone)
    if GetPedArmour(ped) > 0 then
        return Data.ArmoredBones[bone] and true
    else return false end
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
    if not lib.table.contains(Data.StaggerAreas, bone) then return else
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
    local weaponData = Data.WeaponsTable[weapon]
    local isArmored = checkArmor(cache.ped, boneName)
    if not weaponData.statuses then return else
        local statuses = weaponData.statuses
        for k, v in pairs(statuses) do
            Data.ApplyStatus[k](v, damageTaken, isArmored, boneName)
        end
    end
end

AddEventHandler('gameEventTriggered', function(event, data)
    if event ~= "CEventNetworkEntityDamage" then return end
    local victim, attacker, fatal, weapon = data[1], data[2], data[4], data[7]
    if victim ~= cache.ped then return end
    CurrentHealth = GetEntityHealth(cache.ped)
    local damageTaken = PreviousHealth - CurrentHealth
    local hit, bone = GetPedLastDamageBone(cache.ped)
    local armored = GetPedArmour(cache.ped)
    handleDamage(weapon, bone, damageTaken)

    PreviousHealth = CurrentHealth
    CurrentHealth = GetEntityHealth(cache.ped)
end)

if GetConvarInt('medical:debug', 0) == 1 then

    RegisterCommand('gh', function(source, args, rawCommand)
        local name = joaat(tostring(args[1]))
        lib.setClipboard(name)
    end)

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
