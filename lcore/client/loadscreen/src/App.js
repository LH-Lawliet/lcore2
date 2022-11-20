import './App.scss';
import Loadbar from "./loadbar/Loadbar";
import CharacterChoose from "./characterChoose/CharacterChoose";
import {useEffect, useState} from "react";
import ValidationButton from "./validationButton/ValidationButton";
import NUICallback from "./nuiCallback";
import socket from "./socketHandler"

function App() {
    const [finishLoading, setFinishLoading] = useState(0);
    let onMessage = (event)=>{
        console.log(event)
        if (event.data.shutdownPossible) {
            setFinishLoading(1)
        } else if (event.data.playerSpawned) {
            setFinishLoading(3)
        }
        if (event.data.setSource) {
            console.log("set source",event.data.setSource)
            socket.emit("setMySource", event.data.setSource)
        }
    }

    function exitLoadingScreen() {
        setFinishLoading(2)
        socket.emit("callback:spawnplayer", {})
    }

    useEffect(() => {
        window.addEventListener('message', onMessage);
        return () => {
            window.removeEventListener("message", onMessage);
        };
    }, []);


    let bottom=<Loadbar/>
    let className=""

    if (finishLoading === 1) {
        bottom=<ValidationButton onClick={exitLoadingScreen}/>
    } else if (finishLoading === 2) {
        bottom=null
    } else if (finishLoading === 3) {
        className="fadeOut"
        bottom=null
    }

    return (
        <div id="App" className={className}>
            {bottom}
            <CharacterChoose/>
        </div>
    );
}

export default App;
