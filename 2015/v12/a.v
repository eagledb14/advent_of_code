module main;

import os
import regex
import strconv


fn main() {
	lines := os.read_lines("input")!
	int_reg := r"-{0,1}\d+"
	mut re := regex.regex_opt(int_reg)!

	mut all := 0

	for _, line in lines {
		matches := re.find_all_str(line)
		
		mut total := 0
		for _, val in matches {
			total += strconv.atoi(val) or {continue}
		}

		all += total
	}

	println(all)
}

