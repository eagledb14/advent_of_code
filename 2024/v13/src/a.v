module a

import machine as m
import math

pub fn run(input [][]string) {
	mut total := 0
	for i in input {
		machine := m.new_machine(i)
		sum := equate(machine)
		// println("$sum\n")
		total += sum or {0}
	}

	println(total)
}

fn equate(machine m.Machine) ?int {
	bb := (machine.prize.y - ((machine.prize.x * machine.a.y) / machine.a.x)) / (machine.b.y - ((machine.b.x * machine.a.y) / machine.a.x))
	aa := (machine.prize.x - (bb * machine.b.x)) / machine.a.x


	a_int := int(math.round(aa))
	b_int := int(math.round(bb))
	// println("${math.round(aa)}, ${math.round(bb)}")

	if aa < 0 || bb < 0 {
		return none
	}

	if a_int > 100 || b_int > 100 {
		return none
	}

	if a_int * machine.a.x + b_int * machine.b.x != int(machine.prize.x) {
		return none
	}

	if a_int * machine.a.y + b_int * machine.b.y != int(machine.prize.y) {
		return none
	}

	return b_int + (a_int * 3)
}
