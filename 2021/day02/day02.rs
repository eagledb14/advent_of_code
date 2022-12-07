use std::fs;

fn main() {
    let input = fs::read_to_string("input");

    let input = match input {
        Ok(result) => result,
        Err(_) => panic!("file not read")
    };

    let data = input.split(|s| s == ' ' || s == '\n').collect::<Vec<_>>();
    println!("{}", get_location(data));
} 

fn get_location(data: Vec<&str>) -> i32 {
    let mut depth = 0;
    let mut dist = 0;

    for i in (0..data.len() - 1).step_by(2) {
        let pos = data[i + 1].parse::<i32>().unwrap();

        match data[i] {
            "forward" => dist += pos,
            "down" => depth += pos,
            "up" => depth -= pos,
            _ => panic!("idk what this is")
        };
    }
    
    depth * dist
}
