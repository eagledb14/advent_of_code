use std::fs;
use std::time::Instant;

fn main() {
    let now = Instant::now();
    let input = fs::read_to_string("input").expect("");

    let input = input.split("\n").collect::<Vec<_>>().into_iter().filter(|&x| x != "").collect::<Vec<_>>();
    let mut monkeys = Vec::<MonkeyTurn>::new();

    let mut new_monkey = MonkeyTurn::new();
    let mut count = 0;
    for i in &input {
        match count {
            0 => {
                let mut k = i.to_string();
                k.remove(k.len() - 1);
                let k = k.split(" ").collect::<Vec<_>>();
                new_monkey.name = k.last().unwrap().parse().expect("no monkey name");
                //println!("{}", newMonkey.name);
            },
            1 => {
                //let mut k = i.to_string().split([" ", ","]).collect::<Vec<_>>();
                let k = i.split(":").collect::<Vec<_>>();
                let mut j = k[1].split(", ").map(|x| x.trim().parse::<u64>().expect("")).collect::<Vec<_>>();
                new_monkey.items.append(&mut j);
                //println!("{:?}", newMonkey.items);
            },
            2 => {
                let k = i.split(" ").collect::<Vec<_>>();
                //println!("{:?}", k);
                let num = k.last().expect("").to_string();

                new_monkey.operation = match k[k.len() - 2] {
                    "*" => Operation::Multiply(num),
                    "+" => Operation::Add(num),
                    c => panic!("unkown operation {}", c)
                };
                //println!("{:?}", newMonkey.operation);
            },
            3 => {
                new_monkey.test = i.split(" ").collect::<Vec<_>>().last().expect("").trim().parse::<u64>().expect("");
                //println!("{}", newMonkey.test);
            },
            4 => {
                new_monkey.if_true = i.split(" ").collect::<Vec<_>>().last().expect("").trim().parse::<u64>().expect("");
                //println!("{}", newMonkey.if_true);
            },
            5 => {
                new_monkey.if_false = i.split(" ").collect::<Vec<_>>().last().expect("").trim().parse::<u64>().expect("");
                //println!("{}", newMonkey.if_false);
            }
            _ => {},
        };

        count += 1;
        if count == 6 {
            monkeys.push(new_monkey);
            new_monkey = MonkeyTurn::new();
            count = 0;
        }
    }


    //println!("{:?}", &input);
    //println!("{:?}", monkeys);
    //println!("{}", input.len());
    let (first, second) = do_compute(monkeys);
    let total = first * second;
    println!("{}", total);
    println!("{:?}", now.elapsed());
}


fn do_compute(mut monkeys: Vec<MonkeyTurn>) -> (u64, u64) {
    let divisor = monkeys.iter().map(|m| m.test).product::<u64>();

    for _ in 0..10_000 {
        for m in 0..monkeys.len() {
            let mut res = monkeys[m].turn(divisor);

            monkeys[res.0 as usize].items.append(&mut res.1);
            monkeys[res.2 as usize].items.append(&mut res.3);
        }
    }
    //println!("{:?}", monkeys);
    monkeys.sort_by(|a, b| b.num_inspected.partial_cmp(&a.num_inspected).unwrap());
    for m in &monkeys {
        println!("{}", m.num_inspected);
    }
    (monkeys[0].num_inspected ,monkeys[1].num_inspected)
}


#[derive(Debug)]
struct MonkeyTurn {
    name: u64,
    items: Vec<u64>,
    operation: Operation,
    test: u64,
    if_true: u64,
    if_false: u64,
    num_inspected: u64
}

impl MonkeyTurn {
    fn new() -> MonkeyTurn {
        Self {
            name: 0,
            items: Vec::<u64>::new(),
            operation: Operation::Add("".to_string()),
            test: 0,
            if_true: 0,
            if_false: 0,
            num_inspected: 0
        }
    }

    fn turn(&mut self, divisor: u64) -> (u64, Vec<u64>, u64, Vec<u64>) {
        //multiply the worry by the operation
        let mut if_true = Vec::<u64>::new();
        let mut if_false = Vec::<u64>::new();

        for i in 0..self.items.len() {
            self.items[i] %= divisor;
            match &self.operation {
                Operation::Add(num) => {
                    match num.as_str() {
                        "old" => self.items[i] += self.items[i],
                        _ => self.items[i] += num.parse::<u64>().expect("number not parsed")
                    }
                },
                Operation::Multiply(num) => {
                    match num.as_str() {
                        "old" => self.items[i] *= self.items[i],
                        _ => self.items[i] *= num.parse::<u64>().expect("number not parsed")
                    }
                }
            };


            self.items[i] %= divisor;

            if self.items[i] % self.test == 0 {
                if_true.push(self.items[i]);
            }
            else {
                if_false.push(self.items[i]);
            }

            self.num_inspected += 1;
        }

        self.items = Vec::new();

        (self.if_true, if_true, self.if_false, if_false)
    }
}

#[derive(Debug)]
enum Operation {
    Add(String),
    Multiply(String)
}

