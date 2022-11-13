Model = {}

function Model:loadModel(model)
    local hash = GetHashKey(model)

    debug:print("Requesting Model : "..model)
    RequestModel(hash)
    debug:print("Hash is : "..hash)

    while not HasModelLoaded(hash) do
        Wait(10)
        RequestModel(hash)
        debug:print("Waiting Load of "..model.." ("..hash..")")
    end

    return hash
end