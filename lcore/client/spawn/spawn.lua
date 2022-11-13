player = nil

Citizen.CreateThread(function ()
    debug:print("Init scripts ...")
    player = Player:create()
end)