import java.io.File

class Node(
    val pos: Pair<Int, Int>,
    val left: Pair<Int, Int>,
    val right: Pair<Int, Int>,
    val start: Boolean,
    val name: Char
) {
    constructor() : this(Pair(0, 0), Pair(0, 0), Pair(0, 0), false, 'E')

    override fun toString(): String {
        return name.toString()
    }
}

//| is a vertical pipe connecting north and south.
// - is a horizontal pipe connecting east and west.
// L is a 90-degree bend connecting north and east.
// J is a 90-degree bend connecting north and west.
// 7 is a 90-degree bend connecting south and west.
// F is a 90-degree bend connecting south and east.
// . is ground; there is no pipe in this tile.
// S is the starting position of the animal; there is a pipe on this 

fun createNodes(board: List<List<Char>>): Pair<Node, Map<Pair<Int, Int>, Node>> {
    val nodes = mutableMapOf<Pair<Int, Int>, Node>()
    var start = Node()

    for (y in board.indices) {
        for (x in 0..board[y].size - 1) {
            val value = board.get(y).get(x)
            if (value == 'S') {
                val node = createStart(Pair(y, x), board)
                start = node
                nodes[node.pos] = node
            } else {
                val node = getNode(board, Pair(y, x), false)
                nodes[node.pos] = node
            }
        }
    }

    return Pair(start, nodes)
}

fun getNode(board: List<List<Char>>, pos: Pair<Int, Int>, start: Boolean): Node {
    val value = board.get(pos.first).get(pos.second)
    when(value) {
        '|' ->  {
            val left = Pair(pos.first - 1, pos.second)
            val right = Pair(pos.first + 1, pos.second)
            return Node(pos, left, right, start, '|')
        }
        '-' -> {
            val left = Pair(pos.first, pos.second - 1)
            val right = Pair(pos.first, pos.second + 1)
            return Node(pos, left, right, start, '-')
        }
        'L' -> {
            val left = Pair(pos.first - 1, pos.second)
            val right = Pair(pos.first, pos.second + 1)
            return Node(pos, left, right, start, 'L')
        }
        'J' -> {
            val left = Pair(pos.first - 1, pos.second)
            val right = Pair(pos.first, pos.second - 1)
            return Node(pos, left, right, start, 'J')
        }
        '7' -> {
            val left = Pair(pos.first + 1, pos.second)
            val right = Pair(pos.first, pos.second - 1)
            return Node(pos, left, right, start, '7')
        }
        'F' -> {
            val left = Pair(pos.first + 1, pos.second)
            val right = Pair(pos.first, pos.second + 1)
            return Node(pos, left, right, start, 'F')
        }
        else -> return Node()
    }
}

val upPipes = listOf('|', '7', 'F')
val downPipes = listOf('|', 'L', 'J')
val leftPipes = listOf('-', 'J', '7')
val rightPipes = listOf('-', 'F', 'L')

fun createStart(pos: Pair<Int, Int>, board: List<List<Char>>): Node {
    val neighbors = ArrayList<Pair<Int, Int>>()

    //upPipes
    var dir = Pair(-1, 0)
    var value = board.getOrNull(pos.first + dir.first)?.getOrNull(pos.second + dir.second)
    if (value in upPipes) {
        neighbors.add(Pair(pos.first - 1, pos.second))
    }

    //downPipes
    dir = Pair(1, 0)
    value = board.getOrNull(pos.first + dir.first)?.getOrNull(pos.second + dir.second)
    if (value in downPipes) {
        neighbors.add(Pair(pos.first + 1, pos.second))
    }

    //leftPipes
    dir = Pair(0, 1)
    value = board.getOrNull(pos.first + dir.first)?.getOrNull(pos.second + dir.second)
    if (value in leftPipes) {
        neighbors.add(Pair(pos.first, pos.second + 1))
    }

    //rightPipes
    dir = Pair(0, -1)
    value = board.getOrNull(pos.first + dir.first)?.getOrNull(pos.second + dir.second)
    if (value in rightPipes) {
        neighbors.add(Pair(pos.first, pos.second - 1))
    }

    return Node(pos, neighbors[0], neighbors[1], true, 'S')
}

fun main() {
    val file = File("test")
    val board = createBoard(file)
    val (start, nodes) = createNodes(board)

    val loop = traverseNodes(start, nodes)
    var xLoop = createLoopBoard(loop, board)
    println(xLoop)
    // println(loop[loop.size / 2])
    // println(loop.size / 2)
    // println(loop.size)
}

fun createBoard(file: File): List<List<Char>> {
    val board = mutableListOf<MutableList<Char>>()
    for (line in file.readLines()) {
        board.add(line.toCharArray().toMutableList())
    }
    return board
}

fun createLoopBoard(loop: List<Pair<Int, Int>>, board: List<List<Char>>): List<List<Char>> {
    val loopBoard = board.map { it.toMutableList() }.toMutableList()
    for (node in loop) {
        loopBoard[node.first][node.second] = 'X'
    }
    return loopBoard
}

fun traverseNodes(start: Node, nodes: Map<Pair<Int, Int>, Node>): List<Pair<Int, Int>> {
    var node = nodes[start.right]!!
    var parent = start
    val loop = mutableListOf<Pair<Int, Int>>()
    loop.add(start.pos)

    while (!node.start) {
        if (parent.pos == node.left) {
            loop.add(node.pos)
            parent = node
            node = nodes[node.right]!!
        } else if (parent.pos == node.right) {
            loop.add(node.pos)
            parent = node
            node = nodes[node.left]!!
        }
    }

    return loop
}

