use std::fs;

fn main() {
    let input = fs::read_to_string("input").unwrap();
    let input = input.trim().split("\n").collect::<Vec<_>>();

    let mut elf_food = vec![0; input.len()];
    let mut elf_index = 0;
    for calories in input {
        if calories == "" {
            elf_index += 1;
            continue;
        }
        
        elf_food[elf_index] += calories.parse::<i32>().unwrap();
    }
    
    elf_food.sort();

    elf_food.reverse();
    let elf_max = elf_food[0] + elf_food[1] + elf_food[2];
    println!("{:?}", elf_max);
}
