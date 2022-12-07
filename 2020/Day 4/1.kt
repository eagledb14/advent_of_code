import java.io.File;
import java.util.Scanner;

fun main(args: Array<String>) {
    val file = File(args[0]);
    val scan = Scanner(file);

    var outString = "";
    var data = ArrayList<String>();

    // print(scan.toString());
    while(scan.hasNextLine()) {
        val word = scan.nextLine();

        if (!word.isEmpty()) {
            // out.add(word);
            outString += (" " + word);
        }
        else {
            // println(outString);
            // var out = Regex(" ").split(outString);
            data.add(outString);
            // println(outString);
            outString = "";
        }

    }

    data.add(outString);
    // println(data.size);
    // println(data.toString())
    println(eval(data));
}


fun eval(data: List<String>): Int {
    var valid = 0;

    for (s: String in data) {
        val findBYR: MatchResult? = Regex("byr").find(s);
        val findIRY: MatchResult? = Regex("iyr").find(s);
        val findEYR: MatchResult? = Regex("eyr").find(s);
        val findHGT: MatchResult? = Regex("hgt").find(s);
        val findHCL: MatchResult? = Regex("hcl").find(s);
        val findECL: MatchResult? = Regex("ecl").find(s);
        val findPID: MatchResult? = Regex("pid").find(s);

        if (findBYR != null &&
            findIRY != null &&
            findEYR != null &&
            findHGT != null &&
            findHCL != null &&
            findECL != null &&
            findPID != null &&
            checkValid(s)) {
                valid++;
            }
    }
    
    return valid;
}

fun checkValid(input: String): Boolean {
    val scan = Scanner(input);

    while(scan.hasNext()) {
        val thing = scan.next();

        val params: List<String> = Regex(":").split(thing);


        when (params[0]) {
            "byr" -> {
                if (params[1].length != 4 || Integer.parseInt(params[1]) !in 1920..2002) {
                    return false;
                }
            }
            "iyr" -> {
                if (params[1].length != 4 || Integer.parseInt(params[1]) !in 2010..2020) {
                    return false;
                }
            }
            "eyr" -> {
                if (params[1].length != 4 || Integer.parseInt(params[1]) !in 2020..2030) {
                    return false;
                }
            }
            "hgt" -> {
                if (Regex("cm").find(params[1]) != null) {
                    val heightNum = Regex("(\\d+)").find(params[1]); 
                    return evalHeight(Integer.parseInt(heightNum!!.value), "cm");
                }
                else if (Regex("in").find(params[1]) != null) {
                    val heightNum = Regex("(\\d+)").find(params[1]); 
                    return evalHeight(Integer.parseInt(heightNum!!.value), "in");
                }
            }
            "hcl" -> { //this probably doesn't work, lol
                if (params[1][0] != '#' || Regex("(#\\d*|[a-f])").matches(params[1])) {
                    return false;
                }
            }
            "ecl" -> {
                when(params[1]) {
                    "amb"-> return true;
                    "blu"-> return true;
                    "brn"-> return true;
                    "gry"-> return true;
                    "hzl"-> return true;
                    "oth" -> return true;
                    else -> return false;
                }
            }
            "pid" -> {
                return Regex("\\d{9}").matches(params[1]);
            }
            else -> return true;
        }
    }

    return true;
}


fun evalHeight(height: Int, type: String): Boolean {
    
    when(type) {
        "cm" -> {
            if (height in 150..193) {
                return true
            }
            return false;
        }
        "in" -> {
            if (height in 89..76) {
                return true;
            }
            return false;
        }
        else -> return false;
    }
}