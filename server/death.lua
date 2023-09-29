local Death = {}

RegisterNetEvent('medical:playerDeath', function(state)
    local player = Ox.GetPlayer(source)

    if player and player.charId then
        TriggerClientEvent('medical:playerDeath', source)
    end
end)
