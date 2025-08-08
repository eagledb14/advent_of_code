module main;

import os
import json


fn main() {
	file := os.read_file("input")!
	data := json.decode(map[string]All, file)!
	println(data)
}


type All = int | string | map[string]All
