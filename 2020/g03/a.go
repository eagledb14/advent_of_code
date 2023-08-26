package main

import (
  "fmt"
  "bufio"
  "os"
)

func main() {
  file, _ := os.Open("input")
  defer file.Close()

  scanner := bufio.NewScanner(file)
  field := make([][]rune, 0)

  for scanner.Scan() {
    field = append(field, []rune(scanner.Text()))
  }

  fmt.Println(iterate(3, 1, field))
  // fmt.Println(field)
}


//46 = .
//35 = #

func iterate(roff int, doff int, field [][]rune) int {
  treesHit := 0
  width := len(field[0])
  height := len(field)

  j := roff;
  for i := doff; i < height; i += doff {
    if field[i][j] == 35 {
      treesHit++;
    }

    j = (j + roff) % width;
  }

  return treesHit
}



