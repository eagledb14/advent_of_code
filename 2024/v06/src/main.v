module main

import os
import a
import b
import math.vec

fn main() {
	mut input := os.read_file("input")!.split('\n')
	input.pop()
	mut grid := [][]string{}
	for line in input {
        	grid << line.split('')
	}
	
	mut guard_pos := vec.Vec2[int]{}
	
	for i, _ in grid {
                for j, _ in grid[i] {
                        if grid[i][j] == '^' {
                                guard_pos = vec.Vec2[int]{j, i}
                                grid[j][i] = '.'
                        }
                }
	}

	b.run(mut grid, mut guard_pos)
	a.run(mut grid, mut guard_pos)
}

