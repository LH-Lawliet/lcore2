Player = {}

-- Player creation, warning this function can take au while to execute
function Player:create(playerData)
    local player = {}
    playerData = playerData or {}
    setmetatable(player, self)
    self.__index = self


    self.ped = nil
    self.asControl = false
    self.frozen = false
    self.pos = playerData.pos or vector3(231.356,-870.817,30.4921) -- kinda weird to set it here without send the pos to the game engine
    self.model = playerData.model or "mp_m_freemode_01" -- same

    debug:log("Create a player "..self.model.." at pos "..self.pos)

    DoScreenFadeOut(10)

    self:freeze(true)
    self:setModel(self.model)

    RequestCollisionAtCoord(self.pos)
    self:setPos(self.pos)

    NetworkResurrectLocalPlayer(self.pos, 0.0001, true, true, false)
    SetEntityVisible(self.ped, false)

    ClearPedTasksImmediately(self:getPed())

    self:waitCollisionAround()
    self:freeze(false)

    DoScreenFadeIn(10)
    SetEntityVisible(self.ped, true)

    Citizen.CreateThread(function ()
        while true do
            self.pos = GetEntityCoords(self:getPed())
            self.heading = GetEntityHeading(self:getPed())
            Wait(100)
        end
    end)

    return player
end

function Player:playerId()
    return PlayerId()
end

function Player:getPed()
    if not self.ped then
        self.ped = GetPlayerPed(-1)
    end
    return self.ped
end

function Player:control(control)
    self.asControl = control
    SetPlayerControl(self:playerId(), control, false)
end

function Player:freeze(state)
    self.frozen = state
    self:control(not self.frozen)
    local ped = self:getPed()

    if not freeze then
        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end

        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    else
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)

        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end

function Player:refreshPed()
    self.ped = GetPlayerPed(-1)
end

function Player:setModel(model)
    self.hash = Model:loadModel(model)
    self.model = model

    SetPlayerModel(self:playerId(), model)
    SetModelAsNoLongerNeeded(model)
    self:refreshPed()
    SetPedDefaultComponentVariation(self.ped)
end

function Player:setPos(coords)
    self.pos=coords
    SetEntityCoordsNoOffset(self:getPed(), coords, false, false, false, true)
end

function Player:setRotHeading(rot)
    SetEntityRotation(self:getPed(), rot,0.0,0.0,0,false)
    SetEntityHeading(self:getPed(), rot)
end


function Player:waitCollisionAround()
    local time = GetGameTimer()
    while (not HasCollisionLoadedAroundEntity(self:getPed()) and (GetGameTimer() - time) < 5000) do
        Wait(10)
        debug:print("Waiting for collisions "..(GetGameTimer() - time).." ms")
    end
    return
end