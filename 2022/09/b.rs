use std::fs;
use std::time::Instant;
use std::collections::HashSet;

fn main() {
    let now = Instant::now();
    let input = fs::read_to_string("test_input").expect("");
    let input = input.trim().lines().map(|line| line.trim().split(" ").into_iter().collect::<Vec<_>>()).collect::<Vec<_>>();
    let mut intructions = input.iter().map(|x| (x[0], x[1].parse::<i32>().unwrap())).collect::<Vec<_>>();

    let mut movements = HashSet::<(i32, i32)>::new();
    let mut rope = vec![(0,0); 10];

    for step in &mut intructions {
        while step.1 > 0 {
            step.1 -= 1;
            manage_position(step.0, &mut rope[0]);

            //println!("{:?}", rope[i - 1]);
            for i in 1..=9 {
                if (rope[i - 1].0 != rope[i].0) && (rope[i - 1].1 != rope[i].1) && ((rope[i - 1].0 - rope[i].0).abs() >= 2 || (rope[i - 1].1 - rope[i].1).abs() >= 2) {
                    rope[i].0 += 1 * ((rope[i - 1].0 - rope[i].0) / (rope[i - 1].0 - rope[i].0).abs());
                    rope[i].1 += 1 * ((rope[i - 1].1 - rope[i].1) / (rope[i - 1].1 - rope[i].1).abs());
                    movements.insert(rope[i].clone());
                    continue;
                }

                if (rope[i - 1].0 - rope[i].0) >= 2 {
                    rope[i].0 += 1;
                }
                else if (rope[i].0 - rope[i - 1].0) >= 2 {
                    rope[i].0 -= 1;
                }
                
                if (rope[i - 1].1 - rope[i].1) >= 2 {
                    rope[i].1 += 1;
                }
                else if (rope[i].1 - rope[i - 1].1) >= 2 {
                    rope[i].1 -= 1;
                }
                movements.insert(rope.last().unwrap().clone());
            }

            //prinrope[i]jln!("{:?} {:?}", rope[i - 1], rope[i]);
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
