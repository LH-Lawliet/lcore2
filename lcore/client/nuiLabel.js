let nuiLabels = {
    "FR":{
        "selectCharacter":"Choisir un personnage",
        "year":"ans"
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