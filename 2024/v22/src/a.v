module a

pub fn run(input []u64) {
	mut new := map[u64]u64{}

	for secret in input {
		val := get_value(secret)
		new[secret] = val
	}


	mut sum := u64(0)
	for _, val in new {
		sum += val
	}
	println(sum)

}

fn get_value(secret u64) u64 {
	mut new_secret := secret

	for _ in 0..2000 {
		new_secret = next(new_secret)
	}
	return new_secret
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
