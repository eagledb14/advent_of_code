module a
import arrays

pub fn run(start int, end int) {
	mut count := 0
	for num in start..end + 1 {
		if validate(num, start, end) {
			count++
		}
	}
	println(count)
}

fn validate(num int, start int, end int) bool {
	num_arr := num.str().runes().map(it.str().int())
	// println("$num_arr, ${validate_decrease(num_arr)}")
	return validate_decrease(num_arr) && validate_double(num_arr)
}

fn validate_decrease(num []int) bool {
	mut prev_num := -1
	for val in num {
		if val < prev_num {
			return false
		}
		prev_num = val
	}
	return true
}

fn validate_double(num []int) bool {
	num_arr := arrays.window(num, size: 2)

	for val in num_arr {
		if val[0] == val[1] {
			return true
		}
	}

	return false
}
