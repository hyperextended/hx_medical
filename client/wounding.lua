-- Outline:
-- Statebag change handlers for applying affects to playerped
-- Bleeding
-- ticking health damage
-- config to down the player from bleeding or just low health
-- drop blood decals while walking/running
-- decorate ped with blood
-- blur / fade vision

-- Limping
-- set walking clipset
-- increase propensity to trip while jumping/sprinting (configuratble)

-- Blackout
-- vision /audio fade out

RegisterCommand('getexp', function(source, args, rawCommand)
    local expression = exports.scully_emotemenu:GetCurrentExpression()
    print(expression)
end)

RegisterCommand('getwalk', function(source, args, rawCommand)
    local walk = exports.scully_emotemenu:GetCurrentWalk()
    print(walk)
end)
