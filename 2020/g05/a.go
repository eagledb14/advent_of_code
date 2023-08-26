package main


import (
  "fmt"
  "os"
  "bufio"
)


func main() {
  file, _ := os.Open("input")

  scan := bufio.NewScanner(file)
  maxScore := 0


  for scan.Scan() {
    // fmt.Println(scan.Text())
    score := parsePass(scan.Text())
    maxScore = max(maxScore, score)
  }

  fmt.Println(maxScore)
}


func parsePass(pass string) int {
  rowRange := []int{0,127}
  colRange := []int{0,7}
  row := 0
  col := 0


  // rows := 127
  // columns := 7

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

    // fmt.Println(string(pass[i]), diff, rowRange)
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
