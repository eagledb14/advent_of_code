module b

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
	return validate_decrease(num_arr) && validate_order(num_arr)
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

fn validate_order(num[]int) bool {
	num_str := num.map(it.str())

	mut repeats := []string{}
    mut current_group := num_str[0].str()

    for i in 1 .. num_str.len {
        if num_str[i] == num_str[i - 1] {
            current_group += num_str[i].str()
        } else {
            if current_group.len > 1 {
                repeats << current_group
            }
            current_group = num_str[i].str()
        }
    }

    if current_group.len > 1 {
        repeats << current_group
    }

	return repeats.any(it.len == 2)
}
