module a

pub fn run(grid [][]string) {
	mut word_count := 0
	directions := [
		Dir{x: 0, y: -1},
		Dir{x: 1, y: 0},
		Dir{x: 0, y: 1},
		Dir{x: -1, y: 0},
		Dir{x: 1, y: -1},
		Dir{x: 1, y: 1},
		Dir{x: -1, y: 1},
		Dir{x: -1, y: -1},
	]

	for i, _ in grid {
		for j,_ in grid[i] {
			for d in directions {
				if grid[i][j] == "X" {
					word := get_word(grid, Dir{x:i, y:j}, d, "") or {continue}
					if word == "XMAS" {
						word_count++
					}
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

fn get_word(grid [][]string, start Dir, direction Dir, word string) ?string {
	if word.len == 4 {
		return word
	}

	if start.x < 0 || start.x >= grid[0].len {
		return none
	}
	if start.y < 0 || start.y >= grid.len {
		return none
	}

	new_word := word + grid[start.x][start.y]

	new_pos := Dir{x: start.x + direction.x, y: start.y + direction.y}
	return get_word(grid, new_pos, direction, new_word)
}



