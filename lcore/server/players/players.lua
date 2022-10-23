Players = {}

Player = {}

function Player:new(source)
    debug:log("new ply")
    local ply = {}
    setmetatable(ply, self)
    self.__index = self
    self.source = source
    self.identifiers = self:GetIdentifiers()

    self:print()
    Players[source] = ply
    return ply
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