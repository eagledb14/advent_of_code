module main;

import os;

fn main() {
	lines := os.read_lines("input")!
	mut deers := []Deer{}

	for line in lines {
		split := line.split(" ")
		deers <<  Deer {
			split[0],
			split[3].int(),
			split[6].int(),
			split[13].int(),
			0,
			0,
			split[13].int(),
			false,
			split[6].int(),
		}
	}

	calc_distance(2503, mut deers)
	deers.sort(a.points > b.points)
	println(deers)
}

struct Deer {
	name string
	fly int
	fly_time int
	rest int
mut:
	distance int
	points int

	rest_left int
	is_resting bool
	fly_left int
}

fn (d &Deer) str() string {
	return "${d.name}-${d.distance}-${d.points}\n"
}

fn calc_distance(time int, mut deers []Deer) {

	for _ in 0..time + 1 {
		for _, mut deer in deers {

			if deer.is_resting {
				deer.rest_left--
				if deer.rest_left == 0 {
					deer.is_resting = false
					deer.fly_left = deer.fly_time
				}
			} else {
				deer.distance += deer.fly
				deer.fly_left--
				if deer.fly_left == 0 {
					deer.is_resting = true
					deer.rest_left = deer.rest
				}
			}
		}

		deers.sort(a.distance > b.distance)

		for _, mut deer in deers {
			if deer.distance == deers[0].distance {
				deer.points++
			}
		}
	}
}
