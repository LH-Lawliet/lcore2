player = nil

function spawnPlayer()
    player = Player:create()
end

Citizen.CreateThread(function ()
    TriggerServerEvent("lcore:heyIsThatARestart")
end)