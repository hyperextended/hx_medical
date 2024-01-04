-- Outline:
-- Save persisting death/status data if configured
-- Networked Revival
-- Try to fix invisible dead players upon arrival as seen in other scripts

-- TODO: REPLACE UNSECURE EVENT WITH SERVER-SIDE LOGIC
RegisterNetEvent('medical:changeStatus', function(status, value, changeType)
    -- print(status, value, changeType)
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
    print(json.encode(beds, { indent = true }))
    return beds[index], index
end)

RegisterNetEvent('medical:releaseBed', function(index)
    if not index then return end
    local player = Ox.GetPlayer(source)
    local beds = Data.locations.beds
    if inPrison(source) then beds = Data.locations.jailbeds end
    beds[index].taken = false
    player.getState(self):set('bedIndex', nil, true)
    print(beds[index].taken)
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
    TriggerClientEvent('medical:heal', target or source, amount or 200)
end)

lib.addCommand('heal', {
    help = 'Heal a player by a certain amount',
    params = {
        {
            name = 'amount',
            type = 'number',
            help = 'The amount to heal',
            optional = true,
        },
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
            optional = true,
        },
    },
}, function(source, args, raw)
    print(('healing %s for %s'):format(args.target, args.amount))
    TriggerClientEvent('medical:heal', args.target or source, args.amount or 100)
end)

lib.addCommand('revive', {
    help = 'Revive a certain player or self',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
            optional = true,
        },
    },
}, function(source, args, raw)
    TriggerEvent('medical:revive', args.target or source)
end)

lib.addCommand('kill', {
    help = 'Kill a certain player or self',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'Target player\'s server id',
            optional = true,
        },
    },
}, function(source, args, raw)
    local player = Ox.GetPlayer(args.target or source)
    if not player then return end
    local playerState = player.getState()
    playerState:set('dead', true, true)
end)

lib.addCommand('setStatus', {
    help = 'Set a status to a certain value or 100',
    params = {
        {
            name = 'status',
            type = 'string',
            help = 'Status name to set (bleed, unconscious, stagger, thirst, hunger)',
        },
        {
            name = 'amount',
            type = 'number',
            help = 'The amount to set',
            optional = true,
        },
    },
}, function(source, args, raw)
    if args.status == nil then return end
    local statuses = { 'bleed', 'unconscious', 'stagger', 'thirst', 'hunger' }
    local player = Ox.GetPlayer(source)
    for i = 1, #statuses do
        if statuses[i] == args.status then
            player.setStatus(args.status, tonumber(args.amount) or 100)
        end
    end
end)
