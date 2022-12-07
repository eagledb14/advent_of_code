let fs = require('fs');

let data = fs.readFileSync("in.txt", "utf8");

let listString = data.split(/\D/);
let list = [];

listString.forEach( (value) => {
    list.push(parseInt(value));
})

list.sort((a,b) => {
    return a - b
});

let medNum = Math.round(list.length / 2);
let median = list[medNum];


let total = 0;
for (let num of list) {
    total += num
}

let mean = Math.floor(total / list.length);

let modeList = new Map();

for (let n of list) {
    if (!modeList.has(n)) {
        modeList.set(n, 0);
    }

    modeList.set(n, modeList.get(n) + 1);
}

let mode = {
    num: 0,
    occurance: 0
};
modeList.forEach( (value, key) => {
    if (mode.occurance < value) {
        mode.num = key;
        mode.occurance = value; 
    }
})

function getFuel(pos) {
    let fuelTotal = 0;

    for (let n of list) {
        let distance = Math.abs(pos - n);

        fuelTotal += ( distance * (distance + 1) ) / 2;
    }
    return fuelTotal;
}

console.log("\nmean: " + mean + " : " + getFuel(mean));
console.log("median: " + median + " : " + getFuel(median));
console.log("mode: " + mode.num + " : " + getFuel(mode.num));