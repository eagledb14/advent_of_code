use std::fs;
use std::time::Instant;

fn main() {
    let now = Instant::now();
    let input = fs::read_to_string("test_input").expect("");
    println!("{}", &input);
    println!("{:?}", now.elapsed());
}