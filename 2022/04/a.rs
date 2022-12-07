use std::fs;

fn main() {
    let input = fs::read_to_string("input").unwrap();
    let input = input.trim().lines().map(|pair| pair.split(&['-', ',']).collect::<Vec<_>>()).collect::<Vec<_>>();
    let mut score = 0;

    for pairs in &input {
        if check_pairs(pairs.into_iter().map(|x| x.parse::<i32>().unwrap()).collect::<Vec<_>>()) {
            score += 1;
        }
    }
    println!("{}", score);
    //println!("{:?}", input);
}


fn check_pairs(pairs: Vec<i32>) -> bool {
    if pairs[0] <= pairs[2] && pairs[1] >= pairs[3] ||
        pairs[2] <= pairs[0] && pairs[3] >= pairs[1] {
        return true;
    }
    return false;
}
