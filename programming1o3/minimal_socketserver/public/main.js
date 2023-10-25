"use strict";

const FREQ = 33;
let world = [0, 0, 0];

function NetObject() {
  this.users = [];

  this.init = function () {
    console.log("net init", this.users);

    this.socket = io();
    this.socket.on("connect", () => {
      console.log("yay! My id is ", this.socket.id);
    });

    this.sendData = function (that) {
      let msg = {
        posrot: that.posrot,
      };
      this.socket.emit("data-to-server", msg);
    };
    this.socket.on("outro", (key) => {
      console.log(key, "is gone.");
      delete this.users[key];

      let thisEl = document.querySelector("#player-" + key);
      if (thisEl) {
        thisEl.parentNode.removeChild(thisEl);
      }

      //   let thisEl = document.querySelector("#rig_" + key);
      //   if (thisEl) {
      //     thisEl.parentNode.removeChild(thisEl);
      //   }
    });

    this.socket.on("world-to-client", (w) => {
      // console.log("world", world)
      world = w;

      return;
    });

    this.socket.on("data-to-client", (m) => {
      // if not me
      if (m.id != this.socket.id) {
        // if not in dictionary
        if (!netObject.users[m.id]) {
          // create a new player
          console.log("new user", m.id);
          netObject.users[m.id] = {};
          console.log("other users", netObject.users);

          let players = document.getElementById("container");
          players.innerHTML += `<div class="players" id="player-${m.id}">-${m.id}<div>`;
        }
        netObject.users[m.id].posrot = m.posrot;
      }
    });
  };
}

let netObject = new NetObject();
// window maybe?


netObject.init();

let myself = {};

let users = netObject.users;

setInterval(() => {
  // iterate through dictinary (which is not an array)
  Object.keys(users).forEach((key) => {
    // if not me
    if (key != netObject.socket.id) {
      const u = users[key];
      let id = "player-" + key;
      let player = document.getElementById(id);
      // has coordinates
      if (u.posrot) {
        let x = 200 + u.posrot[0] * 10;
        let y = 200 + u.posrot[1] * 10;

        // move the other players
        player.style.top = x + "px";
        player.style.left = y + "px";
      }
    }
  });
}, FREQ);

setInterval(() => {
  // send my position
  netObject.sendData(myself);
}, FREQ);

setInterval(() => {
  // just monitor the coordinates, not really needed
  info.innerText = JSON.stringify({ ...netObject.users });
}, 500);


function doInteract(msg) {
  // global world object update, like a click on a cube
  world[2] += 1;
  netObject.socket.emit("world-to-server", world);
}

setInterval(() => {
  // create random position every second, so we see some changes
  let pos, rot;

  let rx = Math.random() * 10;
  let ry = Math.random() * 10;
  pos = { x: rx, y: ry, z: 3 };
  rot = { x: 0, y: 0, z: 0 };
  myself.posrot = [
    pos.x.toFixed(2),
    pos.y.toFixed(2),
    pos.z.toFixed(2),
    rot.x.toFixed(2),
    rot.y.toFixed(2),
    rot.z.toFixed(2),
    0,
  ];
}, 1000);
