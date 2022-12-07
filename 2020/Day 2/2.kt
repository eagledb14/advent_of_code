import java.io.File;
import java.util.Scanner;

fun main(args: Array<String>) {
    assert(args.size > 0);
    val file = File(args[0]);
    val scan = Scanner(file);

    var data = ArrayList<Thing>();

    while(scan.hasNext()) {
        // populate(scan.next());
        data.add(populate(scan.nextLine()));
    }
    // println(data);
    calc(data);

}

fun calc(data: ArrayList<Thing>) {
    var validPassCount = 0;

    data.forEach {

        if (it.password[it.range[0] - 1] == it.letter && it.password[it.range[1] - 1] != it.letter) {
            validPassCount++
        }
        else if (it.password[it.range[1] - 1] == it.letter && it.password[it.range[0] - 1] != it.letter) {
            validPassCount++
        }
    }

    println(validPassCount);
}

fun populate(line: String): Thing{
    val pattern = Regex(" ");

    val splitLine = pattern.split(line);
    val splitRange = Regex("-").split(splitLine[0]);
    
    return Thing(Integer.parseInt(splitRange[0]), Integer.parseInt(splitRange[1]), splitLine[1][0], splitLine[2]);
}

class Thing {
    val range = IntArray(2);
    val letter: Char;
    val password: String;

    constructor(int1: Int, int2: Int, letter: Char, password: String) {
        this.range[0] = int1;
        this.range[1] = int2;
        this.letter = letter;
        this.password = password;
    }

    override fun toString(): String {
        return "($letter, $password)";
    }
}