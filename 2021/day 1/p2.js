let fs = require('fs');

let inData = [];
let biggerThan = 0;

try {
    let data = fs.readFileSync("input.txt", "utf8");
    inData = data.split("\r\n");
}
catch(err) {
    console.log(err);
}

// currentSlide = parseInt(inData[0]) + parseInt(inData[1]) + parseInt(inData[2]);

for (let i = 3; i < inData.length; i++) {
    let lastSlide = parseInt(inData[i - 3]) + parseInt(inData[i - 2]) + parseInt(inData[ i - 1]);
    let currentSlide = parseInt(inData[ i - 2]) + parseInt(inData[i - 1]) + parseInt(inData[i]);

    if (currentSlide > lastSlide) {
        biggerThan++;
    }
}

console.log(biggerThan);
