use std::fs;

fn main() {
    let input = fs::read_to_string("input");

    let input = match input {
        Ok(result) => result,
        Err(_) => panic!("file read bad")
    };

    let mut data = input.split("\n").collect::<Vec<_>>();
    data.pop();
    println!("{}", get_frequency(data));
}

fn get_frequency(data: Vec<&str>) -> i32 {
    let mut frequency = vec![0; data[0].chars().count()];

    for i in 0..data.len() {
        for (j, c) in data[i].chars().enumerate() {
            if c == '1' {
                frequency[j] += 1;
            }
        }
    }
    let (gamma, epsilon) = get_gamma_and_epsilon(&frequency, (data.len() / 2) as i32);
    gamma * epsilon
}

fn get_gamma_and_epsilon(frequency: &Vec<i32>, length: i32) -> (i32, i32) {
    let mut gamma = "".to_string();
    let mut epsilon = "".to_string();

    for i in frequency.iter() {
        if *i > length {
            gamma.push('1');
            epsilon.push('0');
        }
        else {
            gamma.push('0');
            epsilon.push('1');
        }
    }

    (to_binary(gamma), to_binary(epsilon))
}

fn to_binary(input: String) -> i32 {
    let mut out = 0;

    for (i, c) in input.chars().rev().enumerate() {
        out += c.to_string().parse::<i32>().unwrap() * i32::pow(2, i as u32);
    }
    println!("{}: {}", input, out);

    out
}
