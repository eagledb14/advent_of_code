module a

import math.vec

pub fn run(mut grid [][]string, mut guard_pos vec.Vec2[int]) {
	step(mut grid, mut guard_pos, "^")
	//pretty_print_grid(grid)
	println(count_used_grid(grid))
}

pub fn step(mut grid [][]string, mut guard_pos vec.Vec2[int], dir string) {
	mut direction := dir

	match direction {
		"^" {
			guard_pos.y -= 1
			if guard_pos.y < 0 { return }
			if grid[guard_pos.y][guard_pos.x] == "#" {
				guard_pos.y += 1
				direction = ">"
			}
			grid[guard_pos.y][guard_pos.x] = "X"
		}
		"v" {
			guard_pos.y += 1
			if guard_pos.y >= grid.len { return }
			if grid[guard_pos.y][guard_pos.x] == "#" {
				guard_pos.y -= 1
				direction = "<"
			}
			grid[guard_pos.y][guard_pos.x] = "X"
		}
		">" {
			guard_pos.x += 1
			if guard_pos.x >= grid[0].len {return}
			if grid[guard_pos.y][guard_pos.x] == "#" {
				guard_pos.x -= 1
				direction = "v"
			}
			grid[guard_pos.y][guard_pos.x] = "X"
		}
		"<" {
			guard_pos.x -= 1
			if guard_pos.x < 0 {return}
			if grid[guard_pos.y][guard_pos.x] == "#" {
				guard_pos.x += 1
				direction = "^"
			}
			grid[guard_pos.y][guard_pos.x] = "X"
		}
		else {}
	}

	step(mut grid, mut guard_pos, direction)
}

fn pretty_print_grid(grid [][]string) {
        for line in grid {
                merged_line := line.join('')

                println(merged_line)
        }
}

fn count_used_grid(grid [][]string) int {
	mut count := 0

	for i, line in grid {
		for j,_ in line {
			if grid[j][i] == "X" {
				count++
			}
		}
	}

	return count
}
