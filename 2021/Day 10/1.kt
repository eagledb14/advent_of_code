import java.io.File;
import java.util.Scanner;
import kotlin.math.*;

fun main(args: Array<String>) {
    val file = File(args[0]);
    val scan = Scanner(file);

    var totalList = ArrayList<Long>();

    while(scan.hasNextLine()) {

        try {
            val c = checkLine(scan.nextLine());
            totalList.add(compScore(c));

        }
        catch(e: Exception) {

        }

    
        // when(c) {
        //     ' ' -> {

        //     }
        //     ')' -> {
        //         value += 3
        //     }
        //     ']' -> {
        //         value += 57
        //     }
        //     '}' -> {
        //         value += 1197
        //     }
        //     '>' -> {
        //         value += 25137
        //     }
        //     else -> {
        //         println(c);
        //     }
        // }
    }

    totalList.sort();
    // println(totalList);
    println(totalList[totalList.size / 2]);

    // println(value);
}

fun checkLine(line: String): ArrayDeque<Char> {
    var stack = ArrayDeque<Char>();

    for (c: Char in line) {
        when(c) {
            '(' -> stack.addLast(c);
            '[' -> stack.addLast(c);
            '{' -> stack.addLast(c);
            '<' -> stack.addLast(c);

            ')' -> {
                if (stack.last() == '(') {
                    stack.removeLast();
                }
                else {
                    throw Exception("c");
                }
            }
            ']' -> {
                if (stack.last() == '[') {
                    stack.removeLast();
                }
                else {
                    throw Exception("c");
                }
            }
            '}' -> {
                if (stack.last() == '{') {
                    stack.removeLast();
                }
                else {
                    throw Exception("c");
                }
            }
            '>' -> {
                if (stack.last() == '<') {
                    stack.removeLast();
                }
                else {
                    throw Exception("c");
                }
            }
        }
    }
    return stack;
}

fun compScore(data: ArrayDeque<Char>): Long {
    var total: Long = 0;

    for (c: Char in data.reversed()) {
        total *= 5;
        when(c) {
            '(' -> {
                total += 1;
            }
            '[' -> {
                total += 2;
            }
            '{' -> {
                total += 3;
            }
            '<' -> {
                total += 4;
            }
        }
        // println(total);
    }
    // print(data.reversed() + " ");
    // println(total);
    return total;
}