local charCreationPos = vector4(402.879,-996.279,-99.0,180.0)
local initialCamCoords = vector3(402.99, -998.02, -99.00)

local headDelta = vector3(0.0,0.0,0.5)
local footDelta = vector3(0.0,0.0,-0.5)

function initCharCreation()
    Player:setPos(charCreationPos)
    Player:setRotHeading(charCreationPos[4])

    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    --SetCamCoord(cam, 402.5164, -1002.847, -99.2587+1)
    SetCamCoord(cam, initialCamCoords+headDelta)

    SetCamFov(cam, 30.0)
    PointCamAtCoord(cam, vector3(charCreationPos)+headDelta)
    RenderScriptCams(true, false, 0, true, false)

    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(false)

    Citizen.CreateThread(function()
        while cam do
            Wait(0)
            for i=0, 343, 1 do
                DisableControlAction(0,i, true)
            end
        end

        SetNuiFocus(false, false)
        SetNuiFocusKeepInput(true)

        for i=0, 343, 1 do
            EnableControlAction(0,i, true)
        end
    end)
end

SetNuiFocus(false, false)
SetNuiFocusKeepInput(true)
