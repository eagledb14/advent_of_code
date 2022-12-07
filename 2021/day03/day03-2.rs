use std::fs;

fn main() {
    let input = fs::read_to_string("input");

    let input = match input {
        Ok(result) => result,
        Err(_) => panic!("file read bad")
    };

    let mut data = input.split("\n").collect::<Vec<_>>();
    data.pop();
    let oxygen = get_oxygen(data.clone());
    let carbon = get_carbon(data.clone());

    println!("{}", to_binary(oxygen) * to_binary(carbon));
}

fn get_oxygen(mut data: Vec<&str>) -> String {
    for i in 0..data[0].len() {
        let greatest = get_greatest(data.clone(), i);

        for j in 0..data.len() {
            if data.len() == 1 || data.len() >= j {
                break;
            }

            if data[j].chars().collect::<Vec<_>>()[i] != greatest {
                data.remove(j);
            }
        }
    }
    data[0].to_string()
}

fn get_carbon(mut data: Vec<&str>) -> String {
    for i in 0..data[0].len() {
        let lowest = get_lowest(data.clone(), i);

        for j in 0..data.len() {
            if data.len() == 1 || data.len() >= j {
                break;
            }

            if data[j].chars().collect::<Vec<_>>()[i] == lowest {
                data.remove(j);
            }
        }
    }
    data[0].to_string()
}


fn get_greatest(data: Vec<&str>, index: usize) -> char {
    let mut out = 0;
    for i in 0..data.len() {
        if data[i].chars().collect::<Vec<_>>()[index] == '1' {
            out += 1;
        }
        else {
            out -= 1;
        }
    }

    if out > 0 {
        return '1'
    }
    else {
        return '0'
    }
}


fn get_lowest(data: Vec<&str>, index: usize) -> char {
    let mut out = 0;
    for i in 0..data.len() {
        if data[i].chars().collect::<Vec<_>>()[index] == '1' {
            out += 1;
        }
        else {
            out -= 1;
        }
    }

    if out < 0 {
        return '1'
    }
    else {
        return '0'
    }
}


fn to_binary(input: String) -> i32 {
    let mut out = 0;

    for (i, c) in input.chars().rev().enumerate() {
        out += c.to_string().parse::<i32>().unwrap() * i32::pow(2, i as u32);
    }
    println!("{}: {}", input, out);

    out
}


