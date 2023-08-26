package main

import (
  "fmt"
  "strings"
  "bufio"
  "os"
  "strconv"
)

type passport struct {
  byr int
  iyr int
  eyr int
  hgt string
  hcl string
  ecl string
  pid string
  cid string
}

func main() {
  file, _ := os.Open("input")

  scan := bufio.NewScanner(file)
  passports := make([]passport, 0)

  line := ""
  for scan.Scan() {
    input := scan.Text()

    if input == "" {
      passports = append(passports, createPassport(line))
      line = ""
    } else {
      line += input + " "
    }
  }
  // fmt.Println(passports)
  totalValid := 0
  for _, val := range passports {
    if validatePort(val) {
      totalValid++
    }
  }

  fmt.Println(totalValid)
}

func createPassport(s string) passport {
  paramList := strings.Split(strings.TrimSpace(s), " ")
  newPort := passport{}

  for _, val := range paramList {
    splitParam := strings.Split(val, ":")
    if len(splitParam) != 2 {
      continue
    }

    paramName := splitParam[0]
    paramVal := splitParam[1]

    
    switch paramName {
      case "byr":
        date, _ := strconv.Atoi(paramVal)
        if date >= 1920 && date <= 2002 {
          newPort.byr = date
        }
      case "iyr":
        date, _ := strconv.Atoi(paramVal)
        if date >= 2010 && date <= 2020 {
          newPort.iyr = date
        }
      case "eyr":
        date, _ := strconv.Atoi(paramVal)
        if date >= 2020 && date <= 2030 {
          newPort.eyr = date
        }
      case "hgt":
        height, _ := strconv.Atoi(paramVal[:len(paramVal) - 2])
        metric := paramVal[len(paramVal) - 2:]
        // fmt.Println(paramVal, height, metric)
        if metric == "cm" {
          if height >= 150 && height <= 193 {
            newPort.hgt = paramVal
          }
        } else if metric == "in" {
          if height >= 59 && height <= 76 {
            newPort.hgt = paramVal
          }
        }

      case "hcl": 
        if paramVal[0] == '#' && len(paramVal) == 7 {
          newPort.hcl = paramVal
        }
      case "ecl":
        switch paramVal {
          case "amb":
            fallthrough
          case "blu": 
            fallthrough
          case "brn":
            fallthrough
          case "gry":
            fallthrough
          case "grn": 
            fallthrough
          case "hzl": 
            fallthrough
          case "oth":
            newPort.ecl = paramVal
        }
      case "pid":
          _, err := strconv.Atoi(paramVal)
        if len(paramVal) == 9 && err == nil {
          newPort.pid = paramVal
        }
      case "cid":
        newPort.cid = paramVal
      default:
        continue
    }
  }

  return newPort
}

func validatePort(p passport) bool {
  if p.byr != 0 && 
    p.iyr != 0 && 
    p.eyr != 0  &&
    p.hgt != "" &&
    p.hcl != "" &&
    p.ecl != "" &&
    p.pid != "" {
    return true
  } else {
    return false
  }
}



