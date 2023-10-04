local Hospital = {}

function Hospital:inPrison(serverId)
    local player = Ox.GetPlayer(serverId)
    if player ~= nil and player.getState(self).prison then return true else return false end
end

function Hospital:findEmptyBed(beds)
    for i = 1, #beds do
        if not beds[i].taken then
            return i
        end
    end
end

function Hospital:getBed(source)
    local player = Ox.GetPlayer(source)
    local beds = Data.locations.beds.hospitalBeds

    if self:inPrison(source) then beds = Data.locations.beds.jailBeds end

    local bed = self:findEmptyBed(beds)

    player.getState():set('bed', bed, true)
    beds[bed].taken = true

    return beds[bed]
end

lib.callback.register('medical:getBed', function()
    return Hospital:getBed(source)
end)

RegisterNetEvent('medical:releaseBed', function(index)
    if not index then return end
    local playerState = Player(source).state
    local beds = Data.locations.beds.hospitalBeds
    if Hospital:inPrison(source) then beds = Data.locations.beds.jailBeds end
    beds[index].taken = false
    playerState:set('bed', nil, true)
end)
