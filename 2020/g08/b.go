package main

import (
  "fmt"
  "os"
  "bufio"
  "strconv"
)

type Instruction struct {
  name string
  offset int
}

func main() {
  file, _ := os.Open("input")

  s := bufio.NewScanner(file)

  instruction := []Instruction{}

  for s.Scan() {
    instruction = append(instruction, parse(s.Text()))
  }
  
  fmt.Println(testChanges(instruction))
}

func testChanges(instruct []Instruction) int {
  for i, val := range instruct {
    fmt.Println(i, val)
    if val.name == "nop" {
      clone := append([]Instruction(nil), instruct...)
      clone[i].name = "jmp"

      acc, ran := run(clone)

      if ran {
        return acc
      }
    } else if val.name == "jmp" {
      clone := append([]Instruction(nil), instruct...)
      clone[i].name = "nop"

      acc, ran := run(clone)

      if ran {
        return acc
      }

    }
  }

  return -17
}

func run(instruct []Instruction) (int, bool) {
  accumulator := 0
  runCount := make([]int, len(instruct))

  i := 0
  for {
    if i >= len(instruct) || i < 0 {
      return accumulator, true
    }

    if runCount[i] > 0 {
      return accumulator, false
    }

    switch instruct[i].name {
      case "acc":
        runCount[i]++
        accumulator += instruct[i].offset
      case "jmp":
        runCount[i]++
        i += instruct[i].offset
        continue
      case "nop":
        runCount[i]++
    }

    i++
  }
}

func parse(s string) Instruction {
  name := string(s[0:3])
  offset, _ := strconv.Atoi(s[4:])

  return Instruction{
    name: name,
    offset: offset,
  }
}
