module machine

pub struct Point {
pub:
	x f64
	y f64
}

fn (a Point) < (b Point) bool {
	return a.x < b.x && a.y < b.y
}

pub fn (p Point) is_negative() bool {
	return p.x < 0 || p.y < 0
}

pub fn (a Point) - (b Point) Point {
	return Point {
		x: a.x - b.x,
		y: a.y - b.y,
	}
}

pub struct Machine {
pub:
	a Point
	b Point
	prize Point
}

pub fn new_machine(input []string) Machine {
	return Machine {
		a: parse_point(input[0]),
		b: parse_point(input[1]),
		prize: parse_prize(input[2]),
	}
}

pub fn new_big_machine(input []string) Machine {
	return Machine {
		a: parse_point(input[0]),
		b: parse_point(input[1]),
		prize: parse_big_prize(input[2]),
	}
}

fn parse_point(input string) Point {
	return Point {
		x: input.split(":")[1].split(",")[0].split("+")[1].f64(),
		y: input.split(":")[1].split(",")[1].split("+")[1].f64(),
	}
}

fn parse_prize(input string) Point {
	return Point {
		x: input.split(":")[1].split(",")[0].split("=")[1].f64(),
		y: input.split(":")[1].split(",")[1].split("=")[1].f64(),
	}
}

fn parse_big_prize(input string) Point {
	return Point {
		x: 10_000_000_000_000 + input.split(":")[1].split(",")[0].split("=")[1].f64(),
		y: 10_000_000_000_000 + input.split(":")[1].split(",")[1].split("=")[1].f64(),
	}
}
