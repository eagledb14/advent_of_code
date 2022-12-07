use std::fs;
use std::env;
use std::process;
use std::io::prelude::*;

fn main() {

    let args = env::args().collect::<Vec<String>>();
    if args.len() < 3 {
        println!("Error: use of program incorrect, please use as ./program day_of_advent advent_year");
        process::exit(1);
    }

    let day = args[1].clone();
    let year = args[2].clone();
    let created = fs::create_dir_all(format!("{}/{}", year, day));

    match created {
        Ok(_) => println!("Directory {}/{} created", year, day),
        Err(err) => {
            println!{"Error creating {}/{}", year, day};
            println!("{}", err);
            process::exit(1);
        }
    }


    let file_contents = "use std::fs;
use std::time::Instant;

fn main() {
    let now = Instant::now();
    let input = fs::read_to_string(\"test_input\").expect(\"\");
    println!(\"{}\", &input);
    println!(\"{:?}\", now.elapsed());
}";
 
    let directory_path = format!("{}/{}/a.rs", year, day);
    if let Err(err) =  fs::write(directory_path.clone(), file_contents) {
        println!("Error writing to {}", directory_path);
        println!("{}", err);
        process::exit(1);
    }

    let input_path = format!("{}/{}/input", year, day);
    match fs::File::create(input_path.clone()) {
        Ok(mut file) => file.write_all(b"test input").expect("Error creating input file"),
        Err(err) => {
            println!("Error creating input");
            println!("{}", err);
            process::exit(1);
        }
    };

    let test_input_path = format!("{}/{}/test_input", year, day);
    match fs::File::create(test_input_path.clone()) {
        Ok(mut file) => file.write_all(b"test input").expect("Error creating input file"),
        Err(err) => {
            println!("Error creating input");
            println!("{}", err);
            process::exit(1);
        }
    };
}
