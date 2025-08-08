module main

import os

fn main() {

	// lines := os.read_lines("test")!
	// for line in lines {
	// 	println("$line, ${is_valid(line)}")
	// }

	mut start := "hepxcrrq"
	for !is_valid(start) {
		start = increment(start)
	}

	println(start)
	start = increment(start)

	for !is_valid(start) {
		start = increment(start)
	}

	println(start)
}

fn is_valid(s string) bool {
	
	// contains increasing straight line
	// of 3 letters
	mut increasing := false
	for i in 0..s.len - 2 {
		if s[i + 1] == s[i] + 1 &&
			s[i + 2] == s[i] + 2 {
			increasing = true
			break
		}
	}

	if !increasing {
		return false
	}

	
	// does not contain i, o, or l
	if s.contains("i") || s.contains("o") ||
		s.contains("l") {
		return false
	}

	// non overlapping pairs
	mut overlap_count := 0
	mut s_cpy := s
	for s_cpy.len > 1 {
		if s_cpy[0] == s_cpy[1] {
			s_cpy = s_cpy[2..]
			overlap_count++
		} else {
			s_cpy = s_cpy[1..]
		}
	}

	return overlap_count > 1
}

fn increment(s string) string {
	mut bytes := s.reverse().bytes()

	for i, _ in bytes {
		bytes[i]++

		if bytes[i] % u8(123) != 0 {
			break
		} else {
			bytes[i] = 97
		}
	}

	return bytes.bytestr().reverse()
}
