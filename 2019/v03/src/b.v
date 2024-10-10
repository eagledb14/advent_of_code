module b

import strconv
import math

pub fn run(a_dir []string, b_dir []string) {
	mut field := map[string]Step{}
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

	walk(a_route, mut &field, "a")
	walk(b_route, mut &field, "b")
	// println(field)
	println(find_distance(field))

	// println("$a_route, $b_route")
}

fn walk(route []Vector, mut field &map[string]Step, name string) {
	mut start_point := Point{x:0, y:0}
	mut total_step := 0

	for step in route {
		match step.direction {
			"U" {
				for _ in 0..step.len {
					total_step++
					start_point.y++
					update_step(start_point, mut &field, name, total_step)
				}
			}
			"D" {
				for _ in 0..step.len {
					total_step++
					start_point.y--
					update_step(start_point, mut &field, name, total_step)
				}
			}
			"L" {
				for _ in 0..step.len {
					total_step++
					start_point.x--
					update_step(start_point, mut &field, name, total_step)
				}
			}
			"R" {
				for _ in 0..step.len {
					total_step++
					start_point.x++
					update_step(start_point, mut &field, name, total_step)
				}
			}
			else {}
		}
	}
}

fn update_step(p Point, mut field &map[string]Step, name string, step int) {
	if name == "a" {
		if field[p.str()].a == 0 {
			field[p.str()].a = step
		}
		return
	}

	if name == "b" {
		if field[p.str()].b == 0 {
			field[p.str()].b = step
		}
		return
	}
}

fn find_distance(field map[string]Step) int {
	mut overlaps := []Step{}

	for _, val in field {
		if val.a != 0 && val.b != 0 {
			overlaps << val
		}
	}

	mut dist := 1000000
	for lap in overlaps {
		dist = math.min(lap.a + lap.b, dist)
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

@[heap]
struct Step {
mut:
	a int
	b int
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
