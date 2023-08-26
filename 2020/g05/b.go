package main

import (
  "fmt"
  "os"
  "bufio"
)

type Seat struct {
  row int
  col int
  id int
}

func main() {
  file, _ := os.Open("input")

  scan := bufio.NewScanner(file)
  scores := make(map[int]bool)

  for scan.Scan() {
    score := parsePass(scan.Text())
    scores[score] = true
  }

  viableSeats := checkSeats(scores)
  fmt.Println(viableSeats)
}

func checkSeats(scores map[int]bool) Seat {
  maxRow := 127
  maxCol := 7

  for i := 0; i <= maxRow; i++ {
    for j := 0; j <= maxCol; j++ {
      score := (i * 8) + j
      if score == 0 {
        continue
      }
      _, s := scores[score]
      _, fs := scores[score + 1]
      _, bs := scores[score - 1]

      if !s && fs && bs {
        return Seat{row: i, col: j, id: score}
      }
    }
  }

  return Seat{}
}

func parsePass(pass string) int {
  rowRange := []int{0,127}
  colRange := []int{0,7}
  row := 0
  col := 0

  //getting the rows
  for i := 0; i < 7; i++ {
    diff := (rowRange[1] - rowRange[0]) / 2
    remainder := (rowRange[1] - rowRange[0]) % 2

    if pass[i] == 'F' {
      rowRange[1] -= diff

      if remainder > 0 {
        rowRange[1] -= 1
      }
    } else if pass[i] == 'B' {
      rowRange[0] += diff
      if remainder > 0 {
        rowRange[0] += 1
      }
    }

    row = rowRange[0]
  }

  //getting columns
  for i := 7; i < len(pass); i++ {
    diff := (colRange[1] - colRange[0]) / 2
    remainder := (colRange[1] - colRange[0]) % 2

    if pass[i] == 'L' {
      colRange[1] -= diff
      if remainder > 0 {
        colRange[1] -= 1
      }
    } else if pass[i] == 'R' {
      colRange[0] += diff
      if remainder > 0 {
        colRange[0] += 1
      }
    }
  }
  col = colRange[0]

  return (row * 8) + col
}
