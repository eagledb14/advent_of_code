use std::fs;
use std::collections::HashSet;
use std::time::Instant;

fn main() {
    let now = Instant::now();
    let input = fs::read_to_string("input").expect("");
    //println!("{}", &input);
    println!("{}", find_start_packet(&input));
    println!("{:?}", now.elapsed());
}


fn find_start_packet(signal: &String) -> i32 {
    let mut set = Vec::<char>::new();


    for (i, c) in signal.chars().enumerate() {
        if set.len() == 4 {
            if check_duplicate(&set) {
                set.remove(0);
                set.push(c);
            }
            else {
                return i as i32
            }
        }
        else { 
            set.push(c);
        }
    }
    0
}


fn check_duplicate(set: &Vec<char>) -> bool {
    let mut map = HashSet::<char>::new();
    
    for c in set {
        if !map.insert(*c) { 
            return true;
        }
    }
    return false;
}
