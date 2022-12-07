import java.io.File;
import java.util.Scanner;


fun main(args: Array<String>) {
    val file = File("ex1.txt");
    val scan = Scanner(file);

    val data = ArrayList<ArrayList<Int>>();

    while(scan.hasNextLine()) {
        val line = scan.nextLine();

        val col = ArrayList<Int>();
        for (c: Char in line) {
            col.add(c.toString().toInt()); 
        }
        data.add(col);
    }

    // var flashCount = 0;
    // for (i in 0..99) {

    //     flashCount += computeFlash(data);
    // }
    val flashCount = computeFlash(data);
    

    // println(data);
    println(flashCount);
}


fun computeFlash(data: ArrayList<ArrayList<Int>>): Int {
    var flashCount = 0;

    for (h in 0..1) {

        val didFlash = HashSet<Pair<Int, Int>>();

        var wasFlash = false;

        do {
            wasFlash = false;
            for (i in data.indices) {
                for (j in data[i].indices) {
                    data[i][j] += 1;
//                    println("$i, $j");

                    if (data[i][j] >= 9 && !didFlash.contains(Pair(i,j))) {
                        wasFlash = true;
                        flashCount++;

                        data[i][j] = 0;
                        didFlash.add(Pair(i,j));


                        if (i > 0 && j > 0) data[i - 1][j - 1]++;
                        if (i > 0) data[i - 1][j]++;
                        if (i > 0 && j < data[i].size - 1) data[i - 1][j + 1]++;


                        if (j < data[i].size - 1) data[i][j + 1]++;

                        if (i < data.size - 1 && j < data[i].size - 1) data[i + 1][j + 1]++;
                        if (i < data.size - 1) data[i + 1][j]++;
                        if (i < data.size - 1 && j > 0) data[i + 1][j - 1]++;

                        if (j > 0) data[i][j - 1]++;
                    }
                }
            }
        } while (wasFlash)
        println(data);
        print("\n");
    }

    return flashCount;
}

