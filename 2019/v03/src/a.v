module a

import strconv
import math

pub fn run(a_dir []string, b_dir []string) {
	mut field := map[string]int{}
	mut a_route := []Vector{}

	for a in a_dir {
		ab := a.runes()
		len := ab[1..].map(it.str()).join("").int()
		a_route << Vector{direction: ab[0].str(), len: len}
	}

	mut b_route := []Vector{}
	for b in b_dir {
		bb := b.runes()
		len := bb[1..].map(it.str()).join("").int()
		b_route << Vector{direction: bb[0].str(), len: len}
	}

	walk(a_route, mut &field, 1)
	walk(b_route, mut &field, 2)

	println(find_distance(field))
}

fn walk(route []Vector, mut field &map[string]int, value int) {
	mut start_point := Point{x:0, y:0}

	for step in route {
		match step.direction {
			"U" {
				for _ in 0..step.len {
					start_point.y++
					field[start_point.str()] += value
				}
			}
			"D" {
				for _ in 0..step.len {
					start_point.y--
					field[start_point.str()] += value
				}
			}
			"L" {
				for _ in 0..step.len {
					start_point.x--
					field[start_point.str()] += value
				}
			}
			"R" {
				for _ in 0..step.len {
					start_point.x++
					field[start_point.str()] += value
				}
			}
			else {}
		}
	}
}

fn find_distance(field map[string]int) int {
	mut overlaps := []Point{}

	for key, val in field {
		if val == 3 {
			overlaps << point_parse(key)
		}
	}

	mut dist := 1000000
	for lap in overlaps {
		dist = math.min(math.abs(lap.x) + math.abs(lap.y), dist)
	}

	println(overlaps)
	return dist
}

@[heap]
struct Vector {
	len int
	direction string
}

@[heap]
struct Point {
mut:
	x int
	y int
}

fn point_parse(point string) Point {
	p_split := point.split(":")
	return Point {
		x: p_split[0].int()
		y: p_split[1].int()
	}
}

fn (p Point) str() string {
	unsafe {
		return strconv.v_sprintf("${p.x}:${p.y}")
	}
}
