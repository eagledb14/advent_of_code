import java.io.File;
import java.util.Scanner;


fun main(args: Array<String>) {
    val file = File(args[0]);
    val scan = Scanner(file);

    var data = HashMap<Pair<Int, Int>, Char>();

    var row = 0;
    var col = 0;
    while (scan.hasNext()) {
        val line = scan.next();

        col = 0;
        for (i: Char in line) {

            if (i == '#') {
                val coords = Pair<Int, Int>(row, col);
                data.put(coords, '#');
            }
            col++;
        }
        row++;
    }
    // println("$col, $row");
    // print(data);
    var out: Long;

    out = find(data, col, row, 1, 1);
    out *= find(data, col, row, 1, 3);
    out *= find(data, col, row, 1, 5);
    out *= find(data, col, row, 1, 7);
    out *= find(data, col, row, 2, 1);
    println(out);
}

fun find(data: HashMap<Pair<Int, Int>, Char>, colSize: Int, rowSize: Int, rowStep: Int, colStep: Int): Long {
    var treeHit: Long = 0;

    var col = 0;
    var newRow = 0;
    for (row: Int in 0..rowSize step rowStep) {
        if (data.containsKey(Pair<Int, Int>(row, col))) {
            treeHit++;
        }

        if (colSize - col > colStep) {
            col += colStep;
        }
        else {
            val value = colSize - col;
            col = colStep - value;
        }
        newRow = row;
    }

    // println("$col, $newRow");
    // println(treeHit);
    return treeHit;
}