import './App.scss';
import Loadbar from "./loadbar/Loadbar";
import CharacterChoose from "./characterChoose/CharacterChoose";

function App() {
    return (
        <div id="App">
            <Loadbar/>
            <CharacterChoose/>
        </div>
    );
}

export default App;
