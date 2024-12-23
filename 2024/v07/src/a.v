module a

pub fn run(input []string) {
	mut calibrations := []Calibration{}

	for line in input {
		parts := line.split(":")
		calibrations << Calibration{
			thing: parts[0].u64(),
			operand: parts[1].split(" ").filter(it != "").map(it.u64())
		}
	}

	mut out := u64(0)
	for c in calibrations {
		if eval_operators(c) {
			out += c.thing
		}
	}

	println(out)
}

fn eval_operators(input Calibration) bool {
	mut out := false

	if input.operand.len == 0 && input.thing == 0 {
		return true
	} else if input.operand.len == 0 {
		return false
	}

	//multiplication
	if input.thing % input.operand.last() == 0 {
		out = out || eval_operators(Calibration {
			thing: input.thing / input.operand.last()
			operand: input.operand[..input.operand.len - 1]
		})
	}

	// addition
	out = out || eval_operators(Calibration{
		thing: input.thing - input.operand.last()
		operand: input.operand[..input.operand.len - 1]
	})

	return out
}

pub struct Calibration {
pub:
	thing u64
	operand []u64
}
