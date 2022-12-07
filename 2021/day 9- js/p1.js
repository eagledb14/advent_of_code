let fs = require('fs');
const { parse } = require('path');

let data = fs.readFileSync("in.txt", "utf8");

let listString = data.split(/\D/);
// let list = [];

// console.log(listString);

function parseMatrix(list) {
    let matrix = [];

    for (let i = 0; i < list.length; i++) {
        if ((i % 2) === 0) {
            let tempList = [];
            tempList = list[i].split("");
            matrix.push(tempList);
        }
    }

    // console.log(matrix);
    return matrix;
}

function findSmallNumbers(matrix) {
    let smallNums = [];

    for (let i = 0; i < matrix.length; i++) {
        for (let j = 0; j < matrix[i].length; j++) {
            let topBool = true;
            let botBool = true;
            let leftBool = true;
            let rightBool = true;

            let center = parseInt(matrix[i][j]);

            if (i > 0) {
                topBool = (center < parseInt(matrix[i - 1][j]));
            }

            if (i < matrix.length - 1) {
                botBool = (center < parseInt(matrix[i + 1][j]));
            }

            if (j > 0) {
                leftBool = (center < parseInt(matrix[i][j - 1]));
            }

            if (j < matrix[i].length - 1) {
                rightBool = (center < parseInt(matrix[i][j + 1]));
            }

            if (topBool && botBool && leftBool && rightBool) {
                smallNums.push(parseInt(matrix[i][j]));
            }

        }
    }

    return smallNums;
}

function addSmallNums(nums) {
    let total = 0;

    nums.forEach( (num) => {
        total += num + 1;
    })
    return total;
}


let matrix = parseMatrix(listString);
let smallNums = findSmallNumbers(matrix);
console.log(addSmallNums(smallNums));
