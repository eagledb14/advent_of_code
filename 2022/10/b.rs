use std::fs;
use std::io;
use std::io::Write;

fn main() {
    let input = fs::read_to_string("input").expect("");
    let input: Vec<Vec<&str>> = input.trim().lines().map(|line| line.trim().split(" ").collect()).collect();

    let mut cycle = 0;
    let mut x = 1;


    for instruction in input {
        tick(x, &mut cycle);
        if instruction[0] == "addx" {
            tick(x, &mut cycle);
            x += instruction[1].parse::<i32>().unwrap();
        }
    }

    println!("{}, {}", x, cycle);
}

fn tick(x: i32, cycle: &mut i32) {
    if (x - *cycle).abs() < 2 {
        print!("█");
    }
    else {
        print!(" ");
    }

    *cycle += 1;
    if *cycle == 40 {
        print!("\n");
        *cycle = 0;
        //*score += *cycle * x;
    }

    io::stdout().flush().unwrap();
}

