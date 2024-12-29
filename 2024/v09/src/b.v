module b

pub fn run(input []i64) {
	disk := create_disk(input)
	println(disk)
	compressed_disk := compress_disk(disk)
	println("\n$compressed_disk")
	checksum := calc_checksum(compressed_disk)
	println(checksum)
}

fn create_disk(input []i64) [][]i64 {
	mut disk := [][]i64{}
	mut id := i64(0)

	mut do_block := true

	for i := 0; i < input.len; i++ {
		if do_block {
			// add block id
			disk << [id].repeat(input[i])
			id++
		} else {
			//add padding
			if input[i] != 0 {
				disk << [i64(-1)].repeat(input[i])
			}
		}

		do_block = !do_block
	}
	return disk
}

// there is an off by 1 error somewhere around here, idk where
fn compress_disk(disk [][]i64) []i64 {
	mut new_disk := disk.clone()
	mut moved := map[i64]bool{}

	mut i := new_disk.len - 1
	for i >= 0 {
		if new_disk[i].len == 0 || new_disk[i][0] == -1 || moved[new_disk[i][0]]{
			i--
			continue
		}
		println(new_disk[i][0])

		mut j := 0
		for j <= i {
			if new_disk[j].len == 0 || new_disk[j][0] != -1{
				j++
				continue
			}

			if new_disk[j].len >= new_disk[i].len {
				// get a temp variable because the array size changes on insert of disk at i
				// set the new_disk at i to blank
				// the free space shrinks to what is left of the blank spaces
				// insert the new_disk at i to before the blank block

				temp_block := new_disk[i].clone()
				new_disk[i] = [i64(-1)].repeat(new_disk[i].len)

				new_disk[j].drop(temp_block.len)
				new_disk.insert(j, temp_block)

				moved[temp_block[0]] = true
				break
			}
			j++
		}
		i--
	}

	println("\n$new_disk")
	println(moved)

	mut compressed_disk := []i64{}
	for val in new_disk {
		compressed_disk << val
	}

	return compressed_disk
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
