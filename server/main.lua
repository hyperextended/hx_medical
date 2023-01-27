-- Outline:
-- Save persisting death/status data if configured
-- Networked Revival
-- Try to fix invisible dead players upon arrival as seen in other scripts

-- lib.callback.register('medical:unconscious', function()
--     local player = Ox.GetPlayer(source)
--     player.setStatus('limping', 100)
-- end)


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
    local isDead = player.get('isDead')
end)

RegisterNetEvent('medical:revive', function()

end)

RegisterNetEvent('medical:heal', function()

end)
