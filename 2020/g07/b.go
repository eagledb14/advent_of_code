package main

import (
  "fmt"
  "bufio"
  "os"
  "strings"
  "strconv"
)

type Bags struct {
  bag string
  num int
}

func main() {
  file, _ := os.Open("input")

  s := bufio.NewScanner(file)
  bm := make(map[string][]Bags)

  for s.Scan() {
    name, bags := parse(s.Text())
    bm[name] = bags
  }

  totalBags := countBags("shiny gold", bm)
  fmt.Println(totalBags)
}

func countBags(curBag string, bm map[string][]Bags) int {
  totalBags := 

  for _, c := range bm[curBag] {
    totalBags += c.num + c.num * countBags(c.bag, bm)
  }

  return totalBags
}

func parse(s string) (string, []Bags) {
  s = strings.Replace(s, "contain", ",", 1)
  s = s[:len(s) - 1]
  bags := strings.Split(s, ",")

  ls := strings.LastIndex(strings.TrimSpace(bags[0]), " ")
  bagName := strings.TrimSpace(bags[0][:ls])

  bags = bags[1:]
  bagList := make([]Bags, 0)

  for _, val := range bags {
    params := strings.SplitN(strings.TrimSpace(val), " ", 2)
    
    num, err := strconv.Atoi(params[0])
    if err != nil {
      break
    }
    li := strings.LastIndex(params[1], " ")
    name := strings.TrimSpace(params[1][:li])

    newBag := Bags{bag: name, num: num}
    bagList = append(bagList, newBag)
  }

  return bagName, bagList
}

