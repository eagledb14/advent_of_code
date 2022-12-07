const { count } = require("console");
const { sign } = require("crypto");
let fs = require("fs");

let data = fs.readFileSync("in.txt", "utf8");

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
    // findDigitsFromSignal(signals);
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
    let sortedMap = new Map();

    for (let s of signal) {

        switch (s.length) {
            case one.length:
                sortedMap.set(1, s);
                break;
            case four.length:
                sortedMap.set(4, s);
                break;
            case seven.length:
                sortedMap.set(7, s);
                break;
            case eight.length:
                sortedMap.set(8, s)    ;
                break;
            default:
                break;
        }
    }

    console.log(sortedMap);
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