use std::fs;
use std::time::Instant;
use std::collections::HashSet;


fn simulate_rope(moves: &[(i32, i32, usize)], followers: usize) -> usize {
  let mut rope = vec![(0i32, 0i32); followers + 1];
  let mut visited = HashSet::with_capacity(10000);
  visited.insert((0,0));
  for &(dx, dy, len) in moves {
    for _ in 0..len {
      rope[0] = (rope[0].0 + dx, rope[0].1 + dy);
      for i in 1..rope.len() {
        let (dx, dy) = (rope[i-1].0 - rope[i].0, rope[i-1].1 - rope[i].1);
        if dx.abs() > 1 || dy.abs() > 1 {
          rope[i].0 += dx.signum();
          rope[i].1 += dy.signum();
        }
      }
      visited.insert(rope[followers]);
    }
  }
  visited.len()
}

fn main() {
    let input = fs::read_to_string("input").expect("");
    let moves = input.lines().map(|l| {
    let (a, b) = l.split_once(' ').unwrap();
    let (dx, dy) = match a.as_bytes()[0] as char {
      'U' => ( 0, 1),
      'D' => ( 0,-1),
      'R' => ( 1, 0),
      'L' => (-1, 0),
      _ => unreachable!()
    };
    (dx, dy, b.parse::<usize>().unwrap())
  }).collect::<Vec<_>>();
  //(simulate_rope(&moves, 1), simulate_rope(&moves, 9))
  println!("{}", simulate_rope(&moves, 9));
}
