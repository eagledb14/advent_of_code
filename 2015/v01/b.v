module main;

import os


fn main() {
	mut lines := os.read_lines("input")!

	mut level := 0
	for line in lines {
		for i, c in line.runes() {
			match c {
				`(` {
					level++
				}
				`)` {
					level--
				}
				else {}
			}

			if level < 0 {
				println("${i + 1}, $level")
				break
			}
		}

	}
}
