debug = {}

function debug:print(...)
    if config.debug == 2 then
        local args = {...}
        local string = ""
        for k,v in ipairs(args) do
            string = string..tostring(v).."    "
        end
        print(string)
    end
end

function debug:log(...)
    if config.debug == 1 then
        local args = {...}
        local string = ""
        for k,v in ipairs(args) do
            string = string..tostring(v).."    "
        end
        print("^2LOG : "..string.."^0")
    end
end


function debug:error(...)
    local args = {...}
    local string = ""
    for k,v in ipairs(args) do
        string = string..tostring(v).."    "
    end
    print("^1ERROR : "..string.."^0")
end

-- most of it come from ft_libs, https://github.com/FivemTools/ft_libs/blob/master/src/utils/utils.common.lua
function debug:printTable(table, indentation)
    if type(table) == "table" then
        indentation = indentation or 0
        for k, v in pairs(table) do
            formatting = string.rep("  ", indentation) .. k .. " ("..type(k).."): "
            if type(v) == "table" then
                if indentation > 10 then
                    debug:print(formatting.."table too far... (probably infinite loop due to class)")
                else
                    debug:print(formatting)
                    self:printTable(v, indentation + 1)
                end
            else
                debug:print(formatting .. tostring(v) .. " (" .. type(v) .. ")")
            end
        end
    else
        debug:print(tostring(table) .. " (" .. type(table) .. ")")
    end
end