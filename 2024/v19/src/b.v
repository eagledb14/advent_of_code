module b

pub fn run(patterns []string, towels []string) {
	mut num_possible := u64(0)
	mut memo := map[string]u64{}

	for towel in towels {
		res := possible(towel, patterns, mut memo)
		num_possible += res
	}
	println(num_possible)
}


fn possible(towel string, patterns []string, mut memo map[string]u64) u64 {
	mut count := u64(0)

	if towel in memo {
		return memo[towel]
	}

	if towel == "" {
		return u64(1)
	}

	for pattern in patterns {
		if towel.starts_with(pattern) {
			count += possible(towel[pattern.len..], patterns, mut memo)
		}
	}

	memo[towel] = count

	return count
}
