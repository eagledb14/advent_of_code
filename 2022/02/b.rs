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
        "A X" => *score += 3,
        "A Y" => *score += 4,
        "A Z" => *score += 8,

        "B X" => *score += 1,
        "B Y" => *score += 5,
        "B Z" => *score += 9,

        "C X" => *score += 2,
        "C Y" => *score += 6,
        "C Z" => *score += 7,
        
        _ => panic!("bad input")
    }
}
