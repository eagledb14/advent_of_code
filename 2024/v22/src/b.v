module b

import arrays
import math

pub fn run(input []u64) {
	mut sequence := map[string]i64{}

	for code in input {
		seq := get_sequence(code)

		for key, value in seq {
			sequence[key] += value
		}
	}

	mut max := i64(0)

	for _, value in sequence {
		max = math.max(value, max)
	}
	println(max)
}

fn get_sequence(secret u64) map[string]i64 {
	mut new_secret := secret
	mut seq := map[string]i64{}
	mut sequence := []u64{}

	for _ in 0..2000 {
		sequence << new_secret % 10
		new_secret = next(new_secret)
	}

	mut diff_sequence := []i64{}

	for i in 1..sequence.len {
		diff_sequence << sequence[i] - sequence[i - 1]
	}

	window := arrays.window(diff_sequence, size: 4)

	for i in 0..window.len {
		if window[i].str() !in seq {
			seq[window[i].str()] = sequence[i + 4]
		}
	}

	return seq
}


fn next(start_secret_number u64) u64 {
	mut current_secret := start_secret_number

	value_to_mix1 := current_secret * 64
	current_secret = mix( current_secret, value_to_mix1)
	current_secret = prune( current_secret)

	value_to_mix2 := current_secret / 32
	current_secret = mix( current_secret, value_to_mix2)
	current_secret = prune( current_secret)

	value_to_mix3 := current_secret * 2048
	current_secret = mix( current_secret, value_to_mix3)
	current_secret = prune( current_secret)

	return current_secret
}

fn mix(secret_number u64, value u64) u64 {
	return secret_number ^ value
}

fn prune(secret_number u64) u64 {
	return secret_number % u64(16777216)
}
