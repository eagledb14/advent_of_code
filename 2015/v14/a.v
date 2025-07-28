module main;

import os;

fn main() {
	lines := os.read_lines("input")!
	mut deers := []Deer{}

	for line in lines {
		split := line.split(" ")
		deers << Deer {
			split[0],
			split[3].int(),
			split[6].int(),
			split[13].int(),
			0
		}
	}

	for _, mut d in deers {
		d.distance = calc_distance(2503, d)
	}

	deers.sort(a.distance > b.distance)
	println(deers)
}

struct Deer {
	name string
	fly int
	fly_time int
	rest int
mut:
	distance int
}

fn (d &Deer) str() string {
	return "${d.name}-${d.distance}"
}

fn calc_distance(time int, deer Deer) int {
	mut time_left := time
	mut total := 0

	for time_left > 0 {
		if time_left >= deer.fly_time {
			total += deer.fly * deer.fly_time
			time_left -= deer.fly_time
		} else {
			total += time_left * deer.fly
			time_left = 0
		}

		time_left -= deer.rest
	}

	return total
}
