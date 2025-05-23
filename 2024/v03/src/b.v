module b

enum Param {
	mul
	paren_left
	paren_right
	comma
	trash
	do
	dont
}

type Number = int

type Tokens = Number | Param

pub fn run(input string) {
	input_arr := input.bytes()
	tokens := create_tokens(input_arr)

	answer := parse_grammer(tokens)
	println(answer)
}

fn create_tokens(input []u8) []Tokens {
	mut tokens := []Tokens{}
	mut i := 0

	for i < input.len {
		match input[i].ascii_str() {
			"(" {tokens << Param.paren_left}
			")" {tokens << Param.paren_right}
			"," {tokens << Param.comma}

			else {
				if input[i].is_digit() {
					mut out := ""
					for input[i].is_digit() && i < input.len {
						out += input[i].ascii_str()
						i++
					}
					tokens << Number(out.int())
					continue
				} else if input[i].is_letter() {
					mut out := ""
					mut j := i
					for (input[j].is_letter() || input[j].ascii_str() == "'") && j < input.len {
						out += input[j].ascii_str()
						j++
					}

					match out {
						"mul" {
							i = j
							tokens << Param.mul
							continue
						}
						"don't" {
							i = j
							tokens << Param.dont
							continue
						}
						"do" {
							i = j
							tokens << Param.do
							continue
						}
						else { tokens << Param.trash }
					}

				} else {
					tokens << Param.trash
				}
			}
		}

		i++
	}
	return tokens
}

fn parse_grammer(tokens []Tokens) int {
	mut out := 0
	mut do_eval := true

	mut i := 0
	for i < tokens.len {
		t := tokens[i]
		match t {
			Number {
				// println("number \n\t${tokens[i]}")
			}
			Param {
				// println("param \n\t${tokens[i] == a.Tokens(Param.comma)}")
				match t {
					.mul {
						if !do_eval {
							i++
							continue
						}
						if tokens[i..].len >= 6 {
							out += eval_mul(tokens[i..]) or {
								i++
								continue
							}
						}

					}
					.do {
						do_eval = true
					}
					.dont {
						do_eval = false
					}
					else {}
				}
			}
		}
		i++
	}

	return out
}

fn eval_mul(tokens []Tokens) ?int {
	if tokens[0] != Tokens(Param.mul) {return none}
	if tokens[1] != Tokens(Param.paren_left) { return none}
	if tokens[2].type_name() != "b.Number" {return none}
	if tokens[3] != Tokens(Param.comma) {return none}
	if tokens[4].type_name() != "b.Number" {return none}
	if tokens[5] != Tokens(Param.paren_right) {return none}

	return (tokens[2] as Number) * (tokens[4] as Number)
}
