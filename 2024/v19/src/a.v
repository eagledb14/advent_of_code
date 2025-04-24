module a

pub fn run(patterns []string, towels []string) {
	mut num_possible := 0

	for towel in towels {
		res := possible(towel, patterns)
		println("$res, $towel")
 		if res {
			num_possible += 1
		}
	}
	println(num_possible)
}


fn possible(towel string, patterns []string) bool {
	if towel == "" {
		return true
	}

	for pattern in patterns {
		if towel.starts_with(pattern) {
			res := possible(towel[pattern.len..], patterns)

			if res {
				return true
			}
		}
	}

	return false
}

// fn possible(towel string, patterns []string) bool {
// 	mut start := 0
// 	mut end := 0
//
// 	for end <= towel.len {
// 		slice := towel[start..end]
//
// 		if slice in patterns {
// 			start = end
// 		} else if start != 0{
// 			start -= 1
// 		}
//
// 		end += 1
// 	}
//
// 	println("$start, $end")
// 	if end - start != 1 {
// 		return false
// 	}
//
// 	return true
// }
