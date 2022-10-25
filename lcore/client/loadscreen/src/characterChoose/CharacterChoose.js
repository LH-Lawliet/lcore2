import {_} from '../nuiLabel';
import './CharacterChoose.scss';


function CharacterChoose() {
    return <div id="CharacterChoose">
        <span className="title">{_("selectCharacter")} :</span>
        <div className="seperator"></div>

        <div className="characterContainer">
            <div className="character">
                <div className="imgPart">
                    <img className="playerHead" alt="player head" src="https://img.gta5-mods.com/q85-w800/images/ski-mask-the-slump-god-face-tattoos/821eca-skifacefront.png"/>
                </div>
                <span className="playerFirstname">FirstName</span>
                <span className="playerLastname">LastName</span>
                <span className="playerAge">69 {_("year")}</span>
                <span className="timePlayed">12j 13h 56m</span>
            </div>
            <div className="character">
                <div className="imgPart">
                    <img className="playerHead" alt="player head" src="https://img.gta5-mods.com/q85-w800/images/ski-mask-the-slump-god-face-tattoos/821eca-skifacefront.png"/>
                    <div className="over">
                        <img className="deadPlayer" alt="dead logo" src="https://raw.githubusercontent.com/LH-Lawliet/gtavThings/main/img/menu/commonmenutu/deathmatch.png"/>
                    </div>
                </div>
                <span className="playerFirstname">FirstName</span>
                <span className="playerLastname">LastName</span>
                <span className="playerAge">69 {_("year")}</span>
                <span className="timePlayed">12j 13h 56m</span>
            </div>
            <div className="character"></div>
            <div className="character"></div>
            <div className="character"></div>
        </div>
    </div>
}
export default CharacterChoose;