use std::{collections::HashMap, fs};

fn main() {
    let input = fs::read_to_string("input").expect("");
    let input = input
        .split("\n")
        .into_iter()
        .map(|x| x.split(")").collect::<Vec<_>>())
        .filter(|x| x != &[""])
        .collect::<Vec<_>>();
    let mut orbits = HashMap::<String, Vec<String>>::new();

    for orb in input {
        orbits
            .entry(orb[0].to_string())
            .or_insert(Vec::new())
            .push(orb[1].to_string());
    }

    let reverse_orbits = reverse_map(&orbits);
    let mut total = 0;
    for node in reverse_orbits.keys() {
        total += count_chain(node.to_string(), &reverse_orbits);
    }

    println!("Part a: {}", total);
    println!("Part b: {}", dfs(&reverse_orbits));
}

fn reverse_map(orbits: &HashMap<String, Vec<String>>) -> HashMap<String, String> {
    let mut map = HashMap::<String, String>::new();

    for (key, value) in orbits.iter() {
        for name in value.iter() {
            map.insert(name.to_string(), key.to_string());
        }
    }

    return map
}

fn count_chain(name: String, orbits: &HashMap<String, String>) -> i32 {
    let mut curr_name = name;
    let mut chain_len = 0;

    while curr_name != "COM" {
        if let Some(parent) = orbits.get(&curr_name.clone()) {
            chain_len += 1;
            curr_name = parent.to_string();
        }
    }

    return chain_len;
}


fn dfs(parent_map: &HashMap<String, String>) -> i32 {
    let mut a_parents = parent_chain("YOU".to_string(), parent_map);
    let mut b_parents = parent_chain("SAN".to_string(), parent_map);

    // println!("{:?}", a_parents);
    // println!("{:?}", b_parents);
    while a_parents.last().unwrap() == b_parents.last().unwrap() {
        // println!("{:?} {:?}", a_parents, b_parents);
        a_parents.pop();
        b_parents.pop();
    }
    
    return (a_parents.len() + b_parents.len()) as i32;
}

fn parent_chain(name: String, orbits: &HashMap<String, String>) -> Vec<String> {
    let mut curr_name = name;
    let mut parent_names = Vec::<String>::new();

    while curr_name != "COM" {
        if let Some(parent) = orbits.get(&curr_name.clone()) {
            parent_names.push(parent.to_string());
            curr_name = parent.to_string();
        }
    }

    return parent_names;
}

// fn dfs(name: String, total: i32, chain: i32, orbits: &HashMap<String, Vec<String>>) -> i32 {
//
//     if let Some(children) = orbits.get(&name) {
//         for child in children.iter() {
//             // let t = dfs(child.to_string(), orbits);
//             // println!("{} {}", t, child);
//             // total += t + 1;
//         }
//     }
//
//     return total;
// }
