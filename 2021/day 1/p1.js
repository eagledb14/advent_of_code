let fs = require('fs');

let biggerThan = 0;
let last;

let inData = [];

try {
    let data = fs.readFileSync("input.txt", "utf8");
    inData = data.split("\r\n");
}
catch (err) {
    console.log(err);
}

for (let s of inData) {
    if (!last) {
        last = parseInt(s);
        continue;
    }

    if (parseInt(s) > last) {
        biggerThan++;
    }

    last = parseInt(s);
}

console.log(biggerThan);