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

  groupq := []map[rune]int{} 

  line := ""
  for scan.Scan() {
    input := strings.TrimSpace(scan.Text())

    if input == "" {
      groupq = append(groupq, sortQuestions(line))
      
      line = ""
    } else {
      line += input + " "
    }
  }

  sum := sumTrue(groupq)
  fmt.Println(sum)
}

func sumTrue(groupq []map[rune]int) int {
  sum := 0
  for _, m := range groupq {
    sum += len(m)
  }

  return sum
}


func sortQuestions(s string) map[rune]int {
  p := strings.Split(s, " ")
  p = p[:len(p) - 1]
  t := len(p)
  m := map[rune]int{}
  
  for _, val := range p {
    for _, char := range val {
      m[char]++
    }
  }

  for key, val := range m {
    if val != t {
      delete(m, key)
    }
  }

  return m
}
