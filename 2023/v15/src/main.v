module main

import os

fn main() {
	f := os.read_file("input")!.replace("\n", "").split(",")
	mut b := new_box()

	ln := f.map(new_lens(it))
	for l in ln {

		if l.operation == "minus" {
			b.minus(l)
		} else {
			b.equal(l)
		}
	}

	println(b.sum())
}

type Box = [256]map[string]int

fn new_box() Box {
	mut b := Box{}

	for i in 0..256 {
		b[i] = map[string]int{}
	}
	return b
}

fn (mut b Box) equal(l Lens) {
	b[l.hash][l.label] = l.value
}

fn (mut b Box) minus(l Lens) {
	b[l.hash].delete(l.label)
}

fn (b Box) sum() int {
	mut sum := 0
	for i, v in b {
		mut j := 0
		for _, w in v {
			j++
			sum += ((i + 1) * j * w)
		}
	}

	return sum
}

@[heap]
struct Lens {
	label string
	value int
	operation string
	hash int
}

fn new_lens(tag string) Lens {
	operation := if tag.contains("-") {
		"minus"
	} else {
		"equal"
	}

	arr := if operation == "minus" {
		tag.split("-")
	} else {
		tag.split("=")
	}
	label := arr[0]

	hash := get_hash(label)

	return Lens{label: label, value: arr[1].int(), operation: operation, hash: hash}
}

fn get_hash(s string) int {
	mut curr := 0
	for r in s.runes() {
		ascii := r.bytes()
		curr += int(ascii[0])
		curr *= 17
		curr = curr % 256
	}
	return curr
}
