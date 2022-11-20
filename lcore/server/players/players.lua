Players = {}

Player = {}


-- handle restart
Citizen.CreateThread(function ()
    local num = GetNumPlayerIndices()
    for i = 0, num - 1 do
        print("num : ",num)
        TriggerClientEvent("lcore:spawn",GetPlayerFromIndex(i), {})
    end
end)


RegisterServerEvent("lcore:heyIsThatARestart")
AddEventHandler("lcore:heyIsThatARestart", function ()
    local source = source..""
    if not Players[source] then
        Player:new({}, source)
        spawnPlayer(source, {})
    end
end)


-- called by the socket handler
function spawnPlayer(src, playerData)
    debug:print("spawnPlayer function")
    ply = Players[src]
    if not ply then
        debug:error("No player with source "..src.." impossible to shutdown loadscreen of him")
    else
        ply:spawn(playerData)
    end
end
exports("spawnPlayer", spawnPlayer);


AddEventHandler("playerJoining", function (oldID)
    local source = source..""
    oldID = oldID..""

    debug:print(type(source))

    debug:print("player change source from "..oldID.." to "..source)
    ply = Players[oldID]
    if ply then
        Players[source] = ply
        TriggerClientEvent("lcore:setSource", source, source)
    else
        debug:error("There were no player with the src "..oldID..", probably disonnected during loadscreen")
        Players[oldID] = nil
    end
end)

function Player:new(ply, source)
    debug:log("new ply")
    setmetatable(ply, self)
    self.__index = self
    self.source = tonumber(source)
    self.identifiers = self:GetIdentifiers()

    Players[source] = self

    self:print()
    return self
end

function Player:spawn(data)
    TriggerClientEvent("lcore:spawn", self.source, data)
end

function Player:GetIdentifiers()
    local nIdentifiers = GetNumPlayerIdentifiers(self.source)

    local identifiers = {}
    for i=0,nIdentifiers-1, 1 do
        local splitted = {}
        for v in string.gmatch(GetPlayerIdentifier(self.source, i), "([^:]+)") do
            table.insert(splitted, v)
        end
        identifiers[splitted[1]] = splitted[2]
    end
    return identifiers
end

function Player:print()
    debug:print("--------------------------------")
    debug:print("Player "..self.source.." : ")
    debug:printTable(self.identifiers)
    debug:print("--------------------------------")
end

--not using ip as a valid auth method
function Player:GetDetailsInDatabase()
    d = promise.new()

    database:query([[
        SELECT
            *
        FROM
            users
        WHERE
            steam=$1 OR
            license=$2 OR
            xbl=$3 OR
            live=$4 OR
            discord=$5 OR
            license2=$6
    ]], {
        self.identifiers["steam"],
        self.identifiers["license"],
        self.identifiers["xbl"],
        self.identifiers["live"],
        self.identifiers["discord"],
        self.identifiers["license2"],
    }, function (err, res)
        if (err ~= "") then
            debug:printTable(err)
            return d:reject(err)
        end

        if (#res.rows == 1) then
            return d:resolve(res.rows[1])
        end
        return d:reject(#res.rows)
    end)
    return d
end

function Player:AddInDatabase()
    d = promise.new()

    database:query([[
        INSERT INTO
            users
        (
            steam,
            license,
            xbl,
            live,
            discord,
            license2,
            ip
        )
        VALUES
        (
            $1,
            $2,
            $3,
            $4,
            $5,
            $6,
            $7
        )
    ]], {
        self.identifiers["steam"],
        self.identifiers["license"],
        self.identifiers["xbl"],
        self.identifiers["live"],
        self.identifiers["discord"],
        self.identifiers["license2"],
        self.identifiers["ip"],
    }, function (err, res)
        if (err ~= "") then
            return d:reject(err)
        end
        d:resolve()
    end)
    return d
end