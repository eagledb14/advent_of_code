module a

pub fn run(page_order map[int][]int, updates [][]int) {
	mut correct_count := 0

	outer: for update in updates {

		mut already_seen := []int{}

		for page in update {
			for after_page in page_order[page] {
				if after_page in already_seen {
					continue outer
				}
			}
			already_seen << page
		}

		correct_count += update[update.len / 2]
	}

	println(correct_count)

}
