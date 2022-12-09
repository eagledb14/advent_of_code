use std::fs;
use std::time::Instant;
use std::collections::HashSet;

fn main() {
    let now = Instant::now();
    let input = fs::read_to_string("input").expect("");
    let input = input.trim().lines().map(|line| line.trim().split(" ").into_iter().collect::<Vec<_>>()).collect::<Vec<_>>();
    let mut intructions = input.iter().map(|x| (x[0], x[1].parse::<i32>().unwrap())).collect::<Vec<_>>();

    let mut movements = HashSet::<(i32, i32)>::new();
    let mut h = (0, 0);
    let mut t = (0, 0);

    for step in &mut intructions {
        while step.1 > 0 {
            step.1 -= 1;
            manage_position(step.0, &mut h);
            //println!("{:?}", h);
            if (h.0 != t.0) && (h.1 != t.1) && ((h.0 - t.0).abs() >= 2 || (h.1 - t.1).abs() >= 2) {
                t.0 += 1 * ((h.0 - t.0) / (h.0 - t.0).abs());
                t.1 += 1 * ((h.1 - t.1) / (h.1 - t.1).abs());
                movements.insert(t.clone());
                continue;
            }

            if (h.0 - t.0) >= 2 {
                t.0 += 1;
            }
            else if (t.0 - h.0) >= 2 {
                t.0 -= 1;
            }
            
            if (h.1 - t.1) >= 2 {
                t.1 += 1;
            }
            else if (t.1 - h.1) >= 2 {
                t.1 -= 1;
            }
            movements.insert(t.clone());

            //println!("{:?} {:?}", h, t);
        }
        
    }
    
    //println!("{:?}", &intructions);
    //println!("\n{:?}", movements);
    println!("{}", movements.len());
    println!("{:?}", now.elapsed());
}



fn manage_position(direction: &str, position: &mut (i32, i32)) {
    match direction {
        "U" => position.0 += 1,
        "D" => position.0 -= 1,
        "L" => position.1 -= 1,
        "R" => position.1 += 1,
        _ => panic!("bad match input read")
    }
}
