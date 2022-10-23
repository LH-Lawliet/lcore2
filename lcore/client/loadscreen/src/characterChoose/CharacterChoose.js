import {_} from '../nuiLabel';
import './CharacterChoose.scss';


function CharacterChoose() {
    return <div id="CharacterChoose">
        <span className="title">{_("selectCharacter")} :</span>
        <div className="seperator"></div>

        <div className="characterContainer">
            <div className="character">
                <img className="playerHead" alt="player head" src="https://img.gta5-mods.com/q85-w800/images/ski-mask-the-slump-god-face-tattoos/821eca-skifacefront.png"/>
            </div>
            <div className="character"></div>
            <div className="character"></div>
            <div className="character"></div>
            <div className="character"></div>
        </div>
    </div>
}
export default CharacterChoose;