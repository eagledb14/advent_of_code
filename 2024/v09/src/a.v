module a

pub fn run(input []i64) {
	disk := create_disk(input)
	compressed_disk := compress_disk(disk)
	checksum := calc_checksum(compressed_disk)
	println(checksum)
}

fn create_disk(input []i64) []i64 {
	mut disk := []i64{}
	mut id := i64(0)

	mut do_block := true

	for i := 0; i < input.len; i++ {
		if do_block {
			// add block id
			disk << [id].repeat(input[i])
			id++
		} else {
			//add padding
			disk << [i64(-1)].repeat(input[i])
		}

		do_block = !do_block
	}
	return disk
}

fn compress_disk(disk []i64) []i64 {
	mut new_disk := disk.clone()
	mut left := i64(0)
	mut right := i64(disk.len - 1)

	for right > left {
		for new_disk[left] != -1 {
			left++
		}

		for new_disk[right] == -1 {
			right--
		}

		new_disk[left] = new_disk[right]
		new_disk[right] = -1
	}

	temp := new_disk[right]
	new_disk[right] = new_disk[left]
	new_disk[left] = temp

	return new_disk
}

fn calc_checksum(disk []i64) i64 {
	mut checksum := i64(0)

	for i, val in disk {
		if val != -1 {
			checksum += i64(i) * i64(val)
		}
	}

	return checksum
}
