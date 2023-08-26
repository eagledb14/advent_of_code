package main

import (
  "fmt"
  "strings"
  "bufio"
  "os"
)

type passport struct {
  byr string
  iyr string
  eyr string
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
        newPort.byr = paramVal
      case "iyr":
        newPort.iyr = paramVal
      case "eyr":
        newPort.eyr = paramVal
      case "hgt":
        newPort.hgt = paramVal
      case "hcl": 
        newPort.hcl = paramVal
      case "ecl":
        newPort.ecl = paramVal
      case "pid":
        newPort.pid = paramVal
      case "cid":
        newPort.cid = paramVal
      default:
        continue
    }
  }

  return newPort
}

func validatePort(p passport) bool {
  if p.byr != "" && 
    p.iyr != "" && 
    p.eyr != ""  &&
    p.hgt != "" &&
    p.hcl != "" &&
    p.ecl != "" &&
    p.pid != "" {
    return true
  } else {
    return false
  }
}



