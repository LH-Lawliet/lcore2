import {useEffect, useState} from 'react';
import './Loadbar.scss';


function Loadbar() {
    const [advancement, setAdvancement] = useState(0);

    let onMessage = (event)=>{
        if (event.data.loadFraction) {
            setAdvancement(event.data.loadFraction*100)
        }
    }

    useEffect(() => {
        window.addEventListener('message', onMessage);
        return () => {
            window.removeEventListener("message", onMessage);
        };
    }, []);

    return <div id="Loadbar">
        <div id="LoadbarChild" style={{width:advancement+"%"}}>
            <span>{advancement.toFixed(1)} %</span>
        </div>
    </div>
}
export default Loadbar;