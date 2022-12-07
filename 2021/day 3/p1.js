let fs = require("fs");


let data = fs.readFileSync("input.txt", "utf8");
let binary = data.split("\r\n");

let gamma = "";
let epsilon = "";

let countOne = new Array(12).fill(0);
let countZero = new Array(12).fill(0);


for (let s of binary) {
   for (let i = 0; i < s.length; i++) {
       if (parseInt(s[i]) === 0) {
           countZero[i] += 1;
       }

       if (parseInt(s[i]) === 1) {
           countOne[i] += 1;
       }
   }

}

for (let i = 0; i < countZero.length; i++) {
    if (countZero[i] > countOne[i]) {
        gamma += "0";
        epsilon += "1";
    }
    else {
        gamma += "1";
        epsilon += "0";
    }
}

console.log(countZero);
console.log(countOne);

console.log(parseInt(gamma, 2));
console.log(parseInt(epsilon, 2));
console.log(parseInt(gamma, 2) * parseInt(epsilon, 2));
