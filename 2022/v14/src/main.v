module main

import os
import math


fn main() {
	fname := "input"
	mut f := os.read_file(fname)!.split("\n")
	f2 := os.read_file(fname)!.split(" -> ")
	f.pop()

	mut my := 0

	for line in f2 {
		point := line.split(",")
		y := point[1].int()

		my = math.max(my, y)
	}

	mut c := new_cave(my)
	for line in f {
		c.write(line)
	}
	c.write_floor()
	c.drop()

	println(c)
	eprintln(c.sand_num)
}

struct Cave {
	floor int
mut:
	data [][]u8
	path []Point
	sand_num int
}

fn new_cave(y int) Cave {
	mut d := [][]u8{}
	for _ in 0..y + 3 {
		d << []u8{len: 1000}
	}

	return Cave{
		data: d,
		path: [Point{x: 500, y: 0}],
		floor: y + 2,
	}
}

fn (mut c Cave) write(line string) {
	points := line.split(" -> ")
	mut currx := points[0].split(",")[0].int()
	mut curry := points[0].split(",")[1].int()

	c.data[curry][currx] = 1

	for p in points[1..] {
		x := p.split(",")[0].int()
		y := p.split(",")[1].int()

		for currx != x {
			if currx > x {
				currx--
			}
			if currx < x {
				currx++
			}

			c.data[curry][currx] = 1
		}

		for curry != y {
			if curry > y {
				curry--
			}
			if curry < y {
				curry++
			}

			c.data[curry][currx] = 1
		}

	}
}

fn (mut c Cave) write_floor() {
	for i in 0..c.data[c.floor].len {
		c.data[c.floor][i] = u8(1)
	}
}

fn (mut c Cave) drop() {
	for {
		if c.path.len == 0 {
			return
		}
		mut point := c.path.last()

		for {
			if c.data[point.y + 1][point.x] == 0 {
				point.y++
			} else if c.data[point.y + 1][point.x - 1] == 0 {
				point.y++
				point.x--
			} else if c.data[point.y + 1][point.x + 1] == 0 {
				point.y++
				point.x++
			} else {
				c.sand_num++
				c.data[point.y][point.x] = 2
				c.path.pop()
				break
			}
			c.path << Point{x: point.x, y: point.y}
		}
	}
}

fn (c Cave) str() string {
	mut out := ""
	for d in c.data {
		out += d.str() + "\n"
	}
	return out.replace("1", "#").replace("2", "o").replace(", ", "").replace("0", " ").replace("]", "").replace("[", "")
}

struct Point {
mut:
	x int
	y int
}


// module main
//
// import os
// import math
//
//
// fn main() {
// 	fname := "input"
// 	mut f := os.read_file(fname)!.split("\n")
// 	f2 := os.read_file(fname)!.split(" -> ")
// 	f.pop()
//
// 	mut mx := 0
// 	mut my := 0
//
// 	for line in f2 {
// 		point := line.split(",")
// 		x := point[0].int()
// 		y := point[1].int()
//
// 		mx = math.max(mx, x)
// 		my = math.max(my, y)
// 	}
//
// 	mut c := new_cave(mx, my)
// 	for line in f {
// 		c.write(line)
// 	}
// 	c.drop()
//
// 	println(c)
// 	eprintln(c.sand_num)
// }
//
// struct Cave {
// mut:
// 	data [][]u8
// 	path []Point
// 	sand_num int
// }
//
// fn new_cave(x int, y int) Cave {
// 	mut d := [][]u8{}
// 	for _ in 0..1000 {
// 		d << []u8{len: 1000}
// 	}
//
// 	return Cave{
// 		data: d,
// 		path: [Point{x: 500, y: 0}]
// 	}
// }
//
// fn (mut c Cave) write(line string) {
// 	points := line.split(" -> ")
// 	mut currx := points[0].split(",")[0].int()
// 	mut curry := points[0].split(",")[1].int()
//
// 	c.data[curry][currx] = 1
//
// 	for p in points[1..] {
// 		x := p.split(",")[0].int()
// 		y := p.split(",")[1].int()
//
// 		for currx != x {
// 			if currx > x {
// 				currx--
// 			}
// 			if currx < x {
// 				currx++
// 			}
//
// 			c.data[curry][currx] = 1
// 		}
//
// 		for curry != y {
// 			if curry > y {
// 				curry--
// 			}
// 			if curry < y {
// 				curry++
// 			}
//
// 			c.data[curry][currx] = 1
// 		}
//
// 	}
// }
//
// fn (mut c Cave) drop() {
// 	for {
// 		mut point := c.path.last()
//
// 		for {
// 			// eprintln(c.sand_num)
// 			if c.data[point.y + 1][point.x] == 0 {
// 				point.y++
// 			} else if c.data[point.y + 1][point.x - 1] == 0 {
// 				point.y++
// 				point.x--
// 			} else if c.data[point.y + 1][point.x + 1] == 0 {
// 				point.y++
// 				point.x++
// 			} else {
// 				c.sand_num++
// 				c.data[point.y][point.x] = 2
// 				c.path.pop()
// 				break
// 			}
// 			c.path << Point{x: point.x, y: point.y}
//
// 			if point.y == c.data[0].len - 1 {
// 				c.data[point.y][point.x] = 2
// 				return
// 			}
// 		}
// 	}
// }
//
// fn (c Cave) str() string {
// 	mut out := ""
// 	for d in c.data {
// 		out += d.str() + "\n"
// 	}
// 	return out.replace("1", "#").replace("2", "o").replace(",", "").replace(" ", "").replace("0", " ")
// }
//
// struct Point {
// mut:
// 	x int
// 	y int
// }
