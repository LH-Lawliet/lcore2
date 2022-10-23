let nuiLabels = {
    "FR":{
        "selectCharacter":"Choisir un personnage"
    }
}

console.log("NUI LABELS LOADED")

const NUILanguage = "FR"
function _(label) {
    return nuiLabels[NUILanguage][label] || "_("+text+") is missing from "+NUILanguage+" (NUI)"
}

module.exports = {
    "_": _,
}