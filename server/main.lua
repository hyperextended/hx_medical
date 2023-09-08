-- Outline:
-- Save persisting death/status data if configured
-- Networked Revival
-- Try to fix invisible dead players upon arrival as seen in other scripts

-- TODO: REPLACE UNSECURE EVENT WITH SERVER-SIDE LOGIC
RegisterNetEvent('medical:changeStatus', function(status, value, changeType)
    local player = Ox.GetPlayer(source)
    if changeType == 'add' then
        player.addStatus(status, value)
    elseif changeType == 'remove' then
        player.removeStatus(status, value)
    else
        player.setStatus(status, value)
    end
end)

local function findBed(beds)
    for i = 1, #beds do
        if not beds[i].taken then
            return i
        end
    end
end

local function inPrison(serverId)
    local player = Ox.GetPlayer(serverId)
    if player.getState(self).prison then return true else return false end
end

lib.callback.register('medical:getBed', function()
    local player = Ox.GetPlayer(source)
    local beds = Data.locations.beds
    if inPrison(source) then beds = Data.locations.jailbeds end
    local index = findBed(beds)
    player.getState(self):set('bedIndex', index, true)
    beds[index].taken = true
    -- print(json.encode(beds, { indent = true }))
    return beds[index], index
end)

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

RegisterNetEvent('medical:releaseBed', function(index)
    if not index then return end
    local playerState = Player(source).state
    local player = Ox.GetPlayer(source)
    local beds = Data.locations.beds
    if inPrison(source) then beds = Data.locations.jailbeds end
    beds[index].taken = false
    playerState:set('bedIndex', nil, true)
end)

AddEventHandler('ox:playerLoaded', function(source, userid, charid)
    local player = Ox.GetPlayer(source)
end)

RegisterNetEvent('medical:revive', function(target)
    local player = Ox.GetPlayer(target or source)
    if not player then return end
    local playerState = player.getState(self)
    playerState:set('dead', false, true)
end)

RegisterNetEvent('medical:heal', function(amount, target)
    print('triggered NetEvent medical:heal')
    TriggerClientEvent('medical:heal', target or source, amount or 200)
end)

lib.addCommand('heal', {
    help = 'Heals yourself for 100',
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
    restricted = 'group.everyone'
}, function(source, args, raw)
    print('triggered command heal')
    TriggerClientEvent('medical:selfServiceHeal', args.target or source, args.amount or 100)
end)

lib.addCommand('revive', {
    help = 'Revives the player',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
            optional = true,
        }
    },
    restricted = false
}, function(source, args, raw)
    print('triggered command revive')
    TriggerEvent('medical:revive', args.target or source)
end)

lib.addCommand('builtin.everyone', { 'kill' }, function(source, args)
    local player = Ox.GetPlayer(args.target or source)
    if not player then return end
    local playerState = player.getState()
    playerState:set('dead', true, true)
end, { 'target:?number' })

lib.addCommand('builtin.everyone', { 'setStatus' }, function(source, args)
    if args.status == nil then return end
    local statuses = { 'bleed', 'unconscious', 'stagger', 'thirst', 'hunger' }
    local player = Ox.GetPlayer(source)
    for i = 1, #statuses do
        if statuses[i] == args.status then
            player.setStatus(args.status, tonumber(args.amount) or 100)
        end
    end
end, { 'status:string', 'amount:?number' })
