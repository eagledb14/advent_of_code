module main;

import os


fn main() {
	mut lines := os.read_lines("input")!

	mut level := 0
	for line in lines {
		for i in line.runes() {
			match i {
				`(` {
					level++
				}
				`)` {
					level--
				}
				else {}
			}
		}
	}
	println(level)
}
