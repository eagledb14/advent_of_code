
fn main() {
    let p1 = Player::new(9);
    let p2 = Player::new(6);

    println!("{}", play_game(p1, p2));
}


fn play_game(mut p1: Player, mut p2: Player) -> i32 {
    let mut dice = Dice::new();

    loop {
        p1.turn(dice.roll_three());
        if p1.score >= 1000 {
            break;
        }

        p2.turn(dice.roll_three());
        if p2.score >= 1000 {
            break;
        }
    }

    i32::min(p1.score, p2.score) * dice.rolls
}

pub struct Player {
    pos: i32,
    score: i32
}

impl Player {
    fn new(pos: i32) -> Player {
        Self {
            pos,
            score: 0
        }
    }

    fn turn(&mut self, roll: i32) {
        self.pos = (self.pos + roll) % 10;

        if self.pos == 0 {
            self.pos = 10;
        }
        self.score += self.pos
    }
}


pub struct Dice {
    index: i32,
    rolls: i32
}

impl Dice {
    pub fn new() -> Dice {
        Self {
            index: 0,
            rolls: 0
        }
    }

    fn roll(&mut self) -> i32 {
        self.index = (self.index % 100) + 1;
        self.rolls += 1;
        self.index
    }

    fn roll_three(&mut self) -> i32 {
        self.roll() + self.roll() + self.roll()
    }
}

