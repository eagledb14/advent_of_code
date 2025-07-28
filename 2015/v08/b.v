module main;

import os;


fn main() {
	lines := os.read_lines("input")!
	unparsed := get_total_chars(lines)

	mut encoded := 0
	for line in lines {
		encoded += get_encoded_line(line)
	}

	println("${encoded - unparsed}")
}

fn get_total_chars(lines []string) int {
	mut total := 0
	for line in lines {
		total += line.len
	}
	return total
}

fn get_encoded_line(line string) int {
	mut total := 2
	mut i := 0
	for i < line.len {
		match line.runes()[i] {
			`"` {
				total += 2
			}
			`\\` {
				total += 2
			}
			else {
				total++
			}
		}

		i++
	}

	return total
}
