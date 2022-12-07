let fs = require("fs");

let commands = [];

let aim = 0;
let pos = 0;
let depth = 0;

try {
    let data = fs.readFileSync("input.txt", "utf8");
    commands = data.split("\r\n");
}
catch (err) {
    console.log(err);
}

for (let s of commands) {
    let num = parseInt(s[s.length - 1]);

    if (s[0] === 'f') {
        forward(num);
    }
    else if (s[0] === 'd') {
        down(num);
    }
    else if (s[0] === 'u') {
        up(num);
    }
}

function forward(num) {
    pos += num;
    depth += num * aim;
}

function up(num) {
    aim -= num;
}

function down(num) {
    aim += num;
}

console.log(pos, depth, aim);
console.log(pos * depth);