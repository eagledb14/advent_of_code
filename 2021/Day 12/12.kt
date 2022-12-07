import java.io.File;
import java.util.Scanner;

fun main(args: Array<String>) {
    val file = File(args[0]);
    val scan = Scanner(file);

    val data: HashMap<String, HashSet<String>> = HashMap();
    
    while(scan.hasNextLine()) {
        val input = scan.nextLine();

        val pair = Regex("-").split(input);

        if (!data.containsKey(pair[0])) {
            val set = hashSetOf(pair[1]);
            data.put(pair[0], set);
        }
        else {
            data.get(pair[0])?.add(pair[1]);
        }

        if (!data.containsKey(pair[1])) {
            val set = hashSetOf(pair[0]);
            data.put(pair[1], set);
        }
        else {
            data.get(pair[1])?.add(pair[0]);
        }
    }

    println(data);
}