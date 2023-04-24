use std::fs;
use std::collections::HashMap;
use std::ops;
use std::cmp::Ordering;
use std::collections::BinaryHeap;

fn main() {
    let input = fs::read_to_string("test_input").expect("");
    let input = input.split("\n").filter(|&x| x!= "").collect::<Vec<&str>>();
    let input: Vec<Vec<_>> = input.iter().map(|x| x.chars().collect()).collect();
    //println!("{:?}", &input);

    let mut grid = Grid::new();
    let mut cords = Vec::<Cord>::new();
    for i in 0..input.len() {
        for j in 0..input[i].len() {
            if input[i][j] == 'S' {
                grid.mem.insert(Cord::new(i as i32, j as i32), 'a' as i8);
                grid.start = Cord::new(i as i32, j as i32);
            }
            else if input[i][j] == 'E' {
                grid.mem.insert(Cord::new(i as i32, j as i32), 'z' as i8);
                grid.end = Cord::new(i as i32, j as i32);
            }
            else {
                grid.mem.insert(Cord::new(i as i32, j as i32), input[i][j] as i8);
            }
            cords.push(Cord::new(i as i32, j as i32));
        }
    }

    //println!("{:?}", &grid.get_neighbors(&grid.start));

    let mut prev = HashMap::<Cord, Option<Cord>>::new();
    for i in &cords {
        prev.insert(*i, None);
    }

    let mut q = BinaryHeap::new();
    //q.make_queue(&cords);
    for c in &mut cords {
        q.push(c);
    }
    //println!("{:?}", q);
    
    /*while !q.is_empty() {
        let c = q.delete_min();
        let neighbors = grid.get_neighbors(&c);
        for n in neighbors {

        }
    }*/
    
    //println!("{:?}", input);
    //println!("{:?}", grid);
}

#[derive(Debug)]
struct Grid {
    start: Cord,
    end: Cord,
    mem: HashMap<Cord, i8>,
}

impl Grid {
    fn new() -> Grid {
        Self {
            start: Cord::new(0,0),
            end: Cord::new(0,0),
            mem: HashMap::new()
        }
    }

    fn get_neighbors(&self, cord: &Cord) -> Vec<i8> {
        let edges_offset = vec![Cord::new(0,1), Cord::new(0, -1), Cord::new(1, 0), Cord::new(-1, 0)];
        let mut neighbors = Vec::<i8>::new();
        let current_val = *self.mem.get(&cord).unwrap();

        for edge in edges_offset {
            match self.mem.get(&(edge + *cord)) {
                Some(val) => {
                    if (val - current_val).abs() <= 1 {
                        neighbors.push(*val);
                    }
                }
                None => {}
            };
        };

        neighbors
    }
}

#[derive(Debug, Eq, Hash, PartialEq, Copy, Clone)]
struct Cord {
    x: i32,
    y: i32,
    dist: Option<i32>
}

impl Cord {
    fn new(x: i32, y: i32) -> Cord {
        Self {
            x,
            y,
            dist: None
        }
    }
}

impl ops::Add<Cord> for Cord {
    type Output = Cord;

    fn add (mut self, rhs: Cord) -> Cord {
        self.x += rhs.x;
        self.y += rhs.y;
        self
    }
}

impl Ord for Cord {
    fn cmp(&self, other: &Cord) -> Ordering {
        other.dist.cmp(&self.dist)
    }
}

impl PartialOrd for Cord {
    fn partial_cmp(&self, other: &Cord) -> Option<Ordering> {
        Some(other.dist.cmp(&self.dist))
    }
}

