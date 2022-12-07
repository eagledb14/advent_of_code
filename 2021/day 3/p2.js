let fs = require("fs");

let data = fs.readFileSync("input.txt", "utf8");

let oxygen = [];
let carbon = [];

oxygen = data.split("\r\n");

function findGreaterOxygen(data, i) {
    let count = 0;

    for (let s of data) {
        if (s[i] === "1") {
            count += 1;
        }
        else {
            count -= 1;
        }

    }

    if (count >= 0) {
        return "1";
    }
    else {
        return "0";
    }
}

for (let i = 0; i < oxygen[0].length; i++) {
    if (oxygen.length === 1) break;
    let greater = findGreaterOxygen(oxygen, i);

    for (let j = 0; j < oxygen.length; j++) {
        if (oxygen[j][i] !== greater) {
            oxygen.splice(j,1);
            j--;
        }
    }
}

console.log(oxygen[0]);

carbon = data.split("\r\n");

function findGreaterCarbon(data, i) {
    let count = 0;

    for (let s of data) {
        if (s[i] === "1") {
            count += 1;
        }
        else {
            count -= 1;
        }

    }

    if (count > 0) {
        return "1";
    }
    else {
        return "0";
    }
}

for (let i = 0; i < carbon[0].length; i++) {
    if (carbon.length === 1) break;
    let greater = findGreaterCarbon(carbon, i);

    for (let j = 0; j < carbon.length; j++) {
        if (carbon[j][i] === greater) {
            carbon.splice(j,1);
            j--;
        }
    }
}

console.log(carbon[0]);

console.log(parseInt(carbon[0], 2) * parseInt(oxygen[0], 2));