lib.callback.register('medical:curePlayer', function(source, target, status)
  local targetPlayer = Ox.GetPlayer(target)
  if not targetPlayer then return end
  if status == 'unconscious' then
    TriggerClientEvent('medical:wakeUp', target)
  end
  targetPlayer.setStatus(status, 0)
end)
