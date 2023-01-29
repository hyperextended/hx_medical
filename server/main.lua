-- Outline:
-- Save persisting death/status data if configured
-- Networked Revival
-- Try to fix invisible dead players upon arrival as seen in other scripts

-- TODO: REPLACE UNSECURE EVENT WITH SERVER-SIDE LOGIC
RegisterNetEvent('medical:changeStatus', function(status, value, changeType)
    print(status, value, changeType)
    local player = Ox.GetPlayer(source)
    if changeType == 'add' then
        player.addStatus(status, value)
    elseif changeType == 'remove' then
        player.removeStatus(status, value)
    else
        player.setStatus(status, value)
    end
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

lib.addCommand('group.admin', { 'heal' }, function(source, args)
    print(('healing %s for %s'):format(args.target, args.amount))
    TriggerClientEvent('medical:heal', args.target or source, args.amount or 100)
end, { 'amount:?number', 'target:?number' })

lib.addCommand('group.admin', { 'revive' }, function(source, args)
    TriggerEvent('medical:revive', args.target or source)
end, { 'target:?number' })

lib.addCommand('group.admin', { 'kill' }, function(source, args)
    local player = Ox.GetPlayer(args.target or source)
    if not player then return end
    local playerState = player.getState()
    playerState:set('dead', true, true)
end, { 'target:?number' })
