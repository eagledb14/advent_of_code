use std::fs;
use std::collections::HashMap;

fn main() {
    let input = fs::read_to_string("input").unwrap();
    let input: Vec<_> = input.trim().split('\n').collect();
    let mut score = 0;


    for item in (0..input.len() - 2).step_by(3) {
        //get_score(item.to_string(), &mut score);
        get_score(input[item].to_string(), input[item + 1].to_string(), input[item + 2].to_string(), &mut score);
    }

    //println!("{:?}", input);
    println!("{}", score);
    //println!("{:?}", get_priority(i32::from(b'A')));
}

fn get_score(pack1: String, pack2: String, pack3: String, score: &mut i32) {
    let mut set = HashMap::<i32, bool>::new();
    let mut set2 = HashMap::<i32, bool>::new();

    for item in pack1.chars() {
        set.insert(item as i32, false);
    }

    for item in pack2.chars() {
        let item_pointer = item as i32;
        if let Some(val) = set.get_mut(&item_pointer) {
            //let priority = get_priority(item as i32);
            set2.insert(item as i32, false);
            *val = true;
        }
    }

    for item in pack3.chars() {
        let item_pointer = item as i32;
        if let Some(val) = set2.get_mut(&item_pointer) {
            if *val == false {
                let priority = get_priority(item as i32);
                //println!("{}", priority);
                *score += priority;
            }
            *val = true;
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

