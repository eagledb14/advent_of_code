let fs = require("fs");

let data = fs.readFileSync("in.txt", "utf8");
let list = data.split(/\D/);

let school = new Map();

let maxDays = 256;
let totalFish = 0;

for (let fish of list) {
    fish = parseInt(fish);

    if (!school.has(fish)) {
        school.set(fish, 0);
    }

    let fishNum = school.get(fish);
    school.set(fish, fishNum + 1);
}
console.log(school);

for (let i = 0; i < maxDays; i++) {
    let tempSchool = new Map();

    school.forEach( (value, key) => {
        
        if (key !== 0) {
            let oldFish = 0;
            if (tempSchool.has(key - 1)) {
                oldFish = tempSchool.get(key - 1);
            }

            tempSchool.set(key - 1, oldFish + value);
            return;
        }
        let six = 0;
        let eight = 0;

        if (tempSchool.has(6)) {
            six = tempSchool.get(6);
        }

        if (tempSchool.has(8)) {
            eight = tempSchool.get(8);
        }

        tempSchool.set(6, six + value);
        tempSchool.set(8, eight + value);
    })

    school = tempSchool;
}

console.log(school);

school.forEach( (value) => {
    totalFish += value;
});
console.log(totalFish);