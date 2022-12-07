let fs = require('fs');

let data = fs.readFileSync("input.txt", "utf8");
let parsedData = data.split("\r\n\r\n");

let bingoNums = parsedData.splice(0, 1)[0].split(",");

let boards = [];
let bingoBoard;
let finalNum = 0;

for (let s of parsedData) {
    let tempArr = s.split(/\D/);
    let newArr = [];
    for (let a of tempArr) {
        if (Number.isInteger(parseInt(a))) {
            newArr.push(a);
        }
    }
    
    boards.push(newArr);
}

start();
function start() {
    for (let num of bingoNums) {
        for (let i = 0; i < boards.length; i++) {
            addNum(boards[i], num);
            if (checkBingo(boards[i])) {
                if (boards.length <= 1) {
                    finalNum = num;
                    return; 
                }
                boards.splice(i,1);
                i--;
            }
        }
    }
}

function addNum(board, num) {
    for (let i = 0; i < board.length; i++) {
        if (board[i] === num) {
            board[i] = "x" + board[i];
        }
    }
}

function checkBingo(board) {
    for (let i = 0; i <= board.length - 5; i += 5) {
        if (board[i].includes('x') && board[i + 1].includes('x') && board[i + 2].includes('x') && board[i + 3].includes('x') && board[i + 4].includes('x')) {
            return true;
        }
    }

    for (let i = 0; i < 5; i++) {
        if (board[i].includes('x') && board[i + 5].includes('x') && board[i + 10].includes('x') && board[i + 15].includes('x') && board[i + 20].includes('x')) {
            return true;
        }
    }

    return false;
}

let bigNum = 0;
bingoBoard = boards[0];
for (let a of bingoBoard) {
    if (!a.includes("x")) {
        bigNum += parseInt(a);
    }
}

let answer = bigNum * finalNum;
console.log(answer);

// console.log(boards);
