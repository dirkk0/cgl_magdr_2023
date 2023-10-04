

import * as THREE from 'three';

function lights(scene) { // object
    this.init = () => { // method
        console.log("lights init")

        const ambLight = new THREE.AmbientLight("white", 0.2)
        scene.add(ambLight)

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
    }
    this.init()
}

export default lights