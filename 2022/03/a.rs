use std::fs;
use std::collections::HashMap;

fn main() {
    let input = fs::read_to_string("input").unwrap();
    let input: Vec<_> = input.trim().split('\n').collect();
    let mut score = 0;


    for item in input {
        get_score(item.to_string(), &mut score);
    }

    //println!("{:?}", input);
    println!("{}", score);
    //println!("{:?}", get_priority(i32::from(b'A')));
}

fn get_score(pack: String, score: &mut i32) {
    let mut set = HashMap::<i32, i32>::new();
    let half = pack.len() / 2;
    let first_half = &pack[..half];
    let second_half = &pack[half..];


    for item in first_half.chars() {
        set.insert(item as i32, 0);
    }

    for item in second_half.chars() {
        let item_pointer = item as i32;
        if let Some(val) = set.get_mut(&item_pointer) {
            if *val == 0 {
                let priority = get_priority(item as i32);
                //println!("{}", priority);
                *score += priority;
            }
            *val += 1;
        }
    }
    //println!("{}, {}", first_half, second_half);
    //println!("{:?}, {}", set, score);
}

fn get_priority(item: i32) -> i32 {
    if item <= 122 && item >= 97 {
        return item - 96;
    }
    else {
        return item - 65 + 27;
    }
}

