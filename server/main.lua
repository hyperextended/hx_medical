local Medical = {}

-- TODO: REPLACE UNSECURE EVENT WITH SERVER-SIDE LOGIC
RegisterNetEvent('medical:changeStatus', function(status, value, changeType)
    local player = Ox.GetPlayer(source)

    if player == nil then return end

    if changeType == 'add' then
        player.addStatus(status, value)
    elseif changeType == 'remove' then
        player.removeStatus(status, value)
    else
        player.setStatus(status, value)
    end
end)

-- WIP not functional
lib.callback.register('medical:dropInventory', function(source, coords)
    local victim = source
    local victimCoords = coords
    local weaponsOnly = GetConvarInt('medical:dropInventory', 0) == 2
    local playerItems = exports.ox_inventory:GetInventoryItems(source)
    local inventory = {}
    if weaponsOnly then
        for _, v in pairs(playerItems) do
            if v.name:sub(0, 7) == 'WEAPON_' then
                inventory[#inventory + 1] = {
                    v.name,
                    v.count,
                    v.metadata
                }
                exports.ox_inventory:RemoveItem(victim, v.name, v.count, v.metadata)
            end
        end
    else
        for _, v in pairs(playerItems) do
            inventory[#inventory + 1] = {
                v.name,
                v.count,
                v.metadata
            }
        end
    end
    if #inventory > 0 then
        exports.ox_inventory:CustomDrop('Dropped Items', inventory, victimCoords)
    end
    if not weaponsOnly then
        exports.ox_inventory:ClearInventory(victim, false)
    end
    -- return dropId
end)

AddEventHandler('ox:playerLoaded', function(source, userId, charId)
    local player = Ox.GetPlayer(source)
    local playerState = player.getState()

    repeat Wait(100) until player.get('isDead') ~= nil

    print(player.get('isDead'), playerState.dead)

    playerState.dead = false

    if player.get('isDead') == 1 then
        playerState.dead = true
        return
    end
end)

RegisterNetEvent('medical:playerDeath', function(state)
    local player = Ox.GetPlayer(source)
    if player and player.charId then
        player.set('isDead', state, true)
        player.setStatus('unconscious', 0)
        player.setStatus('bleed', 0)
        player.setStatus('stagger', 0)

        if player.getStatus('hunger') > 50 and GetConvar('medical:resetHunger') then player.setStatus('hunger', 50) end
        if player.getStatus('thirst') > 50 and GetConvar('medical:resetThirst') then player.setStatus('thirst', 50) end

        TriggerClientEvent('medical:playerDeath', source)
    end
end)

---@param target? number
Medical.revive = function(target)
    local player = Ox.GetPlayer(target)
    if not player then return end
    player.set('isDead', false, true)
    player.setStatus('unconscious', 0)
    player.setStatus('bleed', 0)
    player.setStatus('stagger', 0)
    TriggerClientEvent('medical:wakeup', target)
    TriggerClientEvent('medical:revive', target)
    TriggerClientEvent('medical:clearBlurEffect', target)
    TriggerClientEvent('medical:clearBleedEffect', target)
end

---@param target number
---@param amount? number
Medical.heal = function(target, amount)
    TriggerClientEvent('medical:heal', target, amount or 200)
end

exports('heal', Medical.heal)
exports('revive', Medical.revive)

RegisterNetEvent('medical:heal', function(amount, target)
    Medical.heal(source, target, amount)
end)

RegisterNetEvent('medical:revive', function(target)
    if source == nil then return end --possibly cheating
    Medical.revive(target or source)
end)

-- revive (admins only)
lib.addCommand('revive', {
    help = "Revives the specified player, self if blank",
    params = {
        {
            name = "target",
            type = "playerId",
            help = "Target player's server id",
            optional = true,
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    Medical.revive(args.target or source)
end)

-- heal (admins only)
lib.addCommand('heal', {
    help = 'Heals the specified player',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Override target player',
            optional = true,
        },
        {
            name = 'amount',
            type = 'number',
            help = 'Override healing amount',
            optional = true,
        }
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    print('triggered command heal')
    Medical.heal(args.target, args.amount or 200)
end)

-- kill (admins only)
lib.addCommand('kill', {
    help = "Unalives specified player, self if blank",
    params = {
        {
            name = "target",
            type = "playerId",
            help = "Target player's server id",
            optional = true,
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    local player = Ox.GetPlayer(args.target or source)

    if not player then return end

    TriggerClientEvent('medical:killPlayer', args.target or source)
end)

lib.addCommand('setStatus', {
    help = 'Sets the specified status to the specified amount',
    params = {
        {
            name = 'status',
            type = 'string',
            help = 'Status to set',
            optional = false,
        },
        {
            name = 'amount',
            type = 'number',
            help = 'Amount to set status to',
            optional = true,
        },
        {
            name = 'target',
            type = 'playerId',
            help = 'Player to set status for',
            optional = true,
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)
    local target = source
    if args.target ~= nil then target = args.target end
    print('target', target)
    local player = Ox.GetPlayer(target)
    if player == nil then return end
    if args.status == nil then return end
    local statuses = { 'bleed', 'unconscious', 'stagger', 'thirst', 'hunger' }
    for i = 1, #statuses do
        if statuses[i] == args.status then
            player.setStatus(args.status, tonumber(args.amount) or 100)
        end
    end
end)
