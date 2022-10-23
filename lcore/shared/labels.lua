labels = {
    FR={},
    EN={}
}

function _(text)
    return labels[config.language][text] or "_("..text..") is missing from "..config.language
end