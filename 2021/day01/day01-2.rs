use std::fs;


fn main() {
    let data = fs::read_to_string("input");

    let data = match data {
        Ok(result) => result,
        Err(_) => panic!("file not read")
    };

    let mut data = data.split("\n").collect::<Vec<_>>();
    data.pop();
    let data = data.iter().map(|s| s.parse::<i32>().unwrap()).collect::<Vec<_>>();
    println!("{}", get_three_increases(data));
}

fn get_three_increases(data: Vec<i32>) -> i32 {
    let mut curr = 0;
    let mut ans = 0;

    for i in 0..data.len() - 3 {
        let next = data[i] + data[i + 1] + data[i + 2];

        if next > curr {
            ans += 1;
        }

        curr = next;
    }
    ans
}
