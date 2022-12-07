use std::fs;

fn main() {
    let input_stacks = fs::read_to_string("stacks").expect("");
    let input_stacks = input_stacks.lines().collect::<Vec<_>>();

    let input_moves = fs::read_to_string("moves").expect("");
    let input_moves = input_moves
        .lines()
        .map( |line| line.split(" ").collect::<Vec<_>>())
        .collect::<Vec<_>>();

    let mut moves = Vec::<i32>::new();
    for i in input_moves {
        for j in i {
            if let Ok(val) = j.parse::<i32>() {
                moves.push(val);
            }
        }
    }
    let input_moves = moves.clone();


    let mut stacks = Vec::<Vec<char>>::new();
    initialize_stacks(&mut stacks, &input_stacks);

    for i in (0..input_moves.len() - 2).step_by(3) {
        move_stack(input_moves[i], input_moves[i + 1], input_moves[i + 2], &mut stacks);
    }

    let mut out_string = String::new();
    println!("{:?}", stacks);

    for stack in stacks {
        out_string = format!("{}{}", out_string, stack.last().unwrap());
    }
    println!("{}", out_string);
    
}


fn initialize_stacks(stacks: &mut Vec<Vec<char>>, input: &Vec<&str>) {
    for stack in input.into_iter() {
        let mut new_stack = Vec::<char>::new();

        for s in stack.chars() {
            new_stack.push(s);
        }
        stacks.push(new_stack);
    }
}


fn move_stack(num: i32, from_place: i32, to_place: i32, stacks: &mut Vec<Vec<char>>) {
    let mut temp_stack = Vec::<char>::new();

    for _ in 0..num {
        if let Some(val) = stacks[(from_place - 1) as usize].pop() {
            temp_stack.push(val);
        }
    }

    temp_stack.reverse();
    stacks[(to_place - 1) as usize].append(&mut temp_stack);
}
