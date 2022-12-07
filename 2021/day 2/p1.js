let fs = require("fs");

let commands = [];

let depth = 0;
let pos = 0;
let answer;


try {
    let data = fs.readFileSync("input.txt", "utf8");
    commands = data.split("\r\n");
}
catch(err) {
    console.log(err);
}

for (let s of commands) {
    if (s[0] === 'f') {
        forward(s);
    }
    else if (s[0] === 'd') {
        down(s);
    }
    else if (s[0] === 'u') {
        up(s);
    }
}


function forward(data) {
    let num = data[data.length - 1];
    pos += parseInt(num);
}

function up(data) {
    let num = data[data.length - 1];
    depth -= parseInt(num);
}

function down(data) {
    let num = data[data.length - 1];
    depth += parseInt(num);
}

console.log(pos, depth);
console.log(pos * depth);