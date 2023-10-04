

import * as THREE from 'three';

function Cubes(scene) {
    let cube = null
    this.init = () => {
        const geometry = new THREE.BoxGeometry(1, 1, 1);
        const material = new THREE.MeshBasicMaterial({ color: "yellow", wireframe: true });
        cube = new THREE.Mesh(geometry, material);
        scene.add(cube);
    }
    this.update = () => {
        // console.log(123)
        cube.rotation.x += 0.01;
        // this.cube.rotation.y += 0.01;
    }
    this.init()
}

export default Cubes