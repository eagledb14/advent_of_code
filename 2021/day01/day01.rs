use std::fs;
use std::str::FromStr;

fn main() {
    let data = fs::read_to_string("input");


    let data = match data {
        Ok(result) => result,
        Err(_) => panic!("failed to read from file"),
    };
    let mut data: Vec<_> = data.split("\n").collect();
    data.pop();
    println!("{}", get_increases(data));
}



fn get_increases(data: Vec<&str>) -> i32 {
    let mut curr: i32 = data[0].parse::<i32>().unwrap();
    let mut ans = 0;

    for i in 0..data.len() {
        let next: i32 = FromStr::from_str(data[i]).unwrap();
        if next > curr {
            ans += 1;
        }
        curr = FromStr::from_str(data[i]).unwrap();
    }
    ans
}

