module main;

import os;

fn main() {
	lines := os.read_lines("input")!

	mut total := 0
	for _, line in lines {
		if is_nice(line) {
			total++
		}
	}

	println(total)
}


fn is_nice(s string) bool {
	mut repeat := false

	for i in 0..s.len - 1 {
		pair := s[i..i + 2]

		if s[i + 2..].index(pair) != none {
			repeat = true
			break
		}
	}

	if !repeat {
		return false
	}

	mut sandwich := false
	for i in 0..s.runes().len - 2 {
		if s.runes()[i] == s.runes()[i + 2] {
			sandwich = true
		}
	}

	return sandwich
}
