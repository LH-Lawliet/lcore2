AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
    local source = source..""

    deferrals.defer()
    local ply = Player:new({}, source)

    deferrals.handover({playerName=playerName})

    local success = function ()
        debug:print("Successful connection : ")
        ply:print()
        deferrals.handover(ply)
        deferrals.done()
    end

    ply:GetDetailsInDatabase():next(function()
        success()
    end, function(err)
        debug:error('Error 1 ', err)
        if (err == 0) then
            ply:AddInDatabase():next(function()
                success()
            end, function(err)
                debug:error('Error 2 ', err)
                deferrals.done(_("insertPlayerInDBError"))
            end)
        end
    end)
end)