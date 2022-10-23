database = {}

function database:isDatabaseReady()
    return exports[config.resourceName]:isDatabaseReady()
end

function database:query(string, variables, callback)
    exports[config.resourceName]:query(string, variables or {}, callback)
end