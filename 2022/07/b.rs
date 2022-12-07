use std::fs;
use std::time::Instant;

fn main() {
    let now = Instant::now();
    let input = fs::read_to_string("input").expect("");
    let input = input.trim().lines().map(|line| line.trim().split(" ").collect::<Vec<_>>()).collect::<Vec<_>>();

    let total_disk_space = 70000000;
    let needed_disk_space = 30000000;

    let mut directory_stack = Vec::<i32>::new();
    let mut out_directory = Vec::<i32>::new();

    for line in input {
        if let Ok(number) = line[0].parse::<i32>() {
            add_parents(number, &mut directory_stack);
        }
        
        if line[1] == "cd" {
            if line[2] == ".." {
                let size_of_directory = directory_stack.pop().unwrap();

                out_directory.push(size_of_directory);
            }
            else {
                directory_stack.push(0);
            }
        }
    }
    
    for size in directory_stack.into_iter() {
        out_directory.push(size);
    }
    out_directory.sort();
    
    let free_space = total_disk_space - out_directory.last().unwrap();
    for directory_size in out_directory.iter() {
        if free_space + directory_size >= needed_disk_space {
            println!("{}", *directory_size);
            break
        }
    }

    println!("{:?}", now.elapsed());
}

fn add_parents(add_by: i32, directories: &mut Vec<i32>) {
    for size in directories {
        *size += add_by;
    }
}

