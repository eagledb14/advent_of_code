const { count } = require("console");
const { sign } = require("crypto");
let fs = require("fs");

let data = fs.readFileSync("single.txt", "utf8");

let list = data.split(/\r+\n+/);
// console.log(list);

let zero = "abcefg";
let one = "cf";
let two = "acdeg";
let three = "acdfg";
let four = "bcdf";
let five = "abdfg";
let six = "abdefg";
let seven = "acf";
let eight = "abcdefg";
let nine = "abcdfg";

let a;
let b;
let c;
let d;
let e;
let f;
let g;

//6- zero, six, nine
//5- two, three, five

//zero - no d 
//six - e
//nine - c

//two - e
//three - not e or b
//five - b

let sortedMap = new Map();
let fiveMap = new Map();
let sixMap = new Map();

let totalUnique = 0;

for (let row of list) {
    splitRow(row);
}

function splitRow(row) {
    let splitRow = row.split(/\W| \| /);
    let signals = splitRow.slice(0, 10);
    let display = splitRow.slice(12, 16);

    signals = sortAlphabetically(signals);
    display = sortAlphabetically(display);
    // console.log(display);
    findDigitsFromSignal(signals);
    countOutput(display);
}

function sortAlphabetically(array) {
    let newArray = [];
    for (let a of array) {
        a = a.split("").sort().join("");
        newArray.push(a);
    }
    return newArray.sort();
} 

function findDigitsFromSignal(signal) {
    // let sortedMap = new Map();
    // let fiveMap = new Map();
    // let sixMap = new Map();

    for (let s of signal) {
        switch (s.length) {
            case one.length:
                sortedMap.set(s, 1);
                break;
            case four.length:
                sortedMap.set(s, 4);
                break;
            case five.length:
                console.log("five length")
                parseLengthFive(s);
                break;
            case seven.length:
                sortedMap.set(s, 7);
                break;
            case eight.length:
                sortedMap.set(s, 8)    ;
                break;
            default:
                break;
        }
    }

    console.log(sortedMap);
}

function parseLengthFive(input) {
    //fiveMap
    console.log("five");

    for(let s of input) {
        if (!fiveMap.has(s)) {
            fiveMap.set(s, 0);
        }
        fiveMap.set(s, fiveMap.get(s) + 1);
    }

}

function countOutput(out) {
    
    for (let o of out) {
        if (o.length === one.length || o.length === four.length || o.length === seven.length || o.length === eight.length) {
            totalUnique++;
        }
    }
}

console.log(totalUnique);
// let out = "asdfaweg";

// console.log(out.split("").sort().join(""));

console.log(fiveMap);