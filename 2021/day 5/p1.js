let fs = require('fs');
let zeros = require('zeros');

let data = fs.readFileSync("in.txt", "utf8");

let parsedData = data.split(/\r\n/);

let coordinates = zeros([1000,1000]);

let intersections = 0;


for (let s of parsedData) {
    addToMatrix(s);
}

function addToMatrix(pair) {
    let coords = pair.split(/ -> |,/);
    // console.log(coords);

    let left = {
        x: parseInt(coords[0]),
        y: parseInt(coords[1])
    }

    let right = {
        x: parseInt(coords[2]),
        y: parseInt(coords[3])
    }

    if (left.x !== right.x && left.y !== right.y) return;

    // coordinates.set(right.x, right.y, coordinates.get(right.x, right.y) + 1);
    coordinates.set(left.x, left.y, coordinates.get(left.x, left.y) + 1);

    addToMatrixHelper(left, right)
}

function addToMatrixHelper(left, right) {
    if (JSON.stringify(left) === JSON.stringify(right)) return;

    let newLeft = {
        x: left.x,
        y: left.y
    }

    if (newLeft.x > right.x) {
        newLeft.x -= 1;
    }
    else if (newLeft.x < right.x) {
        newLeft.x += 1;
    }
    else if (newLeft.y > right.y) {
        newLeft.y -= 1;
    }
    else if (newLeft.y < right.y) {
        newLeft.y += 1;
    }

    coordinates.set(newLeft.x, newLeft.y, coordinates.get(newLeft.x, newLeft.y) + 1);
    
    addToMatrixHelper(newLeft, right);
}

// console.log(coordinates);

// for (let i = 0; i < coordinates.shape[0]; i++) {
//     let line = "";
//     for (let j = 0; j < coordinates.shape[1]; j++) {
//         line += coordinates.get(j,i).toString();
//     }
//     console.log(line);
// }


// console.log(parsedData);

for (let i = 0; i < coordinates.shape[0]; i++) {
    for (let j = 0; j < coordinates.shape[1]; j++) {
        if (coordinates.get(j, i) > 1) {
            intersections++;
        }
    }
}
console.log(intersections);
// console.log(coordinates);