module main;

import os
import crypto.md5

fn main() {

	key := "iwrupvqb"
	// key := "pqrstuv"
	// key := "abcdef"

	mut i := 0
	for {
		hash := md5.hexhash(key + i.str())

		if hash.starts_with('000000') {
			println(i)
			break
		}
		i++
	}
}
