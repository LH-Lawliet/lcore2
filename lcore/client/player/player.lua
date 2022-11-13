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
    self.pos = playerData.pos or vector3(0.0,0.0,0.0) -- kinda weird to set it here without send the pos to the game engine
    self.model = playerData.model or "mp_m_freemode_01" -- same

    debug:log("Create a player "..self.model.." at pos "..self.pos)

    DoScreenFadeOut(10)

    self:freeze(true)
    self:setModel(self.model)

    RequestCollisionAtCoord(self.pos)
    self:setPos(self.pos)

    NetworkResurrectLocalPlayer(self.pos, 0.0001, true, true, false)

    ClearPedTasksImmediately(self:getPed())

    self:waitCollisionAround()
    self:freeze(false)

    DoScreenFadeIn(10)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()

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
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end

        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end

        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    else
        if IsEntityVisible(ped) then
            SetEntityVisible(ped, false)
        end

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


function Player:waitCollisionAround()
    local time = GetGameTimer()
    while (not HasCollisionLoadedAroundEntity(self:getPed()) and (GetGameTimer() - time) < 5000) do
        Wait(10)
        debug:print("Waiting for collisions "..(GetGameTimer() - time).." ms")
    end
    return
end