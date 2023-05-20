const std = @import("std");
const os = std.os;
const print = std.debug.print;

const pa = std.heap.page_allocator;
pub fn main() !void {
    const fd = try os.open("input", 0, 0);

    var read_buf = try pa.alloc(u8, 2000);
    defer pa.free(read_buf);

    _ = try os.read(fd, read_buf);

    var read_iter = std.mem.tokenize(u8, read_buf, ",|\n");

    var nums = std.ArrayList(i32).init(pa);
    defer nums.deinit();

    while (read_iter.next()) |val| {
        const x = std.fmt.parseInt(i32, val, 10) catch continue;
        try nums.append(x);
    }

    // print("{any}\n", .{nums.items});
    // for (nums.items) |val| {
    //     print("{}\n", .{val});
    // }

    nums.items[1] = 12;
    nums.items[2] = 2;

    var i: usize = 0;

    while (i < nums.items.len) : (i += 4) {
        //while ((nums.items.len - i) > 4) : (i += 4) {
        //while (i < nums.items.len) : (i += 4) {
        var a = @intCast(usize, nums.items[i + 1]);
        var b = @intCast(usize, nums.items[i + 2]);
        var place = @intCast(usize, nums.items[i + 3]);
        // print("{} {} {} {}\n", .{ nums.items[i], a, b, place });

        switch (nums.items[i]) {
            1 => {
                nums.items[place] = nums.items[a] + nums.items[b];
            },
            2 => {
                nums.items[place] = nums.items[a] * nums.items[b];
            },
            99 => {
                // print("{} {}\n", .{ i, nums.items[i] });
                break;
            },
            else => break,
        }
    }

    // for (nums.items) |val| {
    //     print("{}\n", .{val});
    // }
    print("{}\n", .{nums.items[0]});
}
