use std::fs;
use std::time::Instant;

fn main() {
    let now = Instant::now();
    let input = fs::read_to_string("input").expect("");
    let input = input.trim().lines().map(|line| line.trim().split("").collect::<Vec<_>>().into_iter().filter(|x| *x != "").collect::<Vec<_>>()
                                         .into_iter()
                                         .map(|x| x.parse::<i32>()
                                              .unwrap()).collect::<Vec<_>>()).collect::<Vec<_>>();
    let mut scenic_score = 0;
    let height = input.len();
    let width = input[0].len();

    for i in 1..height {
        for j in 1..width {
            scenic_score = i32::max(get_visibility((i,j), &input), scenic_score);
        }
    }

    println!("{scenic_score}");
    println!("{:?}", now.elapsed());
}

fn get_visibility(index: (usize, usize), trees: &Vec<Vec<i32>>) -> i32 {
    let width = trees.len();
    let height = trees[0].len();
    let mut visibilty_score = 1;

    //down
    let mut side_score = 0;
    for i in (index.0 + 1)..width {
        side_score += 1;
        if trees[i][index.1] >= trees[index.0][index.1] {
            break;
        }
    }
    visibilty_score *= side_score;
    
    //up
    let mut side_score = 0;
    for i in (0..(index.0)).rev() {
        side_score += 1;
        if trees[i][index.1] >= trees[index.0][index.1] {
            break;
        }
    }
    visibilty_score *= side_score;

    //left
    let mut side_score = 0;
    for i in (0..(index.1)).rev() {
        side_score += 1;
        if trees[index.0][i] >= trees[index.0][index.1] {
            break;
        }
    }
    visibilty_score *= side_score;

    //right
    let mut side_score = 0;
    for i in (index.1 + 1 )..height {
        side_score += 1;
        if trees[index.0][i] >= trees[index.0][index.1] {
            break;
        }
    }
    visibilty_score *= side_score;


    visibilty_score
}
