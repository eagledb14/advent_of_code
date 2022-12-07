import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'pair.dart';


void main(List<String> args) {
  input(args[0]).then( (response) { 
    var matrix = parseMatrix(response);
    var smallNums = smallestNumbers(matrix);
    findBasins(smallNums, matrix);
    // calcTotal(smallNums);
  });
}

input(String fileName) async {
  RegExp reg = RegExp(r"\D| +");

  var file = new File(fileName);
  String? out;

  if (await file.exists()) {
    out = await file.readAsString();
  }
  else {
    print("File not Found");
  }
  
  return out?.split(reg);
}

parseMatrix(List<String> input) {
  List<List> matrix = [];

  for (var i = 0; i < input.length; i += 2) {
    var tempList = [];
    tempList.addAll(input[i].split(""));
    matrix.add(tempList);
  }
  // print(matrix);
  return matrix;
}


List<List<int>> smallestNumbers(List<List> matrix) {
  List<List<int>> smallNums = [];

  for (var i = 0; i < matrix.length; i++) {
    for (var j = 0; j < matrix[i].length; j++) {

      var topBool = true;
      var botBool = true;
      var leftBool = true;
      var rightBool = true;

      final center = int.parse(matrix[i][j]);
      
      if (i > 0) {
        topBool = (center < int.parse(matrix[i - 1][j]));
      }
      
      if (i < matrix.length - 1) {
        botBool = (center < int.parse(matrix[i  + 1][j]));
      }

      if (j > 0) {
        leftBool = (center < int.parse(matrix[i][j - 1]));
      }

      if (j < matrix[i].length - 1) {
        rightBool = (center < int.parse(matrix[i][j + 1]));
      }

      if (topBool && botBool && leftBool && rightBool) {
        List<int> pos = [i, j];
        smallNums.add(pos);
      }
       
    }
  }
  // print(smallNums);
  return smallNums;
}

void calcTotal(List<int> nums) {
  int total = 0;

  for (int i in nums) {
    total += (i + 1);
  }

  print(total);
}


findBasins(List<List<int>> numPos, List matrix) {
  var basinSizes = <int>{};

  for (var pos in numPos) {
    basinSizes.add(findBasinHelper(pos, matrix));
  }
  print(basinSizes);
}

int findBasinHelper(List<int> pos, var matrix) {
  // findBasinHelper(nums);
  int returnTotal = 0;
  int x = pos[0];
  int y = pos[1];

  // if (&& int.parse(matrix[x][y]) != 9) return returnTotal + 1;

  if (x > 0 && int.parse(matrix[x - 1][y]) != 9) {
    returnTotal = findBasinHelper([x-1, y], matrix);
  }

  if (x < matrix.length - 1 && int.parse(matrix[x + 1][y]) != 9) {
    returnTotal = findBasinHelper([x + 1, y], matrix);
  }

  if (y > 0 && int.parse(matrix[x][y - 1]) != 9) {
    returnTotal = findBasinHelper([x, y - 1], matrix);
  }

  if (y < matrix[0].length && int.parse(matrix[x + 1][y]) != 9) {
    returnTotal = findBasinHelper([x, y + 1], matrix);
  }

  return returnTotal + 1;
  // throw "one of the if statements if wrong";
}