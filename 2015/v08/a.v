module main;

import os;


fn main() {
	lines := os.read_lines("input")!
	unparsed := get_total_chars(lines)
	mut parsed := 0
	for line in lines {
		parsed += get_parsed_line(line)
	}

	println(unparsed - parsed)
}

fn get_total_chars(lines []string) int {
	mut total := 0
	for line in lines {
		total += line.len
	}
	return total
}


fn get_parsed_line(line string) int {
	mut total := 0
	mut i := 0
	for i < line.len {
		match line.runes()[i] {
			`"` {
				if i == 0 || i == line.len - 1 {
					i++
					continue
				}
			}
			`\\` {
				next_char := line.runes()[i+1]
				if next_char == `\\` || next_char == `"` {
					i += 2
					total++
					continue
				}

				if next_char == `x` {
					i += 4
					total++
					continue
				}
			}
			else {
				total++
			}
		}
		i++
	}
	
	return total
}
