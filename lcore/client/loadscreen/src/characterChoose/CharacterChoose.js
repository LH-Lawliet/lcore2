import {_} from '../nuiLabel';
import './CharacterChoose.scss';
import Character from "./character/Character";
import {useState} from "react";

const exempleChar = [
    {
        firstname:"Jack",
        lastname:"Uzi",
        age:69,
        time_played: (17*60*60*24  +  12*60*60  +  10*60  +  56)*1000, // 17d 12h 10m 56s
        img:"https://img.gta5-mods.com/q85-w800/images/ski-mask-the-slump-god-face-tattoos/821eca-skifacefront.png",
    },

    {
        firstname:"Barack",
        lastname:"Grobama",
        age:37,
        time_played: (42*60*60*24  +  5*60*60  +  3*60  +  12)*1000
    },

    {
        firstname:"Maxime",
        lastname:"Ler",
        age:115,
        is_dead: true,
        time_played: (5*60*60  +  14*60  +  5)*1000
    },

    {
        firstname:"Gé",
        lastname:"Pludidé",
        age:18,
        time_played: (11*60*60*24  +  5*60*60  +  14*60  +  5)*1000
    },

    {
        firstname:"Plu",
        lastname:"Dutou",
        age:19,
        time_played: (5*60*60  +  14*60  +  5)*1000
    },
]

function CharacterChoose() {
    let [selectedChar, setSelectedChar] = useState(null)
    let chars = []

    for (let i in exempleChar) {
        let char=exempleChar[i]
        let is_selected = (selectedChar && selectedChar === i)

        chars.push(
            <Character
                onClick={()=>{setSelectedChar(i)}}
                key={"charChoose_"+i}
                img={char.img}
                firstname={char.firstname}
                lastname={char.lastname}
                age={char.age}
                time_played={char.time_played}
                is_dead={char.is_dead}
                is_selected={is_selected}
            />
        )
    }

    return <div id="CharacterChoose">
        <span className="title">{_("selectCharacter")} :</span>
        <div className="seperator"></div>
        <div className="characterContainer">{chars}</div>
    </div>
}
export default CharacterChoose;