config = {}

config.resourceName = GetCurrentResourceName()

config.debug = 2

config.language = "FR"

if (config.debug ~= 0) then
    print("^1WARING : YOU ARE RUNNING IN DEBUG MODE, SHOULDN'T DO IT IN PRODUCTION^0")
end