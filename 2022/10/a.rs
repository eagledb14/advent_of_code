use std::fs;

fn main() {
    let input = fs::read_to_string("input").expect("");
    let mut input: Vec<Vec<&str>> = input.trim().lines().map(|line| line.trim().split(" ").collect()).collect();

    let mut cycle = 0;
    let mut x = 1;
    let mut score = 0;

    for instruction in input {
        tick(x, &mut cycle, &mut score);
        if instruction[0] == "addx" {
            tick(x, &mut cycle, &mut score);
            x += instruction[1].parse::<i32>().unwrap();
        }
    }

    println!("{}, {}", x, cycle);
    println!("{}", score);
}

fn tick(x: i32, cycle: &mut i32, score: &mut i32) {
    *cycle += 1;
    if (*cycle - 20) % 40 == 0 {
        *score += *cycle * x;
    }
}

