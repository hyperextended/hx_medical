lib.callback.register('medical:smellingsaltOnPlayer', function(source, target)
  local targetPlayer = Ox.GetPlayer(target)
  if not targetPlayer then return end
  targetPlayer.setStatus('unconscious', 0)
end)