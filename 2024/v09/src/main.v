module main

import os
import a
import b

fn main() {
	mut input := os.read_file("test")!.split("\n")[0].split("").map(it.i64())
	a.run(input)
	b.run(input)
}
