module b

import math
import arrays

pub fn run(lines []string) {
	mut safe_count := 0

	for line in lines {
		reports := line.split(" ").map(it.int())

		for i, _ in reports {
			report_slice := arrays.append(reports[..i], reports[(i + 1)..])

			if check_safe(report_slice) {
				safe_count++
				break
			}
		}
	}
	println(safe_count)
}

fn check_safe(reports []int) bool {
	if is_ordered(reports) && step_size(3, reports) {
		return true
	}
	return false
}

fn is_ordered(reports []int) bool {
	mut increasing := true
	mut decreasing := true

	for i in 1 .. reports.len {
		if reports[i] > reports[i - 1] {
			decreasing = false
		} else if reports[i] < reports[i - 1] {
			increasing = false
		} else if reports[i] == reports[i -1] {
			return false
		}
	}

	return increasing || decreasing
}


fn step_size(size int, reports []int) bool {
	for i in 1.. reports.len {
		difference := reports[i] - reports[i - 1]
		abs_dif := math.abs(difference)
		if abs_dif > size || abs_dif < 1 {
			return false
		}
	}

	return true
}
