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

  // fmt.Println(countGold(lastBag, bm))
  totalGold := 0
  for key := range bm {
    if countGold(key, bm) {
      totalGold++
    }
  }
  fmt.Println(totalGold, len(bm))
}


func countGold(curBag string, bm map[string][]Bags) bool {

  children := bm[curBag]
  for _, c := range children {

    if c.bag == "shiny gold" || countGold(c.bag, bm){
      return true
    }

    // if countGold(c.bag, bm) {
    //   return true
    // }
  }

  return false
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

