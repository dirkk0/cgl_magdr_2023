
import * as THREE from 'three';
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';


const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.shadowMap.enabled = true
renderer.shadowMap.type = THREE.VSMShadowMap;
renderer.toneMapping = THREE.ACESFilmicToneMapping;

document.body.appendChild(renderer.domElement);
// document.querySelector("#test").appendChild(renderer.domElement)


const geometry = new THREE.BoxGeometry(1, 1, 1);
const material = new THREE.MeshBasicMaterial({ color: "yellow", wireframe: true });
const cube = new THREE.Mesh(geometry, material);
scene.add(cube);

// const ambLight = new THREE.AmbientLight("white", 0.2)
// scene.add(ambLight)

const dirLight = new THREE.DirectionalLight("white", 2.5)
dirLight.position.set(-5, 5, -1)
dirLight.castShadow = true

dirLight.shadow.camera.near = 0.01;
dirLight.shadow.camera.far = 500;
dirLight.shadow.camera.right = 30;
dirLight.shadow.camera.left = - 30;
dirLight.shadow.camera.top = 30;
dirLight.shadow.camera.bottom = - 30;
dirLight.shadow.mapSize.width = 1024;
dirLight.shadow.mapSize.height = 1024;
dirLight.shadow.radius = 4;
dirLight.shadow.bias = -0.00006;


scene.add(dirLight)

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





camera.position.z = 15;
camera.rotation.y = -1;

// setInterval(() => {
//     // console.log("does it?")
//     cube.rotation.x += 0.01;
//     cube.rotation.y += 0.01;
//     renderer.render(scene, camera);
// }, 1);


function update() {
    requestAnimationFrame(update);

    cube.rotation.x += 0.01;
    cube.rotation.y += 0.01;

    camera.position.z -= 0.01;

    renderer.render(scene, camera);
}

update();
