import {_} from '../../nuiLabel';
import './Character.scss';

const defaultPP = "http://cdn.onlinewebfonts.com/svg/img_561183.svg"

function Character(data) {
    function msToString(ms) {
        let dd = 60*60*24*1000;
        let dh = 60*60*1000;
        let dm = 60*1000;

        let td = Math.floor(ms/dd);
        let d = (td>0)?(td+_("_d")+' '):'';

        let th = Math.floor((ms-td*dd)/dh);
        let h = (th>0&&d!=='')?(th+_("_h")+' '):'';

        let tm = Math.floor((ms-td*dd-th*dh)/dm);
        let m = tm+_("_m")

        return d+h+m
    }

    let hover;
    if (data.is_dead) {
        hover = <div className="over"><img className="deadPlayer" alt="dead logo" src="https://raw.githubusercontent.com/LH-Lawliet/gtavThings/main/img/menu/commonmenutu/deathmatch.png"/></div>
    }

    let className = "character"

    if (data.is_selected) {
        className += " selected"
    }

    return (
        <div className={className} onClick={data.onClick}>
            <div className="imgPart">
                <img className="playerHead" alt="player head" src={data.img || defaultPP}/>
                {hover}
            </div>
            <span className="playerFirstname">{data.firstname}</span>
            <span className="playerLastname">{data.lastname}</span>
            <span className="playerAge">{data.age} {_("year")}</span>
            <span className="timePlayed">{msToString(data.time_played)}</span>
        </div>
    )
}
export default Character;