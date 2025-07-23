module main;

import os;
import math;

fn main() {

	lines := os.read_lines("input")!

	mut total := 0
	for line in lines {
		mut dimentions := line.split("x")
		d_int := dimentions.map(it.int())

		a := 2 * d_int[0] * d_int[1]
		b := 2 * d_int[1] * d_int[2]
		c := 2 * d_int[2] * d_int[0]

		total += a + b + c + (math.min(math.min(a,b),c) / 2)
	}
	println(total)

}
