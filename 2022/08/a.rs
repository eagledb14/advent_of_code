use std::fs;
use std::time::Instant;

fn main() {
    let now = Instant::now();
    let input = fs::read_to_string("input").expect("");
    let input = input.trim().lines().map(|line| line.trim().split("").collect::<Vec<_>>().into_iter().filter(|x| *x != "").collect::<Vec<_>>()
                                         .into_iter()
                                         .map(|x| x.parse::<i32>()
                                              .unwrap()).collect::<Vec<_>>()).collect::<Vec<_>>();

    let mut num_visible = 0;
    let height = input.len();
    let width = input[0].len();

    for i in 1..height - 1 {
        for j in 1..width - 1{
            if get_visibility((i, j), &input) {
                num_visible += 1;
            }
        }
    }

    let outside_num = height * 2 + (width - 2) * 2;
    num_visible += outside_num;

    println!("{num_visible}");
    println!("{:?}", now.elapsed());
}

fn get_visibility(index: (usize, usize), trees: &Vec<Vec<i32>>) -> bool {
    let width = trees.len();
    let height = trees[0].len();
    let mut can_see = true;

    //down
    for i in (index.0 + 1)..width {
        if trees[i][index.1] >= trees[index.0][index.1] {
            can_see = false;
            break;
        }
    }
    
    if can_see {
        return can_see;
    }
    
    //up
    can_see = true;
    for i in 0..(index.0) {
        if trees[i][index.1] >= trees[index.0][index.1] {
            can_see = false;
            break;
        }
    }

    if can_see {
        return can_see;
    }

    //left
    can_see = true;
    for i in 0..(index.1) {
        if trees[index.0][i] >= trees[index.0][index.1] {
            can_see = false;
            break;
        }
    }

    if can_see {
        return can_see;
    }
    
    //right
    can_see = true;
    for i in (index.1 + 1 )..height {
        if trees[index.0][i] >= trees[index.0][index.1] {
            can_see = false;
            break;
        }
    }

    can_see
}
