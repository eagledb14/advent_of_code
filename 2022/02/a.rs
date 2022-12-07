use std::fs;

fn main() {
    let input = fs::read_to_string("input").unwrap();
    let input: Vec<_> = input.trim().split("\n").collect();
    let mut score = 0;

    for pair in input {
        round_win(&mut score, pair.to_string());
    }
    println!("{:?}", score);
}


fn round_win(score: &mut i32, round: String) {
    match round.as_str() {
        "A X" => *score += 4,
        "A Y" => *score += 8,
        "A Z" => *score += 3,

        "B X" => *score += 1,
        "B Y" => *score += 5,
        "B Z" => *score += 9,

        "C X" => *score += 7,
        "C Y" => *score += 2,
        "C Z" => *score += 6,
        
        _ => panic!("bad input")
    }
}
