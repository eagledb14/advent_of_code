module b

import math.vec
import a

// There is an off by 1 error here somewhere, I get 1720, but the answer is 1719. Works fine with the test input, but not the puzzle input
pub fn run(mut grid [][]string, mut guard_pos vec.Vec2[int]) {
	mut loop_count := 0

	for i, line in grid {
		for j, _ in line {
			if grid[j][i] == "#" || (guard_pos.x == j && guard_pos.y == i) {continue}

			grid[j][i] = "#"
			is_loop := step(grid, guard_pos, "^")
			grid[j][i] = "."

			if is_loop {
				loop_count++
			}
		}
	}

	println(loop_count)
}


fn step(grid [][]string, pos vec.Vec2[int], dir string) bool {
	mut guard_pos := pos
	mut direction := dir
	mut bounce := map[string]bool{}

	for true {

		match direction {
			"^" {
				guard_pos.y -= 1
				if guard_pos.y < 0 { return false }
				for grid[guard_pos.y][guard_pos.x] == "#" {
					guard_pos.y += 1
					direction = ">"
					if guard_pos.str() + direction in bounce {return true}
					bounce[guard_pos.str() + direction] = true
				}
			}
			"v" {
				guard_pos.y += 1
				if guard_pos.y >= grid.len { return false}
				for grid[guard_pos.y][guard_pos.x] == "#" {
					guard_pos.y -= 1
					direction = "<"
					if guard_pos.str() + direction in bounce {return true}
					bounce[guard_pos.str() + direction] = true
				}
			}
			">" {
				guard_pos.x += 1
				if guard_pos.x >= grid[0].len {return false}
				for grid[guard_pos.y][guard_pos.x] == "#" {
					guard_pos.x -= 1
					direction = "v"
					if guard_pos.str() + direction in bounce {return true}
					bounce[guard_pos.str() + direction] = true
				}
			}
			"<" {
				guard_pos.x -= 1
				if guard_pos.x < 0 {return false}
				for grid[guard_pos.y][guard_pos.x] == "#" {
					guard_pos.x += 1
					direction = "^"
					if guard_pos.str() + direction in bounce {return true}
					bounce[guard_pos.str() + direction] = true
				}
			}
			else {}
		}
		//println(bounce.len)
	}

	return false
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
