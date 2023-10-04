
import * as THREE from 'three';
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';

import lights from "./lights.js"
import Cubes from "./cubes.js"


const scene = new THREE.Scene();

const light = new lights(scene)

const cubes = new Cubes(scene)

scene.background = new THREE.Color(0x88ccee)
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.shadowMap.enabled = true
renderer.shadowMap.type = THREE.VSMShadowMap;
renderer.toneMapping = THREE.ACESFilmicToneMapping;

document.body.appendChild(renderer.domElement);
// document.querySelector("#test").appendChild(renderer.domElement)





const loader = new GLTFLoader()

const path = "https://threejs.org/examples/models/gltf/collision-world.glb"
loader.load(path, (gltf) => {
    console.log(gltf)

    gltf.scene.traverse((child) => {
        if (child.isMesh) {
            child.castShadow = true
            child.receiveShadow = true
        }

    })
    // gltf.scene.children[0].castShadow = true
    // gltf.scene.children[0].receiveShadow = true
    scene.add(gltf.scene)
})


// hoisting
test1()
function test1() {
    console.log("hello world")
}

// test2 ()
const test2 = function () {
    console.log("hell word")
}

const test3 = () => {
    console.log("hello hoisting")
}

// arrow function
// setInterval(() => {
//     console.log(this)
// }, 500);





camera.position.z = 5;
// camera.rotation.y = -1;

// setInterval(() => {
//     // console.log("does it?")
//     cube.rotation.x += 0.01;
//     cube.rotation.y += 0.01;
//     renderer.render(scene, camera);
// }, 1);


// let gameObjects = [cubes, enemies,]

function update() {
    requestAnimationFrame(update);


    cubes.update()

    // gameObjects.forEach(element => {
    //     element.update()
    // });

    camera.position.z -= 0.001;

    renderer.render(scene, camera);
}

update();
