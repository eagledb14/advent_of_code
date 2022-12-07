use std::fs;
use std::time::Instant;

fn main() {
    let now = Instant::now();
    let input = fs::read_to_string("input").expect("");
    let input = input.trim().lines().map(|line| line.trim().split(" ").collect::<Vec<_>>()).collect::<Vec<_>>();


    let mut directory_stack = Vec::<i32>::new();
    let mut out_size = 0;

    for line in input {
        if let Ok(number) = line[0].parse::<i32>() {
            add_parents(number, &mut directory_stack);
        }
        
        if line[1] == "cd" {
            if line[2] == ".." {
                let size_of_directory = directory_stack.pop().unwrap();

                if size_of_directory <= 100000 {
                    out_size += size_of_directory;
                }
            }
            else {
                directory_stack.push(0);
            }
        }
    }

    println!("{:#?}", directory_stack);
    println!("{}", out_size);
    println!("{:?}", now.elapsed());
}

fn add_parents(add_by: i32, directories: &mut Vec<i32>) {
    for size in directories {
        *size += add_by;
    }
}

