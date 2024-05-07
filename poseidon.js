
const circomlibjs = require("circomlibjs");

(async function () {
    const poseidon = await circomlibjs.buildPoseidon();
    const hash = poseidon.F.toString(poseidon([1, 2]));
    console.log(hash);

})()