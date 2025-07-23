module main;

import os;

fn main() {
	dir := os.read_file("input")!.runes()

	mut houses := map[string]int{}

	mut santa := &Pos{x: 0, y: 0}

	for _, d in dir {
		do_turn(mut santa, d)
		houses[santa.str()]++
	}

	println(houses.len)
}

fn do_turn(mut pos Pos, d rune) {
	match d {
		`^` {
			pos.y--
		}
		`<` {
			pos.x--
		}
		`v` {
			pos.y++
		}
		`>` {
			pos.x++
		}
		else {
		}
	}
}

struct Pos {
pub mut:
	x int
	y int
}

fn (p Pos) str() string {
	return '(${p.x},${p.y})'
}

fn from_str(s string) Pos {
	return Pos{x: s.split(",")[0].int(), y: s.split(",")[1].int()}
}
