use std::fs;

fn main() {
    let input = fs::read_to_string("input");
    let input = match input {
        Ok(res) => res,
        Err(_) => panic!("read err")
    };

    let input: Vec<_> = input.trim().split("\n").collect();
    let mut map = vec![vec!["".to_string(); input[0].len()]; input.len()];

    for (i, val1) in input.iter().enumerate() {
        for (j, val2) in val1.chars().enumerate() {
            map[i][j] = val2.to_string();
        }
    }
    
    //println!("{:?}", map);
    println!("{}", loop_cucumbers(map));

}

fn loop_cucumbers(mut map: Vec<Vec<String>>) -> i32 {
    let mut iterations: i32 = 0;

    loop {
        iterations += 1;
        let east_res: bool;
        let south_res: bool;


        (east_res, map) = move_east(&mut map);
        (south_res, map) = move_south(&mut map);
        if (east_res || south_res) == false {
            break;
        }
    }

    iterations
}

fn move_east(map: &mut Vec<Vec<String>>) -> (bool, Vec<Vec<String>>) {
    let mut cucumber_moved = false;
    let mut new_map = map.clone();

    for i in 0..map.len() {
        let row_len = map[i].len();
        for j in 0..row_len {
            if map[i][j] == ">".to_string() && map[i][(j + 1) % row_len] == ".".to_string() {
                cucumber_moved = true;
                new_map[i][j] = map[i][(j + 1) % row_len].clone();
                new_map[i][(j + 1) % row_len] = map[i][j].clone();
            }
        }
    }

    (cucumber_moved, new_map)
}

fn move_south(map: &mut Vec<Vec<String>>) -> (bool, Vec<Vec<String>>) {
    let mut cucumber_moved = false;
    let mut new_map = map.clone();

    let column_len = map.len();
    for i in 0..column_len {
        let row_len = map[i].len();
        for j in 0..row_len {
            if map[i][j] == "v".to_string() && map[(i + 1) % column_len][j] == ".".to_string() {
                cucumber_moved = true;
                new_map[i][j] = map[(i + 1) % column_len][j].clone();
                new_map[(i + 1) % column_len][j] = map[i][j].clone();
            }
        }
    }

    (cucumber_moved, new_map)
}
