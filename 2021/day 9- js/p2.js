let fs = require('fs');

let data = fs.readFileSync("in.txt", "utf8");

let listString = data.split(/\D/);
let list = [];
