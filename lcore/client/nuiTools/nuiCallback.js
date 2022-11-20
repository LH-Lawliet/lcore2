let resourceName = "unknown resourceName"

export function isEnvBrowser() {
    if (window.invokeNative) {
        if (resourceName === "unknown resourceName") {
            resourceName = window.GetParentResourceName()
        }
        return false
    }
    return true
}


function NUICallback(event, data, cb) {
    data = data || {}
    cb = cb || (()=>{})
    if (!isEnvBrowser()) {
        console.log("sending nui event to ", resourceName, event, `https://${resourceName}/${event}`)
        fetch(`https://${resourceName}/${event}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify(data)
        }).then(resp => resp.json()).then(resp => cb(resp));
    } else {
        console.log(`Should send NUICallback ${event} with data `,data)
        cb()
    }
}

export default NUICallback