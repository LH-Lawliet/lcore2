let nuiLabels = {
    "FR":{
        "selectCharacter":"Choisir un personnage",
        "year":"ans",
        "_d":"j", //_d is for days
        "_h":"h", //_d is for hours
        "_m":"m", //_d is for minutes
    }
}

console.log("NUI LABELS LOADED")

const NUILanguage = "FR"
function _(label) {
    return nuiLabels[NUILanguage][label] || "_("+label+") is missing from "+NUILanguage+" (NUI)"
}

module.exports = {
    "_": _,
}