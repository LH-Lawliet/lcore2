const socket = io("ws://localhost:8080");
console.log(socket)
function emit(event, data) {
    socket.emit(event,data)
}
exports.emit = emit

function on(event, callback) {
    socket.on(event,callback)
}
exports.on = on
