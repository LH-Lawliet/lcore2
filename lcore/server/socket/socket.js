const { Server } = require("socket.io");

let players = {}

const io = new Server({
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
    },
    serveClient: false
});

io.listen(8080);

io.on("connection", (socket) => {
    console.log("new socket", socket.id)
    socket.on("setMySource", (src)=>{
        console.log(socket.id+" is "+src)
        players[socket.id] = src
    })

    socket.on("callback:spawnplayer", (player)=>{
        console.log("should call exports exports.lcore.spawnPlayer with value",players[socket.id], player)
        exports.lcore.spawnPlayer(players[socket.id], player)
    })
});