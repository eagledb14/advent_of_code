module b

pub fn run(grid [][]string) {
	mut word_count := 0

	for i, _ in grid {
		for j, _ in grid[i] {
			if grid[i][j] == "A" {
				if check_x_mas(grid, Dir{x:i, y:j}) {
					word_count++
				}
			}
		}
	}
	println(word_count)
}

struct Dir {
	x int
	y int
}

fn check_x_mas(grid [][]string, pos Dir) bool {

	if pos.x < 1 || pos.x >= grid[0].len - 1 {
		return false
	}
	if pos.y < 1 || pos.y >= grid.len - 1 {
		return false
	}

	if (grid[pos.x - 1][pos.y - 1] != "M" || grid[pos.x + 1][pos.y + 1] != "S") &&
		(grid[pos.x - 1][pos.y - 1] != "S" || grid[pos.x + 1][pos.y + 1] != "M") {
		return false
	}

	if (grid[pos.x + 1][pos.y - 1] != "M" || grid[pos.x - 1][pos.y + 1] != "S") &&
		(grid[pos.x + 1][pos.y - 1] != "S" || grid[pos.x - 1][pos.y + 1] != "M") {
		return false
	}

	return true
}

