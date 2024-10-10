use std::{collections::HashMap, fs};

fn main() {
    let input = fs::read_to_string("input").expect("");
    let input = input
        .split("")
        .into_iter()
        .filter(|&x| !x.is_empty() && x != "\n")
        .map(|x| x.to_string())
        .collect::<Vec<String>>();

    // part_a(input);
    part_b(input);
}

fn part_a(input: Vec<String>) {
    let width = 25;
    let height = 6;
    let mut index = 0;

    let mut layers: Vec<HashMap<String, i32>> = Vec::new();

    while index < input.len() {
        let mut new_layer = HashMap::<String, i32>::new();

        for _ in 0..(width * height) {
            // println!("{}", input[index]);
            *new_layer.entry(input[index].clone()).or_insert(0) += 1;
            index += 1;
        }

        layers.push(new_layer);
    }

    // println!("{:?}", layers);
    let zero_layer = get_layer_with_least_zeros(&layers);
    // println!("{:?}", layers[zero_layer as usize]);
    println!("Part a: {}", get_a_answer(&layers[zero_layer as usize]));
}

fn part_b(input: Vec<String>) {
    let width = 25;
    let height = 6;
    let image_size = width * height;
    let num_layers = input.len() / image_size;

    let mut image = vec![" "; image_size];

    for i in 0..image_size {

        for j in 0..num_layers {
            let image_offset = j * image_size + i;

            if input[image_offset] != "2" {
                if input[image_offset] == "0" {
                    image[i] = " ";
                } else {
                    image[i] = "#";
                }
                break;
            }
        }
    }

    print_image(width, height, image);
}

fn print_image(width: usize, height: usize, image: Vec<&str>) {
    for i in 0..height {
        for j in 0..width {
            print!("{}", image[i * width + j]);
        }
        println!("");
    }
}

fn get_layer_with_least_zeros(layers: &Vec<HashMap<String, i32>>) -> i32 {
    let mut layer_index = 0;
    let mut min_zero_count = 100000;

    for (index, layer) in layers.iter().enumerate() {
        // println!("{}", min_zero_count);
        if let Some(zero_count) = layer.get("0") {
            if *zero_count < min_zero_count {
                min_zero_count = *zero_count;
                layer_index = index;
            }
        } else {
            layer_index = index;
            min_zero_count = 0;
        }
    }

    return layer_index as i32;
}

fn get_a_answer(layer: &HashMap<String, i32>) -> i32 {
    return layer.get("1").unwrap() * layer.get("2").unwrap();
}
