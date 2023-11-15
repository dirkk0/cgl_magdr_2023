"use strict";


const http = require('http');
// const https = require('https');

const express = require('express');

const socketio = require('socket.io');



const PORT = process.env.PORT || 5002;


let app = express();

app.use('/', express.static(__dirname + '/public'));

const server = http.createServer(app)
// const server = https.createServer(credentials, app)

const io = socketio(server);

let startTime = new Date()
let serverTime = null

// start express server
server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
})

// let players = []

let world = {
    things: { x: 130, y: 70 }
}

io.on('connection', (socket) => {
    console.log("LOG: connected with ", socket.id, socket.handshake.address);

    socket.on('data-to-server', (msg) => {

        msg.id = socket.id
        io.emit('data-to-client', msg);
    });

    socket.on('key-to-server', (msg) => {
        console.log(msg)

        let condition = true
        condition = condition && msg.coords.x > (world.things.x - 5)
        condition = condition && msg.coords.x < (world.things.x + 5)
        condition = condition && msg.coords.y > (world.things.y - 5)
        condition = condition && msg.coords.y < (world.things.y + 5)

        // console.log()
        if (condition) {
            console.log("yay")
            world = {
                things: { x: Math.random() * step, y: Math.random() * step }
            }
        }
        // msg.id = socket.id
        // io.emit('data-to-client', msg);
    });

    socket.on('world-to-server', (w) => {
        world = w
    });

    socket.on('disconnect', (c) => {
        console.log('LOG:  disconnect: ' + c + socket.id);
        // console.log(socket.id)
        io.emit('outro', socket.id);
    });

});

// setInterval(() => {
//     let temp = ""
//     for (const [_, socket] of io.of("/").sockets) {
//         if (socket.username != "monitor") {
//             // console.log(Object.keys(socket.rooms))
//             temp += "\n" + socket.id + " " + socket.username + " " + socket.prop_room + " " + socket.prop_x + " " + socket.prop_y
//         }
//     }
//     let today = new Date();
//     let time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
//     io.emit('monitorinfo', temp);
//     // io.to("abc123").emit('info1', "Hello room abc123, it's "+ time);
//     io.to("def456").emit('info1', "Hello room def, it's " + time);
// }, 500);


setInterval(() => {
    // serverTime = new Date() - startTime
    // world[0] = (serverTime / 1000).toFixed(1)
    io.emit('world-to-client', world);
    // console.log(world)
}, 500);

let step = 400
// setInterval(() => {
//     world = {
//         things: { x: Math.random() * step, y: Math.random() * step }
//     }

// }, 2000);