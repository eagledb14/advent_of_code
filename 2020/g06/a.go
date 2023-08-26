package main


import (
  "fmt"
  "os"
  "bufio"
  "strings"
)


func main() {
  file, _ := os.Open("input")

  scan := bufio.NewScanner(file)

  groupq := []map[rune]bool{} 

  line := ""
  for scan.Scan() {
    input := strings.TrimSpace(scan.Text())

    if input == "" {
      groupq = append(groupq, sortQuestions(line))
      
      line = ""
    } else {
      line += input
    }
  }

  sum := sumTrue(groupq)
  fmt.Println(sum)
}

func sumTrue(groupq []map[rune]bool) int {
  sum := 0
  for _, m := range groupq {
    sum += len(m)
  }

  return sum
}


func sortQuestions(s string) map[rune]bool {
  m := map[rune]bool{}

  for _, char := range s {
    m[char] = true
  }

  return m
}
