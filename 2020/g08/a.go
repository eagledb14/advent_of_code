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
  runCount int
}

func main() {
  file, _ := os.Open("input")

  s := bufio.NewScanner(file)


  instruction := []Instruction{}

  for s.Scan() {
    instruction = append(instruction, parse(s.Text()))
  }
  
  fmt.Println(run(instruction))
}

func run(instruct []Instruction) int {
  accumulator := 0
  runCount := make([]int, len(instruct))

  i := 0
  for {
    if i >= len(instruct) || i < 0 {
      return accumulator
    }

    if runCount[i] > 0 {
      return accumulator
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
