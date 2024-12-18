module b

pub fn run(page_order map[int][]int, updates [][]int) {
	mut incorrect_updates := [][]int{}

	outer: for update in updates {

		mut already_seen := []int{}

		for page in update {
			for after_page in page_order[page] {
				if after_page in already_seen {
					incorrect_updates << update
					continue outer
				}
			}
			already_seen << page
		}
	}

	mut corrected_count := 0

	for mut update in incorrect_updates {
		update.sort_with_compare(fn [page_order] (one &int, two &int) int {
			if *one in page_order[*two] {
				return 1
			} else if *two in page_order[*one] {
				return -1
			} else {
				return 0
			}
		})
		// println(update)
		corrected_count += update[update.len / 2]
	}

	// println(incorrect_updates)
	println(corrected_count)
}
