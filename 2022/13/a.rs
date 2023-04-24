use std::fs;
use std::time::Instant;

fn main() {
    let now = Instant::now();
    let input = fs::read_to_string("test_input").expect("");

    let input: Vec<_> = input.split("\n").filter(|&x| x != "").collect();

    println!("{:?}", &input);
    println!("{:?}", now.elapsed());
}
