module main;

import os;
import arrays;

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
	vowels := "aeiou"
	mut vowel_count := map[rune]int{}

	nilzya := ["ab", "cd", "pq", "xy"]

	for _, l in s.runes() {
		if l in vowels.runes() {
			vowel_count[l]++
		}
	}

	mut vowel_total := 0
	for _, v in vowel_count {
		vowel_total += v
	}

	if vowel_total < 3 {
		return false
	}

	mut valid_pair := false
	for _, p in arrays.window(s.runes(), size: 2) {
		pair := p.map(it.str()).join("")

		if pair in nilzya {
			return false
		}

		if p[0] == p[1] {
			valid_pair = true
		}
	}

	return valid_pair
}
