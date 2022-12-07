import java.io.File
import java.util.Scanner

fun main() {
    val input : String = "in.txt";
    val file = File(input);

    val scan = Scanner(file);

    var data = ArrayList<Int>();

    while (scan.hasNext()) {
        val int = Integer.parseInt(scan.next());
        data.add(int);
    }

    // println(data);
   
    println(find(data));

}


fun find(data : ArrayList<Int>): Int {
    var out = 0;

    for (i : Int in data) {
        for (j : Int in data) {
            for (l : Int in data) {
                if ((j + i + l) == 2020) {
                    out = j * i * l;
                    println("$i, $j, $l");
                    return out;
                }
            } 
        }
    }

    return out;
}