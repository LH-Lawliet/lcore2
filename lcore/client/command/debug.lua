local adminVeh = nil

RegisterCommand("pos", function ()
    debug:print(Player.pos)
end , false)

RegisterCommand("posh", function ()
    debug:print(vector4(Player.pos[1], Player.pos[2], Player.pos[3], Player.heading))
end , false)


RegisterCommand("tp", function (source, args)
    Player:setPos(vector3(tonumber(args[1]),tonumber(args[2]),tonumber(args[3])))
end , false)

function createAdminVeh(source, args)
    --[[if not args[2] or args[2]~="infinity" then
        if adminVeh then
            adminVeh:delete()
        end
    end]]--
    adminVeh = Vehicle:create({setDriver=Player:getPed(), model = args[1]})
    collectgarbage()
end

RegisterCommand("vehicle", createAdminVeh , false)
RegisterCommand("car", createAdminVeh , false)
RegisterCommand("veh", createAdminVeh , false)


RegisterCommand("createChar", function (source, args)
    initCharCreation()
end , false)
