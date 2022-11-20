Vehicle = {}

function Vehicle:create(data)
    vehicle = {}

    self.__gc=function(self)
        print("delete vehicle "..self.id)
        self:delete()
    end

    setmetatable(vehicle, self)
    data = data or {}
    vehicle.model = data.model or "sultan"

    self.__index = self

    vehicle.pos = data.pos or Player.pos
    vehicle.heading = data.heading or Player.heading
    vehicle.network = data.network or false
    vehicle.setDriver = data.setDriver -- that should be the ped to set inside
    vehicle.setOnGroundProperly = true
    if data.setOnGroundProperly == false then
        vehicle.setOnGroundProperly = false
    end

    self.hash = Model:loadModel(vehicle.model)
    self.model = model

    vehicle.id = CreateVehicle(
            vehicle.model --[[ Hash ]],
            vehicle.pos,
            vehicle.heading --[[ number ]],
            vehicle.network --[[ boolean ]],
            true --[[ boolean ]]
    )
    self.id = vehicle.id
    SetModelAsNoLongerNeeded(model)

    debug:print("Vehicle is : "..self.id)

    self:setDefault()

    if vehicle.setDriver then
        SetPedIntoVehicle(vehicle.setDriver, self.id, -1)
    end

    if vehicle.setOnGroundProperly then
        SetVehicleOnGroundProperly(self.id)
    end

    return vehicle
end


function Vehicle:delete()
    DeleteVehicle(self.id)
    self = nil
end


function Vehicle:setDefault()
    local white = vector3(255,255,255)
    self:setColors({white, white})

    SetVehicleCanLeakOil(self.id, true)
    SetVehicleCanLeakPetrol(self.id, true)
    SetVehicleEngineCanDegrade(self.id, true)
    self:repair()
    self:clean()

    SetVehicleDashboardColor(self.id, 0)
    SetVehicleExtraColours(self.id, 0, 4)

    for i=0,49,1 do
        SetVehicleMod(
                self.id --[[ Vehicle ]],
                i --[[ integer ]],
                0 --[[ integer ]],
                false --[[ boolean ]]
        )
    end
end

function Vehicle:repair()
    for i=0,7,1 do
        FixVehicleWindow(self.id, i)
    end

    SetVehicleEngineHealth(self.id, 999.99)
    SetVehicleBodyHealth(self.id, 999.99)
end

function Vehicle:clean()
    SetVehicleDirtLevel(self.id, 0.0)
end

function Vehicle:setColors(colors)
    self:setPrimaryColor(colors[1])
    self:setSecondaryColor(colors[2])
end

function Vehicle:setPrimaryColor(color)
    debug:print("Set "..self.id.." primary color to r:"..color[1]..", g:"..color[2]..", b:"..color[3])
    SetVehicleCustomPrimaryColour(self.id, color[1], color[2], color[3])
end

function Vehicle:setSecondaryColor(color)
    debug:print("Set "..self.id.." secondary color to r:"..color[1]..", g:"..color[2]..", b:"..color[3])
    SetVehicleCustomSecondaryColour(self.id, color[1], color[2], color[3])
end